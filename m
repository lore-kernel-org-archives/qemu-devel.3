Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0282606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Pj7l22zj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSawu-0001cQ-9V; Sun, 15 Nov 2026 09:11:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSawq-0001cD-AR
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:11:12 -0500
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xSawo-00036O-GB
 for qemu-devel@nongnu.org; Sun, 15 Nov 2026 09:11:12 -0500
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-67921b515a7so2549274d50.2
 for <qemu-devel@nongnu.org>; Sun, 15 Nov 2026 06:11:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794751868; cv=none;
 d=google.com; s=arc-20260327;
 b=FDQaE/m4yrFGpUJ9JDzgEacn/KWeSp9YnymOSySaPLQIjSFclljRNrPRtH6MpYz1oC
 ENFG9VTK4E/CGcQ+k3d9u3z7hKVmVLCZ3jzbTgt6cjchmx+/rYi+Sv+hOxTt5bwtW41S
 9Onbebjz3SCIgTPzVtFATI6ycf9i6P+haazJMg95H2oe3fUqJGllZTgCF8Rpem4X386r
 yoVCU2nRsRLBRaM8VrIWfIOZIcdEYN5p3fuJjUh31oQ6fx8Z6serWRJX4WKqoRxdY6IQ
 rhHZdZSWEDF6ItKcp6DeR1jB5UQLi+wj8vLfaeaugQ5wJeMpSV6i3sM2s8ynR9ztUj5N
 b2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i0F5yzwA+G184rrTVUqfVpCPg+kI0D76JH7CsSfqVv8=;
 fh=/0mLx2QZvtq8GoWzzSMd7ktKRyEIb2z3fIEkTJl/yJI=;
 b=Malbd3MHJM/SKZ9U5eWG4RXQBps9Rti8K+F9oBw3m7afEafyl+VSiEUeL0u8in3TVx
 zgptPxmnu+MfTK/FV1cSsnitZUiTRYtz06ndOIYiYWK5W2Gx9M9NKQ/cTrrHDUlfNOUN
 Jc2Mz7D3KZdf9ae8SEZXBpbt510S53WiLt69W49uu0+SzEFrV4jQhToHDwtSKWwBelNO
 sh71pusl+7dsvQvi0MB3PXzlzCyPB+eqgMOwbjD4MNmHmWczqfiQr1FgAQD6072EgDbx
 gKwJ2RDE9S7+1EYY3hCovXLxQBq2EVEKgzFsgwNrTq26wv1KD/SKUlcAgRae6jK8Hpzq
 bPdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794751868; x=1795356668; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=i0F5yzwA+G184rrTVUqfVpCPg+kI0D76JH7CsSfqVv8=;
 b=Pj7l22zjOVjWAy/usQyyHBiLAONEd0K4dVGqdo8elXYwPLqn0uiezgNL94nFWpbZBA
 rfRcS7ZaVl6vPIWE6WOMs+/VreGhsL24ZR72XdBZeCdX9yGxmDsXIKgNAlZ2O9PkNItz
 LBKEU5eZLB/Q9mesgxXrHl+dOf2p32vOheB2BeGLLBLhjennaqlNzZQAFxq/1RVJh0h7
 oRWAjdSw51eFSKVNIiV2Lt4/KCWeqDixZEgZyQ6M/zigDo92EMD5kVKYN4vpUPvPx6Zm
 UHIeUpmg7ZHRjtEWpeuVUEDxR6s593HFDZuB5pt+2iAsUEdv4MqEsWnh2Eh1z5imTcaz
 O1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794751868; x=1795356668;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=i0F5yzwA+G184rrTVUqfVpCPg+kI0D76JH7CsSfqVv8=;
 b=qy8Y28P7gaJ388reotuleFHlliUzdLkPjjA2c9Z0JcBy7O5WqOXJb5ma4u/jgp6HN4
 p7y1flsSearJRNI92T9gxursLdxW6muXUD34w8rVeKY1niHhPrOq2gDcARO0vo7Gpquo
 krLakLuy5qFC5K5sFbCGXMRpZcpoDq81MvYIuKCxR2eNlNDK6izgU/L8UZG8xb1cY0TK
 /tFIrnyrS/IMRIf8hOGzvd3w0QeHCJ9VBaxR+mwOmdL4W2JgpErvrAQfcST4/uYu35bU
 qKxIb7EJURgczPkU1g9axQ1CqGUHkDhWwtAjR+8+8fiPLfrsH38BFdQ4FjweM+cqa1Pf
 05Sg==
