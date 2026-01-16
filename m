Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220A0D4A619
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 09:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vggPz-0001A2-LU; Fri, 16 Jan 2026 04:46:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggPx-00018K-N6
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vggPw-0007uH-0u
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 04:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768556815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sfDGErVxumvs4vxD3ArmlSXqVkPv7fP2hf/CI8LUNYk=;
 b=Mi7ilaahN1iScCg0M1etX/sLQncW8UFkJyiihZgRjgh5i4LPDVkegpi1Hq/1X6S03VgS/H
 MG7Yyj8+Bw4XgxFDcuoKmgV5E4lonzJNYvBnzF+KV+R+sXpJ75uV1hoebnm18bXRL5pmG+
 Hv69IiRCQj3I2pS0k7S0nhoen8+pe30=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-Rt3vOaFIMmCVyw7Bi1hklQ-1; Fri,
 16 Jan 2026 04:46:51 -0500
X-MC-Unique: Rt3vOaFIMmCVyw7Bi1hklQ-1
X-Mimecast-MFC-AGG-ID: Rt3vOaFIMmCVyw7Bi1hklQ_1768556810
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F19611956054; Fri, 16 Jan 2026 09:46:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2462E18004D8; Fri, 16 Jan 2026 09:46:45 +0000 (UTC)
Date: Fri, 16 Jan 2026 09:46:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Peter Xu <peterx@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWoJAz_GLXzqs_oH@redhat.com>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <aWlso1w39cQnEh2t@x1.local> <aWlxY9TWGT1aaMJz@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWlxY9TWGT1aaMJz@gallifrey>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Thu, Jan 15, 2026 at 10:59:47PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> > > Nack.
> > > 
> > > This code has users, as explained in my other email:
> > > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> > 
> > Please then rework that series and consider include the following (I
> > believe I pointed out a long time ago somewhere..):
> > 
> 
> > - Some form of justification of why multifd needs to be enabled for COLO.
> >   For example, in your cluster deployment, using multifd can improve XXX
> >   by YYY.  Please describe the use case and improvements.
> 
> That one is pretty easy; since COLO is regularly taking snapshots, the faster
> the snapshoting the less overhead there is.

Also if we ever want to be able to deprecate the non-multifd migration,
then we need to ensure multifd migration has the super-set of functionality.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


