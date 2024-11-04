Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227EFD132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7w8Y-0001R7-Je; Mon, 04 Nov 2024 07:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7w8W-0001Qj-5f
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:24:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t7w8U-00087m-8D
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:24:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso35716585e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730723084; x=1731327884; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6811aNLy2ASy5j7JljKKFGE/wpkaqg4cr/Y8FpjBLgs=;
 b=corabx92GCIT3gWLTzqNTB1Ij134DCWc9iHioFWBXvUN/90f6ZLWnPZ+UPfgBN9O6W
 /hExeX606/v7PHCg80kjhNxTNtoRafbGaX3jptoWXbfYv2jZ3Aak88Zl5AG0vPXxobx8
 oppXxnLEQeIMFJYdIZXDJ96p2PCeQzCFUWIn/Ng3uSvCACDF6m3kMD2Ni64GDNKP19yW
 AUcd/VpM+9d49b1dzAxjOYs4EsjcYGeRGsovccluSUEEIFZdg/YvFBSR7NodJx0jU5QL
 KzYwwzfC39sDsNMBqvThnySTsYOpcgIE++F0fgFsfzj5lLuvnp8Fff2HpiYcEylCmdMp
 l5Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723084; x=1731327884;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6811aNLy2ASy5j7JljKKFGE/wpkaqg4cr/Y8FpjBLgs=;
 b=QlPwD7nuvJqKsSymAwaOvdIQiiCHTdDXWuDynV1LEtPwtvCpoAJfa1NHYg8ZbLfSh/
 NxPK9KXS8P9SEWWijAlVNuhs6g28pzEN7hQp/JvN5RjfmdSuDS+29mX+hm9mzagzi3i0
 +3JJXKOBonS8LLvyPb46rNiM28x56xXE7VeGmhMHeSDKrPVRHj9yKyLWQZYH3wtMW8D9
 Yk5GYR3RHJzvXrU15wkduWRaMk8Mi9iql+aIKs5W4zEtAtiO9i8XlMa/VkKdAJEoceOF
 eH8ElywSiFjSylxPBEXUKnPJWZ/fgX9sFvR2COhuBbXob9vfZwSE+nw8esczuryOKa6n
 1y4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx0+gkK+KOkSg8YQZKP4NMhdDOtOadFnfHzIew/542oRy5l89FuhUDUTBpAmXfeOk7uXNnMFRx3GOE@nongnu.org
X-Gm-Message-State: AOJu0YzTtcMCLa1vLv3HMa537FC7SYBWGWRt51R9X/uKuU6rMCjqCmiP
 jVQAk0i4nw01eLOmAPGyT1tMMdLKxj16NLPSkEebFt2hEgk36dBA+79eih/wF+iOZW2LHtC4lZh
 9pF0=
X-Google-Smtp-Source: AGHT+IGC7TH11P0rWmLnUGVxmw1c3l6IlzDm5SSP/DfXSQceJhFYCUftv4ickRnxk4Cerx9W/tmijQ==
X-Received: by 2002:a05:600c:3ca1:b0:425:80d5:b8b2 with SMTP id
 5b1f17b1804b1-43283255489mr94372415e9.16.1730723084419; 
 Mon, 04 Nov 2024 04:24:44 -0800 (PST)
Received: from [192.168.21.227] ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd8e8466sm182906745e9.2.2024.11.04.04.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 04:24:43 -0800 (PST)
Message-ID: <dcdf552b-5078-4d46-bdd0-4c39e1fcc75d@linaro.org>
Date: Mon, 4 Nov 2024 12:24:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user: Fix GDB complaining about system-supplied
 DSO string table index
From: Richard Henderson <richard.henderson@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20241023202850.55211-1-iii@linux.ibm.com>
 <5cb882c5-a455-408b-9ec2-4e8d4bd88350@linaro.org>
Content-Language: en-US
In-Reply-To: <5cb882c5-a455-408b-9ec2-4e8d4bd88350@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

On 10/25/24 12:41, Richard Henderson wrote:
> On 10/23/24 21:27, Ilya Leoshkevich wrote:
>> When debugging qemu-user processes using gdbstub, the following warning
>> appears every time:
>>
>>      warning: BFD: warning: system-supplied DSO at 0x7f8253cc3000 has a corrupt string 
>> table index
>>
>> The reason is that QEMU does not map the VDSO's section headers. The
>> VDSO's ELF header's e_shoff points to zeros, which GDB fails to parse.
>>
>> The difference with the kernel's VDSO is that the latter is mapped as a
>> blob, ignoring program headers - which also don't cover the section
>> table. QEMU, on the other hand, loads it as an ELF file.
>>
>> There appears to be no way to place section headers inside a section,
>> and, therefore, no way to refer to them from a linker script. Also, ld
>> hardcodes section headers to be non-loadable, see
>> _bfd_elf_assign_file_positions_for_non_load(). In theory ld could be
>> enhanced by implementing an "SHDRS" keyword in addition to the existing
>> "FILEHDR" and "PHDRS".
>>
>> There are multiple ways to resolve the issue:
>>
>> - Copy VDSO as a blob in load_elf_vdso(). This would require creating
>>    specialized loader logic, that duplicates parts of load_elf_image().
>>
>> - Fix up VDSO's PHDR size in load_elf_vdso(). This would require either
>>    duplicating the parsing logic, or adding an ugly parameter to
>>    load_elf_image().
>>
>> - Fix up VDSO's PHDR size in gen-vdso. This is the simplest solution,
>>    so do it.
>>
>> There are two tricky parts:
>>
>> - Byte-swaps need to be done either on local copies, or in-place and
>>    then reverted in the end. To preserve the existing code structure, do
>>    the former for Sym and Dyn, and the latter for Ehdr, Phdr, and Shdr.
>>
>> - There must be no .bss, which is already the case - but having an
>>    explicit check is helpful to ensure correctness.
>>
>> To verify this change, I diffed the on-disk and the loaded VDSOs; the
>> result does not show anything unusual, except for what seems to be an
>> existing oversight (which should probably be fixed separately):
>>
>> │  Symbol table '.dynsym' contains 8 entries:
>> │     Num:    Value          Size Type    Bind   Vis      Ndx Name
>> │ -     0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>> │ -     6: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29
>> │ +     0: 00007f61075bf000     0 NOTYPE  LOCAL  DEFAULT  UND
>> │ +     6: 00007f61075bf000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.29
>>
>> Fixes: 2fa536d10797 ("linux-user: Add gen-vdso tool")
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>
>> v1: https://lore.kernel.org/qemu-devel/20241023144744.50440-1-iii@linux.ibm.com/
>> v1 -> v2: Check that there is no bss, mention linker scripts in the
>>            commit message (Richard).
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> r~

Queued, thanks.

r~

