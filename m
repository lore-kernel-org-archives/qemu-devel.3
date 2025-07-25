Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76441C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 18:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufNT0-0004v7-1v; Fri, 25 Jul 2025 14:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufNSP-0003pA-Ng
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:47:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ufNSM-0004JL-KH
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 14:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753469265;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbpLiEB6XhaxfPCqU3EoBFV+m18pmD4Dnio2kwobPMg=;
 b=JbXmw3xQlmdFUy7dYtm5QQ1VuXmHxV63ybtjQLthcjatloA0gCYbJ9xO47DAlFw6OBQaHS
 DnpI9dsQS3NDtjdCcniXkVBr+kEjfTH2uTFQTc27r3F5vMLmzDKGqiRvEyr9jsBjhWPYLP
 DQkUcBs2RvnOPLnboFcQxolXrxQr/qw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-UdQf_EZYMcujjf9u2ocQ5A-1; Fri,
 25 Jul 2025 14:47:40 -0400
X-MC-Unique: UdQf_EZYMcujjf9u2ocQ5A-1
X-Mimecast-MFC-AGG-ID: UdQf_EZYMcujjf9u2ocQ5A_1753469258
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB9BD1955D90; Fri, 25 Jul 2025 18:47:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.162])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 310ED3000199; Fri, 25 Jul 2025 18:47:35 +0000 (UTC)
Date: Fri, 25 Jul 2025 19:47:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] hw/xen/xen_pt: fix missing include
Message-ID: <aIPRRJHJXfYk8zBW@redhat.com>
References: <20250725165749.3893240-1-pierrick.bouvier@linaro.org>
 <aIO9SHJkDPnrfAHf@redhat.com>
 <5577bfdd-2441-4b6f-a58a-29bc2a6850c7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5577bfdd-2441-4b6f-a58a-29bc2a6850c7@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.175,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 25, 2025 at 10:49:58AM -0700, Pierrick Bouvier wrote:
> On 7/25/25 10:22 AM, Daniel P. Berrangé wrote:
> > On Fri, Jul 25, 2025 at 09:57:49AM -0700, Pierrick Bouvier wrote:
> > > FAILED: libqemu-i386-softmmu.a.p/hw_xen_xen_pt.c.o
> > > ...
> > > /home/user/.work/qemu/hw/xen/xen_pt.c: In function ‘xen_pt_need_gsi’:
> > > /home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: implicit declaration of function ‘error_report’; did you mean ‘error_report_err’? [-Wimplicit-function-declaration]
> > >    783 |         error_report("Cannot open %s: %s", guest_type, strerror(errno));
> > >        |         ^~~~~~~~~~~~
> > >        |         error_report_err
> > > /home/user/.work/qemu/hw/xen/xen_pt.c:783:9: error: nested extern declaration of ‘error_report’ [-Werror=nested-externs]
> > > cc1: all warnings being treated as errors
> > > 
> > > Fixes: 012842c ("log: make '-msg timestamp=on' apply to all qemu_log usage")
> > 
> > The problem pre-dated this, so this should be
> > 
> >   Fixes: cfcacbab38e (xen/passthrough: use gsi to map pirq when dom0 is PVH)
> > 
> > See the prior posting of this fix last week:
> > 
> >    https://lists.nongnu.org/archive/html/qemu-devel/2025-07/msg04831.html
> > 
> 
> While true, this was not a problem as error-report.h was still implicitely
> included (as Markus pointed). We can debate where the regression comes from,
> but from git bisect point of view, this is the trace one, at least with the
> simple "./configure --enable-debug".

It was /only/ implicitly included if you had the 'log' trace backend
enabled - other configurations missed it, hence the build failures
we got in Fedora from commit cfcacbab38e.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


