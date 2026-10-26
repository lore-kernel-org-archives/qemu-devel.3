Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E648606A331
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MoRrB+sC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKJL-0006Nq-RI; Mon, 26 Oct 2026 09:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKJH-0006Mv-UA
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:00:20 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xLKJF-0002vo-25
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:00:19 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-8b0d91601bdso30190087b3.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793019613; cv=none;
 d=google.com; s=arc-20260327;
 b=Mwvn1zYrrrLDNL5Cybj3XL7I3YmwV9RWVYv2V5y0yQTBTmZPKo3+Mc0PmfS2Q6rjXR
 t6jHOHZdkd7O+p2/+Cx33lmkxh9CcRIZmMSAd/toRhD8tuiI4YX9NaxSobtJ17k3u4zQ
 iSBjxekEPjemlNMvDtxGXBO2pVUYCDm+VMKCamk4kNou3ekNKHPS1wyiUbs2n+kLMa/I
 U2UoWW3eXIUaloD3orEiun0w2MiWZ1no+6HESb64FYdr0OgJWHzrSUGjDWCL+cZxUPm3
 gW4AQC6aBY7qARwZJ7Ys/8haX+OQf/UfrJZAMQUpFSTyAD3tnEQ+8xI71CqiDpuhuVKk
 thOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ihqk4gb/zPAdcLj/1nSQMj+bUbq42VGtZ2AIX+Jrako=;
 fh=9vbVNIdRsO0paNhZWc2/4JcInsvPbgZ5nIOMIbgIuW4=;
 b=Rs7ojhjvM9EpBEriQ03i/v/4R3K2OVMARxbxr80DVjYtsCu9Lg3pLjrJud+LVDIE0q
 NJmi6HQ939HG7Pd/e8tDsLPIylXqkwaBnP696Vo8+5QrFC1ynOFqqXlGzwQLgsIIbzmC
 RNrHvPicvY/3kMXoVHmoNdTH8VtzL8h0nUWV73EeyBANaMGih0zyi1DwyQzh4RW7Hwp0
 okemQE32m+YgkQr9YDTrHDivvie+EJ/C1MPa45QpYtKTB/icYcFUOTG3lIFGyliTl2on
 hnTc7m1qn1Mgknzu0NKtAU0JPzGbg7TD72XQ/v1DoiF3ExoSeBY+xZXiyn3BDIqj+HwZ
 utJQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793019613; x=1793624413; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ihqk4gb/zPAdcLj/1nSQMj+bUbq42VGtZ2AIX+Jrako=;
 b=MoRrB+sCAIv7o9HkJIkNQJrQz5hyVq0zzSdAKEVzlUByMkl2K8Igra03pu9BUXo9B7
 BQo61kwP/Oue/hYBHFvN+U+BM0PDYZKemL7gwKojJFCw/qreXt9S1muCUVV0eVknLgVJ
 Qkw9mrZQ2p/luWAyyUuPjpxPThV8bTDs3RegxCvaufJOKKADz+L/LqFv3IdwM2xQ618u
 TGigXyh9q/aHyXIGYmjHGodu4YEKW7t821vCFrskIKJ2n/G28RccKdc05fy94vgb2asO
 BRQmhQ5I1pSwTpDDGDl7HEOle6Y/XrmEV30NZ6siWsfa2l0KT6ZLUTICjjN/A2lbuYdf
 +TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793019613; x=1793624413;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ihqk4gb/zPAdcLj/1nSQMj+bUbq42VGtZ2AIX+Jrako=;
 b=Xle9LkXVloLNVR/NQDAiYxBAwxBClbZ/NFZGA51paTR+2Cb+Y79AiXs1mJnG/vEMNq
 G3hDfU/W+eDA8mKHsQRRq/36o9rp3fR24kC1FEqw5tINgcq2QUvQZu7knm1CBWMuaEnU
 n4tpTM0a2VmmdMao7NzKhmIqxcRnZWnCWAmMU5rMzFgYVQD+0oSuaJnONWdcN9UycOj4
 ialLUXd7bNd4VVycXU2T/0EbT4DSgR1GSJ6mv8SOUB3fOgArFVphZRtuXmaCbV9D2pe/
 ETHPYdy2UF+nThsuwFMqysonIFOK6t1wrBV9s3ShucV73cFHYRzeaQoEJKqeTdFR0SFY
 1EaA==
X-Gm-Message-State: AFq9FYJcelmAa9Tq+ZsiaB1xIWMkTkWjfeZx2trFOogO1O4wtKFb69a1
 FgYPWhmy6jcoykN727lsueXrLlc2hnWxvqzf/qvNDSq/5lCAsI2rVvAznutjhjcUoicYHhu5pc/
 imEI+4PocliDPYuhfVnFeFUCkQd3I0WOFU8GiVkhNlA5Q0wutS+IhFtA=
