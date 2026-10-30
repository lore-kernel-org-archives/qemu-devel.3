Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D8606A337
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LIh30+rn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMjz4-0006hY-NK; Fri, 30 Oct 2026 06:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjz2-0006gc-C1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:37:16 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMjz0-0006mb-Uj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 06:37:16 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8b0db268bd8so3498997b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 03:37:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793356634; cv=none;
 d=google.com; s=arc-20260327;
 b=Z0a5Ir3ln/RI0UzgIfwTME0IBwHokcukQgqt39WAZVDTS6nWqfMpEQGda7rt15dSU8
 PnxAhQ+zVUcYJAOPcb1Q8uN7FpE1Ukle4vZUryGqNZibvCW+vAYu2Zexumnn4SY/SVcz
 AKoxtLIsZeWGcmRZqYnEMXrAQ/NNdRtdmuu5YdS+rQkdQ/Ap8pR7s/sWRNANKpuZdW5a
 WUgNlJM9ynk2Tq7mdpkJHJWYrfbBpP/eeIHJBxVg+lWmveBm+Us8tq7Lt1UQXJQiKB36
 uKyAHP+k9E7NIm6A7m6SUR3iDS2DFnH4wWyE/88GBeFu+xm9X5RXIDIVEGCRshGCqNx+
 T1sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DSvv5DYNLX5eXq0aNrVBTRfpLWIbkD/Q13mszp4qvSo=;
 fh=tcCFuRw/214RKLiO4A0ROR9RY3msDExzOP9GfyEGSL4=;
 b=NTha8Q4tlSjsLS/XzxDCf/ZIjOyCpWGEk8g/RpmOEOOaHLpkrQt7YoRPV8F9o8xPLH
 iivr5C3dZPzFAeq/NzpwHDbI1/Lw5vEEfQqxf6WkzQJGZfXZkv98xd75JjqkEj/bQwYS
 qSHMwMyrbsZUWwrd92MHAb/tg11MLUr3fqV2fQ4OLYXz6N8E4QVE5QfqD1JvO9nK4e4p
 1kR9BFothATufqyn7WiXlMHJkVeKGz4FtPPevlQXCN3XwMWzDeehzVEjvp/fETg/0NLY
 qPbR0KwQ65mvYK4cB1dtZW+WcOxXE6r6DTcjoTYnOSs9X/yu+DDwfGbhp3foZC8gv0pY
 lX+Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793356634; x=1793961434; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DSvv5DYNLX5eXq0aNrVBTRfpLWIbkD/Q13mszp4qvSo=;
 b=LIh30+rnMc2InCmeiHLqxYbBfk7klqCkxyP3ev30fOsarbppHoScPCdwXVh0kM0Yzh
 F50p1tsEY+mx1tn24V5itssep8YIYmz6Juy5BxdDAukHLC1+LQThFePHVw6ZGH81ndUy
 QVoqkIvW+gzE3d8FbPdxurCj/Y3xSaJhQxefqzBQgaMqf05muOcMsQvKqMC4Gf0K1S2f
 wuXsjy5YXTjRpFM3ML2b9jKH7dTaiO0S0PMSDjiLZJvhGaNnw7/e3qyamfrGflrr6OsA
 SfOx7DMhm5Rw1BRxKDMdeG0mh75WKLWSHVGnMQdMuh9aPCMrTeSkv8TwdQhMLpkDl+2y
 70MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356634; x=1793961434;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DSvv5DYNLX5eXq0aNrVBTRfpLWIbkD/Q13mszp4qvSo=;
 b=kXmxgX89PYDAT8vrQ56YQ1FSJ5TuNwcekwPdIc0pCIlRFj1xZkL+MxK0fCchM2vos3
 lmXdyr/tS/jpvZalYcJHyGhJ7YluwNbMVStBAdGjdY38+aSZNnqlBLv/GtmiPZeslqlD
 f8G9H2IHhb7uKSL37lCJS7XM6FznGppBSyoQd3sPs34uYxS8XkZKFxKpLWr79muCvIze
 2WhvIIRspIvwTyxBfuPLQ3sSZgu2B6jxOPSmuC1Fg+HDbA2ikWEl9dlmubObghqtmFx+
 sxe/32KcBBPADCfj4+qLkOIZGA4ntBcjcxew9YDANUdTtyRSZRjVdkTOkBHFCOxgOTp8
 Jy0w==
