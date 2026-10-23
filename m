Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47A6606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=KxC/x3AB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEGB-0004yN-Ht; Fri, 23 Oct 2026 08:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEG6-0004tM-QJ
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:20:31 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKEG5-0003Cy-2a
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:20:30 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8b056d58f2aso7505077b3.2
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:20:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792758027; cv=none;
 d=google.com; s=arc-20260327;
 b=Astj+yo1+cBsD6qf8G8flEmIaeRBAe0SgxM7zsZlSHjAaDhwhrMJG+9nXSPzZ6GHmI
 16tn05Amx820Mmb05il3/JIZGeKmXEKegbExJnWJPko2qP7MUeeFGX1AHr1ho0EGA3Qa
 4HYCIQzFOzyQoMXrOEq5lLcLJGXzSJ8M+E20f0fvAzUF08WlGrOqPtn3OrAh706WYLV/
 OR+w09KbZqPMBFCUpkar/SO5prCRa89+7NIH9z80bBJS4PcxB9yUNCJEl36h7V26Y72l
 tyqD7+DO1rop2O+U6auKd3IQsVamZs5MImzpjbAH8G3H0g3KBxi5OR2hoXNHsrtftLiy
 9Whg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VisH/MgOPy1gOs4xUqtHlpe4s/DAlIc1J9+gozYPrFw=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=Q7Zh9DPZr+VinzujrV7eif8Hsfbd/MTLHf48TxhtN7WFKKbCqbn9iTaYsxOZBipZ2k
 CfxGa7gDt7mJwylTsAfro7sNmhr7Un+ZXsc43kQbD4A/Xm4QGupxyzoRbDrAOq8IAQKz
 O5yHQ+cn6HsTbxP8SWpizXAmGa/gmcpWYaD4v9piO3FdhGUOqk/sQ+kS2f0BfI2SYEYU
 MQp7f3eSud8RuPniBuEECFPvdNoUX+fLSlkEDO64/4MgKtNBDrr9sj32Nyrhz76LCnuX
 2QHB9YLOImMz3uaGv4WqazSkLsF+LQy6IxohJp7Urg0QaFgY82Z/+buXFkNjy/NpoQja
 GVvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792758027; x=1793362827; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=VisH/MgOPy1gOs4xUqtHlpe4s/DAlIc1J9+gozYPrFw=;
 b=KxC/x3ABU9DHLcpfsMvW5WFTsPB9a1JzeLCgubpqhF+pSTE2+WGdvrzeXEKTGlmcpb
 Z7MzFosaQNVm408ldgAiTHV9wshnvRwWBh999NbHew8EjOhQKnj4UxG6y2AzjSESJwEA
 5XePYJ0sNiylqgCrtau57q1jIzrTp124uyVrfmNPtinrUZRypjuiL+ENyjlzFkNIInOZ
 3uu8qsKN3ruKSYKhsfZNxyfWZateK+UkmG+6F3jtcxOKOSbxtjeVSuL3v4bt3Ug+xzYz
 oghAzXwsVYTwuooomC7lFpEMLbZ+LxKtnp2F1TnYnER6QMNOWJLwvyR2q3UrhlbMfvwx
 5SoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792758027; x=1793362827;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VisH/MgOPy1gOs4xUqtHlpe4s/DAlIc1J9+gozYPrFw=;
 b=wNytwyohWed5ivr35bXCpyiK5yLfjy9FXluNw7q8c9ofpAZTDHkLGK5M6KqTYLMj7m
 c1tBXgOuQ/qY+v0kqkBoX5uqFv53w3Qx7A1U2ytsfeWAp7fR0suoSiwF0qMg9Qo73eeu
 Kk26sv0oqAtjiioOlj+hztw451yQTsisdSLMbajvy6nSzHFmsWhU7zhelpk8aEtexbIN
 8fKIamyF7DnoZKbtgOE+vKDUSaqarraeloiBxlZOh6MV0kclRmqXH6vVYhqmBrGfs84J
 VKGNDkwHwne3Cu792zJqflYuCg7K0fWBNrCQtgX1XBXmxYIB3cNc1mxCo7fUHT2hLkLe
 Jtqw==
