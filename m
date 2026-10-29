Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B5606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dBY1egFW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRRe-0004v4-UL; Thu, 29 Oct 2026 10:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRRa-0004uB-EC
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:49:31 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMRRY-0000DL-8c
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:49:29 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-8ab43af5e97so10369357b3.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:49:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793285366; cv=none;
 d=google.com; s=arc-20260327;
 b=iD9M/5LqbT/IEcJJcw6yvlc6tktq5BOVMmfDesSuaBi3Xm7shpJHi+DEj+Eb+kinh5
 csGqAlzt21FWX7Do1ohLPv7WdPTn3KX5Uu91qHCcmdWdi1H2Ig7MTWpI1kp+eMRXZbc0
 HKwQxUNZyBA6C4GWmArBvY0WMBf6Xj+xX/jeagj5CHAIF3uHtWl/r6PNgK/r257IEM1Z
 2eyW2kvrhLnDbrXGU0MVSf4Dl1YbHCdgltPm1f+TqOpvPSFozfAwDsSg+AAMcTuKVfJ9
 vzkJA/Btf2MFlNaAohQAd5v6rlP8K+hmSQR5MrRzU00tsUDvbXblmWo4xMcjOpOBp5kf
 5hcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MgN094k1BFcqlTCztzZgWYZeEgqavZD4L+tZVF7wL1k=;
 fh=4SguDWKpx5GeakMa/O8CghfuDhynpnNknHC36jYJwrM=;
 b=V3DJfw3pTh1qYU4Kpl0l5uZmQSzeYWNpOS9XWk3dMmwkztttl/5OUJVb6VPFGSsrJH
 PZdPvKL/8NmwMHHU2IibYlMbi4XTz9uAjplb9/yDDrVuKNaE4G5wdxZOejfJ/NLhegX3
 AEswHgArHyUBEZANOmEdv5/GHZudNd74UGveDCmxkg7XzHj9QavspI7++7Z7gU6PjZDq
 mfwkUHbaDYCgBQU3gOaSW3tKHN34+Gie3j4I0KaTqs0O7XQdnzsDo57aFxguaAXmPx4I
 pb28J5v5366QSXJ7gae8wSUhCzLo+l5WkC+XIYOICRDf94QR+LGufL65PC/mM42CgFcc
 FRNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793285366; x=1793890166; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MgN094k1BFcqlTCztzZgWYZeEgqavZD4L+tZVF7wL1k=;
 b=dBY1egFWHgkhINo1/dwaixOObXd4O8txiiKNzBXU/nLJTcKGCWUiXJGWGanptjk0iA
 h5DLYug8HTPSTj9mqVm8nxtoo2Y+0cxVOLSRyY0lofPpixEeaAUgXWSfwUQWFQWv8epQ
 ffIoxvKlMqjYSuMpm+1laVTM8Lq4ETAAXCdv7awwshC6WXbEZ2w2e8zoOn46htt7aYof
 UguoXWHyTdKG2C4dSchJtNiQpmba5yNG3hG5583nvIJAyfNq77vbbjgNyttMLqODZ2cq
 zrpWjgWpxRbd9EJvw2oFiN5tMTpO+HAjqjrfSja2t17KEW+XsXH+hcNETTMLTe+AspbL
 65/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793285366; x=1793890166;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=MgN094k1BFcqlTCztzZgWYZeEgqavZD4L+tZVF7wL1k=;
 b=ts5fBdLIhQ2dreCX/Rlzv9GOtl8GSkzkhRTMb/3z7+ge2CO747zL+XdBpJzHWoHMZw
 oBTJ6hmTRFmmAhAJsYy8hJL+I6ciGMw6snue0aotAw6rAU7q46O4+A1uqg8iZHnnhLbX
 GFsLYjLJ8ckwa+eaDwlbKmyHVVAV0/XtU0bpFx6ajVnK6ckKsbdEuWuqpPCt5YoG6/Nn
 3vwJ/ruvwJ4dqBA/BAuYiXGFAfEmgFBfLCSyIXDRmb33SdCmJOldVAIsqRXYKcW1eW26
 c4rpEnChbYrdbWx6ZaeGsD7ipPddO0pJZkprFgJdhz7rC6qBlsgunEjmSDEySNxWO4ZY
 MauA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+u5gmbyF7LP+s9aKuf4cGeVHAN6Zxyu+IjbXMb8jTEfd9aNknz8/WcL9/JM/z/C3+d+SWJALkQhrC@nongnu.org
