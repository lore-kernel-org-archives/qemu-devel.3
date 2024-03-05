Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C64C5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOAy-0001Fb-R1; Tue, 05 Mar 2024 01:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rhOAv-0001Ca-GD
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:21:17 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rhOAr-0001TL-6l
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:21:17 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxOPDSueZlJ5wUAA--.51941S3;
 Tue, 05 Mar 2024 14:21:07 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxM8zNueZl2VZOAA--.3108S2; 
 Tue, 05 Mar 2024 14:21:04 +0800 (CST)
Subject: Re: [PATCH V2 1/1] target/loongarch: Fixed tlb huge page loading issue
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, Song Gao <gaosong@loongson.cn>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, zhaotianrui@loongson.cn
References: <cover.1709610311.git.lixianglai@loongson.cn>
 <5b23421ee1ebf59142c7d7a3bc1082fff910f2fa.1709610311.git.lixianglai@loongson.cn>
 <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <aa2670bd-b01d-6cc5-d6ad-9e807ed0abe4@loongson.cn>
Date: Tue, 5 Mar 2024 14:21:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------8C3862C36770D38D452F7C98"
Content-Language: en-US
X-CM-TRANSID: AQAAf8DxM8zNueZl2VZOAA--.3108S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DJw1DKr48Wr1xXFyrGrX_yoW5JFy5pF
 WfZ34fKr4ktrZ7Gwn7X3yUW343Aws7G3y7uF1xAa4rCwn8J34IvF40yrWq9F1UAFWfJFy8
 Xr4jyr17Za1kZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67
 AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq
 07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1lYx0E2Ix0cI8IcVAFwI0_JrI_Jr
 ylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCj
 r7xvwVCIw2I0I7xG6c02F41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrw
 CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE
 14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
 IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxK
 x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
 0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUb6nQUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 HTML_OBFUSCATE_05_10=0.26, NICE_REPLY_A=-4.098, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
