Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90318C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thR2Y-0000JE-49; Mon, 10 Feb 2025 05:29:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thR2V-0000In-Q4
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:29:19 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thR2U-0002eV-2y
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:29:19 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4361b0ec57aso41511905e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739183356; x=1739788156; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gwoHDxEe1yoMjGTzigAXaUBwSlPAqHkv9aasYnJtIOY=;
 b=Uz0MeH4FsYmFe5Nwc66l4z9EU8lGZj2KQARA4IH7e/m24i0paksxJi68ncMeHKWkku
 pJ7haFm7/wyaQw0KvnDzP3OSyzxyw284d3t60UlEd8qL/XhUV8GRCjS9Bd3uXJLKDRkK
 BynXpbTTgEnsU67iTcjAlH3/tWGqQxxB12XV+IpPAwkfN7u00UA623swIKb2DgPRbmK/
 9TZ8lUf+4dAQCbA5e7oh+j3Xl8qtOH5gRQ7lsf/aL4ZjjK+Sctit4JGcfgr2ZV/W/GRs
 MhQnD9DJJHH0y9OIL57n3zEGEM/zmvR/admtkLoE5HqfnzJ3Ndl8SnYsBnYob7NKsHfX
 Ar6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739183356; x=1739788156;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gwoHDxEe1yoMjGTzigAXaUBwSlPAqHkv9aasYnJtIOY=;
 b=X2Y3h1ZgPRIHzYSqZCJuzdAqiCqs/6AbV2RSlz/GW5Y5gvbnBggJTtkj3JRa9WNAd9
 srjW4BjcYH6N0xeAbTJEoilOFlpL17sPhKhzBc1LZ+p20DrAiCh6a5hoJufs4cRqnYPv
 OBJREAittQIFr4tlZhWWrnG9gcusF3Un4Y+kGNR/JW1zFJPfB6eGVYUM/8jqUjPQS6XC
 BPoEDrhs5WgblsHqGZWa49PQPiQRRcWx9nK95M2h4W5bSk9awDn5gQPnNHbN1bA9k0i8
 TiJoyDo9OyQItAWzRo5FVuciFEW3xfCjiVaa7H2S8n5wKJAYPP/J+giCiVfeXT1/sgal
 18/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPjDqvAwKtiqxJqqCdMLXpVru7BzTlB/kVOb14jVHDroi3C11XmsEl2woJ5tLg90OiT5hoEmpI1YoV@nongnu.org
X-Gm-Message-State: AOJu0YzNAsBY+87pdIICkXEyxMWHzbQnlLETfmPnQNlm3P+FJ1I7XXNe
 dRSMY9I7u+a5Eq8L+1LMOUsD4wAJlGk21Pw/LNIj+v3TA5E4AM2eFSE5rxg6k3g=
X-Gm-Gg: ASbGncv7Y/4PdwbLx8pZ0q4KEpQHbMl0KASHak/CRiHTXG4c33rDGoiERXHkOTx5Rlw
 XNBxV4E7hbpJPaU/DXNc1xc9lJvUBz+qvGwzfXEgElbAbV6WN7M+s/8ytiEFX99picyWD8k0lkT
 vYeekasTwRB/9zDMPA+Ll0WcgiMPTSb7EDlbIT0In6qfzI0mSfOQ4FHFihXjtDz2GrOJYKYBmME
 +yI4fnmfALhgcdiSkdw/k26wieSE8hT2eE0pf0Q1NxpiQi5UxFRq4KCQ3P+/lvXwcrnUkaANpNj
 HGSufAi/1qH5Is0xabM4aGzqff2HevfixFEnzlzrVC8dib4qrn8EOylKvRWAyhWP
X-Google-Smtp-Source: AGHT+IGiZTiHK+hTx34nXbDojdOC0JAjb8dGlkr9wvTo+IOdgmt8k31Skglef73Fll741g197EphnQ==
X-Received: by 2002:a05:600c:1f96:b0:435:1b:65ee with SMTP id
 5b1f17b1804b1-43926158833mr87856795e9.24.1739183356102; 
 Mon, 10 Feb 2025 02:29:16 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391da9652bsm144654865e9.2.2025.02.10.02.29.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 02:29:15 -0800 (PST)
Message-ID: <4b4dacd6-f61c-44d9-9764-d111413e42d0@linaro.org>
Date: Mon, 10 Feb 2025 11:29:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 7/9] tcg/optimize: optimize TSTNE using smask and zmask
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20250210102255.2555097-1-pbonzini@redhat.com>
 <20250210102255.2555097-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250210102255.2555097-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/2/25 11:22, Paolo Bonzini wrote:
> Generalize the existing optimization of "TSTNE x,sign" and "TSTNE x,-1".
> This can be useful for example in the i386 frontend, which will generate
> tests of zero-extended registers against 0xffffffff.
> 
> Ironically, on x86 hosts this is a very slight pessimization in the very
> case it's meant to optimize because
> 
>   brcond_i64 cc_dst,$0xffffffff,tsteq,$L1
> 
> (test %ebx, %ebx) is 1 byte smaller than
> 
>   brcond_i64 cc_dst,$0x0,eq,$L1
> 
> (test %rbx, %rbx).  However, in general it is an improvement, especially
> if it avoids placing a large immediate in the constant pool.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/optimize.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

https://lore.kernel.org/qemu-devel/484b6063-e21f-48d6-9121-6c0c64396889@linaro.org/


