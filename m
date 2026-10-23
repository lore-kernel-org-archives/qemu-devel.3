Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B188606A334
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Qn6/17gA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKCDy-0007Qb-1N; Fri, 23 Oct 2026 06:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCDs-0007HW-27
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:10:04 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKCDo-0002j8-UB
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 06:10:02 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8b0dba37a7fso6192897b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 03:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792750199; cv=none;
 d=google.com; s=arc-20260327;
 b=QALxaxKO5BOtbE6lN4qqf60be7RtKfhN+9cqQYZ66KLKecnjN5GAOXtMXMtzFWabBm
 1WOI/GUyBEx9IF+kiqVVEul8QsWT5W3pq+E3C+TS+gdQj2mE1bbOz9MBF8VLVReMibxT
 lS0/+Nk4dA/J2ClXp8ccmPi9pJb7+/DTxKgDKk0A+n2lGOyizoZIcpEHJA5nMAOVCcEz
 m/0XGVJ5POJjde3oBUGC2Je0K9SHrAu4+gMOItUDJ/YEOKsuhAsEb60ZPdJ/bNPFwKTL
 iASzXEcXPSxetyzsVyQ97WbK6C9EqZM/Tbzxgv9yDoPeYKB2gRxnJ6tgIkPeBcPAyWz7
 8SxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7bdZpNHoTuv1cxrtME0r7Z9VIjTt5QEHDedoD+g/PIk=;
 fh=gREritCzZWvcfaWqpktBp3/OUmb0rOUSRfa2BWEvW68=;
 b=lYXWa5++QE54V15x6HhuJo4k17H3CXXwupM/U9SzkXt3JqBmdRje8kZGCfTWo07dfl
 zl76wKOIlYyVPOx0YdH+UfalJ5wQMb/wkUh2hHFkURaqdVn/7W/d5CFtdwXICnLO0Exc
 HEP2lDXLjyxXLNHj0arK21WuDXYCcNk8DbSH4ksNx0Ex+GLLPhJYWv8BK/DSe9e3FJ8e
 UgrcogpTB95HucjAWfGxSZwiVuCELg58RtQ5kJH2tSLEF/kAHzi4iRjOqVD33kgwk4Wf
 jp4tbmvYycXTAYuJQYMWrQE0cX1aRcbIElQ/GOe4dGAoPkj/2DiCnj/wDMEoGUHoPrv0
 orsw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792750199; x=1793354999; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7bdZpNHoTuv1cxrtME0r7Z9VIjTt5QEHDedoD+g/PIk=;
 b=Qn6/17gAK9/22FtpSRnKGb8+MljLULSYq7q1vX1RcvjiknnteWg1Fb7Nd4I3IOmwrg
 xUkTAX4/Y85dR/UuiuDxBFahuVqJzCrs0QqAdlmZGabaHBQgD/1pap78DQq5fsAOENb5
 AlMA/M5Cek+V8LisyWwqu6+gDXYaTTQfpKdyN0O+tPlqFZ9MIvOwgxyfUKBv7936OwAf
 mSfFS9pWhiVgsd7yy29Al3BqcVVbifBvW8eD4zMJePBvLEUBhe0vxed0rRmmjw8NBWMd
 jmME77P0cPmsiad341HoqWr+jSPYdMM4cBuN05hCfn4zba4KtfpCZcuFvej7mffXAHAe
 n/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792750199; x=1793354999;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7bdZpNHoTuv1cxrtME0r7Z9VIjTt5QEHDedoD+g/PIk=;
 b=skR/EsnaHVaAwUURDI18wB74diY3gM4SBVTxKSYT1DXXjyiMfP3l1+CkZy5SHA+j34
 /NXp/fijE9IxHUXogRsUnSiLBCBLEj1+4kYugSn+EC1/9m+4H8QLq67PFghxf2gTof/c
 GhV/tF9DTDwZMC0XnzbA7Wnx7BnwfJmkGixiI5aePKHyWP2y4qeu1G1KQhKEf3lVOWOH
 ynX13sT1bZVddz2Up8S5856Ez2wxKCbQDgu2ZsRk+5nUDrHN2S75BRghqDLfoR+Zy2B2
 MgcSqIUAd88w2hBxXK6QXFSAD30BFhY6G3Yx+haqghROUJFTZAUwJpRea4kfVLQhesoL
 2l5g==
X-Gm-Message-State: AFq9FYIw4vU/8g50+yuQETY/iMnh5qdtssvc6MM4o/ldZkX8lYpfmtFA
 uEIwM9FYFoXth4c2I0gW7oVj83hrKdbIXtxtYi5bNn2XQ7YgX3Xt5oTjPWPQOU53R3RbMli+ABH
 ilzi+jyBgiWrWX3v3u9cNk1HZ1mkWnekDwkxnv08EgQ==
X-Gm-Gg: AYBFou14qCP8xISL7sVk6yBXApFzXwZ/ATjttYRAyPRxPwrWVzUauynJExCWs08fG1u
 DiKkYe/lnxfgWe2yD+0Tw2tCTQY5BAM0a0eADZnx5ToBEknhv4wNKosvE9aOPPkPLToDhWNDWpf
 EQg1Kp1+caqodjyTmFM7fjapHuiRewGRXuvXuodQTfDQr/miEX3k9mPSmxma4OtKNIT72H+c96f
 6d0bsEjwLaNRnZd7+hnykhx0uRyajO5eV37F4DQF/JzHYyv42RZomotzIY5+Mu2C/1Fi54W6Yq1
 RCVgB21CrU+vIiUUCd1uWSXpmAS09jOM0+r7m7HWuTLBhEbxrr5K3ZaDpP9GiG91BRWN4KDWilx
 2E4KQz6jRet1zWTwUEIh2rzt9Y4Mfs2jcnCvCB0Z8oaoB4/isf6s+qKPX4We8ln4ehdwLcZpZuk
 SkV11tmFOyV0O35c3bl6TM
X-Received: by 2002:a05:690c:c6c4:b0:882:31:3af9 with SMTP id
 00721157ae682-8b157c8f608mr10629497b3.9.1792750199291; Fri, 23 Oct 2026
 03:09:59 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
 <20261018133603.64323-12-marcelomanzo@gmail.com>
In-Reply-To: <20261018133603.64323-12-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 11:09:47 +0100
X-Gm-Features: AclHuK-sB-K9XTNyZlKeCsKCGmkxZZAKx4U0GG11jjpljJyrF5rkowfIsdXmyNU
Message-ID: <CAFEAcA-BoFGKpd8vcSGp7SNxq5xmKHx4RGg1eOT3rNwjB1A6jg@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] hw/net/bcm2838_genet: implement GENET MDIO
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, philmd@oss.qualcomm.com, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 18 Oct 2026 at 14:36, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the MDIO command register handling used to read/write the
> BCM54213PE PHY's standard MII registers (BMCR, BMSR, LPA, ...) plus
> its vendor "shadow" register blocks reached through the AUX_CTL/
> EXP_SHD indirection scheme, and a simple link-state model (PHY
> starts down, comes up once BMCR is programmed and autonegotiation
> is (re)started).
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> While carrying this forward, fix the autonegotiation-restart handling
> in bcm2838_genet_mdio_cmd(): the guest PHY driver sets BMCR.ANRESTART
> and polls BMCR until it reads back as cleared, but the result of
> FIELD_DP16() (which returns a new value rather than modifying its
> argument) was discarded, so the bit never cleared and the guest
> spun forever at boot.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

