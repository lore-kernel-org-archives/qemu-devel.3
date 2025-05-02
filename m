Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB5FC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 12:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uApvy-00013F-Go; Fri, 02 May 2025 08:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApvw-00010Q-8v
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:56:04 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uApvu-0001Oy-FK
 for qemu-devel@nongnu.org; Fri, 02 May 2025 08:56:04 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-7082ad1355bso15491827b3.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 05:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746190561; x=1746795361; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7mXFSvhaukdJK+iayCwvss7NQ9GSRN8lcF0pHMoDFDc=;
 b=Fw5xpYl1EpK3tKpykaheWFOVHJEDoIzvM2y9fmaZKcTPi3ZVCtyOYGLnnL74nQy3Xy
 8LM3duW35TJXiojrCTk+rEutMl+DQk8gF30tC/POdhU0na6lS4kUyA4KM5Ld1cVu1PKy
 SZAMXrEP/mAY3mbKK3T5GhUmSmEl1ttnniSMgyRqpy7LB+92BYzkM7nEtw8O7v8nJLP2
 Jamw0Z55KHVM7YS3s3VVNreO27MILXViJ9YAMMHsTmRogvjnCxj9/lzo9HA+WIv1595m
 AL46aR7qNx5ODQZzggn5Ck7l7pgjJSB+fXG86e7VCg/CtQzRr8I1pd0GN5US9o69HPTy
 2mMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746190561; x=1746795361;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mXFSvhaukdJK+iayCwvss7NQ9GSRN8lcF0pHMoDFDc=;
 b=YZPGh25el9g/60If3Nf7N1QaKeNPWd0uMf5J4TXKFOxbcwS0D1Sn7BXZMzKbAZDF3g
 FrghdEWc3SPjqS+MN76fD1GqhWqxIupF9xUXWdS7nbjEh9dnQkoRWV1CPE9Bh+9P+bUG
 wOzMaT7stH/G6kHTCxzlQm3oeu5qBA7k7ldUoenOEhwkOO2Cc+f6H3Di873OIDwbIt00
 LlGkTqs36wzqUtmxKq37gtbxKTd37GfA8R0SJrMjwY9eFDxxnGGIs/WXtpPhuNQmO1YB
 pDf4ujSi2XIR2hqAVpS7khOR7tji8TJHDkRpIM21Z+bSpYLU9Q3cA0aGAxfWYoHram0g
 Xzpw==
X-Gm-Message-State: AOJu0YzSOkkzdOVuew0PlYU7vliLl6pAsVjyWkghBDG0ypXNuC6LAyf5
 TOukhbYfBcwRS9YHbL+HBQc83pZ+YoYjabq08119uL7iWQAejgkScgosVbZpNVCcjCXKP+NnVu5
 B72raRvY6nZUHB7iiE+a2/hKQM1dEqrL36yU6eg==
X-Gm-Gg: ASbGncu3ImIaBoemzp7kfwMJMVVilBUS2u0idMy4VNvBeKFDzBcyeD1UwRDn7q59AXy
 BKJ7LEGzq6iRrqtbxaHaTvru0RU5GySzfCMnwn1YxW16HCWhWyiNTrXgy5iQhk4f6mjJNmNO1dL
 bEq1wsY8A8Aobje3mFHLiyKmE=
X-Google-Smtp-Source: AGHT+IH/VWx+ZkU4B7yFZ+VYwLqZZgxbg/rui5KRZGFi6vhrl/cEBh0g8HPNlm6SPDuOsWOMidtf8k229/UNftraBiw=
X-Received: by 2002:a81:d849:0:b0:6fe:b88e:4d94 with SMTP id
 00721157ae682-708cf167f41mr33323397b3.19.1746190561116; Fri, 02 May 2025
 05:56:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250402135229.28143-1-mads@ynddal.dk>
 <20250402135229.28143-3-mads@ynddal.dk>
In-Reply-To: <20250402135229.28143-3-mads@ynddal.dk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 May 2025 13:55:48 +0100
X-Gm-Features: ATxdqUFcZ2V1VvpUxM0hFFg8rlhOByQLMDwlT-mOQ6SAD6rycE17-XVo_jBjQO4
Message-ID: <CAFEAcA8Hgmt_ph1Sv1Sbhvf+CnXRrw1jwE67_uJKFt2AqRFZng@mail.gmail.com>
Subject: Re: [PATCH 2/2] hvf: only update sysreg from owning thread
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <m.ynddal@samsung.com>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2 Apr 2025 at 14:52, Mads Ynddal <mads@ynddal.dk> wrote:
>
> From: Mads Ynddal <m.ynddal@samsung.com>
>
> hv_vcpu_set_sys_reg should only be called from the owning thread of the
> vCPU, so to avoid crashes, the call to hvf_update_guest_debug is
> dispatched to the individual threads.
>
> Tested-by: Daniel Gomez <da.gomez@samsung.com>
> Signed-off-by: Mads Ynddal <m.ynddal@samsung.com>
> ---
>  accel/hvf/hvf-all.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index d404e01ade..3fc65d6b23 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -58,8 +58,13 @@ int hvf_sw_breakpoints_active(CPUState *cpu)
>      return !QTAILQ_EMPTY(&hvf_state->hvf_sw_breakpoints);
>  }
>
> -int hvf_update_guest_debug(CPUState *cpu)
> +static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
>  {
>      hvf_arch_update_guest_debug(cpu);
> +}
> +
> +int hvf_update_guest_debug(CPUState *cpu)
> +{
> +    run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
>      return 0;
>  }

run_on_cpu() implicitly drops the BQL, so it is a potential
really nasty footgun in this kind of situation where callers
to update_guest_debug aren't expecting the BQL to be dropped
on them. But we already use run_on_cpu() in the KVM equivalent
kvm_update_guest_debug(), so presumably it's also OK here...

-- PMM