X-Gm-Gg: AYBFou1zIgO9MucFkbvBCLJHchyfk24cqH2syqbVBmt3zgDQyjeUtP7oYP035VWH8aP
 4c9+YypQjSMzYLflratiatmCdVr+du2Y+ENbsT/YrnW5+lg5M5gUzoPGYqZ8AgOxgQCLumUAuiR
 bCjSxLQ7YDucaS7s7+dR/EBfsK66fBhoNX1QVZ+n6eS+3ZFSv2LJWJXiUznAC8vOT34gld5NXOn
 D1h0gAvQR9YD5z42Ma2L3jOAl/dvNB43jtFR/Z+h6mytTDVJQLwddEd4KM04ODl5vS3hvbBDfaX
 niAp9IFF+xPkCEoXOuwUO7oceX3pdjdU6+W2HP39+Xidr5wknuwCirLskfglVKXV8wwnkl8sv4F
 Yq8qwXmgHdbOB47ZECz5eme6tof+Gs3yBbKeIfZnds2acvJb2Ks2Tkj0AD8IGG4XxIdWwjRdXyW
 H+Fa7RAi2Y3bnW2hQJDaZX
X-Received: by 2002:a05:690c:f95:b0:8b0:cf3d:7b10 with SMTP id
 00721157ae682-8b16731a990mr42279717b3.28.1793019612986; Mon, 26 Oct 2026
 06:00:12 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <DB8PR04MB7177C8ED1A20409414A573EF87622@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA-dpfXTLk9KNJ0OsOEaCYppcZLLgcnOCqhUXmOVE2jfaw@mail.gmail.com>
 <DB8PR04MB7177409A95BDC85AC5446A6687612@DB8PR04MB7177.eurprd04.prod.outlook.com>
 <CAFEAcA_BNjFC4vEJ2h62NytzYQXKE0o4MvB2jpN74S05kHRLMg@mail.gmail.com>
 <DB8PR04MB717745592F89F86226B7E73787612@DB8PR04MB7177.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB717745592F89F86226B7E73787612@DB8PR04MB7177.eurprd04.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2026 13:00:01 +0000
X-Gm-Features: AclHuK8j9g65b9owMZgmgPDYCSsnbD20pc0CVEqCxO9FIsvmfVzCKHg4vIIP9ko
Message-ID: <CAFEAcA_z5n9obipm=jOieJD0VoSJOTN1MVpRdtHgEDDfq5SfUg@mail.gmail.com>
Subject: Re: [EXT] Re: [RFC] target/arm: Correct MPIDR.MT handling for i.MX95
 Cortex-A55 Aff1 topology
To: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Cc: QEMU <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 26 Oct 2026 at 12:29, Gaurav Sharma <gaurav.sharma_7@nxp.com> wrote:

> > > This is OP-TEE's generic implementation rather than i.MX-specific
> > > code. The implementation is appropriate for the conventional layouts
> > > it
> > > supports:
> > >
> > >   MT=0: Aff0=core, Aff1=cluster
> > >   MT=1: Aff0=thread, Aff1=core, Aff2=cluster
> > >
> > > Therefore, I think the problem is not limited specifically to i.MX95. Another
> > platform could encounter the same issue if QEMU presents a core ID in Aff1
> > with Aff0 fixed at zero while leaving MT clear, and the guest uses the generic
> > OP-TEE core-position implementation.
> >
> > But shouldn't QEMU's Aff0/Aff1 be the MT=0 arrangement? That's how
> > arm_build_mp_affinity() sets them up, for instance.
> >
> > Is your SoC model specifically overriding the default values to something else
> > via the mp-affinity QOM property?
>
> Yes, the i.MX95 model explicitly overrides QEMU's default CPU
> affinities through the mp-affinity QOM property:
>
>   object_property_set_uint(cpuobj, "mp-affinity",
>                            (uint64_t)cpu_index << 8, ...);
>
> This gives CPU0 through CPU5 affinity values 0x000, 0x100, ...,
> 0x500, with the core ID in Aff1 and Aff0 fixed at zero. This matches
> the affinity values in the DTSI. The TF-A
> platform code also derives the A55 core ID directly from Aff1.

Right. I was hoping it might be possible to avoid having to get the MT
bit right by making the affinity values you set on each core match the
MT=0 pattern (as I think we do on other SoC models), but it probably
makes more sense to get QEMU to also handle the MT=1 setup, given
that bit of A55-specific code looking at Aff1.

thanks
-- PMM

