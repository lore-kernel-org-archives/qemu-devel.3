Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CD606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A3tiNqmk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMUBe-0007NL-Sx; Thu, 29 Oct 2026 13:45:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMU9U-0004W5-G6
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:43:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMU9Q-0003RN-P5
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 13:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793295775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CeqxaDJAfhVAeXfJnL4fWFeqEC+RtNwm3uyWqu/tgkc=;
 b=A3tiNqmkwQ3MTXaszDuj3kX+EcUaND5104MV0FKf1jLSI6/k8s14gafNmX+7m1B/ortfvq
 A0ulVFERYTZrs92ZZ9Dzm9HLO+ee7rgxakXymApa2Yvm7CYOUuu/N+5ePu65ffR6tfvizQ
 UYsxHg4YAGeughdAOREIEpenGBA1u9E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-03pA8_F-OFmSR-SNpJKqdg-1; Thu,
 29 Oct 2026 13:42:51 -0400
X-MC-Unique: 03pA8_F-OFmSR-SNpJKqdg-1
X-Mimecast-MFC-AGG-ID: 03pA8_F-OFmSR-SNpJKqdg_1793295769
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB10918021CE; Thu, 29 Oct 2026 17:42:48 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9826A3000B4E; Thu, 29 Oct 2026 17:42:44 +0000 (UTC)
Date: Thu, 29 Oct 2026 17:42:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Hao Wu <wuhaotsh@google.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 7/8] tests/functional: remove @skipSlowTest from
 quanta_gsj test
Message-ID: <auOFkbm4VJblb4SY@redhat.com>
References: <20261029161310.2065290-1-alex.bennee@linaro.org>
 <20261029161310.2065290-8-alex.bennee@linaro.org>
 <CAFEAcA_UJ=QMFwdGtWv_wWhRyzoig0_0VC+T21+kFvzv9qasoA@mail.gmail.com>
 <1d76264a-040a-40f7-977f-948d4db6576a@redhat.com>
 <ae1dada6-057c-4614-bf59-ec60b1f89604@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae1dada6-057c-4614-bf59-ec60b1f89604@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 09:14:21AM -0800, Pierrick Bouvier wrote:
> On 10/29/2026 9:05 AM, Thomas Huth wrote:
> > On 29/10/2026 17.38, Peter Maydell wrote:
> >> On Thu, 29 Oct 2026 at 16:13, Alex Bennée <alex.bennee@linaro.org> wrote:
> >>>
> >>> The full quanta_gsj test would have caught the regression caused by
> >>> the WFxT implementation and isn't that slow (<60s) it needs to be
> >>> gated.
> >>>
> >>> Suggested-by: Thomas Huth <thuth@redhat.com>
> >>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >>> ---
> > ...
> >> The other argument against using quanta-gsj as our test here
> >> is that as discussed as part of a recent docs update:
> >> https://lore.kernel.org/qemu-devel/20260627063208.33642-1-
> >> bin.meng@processmission.com/
> >> it's no longer supported by OpenBMC.
> >>
> >> I didn't get any response from the Nuvoton maintainers in
> >> that thread, but I kind of favour deprecating the machine
> >> type in QEMU.
> > If nobody seems to care anymore, please go ahead and mark it as
> > deprecated! We can still revert it in case someone speaks up later
> > during the deprecation period.
> > 
> >  Thomas
> > 
> > 
> 
> For what it's worth, I also noticed that this test tends to timeout
> randomly, even when running tests with -j1. So we might observe this in
> our CI also, by enabling it by default.

If it is unreliable then it should be tagged with skipFlakyTest,
and a gitlab issue filed with an example failure trace.

If no one steps up to fix the flaky test in a reasonable time
then it should later be deleted, as flaky tests should not be
allowed to linger for years.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