X-Gm-Message-State: AFq9FYImAKVm9jXKmuVrC6A9LoucMcETUuxBGL3M4ebTYuXIWciJ9kJd
 HxvjWyTV/whu+aOGssLBxhVWCpnRyd7omuB+mJhF7V+f16nmaz17wQyQYFtxzget2GMmabeCFOA
 6L0GH5Ha3sMcfIFF1jX6racn87E42hkzxvx+QS8Jxcg==
X-Gm-Gg: AYBFou1Md6SaasXyV+8Lcg/aC4pPtV+bfw1+Z5OJ6+L5nxUB1jB+wn6Bz9zlOgbCwK+
 92xoVHFkZnDZq0wY9aKNmB08xhyZsnXGioJFsHgr7lcISLrWNgbjV9xqUkP5BHyJnhhgE9n8OUi
 u9y4LeqNvz4WONFKOL9tTRtD3mMcD0ls1l7fCmxgQQKwCEyt4kJ7oAVihf4+tinaaOUuO191pxy
 POOtxcBogRcTOC2BN/vv0NPBLJEccSwxIvOt5FL/m7WJJnZC900I9ueX2FL9lEbhvEvteBBkYEX
 vedciz5N4hc2QPhiXXjxferoKBB5yexErvsGJhUQHJEGoNzhOt/jvAWLIurYSvtpl2TWqmmoZAc
 X98FRu7hp8IC0UQZO7dNAyoeeOjzSIO34OIHVynzZB2HaucaExa2O0jPMVgS1Ke0UETkFrqxQGT
 Hx26w1hn4VROfn0c7I3IJM
X-Received: by 2002:a05:690c:c50f:b0:8b0:ce9f:2993 with SMTP id
 00721157ae682-8b157c709c0mr15122257b3.5.1792758026703; Fri, 23 Oct 2026
 05:20:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-4-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-4-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:20:14 +0100
X-Gm-Features: AclHuK_gUlrIYavqGAGJF8KAe0KTrT_YjnkSiPP5zRjveaSLV6lPq3OKJ4pRRuQ
Message-ID: <CAFEAcA91zAWyYXMFErTdB-Xw+BnJeC7dLp8+Qpq84GnwNcZtzg@mail.gmail.com>
Subject: Re: [PATCH 3/6] hvf: arm: save/restore SME state only when SME on
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> When SME is disabled as part of the CPU configuration, do not restore SME state.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  target/arm/hvf/hvf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index b00a7e1a84..df047b5dcc 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1394,7 +1394,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>      int i;
>
>      if (__builtin_available(macOS 15.2, *)) {
> -        if (hvf_arm_sme2_supported()) {
> +        if (hvf_arm_sme2_supported() && cpu_isar_feature(aa64_sme, arm_cpu)) {
>              sregs_match_len += ARRAY_SIZE(hvf_sreg_list_sme2) + 1;
>          }
>
> @@ -1444,7 +1444,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
>          }
>      }
>      if (__builtin_available(macOS 15.2, *)) {
> -        if (hvf_arm_sme2_supported()) {
> +        if (hvf_arm_sme2_supported() && cpu_isar_feature(aa64_sme, arm_cpu)) {
>              for (i = 0; i < ARRAY_SIZE(hvf_sreg_list_sme2); i++) {
>                  hv_sys_reg_t hvf_id = hvf_sreg_list_sme2[i].sreg;
>                  uint64_t kvm_id = HVF_TO_KVMID(hvf_id);

Do we need to check both, or at the point where this code is
called will we already have updated the ID registers to
not report aa64_sme if the host hvf doesn't have sme2 support?

thanks
-- PMM

