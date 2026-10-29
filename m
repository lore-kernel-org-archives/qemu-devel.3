Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC5C606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=YwEH+7j2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMR7C-0004Z2-M9; Thu, 29 Oct 2026 10:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMR6s-0004Xr-7b
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:28:06 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMR6p-0006aG-0N
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:28:05 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0d63f60bcso19859807b3.3
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793284081; cv=none;
 d=google.com; s=arc-20260327;
 b=WEeZqGd0Upd9PZMsXj5JEBsWZnXEo9hy5cIv0u3iv9PHWHkIWqZKGeiHOK/SyA10D1
 64kyMs3Rq9Tg51O9GMsv9mhsLX/t978iMs7CpCES5wUwR03Zn2Vf3bX/mrlBjDfR0g1t
 OBbI2ghLAVX59mXlQasRzugfbXySDWFaEq8e024IZiTbdZxiKxXabarx4JBhTuEtcbO5
 /N3mSj8ymeAA2AaPpiMdgo7RkVEAqDv2XfNtSjlI72OFwNaw116pPo+l8sMQ4jGUBRXv
 TD592e1/ipb6g2nh4+VUOHDpDEc+4Ct852nfPs9/zE8AwdTXwkXAM8ZlvbYy84JKfvY5
 v3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HD1coENdng4AAsY4IxTWez3IUQcp/V32YZu+Hlw2Sjg=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=ZegbMv169dgGW1qtLDmKTxRi5EHaUOEcWOuobI3hoSO4zj5aD3dlF6/TNrLAO1S2b/
 MznwblEXniQSdmVjBAg5Uxti2qEPW54uJDjLqhLDDSzAWJDJ2KeprJmzUePLT6LOtaFT
 nyDkTnFCPiOqHnnGWkzSb3bJ0J291SW+kerI4WGwZOtrwSfwCgVWP9zOABIBFVkxnNFz
 pgPo2eJ434K5ERBC9EoBKz/1B4o5f8vKHqzJG5ttGYhaW8rpvPCu7FK7M1zyZa9WBiJN
 i7ZC27UtVbZTzCeoHauc1bAbNMvFQj1F5yIFSODAE2oN19FNcmnBHMnimX0S5vGiahUX
 3O0w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793284081; x=1793888881; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HD1coENdng4AAsY4IxTWez3IUQcp/V32YZu+Hlw2Sjg=;
 b=YwEH+7j2E3OhPQs3WBNHUvBHSqXSTvCYcQyZAVvCMB7moaUKHRQgYr3zVqB/2J2Mur
 N5hoCDeC9MzDl9FK9tWwlbauUemalVum0lgDfGoynxwSx4bLMAnbQFLQnt6r/jAA9Kp7
 cNF0zLVoPbMKuK45d48dM/NWDAe9MunAQUBMNti2GUVgDdL55hmLfs0iHAiy3lLtXHjO
 CL7Je4t/SjLZyH47lJWjJXw/IDcGwjq8g7KDXDvDFGYlZ08KlhiwTfEUKvnAfvnbqGd2
 +VA/jXxjT1+0sjWuZ/EkF3masCwwQDvdFHLEC2e7rexPhbrPQ8V8kzCe6d0U+Cd+rROn
 6aPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793284081; x=1793888881;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HD1coENdng4AAsY4IxTWez3IUQcp/V32YZu+Hlw2Sjg=;
 b=wsdEnt0me3DcrtMd7pot8s5rcBgPIA1fuDUGgZbcp/4WRPVE7W7/AZg7nT2XrDo6Ow
 3paWEQ8alE1USmtGg6W+iH8+yPTBvaWyscbl3yXwXAdT8xAculFkLTBG0Qv4tBajjMH3
 /Q1OOpFXMU4vSVCTFq1/nD27alj1Ypk7rrcK4+XXdSgqSG81M5f/hEpImPO3gakHJVkZ
 KAg6FvT4cyQaF8RCbUEcE/adXWWYgLGrYu8uSK4LJ+doVw9Uia/98Q/FIAahXI1eufLm
 EAN65wID1cJi+1f+paqQ9RCTK/wFO2IekFDqyn7f53VW2wGiWQLWCtQggq8PRa9a+JdE
 oRCQ==
X-Gm-Message-State: AFq9FYLczXPfVnDm+m61oUEYGWbl4dgfryRLfF6dRXc5bNAPfwEVqb2W
 HjzBbwCD7dtBY4uCFvW+fmz428aKaoCl9irHjHAnYDKQn8UQgsmbwiNWKIp9m5+HHsZY15DRwkn
 0iklEFCl7s52BdlO2d0Bk6S/w1DGi9AQ0iq3a2lmnvw==
X-Gm-Gg: AYBFou1k2DI3LBLz2+HJYK22FTHgwPmPjjRaLLyOkCApFxXOlulezjc1vFMid7wlrzv
 7u3TybIr9rIPP2z+T2crNJ4OXPxctkA8rk4wYy4NK27QzExWzECjBo63axr1WCFuZbW7/Fv+nRI
 9Fa/H0rxqvKo2fhIsUIqNxO377jUNSo/W3GL+UNVg/fBnt6g/JtXILocW8oxqGnJY4YzeNHLhIq
 8QKOadgEfMfKshAwQb2fKrk+DOg4CGQD8OZRrOIUR5lKcC5MgksR2jFxRukVxtl0MTys5jvVsD+
 jT2rXYNF8O/W06mTC1vDqOMuJaVsfltcprb1RnTJWTm7PW9vw63SI9ebPNjeTwgb+tUct+i6YLf
 a7GBS50czPX7Tro2Wqrh0jAYoJP518DyTS/8YpJno67PnxVSgRJzb/mGsamcMl3n+ONYHp5UFX8
 qpzZ2qxBW3Gtv10vxwWj65
X-Received: by 2002:a05:690c:e3ea:b0:8ae:b617:7138 with SMTP id
 00721157ae682-8b1b5d023fcmr40702377b3.49.1793284081414; Thu, 29 Oct 2026
 07:28:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
In-Reply-To: <20261027120135.53048-1-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 14:27:49 +0000
X-Gm-Features: AclHuK9tCGDod4pQB435_uszNhfj3bFbQMeqe8xtHC9kP_n7bodYKh4MTcZTI8Q
Message-ID: <CAFEAcA-=bOxmonNOYC2_1MHDrdof6eciYrehJRDfWx_7kYsJmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hvf: arm: fixes for QEMU 11.2
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 27 Oct 2026 at 12:03, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> v2:
> - remove GIC_ISPENDR workaround: currently under further investigation
> - simplify SME save/restore patch
> - rework the CPU reset strategy, with also taking care of the GIC CPU interface registers.
>
> v1:
>
> - workaround for presumed Hypervisor.framework issue
> - save/restore SME state only when SME is on for the CPU
> - add ID_AA64PFR0_EL1.GIC sync to advertise the system register interface

I've applied patches 1-4 to target-arm.next; 5 and 6 I left comments on.

What's the status with the apple-gfx compile failures on macos 27?
(issue #4486)

thanks
-- PMM

