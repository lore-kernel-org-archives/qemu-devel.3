Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E03A606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WDL4As5i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQk9-0005c5-Qn; Thu, 29 Oct 2026 10:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQk6-0005bV-Dl
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:04:35 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMQk3-0004EC-Sn
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:04:33 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-8b118bea471so15442817b3.0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 07:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282670; cv=none;
 d=google.com; s=arc-20260327;
 b=J3s7MR+OKfs/8ayZUSXslXYUwGDn2KelYwZvVH0LYcaxFm4DF1l4agmJN5zAUIOnTN
 mVl/8eT5SnIPXj450q34mWOQ6rtNYOYAVDkE0RUC1VqQFCFfU9AJ2pU+Rzf97514G7XP
 2K3RoimWsDHuT7IrQzC7b0ORZu3y2Ir4JxrLWu5k5CImS+wLCIIMSCHKbd0QERmU6jZo
 dzAAK6yY/yarsoadPC21eIhrAX6m+W55Q4U2BCTsTfQOSs0TxY2OxKFDLdzw71E/xh5/
 Ra2kFy4GGPATPCbW9ZU1DkMD9pxuR9CUy6G6dGhkwdHueDxgDbhebUFSzHgKLJ7wTM4e
 T/EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6Msv8WnU8v4xKPNjuWlPYWq91lci8T4e3AS7OgMk/Ig=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=n1Nh7zb9zZQQmG+fCWhuxHBo34NB4yah4JshjLp+TZnmWeq8gNKAa2tt0fk0TkSe/L
 ERH9SxLsnN/Pn60ikQMh2t1ujp2Ta2BeahnGVIYgpMQnE9XOOuQqOHqu5ue7xdxvNMK6
 w6lA0QLR4HT1Kwx5yPqGhcL8uSCCozTGhm96mnBpdptGuLrnyfuyfgujY36AKRuXuxOI
 t8h92MCkJm7H5jPYTtVbpFOZEk7VqPaLAzPVof+mUjaDa9GwC2ObMmNVgvW/yieYQwCZ
 0p9iduenIPY4UuYC5Jb5EpeZgsNjnVQPBtkHjsvVmBNNqMdvd6BHcxnYauK8ZIGgaMVS
 mfyg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793282670; x=1793887470; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6Msv8WnU8v4xKPNjuWlPYWq91lci8T4e3AS7OgMk/Ig=;
 b=WDL4As5i1tvKhlxR713zOjYggqaiaAMFrYMRbaLaD8nUh0iejvrxc3EiXaX+jQVvn1
 2eGO0LOcKY8A0ag+Ll2bZma57dKrLmmCj8aI0gdmYjc+Ff9IY0tFCppOsUtNWg929zMt
 OirvG+dcCkR4WWx1vx4u2ybWyNdN3Trh9KHH5ZYf7y9clbZigXmQb1eFgX+1uu2s1sIn
 12iRHjYqe+bEHD2rUsFjQArbW7Ic/TECt89R4UUhE72kUi/4xeSdH2An7nQTQKJdyZY0
 wwT6Zy0v8WS7PR2aUIsA32ULzpMTD2P5FRWxrzAEo8MycEmoyu0Ap6KKRVSXK/Rrxp2r
 Fx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282670; x=1793887470;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6Msv8WnU8v4xKPNjuWlPYWq91lci8T4e3AS7OgMk/Ig=;
 b=JoOM0/YwSyZP6jbfjFApKIgxzpv4TVzzW75zHCLs+vzoanYzbjhTBpVvWwSAPS9nx1
 Y8FTMdFbdIi7zDewPjbPAIb0r8xM4wXyXoZMjAEf11eW/UcXP2ynvI9mLKB1tGNsDRiJ
 P0dKFdg6QG6Mlw8xAhMajNdRJnuurJqXWTzt90lDeZnvtVKdufF27Skii7+877m8uM+b
 +JgpEysj9lwrWaNUoa5hmhRMx9BoQV9mucIwbiC2FWXXg+k4tWHr9+zUBkKQJwx7FF9B
 Fpv9AmhsGCbC2ge+RXUSTMGkdR2bHys/ZoHGRJf1wXNH7eyxxqcMGD9+JZc9RhsWKZbL
 GdVA==
