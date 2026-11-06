Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4D606A33A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SZGtyDU3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPNp4-0005Ee-GW; Fri, 06 Nov 2026 12:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPNov-0005Dp-To
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:33:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xPNou-0004sj-3L
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 12:33:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793986423;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SgNWBh5whufnh1RfN6VWrph1TlYC50rhVdGcVg//7Zg=;
 b=SZGtyDU3ZqA2PMCr5h+mmiGsAeyNKNHM+JqMihg12+HlRxVo6ugHclXxmqeCqH+jQs/QVH
 PrLSCEGdXJ2VyOYC4cR7pHewyWQXOqpGrlPHRFehZ4beKk39uoiUZJMiLFMwHB93tGYUAK
 vdXuLZL5574N3ti+sjdSd1AAKuZgSaU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-VSfcwTERNjuWWPRpuDy8hQ-1; Fri,
 06 Nov 2026 12:33:40 -0500
X-MC-Unique: VSfcwTERNjuWWPRpuDy8hQ-1
X-Mimecast-MFC-AGG-ID: VSfcwTERNjuWWPRpuDy8hQ_1793986418
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECBA41956089; Fri,  6 Nov 2026 17:33:37 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0238195608B; Fri,  6 Nov 2026 17:33:34 +0000 (UTC)
Date: Fri, 6 Nov 2026 17:33:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 04/28] hw: mark all remaining virtio object types as
 secure
Message-ID: <au4Pa4GFA4u-XQ7J@redhat.com>
References: <20261029131241.2275706-1-berrange@redhat.com>
 <20261029131241.2275706-5-berrange@redhat.com>
 <fe7f7d29-8ca3-4ced-afcc-c768b84c4888@redhat.com>
 <CAMxuvazfhfGSZCiSi+viwJ7f7XDWAZfjmW39n3a7a-qQyw-YSA@mail.gmail.com>
 <au3mwO32b0-PSXKu@redhat.com>
 <CAMxuvayhYcOvH2QPptrKUQGFHoRxQcM1USF5OwuZYR_g2c4zgw@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayhYcOvH2QPptrKUQGFHoRxQcM1USF5OwuZYR_g2c4zgw@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 06:52:27PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Nov 6, 2026 at 6:40 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Fri, Nov 06, 2026 at 06:35:29PM +0400, Marc-André Lureau wrote:
> > > Hi
> > >
> > > On Fri, Nov 6, 2026 at 3:53 PM Thomas Huth <thuth@redhat.com> wrote:
> > > >
> > > > On 29/10/2026 14.12, Daniel P. Berrangé wrote:
> > > > > These are all intended for use in a virtualization scenario and must
> > > > > provide a security boundary.
> > > > >
> > > > > Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > ---
> > > > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > > >
> > >
> > > I have a second thought about this, I'd like to exclude all
> > > gpu-accelerated paths for now. virgl/mesa/rutabaga expose a very large
> > > attack surface, so I'd like to drop them from the secure boundary
> >
> > Rather than repost, please see my response for patch 2:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg01530.html
> >
> > TL;DR: we have already promised anything virtio related is in scope
> > for security handling for a long time, as they are all unambiguously
> > "virtualization use case".
> >
> 
> the value of a secure policy enforcement is low if we know those
> devices are unsecure and don't have the resources to make them secure.

It isn't a great situation to be in, but we're already there for any
virtio devices based on our existing policies for bug handling and
security triage. We can't promise we'll get fixes for all CVEs quickly,
but we will at least assign CVEs so that users are aware when there
are known problems.

This contrasts to other devices where problems will remain largely
hidden for view, as we treat them as normal bugs and never call our
security concerns when committing changes.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


