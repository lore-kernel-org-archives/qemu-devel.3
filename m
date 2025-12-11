Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2AFBD43341
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 19:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTmHR-0006Gw-FZ; Thu, 11 Dec 2025 14:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTmHQ-0006GZ-9m
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:24:48 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vTmHO-0003gS-LW
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 14:24:48 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4510974a8cdso234873b6e.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765481085; x=1766085885; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6Zj5UQSrfZM3CFNDZmkZz2UI4yzxlAdL7olSZ3a4Q8=;
 b=qQVNnW9FH1nYX/qqIpoISOomDXctZWOd39LXFohbDJFoCvboFKPiX0retGF/p8W9rw
 ImNKvLhIjPSf2s6OietrxkYC0Ip+dHqQz4WgZTgu9KHmmcZuEW3OOVXPD9eR0TZX8huo
 46Bv+V8Y5rCckxwIwOG/1Z0pDOCO7R8ieRzjweBHYuw+QU1wPal2uFYsbb0HOd9/sLXw
 f2vzqpALE6xIcqkH+Kn5YiPIJfT9KMFbxSV6QIpQPnkR70X/q/CjO+pF9uKKS/G0rI5Y
 314Bq03AJBiZeIfHs9xgtGgOwczxx164EeTYPj89UIaJ05pji2G2mE6SkgFwObx+zAxP
 JU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765481085; x=1766085885;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T6Zj5UQSrfZM3CFNDZmkZz2UI4yzxlAdL7olSZ3a4Q8=;
 b=naQZfL4bl7PTNgSzKLV3qhqNcGXn7+BUPjwr/R2n4kIgRkqikncvTC/qQ4IZfo1Xnj
 JLzZv45iXLVx2Xj+EHB4Vuaxe/xdcGwPCVltr3hYk/Iw8pXwXhKkawtk15shaVSGPOdj
 TXWE7RYo2mvTM88e5uE4dWOH3hnMlSNrdH45Nuos6CoGPiZJqieN963L0fFUtotnlX4I
 sE6x3hLmLWSxX4pdYRa9RXh47qCGXIzP9kxAt1o2teNx3rI41Nrw66JWy/AOf9fMxS9b
 Iqi2PoRdRR89viTEpPnvI+SlR8H5goilKUWnCz2jR0aZOMuR5fVBqMpb8+FJzBSF7X0O
 7a3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVI03fp0y9j0iYWpT9aPGAlP4D/QSUkjGS9S6DlswFpaqy3HZtFOjizq1GY1XmCzYdQir5hcwV2aVdH@nongnu.org
X-Gm-Message-State: AOJu0YxPU5RFEHbj8bh6jy37ozFRwxqxn77wbVFGawi2HQQuKJV0nIeF
 4Q33X6bDRvQVlQYufb74ZhCLO2Q4TAFbNYm62at9WZlN5/YR62rbgcZyakFJ2bDo2Yk=
X-Gm-Gg: AY/fxX5O66CuuRrzaXbrsp3rDE4fHN4uLRl/Mr5U8xuCB01e5gqV8KvpDSs23gDj1ia
 69ylIU137u6VdKbG9Pzo1MMiIkd3sSAmIJOkKKhG+KLxKuAHJe4sQpFXAm9sNOfKM9e03PyWoZK
 2GXtviXsaAWNSBsU/jP3ZAqEB6bshdA+AaoSyH5hwWJWgu6l9yZeKDqE6HdVbSIXOERZyDnL+W2
 Q6Ut50gaHaG5GVla8dSTJaQdH3ARheTSe84ds+y9JUWw6f96115hbGALuXqT7RmTftCSvDl/H6N
 Wc4xT2ScBZaf+3uHTqucBtv79YXR7BEDf533IS4ltelz/nDuzZKZ1wWJX84Zc5w8Xn6PF2Kun+C
 BqviRMb10QUE0rifiddtC2Y8f9r+EtTtfMlk2Nlo2EsTAzdIAByd7pyClyxDhqYnUkP4S8A2SMH
 kY2lUeeufY+F1a6el4E8uCyNN3tCtowBHG8YngXQznk0jIKXXYaXCG2xJ2qaf4IaKj
X-Google-Smtp-Source: AGHT+IHXyf/C6l4WWJIvTPXYJTP8NrYwJvw8nBTE0/pSFBYfV6C/y9DFPZRK1YU//S7+y3mBrQS5CQ==
X-Received: by 2002:a05:6808:17a2:b0:43f:76b4:816e with SMTP id
 5614622812f47-45586554cf8mr4161271b6e.4.1765481085109; 
 Thu, 11 Dec 2025 11:24:45 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598d6cbb2sm1497901b6e.21.2025.12.11.11.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 11:24:44 -0800 (PST)
Message-ID: <081b44f3-48aa-4af3-a0d1-c8e5915d95e3@linaro.org>
Date: Thu, 11 Dec 2025 13:24:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Record AS in full tlb
To: Mark Burton <mburton@qti.qualcomm.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matheus Bernardino <mathbern@qti.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>, Brian Cain <bcain@quicinc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <A5D46F85-9B92-477C-B964-1DCE2A1CCF19@qti.qualcomm.com>
 <0d3b4338-2c31-4e42-8a8e-319f3ad4029f@linaro.org>
 <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <2A86D9C4-7EA7-4275-943F-D75801B5539C@qti.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x233.google.com
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

On 12/11/25 12:49, Mark Burton wrote:
>> Adding the as to CPUTLBEntryFull is unnecessary because
>>
>> (1) Each CPUTLB, and thus each CPUTLBEntryFull, is private to the cpu.
>> (2) Each CPUTLBEntryFull contains the MemTxAttrs for the access.
>>
>> Thus the AddressSpace is purely a function of (cpu, attrs).
> 
> The issue is, it would seem, it is also a function of the lookup provided by an IOMMU access - that kindly provides an address space independent of any CPU.

No, it really isn't.

Because you think that, it seems like you're doing something wrong with IOMMU accesses. 
Since I don't know the wider context of the query means I don't know how to help you further.

My shot in the dark: there is a flush that's supposed to happen for changes to a cpu's 
address space.  There are plenty of ways in which this happens, e.g. x86 a20 translation 
line and pci bar changes.  I forget the exact details when it comes to IOMMU, but there 
must be something related when translations change.  The actual tcg flush will happen via 
the MemoryListener interface.


r~

