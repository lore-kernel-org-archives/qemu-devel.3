Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B8860A2624
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=mEXs9hVt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiy1-0005pX-JG; Tue, 27 Oct 2026 11:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLixn-0005jg-C9
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:19:48 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLixl-0001iH-HK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 11:19:47 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c4322d310e7so633881366b.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 08:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793114384; cv=none;
 d=google.com; s=arc-20260327;
 b=YutRAZ5ZAERyM7I0iip5YfE+JRMjIcT5CW/nAx6wDQDRb9aKUuI2foXH7t4jaFVftU
 ItfkN6GiIX411u0S55qDWan03hA4aFyJ4F98ZklASvneQ4OcH2M02ge3gfmnuIIVZjYw
 aiAhAmyqocJhJyezOrv472ZvWBZtOWozj9104/OvRnEeN8mWO7aUaxpEPH2s1tGNtxnh
 1SnFfTnWKJnwDqNlrAPPiUgeVbpFfJMmofTBbjhvyb+51PP8mPWGr+vLCMDjgWWckfU8
 Tzf3mcP6cIl7fAcdoth4X6ODMVbSgIkOxQ25/LuBGj9rSx7WkONwsRzyPS4XKFPlwHIf
 76Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QNLGFEB0BNZwN2ea1M6YUWGW+5mREQVg1wxL9/Q473w=;
 fh=9vbVNIdRsO0paNhZWc2/4JcInsvPbgZ5nIOMIbgIuW4=;
 b=Cq+6PM+1Q/GSfJVphQu98UpOvFaIYFD5jVnxYy4HInLd3v9BvvnpX/Ekt737Q3zrFB
 LpEDLAVZfUPmhH5RQNg4F48nrK5DLxUDYYVyt8AeiPoCQZMM/+8bOpPNI545HJ3kzBQn
 m3YQhDTjfq/vIDYW25Cm2n8PRvLqsGuDXe+ZESsobC5RnAbJiIV6COU9AcJCQvDqKmFp
 nG+nhIfNhSJvY70c+qotmQfM8cDv6EmrTBWcBMu9PckVOtOaavPhIdcSo9oTYZ91zZ4l
 sCQCfSVagSbn1iLRCITuPthJJvkhUWUNr3rKjtDHfazcVszEncFTMGh8QtQ+uya5h1dF
 Yrsg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793114384; x=1793719184; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QNLGFEB0BNZwN2ea1M6YUWGW+5mREQVg1wxL9/Q473w=;
 b=mEXs9hVt3wAvpq+0JSKodFkqbzzirk6QnWiiMPHS7NqdFC8eeXX9FBsY0KYaJCaShZ
 6VWuuS3AV1JpTPV2G3Pge9jN2+pIBB4tuDm/lsw44VIrgxNTTmICQKhP9h4SXuJTplaD
 JwchCVO2LMcsHy/ZJ0khOPOrVCAx0KHNu/L/4T3PxkmiFLxDWqCVtrynh0i8FSIbnzOx
 rjkro7ppn89ErWZ0eKH9c88PTDCc1o4wqqFyHoal2fj7uAAvDrsgyv2BlVYCHp+7F9vg
 1pVocAgZOMecYs7KXNIpdIHmqyawZ3hFkFDzSch9qUDqRA2s1mkQkCcSLXK4rh7bRffm
 vkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114384; x=1793719184;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QNLGFEB0BNZwN2ea1M6YUWGW+5mREQVg1wxL9/Q473w=;
 b=o4Rtfn6wUhRR5Fpoe5mDwbCIWQu1HZNQYakGJvMumEdWuvGUg3fgWd1pgstJOxQdFA
 m4GKXZ+BmdhmZAdthxmNp3HzZrYZzhA4zPxRs7LZSAYmFFhxu37eURTn4qincjeye7mB
 4t6hflCpqOG5WYIfwf+tAGh+UJBZIwTvHpZgCNXscuitgnKpXWQXWA3sRToYowz69V7u
 VPuHyi6CjpkzvfF8aDADM5Tw88j7xRz5lQVpo/+LvHV0v3Bxc/hGXbReoexac0ZUvwlE
 /ydzxnXGMNjT0iMUPQtEoVWsJ2mgcYZvyZPG/WEFpA14zMtfb0xZ+JsXWheiXtglktLV
 mdIg==
