Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C023CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 01:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyhAh-0004Rw-67; Tue, 16 Sep 2025 21:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uyhAc-0004Os-OF; Tue, 16 Sep 2025 21:41:19 -0400
Received: from [115.124.30.98] (helo=out30-98.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1uyhAQ-0007vH-4q; Tue, 16 Sep 2025 21:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1758073224; h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:From;
 bh=haZp8VNoaezTAg6Zh1rZ7qYo9JwKw7CSWvchNkA7fHM=;
 b=bGVUjMpe2WI95pRdsiemrf7Dge5zUWe5N07ojShzXVMi3gmJol281r73hVGFWwZM/kYnmkvXzsNEUlgGc2fYLoA4vCjFT5XkINDcbEtxuJwcJBYgdOeomNRpRtLe7Dgb2Ir2cXCq4OnUvaalvo1X7lUGYiR234SNrlzwfLCtqe4=
Received: from 30.166.64.187(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WoAfjNg_1758073222 cluster:ay36) by smtp.aliyun-inc.com;
 Wed, 17 Sep 2025 09:40:22 +0800
Content-Type: multipart/alternative;
 boundary="------------hOTlUqcrM0fKov1MZwH51DHx"
Message-ID: <192bf4d1-f519-4303-9636-e6d572971553@linux.alibaba.com>
Date: Wed, 17 Sep 2025 09:40:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/5] target/riscv: Implement SMSDID and SMMPT extension
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com
References: <20250909132533.32205-1-zhiwei_liu@linux.alibaba.com>
 <1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com>
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.98 (deferred)
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
--------------hOTlUqcrM0fKov1MZwH51DHx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/16/25 8:49 PM, Daniel Henrique Barboza wrote:
> Hi!
>
> On 9/9/25 10:25 AM, LIU Zhiwei wrote:
>> This patch set introduces support for the RISC-V Smmpt (Supervisor
>> Domain Access Protection) extension. It only includes two 
>> sub-extensions:
>> SMSDID and SMMPT.
>>
>> This patch set implements the v0.3.4 version of Smmpt
>> (https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4).
>>
>> As there are newer SMMPT specification versions, this patch set is
>> not intend for merging.
>
> I'm not sure I understood. Do you mean this patch set isn't supposed 
> to be
> merged even after review?
>

Hi Daniel,

Thanks for the follow-up.

My primary goal is to have this feature merged eventually. I marked this 
version as "not for merging" because I'm aware it's based on an older 
specification, and I plan to update it to the latest one.

However, if the community finds this specific version (v0.3.4) useful 
for current development, such as for CoVE or other ongoing work, I am 
open to having it merged as is.

In any case, I will continue to work on an implementation aligned with 
the newest specification. I would greatly appreciate any review comments 
or feedback on the current approach.

Best regards,
Zhiwei

