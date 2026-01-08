Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567FBD1D494
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxH2-0002VR-5A; Thu, 08 Jan 2026 16:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGy-0002Mv-OA
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:25 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxGv-0004cd-HR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:10:23 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-29efd139227so27652935ad.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767906619; x=1768511419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q8gZpfZYUydKqP3G0/V9i0C9VASiUnqVACgQRLNoczc=;
 b=x1QKJTlnfoKsIVESFK77Hw2TOKLa/EeSJNHNhA2kHGeHKLTe84vA1H+W8m+yEYY7K1
 Gv5UZHCG5j+xXBrStv2jwwWTJ5QlxYlu+itPkII7cWxmHON8W+U6utM1RlabgdR77ctf
 VHXDPv/jvu05SVkfS3YfdBafQZRRDAD3/G/Un+XnpSaeuhANI/zSw6lhebSiRj4ph4u+
 wAz+u7OwtUw7X/xCIU+gl3Yi1zqFrreB8neWZwBbeTIX4nXuGVTxs/UDCdUq6Owxcysu
 mDabeEhX76sp0CdWtiPnead8S8sU2ckVBlFvIYjstDU3zr/V8Ik8GVGibo5ucgJ01a8J
 UPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767906619; x=1768511419;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q8gZpfZYUydKqP3G0/V9i0C9VASiUnqVACgQRLNoczc=;
 b=SotaEi4uICwEk6hzZwkfvDNJ2Pya7a85ETzW+kjZ58KU2zQ54dRmNSi7Ldv3X6CoyH
 HEgDDtGr2ndB665/0oRwpBoz6ywwa2VkQcUqpGXpQQg3HfDAYBHPQth+lxYO0bH9MOL0
 JWPAMkN6yTEKoefIuP5qQCXR8wiCl0Lff9nv39/waJrnKGQvrLdMNGPrtKKaRHmrlmEY
 Qb1pf3lfCg9L3o8+HepjGD9fezy/+IfQWkk9HTGDWlsDasfuVmcZ+71MMP674r80t+gU
 DBGN2TwHYusUWAr590UIfZA2fNp7q4Kn0cRoX8L2/MHJtmqMkrz5uLQBNVNxGkXacFna
 /Asg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxkNIE7eUPJ1BLVfsmoHP24JhtJLitd1vzEV5DrsQTIVufRdJzaCp1YlFuQ8mrkAzBbXUJ/TmiAdN+@nongnu.org
X-Gm-Message-State: AOJu0Yx8GRE2tlGRf/qBAlhJrlPOEFxuB+WxiOyEYEf0YcrkxyWqLlKB
 koG+G8ZcEXytKOWFYG3aqs535kwCD1Z1ueJ2Z/s5dgjTT4q9pfcxIZXz6WI77ZBvwGA=
X-Gm-Gg: AY/fxX6+YCPuxT+ixL0/NQA+kPbjixA0pI7c6LSxY8XeIIaQFr5JT/sYkp/DEdEsILq
 DbHBYqNtnV67eqKaP/C4ajetVmdRL3g8EHoV4gixOiQyz0oz+e/dri16df+K1VUirF+pzR3BB/Q
 74E2GQUHPGUPBD3AnMBq5DkCXvOvhlSgaSmBwEQ5cfsqvI0RbCoVXHyI8Hzlm2Cvkr2IbsBhZ3T
 GZ5AdmAW8dCS41Ul9qMAKk2HfqnBPXW7RJ3yq3963+biiNHA9jY9UyBJfEixACD66BRnkGkSX9j
 mqUZVZP3q0hKrzhaScbN8f92TwO2RYhZSc7jTNZxoRvmC/rjETeKsUhKPUouQC/V5YkF/7SRBgA
 8Zj8JthBta0zIzvYyO/Y0mlWgxb0vnol7nTSyLwNKPeHytP0c52Kj0AAld9T2SRsvJGD8on1/6r
 YfzjeWhWfYkpwYGVkaIZX58ZM3ZVyJrh1Gau6IYgKPDKY9rL2cE3zKbD5s
X-Google-Smtp-Source: AGHT+IESTadHNP/lNtrbUmDdW13rMSkp+v1IfE2y98e20VeMVtA7JhlGMhg3ho6B+Rt9BoEHsKMVrw==
X-Received: by 2002:a17:903:41ce:b0:2a2:acc5:7a42 with SMTP id
 d9443c01a7336-2a3ee4dcbe0mr65414335ad.48.1767906618725; 
 Thu, 08 Jan 2026 13:10:18 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c48c15sm85508365ad.27.2026.01.08.13.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:10:17 -0800 (PST)
Message-ID: <9ec9c024-8c90-4b2c-a7c5-bdfc2c0a0ec6@linaro.org>
Date: Thu, 8 Jan 2026 13:10:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/50] accel/tcg/runtime: Remove helper_nonatomic_cmpxchgo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-36-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-36-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> This were only required for some 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/tcg-runtime.h       |  3 ---
>   accel/tcg/atomic_common.c.inc | 20 --------------------
>   2 files changed, 23 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