X-Gm-Message-State: AFq9FYI/MC1xMC67A6t3uB2PpTp1IXeI5JZJhH0dkzj492xwsm/aXJ/w
 9m1CFBUE6ODpD5ve3twwDgA3s2P8iSVBztOhemWmVqsk/I/zEnDWBK56/ONbB7NsbC4FrFxUPoR
 G9EdpFDjSQrQBs/0SjJJguJjTgTLGCrk1owkXe5ln2w==
X-Gm-Gg: AYBFou3p3z4Tv4XJkZnKAlxJHxPGIAjMx46orWqowHLpLqXi1AnefPgyiBhq/aRhlY8
 yTqe6zwci1pMfSDnQtlxzHIKPLyWrxetvl+s5RZH6CRZbkT3DEa0sGiPCVSxrCPVRpaEIzCwTE+
 xAa0lKCOtD9fYrmObXfnP/3Cl4+rOwRgzniXpP2v7vt58zIbJyzKdlw3nqutFvsdYSs6vPa0Bgk
 OvvoLaGJwzCjQYosX6Z4rfHjnJPnmj3Xn/MvA+5T1/9EbhvHSRoHQDhhfH6aH8N+aJq5x3gjhUR
 avsM+HCQOWMMIVX4/vXVyIDCzzVrTZfyH+JuYXlF3SpxsKMB8NhqydHHMxsrV+vpC511BFY5VW8
 0tzVhcQe3ivRXJtmCgxqQ2WFu/wxhJ/g+BWLdgUPrA227ar+DRK/T1z1cCGdYT616wfXNVWbBfE
 Y49YCoTzsNvXWnkRSOkrEw
X-Received: by 2002:a05:690c:9517:b0:8b0:cc24:f7b8 with SMTP id
 00721157ae682-8b1b5ba8243mr32649757b3.69.1793282670125; Thu, 29 Oct 2026
 07:04:30 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261027120135.53048-1-mohamed@unpredictable.fr>
 <20261027120135.53048-6-mohamed@unpredictable.fr>
In-Reply-To: <20261027120135.53048-6-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2026 14:04:18 +0000
X-Gm-Features: AclHuK_TrYWo6XQkouv6VomuD4cP7uBtZoxw3HgBLjRLUwbZDjbUeC3zMuJrp_A
Message-ID: <CAFEAcA9y-AwrGSgeqhL04jFdSUmncNS-RBPmrjyzVi_Wwnn_yg@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] hvf: gic: sync the CPU interface during a vCPU
 reset
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Tue, 27 Oct 2026 at 12:01, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> When a vCPU reset happens, we should also
> reset the state of the GIC CPU interface.
>
> Otherwise, reboots might not work as expected
> during some circumstances.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> @@ -629,6 +640,7 @@ static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
>  static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      GICv3CPUState *c;
> +    run_on_cpu_data data;
>
>      c = env->gicv3state;
>      c->icc_pmr_el1 = 0;
> @@ -649,6 +661,9 @@ static void hvf_gicv3_icc_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>      c->icc_sre_el1 = 0x7;
>      memset(c->icc_apr, 0, sizeof(c->icc_apr));
>      memset(c->icc_igrpen, 0, sizeof(c->icc_igrpen));
> +
> +    data.host_ptr = env->gicv3state;
> +    run_on_cpu(env_cpu(env), hvf_gicv3_put_cpu, data);

This isn't safe to call here. run_on_cpu() has an extremely
nasty beartrap built in, which is that it will unlock the BQL
while it is waiting for the queued work to complete. The
code that calls these register reset functions doesn't
expect to have the BQL dropped underneath it, and there
might be various race conditions that happen if it does.

I think the existing use of run_on_cpu() in hvf_gicv3_put()
is also broken for a similar reason.

Put another way, run_on_cpu() is extremely hard to use
safely; I think you can only really use it if you're calling
it directly from code that was itself called with the BQL
initially not held, and which is therefore dealing with the
BQL directly and can be careful not to assume that state
that it looked at before the run_on_cpu() is still valid
after run_on_cpu() returns; and if you do use it like that
you probably want clear commentary warning about the
potential problems.

thanks
-- PMM

