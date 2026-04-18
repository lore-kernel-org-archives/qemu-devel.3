Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBCF99C95
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEDyT-0001Lt-UG; Sat, 18 Apr 2026 18:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDyL-0001FR-J7
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:17:11 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEDyI-0008A0-I1
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:17:04 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso23003965e9.1
 for <qemu-devel@nongnu.org>; Sat, 18 Apr 2026 15:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776550621; x=1777155421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rkwGeMSpnBapIgdJPL0XX4p5ULR2X+O5b3dLSMCMjKQ=;
 b=qtJt5CJ4H/Pk1gkzy/jZTt8GuA6+2vF4Yvxsmnfz0iG3SZSTAl9+58YP8Lf+rkRDJt
 2vC0+Ezb3hrYI961W4UyWqWYTeCPCPbRc/n85IFK6RAa9EkGzimWSoLE9naKWgmo4E/6
 nBtKYUODt+F72ZuUXNZ3uKHRUTB1PFWYapVg0yIhtYctyDH3JSrmQHODfzh6KRDc980/
 lZyqc/NeAG6c/XBSOQSMvHtQxCUVj9P4Z+ommDE8vXkLyUyDaIJx422OoUhbMW6AGUsS
 /Arx1RlNOYPu/qhsdBXsmo7SsaP0XJTlA9x5qpG+g9QqZK6QH4UcA2F653n95HSU0lFH
 fRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776550621; x=1777155421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rkwGeMSpnBapIgdJPL0XX4p5ULR2X+O5b3dLSMCMjKQ=;
 b=lwuWNH9YsB6qxAGqyLreh/naxPeC6v3P5Ulox+G284z3NkZRHVFif/hIrFhpXgQsTt
 YpDfglRBmIAN7IwUICFft+HwBa0U67QQOU53GNmRaXBB8yaJfNjeEKBQmb2oaiyKNEU8
 dUbAKfZ5+EQCPOqmSaMr1FefFlqGjJU02tIxlhiSA+AnS4pmrbwopsAsEApQGt8zpB8t
 Pd1sEcEZma/2u30/Rf/YYMBGJuOC+QY06t+7+EfODNMXraUUm45eXVxGKNezBcm/8J5/
 7+eLWt7e+eYR4PZrBc4auR95W80wNueL+fHzg7VE5sJHjwa/X6OfNhG5WXgMohw9g1EO
 njyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8vz1nKnrrxwcm8180TlHh4NtaG7k+StdRL+hqGo1wE8+EPbnYRACN+lz9BPkxcU3YRT97cyZ1uMihW@nongnu.org
X-Gm-Message-State: AOJu0YxdjGRuvmcaW82mxPZqu1tyBYNgGzrGjWBFcqsS9h/r/SGPbLfu
 UrcDXQ5CoWjbcKPbGkqaevdpmH3vOyPYHY7goVLmnCP1Rj4nXNAG6NIwuR2ofYVQPGY=
X-Gm-Gg: AeBDiesyF6fhQlBcf9Ewxi0tHscaIxPruq+wNDQOclh9visLmjlXm7KgO9Awlx8/voJ
 YI+KGgv1kNurS6HrL8C+sF7mLvAxCNCSsC5siy1D27+yX4nPH+Gl45b0kx94QSIHzF9+vwvI2W6
 9NawbY2g+sq8KF2i4NrPNLBPlyLxksizjBgGwaDRACsM+7WI3FRw4oHHEObThF3MdVM2TDJX9dy
 hYoZoaTAX9lilxQnUNDDN0BDDKdy6Zp3M3nnxysF99WOS4IMMK5gHcd19qlp0iGYkBcvzaJaEha
 FBv2Q2Y+5tBPFTQxpA9esO0S6/MGRjakZ4f85qoZtq+XJGsTKXyjK7S8Z5gEWFWggI3j4HkMHeY
 TMXZ6J69df58Q9pFU8Y1xw2AyuOmIPdJEQxn1rAOouqAejV/gWjWvuht89zqCYPPhhWn9M1bTms
 6+rd4vAwHoCbe2VRfp6z804FeyNeMFRKVg1BwRwPJvskVY22ByJKIwVVBEGC0AH0QqJfdgFTQCr
 COS
X-Received: by 2002:a05:600c:a416:b0:488:af48:af11 with SMTP id
 5b1f17b1804b1-488fb73a9b8mr90585395e9.1.1776550621096; 
 Sat, 18 Apr 2026 15:17:01 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb7c2167sm49193415e9.36.2026.04.18.15.16.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Apr 2026 15:17:00 -0700 (PDT)
Message-ID: <1f029e85-5405-46dc-bd1b-0998c6f622c5@linaro.org>
Date: Sun, 19 Apr 2026 00:16:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/17] monitor: hmp_gva2gpa: Don't page-align
 cpu_get_phys_addr_debug() arg and return
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
 <20260417173105.1648172-13-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260417173105.1648172-13-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/4/26 19:31, Peter Maydell wrote:
> In hmp_gva2gpa() we currently have a workaround for not all implementations
> of get_phys_addr_debug handling non-page-aligned addresses: we round the
> input address from the user down to the target page boundary before the
> call and then add the page offset back to the returned value.
> 
> Now that we guarantee that all implementations will return the correct
> exact physaddr for a virtual address, we can drop this handling.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   monitor/hmp-cmds.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