X-Gm-Message-State: AFq9FYJCYP75h4XsFCOdA5KVOBggkl37f4fblYk77fevQ7QIsC0ZVBOJ
 1wNbXAiMJPAiitsmi9/q4u5h5WxEACGryBcJ4A1E2JWiZJ9bYIOamGjc1Q2vdwsx4qVkUMYL1dN
 i5aG3fMZMdTyhXWQ3OLo3XrDTfNqvaVwL2KAfZfF1aQ==
X-Gm-Gg: AYBFou1kpNIG3T5EIjDdQQ1mjZd6duJV0zShZUPmsyNAPifP4X0XVyEBjEsZOw2H+VB
 cbMQwX8O+rxc55/+9i18+HuUK+ng9BtjGipgafldaSI2VWv4inzxBsnZr3uIFH5TbyRovTZvpmS
 j0WbEVyYKTH1IqlLdZ4QrmX6CXwvRin0VLk2u6ihJ/gXgtrR3scxZCkuc8aNfkHSOrB2HFdsS4w
 uZ4k2d+LfhyKdnq7zazqsHy2akKGZCsxPoP8oHEgqOygGczh0MjfL1UQ2AzAaFuTTA8c4wmrffF
 RvVGDQ54LWyYGyHIMg19oc2jHO1wdY/an1GU2aVJ/UhINRbnaszZZe+dVmM1TEzdFug9rT9t09v
 SJ1bpyD7Dbz96fLKV9B6HU2NXRWEAyR5hysNSjLMV/ZznPFCo1YGhx2AU8T2AlCYub2RGjXVPGS
 t+OfrS7LhnmYlR9BFvRuka
X-Received: by 2002:a17:907:980b:b0:c40:b59:1b with SMTP id
 a640c23a62f3a-c46bdfed1b9mr1060139166b.44.1793114383584; Tue, 27 Oct 2026
 08:19:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
 <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
 <DB8PR04MB717745592F89F86226B7E73787612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_z5n9obipm=jOieJD0VoSJOTN1MVpRdtHgEDDfq5SfUg@mail.gmail.com>
 <DB8PR04MB717789469E7A52109B5AC9E787602@DB8PR04MB7177.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB717789469E7A52109B5AC9E787602@DB8PR04MB7177.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Oct 2026 15:19:29 +0000
X-Gm-Features: AclHuK_qiIKXlZTt8V2Y4LUFJ78tMktuGCd5Avf6Qc9b6VIbTvOoc17JXFpmhLg
Message-ID: <CAFEAcA_6xQi-RCubX_fWw+d7ON6CDy0JzP348RBa1rXdntg=Ew@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 15:01, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:
> I do not yet have a proposal for resolving that generic topology issue.
> Would it still be useful for me to post the i.MX95 machine-model series
> identifying the Cortex-A55 MPIDR handling as an unresolved
> dependency or any other way the patch series review can be unblocked?

Fixing the MPIDR only matters for booting firmware, right?
We're generally OK with taking machines if they can usefully
direct-boot Linux, and we can address the MPIDR part later.

> Most of the series covers the SoC model and the complete boot flow from
> ROM through the System Manager firmware to Linux, so I would like to
> start getting feedback on those parts while the generic MPIDR question
> is considered separately.

The main thing blocking the i.MX95 series (we're talking about
https://patchew.org/QEMU/20260820024834.3286721-1-kylefoxaustin.github@gmail.com/
I assume) is "people who care about i.MX boards need to look at it".
I do not unfortunately have time to do review of large Arm board
and SoC model patchsets, so they get in the tree if at least
two different people care enough about them to work on the code
review.

thanks
-- PMM

