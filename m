Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103AAC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZzn-0003Ea-3C; Tue, 29 Sep 2026 11:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBZzk-0003EE-Bu
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:43:53 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBZzZ-0000fG-E3
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:43:44 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d91ede8035so37018345ad.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790696619; x=1791301419; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9BFSr0MMPULdJAhx06wcX6IZ7Z15Rp7P2jwzsVUboSA=;
 b=OiDp53X4Yx1yU7/idD4g1ow9+a8MzyjYqT6S584cMRB5zCafLML+UXGJv6nAWxhhrq
 AOdjai84V8zQnTZfhpO9dCMoO8fqVHiO/hOXOeFM9tQsk6uWDs2+RcLIop8Dueo1McJ2
 Dj+O+UrW3MXXerDhZhTBdeWW6EC86JTkQKeQdC5BFzNkC0cUoBkMU7L5jTHaHIX64bLk
 a2UAwCP10V2rsdIAVTwdJb0PmhHsLs8VMVL4wa/5z0jtUMQhK/gZQK4fSJmnb8enpc8a
 NnCFAH9GUxmK9pQsmu7E4peV7UNS8gWIqvvdZPeQI3xxekGzmMBuQnSh9vMhWCpV6nWu
 jnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696619; x=1791301419;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BFSr0MMPULdJAhx06wcX6IZ7Z15Rp7P2jwzsVUboSA=;
 b=XUpzU4k/NCnIAUJqTPuSH2jLDiJ+GBoavNUP8X+Hrk0hGw/wpr3K2K1RNX9GEYtBB8
 BMeldUIhuU1IiLEos9EZ9bMCIkFvj+CLDnPUb3RCedqnWX2IVYVQZEIdW7ijzQ39/9fQ
 8l18OKPUe/JfLuk0MQ0DBanZeezutWMAJc/mhUWKHpp+u9HOjFZN5Lzi4YMeaVZuzVl8
 marUXLAmV06fn6ZezeWsTKS2/W9RUGn/kKXxydDb9oPH4UKGmHra1gVP5SfcoXdJQuep
 IctA9gWYdqd+TrDsYXclscqd7wDllACVrvPDY2F7u09G/52GPLqCJ441lqubImLED5s7
 rclw==
X-Gm-Message-State: AFq9FYKydJfQc8+/n2QxBJ1O5HXKPefzxUvjN3kMpKt8KJogie4rMtAo
 daZ0/kpkZKwhWFaihApDCiVGCyE5IV8AnPTpTZh/K7bP4k3BRyE58zMByYJwIfGF2xI=
X-Gm-Gg: AYBFou327p4022xWDbuz5wJT3anWORajEnld/X0ywVGNwic5JXitTauBCTkCe0Ho9w5
 6DiAiquUXPAajZZlGLnGe010MTSfTFFYJbS3Y8DseWup2FbbQgAV65Exez3M24P24yByzgqaK7z
 Z2X6u7lKXs6yoAUtZ5JpyBpKsjo+dxQ2YVHYVJF7iMnbH8zaWkxgOz16BegwH/Qs1KGIs2Fybnd
 zdaeUEUyDmHOOrn95WsRhfRNDbQTAHmRS9aWkZ3do7hG7FTj6XXumF1q9i63ucv41Gab8SgUNvI
 YfeJobPs1RCw4lf4FpW9YuZ8IPV7EhAaS2/4OD0P5YaSEWFEPqH4Q2XpStyj9VUhAfqd1EmBihq
 RHSolhN0KoMnAteEsFa3HI2n8VHTilj82BPk2hCrKfsnwOj+50BUSfyUizfBHGjcD50bRThdo03
 DM2Dc+DkNOF2rHUT19m5dgCCO1bcJGEQj2G6K1IGjO59t0nsfQMXCBeBMaVKayZzkDWmZ6xN5U7
 FskfoJjgkj5qtJ2ZS4Cpx8=
X-Received: by 2002:a17:902:ebc7:b0:2ca:e19c:97b with SMTP id
 d9443c01a7336-2df94901b8dmr111406495ad.5.1790696618859; 
 Tue, 29 Sep 2026 08:43:38 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df91458e3bsm59339785ad.68.2026.09.29.08.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:43:38 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:43:35 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 02/11] tcg/riscv64: Rename sb-type to b-type format
Message-ID: <arvcjJ_WhYJyFSiN@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=max.chou@sifive.com; helo=mail-pj2-x10.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-09-13 14:08, Richard Henderson wrote:
> The current riscv documentation calls this b-type.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

