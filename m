Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA620CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNsv-0002IW-81; Tue, 19 Aug 2025 11:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uoNss-0002Hz-9L
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:22 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uoNsq-0003Ic-2v
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:04:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4717ba0d5dso3756954a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755615858; x=1756220658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2vin8+zsd4VEAVrYozEhkaGbKvgvJ1PgV2ByS/ztruw=;
 b=QF33Vh3IKkzLBV7MJ2pOqIolmjArXos+to6y5IcmE8zVQfWwXicRJ0wMH5Hf33+ozf
 OAKSL6F26V3C/paXZg5ki29T+QfGrHGhCkWe8vqAzIybp2iIX32Z7KnxN6ReMQVcpWGO
 aNU0WT+mZhYXffp+vjmI/O5SZX3pI5ioleKulOBSsl/tKvxwhoY+RO/8B8gAKcMvERfc
 w509lGVLFRuJqaHSAPX1A1sEMwHdkQ+r2qDwvHxjfzPQGgN5wWcC4FTCw8skPgUzj0Rz
 gvV96x+IvUHnBCXIUgdFLmTzU7C6jBqJ+l4ORBatozuNio1T0hbSlN3pOXc/Nmg3OTtR
 ktGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755615858; x=1756220658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2vin8+zsd4VEAVrYozEhkaGbKvgvJ1PgV2ByS/ztruw=;
 b=eDpzEmFDZnOtXsHXg/NLcnVxfyTYD64ntD+UyUFYnsdmklvaT0V/tARYjKjUmkbYLV
 RHyWtwgbHYPEHOEZRO6wa3V/AHiGzOvmPbWC9C91Q2xd7zuYfpT9ZLqAuM7O4dfMrvSP
 8KXKfx/Dix1J1w/AfGq+mArfNPKJo8vs/ln36J6uxIoJNdIrV2Zjh1klPr8HJgBcrPN9
 IeJPYyL1c1t1dp8fZuHQI7vsTdgIzUxXjjn2JoWl3T4VAgMCmwSUCjObUGfCEGapMcnA
 hQ6NEkiHjzzAMQ6JYRFFsb9BYThce7HPvEPQ/UBnS0p/cKARZqE83hr8XkBA1bfQ7P9U
 V94A==
X-Gm-Message-State: AOJu0YxYOrXHNUSdhU6MBZRNwbHd0TK9eJOcA0vFP6esW5QKZXgXr2H1
 IJFAt6acY9hwmAh5jPMUzLWLiS8z0qLYfPH01prrIv88ThPCc2tAlV7UpmX3SoLNsgc=
X-Gm-Gg: ASbGncs/sKg38cbSBuq7eFA5lP3NpSNuK7qK5AkE9wjpb5jh5KasHxoD01DAY3AkSJa
 4+ZlZ0yjPntE9e+zFZOE6uYRZqXiP9Lp5H7GYrScOq06Jbq4ev3zfFuV5awRr7CqpCI3ALKUTaF
 Vu8VXXclxQZKXFL3DTMT17IByQinWzGsvvr13oD+uEc2Keu9TjTLyEk/ml0WtYXh4GZoGIJubu5
 lajRD8GhrNwxUw+95+1GJe13jfcj1aI7R0cMSQ7SfbxjOaE3KHMYI+JSO+2DohEqPU5cIQq9Ji8
 LhM4iuV6MJ7WQMI8t5Ql8gqlD67l/OnocgQ4gQJYvZGHgzmZNYvMlG0Z+bErC/ToWTez1OBfnSC
 qcGdzbYEzvIUqkHXVbXNwZq+vqm2aPmv4WY4=
X-Google-Smtp-Source: AGHT+IF0nxufkoXKHQgp9WIP/UUiBGbhmgyB/QFKQlNKthYtOxjbsJtMnooBI0PoAxNLshXkKwUh6Q==
X-Received: by 2002:a17:903:1987:b0:240:72d8:96fa with SMTP id
 d9443c01a7336-245e0a09c44mr31509485ad.20.1755615857607; 
 Tue, 19 Aug 2025 08:04:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed33cac4sm47735ad.16.2025.08.19.08.04.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 08:04:17 -0700 (PDT)
Message-ID: <8e64fd77-9969-42b3-bbcd-1ed8de910ff9@linaro.org>
Date: Tue, 19 Aug 2025 08:04:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] whpx: arm64: implement -cpu host
To: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-16-mohamed@unpredictable.fr>
 <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 8/19/25 6:24 AM, Peter Maydell wrote:
> On Fri, 8 Aug 2025 at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>
>> OpenProcessorKey and ReadRegU64 adapted from:
>> https://github.com/FEX-Emu/FEX/blob/e6de17e72ef03aa88ba14fa0ec13163061608c74/Source/Windows/Common/CPUFeatures.cpp#L62
>>
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
>> +    /*
>> +     * MIDR_EL1 is not a global register on WHPX
>> +     * As such, read the CPU0 from the registry to get a consistent value.
>> +     * Otherwise, on heterogenous systems, you'll get variance between CPUs.
>> +     */
>> +    HKEY ProcessorKey = OpenProcessorKey();
> 
> 
> Can you follow the QEMU coding style, please (here and elsewhere)?
> Variables and function names should be all lower case,
> and variable declarations go at the start of a C code
> block, not in the middle of one.
>

In some cases, including in this function, I feel that the rule to 
declare variables at the start of a block is not really helpful, and is 
more related to legacy C than a real point nowadays.
As well, it sometimes forces to reuse some variables between various sub 
blocks, which definitely can create bugs.

Anyway, I'm not discussing the existing QEMU coding style, but just 
asking if for the current context, is it really a problem to declare 
variable here?

> thanks
> -- PMM


