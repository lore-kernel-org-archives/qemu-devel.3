Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACDAC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:19:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfd0-0003oe-OM; Wed, 07 Aug 2024 08:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfcz-0003ni-GX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:18:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfcx-0001XE-K4
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:18:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4280ee5f1e3so11813585e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723033127; x=1723637927; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tbWHhjdyT144xVaMzu60IOjDzNxtdVb+itnanPAVE2U=;
 b=qArnI9qojXBs8FVtKEQJMjoxf1rCp2QPH/pRjIDzN0kOJA4GhNCZQJxxD8zeRN4pjW
 Srd5GHUftgXLgJK+aqAgjFCLT7hwFiCuZUB8gRL+tAZdPNyio7yziRXExAk853vp3kVi
 yO1dwutghy9N1iWzA/2sLmirfnwU+fSu4ewDz6qNRhWEU5mVRGAJCJW7cjhx6eXbSz7J
 MU7kVQsTYAhGZW3tHJy9uqke3vUKVLvyCATF1AUaR+NPlaUsNgpP9Q+SLnsE7GQbXB2O
 /iWeG5kvCmMZYM2cGxEYSaBAbLAJ5YI4Zciz+Urbo4LbWJ6bF6OxovRvUBIAy2w4hBoZ
 bpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723033127; x=1723637927;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tbWHhjdyT144xVaMzu60IOjDzNxtdVb+itnanPAVE2U=;
 b=TJsy8xVoDMVDmv8wOAwK3EqtG42SReRn6ZCbATZuUk5n2G5ocTu08qu58j3iZikf2q
 GkH17sqfaywhzwxMxbj/XpI8FzJAORMQExmujv5Cced3VrqNXGrmkgPgnBJslHlQtUk4
 JhmCT+sIZaak4oGWHWuKQnrvFfOHi5pQit9+IfApojX0tAOgqy7otUu4uY0Lufj2viqN
 f1vU1a7MfKYKaUgyxZ8ONQ3g3xHKv3uMhXxhgNrWPDFGnKyu6PaiaxfgpsOG7uctZbqr
 HCHVbuV/Ghxra9o7cIOfvEF+a0YJoqfTQBCjNQB7XUTolyqrt1lYbTrHDgckFte6GuD2
 rrLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBgWg6ueIIYExFc6EYA0liNvbZRszw91qvCJPxdB4qbd3BDrLqEX0b704iZfyHXoch6QrqWRBdhyD1ZEsXGjrBR3FSnu8=
X-Gm-Message-State: AOJu0YyJsl3bER4Ft7zhbT0qqE9UPoj2XqjEN7ujrEWos2BjJyPMlGLP
 I7rGSAf3LAMVxYvjs1ehZdGRu2CBWuOBDMlkgb+UVBA3ot1hi+wt/zsDQ2FzNJlarw9Sps0oixv
 Z
X-Google-Smtp-Source: AGHT+IH6Bl+rdG8DLPdfqllerC6E9JvR0twh0pxie31Nq9J9CvO14NUu8KD8aPZ1hqVqc5vVkvA2eA==
X-Received: by 2002:a5d:6488:0:b0:367:8a72:b8b4 with SMTP id
 ffacd0b85a97d-36bbc0ece70mr17369705f8f.33.1723033127509; 
 Wed, 07 Aug 2024 05:18:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd02a451sm16022585f8f.63.2024.08.07.05.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Aug 2024 05:18:47 -0700 (PDT)
Message-ID: <79abbd4a-e1c8-4539-a29e-f0ec76becf20@linaro.org>
Date: Wed, 7 Aug 2024 14:18:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] linux-user: Add strace for sendto()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>
References: <20240807083508.28134-1-philmd@linaro.org>
 <20240807083508.28134-3-philmd@linaro.org>
 <47d9b786-870c-4a0b-bc8c-1fa09d3c2113@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <47d9b786-870c-4a0b-bc8c-1fa09d3c2113@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 7/8/24 12:55, Richard Henderson wrote:
> On 8/7/24 18:35, Philippe Mathieu-Daudé wrote:
>> +#ifdef TARGET_NR_sendto
>> +static void
>> +print_sendto(CPUArchState *cpu_env, const struct syscallname *name,
>> +             abi_long arg0, abi_long arg1, abi_long arg2,
>> +             abi_long arg3, abi_long arg4, abi_long arg5)
>> +{
>> +    print_syscall_prologue(name);
>> +    print_sockfd(arg0, 0);
>> +    print_buf(arg1, arg2, 0);
> 
> You still need to log arg2.

Oops.


