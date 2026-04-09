Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E42E10FC465
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 02:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAf31-0001fM-U9; Wed, 08 Apr 2026 22:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wAf2y-0001eq-TL; Wed, 08 Apr 2026 22:23:08 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1wAf2u-0007UG-4I; Wed, 08 Apr 2026 22:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1775701373; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=NfTHG7UI5sBK0PtnZA2OpLrnaXondaynD6VfYmnaTXs=;
 b=cmg7PypMbD58Ku4Wo5snLP9pG78wcS7CgOOprXJHoJNQ8crirn4g8DaVwNaM8+byoLxj+IfZD3o3N/GjUKSYPbtCpIOV0DzUhoswcjWnKBDa1fB/Rn8zMA0e73SadcuTh9gpJwZc3lm0B/5EbaWHOmvhJRicx0j+xzV6jKxUb6U=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037009110;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=7; SR=0;
 TI=SMTPD_---0X0gksHZ_1775701357; 
Received: from 30.166.65.22(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0X0gksHZ_1775701357 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 09 Apr 2026 10:22:52 +0800
Content-Type: multipart/alternative;
 boundary="------------IX9INFHZfvTjY0UGRsHDCPcE"
Message-ID: <d9ebc0f1-9296-4d5b-a5d7-0bfd288b3e7f@linux.alibaba.com>
Date: Thu, 9 Apr 2026 10:22:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] target/riscv: Implement Smsdid and Smmpt extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20251112064945.46533-1-zhiwei_liu@linux.alibaba.com>
 <ccad0832-a4e8-4f7e-9972-297872e53436@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <ccad0832-a4e8-4f7e-9972-297872e53436@ventanamicro.com>
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------IX9INFHZfvTjY0UGRsHDCPcE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel and Alistair,

On 4/8/26 5:33 PM, Daniel Henrique Barboza wrote:
> Gentlemen,
>
>
> This is fully reviewed and good to go.  Maybe needs a rebase since it
> was last posted back in November.
>
> Zhiwei, if you could please send a rebase keeping all acks that would be
> terrific.

Thanks for the review and suggestion.

I have rebased the series on top of the latest tree and sent out v5. All 
previously received Acked-by/Reviewed-by tags have been kept.

https://patchew.org/QEMU/20251112064945.46533-1-zhiwei._5Fliu@linux.alibaba.com/diff/20260408140635.42546-1-zhiwei._5Fliu@linux.alibaba.com/

Thanks,
Zhiwei
>
>
> Cheers,
> Daniel
>
> On 11/12/2025 3:49 AM, LIU Zhiwei wrote:
>> This patch set introduces support for the RISC-V Smmpt (Supervisor
>> Memory-tracking and Protection Table) extension. Smmpt provides a
>> hardware mechanism for fine-grained memory protection, checked after
>> address translation, which is particularly useful for supervisor-level
>> sandboxing and security monitoring.
>>
>> The rfc patch set:
>> https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html
>>
>> v3->v4:
>>      1. Add missing review tags.
>> v2->v3:
>>      1. Fix build error in patch 2.
>>      2. Rebase to master.
>>
>> rfc->v2:
>>      1. When ext_smmpt is false or BARE mode, make other fields in mmpt
>>         CSR zero.
>>      2. Add patch 5 to fix smrnmi ISA string order.
>>      3. Fix patch 6 smmpt and smsdid ISA string order.
>>      4. Make smmpt and smsdid experiment extensions.
>>      5. Add review tags.
>>
>>
>> LIU Zhiwei (6):
>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>    target/riscv: Implement core SMMPT lookup logic
>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>    target/riscv: Implement SMMPT fence instructions
>>    target/riscv: Fix smrnmi isa alphabetical order
>>    target/riscv: Enable SMMPT extension
>>
>>   target/riscv/cpu.c                            |   6 +-
>>   target/riscv/cpu.h                            |   9 +-
>>   target/riscv/cpu_bits.h                       |  27 ++
>>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>>   target/riscv/cpu_helper.c                     |  81 +++++-
>>   target/riscv/csr.c                            |  95 ++++++
>>   target/riscv/insn32.decode                    |   2 +
>>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>>   target/riscv/meson.build                      |   1 +
>>   target/riscv/pmp.h                            |   3 +
>>   target/riscv/riscv_smmpt.c                    | 274 ++++++++++++++++++
>>   target/riscv/riscv_smmpt.h                    |  36 +++
>>   12 files changed, 560 insertions(+), 6 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>   create mode 100644 target/riscv/riscv_smmpt.h
>>
>
--------------IX9INFHZfvTjY0UGRsHDCPcE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Daniel and Alistair,</p>
    <div class="moz-cite-prefix">On 4/8/26 5:33 PM, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:ccad0832-a4e8-4f7e-9972-297872e53436@ventanamicro.com">Gentlemen,
      <br>
      <br>
      <br>
      This is fully reviewed and good to go.  Maybe needs a rebase since
      it
      <br>
      was last posted back in November.
      <br>
      <br>
      Zhiwei, if you could please send a rebase keeping all acks that
      would be
      <br>
      terrific. <br>
    </blockquote>
    <span
