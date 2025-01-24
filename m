Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C1CC0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 21:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbQrt-0002Lq-Su; Fri, 24 Jan 2025 16:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tbQrZ-0002JF-5c
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 16:05:13 -0500
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1tbQrX-0003yQ-Ak
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 16:05:12 -0500
Received: from [192.168.1.5] (default-rdns.vocus.co.nz [202.150.110.104] (may
 be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 50OL4wE32302650
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Fri, 24 Jan 2025 21:05:01 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=XSoOvmWK header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1737752703;
 bh=TuBJcBBLRxC9jwybsCoLheo+qYw+5Q440ouZ7yBjltM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=XSoOvmWKqSScXMFc/HMwE4twYLUGMs6JG+RfEEU43p2nqGvsamolXX/BqYoL1SeD2
 MaVK39I1JFtzlUxTcWZwTB5BzF+Fq7ZICUkLKfsK9Q3ZoMbMtZYUP0l7ArPMYkJdzH
 Zlmz3k4myq+e9IZtUbb7I1+sVqwk4dZPt27UC5uNusC1h7daAXeaOFw6bH9X5iCeJC
 7RrHY4JOKfRQSS3uFhjKp1O9K4lfLpoYO4U3nYBXBmqupnwJA9Ic7/RMEsAkgFXKjy
 OSdUMmBMC6H2MljJcQKOSkxeBzd8Cs9ESyWIPIQsrl3uDWMstZheLqf+bEIThC/qqX
 VpBXlPRyzq1ew==
Message-ID: <1bc0a815-640a-4340-96d1-6aecd12724d6@anarch128.org>
Date: Sat, 25 Jan 2025 10:04:52 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] x86-disas: add x86-mini instruction set metadata
To: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>
References: <20250124001032.1073926-1-michael@anarch128.org>
 <20250124001032.1073926-2-michael@anarch128.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <20250124001032.1073926-2-michael@anarch128.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 1/24/25 13:10, Michael Clark wrote:
> this metadata is based on x86-csv with numerous inaccuracies
> fixed plus conversion of legacy instructions to a new LEX format.
> this metadata has been fuzz-tested against the LLVM disassembler
> for x86-64 with 64-bit ISA coverage in the order of ~99.9%.

adding someone from AMD into this thread.

I should say disassembly for ~99.9% of the Intel ISA in 64-bit mode.
as I did not get to transcribing the AMD extensions yet. I did make
a somewhat complete list of instructions that includes AMD extensions:

https://github.com/michaeljclark/x86/blob/trunk/doc/x86_desc.md

that table can be used to get a list of missing AMD instructions.
in fact, I have a patch to x86-tablegen.py that does that. note
SSE instructions paired with VEX extension start with lower case v
so they will sort properly. and that file is grouped by extension
instead of listed in alphabetical order of all possible orders.

the version of x86-tablegen in the repo in the first message in
this thread has additional features. it can read instruction
descriptions to print fancy documentation in Markdown-like format.
this is truncated for the email because it needs a 132 column
line printer, as opposed to a 72 column line printer like emails.

./scripts/x86_tablegen.py --print-fancy-insn

[AND] # r/m AND sign-extend ib.

| opcode                               | encoding                      |
|:-------------------------------------|:------------------------------|
| AND r8/m8,r8                         | lex.wb 20 /r lock             |
| AND rw/mw,rw                         | lex.wx 21 /r lock             |
| AND r8,r8/m8                         | lex.wb 22 /r                  |
| AND rw,rw/mw                         | lex.wx 23 /r                  |
| AND al,ib                            | lex.wn 24 ib                  |
| AND aw,iw                            | lex.wx 25 iw                  |
| AND r8/m8,ib                         | lex.wb 80 /4 ib lock          |
| AND rw/mw,iw                         | lex.wx 81 /4 iw lock          |
| AND rw/mw,ib                         | lex.wx 83 /4 ib lock          |
|:-------------------------------------|:------------------------------|

i'd appreciate if someone from AMD could contribute data for the
AMD extensions, or donate hardware. ;D the interest in AVX-512
was because I have an old Intel 7980XE PC and TCG doesn't/didn't
support AVX-512 so I thought I would write another one. I note
there is `tcg_out_evex_opc` but I have not seen that code. the
original code in x86-mini is external and is by-file MIT-licensed.
so I would appreciate if folks that want to help with this could
patch the original repo instead of making code that I can't use.
like you are doing for Berkeley SoftFloat.

thanks,
Michael.