>
> Daniel
>
>>
>> The implementation is broken down into a series of logical steps:
>>
>> Patch 1 adds the fundamental definitions for the Smmpt extension,
>> including
>> new CSRs (mmpt, msdcfg), their bit-field layouts, and the corresponding
>> CPU
>> configuration flags (ext_smmpt, ext_smsdid).
>>
>> Patch 2 introduces the core logic for Memory Protection Table (MPT)
>> lookups.
>> It includes a new file, riscv_smmpt.c, which implements the multi-level
>> table walk to determine permissions for a given physical address.
>>
>> Patch 3 integrates the MPT permission checks into the main MMU and TLB
>> handling pathways. This ensures that both page table walks and final
>> data accesses are subject to Smmpt protection rules.
>>
>> Patch 4 adds support for the new fence instructions defined by the Smmpt
>> extension, specifically `mfence.spa` and `minval.spa`.
>>
>> Patch 5 enables smmpt and smsdia extendion.
>>
>> With this series, QEMU can now model systems that utilize the Smmpt
>> extension for enhanced memory security.
>>
>> LIU Zhiwei (5):
>>    target/riscv: Add basic definitions and CSRs for SMMPT
>>    target/riscv: Implement core SMMPT lookup logic
>>    target/riscv: Integrate SMMPT checks into MMU and TLB fill
>>    target/riscv: Implement SMMPT fence instructions
>>    target/riscv: Enable SMMPT extension
>>
>>   target/riscv/cpu.c                            |   4 +
>>   target/riscv/cpu.h                            |   9 +-
>>   target/riscv/cpu_bits.h                       |  27 ++
>>   target/riscv/cpu_cfg_fields.h.inc             |   2 +
>>   target/riscv/cpu_helper.c                     |  81 +++++-
>>   target/riscv/csr.c                            |  83 ++++++
>>   target/riscv/insn32.decode                    |   2 +
>>   .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
>>   target/riscv/meson.build                      |   1 +
>>   target/riscv/pmp.h                            |   3 +
>>   target/riscv/riscv_smmpt.c                    | 273 ++++++++++++++++++
>>   target/riscv/riscv_smmpt.h                    |  38 +++
>>   12 files changed, 548 insertions(+), 5 deletions(-)
>>   create mode 100644 target/riscv/riscv_smmpt.c
>>   create mode 100644 target/riscv/riscv_smmpt.h
>>
>
--------------hOTlUqcrM0fKov1MZwH51DHx
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
    <div class="moz-cite-prefix">On 9/16/25 8:49 PM, Daniel Henrique
      Barboza wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com">Hi!
      <br>
      <br>
      On 9/9/25 10:25 AM, LIU Zhiwei wrote:
      <br>
      <blockquote type="cite">This patch set introduces support for the
        RISC-V Smmpt (Supervisor
        <br>
        Domain Access Protection) extension. It only includes two
        sub-extensions:
        <br>
        SMSDID and SMMPT.
        <br>
        <br>
        This patch set implements the v0.3.4 version of Smmpt
        <br>
        (<a class="moz-txt-link-freetext" href="https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4">https://github.com/riscv/riscv-smmtt/releases/tag/v0.3.4</a>).
        <br>
        <br>
        As there are newer SMMPT specification versions, this patch set
        is
        <br>
        not intend for merging.
        <br>
      </blockquote>
      <br>
      I'm not sure I understood. Do you mean this patch set isn't
      supposed to be
      <br>
      merged even after review? <br>
      <br>
    </blockquote>
    <br>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Hi
      Daniel,</p>
    <p data-spm-anchor-id="idealab.4d3ad9aa.0.i1026.26095fb4iiyaSS"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Thanks
      for the follow-up.</p>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">My
      primary goal is to have this feature merged eventually. I marked
      this version as "not for merging" because I'm aware it's based on
      an older specification, and I plan to update it to the latest one.</p>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">However,
      if the community finds this specific version (v0.3.4) useful for
      current development, such as for CoVE or other ongoing work, I am
      open to having it merged as is.</p>
    <p
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">In
      any case, I will continue to work on an implementation aligned
      with the newest specification. I would greatly appreciate any
      review comments or feedback on the current approach.</p>
    <p data-spm-anchor-id="idealab.4d3ad9aa.0.i1025.26095fb4iiyaSS"
style="box-sizing: border-box; font-size: 16px; margin: 7px 0px; line-height: 20px; font-weight: 400; color: rgb(13, 18, 57); font-family: &quot;PingFang SC&quot;, &quot;Helvetica Neue&quot;, Helvetica, Arial, Tahoma, &quot;Microsoft YaHei&quot;; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; white-space: normal; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; word-break: break-all;">Best
      regards,<br style="box-sizing: border-box;">
      Zhiwei</p>
    <blockquote type="cite"
      cite="mid:1d82761a-a968-467b-96ca-427bca7edc65@ventanamicro.com"><br>
      Daniel
      <br>
      <br>
      <blockquote type="cite">
        <br>
        The implementation is broken down into a series of logical
        steps:
        <br>
        <br>
        Patch 1 adds the fundamental definitions for the Smmpt
        extension,
        <br>
        including
        <br>
        new CSRs (mmpt, msdcfg), their bit-field layouts, and the
        corresponding
        <br>
        CPU
        <br>
        configuration flags (ext_smmpt, ext_smsdid).
        <br>
        <br>
        Patch 2 introduces the core logic for Memory Protection Table
        (MPT)
        <br>
        lookups.
        <br>
        It includes a new file, riscv_smmpt.c, which implements the
        multi-level
        <br>
        table walk to determine permissions for a given physical
        address.
        <br>
        <br>
        Patch 3 integrates the MPT permission checks into the main MMU
        and TLB
        <br>
        handling pathways. This ensures that both page table walks and
        final
        <br>
        data accesses are subject to Smmpt protection rules.
        <br>
        <br>
        Patch 4 adds support for the new fence instructions defined by
        the Smmpt
        <br>
        extension, specifically `mfence.spa` and `minval.spa`.
        <br>
        <br>
        Patch 5 enables smmpt and smsdia extendion.
        <br>
        <br>
        With this series, QEMU can now model systems that utilize the
        Smmpt
        <br>
        extension for enhanced memory security.
        <br>
        <br>
        LIU Zhiwei (5):
        <br>
           target/riscv: Add basic definitions and CSRs for SMMPT
        <br>
           target/riscv: Implement core SMMPT lookup logic
        <br>
           target/riscv: Integrate SMMPT checks into MMU and TLB fill
        <br>
           target/riscv: Implement SMMPT fence instructions
        <br>
           target/riscv: Enable SMMPT extension
        <br>
        <br>
          target/riscv/cpu.c                            |   4 +
        <br>
          target/riscv/cpu.h                            |   9 +-
        <br>
          target/riscv/cpu_bits.h                       |  27 ++
        <br>
          target/riscv/cpu_cfg_fields.h.inc             |   2 +
        <br>
          target/riscv/cpu_helper.c                     |  81 +++++-
        <br>
          target/riscv/csr.c                            |  83 ++++++
        <br>
          target/riscv/insn32.decode                    |   2 +
        <br>
          .../riscv/insn_trans/trans_privileged.c.inc   |  30 ++
        <br>
          target/riscv/meson.build                      |   1 +
        <br>
          target/riscv/pmp.h                            |   3 +
        <br>
          target/riscv/riscv_smmpt.c                    | 273
        ++++++++++++++++++
        <br>
          target/riscv/riscv_smmpt.h                    |  38 +++
        <br>
          12 files changed, 548 insertions(+), 5 deletions(-)
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

--------------hOTlUqcrM0fKov1MZwH51DHx--

