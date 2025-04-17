Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FED0C369C7
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 07:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5JNL-0000te-DE; Thu, 17 Apr 2025 03:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5JNJ-0000tJ-N8
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:09:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u5JNG-0006CC-4b
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 03:09:29 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso3685885e9.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 00:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744873762; x=1745478562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p/xU5hK/8FCUmQ5qW+5hX/Dn3rucZMKPBnRpeKaAg7c=;
 b=Tq5MsrzIqPQb4iYceh2E0U966ua6cZcg0D4InalZ1hiGlSxoRnq8aBkS6+yBB5DwPr
 oBVdu6LPbIyYP6b6hA7PXZnLOpb+StHMQajTPLksNSVQTaUvth+C7IXhmAk2P0+1znPB
 xHPCKzBxNvWIQjTKCjhu6qArf54EvCIrjoYKrCo9MQWkQEKUNTHQqI5Se+v+4l0mgLpF
 ZNFWrzv7/5pT3v6eKKY3w2BJm7kRMkubWiQC1y9O3px0FugU3cQQHRJJZMg0g2dm0EH8
 h92U5DszFgaDrogpHjPb9YAPYcce2OGpnDzV9wyyrUI46NLymY8vGS7FVtD6vOqkGuPo
 o3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744873762; x=1745478562;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p/xU5hK/8FCUmQ5qW+5hX/Dn3rucZMKPBnRpeKaAg7c=;
 b=SHvSOkhR7zpUBwsUPAtLOsPq+M4vMXpcw06WbGq5SfFj7DxGuuExAKqf1udjg0728B
 aNs/kfh+3CEY4zUWWoHvFgPl+B7zY1eTQPyHnID3KY3PIEIhnRauQ0JK9xP/D0+LDqWi
 DE+iPcKXUmwl2+DcV5TnEmkpXIQOQIJ/oLAiiKarEUjyG971P6dSZ9Q2PjIbJA/iz8bn
 BAZy9HuYXhS0Nt40N5Bq1KJD/NJaHozs7SocaOjF7D/AmFuv906Fnh5yIT56urbekXDZ
 HvKKPfnVXWMR6Pdj+uyIgQyC1D/MswBTvbjg+79cc4lwxGF2sFqW7VRKopVYUz2grISp
 46zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDiuXQD3ZuVU88bp+fUTZ57EDo7YpsO0yn6IN60bv7u1BbD+wZ6AJ2J1/okyZhAMf7yvnCh3LJaG/k@nongnu.org
X-Gm-Message-State: AOJu0YzuMomIgnVe6gbRuHD/hkoLJGQN5iC+Tnm+b9t65QIrWjC+tQ5g
 AoyD8kf/BWrAryIjWoOjVe3q+lKBwmufWLmBP7+iitjBmuvffbKq+nLtTjZW9sw=
X-Gm-Gg: ASbGnctVqOhR1eq/5baYpa1VeAQSCGe8Dn58Udom/hf0ZqgwgHyxAO1+LPa8Tb5Se31
 3VBY2EcKHl2N74IymFt5qaczM2va/BTKCPpnZ4ZNxoyGXhQiTwoo/0lSBEIFK0xYsXX2ln23Fxc
 xTVavq5BnCwYtcbuA01rBfgHxrva+WPXaaAlFrVeMWfW2+79G+MdGzUdDYKTdeaQI7KueutahSJ
 JIhuHDkfmHZ9LUEbhEVb/4DTqL9sq1BRYKUOz0JlSuNVGylQ6AP7MeiPV/K01HYHS1gSdTwgH/D
 LAEKNKsgNbRp34afRiNb2lBaDkW32LO9azoKfNWhDb8kBr0xmjPkNY1D2+VgaLcE8MffCXSINrO
 u3sPaMQNM
X-Google-Smtp-Source: AGHT+IFnnjTWMptRx7N4U4C3Yi6YOME2BIguHP1GMu42axIfbT/zKzvVRUHmqPkKE/MN+iTPZWm8Pg==
X-Received: by 2002:a05:600c:5494:b0:43d:fa59:bcee with SMTP id
 5b1f17b1804b1-4405d6cc6acmr36232935e9.33.1744873762038; 
 Thu, 17 Apr 2025 00:09:22 -0700 (PDT)
