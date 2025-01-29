Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7BFC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC3j-0006jz-PT; Wed, 29 Jan 2025 12:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC3h-0006jU-4v
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:41:01 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC3f-0003sv-Nu
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:41:00 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4361815b96cso49459285e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172458; x=1738777258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v4L1zDpRevhGiXMBWIpwJFLmHaslcj+FLKXjeT5c2+M=;
 b=dyOCl+pnZdOoaKjzJGmI3k4jYzHfUKEgsI1dxQvTyeuWduolJerzz8K1WfBVFO0L2G
 5se1GShFdc1cY01cBpvJT81i7fmPB42JyzL8kcVDpH9QQ4JlEwDIJw0t9qcz7GySy5w0
 t3Sub41/I19568HpMGku4ffdMqaO2KxOw8LR+Ve33FONdJyN3KYVFXL2Lsn5sLql2cpt
 BTqParPS9gFCTOkFrkCVSJWRlokrdA25A6vNWoaPKQRJ0j4RqjVHQD3oYM/mob7jo7zH
 UV/sab3V5DWNecbvt8XfrHC3mARZe0CNz3fDiolVklrRqz8Y2AeAzj6mWFY/UmNjgvkW
 SFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172458; x=1738777258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v4L1zDpRevhGiXMBWIpwJFLmHaslcj+FLKXjeT5c2+M=;
 b=OdzQbgwnrFB7ezzPmvx9xfwc7CxNSx5RddlYEzPw0pylkh7JuypkyQYC9NnCeHIOoT
 2RJCa1gnb+4+85DAF8p0VYGSMHJjIKN/7DjEz8MyYckMcs8/aTfaEGiZe/byrvAnImZi
 6E7GXwO/ZwGR0woWOou6BJb5j3xMwAEaL1lGJe4p35rDUepSkiL9FtOSEKzhf+zQAiXt
 wtZQehBn45IaTByLixG0RYmFOZHej6sBKofcdWC2Z8Nd1HA8Zwtez12vTnbdyp5fBXga
 P4o0IEZ17vdSIUFt8ylPJApt4aAWQIaRQMSDk9j6pL5MyfEVveDm38Fv4ClmheDot7hG
 ovWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKJO87GQ4HsBLlsgYFakV2ssGbLqLwEi3E8xyz273h2EjLCvwO7YjLXRm3ohi2PBF1Y084fa06mElq@nongnu.org
X-Gm-Message-State: AOJu0YyLC3+67fj0MqNcLccQ0gyvn9kUcz8GWMROE4AALBBKq7sIpVzh
 RXosqv8qAQmrVwZtVcDEbT8r2AffDMYAkptlTKVRtk95Zr7uZoBsg7IcDW21GZMYzrrBkgBHdbw
 cOAc=
X-Gm-Gg: ASbGncvr7/41KQEjvV/VRrRBRp/JD+TZH/9rqwg8to5UpQu0mstgoCMG6Y1F6HY37Dz
 BfvhVKfNiPiOF+InUfFWPLQ/KBQ/v4VWlfa1cyEQWw5r3qTuNvVanmpnxKjbqsXGQVO2OPXb8m8
 Ue5FiQQDBzjPWXcyZIzkHi0/55qtWeOpB8LjpozY8lp5fM7LD3Tmm2yyNGYHZBaDCbeO0+hV6sa
 98yBfBdiKMfnYiPlFT8hlHnb+WScDv6DIycCE3rL4nEGgM/27QGQde9HyaHnJL01fnMKoj1iubm
 6Bd6uLTiyrgcclmiUeDValE2na4SD6GvZpGz/cZLkyqeJzsBC0r3ubAn2Xo=
X-Google-Smtp-Source: AGHT+IEKMem0Z/XorePdx9sifwHl4JNMY0knImx0t2MK4ERmYEObX9pQy9BTAlEo6HHRr+qJm37OYQ==
X-Received: by 2002:a05:600c:501e:b0:434:9e46:5bc with SMTP id
 5b1f17b1804b1-438dc3bd80cmr40315895e9.10.1738172458017; 
 Wed, 29 Jan 2025 09:40:58 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc6df2asm29618465e9.29.2025.01.29.09.40.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:40:57 -0800 (PST)
Message-ID: <06b011cf-7f57-4dde-b10c-eb42b2b8a14f@linaro.org>
Date: Wed, 29 Jan 2025 18:40:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/34] target/arm: Simplify DO_VFP_cmp in vfp_helper.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 29/1/25 02:38, Richard Henderson wrote:
> Pass ARMFPStatusFlavour index instead of fp_status[FOO].
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/vfp_helper.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


