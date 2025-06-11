Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86B1BC677C4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 09:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPHtV-0000iL-Bx; Wed, 11 Jun 2025 05:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uPHtP-0000hg-V1; Wed, 11 Jun 2025 05:37:11 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roan.richmond@codethink.co.uk>)
 id 1uPHtI-0002O1-3F; Wed, 11 Jun 2025 05:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:In-Reply-To:From:References:Cc:
 To:Subject:MIME-Version:Date:Message-ID:Content-Type:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AnYxm8P7stbrqu0QxPVMhK8+UITY1TlkmB1aK98oaqw=; b=feTN8C7aR8B79o03sf8utimVIZ
 gDzhi+ioCclhX6zVtonaBqGV8sTT4nlej8SwvQuA95uPAHCOi5HD8QTeJR/Mf1gzwbPt+gb0dxVw5
 cNa7AcYOgqpRdVHtVbrwJPAQLmBg6qd9GSqFOrNlRJy9cG5oa/mwT4gpNsnuwd7RUSRyf8EOF4AkU
 yEngKefll+bjquqJrFqqTgTB0W6K9JIYjwGghzumQ8wL1+2qAjvouOaJ88SJQitZnesGJj34JIF5C
 xui/W5XiSLtvg6bbpGGsSPiRyh/poeS4tRSWoofa+A10FjxgPN7bgOAsB9iE/Sctl8xihvnb+cY8l
 LDuGpQCQ==;
Received: from [167.98.27.226] (helo=[10.35.4.30])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1uPHt8-00CSvM-2e; Wed, 11 Jun 2025 10:36:54 +0100
Content-Type: multipart/alternative;
 boundary="------------jlY5VJJi0fu0VIn9kmDROalU"
Message-ID: <537163b6-cf9a-4258-b093-1e680193627a@codethink.co.uk>
Date: Wed, 11 Jun 2025 10:36:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] Add RISCV ZALASR Extension
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, qemu-devel@nongnu.org
References: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
 <CAKmqyKPQ=TjrgdvHBRoe1CYLR4eoMsd+Hs+2LNVzUOEMApDeow@mail.gmail.com>
Content-Language: en-US
From: Roan Richmond <roan.richmond@codethink.co.uk>
In-Reply-To: <CAKmqyKPQ=TjrgdvHBRoe1CYLR4eoMsd+Hs+2LNVzUOEMApDeow@mail.gmail.com>
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=roan.richmond@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------jlY5VJJi0fu0VIn9kmDROalU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/06/2025 05:31, Alistair Francis wrote:
> On Tue, Jun 10, 2025 at 6:33 PM Roan Richmond
> <roan.richmond@codethink.co.uk> wrote:
>> Ping, resending as no responses in over week.
>>
>> V2:
>>    - rebased patch onto master branch
>>    - added check for RV64() for Load Double, as pointed out by Alistair Palmer.
>>
>> In response to Alistair Palmer (https://lists.gnu.org/archive/html/qemu-riscv/2025-06/msg00010.html):
>> "Aren't you missing a check to ensure RL is set?"
>>    - There is no need to check if RL is set, as this is required by Spec for all Store Release instructions.
> I don't follow this justification.
>
> What would happen on real hardware if an invalid instruction is run?
> It should cause an exception, which is what we should be doing as well.
>
> Alistair
Ok - I understand the reasoning, For v3 I will add some check to ensure 
that:
- `aq` is set for Load Acquire
- `rl` is set for Store Release
>> Roan Richmond (1):
>>    Add RISCV ZALASR extension
>>
>>   target/riscv/cpu.c                           |   1 +
>>   target/riscv/insn32.decode                   |  10 ++
>>   target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
>>   target/riscv/translate.c                     |   1 +
>>   4 files changed, 122 insertions(+)
>>   create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>>
>> --
>> 2.43.0
>>
Thanks,
Roan

-- 
Roan Richmond (he/him)
Software Engineer
Codethink Ltd

--------------jlY5VJJi0fu0VIn9kmDROalU
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 11/06/2025 05:31, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAKmqyKPQ=TjrgdvHBRoe1CYLR4eoMsd+Hs+2LNVzUOEMApDeow@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Tue, Jun 10, 2025 at 6:33 PM Roan Richmond
<a class="moz-txt-link-rfc2396E" href="mailto:roan.richmond@codethink.co.uk">&lt;roan.richmond@codethink.co.uk&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Ping, resending as no responses in over week.

V2:
  - rebased patch onto master branch
  - added check for RV64() for Load Double, as pointed out by Alistair Palmer.

In response to Alistair Palmer (<a class="moz-txt-link-freetext" href="https://lists.gnu.org/archive/html/qemu-riscv/2025-06/msg00010.html">https://lists.gnu.org/archive/html/qemu-riscv/2025-06/msg00010.html</a>):
"Aren't you missing a check to ensure RL is set?"
  - There is no need to check if RL is set, as this is required by Spec for all Store Release instructions.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
I don't follow this justification.

What would happen on real hardware if an invalid instruction is run?
It should cause an exception, which is what we should be doing as well.

Alistair
</pre>
    </blockquote>
    Ok - I understand the reasoning, For v3 I will add some check to
    ensure that:<br>
    - `aq` is set for Load Acquire<br>
    - `rl` is set for Store Release<br>
    <blockquote type="cite"
cite="mid:CAKmqyKPQ=TjrgdvHBRoe1CYLR4eoMsd+Hs+2LNVzUOEMApDeow@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Roan Richmond (1):
  Add RISCV ZALASR extension

 target/riscv/cpu.c                           |   1 +
 target/riscv/insn32.decode                   |  10 ++
 target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
 target/riscv/translate.c                     |   1 +
 4 files changed, 122 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc

--
2.43.0

</pre>
      </blockquote>
    </blockquote>
    Thanks,<br>
    Roan<span style="white-space: pre-wrap">
</span>
    <pre class="moz-signature" cols="72">-- 
Roan Richmond (he/him)
Software Engineer
Codethink Ltd</pre>
  </body>
</html>

--------------jlY5VJJi0fu0VIn9kmDROalU--

