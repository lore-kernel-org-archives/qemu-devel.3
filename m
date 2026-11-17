Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026BF606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aYpwZp75
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTKwa-0008JE-KF; Tue, 17 Nov 2026 10:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTKw6-0008HA-Bj
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 10:17:46 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xTKw2-0005DA-MK
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 10:17:29 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677bc4704cbso4952166d50.0
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 07:17:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794928641; cv=none;
 d=google.com; s=arc-20260327;
 b=hLkTdfsHHhtHahA1XcWDPyvQGywMEVbGd8xvPUzE4FLc6m1b5hzkriBHJsoWQsfYYl
 2EMQpWZYJfNbEpwQXNTDapXnZszIu2SYJ/l3CdfIhML5NK+ykTEy6RvxtEFma234166p
 3RFmKf2db1o1RRe0XaavWAdytQaK3k69b4ADMtysP0OjjfVBg+RXXmaSYX1t02LQPouX
 Kf0UDsocb8X2GaUFpAghdxggAmPzWeZlHGDwsIWn3IxZvf/O3Q/9CXqfK1SPzkhUwUev
 06Nu9KJiHTi4qvtpWzix4zwuFzUeVh07sDUQENdWzJrAmZToVoSdbNLf/hEEIDQiEVav
 rsRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MBW5D4CjDDY+8kCrvGFQlhDf3e9qQhNlGIu++bbIG/Y=;
 fh=/JS77veIKt/S+fkZ8tgyRWLxJwtjCfHfDybhpv2ZsgI=;
 b=V3dT2rb7jsJT7zqj8e91bL2iwlup/hzJpryvZULoNK7pWSP5caL+jqLKdLG4eZVfWW
 CdKnEkKxWEQefFp05sfzn9il4b8x9n1Dh++e2UYxNVWLonu2Cys8MeeeHFduciGQ4f65
 FSlhoimshThRsr4myRGujrRP48mfT7mZzH3DAAk3T+RpnuutpKmO+kSTOvgoSOUJm6mS
 XGDBzywYnJzHVPGjnOpjuMcuZBoxV/pHGUpIaD1ZLezYtrce8QslW3Bs0HTiSXTqx77/
 oPdbZx2DPGMBc9m5nSHN7UyHAOiZgiHNvjz/SV18w9J50rhNkN+ZzTdrB0ag1LWquaxP
 0VlA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794928641; x=1795533441; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MBW5D4CjDDY+8kCrvGFQlhDf3e9qQhNlGIu++bbIG/Y=;
 b=aYpwZp75s9Ox1HRzVVcnFkT6VTMltmWZi8jcmN+kVGxM4nMMH2cTtRlVDO8B2v1lJC
 3sbAe1hWb4Xb520jvlU1j1+QDBxd8Mvx7q8IT5a33VgQfErfi4YjkeOZbzukA34pIuB6
 8qIVaEFTcmj4fCqVzTM0ZPzUV59U6kT+OfUnBfQhhyKqIpASodTzd4F7C4aPYuyz36kI
 5h135r/S4SF2ANKixH1advzdBGk7N4pEcl8nvIea/neh/UTC8YimgSG2ZEgyPgzptFyi
 97PADeE4QL0HOOwbXMKvBwLsM05WYJyVpHDu7uDgdTYrHB9XdLrd26wZo8OMoPHhluUJ
 T/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794928641; x=1795533441;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MBW5D4CjDDY+8kCrvGFQlhDf3e9qQhNlGIu++bbIG/Y=;
 b=jrsUpTiBUzuSgrmIt+gmBWq7qdQtuNKt1GpOnj2ZazusbJetM6800FyI0vvddujIbx
 JYqJNNnnTsoFfznkaRauS2pOFtvxPLl1Fq2K4O2yJMtgCpt69ZEzsqylw5nEgwfmW8xG
 L65MVSZswtQHCduBOJAVMAeZK/eW0wqVsJflJ0uq7z2QHR1fqVdrD1tDTFC0AmnwIjsN
 oPMFptFc4MXYeDD7zektjoeo2zlY4G9ohGNGhg3DrQfbwjQ2xasyJsZTJRGDEHmClTB7
 ptYE5faoY4xk0Rz+Th4r418jB0qISGlyxQvSzNlR3Kcii/sewyugtiY09JG+2yH5Ef0H
 vVLA==
X-Forwarded-Encrypted: i=1;
 AL+hErHfLGucYUZ39HZ7+9lyp8CJtL6R8MA8nywLdap4wYUUmrV27Bl1nsX+PbVcd6yzdSMmrmq5dzBx8HO8@nongnu.org