X-Forwarded-Encrypted: i=1;
 AKwUvByAcJTNTlxLVLqyk6OzhBQBiMTj8zvMi1fGdtryP6X/+dupJgFs9FmVkEsn7xS5BHe6fME9BgxnMRQG@nongnu.org
X-Gm-Message-State: AFq9FYKN9r8iwUXD9954UvqTbTQZdCXprRXiVrDoMU6QS9xabjxm6ukg
 gBmYW0yfeE/WR7TLVVMCUOwgnr1MVSalH1+Yq2z62c3SW3Dq5aqul7tPyRsR3Q96+j+fgC3In7A
 7rilRMQ3SyPaVRLFa+9zWCKZF3PwGJ/ltP5AfAYbTEg==
X-Gm-Gg: AYBFou2kFePZJnThhpySjG2/xQQ5u7ZH4WfmDF+H2xq7NbJ1/ZzqIsYanjqlMFrgxDv
 CGmICo6q+ZUf8wg0mmSkgslGqNfUxRjNsu4jPOMsTJiTCBTNR9GSozU7oKxB3sGuesm5vywkfX7
 3XjcbIZKoKnHDPP3q20pYpseYoLDdr+Zx+1uoydRaEdYClV9g4zTdT3Ef149zdraRrNZkEGTv7Y
 Ot7YrtarseFtiFcTvqSMvRq2o8QZ2PwXHO77E0TldJlAG76VwRYVanZ8dZkMj+roy6kXfF3r13J
 P0H+7eS8LPTU8vfmXLsS4OvE873sQ3JUJa9Z5wHexi2Cb+ZgqRe7OQvSuF+Ag49J6UFn62+M5Nu
 Gac7LeYDOBhVaS5ajxj+lyTzj0kI9iYOfaPyr2K1MWOuh6EUda3nWHrIUPVWfPoOfCusfZBeRIv
 ADWsAknodQ2XJDuTqVDJpVk4T8auvZr7qCa7DNQyi+fvk=
X-Received: by 2002:a05:690c:6612:b0:8b1:368b:391f with SMTP id
 00721157ae682-8b2b67c08f1mr10761567b3.61.1793356633505; Fri, 30 Oct 2026
 03:37:13 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030072956.402425-1-eric.auger@redhat.com>
 <20261030072956.402425-11-eric.auger@redhat.com>
In-Reply-To: <20261030072956.402425-11-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 10:37:01 +0000
X-Gm-Features: AclHuK-wXxJkaGcuhuFPzduFoH5z441AXeGtKwHLY2uGWjmgyKdaehNKKFRjwuI
Message-ID: <CAFEAcA8teCWU1F3_xw9biUNPiSaEU66U1qMvfCFF5+e8OhaCpA@mail.gmail.com>
Subject: Re: [PATCH v3 for-11.2 10/10] target/arm/kvm: Pass an error handle to
 kvm_arm_create_scratch_host_vcpu
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com, 
 mbawa@redhat.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 07:31, Eric Auger <eric.auger@redhat.com> wrote:
>
> This allows to report a precise error message if any error occurs.
>
> In arm_gic_cap_kvm_probe() call path we just pass a NULL error handle
> because we don't care about the failure, reverting to emulated
> versions.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

> @@ -527,15 +537,14 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>  void kvm_arm_set_cpu_features_from_host(ARMCPU *cpu)
>  {
>      CPUARMState *env = &cpu->env;
> -    static bool probe_ok;
> +    static Error *probe_err;

I'm not a fan of this static variable. I'd prefer if we put the Error*
into the ARMHostCPUFeatures struct.

-- PMM