X-Gm-Message-State: AFq9FYJ26CiNOyESgytph/wDb4KI325fnR/prxP9IJCq0EJ/TBHh7TtS
 DHa8pGcxfYR6iWyinRY6jdwbT8lvG+B2ylIOAVWlFxfAc79mt1qpjl0gpLd+Ge4uvaPzfKNiC4v
 hSS+KNaPcAZXB6sW8U0vNWOEY7n1CCVtmFeObtGplww==
X-Gm-Gg: AYBFou2+rSD/UnCrKeu8phLfEHH1kLsWFBIORWzR/QRkZLNsWz3SSlscQUHCQxaITUR
 UxasUfMJW8Jicsq68AqnodzUWXRfGJcWE6Wy1x3OUYSW/75pDtd6br0LLCNoRKjL+9+tA9R6bgR
 NfEHD+xcTFQmpla2CI09zoufeSApyp2n5rnnYOydlY1QoTiBP5vujitv8eianVj+F0dUydWtpAm
 tuLuswYJQNReCvlVm30lIAw9AgoG2oWD3EkcE8PriNVOIZhG4rOS86124A+8Gc6kppGy/LyBv9z
 itNznleFrS2bWfiCotjB/xnwUwWeLKBqJMC4vPejC5DjqVSdgOIuvJeLCbc/oE7zcYg3LaDsz7o
 jWYLttdVIWoAuDEreYXHyjexCjtRLDHZNRN+4CsbK6XXaFTNKx54ovMn3QJPjLSKLx0KQX+t6PU
 mmiTaLCm7pHUunFDotPMiL
X-Received: by 2002:a05:690c:6612:b0:8b1:6c4d:6b83 with SMTP id
 00721157ae682-8b1c6762363mr20010397b3.24.1793285366380; Thu, 29 Oct 2026
 07:49:26 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-7-eric.auger@redhat.com>
In-Reply-To: <20261029092307.281287-7-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 14:49:14 +0000
X-Gm-Features: AclHuK_QnTgYU6J5yARPKiW8vNTsLA2SYpuOAg5EmAHtKzsWF-GIopk7PrDDMDc
Message-ID: <CAFEAcA9NZ6kUCB3eLYdwYaG0pedZej_Wv7te1s94hYo67CpV+A@mail.gmail.com>
Subject: Re: [PATCH for-11.2 6/9] target/arm/kvm: Pass an error handle to
 kvm_arm_init_cpreg_list
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, armbru@redhat.com, mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026 at 09:23, Eric Auger <eric.auger@redhat.com> wrote:
>
> Pass an error handle to kvm_arm_init_cpreg_list(). A Subsequent patch
> will do the same with kvm_arch_init_vcpu().
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

I wondered if putting patches 6 and 7 the other way around
would be better but it doesn't seem worth the effort of
rearranging them now.

> ---
>  target/arm/kvm.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 28f199c03f..d454346037 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -872,6 +872,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>  /**
>   * kvm_arm_init_cpreg_list:
>   * @cpu: ARMCPU
> + * @errp: Error handle
>   *
>   * Initialize the ARMCPU cpreg list according to the kernel's
>   * definition of what CPU registers it knows about (and throw away
> @@ -879,7 +880,7 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
>   *
>   * Returns: 0 if success, else < 0 error code
>   */
> -static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
> +static int kvm_arm_init_cpreg_list(ARMCPU *cpu, Error **errp)
>  {
>      struct kvm_reg_list rl;
>      struct kvm_reg_list *rlp;
> @@ -889,12 +890,17 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
>      rl.n = 0;
>      ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, &rl);
>      if (ret != -E2BIG) {
> +        if (ret < 0) {
> +            error_setg_errno(errp, -ret,
> +                             "failed to get KVM register list size");
> +        }

This made me wonder about what the "returns success" case here
would mean. I think that's in practice a "can't-happen" case,
because it would mean KVM had no registers in its register list
(i.e. we handed it a 0-sized list and it said "sure, that's big
enough"). But we should treat it as an error, because otherwise
we'll return success here and then later code will assume that
cpu->cpreg_indexes and so on have been set up for KVM when they
haven't been.

But this is a pre-existing bug.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

