Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BF5104891D
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 23:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw6yu-0006wy-QK; Fri, 27 Feb 2026 18:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6yt-0006wS-IV
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:10:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vw6yr-0008QX-Ir
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 18:10:47 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso20994805e9.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 15:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772233844; x=1772838644; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lby2zEjFz648tCuQhPqZYTemPi0Ln7KE6UdnZbXZehc=;
 b=cJoBeXjG8ohKOWjHnCJY9Pfl/ikjQdZ/pjpsum8Gyz6nTe5C+PRDlvCOxZzp+dppeL
 W17kE/7L16M0P9uC20RDUwneKPlx2eJiDPtKwOY0wS5EwbN/MhbT76YD8sBn5Z1pUdpr
 XORWhVI8Bjle/U04HlFuym8kyPBIq0Xu/50BEKKcIuxCtvAtUkYNWEuXK8O8KzKe219t
 yt8wEI5yd/5skClSbhmXfe3bZ+jeRPT6G0UQmdUHGW0TBzhJbi4MqAtOF+wXhFkc4Kgq
 tm8y1oHyif3mgW3p1SqEZ3oVP23V8Jz2wF2AOZeMMGlW/CYUPtgNfs+GOy8KuQLzzCxt
 F8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772233844; x=1772838644;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lby2zEjFz648tCuQhPqZYTemPi0Ln7KE6UdnZbXZehc=;
 b=i5NMW6KwAP8A3yIFUDySO2MDVYq+yxfsPQVB8aRaDObmoPy3QzbE+spGXFw79tAQyL
 G1dbkUeo2s/Vw7pxNe8cDuaGZFGwzEm+JiEKtc+vXlemkKUQEp0JJuuh2Bu3ah/lwxct
 SaPq1mZ3z2g32fgmyPH/oa9fUatSz78J0cGNF21ut1YThDZhRz34PahBFmx7V+z24WvZ
 6AXFQ2lKXsMvwmKJGxwu/eYRx3T/+CLsVK2otpKdpInM7b9LY+zue9VBtHveGC9bYi9P
 NQUO8byaVVLPkbVdiSaO8OvFP/aSXt5zM0WWc1sH7sJ4sypwoNXEnHl6AK0WfFSKCN9F
 +30w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2s+BZd2HVFKXQ0C/49VbbTjeyIF1vYFYCcAA0F4V7+ZkMievnnseaxdT74phzo5PUtKmJllS0tZc3@nongnu.org
X-Gm-Message-State: AOJu0Ywbrq2tdDEb71zKrqkw1Fdk4hJOIdB8xQLuuK41d4LUi9NhjFVE
 C2o/kxBCIPJAF7X6c1SUPjSRv5ECugxEUi5XWN2TSev72jFMEdOSIB5IasyjrcKoMqQ=
X-Gm-Gg: ATEYQzx7AmxFh0+zhe5qauy9xg1x5h9ErHlMbp3ameG15UoKkAxRNJUU/O8g7cgDL8l
 UBosDkSiIzVLoOXfo8+eFbLcUjqSnntndjneoJoRRhO6+5pFNbQ0DX2lSJi7W/q+xWKecJicibC
 eY6bOOuFfYyvzO7wm61puIFgKVwUwYrwF2LQyN2dpfoOYiiFAib3af7yk4J+oozc25v83gTK5KN
 cOlCHAy+UMdI4p18pjHvq0smDUy/OenU8ladWeztTh9FX1kEs8tDYoE4ZofhZnChT/iTbgtMhbB
 XKYiF+NbcAclj7WdlHSKqgrvGPGYHGN21pbqNQM43ewsWcq9ovI4qdv3WYsXis83tsuBYOMfXCU
 NoAWasjQf+5f3OpfHiPsBG1BCQeXXKG2xmxiq228A+d9BQ+HQC2H0F929ZUuDUqozqohC9l4kRs
 70A3KN84tvtczFxyqUl5o4/HcoQY5ymuCEGb0RDuRZRv6JLbWntIfopCuXNzeMvX3aP+icRhSYS
 IF+