X-Gm-Message-State: APuU4Z/sfZQjb1JHGDm2129RqcLju8kyWJkcwVkoZr8IqJWsR5dfTag7
 j9cbx7GUO3uvOMHCuIuC9gf6/HYOv41fjl7drcXSnYZuLfMntdbpTFw5sPZo4wEQay18RcVtdkO
 OR6mhDVBHpc7NP5yFBKFOBNYqSMYr8mQ2x3cgjP1+tXkwHVf/i7P+VU9E0g==
X-Gm-Gg: AYBFou3ivNb8NhINA2mEnovssZRGHQRWhbETm5uKYCVSgjQ4zcLisFwtHThq9Yo+XCn
 GT5C/IQW9SC+BrXQeyuS46D/vDPxwa3OYp9mR1ufu7nI3dOrO8Wmdi0brzolOl+3tdYS+KYdSB3
 3ANqjk8eVfanJTOXRZUMBZlMPSi53HaiZSLQebLTOZiRFLF1GLf8jmTUHGt2/3IXAfq4e01WeG9
 GQzkRwQP0UN5t3vlMawHvVYHpXdxx0XRs+0dwU6hw+PyjvdXUaWriZvSnAqpLQ4ydCfUIWql0ir
 8/osWzuaXbb+wJW7JxiSPOKBdeoKUgk4QRFzeE/kTAS1ySv2vLK61Wo35DyfFxJhDXfvdOODMcp
 5HKZoxZ/1sJRRwZPcGI8b/9QCz3yVQxYr/XwpIenuiAL7z+L2M2G1BjHYtYgpU8nGiEN5v10r5r
 JHr/RaXEgk+ofW7jXPovkc
X-Received: by 2002:a53:d006:0:b0:67c:664a:9006 with SMTP id
 956f58d0204a3-67d896df2d8mr4215261d50.64.1794751868455; Sun, 15 Nov 2026
 06:11:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261023014931.4055823-1-maobibo@loongson.cn>
 <20261023014931.4055823-6-maobibo@loongson.cn>
In-Reply-To: <20261023014931.4055823-6-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 15 Nov 2026 14:10:57 +0000
X-Gm-Features: AclHuK-dBeqwp1B4sZBgoai_L7EwgjZuigML2y1ZHn30-F9mOM7vjtZfEnj-LOk
Message-ID: <CAFEAcA-bMyReAMg7LgLujtPQZ361fb3oNN3AAmiMeGQ9_Og1Bw@mail.gmail.com>
Subject: Re: [PULL 05/10] target/loongarch: Remove TLB entry in vmstate
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb133.google.com
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 23 Oct 2026 at 02:49, Bibo Mao <maobibo@loongson.cn> wrote:
>
> The content of TLB entry may change if LVZ is added, TLB table can
> re-establish from empty state after VM migration. There will be
> compatible issue if TLB entry is removed in vmstate, however it is
> only affect TCG mode.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>
> ---
>  target/loongarch/machine.c | 35 -----------------------------------
>  1 file changed, 35 deletions(-)

Hi; as pointed out in https://gitlab.com/qemu-project/qemu/-/work_items/4879
this change breaks migration of a loongarch "virt-11.1" machine from
QEMU 11.1 to current head-of-git. Since loongarch supports versioned
machine types that means you must preserve migration compatibility
across QEMU versions.

In this case if the destination QEMU can reconstruct its TLB
state without the incoming information, that means you need
to accept and ignore these vmstate sections in the incoming
migration data.

> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 931a5ca5ba..952c5497af 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -175,38 +175,6 @@ static const VMStateDescription vmstate_pmu = {
>      },
>  };
>
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -static bool tlb_needed(void *opaque)
> -{
> -    return tcg_enabled();
> -}
> -
> -/* TLB state */
> -static const VMStateDescription vmstate_tlb_entry = {
> -    .name = "cpu/tlb_entry",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_UINT64(tlb_misc, LoongArchTLB),
> -        VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
> -        VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
> -static const VMStateDescription vmstate_tlb = {
> -    .name = "cpu/tlb",
> -    .version_id = 0,
> -    .minimum_version_id = 0,
> -    .needed = tlb_needed,
> -    .fields = (const VMStateField[]) {
> -        VMSTATE_STRUCT_ARRAY(env.tlb, LoongArchCPU, LOONGARCH_TLB_MAX,
> -                             0, vmstate_tlb_entry, LoongArchTLB),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -#endif
> -
>  /* LoongArch CPU state */
>  const VMStateDescription vmstate_loongarch_cpu = {
>      .name = "cpu",
> @@ -283,9 +251,6 @@ const VMStateDescription vmstate_loongarch_cpu = {
>          &vmstate_fpu,
>          &vmstate_lsx,
>          &vmstate_lasx,
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -        &vmstate_tlb,
> -#endif
>          &vmstate_lbt,
>          &vmstate_msgint,
>          &vmstate_pmu,

thanks
-- PMM

