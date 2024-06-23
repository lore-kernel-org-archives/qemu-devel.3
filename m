Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282E2C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2024 22:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLVJ1-0006z8-Q5; Sun, 23 Jun 2024 18:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVIy-0006x3-6O
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:03:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLVIw-0006Op-OT
 for qemu-devel@nongnu.org; Sun, 23 Jun 2024 18:03:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70666aceb5bso1037900b3a.1
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 15:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719180201; x=1719785001; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xk3YXxtAodWL0/D/8U6fC2fyubscmoVz8yzorekyPy8=;
 b=LR67PoNC7cL3/PQ81+2TqkULbmwFOX0rXuqyyrOcOEeOXMNgf618f6B8adCgwutKTg
 wjak5xhZ2MRXpGjJWprdYdJzE3j9u24hNPDhZMQR2uvov0nHWudJKs9ahAT4aSP+h1Sv
 6E9/tzSL1qjt9/2ip05cn1EB0c6vjszvgIp5iuxwRMGcnudvDhmtSsmL2f6oHz/Qgztv
 wBZ//sXDrFRDFQKO50vaaSQxaavkGfM4a9Hc0ztVQW/GIGDPGNsRGZo5x/rwE9vTe1SJ
 dwgh0vhuBro2s7Oa8JBfCBUs4po9mvx3dmHWk130R9/NWuvn/FdyMFYhPtFiO8SLLI6z
 l6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719180201; x=1719785001;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xk3YXxtAodWL0/D/8U6fC2fyubscmoVz8yzorekyPy8=;
 b=Tmy83MZLHQ/Y4baz4o+Zi0DrvtyOiFSD7eEWAOeaORur9DCZOmtd1V8d+2e9dbJ6GV
 OvPO9D3SBRll2fjOoaZgABYcers0Q2/UMwT0yO/LYWZ0dPXPvoXqqDJ9oG5fjO1lf7nV
 opHW9iyOBuatR6iGPWxcCZ698/HNLH2Ibi4jdxHEnGvOBtdUS3AkMgjDFneJ5i2yx3tC
 g99JDwFn4deMsL5LTJzWw9pluCh3UXv+SS3bg9ZFr3SvM6gJO3r5qGGwsH2wLJqhInWw
 IPLyYPhDmNKc62Zhl2EGxZMMiteJMYllyIQ9MRYKyRAUNaJE5gSeCZ9yIGGxRFBMq7iv
 Hg8w==
X-Gm-Message-State: AOJu0YyivgopYKgOQ+HiHwoYv0cDMJwZZwsCPOdyyM/2m8bBFZNKsc5E
 nEfNnCJg4jDKes3udq5Uf12rOoFcFqALyrNfsOKkPXiPj3BUoiIhFWhJNX46hSZDyHLrrDGxsPX
 B
X-Google-Smtp-Source: AGHT+IH/SbBXbGb487xNBjwNUo8dXwo9WK2/g5hxHCWIshu2C0Lg8qOECr/EtwCxKHhodU7+bcjCLA==
X-Received: by 2002:a05:6a20:27a3:b0:1b4:82eb:61c9 with SMTP id
 adf61e73a8af0-1bcf7e3d52emr2839262637.6.1719180201083; 
 Sun, 23 Jun 2024 15:03:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716ba5b61f2sm4360065a12.74.2024.06.23.15.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 15:03:20 -0700 (PDT)
Message-ID: <86abae67-79ba-487a-925a-de6a55f2b525@linaro.org>
Date: Sun, 23 Jun 2024 15:03:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util: fix building on OpenBSD/powerpc
From: Richard Henderson <richard.henderson@linaro.org>
To: Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <ZneCVxqGDjKpa5Jp@humpty.home.comstyle.com>
 <c8841c2f-3903-42ee-9bf5-2c74185dc007@linaro.org>
Content-Language: en-US
In-Reply-To: <c8841c2f-3903-42ee-9bf5-2c74185dc007@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

On 6/23/24 10:53, Richard Henderson wrote:
> On 6/22/24 19:03, Brad Smith wrote:
>> util: fix building on OpenBSD/powerpc
>>
>> Signed-off-by: Brad Smith<brad@comstyle.com>
>> ---
>>   util/cpuinfo-ppc.c | 20 ++++++++++++--------
>>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

Queued to tcg-next.


r~