--------------8C3862C36770D38D452F7C98
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Richard:
> On 3/4/24 17:51, Xianglai Li wrote:
>> When we use qemu tcg simulation, the page size of bios is 4KB.
>> When using the level 2 super large page (page size is 1G) to create 
>> the page table,
>> it is found that the content of the corresponding address space is 
>> abnormal,
>> resulting in the bios can not start the operating system and 
>> graphical interface normally.
>>
>> The lddir and ldpte instruction emulation has
>> a problem with the use of super large page processing above level 2.
>> The page size is not correctly calculated,
>> resulting in the wrong page size of the table entry found by tlb.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> Cc: maobibo@loongson.cn
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: zhaotianrui@loongson.cn
>> ---
>>   target/loongarch/cpu.h            |  1 +
>>   target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
>>   2 files changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
>> index ec37579fd6..eab3e41c71 100644
>> --- a/target/loongarch/cpu.h
>> +++ b/target/loongarch/cpu.h
>> @@ -292,6 +292,7 @@ typedef struct CPUArchState {
>>       uint32_t fcsr0_mask;
>>         uint32_t cpucfg[21];
>> +    uint32_t lddir_ps;
>
> This magical cpu state does not appear in the manual.

The hardware instruction manual is hosted on github at

https://github.com/loongson/LoongArch-Documentation

> Are you sure that large pages above level 2 are really supported by 
> LDDIR?


Yes,We have done tests on the physical cpu of loongarch64 and

it works fine with a level 2 large page on the physical cpu.


>
> Some explanation from the hardware engineering side is required.

The description of lddir hardware manual is as follows:


Instruction formats:

|lddir rd, rj, level|

The|LDDIR|instruction is used for accessing directory entries during 
software page table walking.

If bit|[6]|of the general register|rj|is|0|, it means that the content 
of|rj|is the physical address of the

base address of the level page table at this time. In this case, 
the|LDDIR|instruction will access the level

page table according to the current TLB refill address, retrieve the 
base address of the corresponding

|level+1|page table, and write it to the general register|rd|.


reference:

https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html


          4.2.5.1.|LDDIR|

Thanks,

Xianglai.


>
> r~

--------------8C3862C36770D38D452F7C98
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Richard:<br>
    <blockquote type="cite"
      cite="mid:5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org">On
      3/4/24 17:51, Xianglai Li wrote:
      <br>
      <blockquote type="cite">When we use qemu tcg simulation, the page
        size of bios is 4KB.
        <br>
        When using the level 2 super large page (page size is 1G) to
        create the page table,
        <br>
        it is found that the content of the corresponding address space
        is abnormal,
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
          target/loongarch/tcg/tlb_helper.c | 21 ++++++++++++---------
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
    <p>The hardware instruction manual is hosted on github at</p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/loongson/LoongArch-Documentation">https://github.com/loongson/LoongArch-Documentation</a></p>
    <blockquote type="cite"
      cite="mid:5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org">Are you
      sure that large pages above level 2 are really supported by LDDIR?
      <br>
    </blockquote>
    <p><br>
    </p>
    <p>Yes,We have done tests on the physical cpu of loongarch64 and <br>
    </p>
    <p>it works fine with a level 2 large page on the physical cpu.</p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org">
      <br>
      Some explanation from the hardware engineering side is required.
      <br>
    </blockquote>
    <p>The description of lddir hardware manual is as follows:</p>
    <p><br>
    </p>
    <div class="paragraph" style="box-sizing: border-box; margin: 0px;
      padding: 0px; direction: ltr; color: rgba(0, 0, 0, 0.8);
      font-family: &quot;Noto Serif&quot;, &quot;DejaVu Serif&quot;,
      serif; font-size: 16px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255);
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial;">
      <p style="box-sizing: border-box; margin: 0px 0px 1.25rem;
        padding: 0px; direction: ltr; font-family: inherit; font-weight:
        400; font-size: 1.0625rem; line-height: 1.6; text-rendering:
        optimizelegibility; letter-spacing: -0.01em;">Instruction
        formats:</p>
    </div>
    <div class="listingblock" style="box-sizing: border-box; margin: 0px
      0px 1.25em; padding: 0px; direction: ltr; color: rgba(0, 0, 0,
      0.8); font-family: &quot;Noto Serif&quot;, &quot;DejaVu
      Serif&quot;, serif; font-size: 16px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255);
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial;">
      <div class="content" style="box-sizing: border-box; margin: 0px;
        padding: 0px; direction: ltr; position: relative;">
        <pre class="highlight" style="box-sizing: border-box; font-family: &quot;Droid Sans Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size: 1em; white-space: pre-wrap; margin: 0px; padding: 1em; direction: ltr; line-height: 1.45; color: rgba(0, 0, 0, 0.9); font-weight: 400; text-rendering: optimizespeed; border-radius: 4px; overflow-wrap: break-word; background: rgb(247, 247, 248);"><code style="box-sizing: border-box; font-family: &quot;Droid Sans Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace; font-size: 1em; font-weight: 400; color: rgba(0, 0, 0, 0.9); line-height: 1.45; text-rendering: optimizespeed;">lddir   rd, rj, level</code></pre>
      </div>
    </div>
    <div class="paragraph" style="box-sizing: border-box; margin: 0px;
      padding: 0px; direction: ltr; color: rgba(0, 0, 0, 0.8);
      font-family: &quot;Noto Serif&quot;, &quot;DejaVu Serif&quot;,
      serif; font-size: 16px; font-style: normal;
      font-variant-ligatures: normal; font-variant-caps: normal;
      font-weight: 400; letter-spacing: normal; orphans: 2; text-align:
      start; text-indent: 0px; text-transform: none; white-space:
      normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width:
      0px; background-color: rgb(255, 255, 255);
      text-decoration-thickness: initial; text-decoration-style:
      initial; text-decoration-color: initial;">
      <p style="box-sizing: border-box; margin: 0px 0px 1.25rem;
        padding: 0px; direction: ltr; font-family: inherit; font-weight:
        400; font-size: 1.0625rem; line-height: 1.6; text-rendering:
        optimizelegibility; letter-spacing: -0.01em;">The<span> </span><code
          style="box-sizing: border-box; font-family: &quot;Droid Sans
          Mono&quot;, &quot;DejaVu Sans Mono&quot;, monospace;
          font-size: 0.9375em; font-weight: 400; color: rgba(0, 0, 0,
          0.9); letter-spacing: 0px; padding: 0.1em 0.5ex; word-spacing:
          -0.15em; background-color: rgb(247, 247, 248); border-radius:
          4px; line-height: 1.45; text-rendering: optimizespeed;
          font-style: normal !important;">LDDIR</code><span> </span>instruction
        is used for accessing directory entries during software page
        table walking.</p>
    </div>
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
        the general register<span> </span></span><code
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
        initial; display: inline !important; float: none;"><span> </span>is<span> </span></span><code
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
        initial; text-decoration-color: initial;">0</code><span
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
        that the content of<span> </span></span><code style="box-sizing:
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
        !important; float: none;"><span> </span>is the physical address
        of the</span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">base address
        of the level page table at this time. In this case, the<span> </span></span><code
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
        initial; text-decoration-color: initial;">LDDIR</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span> </span>instruction
        will access the level</span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;">page table
        according to the current TLB refill address, retrieve the base
        address of the corresponding<span><br>
        </span></span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span></span></span><code
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
        initial; text-decoration-color: initial;">level+1</code><span
        style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span> </span>page
        table, and write it to the general register<span> </span></span><code
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
    <p><br>
      <span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><span
          style="color: rgb(90, 117, 224); font-family: Gilroy,
          &quot;PingFang SC&quot;; font-size: 16px; font-style: normal;
          font-variant-ligatures: normal; font-variant-caps: normal;
          font-weight: 400; letter-spacing: normal; orphans: 2;
          text-align: start; text-indent: 0px; text-transform: none;
          white-space: normal; widows: 2; word-spacing: 0px;
          -webkit-text-stroke-width: 0px; background-color: rgb(255,
          255, 255); text-decoration-thickness: initial;
          text-decoration-style: initial; text-decoration-color:
          initial; display: inline !important; float: none;">reference:</span></span></p>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"><a class="moz-txt-link-freetext" href="https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html">https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html</a></span></p>
    <h5 id="_lddir" style="box-sizing: border-box; margin: 1em 0px
      0.5em; padding: 0px; direction: ltr; font-family: &quot;Open
      Sans&quot;, &quot;DejaVu Sans&quot;, sans-serif; font-weight: 300;
      font-style: normal; color: rgb(186, 57, 37); text-rendering:
      optimizelegibility; line-height: 1.2; font-size: 1.125em;
      word-spacing: -0.05em; font-variant-ligatures: normal;
      font-variant-caps: normal; letter-spacing: normal; orphans: 2;
      text-align: start; text-indent: 0px; text-transform: none;
      white-space: normal; widows: 2; -webkit-text-stroke-width: 0px;
      background-color: rgb(255, 255, 255); text-decoration-thickness:
      initial; text-decoration-style: initial; text-decoration-color:
      initial;">4.2.5.1.<span> </span><code style="box-sizing:
        border-box; font-family: &quot;Droid Sans Mono&quot;,
        &quot;DejaVu Sans Mono&quot;, monospace; font-size: 0.9375em;
        font-weight: 400; color: rgba(0, 0, 0, 0.9); letter-spacing:
        0px; padding: 0.1em 0.5ex; word-spacing: -0.15em;
        background-color: rgb(247, 247, 248); border-radius: 4px;
        line-height: 1.45; text-rendering: optimizespeed; font-style:
        normal !important;">LDDIR</code></h5>
    <p><span style="color: rgba(0, 0, 0, 0.8); font-family: &quot;Noto
        Serif&quot;, &quot;DejaVu Serif&quot;, serif; font-size: 17px;
        font-style: normal; font-variant-ligatures: normal;
        font-variant-caps: normal; font-weight: 400; letter-spacing:
        -0.17px; orphans: 2; text-align: start; text-indent: 0px;
        text-transform: none; white-space: normal; widows: 2;
        word-spacing: 0px; -webkit-text-stroke-width: 0px;
        background-color: rgb(255, 255, 255); text-decoration-thickness:
        initial; text-decoration-style: initial; text-decoration-color:
        initial; display: inline !important; float: none;"></span></p>
    <p>Thanks,</p>
    <p>Xianglai.<br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:5d3c7aa7-16d2-4812-a72b-dae5e567b9b8@linaro.org">
      <br>
      r~
      <br>
    </blockquote>
  </body>
</html>

--------------8C3862C36770D38D452F7C98--


