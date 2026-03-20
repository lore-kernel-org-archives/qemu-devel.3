Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 568BF1099B40
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hlf-0002SD-KN; Fri, 20 Mar 2026 17:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hle-0002RK-AB
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:30 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hlc-0001ZN-4A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:30 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-35a09e0dd63so1293803a91.3
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043546; x=1774648346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AbJPLOlgxB0/11AE3CtlvCBdGPlx6ENuIB66JCuPM4U=;
 b=Tw9SVMDGnogq8bUfw6gn63ohCDv5tsaeDZXK/2BpmHTB1gjZES4cco72w9VDIPFFMZ
 KQ37gOq4WDyX+92Q4NJQsja84io8i+VSsUJTjJWGiQbTi1uYf7jho//sIl72F9kTU4xc
 z8k1PorZSz9Xb3Srg7H2COs/vvYCb7N3fTgst/p6H6clqv4qgm3HJJQ1bvOwRfQGXcel
 5HHRoFEau4l6e32ryzITuYTgDUVga4QMFJcjGLqJc68luH15iDbVA9insQUZlw7adgEe
 +N5LHhSBAYCvWepej8aVtNWZcpyyvDXd5TmTuQj6zyyXiBEWdpwUIDCuUIVn5hQMZ3cE
 BXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043546; x=1774648346;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbJPLOlgxB0/11AE3CtlvCBdGPlx6ENuIB66JCuPM4U=;
 b=muTLy/aR8OCrtTeSOWbHXYyAUjr9bKKiWJi20T6HgySh36RrAhzCLdqWiGmKgyqHKl
 jtS8Qgoc0j10/5V87zt2p9kqvU7trRY9E9lGYSspc1CNRGblRLElKgzXIt06Ikez+pLt
 v+fIkMhfxLSO7bX7CBYPb3ZCtQrMezmyCpkmlO/IYwk0Rn6/Umy7TG/n73N45dJh0so7
 OCumJe+EPVDLxefevznfK8q6jKGApynaGij81j9EC/Bmc/T1vvcSQwwV7LiTxSDA/ucg
 xWR9ppRJ73x41eWz8QHdSbEa5kmVSB5qDQ4zE7nWYDTwOVgX+NWD9V8z8sM2Flqn3b23
 aV1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIrgyd+InNPfTFa/9wEzgPn/+OdPVmrZAtDx9okKgCxvKsOQIikyTBj3APWOW86hFjzGUeTQ4QmJTI@nongnu.org
X-Gm-Message-State: AOJu0YzoG42QkPyFpusLToDIMcJLfkS02bZJejHTgg9mquziVU3nTze9
 RM2zFrzlG/lmQhN1Ubt1jbNY4M+AX7oNuP+8vmNT7JhuDjdjMSEFOdyOnAkScmxc5+I=
X-Gm-Gg: ATEYQzwSqsWxETUZ6PxHTXcvTx2k/pv6cjbppnuImxxuqLDar3dIXj14sx7I4AycRbH
 JB3mBDcOxuf6uISZs/Wvp90FWG7/oBhAivuNVDPT4DacW0OzIfT+hlsZP5iIO/Zt5fZjyWQcz1i
 JahL8JYbQ+7e6WfbVF1EnZHWUHgJDE4fZHTwPIauoX6QGVr7w5T4PeBldmsdKHyc8X38VeWAMM6
 Q5xX7uuWTUUNG63sNqm8GOaUXkLWpDOqQxCYaYWviZZFxqRQ70dd5TO3zGWKzQnlB/apLZAnIQq
 hNoSEZIO4SimyY7uoYtNm+F7Cy5ZCasJDl8PXsczdL7ZPprfBbls4OFUCM+Xrg4RYGm+yBHh3lL
 BGt4/RLNfM6J+knWdNp2CyPFUaYvue8jclNmYu0yuavnC9npROpV23lOSHbgyzm+FKDGWYsohsB
 Wwdb51F8E1CV8/VdEjLMEMJnm3nbBbcd3mHhZ+0OMv+V2ZsT6J/6qUNxr3LIxsGUTt4hkd
X-Received: by 2002:a05:6300:210b:b0:398:71c6:e8fd with SMTP id
 adf61e73a8af0-39bcec38a75mr3936020637.59.1774043546196; 
 Fri, 20 Mar 2026 14:52:26 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c743a7ff47csm2486650a12.6.2026.03.20.14.52.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:52:25 -0700 (PDT)
Message-ID: <419cc31f-3651-4c45-a8ca-942a0cdd5506@linaro.org>
Date: Fri, 20 Mar 2026 14:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v6 6/6] monitor: Remove 'monitor/hmp-target.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>, Max Filippov
 <jcmvbkbc@gmail.com>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org
References: <20260320091019.59902-1-philmd@linaro.org>
 <20260320091019.59902-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320091019.59902-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 3/20/26 2:10 AM, Philippe Mathieu-Daudé wrote:
> The "monitor/hmp-target.h" header doesn't contain any
> target-specific declarations anymore. Merge it with
> "monitor/hmp.h", its target-agnostic counterpart.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   MAINTAINERS                   |  2 +-
>   include/monitor/hmp-target.h  | 42 -----------------------------------
>   include/monitor/hmp.h         | 12 ++++++++++
>   hw/i386/sgx-stub.c            |  1 -
>   hw/i386/sgx.c                 |  1 -
>   monitor/hmp-cmds.c            |  1 -
>   monitor/hmp-target.c          |  1 -
>   monitor/hmp.c                 |  1 -
>   stubs/target-monitor-defs.c   |  2 +-
>   target/i386/cpu-apic.c        |  1 -
>   target/i386/monitor.c         |  1 -
>   target/i386/sev-system-stub.c |  1 -
>   target/i386/sev.c             |  1 -
>   target/m68k/monitor.c         |  1 -
>   target/ppc/monitor.c          |  2 --
>   target/riscv/monitor.c        |  1 -
>   target/sh4/monitor.c          |  1 -
>   target/sparc/monitor.c        |  1 -
>   target/xtensa/monitor.c       |  1 -
>   19 files changed, 14 insertions(+), 60 deletions(-)
>   delete mode 100644 include/monitor/hmp-target.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