Received: from [192.168.69.176] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4405b58cc4csm43328225e9.25.2025.04.17.00.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 00:09:21 -0700 (PDT)
Message-ID: <b7d70a5d-199c-47fb-ba7b-010a8d7c1103@linaro.org>
Date: Thu, 17 Apr 2025 09:09:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Hexagon (target/hexagon) Remove gen_tcg_func_table.py
To: ltaylorsimpson@gmail.com, qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, quic_mathbern@quicinc.com,
 sidneym@quicinc.com, quic_mliebel@quicinc.com, richard.henderson@linaro.org,
 ale@rev.ng, anjo@rev.ng
References: <20250415235542.71703-1-ltaylorsimpson@gmail.com>
 <c7588131-2c4f-4a66-8107-cba4df904278@linaro.org>
 <074e01dbaede$2516b720$6f442560$@gmail.com>
 <075601dbaee0$05faee40$11f0cac0$@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <075601dbaee0$05faee40$11f0cac0$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 16/4/25 16:58, ltaylorsimpson@gmail.com wrote:
> 
> 
>> -----Original Message-----
>> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
>> Sent: Wednesday, April 16, 2025 8:45 AM
>> To: 'Philippe Mathieu-Daudé' <philmd@linaro.org>; qemu-
>> devel@nongnu.org
>> Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
>> sidneym@quicinc.com; quic_mliebel@quicinc.com;
>> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
>> Subject: RE: [PATCH] Hexagon (target/hexagon) Remove
>> gen_tcg_func_table.py
>>
>>
>>
>>> -----Original Message-----
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Sent: Wednesday, April 16, 2025 12:18 AM
>>> To: Taylor Simpson <ltaylorsimpson@gmail.com>; qemu-
>> devel@nongnu.org
>>> Cc: brian.cain@oss.qualcomm.com; quic_mathbern@quicinc.com;
>>> sidneym@quicinc.com; quic_mliebel@quicinc.com;
>>> richard.henderson@linaro.org; ale@rev.ng; anjo@rev.ng
>>> Subject: Re: [PATCH] Hexagon (target/hexagon) Remove
>>> gen_tcg_func_table.py
>>>
>>> Hi Taylor,
>>>
>>> On 16/4/25 01:55, Taylor Simpson wrote:
>>>> This can easily be done in C with opcodes_def_generated.h.inc
>>>>
>>>> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
>>>> ---
>>>>    target/hexagon/genptr.c              |  6 ++-
>>>>    target/hexagon/README                |  1 -
>>>>    target/hexagon/gen_tcg_func_table.py | 66 ----------------------------
>>>>    target/hexagon/meson.build           | 10 -----
>>>>    4 files changed, 5 insertions(+), 78 deletions(-)
>>>>    delete mode 100755 target/hexagon/gen_tcg_func_table.py
>>>>
>>>> diff --git a/target/hexagon/gen_tcg_func_table.py
>>>> b/target/hexagon/gen_tcg_func_table.py
>>>> deleted file mode 100755
>>>> index 299a39b1aa..0000000000
>>>> --- a/target/hexagon/gen_tcg_func_table.py
>>>> -        f.write("const SemanticInsn opcode_genptr[XX_LAST_OPCODE] =
>>> {\n")
>>>> -        for tag in hex_common.tags:
>>>> -            ## Skip the priv instructions
>>>> -            if "A_PRIV" in hex_common.attribdict[tag]:
>>>> -                continue
>>>> -            ## Skip the guest instructions
>>>> -            if "A_GUEST" in hex_common.attribdict[tag]:
>>>> -                continue
>>>> -            ## Skip the diag instructions
>>>> -            if tag == "Y6_diag":
>>>> -                continue
>>>> -            if tag == "Y6_diag0":
>>>> -                continue
>>>> -            if tag == "Y6_diag1":
>>>> -                continue
>>>
>>> What about all these skipped tags? IIUC gen_opcodes_def.py doesn't
>>> skip them. If it isn't necessary to skip, please mention it in the
>>> commit description for clarity.
>>>
>>> Regards,
>>>
>>> Phil.
> 
> I looked into this.  There aren't any instructions currently in the code that would be skipped by this logic.  Perhaps this logic was needed at one point in time but is no longer needed because those instructions were removed at some point.
> 
> I recall that Brian consolidated the logic to decide which instructions to skip into a single function in hex_common.py as part of the system mode patch series.  So, I'll go ahead and add a comment to the commit description as you suggest.

Thanks! With it:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