X-Received: by 2002:a05:600c:4fc8:b0:480:4a90:1b00 with SMTP id
 5b1f17b1804b1-483c9bead27mr66657345e9.20.1772233843776; 
 Fri, 27 Feb 2026 15:10:43 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b3471asm143698555e9.3.2026.02.27.15.10.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 15:10:43 -0800 (PST)
Message-ID: <bc7dd4b4-f011-415a-bcd7-6f4fb45b6d55@linaro.org>
Date: Sat, 28 Feb 2026 00:10:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] gdbstub: Always infer base register index from GDB XML
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Florian Hofhammer <florian.hofhammer@fhofhammer.de>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-ppc@nongnu.org
References: <20260227213958.21170-1-philmd@linaro.org>
 <d381b443-93e8-435e-801a-eae414216940@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d381b443-93e8-435e-801a-eae414216940@linaro.org>
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

+Zhao/Paolo

On 27/2/26 23:39, Pierrick Bouvier wrote:
> On 2/27/26 1:39 PM, Philippe Mathieu-Daudé wrote:
>> Generic fix for a latent bug reported by Florian:
>> https://lore.kernel.org/qemu-devel/e44df309- 
>> d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de/
>>
>> Use the 'regnum' XML tag for feature base register index
>> (after fixing the incorrect m68k FPU ones).
>>
>> Philippe Mathieu-Daudé (4):
>>    gdbstub: Have scripts/feature_to_c.py generate more verbose output
>>    gdbstub: Make base register explicit in m68k GDB XML files
>>    gdbstub: Emit base_register index in GDBFeature entries
>>    gdbstub: Remove @g_pos argument in gdb_register_coprocessor()
>>
>>   include/exec/gdbstub.h     |  4 ++--
>>   gdbstub/gdbstub.c          | 16 ++++++----------
>>   target/arm/gdbstub.c       | 21 ++++++++-------------
>>   target/arm/gdbstub64.c     | 19 +++++++------------
>>   target/hexagon/cpu.c       |  2 +-
>>   target/i386/gdbstub.c      |  8 +++-----
>>   target/loongarch/gdbstub.c |  6 +++---
>>   target/m68k/helper.c       |  4 ++--
>>   target/microblaze/cpu.c    |  3 +--
>>   target/ppc/gdbstub.c       | 11 +++++------
>>   target/riscv/gdbstub.c     | 18 ++++++------------
>>   target/s390x/gdbstub.c     | 15 +++++++--------
>>   target/sparc/gdbstub.c     | 12 ++++--------
>>   gdb-xml/cf-fp.xml          |  2 +-
>>   gdb-xml/m68k-fp.xml        |  2 +-
>>   scripts/feature_to_c.py    | 14 +++++++++-----
>>   16 files changed, 66 insertions(+), 91 deletions(-)
>>
> 
> See some check-tcg failures:
> https://github.com/p-b-o/qemu-ci/actions/runs/22505136358/job/65203283939

I ran check-tcg on a user-only build... And neglected system binaries.
Sigh. Thanks for testing / noticing.

Per commit f46e5073a8a ("i386/gdbstub: Add APX support for gdbstub"),
the gdb-xml/i386-64bit-apx.xml file comes from GDB, but I can not find
it there...

https://sourceware.org/git/?p=binutils-gdb.git;a=tree;f=gdb/features/i386;h=524dad125c554f6210e8987f141383b98ec606cf;hb=refs/tags/binutils-2_46

Maybe it has been generated manually like the m68k one? In that case
it could miss the @regnum tag, and the fix could be as easy as:

-- >8 --
diff --git a/gdb-xml/i386-64bit-apx.xml b/gdb-xml/i386-64bit-apx.xml
index 11a4ec67cae..34cd501881f 100644
--- a/gdb-xml/i386-64bit-apx.xml
+++ b/gdb-xml/i386-64bit-apx.xml
@@ -9,3 +9,3 @@
  <feature name="org.gnu.gdb.i386.apx">
-  <reg name="r16" bitsize="64" type="int64"/>
+  <reg name="r16" bitsize="64" type="int64" regnum="16"/>
    <reg name="r17" bitsize="64" type="int64"/>
---

But I have no clue, it is too late for me to look at GDB source code
so I'll defer to Zhao / Paolo and revisit after the week-end.

Thanks,

Phil.

