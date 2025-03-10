Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64A6DC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trfzD-0005EL-Dy; Mon, 10 Mar 2025 12:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfzB-00056B-57
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:28:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trfz7-0002Uz-VY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:28:12 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso6875551a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741624088; x=1742228888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MB2fJsQ4IboLQPMn+u5sD/iZ5CoCsD5DvTx+in/FBzM=;
 b=orhoWM/VxT2pmYDQLMuurq9Yp+hzuU6gv65WxgG8Ctk6mBwFQCFIafuPsmKbV48pyD
 a1ONzZe4ueSwbqyNpzTa5/qG7YvnyZf78KpyVRSEdCnhvsKPpE+1W73P/KkQd1PuGYJS
 0u4dFM5DAy+txQG3TLW2kjdtYRy5eLopaAxX53le1RRAUNDZlMRw880KN3zQ7lYJ+jNr
 t/KTi5o4FnEElTLwdPuUsnhpB9U/MqfpNTtVQUurWfJ520Qsvzpog0dRiWcRpCnuKJYo
 pxVmWrQDEuyth/RM4fEa2QYG+mKjP4+3C4QuLU8vEMPjnRL8ujxHWihNK/WZ+rMVVvpa
 fxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741624088; x=1742228888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MB2fJsQ4IboLQPMn+u5sD/iZ5CoCsD5DvTx+in/FBzM=;
 b=XQZmwYEFWgFYPEZLTkDb+YjX9VzxVWcKTix3oekRdlDgizmMsszlDCGuCV7UPTPp0/
 q/5UJPQbnrqyRwQqT8EJo8J/RVX/BmMXCRc6nZsRmi/EeahYMPeOPMf7Z68aErSvXFJA
 +elLJGGJ7jmG5ZRtFgPumPSCtRZ0WJMKm0QL6TXOdeZeCkNfNvn1pDV67J71+jr0JI4d
 WkBQnNvhmHBZdZeafqb1HuEdZQkOh/vgZih9BHS2wpw2Y7ibmzmob37Lro2fIB0pmELJ
 S7JULk1+o/UOLY3fNH4uoIVeL9hKwBFrUH5L5uvzGf0lcfY1hqIBjZUP9/eav8RJIHR5
 QaiA==
X-Gm-Message-State: AOJu0Yzz/fil9fM438gqhjvtQRWQ4UHL+d0TQMkYJ4xpLemAGJxwyBBh
 MyiogQ6c62qlZ0bxaHaX7MmDsZI6PlomTVDmB3Zrv44oq6iGJSEKSHAIZoK9BVU=
X-Gm-Gg: ASbGncuKEv9353Rw9PDZv3rL5A6M0/HHDstTqlJqw97QfU40BcbYaiEY55LTPg20/GB
 tX9ItsjpUyOuTigKn26Wqxt1JsNZfqkDYk+b3PfjLZBqdCMb0AmgwSYiQyTiXCQTvEQfOM+ZXAY
 XRNl1UJS0wI2aGaSxfZG36dw24NTB/qdDETgxl0vy74O9I40E1kI9BXMA/ap6U8gtm/LChQ9EaL
 aMhEnsfuc29K9WwtSctQpMmN4fWbf+fbJ+FynbY6Zn5sIxSRzQ2bUD/8LccdITvUTV8qcCwbXKI
 TwbVT0kyb2L/3vh8wQt5fCSc5oqzIGei5/1C4J3PNwARfHLc4ctXhWWhAQ==
X-Google-Smtp-Source: AGHT+IEMClmiHQu47yv2LCemW+QIh5GG4atFR9obpakYwQTFo0T5HFRT/xNIXLHFw49N04gZ3Ngyqw==
X-Received: by 2002:a05:6a21:6e8a:b0:1ee:e2ac:5159 with SMTP id
 adf61e73a8af0-1f58cb438c6mr642912637.19.1741624088169; 
 Mon, 10 Mar 2025 09:28:08 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736ab33e1d3sm7113582b3a.132.2025.03.10.09.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:28:07 -0700 (PDT)
Message-ID: <c5b9eea9-c412-461d-b79b-0fa2f72128ee@linaro.org>
Date: Mon, 10 Mar 2025 09:28:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] make system memory API available for common code
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Paul Durrant <paul@xen.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anthony PERARD <anthony@xenproject.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, manos.pitsidianakis@linaro.org,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <f231b3be-b308-56cf-53ff-1a6a7fb4da5c@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <f231b3be-b308-56cf-53ff-1a6a7fb4da5c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Zoltan,

On 3/10/25 06:23, BALATON Zoltan wrote:
> On Sun, 9 Mar 2025, Pierrick Bouvier wrote:
>> The main goal of this series is to be able to call any memory ld/st function
>> from code that is *not* target dependent.
> 
> Why is that needed?
> 

this series belongs to the "single binary" topic, where we are trying to 
build a single QEMU binary with all architectures embedded.

To achieve that, we need to have every single compilation unit compiled 
only once, to be able to link a binary without any symbol conflict.

A consequence of that is target specific code (in terms of code relying 
of target specific macros) needs to be converted to common code, 
checking at runtime properties of the target we run. We are tackling 
various places in QEMU codebase at the same time, which can be confusing 
for the community members.

This series take care of system memory related functions and associated 
compilation units in system/.

>> As a positive side effect, we can
>> turn related system compilation units into common code.
> 
> Are there any negative side effects? In particular have you done any
> performance benchmarking to see if this causes a measurable slow down?
> Such as with the STREAM benchmark:
> https://stackoverflow.com/questions/56086993/what-does-stream-memory-bandwidth-benchmark-really-measure
> 
> Maybe it would be good to have some performance tests similiar to
> functional tests that could be run like the CI tests to detect such
> performance changes. People report that QEMU is getting slower and slower
> with each release. Maybe it could be a GSoC project to make such tests but
> maybe we're too late for that.
> 

I agree with you, and it's something we have mentioned during our 
"internal" conversations. Testing performance with existing functional 
tests would already be a first good step. However, given the poor 
reliability we have on our CI runners, I think it's a bit doomed.

Ideally, every QEMU release cycle should have a performance measurement 
window to detect potential sources of regressions.

To answer to your specific question, I am trying first to get a review 
on the approach taken. We can always optimize in next series version, in 
case we identify it's a big deal to introduce a branch for every memory 
related function call.

In all cases, transforming code relying on compile time 
optimization/dead code elimination through defines to runtime checks 
will *always* have an impact, even though it should be minimal in most 
of cases. But the maintenance and compilation time benefits, as well as 
the perspectives it opens (single binary, heterogeneous emulation, use 
QEMU as a library) are worth it IMHO.

> Regards,
> BALATON Zoltan

Regards,
Pierrick


