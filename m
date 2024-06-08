Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DAF7C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG1xH-0002Jq-Lv; Sat, 08 Jun 2024 15:42:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1xF-0002JH-CG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:42:21 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1xD-0008CV-Rp
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:42:21 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6ce533b6409so2417758a12.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717875738; x=1718480538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KD8gn/JiY8FjkVHvsahMem5Zcr+4iZEyd1nFOXXUbto=;
 b=wPLLn2FsewT9lYrnR7aJ11e7zoLt9nPm7NWcrRxcF/NVLnj5skSTc9rVH6X7z6yq35
 27jtSxbkmKvm7lOywmXOPPLNTs3S8KD+O/4L7FAjNbR5fZylmGM45oKT87axfS242fe/
 mxThkFlqIyxMLcuoiMYl2qBTkBBxv5RI6UiSqp71y0KSxTjHSqjhabZVrxd8oNv6vC99
 8NVpIsaBFhuC4n2TW8x79Hv8WIiO7FefupTdu5qnzL1z7T5odFh3HVm0JvHk0bRzJqub
 WInuAA516ZpeJAZe+XWsXjR8AaLDl/RBp9viY28s0dD2oL1WYFdkqB6MhNnXuxAGE5wd
 rVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717875738; x=1718480538;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KD8gn/JiY8FjkVHvsahMem5Zcr+4iZEyd1nFOXXUbto=;
 b=aO2n13EZXywKivFjkPtORLmXYNvVi/D9y5Lk0/AlSAGSUp/gm/EAQXFntlcZMizR5G
 MCPeWsjvK29MZiPmz4auLbDeakbGJHGHtoD5WoEcRFYSOgYJAuWvBfRiJAUCikRmxBIY
 qeSztG60xWUNyfAfjbQ9hwcALEWncShJGZ/aYUXBImpcDIhiVQXBgP57wJUxkDylPHJI
 zB2TPdsQWdN/4tNmnzVQaSBTz0BBO6CdDQp7ByXFr2uXNvbiog9XOEx92CN4tIWO/cYz
 Wj5wCqwVl+j5eZ2/3+a60oZ0VCLOJ5TvptDBxQ7lqNrzzWsBuMYhbZqnFcbgIeFGAbo7
 Te9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTJgOfF6rJ3Hl0jinV8UapYAtU+CvNIp4QR44ZP+0U+LqhxID9HeZ6PIM3h04p7CYw3JEyrd3ThoHA0kYeGAS9LrWGhA=
X-Gm-Message-State: AOJu0YzUBXR6CD2UlijQj6afoAUApZmW1M+WRkt5QVOtXBz4WYQEFJoG
 qjnSing3lnMOwwlOyVhuh3rP092dMGNFE6sMPloIH9EEN+oaA5kjXeKvzimrEbo=
X-Google-Smtp-Source: AGHT+IG/k4Z+mgORS1V8ByIrqzWwX5TTyTGxq9KAm0V0KP0IJnNv/WuO6Ig7Dy74OxoYu8JwjMYYbw==
X-Received: by 2002:a17:902:6549:b0:1f2:fd49:9fcc with SMTP id
 d9443c01a7336-1f6d02f4f38mr58702235ad.34.1717875738127; 
 Sat, 08 Jun 2024 12:42:18 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f705013129sm1335815ad.54.2024.06.08.12.42.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:42:17 -0700 (PDT)
Message-ID: <d1e604ba-7f7c-436f-bf1b-4e53bed4d5ff@linaro.org>
Date: Sat, 8 Jun 2024 12:42:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/25] target/i386: adapt gen_shift_count for SHLD/SHRD
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-17-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-17-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> SHLD/SHRD can have 3 register operands - s->T0, s->T1 and either
> 1 or CL - and therefore decode->op[2] is taken by the low part
> of the register being shifted.  Pass X86_OP_* to gen_shift_count
> from its current callers and hardcode cpu_regs[R_ECX] as the
> shift count.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/emit.c.inc | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