style="box-sizing: border-box; text-wrap: wrap; word-break: break-word; color: rgb(0, 0, 0); font-family: Consolas, Monaco, &quot;Andale Mono&quot;, &quot;Ubuntu Mono&quot;, monospace; font-size: 16px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space-collapse: preserve; background-color: rgb(245, 242, 240); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;"><span
style="box-sizing: border-box; text-wrap: wrap; word-break: break-word;">
</span></span><br>
    Thanks for the review and suggestion.<br>
    <br>
    I have rebased the series on top of the latest tree and sent out v5.
    All previously received Acked-by/Reviewed-by tags have been kept.<br>
    <br>
<a class="moz-txt-link-freetext" href="https://patchew.org/QEMU/20251112064945.46533-1-zhiwei._5Fliu@linux.alibaba.com/diff/20260408140635.42546-1-zhiwei._5Fliu@linux.alibaba.com/">https://patchew.org/QEMU/20251112064945.46533-1-zhiwei._5Fliu@linux.alibaba.com/diff/20260408140635.42546-1-zhiwei._5Fliu@linux.alibaba.com/</a><br>
    <br>
    Thanks,<br>
    Zhiwei
    <blockquote type="cite"
      cite="mid:ccad0832-a4e8-4f7e-9972-297872e53436@ventanamicro.com"><br>
      <br>
      Cheers,
      <br>
      Daniel
      <br>
      <br>
      On 11/12/2025 3:49 AM, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">This patch set introduces support for the
        RISC-V Smmpt (Supervisor
        <br>
        Memory-tracking and Protection Table) extension. Smmpt provides
        a
        <br>
        hardware mechanism for fine-grained memory protection, checked
        after
        <br>
        address translation, which is particularly useful for
        supervisor-level
        <br>
        sandboxing and security monitoring.
        <br>
        <br>
        The rfc patch set:
        <br>
<a class="moz-txt-link-freetext" href="https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html">https://mail.gnu.org/archive/html/qemu-riscv/2025-09/msg00216.html</a>
        <br>
        <br>
        v3-&gt;v4:
        <br>
             1. Add missing review tags.
        <br>
        v2-&gt;v3:
        <br>
             1. Fix build error in patch 2.
        <br>
             2. Rebase to master.
        <br>
        <br>
        rfc-&gt;v2:
        <br>
             1. When ext_smmpt is false or BARE mode, make other fields
        in mmpt
        <br>
                CSR zero.
        <br>
             2. Add patch 5 to fix smrnmi ISA string order.
        <br>
             3. Fix patch 6 smmpt and smsdid ISA string order.
        <br>
             4. Make smmpt and smsdid experiment extensions.
        <br>
             5. Add review tags.
        <br>
        <br>
        <br>
        LIU Zhiwei (6):
        <br>
           target/riscv: Add basic definitions and CSRs for SMMPT
        <br>
           target/riscv: Implement core SMMPT lookup logic
        <br>
           target/riscv: Integrate SMMPT checks into MMU and TLB fill
        <br>
           target/riscv: Implement SMMPT fence instructions
        <br>
           target/riscv: Fix smrnmi isa alphabetical order
        <br>
           target/riscv: Enable SMMPT extension
        <br>
        <br>
          target/riscv/cpu.c                            |   6 +-
        <br>
          target/riscv/cpu.h                            |   9 +-
        <br>
          target/riscv/cpu_bits.h                       |  27 ++
        <br>
          target/riscv/cpu_cfg_fields.h.inc             |   2 +
        <br>
          target/riscv/cpu_helper.c                     |  81 +++++-
        <br>
          target/riscv/csr.c                            |  95 ++++++
        <br>
          target/riscv/insn32.decode                    |   2 +
        <br>
          .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
        <br>
          target/riscv/meson.build                      |   1 +
        <br>
          target/riscv/pmp.h                            |   3 +
        <br>
          target/riscv/riscv_smmpt.c                    | 274
        ++++++++++++++++++
        <br>
          target/riscv/riscv_smmpt.h                    |  36 +++
        <br>
          12 files changed, 560 insertions(+), 6 deletions(-)
        <br>
          create mode 100644 target/riscv/riscv_smmpt.c
        <br>
          create mode 100644 target/riscv/riscv_smmpt.h
        <br>
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------IX9INFHZfvTjY0UGRsHDCPcE--

