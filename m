Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783B5EA8107
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmhb-00065F-Bf; Tue, 10 Feb 2026 07:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpmfY-0002Hd-61
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:16:42 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vpmfW-0000XH-G0
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:16:39 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2a963f49234so12955065ad.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 04:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770725792; x=1771330592; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rmdejh5m+b7G0X7nw7oeKKLpU/m4Eh0ZpMrSHBHCNRU=;
 b=GemTEUxp05+X6KrNuD+2ErOP/wa8tU3Wb9f0/nB86VTRC/Dlm1AtSrMPBr0Qf4f2qD
 oxMMazGzZkL1Zu9Hd39Mdk3MZcs7m55bbqQyFObVjkIhaVGqtt/CPteqytYkVoen6Ima
 DqGjWE3OuuquDboAoYHJ3xI1SR6sAEb27VMZ/kM/F25m6IWLspUsOAUw2579fEq5kpVk
 WP9B+mr3AtyK05V0/5FN+hi+TXG6I1YQ/uOkaP3Jp6OB7zhltE7LSXt84XiJ0ulE1xzf
 reKOg/Kig0vRq5O843rYPGLJ+TCt64QXyN3HJqvDSSxmHdSWJXpjE326zH/X1FaLwE5u
 3jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770725792; x=1771330592;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rmdejh5m+b7G0X7nw7oeKKLpU/m4Eh0ZpMrSHBHCNRU=;
 b=DZJUd5gVcLu7EScreo6qYiJgEtftbm9gt2H3WIA4W5Zbw1e4yFd78+HWMDbHrk8cpF
 Q35emkoqJaiweBqbx5VFFckxk+xBd+/7fqqac6a661r60I5NUPNQkIon3sy8NAHhMWsg
 o4fp09NRLL34f3ofvFcWZ5wMM5LeePAWQHgHZ4lV7IAO9Ulobc168q075nsqctpusnly
 kUB+SUcZgafb0dZr4GevjPpsAYAyYY1zqHCvjcvZvVrEwTHCuzr3Afa5hOmRO69WDRAP
 0OkSyv/7O+/GZ+p7KUxZgkUyJyWp5JGc8aQMoUrMcRdfn+xq1GiP199GqFiDo/FOKLfN
 ck+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/SWn+LORLa9NOynZ4ZhBP2N5qrLrSnd/ZFVxIhYITCYpuqy3t9K2RU2AUJUpAmRezSCmypK2jzRzM@nongnu.org
X-Gm-Message-State: AOJu0YwPwz/y+7ms7IP3usWDM2VECC55WW0T2DlLpI5Uw9Wb3IKMIuhA
 mNJ1Tk7HmN+k0PC7ln1K7j69UOm+Eq/H/X9HD7zxCLSCk2j4fEDQcWT+Cy7WD6LFTHw=
X-Gm-Gg: AZuq6aK75z3vigfIRbrXkbndh0hIKe7Skw18g70wLmE6wHMdJSxbS3VGPx7KqQWmcs5
 /a28o1kpxwwtr7+i4QsvkfO8MJSUCHyu54u0CDLYn4DEic6zY37z005ZQbjZw2rzpjtxvSy6Cob
 iWrhJQqm3wmuC9sfMADM2YRQp3aM14PAibhK4mDs0cCEsUOtUIHsaVcEJ1CMBBihRgHVWw5Vhpj
 QA21WPPPXAgCceE8BqmAQlx4XzWKfForkM5TeR7KaNC4nyMsv7Ushr8KsWna9B7OZzo/NxtogCl
 DbiqtWLayMxUBHnNxzxuTDop9yeHoozS3NJrnKIES+/Nsq8oQid9LCA+2mWanpDUUwbjCw7UsLd
 nu82fciF8GgCA+7gGU3RvcMj30J5Yujf1uVZBfbobYz4JJXNOoVl8wqR77Y3n8bzwDSOgfq373C
 Go196vMGiuJlWPdtv5FRoE2tTOurdfJ9PHMZMrfxMUxGBDRE7G7kgFj6PE4XhR4yGcd+91SQqyz
 48HdXCoDBa2RF/lCtEALw==
X-Received: by 2002:a17:902:dacd:b0:2a0:b467:a7cf with SMTP id
 d9443c01a7336-2ab100b9a8dmr24128775ad.0.1770725792283; 
 Tue, 10 Feb 2026 04:16:32 -0800 (PST)
Received: from ?IPV6:2001:8003:e109:dd00:2d9:8d52:afad:d0d6?
 ([2001:8003:e109:dd00:2d9:8d52:afad:d0d6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a951a63686sm131177735ad.14.2026.02.10.04.16.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Feb 2026 04:16:31 -0800 (PST)
Message-ID: <6cf4aa8f-5f1b-4145-88d3-da5abfa978ab@linaro.org>
Date: Tue, 10 Feb 2026 22:16:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/arm: implement FEAT_E2H0
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
References: <20260205210231.888199-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260205210231.888199-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/6/26 07:02, Alex Bennée wrote:
> @@ -3817,10 +3821,15 @@ static void do_hcr_write(CPUARMState *env, uint64_t value, uint64_t valid_mask)
>       /* Clear RES0 bits.  */
>       value &= valid_mask;
>   
> -    /* RW is RAO/WI if EL1 is AArch64 only */
> -    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
> -        !cpu_isar_feature(aa64_aa32_el1, cpu)) {
> -        value |= HCR_RW;
> +    if (arm_feature(env, ARM_FEATURE_AARCH64)) {
> +        /* RW is RAO/WI if EL1 is AArch64 only */
> +        if (!cpu_isar_feature(aa64_aa32_el1, cpu)) {
> +            value |= HCR_RW;
> +        }
> +        /* Strictly E2H is RES1 unless FEAT_E2H0 relaxes the requirement */
> +        if (!cpu_isar_feature(aa64_e2h0, cpu)) {
> +            value |= HCR_E2H;
> +        }
>       }

Reset value of hcr_el2 should have E2H set too.
I think you want something like cpacr_reset().


r~


