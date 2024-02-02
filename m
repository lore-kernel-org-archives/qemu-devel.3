Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16EEEC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 04:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVl2c-0001G8-Cg; Thu, 01 Feb 2024 23:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVl2b-0001Fw-Al
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 23:20:37 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rVl2Z-0003O6-No
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 23:20:37 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6ddd19552e6so1068681b3a.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 20:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706847634; x=1707452434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UQq0EMVcFdUNcVVSXM7BtmYaS6IpJqyJlnxYSJ7y0nY=;
 b=u/r3C/zxFZIXYDgGu1vxhD1Ue8MdBdfYOCJV1U4xkUm/U1G+R1E+ZqwgsG+aSlx27Y
 zSIVR/KwUhipk0IJrefQtsGVawF+UadtblC/StYVQC7U5iy5eu1MDsQmRwomIPSvA3w7
 rhet+1Wd2foMlsFa8I3siVC7Kje3fMfbJjbhWPvGWDyN1j8UG+mX0KxvslpvvRKW6aPm
 AsOA4T+QysbuHCGNOt9VEBJZnQ5BLOsZYR12kxxDrWv6AajOriqGsjFKd+OZiyjDgkTk
 gwypzHeWdoWMHvuTf0g9VH6VqW6SJnL3dZ4BqPACOP74lzdp5MMPZJkMwyqtRbZz4FLf
 W6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706847634; x=1707452434;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQq0EMVcFdUNcVVSXM7BtmYaS6IpJqyJlnxYSJ7y0nY=;
 b=pPP3eTfq3oSnD5nOqwSIoGoSW+Vk224NNp8anOiDkldcRHHDi2449h/s1Rp7dm5QLc
 v87un7XBmzVpw7z1Q8Vpq4JXr+ac/1mT/ZMb515kZrMj52dOHsdmG4e3cl1TSCDsURyV
 4Du4FMHTPEOQ+Ck0mHMstwR0KALvwkPFc688siKWDniPuPRKysJntbGlPd689919enD8
 YRPCIPm2W94bayQmYqUR4D43NhgyBFuy0fq9ngHzkjUZQx5Yt559q2eA/+mQ2J4tGne/
 tbdkMMi0YBRF3AXJYKFziCXUPfvtxcIRRD2cyC7ecAbVJ5EJ8LhVsOn2AdpdEdsqCbnK
 TrUw==
X-Gm-Message-State: AOJu0YwBoEDmEPqDEPbmeSGj2J28uIHyfYflOJyyKCiBkDom/9mQoizJ
 1+S15zavPKto4dko9VseAsK1HhKkuCzQwQ3xivEsQvbETKJFFMorkTGa3t8ZsPU=
X-Google-Smtp-Source: AGHT+IGvYwB3D4oOyjDGCxq4qSUKszrgHBE/90rPHIK+Q4dM9FyndxNlG+jmJiwKyuoQLLPWE3ESrw==
X-Received: by 2002:a05:6a00:1a8d:b0:6df:edcd:f45b with SMTP id
 e13-20020a056a001a8d00b006dfedcdf45bmr3804297pfv.13.1706847634085; 
 Thu, 01 Feb 2024 20:20:34 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXAvyFPiVR+Scexo62zMYNKU0hEcBJBuRFJR+gPOFn0oXJRpUE1xvMWBpZO+qiQCmtjdir7XBle835HVS+GDBh3UwbuSB9NbyyYl0717aM/xp0UGMqkblF9/XauW3Y=
Received: from [192.168.0.100] ([103.210.27.218])
 by smtp.gmail.com with ESMTPSA id
 hq20-20020a056a00681400b006dff34523ffsm562939pfb.125.2024.02.01.20.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Feb 2024 20:20:33 -0800 (PST)
Message-ID: <f12bdb03-c855-4119-96b9-c9b6c1ba7232@linaro.org>
Date: Fri, 2 Feb 2024 14:20:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Fix the /proc/self/mem probing in the
 PROT_NONE gdbstub test
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240131220245.235993-1-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240131220245.235993-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/1/24 08:02, Ilya Leoshkevich wrote:
> The `if not probe_proc_self_mem` check never passes, because
> probe_proc_self_mem is a function object, which is a truthy value.
> Add parentheses in order to perform a function call.
> 
> Fixes: dc84d50a7f9b ("tests/tcg: Add the PROT_NONE gdbstub test")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/multiarch/gdbstub/prot-none.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/gdbstub/prot-none.py b/tests/tcg/multiarch/gdbstub/prot-none.py
> index e829d3ebc5f..7e264589cb8 100644
> --- a/tests/tcg/multiarch/gdbstub/prot-none.py
> +++ b/tests/tcg/multiarch/gdbstub/prot-none.py
> @@ -20,7 +20,7 @@ def probe_proc_self_mem():
>   
>   def run_test():
>       """Run through the tests one by one"""
> -    if not probe_proc_self_mem:
> +    if not probe_proc_self_mem():
>           print("SKIP: /proc/self/mem is not usable")
>           exit(0)
>       gdb.Breakpoint("break_here")

Ack.  Queued to tcg-next.

r~

