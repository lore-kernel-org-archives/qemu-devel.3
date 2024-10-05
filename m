Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C8D4CFB42D
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAoH-0003jH-Hu; Sat, 05 Oct 2024 15:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAoG-0003br-FZ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:51:24 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sxAoE-0008M1-Ls
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 15:51:24 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-71df0dbee46so645183b3a.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728157881; x=1728762681; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U/LwouViJq+HB0xpw3jHJTahhjSrGiduLo7aelhKuSk=;
 b=zLHgWP9QoLTVDXBrA/NAFW6+12Gx+xArNt281rUOT9kFHPCUOWoXL+c6nXAvLsqSse
 DZL4Rix8BqOv3S1YniJlxfdt0cfBwiwDPP8Vf4FJOl4Cj7g0wste702bLH9dNwB+ABVk
 LONHBFK9jaClqvkTYZM9cIgkxhCKs3Ww9Z0SxM0kvB5sO8KU/YkipEds5cVTduBpe/gv
 m+Yq3a4+OyRUyo3eXhiPGDqmiYkGXApNC2QySZCZxVUW4xz7vOKOXHrehhQeAYRgTO3r
 LDrGsQ2E9mXicYCpLWZ6qZ8wuPqAbdvvP2m0RGreKnE/B1AKw84Zy/9E643j01LuXFGA
 2ZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157881; x=1728762681;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U/LwouViJq+HB0xpw3jHJTahhjSrGiduLo7aelhKuSk=;
 b=P6eYtl0VWUE0urNqAV0WfubGo9RWyQfhclj52URAqgx0xiTa+kPy3F3N2UzUO5Z0sz
 Fiy2Jt4T95EGvX+dR1UqgWQnHj3wUBVH/olyrj1bngb190LzSZJwe4mVmNI6qRqGpKex
 rfNwG8x/fl4VaNRP7/4xaMUU5P6UqQH1n3jLtJU7V9KMUr9Ln7/gp4MX16F+rjxU1p+y
 IO5JLrMgrl17bnSdi5KsMBSlzWFuPSQh+caq+84dHMpVCR8FXhZz3Av25STNjhHrUjcu
 GdmQk4nX0eiMI6N3a6p9bKtg2TI6ys05WlVcnMXaE7gVoSlxc6QIjD1LreEiXDErklTV
 pAhw==
X-Gm-Message-State: AOJu0YyIIXcmvg09qZUlm/Yr8uKvFGHt/+pb3u6+9hKMN9w/eA8414Vg
 sZETUPF47+isr2/PV1CrwuHtV7Tz9uWVrDD/FmQG2BixU9oMyvsrNFxLiat2f8PiCv5GNpuvgIL
 q
X-Google-Smtp-Source: AGHT+IEjU2DXjoxwm1G1yH5cjNZ4oG2uuIBe2vlv+xD9Yqxc6m2GWSCYiQxn2Kzna1Kogu0gDRfSPg==
X-Received: by 2002:a05:6a00:888:b0:70a:f65e:b13d with SMTP id
 d2e1a72fcca58-71de245f362mr10675320b3a.27.1728157880824; 
 Sat, 05 Oct 2024 12:51:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d7d407sm1806250b3a.210.2024.10.05.12.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 12:51:20 -0700 (PDT)
Message-ID: <6d820efe-7f0b-4b6b-946d-e1815934e4e9@linaro.org>
Date: Sat, 5 Oct 2024 12:51:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] Stop all qemu-cpu threads on a breakpoint
To: Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20240923162208.90745-1-iii@linux.ibm.com>
 <8c7ed3d0-15c2-426b-baf5-304a984d2559@linaro.org>
 <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7164df57c9c3eae2e6f27be7f6c890081740b2cc.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 9/25/24 00:43, Ilya Leoshkevich wrote:
> On Tue, 2024-09-24 at 13:46 +0200, Richard Henderson wrote:
>> On 9/23/24 18:12, Ilya Leoshkevich wrote:
>>> Hi,
>>>
>>> On reporting a breakpoint in a non-non-stop mode, GDB remotes must
>>> stop
>>> all threads. Currently qemu-user doesn't do that, breaking the
>>> debugging session for at least two reasons: concurrent access to
>>> the
>>> GDB socket, and an assertion within GDB [1].
>>>
>>> This series fixes this by importing pause_all_vcpus() from qemu-
>>> system.
>>> This in turn requires introducing BQL and a few stubs to qemu-user.
>>
>> I would have expected you to reuse (some portion of) start_exclusive,
>> which is already
>> part of qemu-user.  Is there a reason you chose a solution which
>> requires...
>>
>>>     replay: Add replay_mutex_{lock,unlock}() stubs for qemu-user
>>>     qemu-timer: Provide qemu_clock_enable() stub for qemu-user
>>>     cpu: Use BQL in qemu-user
>>
>> all sorts of other infrastructure?
>>
>>
>> r~
> 
> I don't think start_exclusive() would protect the gdb socket from
> concurrent accesses (e.g., if two threads are simultaneously stopped).

Of course it would, otherwise "exclusive" has no meaning.
All other cpus are blocked in exclusive_idle().

Importantly, no cpus are blocked in syscalls, where the kernel can modify memory behind 
gdbstub's back (e.g. read).  I think considering "in_syscall" to be "paused" a mistake.


r~

