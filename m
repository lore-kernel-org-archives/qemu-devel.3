Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F2FCCD194
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 16:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v94nI-0004oz-0L; Wed, 15 Oct 2025 12:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94nG-0004oc-9t
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:56:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v94nA-0002OH-5Y
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 12:56:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so4969833f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760547354; x=1761152154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3blqevTUMY+PyitpbFBhgo4hWwUVIj/OwUUeGP3sUM=;
 b=eGL3Jg3W6+iM2HHinKkqI/giE+VJ5mdSbUb/hHe9n7o91a5RL/PbADTqfz0kH8ATQV
 HaXUX9DkvYlpi3TDgTPDlZgcwz6gAwrRUigArbVTGrGfrHzcRbz7N+bZh2WoLpL8Logc
 jLGfwkGjp4blKlUHxMUCXTYnPpp5LQD47UNpfUsx4bqtFr/dAjpV0C5y8YnEPHkukbL6
 kzcpO/dsY3xKo2Nb835OrtWaK7Z0KdTZIXuaXnn7as6kIC/woAlhNIZJMQSgRHUB/eq1
 C7carJWxA/OsQ5Vj8oPaKGuNhPPG4/eZmx5Te+692LXFFKTOkwoFR1P/kWy6BoYFAyW4
 ym0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760547354; x=1761152154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3blqevTUMY+PyitpbFBhgo4hWwUVIj/OwUUeGP3sUM=;
 b=IqCVBhxh5/ylWsBaRtOHE28v55XL6SN/xycCQ87UHQCFQnABASOTnT4TwHbiETj331
 p51e6cKymV+NxWG6lKc7d4ABMa6t6DhRkZJTEp/+lyO5G9Ns9MlMMLSy2KwlnXPAiL4U
 fETmA9+7FdEtNvuttQXkgHtXAYlVghnPCGtAZDaB/RKU5sFoRiUDkhcHr/luwBfZtEqD
 l0Eja1iakjZlH0RUC2K9oL3KBbdKzg21aD0WRH7dPRuS+l/o0O5WQEgexW+NC6k5pdNP
 +K16f3CPPieVJdXDKswxwvR9f58JwULHo+0Rvw6oNDitNHlScL2eh3KUYC9RZKioVo8n
 mcTg==
X-Gm-Message-State: AOJu0Yzu0kU9K5mwGPfP6Q+VLLrTJmkmcUmJTPLH8oFfkXYbyqvGaSVj
 Va+W6mSfjcA0vcgbElQpQYkevhFNsWluXtKyAu1e+dJzEM6VrYdS0TiUU+ShCjK69A1ngmIzuHa
 swnoWXsWfig==
X-Gm-Gg: ASbGnctO3U1LhX1Rg2BDt/BvHAqy7B/njLI8z/SuYES22a8XCSQ7lEwzQbqpi5dVw4z
 6f8y7rxjPMv9RWmvsr2t7NAsbl9k94eTTuahH78FgxkE4omGGlRh1rVV4zw6buDnhIUJqS6fiz1
 dQEfPSEyglIOoaLR5MO0CS2FExgb59hWAf4rsR31we1iSlP5C9Bo8Pp5bCvq1cm4JclBPDLeCex
 1+Tnq35u/TorMi3n3GKstu/1Tzpu2l8KbHZ+R3TIb6AOwp/Ei4i1aKhpxLLH/YoLW07j5IjKV3l
 btxjlDCIAJEO3HNnuf8l9VVGLNHzvc41ZvgFAOS2t+Tgrz1ePIefrksDbhoJuHpwTZxA16WliKc
 cd6kVw84F8hyvujI/HEPfvGVYTcRqYDemHbILOF0UM28vvdUM/4MR8Tx0riHyZztveJmPNfinh+
 c/LY8GM06T7QgMtUmjCAwUm1I=
X-Google-Smtp-Source: AGHT+IFoCX6AO+nOOMZepXenilz5V+4kYhDBhHqOEGHWBXLAHTPxDVTDPLfaUSms7MCwPt4kZzzFGg==
X-Received: by 2002:a05:6000:2301:b0:425:72cd:8364 with SMTP id
 ffacd0b85a97d-4266e8e1afamr20010298f8f.53.1760547353767; 
 Wed, 15 Oct 2025 09:55:53 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57d49bsm31514917f8f.10.2025.10.15.09.55.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 09:55:53 -0700 (PDT)
Message-ID: <3d719fc0-426b-483b-b72a-ef205b1c22d0@linaro.org>
Date: Wed, 15 Oct 2025 18:55:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] target/tricore: Remove all uses of target_ulong
 types
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20251010052141.42460-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251010052141.42460-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/10/25 07:21, Philippe Mathieu-Daudé wrote:
> Remove incorrect target_ulong uses, then for the rest
> mechanically convert:
> 
>   - target_ulong -> uint32_t
>   - TCGv -> TCGv_i32
>   - tcg_temp_new() -> tcg_temp_new_i32()
> 
> Based-on: <20251010031745.37528-1-philmd@linaro.org>
> 
> Philippe Mathieu-Daudé (12):
>    target/tricore: Remove target_ulong use in gen_goto_tb()
>    target/tricore: Replace target_ulong -> vaddr with tlb_fill() callees
>    target/tricore: Remove target_ulong use in translate_insn() handler
>    target/tricore: Remove target_ulong use in gen_addi_d()
>    target/tricore: Remove unnecessary cast to target_ulong
>    target/tricore: Replace target_ulong -> uint32_t in op_helper.c
>    target/tricore: Declare registers as TCGv_i32
>    target/tricore: Inline tcg_gen_ld32u_tl()
>    target/tricore: Expand TCG helpers for 32-bit target
>    target/tricore: Pass DisasContext as first argument
>    target/tricore: Un-inline various helpers
>    target/tricore: Expand TCGv type for 32-bit target

Series queued, thanks.

