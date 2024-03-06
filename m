Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3BAC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 03:53:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhiKc-0007Y4-2A; Tue, 05 Mar 2024 22:52:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rhiKZ-0007Xw-Gh
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 22:52:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rhiKW-0005Oq-3j
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 22:52:35 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dxfet26Odllv0UAA--.52179S3;
 Wed, 06 Mar 2024 11:52:22 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxM8xy6Odli_5OAA--.3173S2; 
 Wed, 06 Mar 2024 11:52:20 +0800 (CST)
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
 <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
 <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <5325b63b-2a51-8448-bf70-c0659497db61@loongson.cn>
Date: Wed, 6 Mar 2024 11:52:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------E02E5233BAB56D870F4B7EFD"
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxM8xy6Odli_5OAA--.3173S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZr18WF4Dtry5AF18KryDurX_yoWrGw4UpF
 WxX34fKF95tFWIgrn7Xa48XFy3Aan5G3y7AF1xGFyrCwnxX34I9r10vrWYgF1UuFWfAFy0
 qr4jyryDZa1kA3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67
 AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8I
 j28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAv7VC0I7IYx2IY67AKxVWUJVWUGw
 Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx8G
 jcxK6IxK0xIIj40E5I8CrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMx
 C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_JrI_JrWlx2IqxVCjr7xvwVAF
 wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
 vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
 0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
 WUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUz4SrUUUUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-1.98, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This is a multi-part message in MIME format.
