Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F75BC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdar-0001JS-Ix; Fri, 07 Mar 2025 14:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdaq-0001HW-F7
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:42:48 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqdao-0001Ap-Qi
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:42:48 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-224019ad9edso56263815ad.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741376565; x=1741981365; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gmrUJZZpqfd6XxtNYtadhcNdueLwYlaYXGK3tP/sofA=;
 b=w/8drALUE+T24xGqDiO2KrRBOGl/5AaNokTRZBoloSrSydTuzO0O8afMCs0cnqLm8u
 ErZI5hX9OThPDk4F+PlZ6OKvfl54amnmd30knCc6ZtpoPmTWdkVBgM0xTO9cNFLjzlVQ
 H4nqvkMrGr/RRTvmk+zuy3cqmQHVoF0ZNYkfWuuvYAhhdOfSrMN+oolqHpS+Hamhbxfm
 AJfuzsQZMCMmaZhGLwR2M8N2cfSrsbSpk8xhbX7zyqQGUsbgNCKCKxB7ZTZBEtxsmqIa
 np7gxNo0B2pjpT5g3f2zR+eRf5NrXLpcNpv+7bILBQOwmIC9cIwJo39TIilOnfZcXJeI
 Idpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741376565; x=1741981365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmrUJZZpqfd6XxtNYtadhcNdueLwYlaYXGK3tP/sofA=;
 b=MEsBUW7Rm75bm0j7EaTbv1LDHUraAEm3o3tHeQ2GbFcTxHsRKKH6D/0WivFvB4Fy/i
 ischynRTx+bAmjnOLzvLOq32j2qXFRIiThmN4Di+OofqyaSNpsZVpRZgG4GyKHroAtr2
 R+E30bzD6ZRHtfbUeUXXz+SDWoRu0k0s9jzoEWxRQmOhfzs3tzgBU/NnfGT2EePp/Vb8
 b9Yeor772R120iHzUfgto0w/4QJ9rg8mGaeHpEDZeeafvrfVWi2LAtFtrHVYknfrXSbU
 Ltc+0uxACShkqlWjEUf2Kia22gcIHVjjDYcQZG1Y+P+iyghcqwbK0pgTHrblLSyDd5Bb
 tZIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0HrwWzB66C/7PSUsuAwx9VQFmkkt1JTMB2DtNg9EZufXDqehUdQ8z4Ke34sWXRnyIvthcYhgpaeuD@nongnu.org
X-Gm-Message-State: AOJu0YxJWvtcZ/zwSi2sxyWoa7RGLBdJh7H5hNbDTdD+BSOe4vSm+B8c
 y8j2a46Njf65ApjKIIc6INpiH4U2wE55Vmx650siXX1cW6tKp7iTXremhj8CQhLJdSGINfNmv/2
 E
X-Gm-Gg: ASbGncuR/JtJA/SmqytN+5MA//OPlKeMR6WfEGGszBFc9fjCMkg8dT4BbyPqC/jbMw7
 yEfXRal2U2gRUtX0dWCZWdBYLI42d5NPDRiU7hc2YyxpQ8oQAuleiuksgQdlT5pdBSw/emwjEqS
 4q+u8piaR5V3Rx5KiE9H2AtTaye9jk5eY5CAGNen3ZtVaJKFq6Aa9L79ns2FEgi6986OSRrxiFh
 aaS4kPkGHmv3AAH7EnkOLK2jyeI48Uh8gJ9B6igDSf6l7QqUnjuwy3sARUwld4lc5M2uL04SBqI
 a5CWQqHt3DcIYUU2AblHyDMVL2BYyckAJAkmlr/gSDQN04NPdQAGxpth8Y5C6E0Ohl3jNvrf0qd
 kSD5b+YFw
X-Google-Smtp-Source: AGHT+IEOhzzSn7MnwkgXE/4T6rS7U2QJEMGyn9qyZizt91dQ01j9Id9kJqSyf5HWiyQuT0gGpHkS1w==
X-Received: by 2002:a17:902:ea0c:b0:21f:b483:2ad5 with SMTP id
 d9443c01a7336-2242888b35dmr63415955ad.20.1741376565452; 
 Fri, 07 Mar 2025 11:42:45 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91b8asm33982565ad.171.2025.03.07.11.42.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:42:45 -0800 (PST)
Message-ID: <cde0c2d8-ddf1-4860-960a-1cb1b8f64ab5@linaro.org>
Date: Fri, 7 Mar 2025 11:42:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/14] hw/vfio: Compile display.c once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250307180337.14811-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 3/7/25 10:03, Philippe Mathieu-Daudé wrote:
> display.c doesn't rely on target specific definitions,
> move it to system_ss[] to build it once.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/meson.build | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