X-Gm-Message-State: APuU4Z/p5w0fAF1oiIzKCmUMmzj0c6KEJAJVA+xG3KWdI3rWjFKcBJQ4
 ofiz0Qpjn01r1gt9HCX7u82+Hqb+yBK9n2EReRUmGaLxBBzrumhA5lgH6QpT2lxjv1P3yPL47HR
 T5sOklIMmIpDEoH6nbpspfO6+mGDDLY/a+Tvgm9tFAA==
X-Gm-Gg: AZFdTZclWKmE+AeeKUOHnegAq/2EYkzU0Ynq3YnSiqam/BmumeHPcAq/9gINQLj0VS8
 Dd+FlxA7u2F7Iy0MCFgLm35krTdGQmvFWL7kE/a7wa4hxgzo711fPxlHyzsJo5uqXTIPt3XnxEs
 0NTWrdTPV6npYMeN+vRademzyD3g+vIIGtlEPMXP1rJL7fE3VEM1SMjbt8sNibWuGwpr13+9IuK
 aQHsfEHRYqUCe1D2XCpkht03hvrT9f2ywmHhabE76BGGMLz1STn5vkJhT+UqcT30a02gH7WYD4w
 4N8/cBxyJCFRL56Ts0SCLyOa3uQacSscFyatxKrCRlLQUkLeaVFdWMcYkBwSruWWMR9HJ6L5sU2
 5oAV+DVUbIDyYRbIu199GvDHj9+n4DBxTobaPyv2XSjySgB8Ma7x1x17pxcBbPDHSezMs7o6rDD
 wX0BjVZDNSZPTabTNhpF7g+Q==
X-Received: by 2002:a05:690e:168a:b0:67d:99fc:2e46 with SMTP id
 956f58d0204a3-67d99fc38d3mr5349841d50.36.1794928640508; Tue, 17 Nov 2026
 07:17:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
 <20261028052024.38377-7-harshpb@linux.ibm.com>
 <CAFEAcA-CML7CFxn7WC0d2uuE6cHJbM2-p2Lv-wcAXWU9kpsRWw@mail.gmail.com>
 <e2e9c608-f139-447f-887f-8fb4909470a3@linux.ibm.com>
In-Reply-To: <e2e9c608-f139-447f-887f-8fb4909470a3@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Nov 2026 15:17:08 +0000
X-Gm-Features: AclHuK_NQKiF6NWxXp721e8z9ZQRSir6_VSv0Rs7AA4KyTfpBUphoQMLgSOoPdM
Message-ID: <CAFEAcA8M6PhCQV6EtKSp9VtqroA2Ah82y1--q_8Argg686_YwA@mail.gmail.com>
Subject: Re: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to
 struct size
To: Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 Chinmay Rath <rathc@linux.ibm.com>,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>, 
 Gautam Menghani <gautam@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 10 Nov 2026 at 06:54, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
>
> + qemu-stable
>
> Hi Peter,
>
> On 05/11/26 8:57 pm, Peter Maydell wrote:
> > On Wed, 28 Oct 2026 at 05:21, Harsh Prateek Bora <harshpb@linux.ibm.com> wrote:
> >>
> >> From: Chinmay Rath <rathc@linux.ibm.com>
> >>
> >> vscsi_send_adapter_info() used the guest-supplied common.length
> >> field directly as the size argument to spapr_vio_dma_write().
> >> Since common.length is controlled by the guest, a value larger
> >> than sizeof(struct mad_adapter_info_data) (148 bytes) caused
> >> dma_memory_write() to read past the end of the stack-allocated info
> >> struct, leaking arbitrary host stack contents into guest memory.
> >>
> >> Fix this by clamping the write length to sizeof(info), then using
> >> spapr_vio_dma_set() to zero-fill any remaining bytes the guest
> >> requested beyond that size. This mirrors the existing pattern in
> >> vscsi_send_capabilities().
> >>
> >> Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
> >> Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
> >> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> >> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> >> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> >> Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
> >> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >
> > Shouldn't this be Cc: qemu-stable@nongnu.org ?
>
> Yes, should have been marked for stable. I have CCed it now though.>
> > Given that spapr-vscsi is supposed to be covered by the "virtualization
> > use case", have we deliberately decided we didn't want to give this
> > a CVE, or did that step in the process get missed ?
>
> I think it got missed, can we still request for a CVE to be assigned on
> the gitlab issue?

I asked Dan on IRC, and he said:

"depends how far in the past it is - if we've not released the fix
 in a major release, I'd jsut temporarily re-open the bug and add the
 CVE::Required tag, and close it again once assigned
 that way we at least get a record of the CVE in the issue tracker, even
 though its missnig from the merged commit message
 if it was already fixed in a previous major release, I'd just accept
 that we dropped the ball and move on without a CVE"

which sounds like a good idea to me.

Speaking of things that got missed, what about
https://lore.kernel.org/qemu-devel/20260819095855.115823-1-rathc@linux.ibm.com/
("hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()")
which is another one from Chinmay for this device that got posted
back in August and never applied ?

thanks
-- PMM