--------------E02E5233BAB56D870F4B7EFD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard :
> On 3/4/24 20:21, lixianglai wrote:
>> Hi Richard:
>>> On 3/4/24 17:51, Xianglai Li wrote:
>>>> When we use qemu tcg simulation, the page size of bios is 4KB.
>>>> When using the level 2 super large page (page size is 1G) to create 
>>>> the page table,
>>>> it is found that the content of the corresponding address space is 
>>>> abnormal,
>>>> resulting in the bios can not start the operating system and 
>>>> graphical interface normally.
>>>>
>>>> The lddir and ldpte instruction emulation has
>>>> a problem with the use of super large page processing above level 2.
>>>> The page size is not correctly calculated,
>>>> resulting in the wrong page size of the table entry found by tlb.
>>>>
>>>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>>>> Cc: maobibo@loongson.cn
>>>> Cc: Song Gao <gaosong@loongson.cn>
>>>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>>>> Cc: zhaotianrui@loongson.cn
>>>> ---
>>>>   target/loongarch/cpu.h            |  1 +
>>>>   target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
>>>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>>>> index ec37579fd6..eab3e41c71 100644
>>>> --- a/target/loongarch/cpu.h
>>>> +++ b/target/loongarch/cpu.h
>>>> @@ -292,6 +292,7 @@ typedef struct CPUArchState {
>>>>       uint32_t fcsr0_mask;
>>>>         uint32_t cpucfg[21];
>>>> +    uint32_t lddir_ps;
>>>
>>> This magical cpu state does not appear in the manual.
>>
>> The hardware instruction manual is hosted on github at
>>
>> https://github.com/loongson/LoongArch-Documentation
>>
>>> Are you sure that large pages above level 2 are really supported by 
>>> LDDIR?
>>
>>
>> Yes,We have done tests on the physical cpu of loongarch64 and
>>
>> it works fine with a level 2 large page on the physical cpu.
>>
>>
>>>
>>> Some explanation from the hardware engineering side is required.
>>
>> The description of lddir hardware manual is as follows:
>>
>>
>> Instruction formats:
>>
>> |lddir rd, rj, level|
>>
>> The|LDDIR|instruction is used for accessing directory entries during 
>> software page table walking.
>>
>> If bit|[6]|of the general register|rj|is|0|, it means that the 
>> content of|rj|is the physical address of the
>>
>> base address of the level page table at this time. In this case, 
>> the|LDDIR|instruction will access the level
>>
>> page table according to the current TLB refill address, retrieve the 
>> base address of the corresponding
>>
>> |level+1|page table, and write it to the general register|rd|.
>>
>>
>> reference:
>>
>> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html 
>>
>>
>>
>>           4.2.5.1.|LDDIR|
>
> Yes, I have this manual.  Please highlight the portion of this 
> description that corresponds to the LDDIR_PS variable that you add.
>

Sorry, I don't think I quite understand what you mean.

Do you mean that you want me to point out the detailed description of 
LDDIR_PS in the manual

or suggest that I add a corresponding comment to the LDDIR_PS variable 
in the patch?


I think the description I quoted is missing a key part:

If bit|[6]|of general register|rj|is|1|, it means that the content 
in|rj|is a large page (Huge Page) page table entry. In this case, after 
executing the|LDDRI|instruction, the value in the general 
register|rj|will be written directly to the general register|rd|.

The LDDIR_PS variable is not described in detail in the manual, but is 
only an intermediate variable to assist in page size calculation during 
tcg simulation.

However, in section 5.4.2 TLB, we learned that TLB is divided into STLB 
and MTLB.

The PS field in MTLB has the same meaning as the variable LDDIR_PS we 
defined.

Since TLB is divided into parity entries, Therefore, when the TLB is 
generated,

the size of each parity entry becomes half, that is, LDDIR_PS-1.

It should be noted here that all large-page tlb entries will be placed 
in the MTLB, because the PS field is only meaningful in the MTLB.


Thanks,

Xianglai.




>
> r~

--------------E02E5233BAB56D870F4B7EFD
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Richard :<br>
    <blockquote type="cite"
      cite="mid:dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org">On
      3/4/24 20:21, lixianglai wrote:
      <br>
      <blockquote type="cite">Hi Richard:
        <br>
        <blockquote type="cite">On 3/4/24 17:51, Xianglai Li wrote:
          <br>
          <blockquote type="cite">When we use qemu tcg simulation, the
            page size of bios is 4KB.
            <br>
            When using the level 2 super large page (page size is 1G) to
            create the page table,
            <br>
            it is found that the content of the corresponding address
            space is abnormal,
            <br>
            resulting in the bios can not start the operating system and
            graphical interface normally.
            <br>
            <br>
            The lddir and ldpte instruction emulation has
            <br>
            a problem with the use of super large page processing above
            level 2.
            <br>
            The page size is not correctly calculated,
            <br>
            resulting in the wrong page size of the table entry found by
            tlb.
            <br>
            <br>
            Signed-off-by: Xianglai Li <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
            <br>
            Cc: <a class="moz-txt-link-abbreviated" href="mailto:maobibo@loongson.cn">maobibo@loongson.cn</a>
            <br>
            Cc: Song Gao <a class="moz-txt-link-rfc2396E" href="mailto:gaosong@loongson.cn">&lt;gaosong@loongson.cn&gt;</a>
            <br>
            Cc: Xiaojuan Yang <a class="moz-txt-link-rfc2396E" href="mailto:yangxiaojuan@loongson.cn">&lt;yangxiaojuan@loongson.cn&gt;</a>
            <br>
            Cc: <a class="moz-txt-link-abbreviated" href="mailto:zhaotianrui@loongson.cn">zhaotianrui@loongson.cn</a>
            <br>
            ---
            <br>
              target/loongarch/cpu.h            |  1 +
            <br>
              target/loongarch/tcg/tlb_helper.c | 21
            ++++++++++++---------
            <br>
              2 files changed, 13 insertions(+), 9 deletions(-)
            <br>
            <br>
            diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
            <br>
            index ec37579fd6..eab3e41c71 100644
            <br>
            --- a/target/loongarch/cpu.h
            <br>
            +++ b/target/loongarch/cpu.h
            <br>
            @@ -292,6 +292,7 @@ typedef struct CPUArchState {
            <br>
                  uint32_t fcsr0_mask;
            <br>
                    uint32_t cpucfg[21];
            <br>
            +    uint32_t lddir_ps;
            <br>
          </blockquote>
          <br>
          This magical cpu state does not appear in the manual.
          <br>
        </blockquote>
        <br>
        The hardware instruction manual is hosted on github at
        <br>
        <br>
        <a class="moz-txt-link-freetext" href="https://github.com/loongson/LoongArch-Documentation">https://github.com/loongson/LoongArch-Documentation</a>
        <br>
        <br>
        <blockquote type="cite">Are you sure that large pages above
          level 2 are really supported by LDDIR?
          <br>
        </blockquote>
        <br>
        <br>
        Yes,We have done tests on the physical cpu of loongarch64 and
        <br>
        <br>
        it works fine with a level 2 large page on the physical cpu.
        <br>
        <br>
        <br>
        <blockquote type="cite">
          <br>
          Some explanation from the hardware engineering side is
          required.
          <br>
        </blockquote>
        <br>
        The description of lddir hardware manual is as follows:
        <br>
        <br>
        <br>
        Instruction formats:
        <br>
        <br>
        |lddir rd, rj, level|
        <br>
        <br>
        The|LDDIR|instruction is used for accessing directory entries
        during software page table walking.
        <br>
        <br>
        If bit|[6]|of the general register|rj|is|0|, it means that the
        content of|rj|is the physical address of the
        <br>
        <br>
        base address of the level page table at this time. In this case,
        the|LDDIR|instruction will access the level
        <br>
        <br>
        page table according to the current TLB refill address, retrieve
        the base address of the corresponding
        <br>
        <br>
        |level+1|page table, and write it to the general register|rd|.
        <br>
        <br>
        <br>
        reference:
        <br>
        <br>
<a class="moz-txt-link-freetext" href="https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html">https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html</a>
        <br>
        <br>
        <br>
                  4.2.5.1.|LDDIR|
        <br>
      </blockquote>
      <br>
      Yes, I have this manual.  Please highlight the portion of this
      description that corresponds to the LDDIR_PS variable that you
      add.
      <br>
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Sorry, I don't think I quite understand what you mean.<br>
    </p>
    <p>Do you mean that you want me to point out the detailed
      description of LDDIR_PS in the manual <br>
    </p>
    <p>or suggest that I add a corresponding comment to the LDDIR_PS
      variable in the patch?</p>
    <p><br>
    </p>
    <p>I think the description I quoted is missing a key part:</p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">If bit<span> </span></span><code
        style="box-sizing: border-box; font-family: &quot;Droid Sans
        Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size:
        0.9375em; font-weight: 400; color: rgba(0, 0, 0, 0.9);
        letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
        -0.15em; background-color: rgb(247, 247, 248); border-radius:
        4px; line-height: 1.45; text-rendering: optimizespeed;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">[6]</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span> </span>of
        general register<span> </span></span><code style="box-sizing:
        border-box; font-family: &quot;Droid Sans Mono&quot;,
        &quot;DejaVu Sans Mono&quot;, monospace; font-size: 0.9375em;
        font-weight: 400; color: rgba(0, 0, 0, 0.9); letter-spacing:
        0px; padding: 0.1em 0.5ex; word-spacing: -0.15em;
        background-color: rgb(247, 247, 248); border-radius: 4px;
        line-height: 1.45; text-rendering: optimizespeed; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        -webkit-text-stroke-width: 0px; text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">rj</code><span style="color: rgba(0, 0, 0, 0.8);
        font-family: &quot;Noto Serif&quot;, &quot;DejaVu Serif&quot;,
        serif; font-size: 17px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: -0.17px; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"><span> </span>is<span> </span></span><code
        style="box-sizing: border-box; font-family: &quot;Droid Sans
        Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size:
        0.9375em; font-weight: 400; color: rgba(0, 0, 0, 0.9);
        letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
        -0.15em; background-color: rgb(247, 247, 248); border-radius:
        4px; line-height: 1.45; text-rendering: optimizespeed;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">1</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">, it means
        that the content in<span> </span></span><code style="box-sizing:
        border-box; font-family: &quot;Droid Sans Mono&quot;,
        &quot;DejaVu Sans Mono&quot;, monospace; font-size: 0.9375em;
        font-weight: 400; color: rgba(0, 0, 0, 0.9); letter-spacing:
        0px; padding: 0.1em 0.5ex; word-spacing: -0.15em;
        background-color: rgb(247, 247, 248); border-radius: 4px;
        line-height: 1.45; text-rendering: optimizespeed; font-style:
        normal; font-variant-ligatures: normal; font-variant-caps:
        normal; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        -webkit-text-stroke-width: 0px; text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial;">rj</code><span style="color: rgba(0, 0, 0, 0.8);
        font-family: &quot;Noto Serif&quot;, &quot;DejaVu Serif&quot;,
        serif; font-size: 17px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: -0.17px; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;"><span> </span>is a large page (Huge
        Page) page table entry. In this case, after executing the<span> </span></span><code
        style="box-sizing: border-box; font-family: &quot;Droid Sans
        Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size:
        0.9375em; font-weight: 400; color: rgba(0, 0, 0, 0.9);
        letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
        -0.15em; background-color: rgb(247, 247, 248); border-radius:
        4px; line-height: 1.45; text-rendering: optimizespeed;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">LDDRI</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span> </span>instruction,
        the value in the general register<span> </span></span><code
        style="box-sizing: border-box; font-family: &quot;Droid Sans
        Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size:
        0.9375em; font-weight: 400; color: rgba(0, 0, 0, 0.9);
        letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
        -0.15em; background-color: rgb(247, 247, 248); border-radius:
        4px; line-height: 1.45; text-rendering: optimizespeed;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">rj</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span> </span>will
        be written directly to the general register<span> </span></span><code
        style="box-sizing: border-box; font-family: &quot;Droid Sans
        Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size:
        0.9375em; font-weight: 400; color: rgba(0, 0, 0, 0.9);
        letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
        -0.15em; background-color: rgb(247, 247, 248); border-radius:
        4px; line-height: 1.45; text-rendering: optimizespeed;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; orphans: 2; text-align: start;
        text-indent: 0px; text-transform: none; white-space: normal;
        widows: 2; -webkit-text-stroke-width: 0px;
        text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial;">rd</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">.</span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">The LDDIR_PS
        variable is not described in detail in the manual, but is only
        an intermediate variable to assist in page size calculation
        during tcg simulation.<br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">However, in
        section 5.4.2 TLB, we learned that TLB is divided into STLB and
        MTLB. <br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">The PS field
        in MTLB has the same meaning as the variable LDDIR_PS we
        defined. <br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">Since TLB is
        divided into parity entries, Therefore, when the TLB is
        generated, <br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">the size of
        each parity entry becomes half, that is, LDDIR_PS-1. <br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">It should be
        noted here that all large-page tlb entries will be placed in the
        MTLB, because the PS field is only meaningful in the MTLB.<br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">Thanks,</span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">Xianglai.</span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><br>
      </span></p>
    <blockquote type="cite"
      cite="mid:dd5d998d-2c2e-4757-8e18-ae424df4f6a2@linaro.org">
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------E02E5233BAB56D870F4B7EFD--


