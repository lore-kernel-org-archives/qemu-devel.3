Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BF4C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 04:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgGjG-0005KB-0l; Fri, 01 Mar 2024 23:12:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1rgFAX-0003RO-Ig
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 21:32:09 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1rgFAU-0007qy-Lk
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 21:32:09 -0500
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8DxdfGaj+JlyHUTAA--.49485S3;
 Sat, 02 Mar 2024 10:31:55 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx_xOWj+JlKiNMAA--.2856S2; 
 Sat, 02 Mar 2024 10:31:52 +0800 (CST)
Subject: Re: [PULL v2 1/1] loongarch: Change the UEFI loading mode to loongarch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Andrea Bolognani <abologna@redhat.com>,
 maobibo@loongson.cn, zhaotianrui@loongson.cn
References: <20240229113842.619738-1-gaosong@loongson.cn>
 <20240229113842.619738-2-gaosong@loongson.cn>
 <168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <5e2419ec-6c1f-e21c-2105-fadb5971239c@loongson.cn>
Date: Sat, 2 Mar 2024 10:31:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org>
Content-Type: multipart/alternative;
 boundary="------------F376EBF4DB57B5BCAEC0DC40"
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx_xOWj+JlKiNMAA--.2856S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WF1fWr43Cr17tFyfZrWrZwc_yoW8CF13pF
 yfC3Z8Wr4UJry7JFsxX3yIgrZxAr95KFyxXFsaqry8Grn8Aw1kXr1rKr1vyryfZayfJ3Wj
 vrWvkry8Wan8ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67
 AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1lYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx
 0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCjr7xv
 wVCIw2I0I7xG6c02F41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
 0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUb6nQUUUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-4.176, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
--------------F376EBF4DB57B5BCAEC0DC40
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Philippe:
> On 29/2/24 12:38, Song Gao wrote:
>> From: Xianglai Li <lixianglai@loongson.cn>
>>
>> The UEFI loading mode in loongarch is very different
>> from that in other architectures:loongarch's UEFI code
>> is in rom, while other architectures' UEFI code is in flash.
>>
>> loongarch UEFI can be loaded as follows:
>> -machine virt,pflash=pflash0-format
>> -bios ./QEMU_EFI.fd
>>
>> Other architectures load UEFI using the following methods:
>> -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
>>
>> loongarch's UEFI loading method makes qemu and libvirt incompatible
>> when using NVRAM, and the cost of loongarch's current loading method
>> far outweighs the benefits, so we decided to use the same UEFI loading
>> scheme as other architectures.
>
> FYI I'm still trying to find a way to avoid that, planning to discuss
> more with libvirt folks. Well, maybe it is a waste of my time and I
> should just stop worrying / caring about this long standing issue.
>
Thank you so much for your attention to this issue

and your long-standing contributions to the community!!:-)

Best regards,

Xianglai.


>> Cc: Andrea Bolognani <abologna@redhat.com>
>> Cc: maobibo@loongson.cn
>> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: zhaotianrui@loongson.cn
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> Tested-by: Andrea Bolognani <abologna@redhat.com>
>> Reviewed-by: Song Gao <gaosong@loongson.cn>
>> Message-Id: 
>> <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>> ---
>>   hw/loongarch/acpi-build.c   |  29 +++++++++--
>>   hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
>>   include/hw/loongarch/virt.h |  10 ++--
>>   3 files changed, 107 insertions(+), 33 deletions(-)
>

--------------F376EBF4DB57B5BCAEC0DC40
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Hi Philippe:<br>
    <blockquote type="cite"
      cite="mid:168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org">On
      29/2/24 12:38, Song Gao wrote:
      <br>
      <blockquote type="cite">From: Xianglai Li
        <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
        <br>
        <br>
        The UEFI loading mode in loongarch is very different
        <br>
        from that in other architectures:loongarch's UEFI code
        <br>
        is in rom, while other architectures' UEFI code is in flash.
        <br>
        <br>
        loongarch UEFI can be loaded as follows:
        <br>
        -machine virt,pflash=pflash0-format
        <br>
        -bios ./QEMU_EFI.fd
        <br>
        <br>
        Other architectures load UEFI using the following methods:
        <br>
        -machine virt,pflash0=pflash0-format,pflash1=pflash1-format
        <br>
        <br>
        loongarch's UEFI loading method makes qemu and libvirt
        incompatible
        <br>
        when using NVRAM, and the cost of loongarch's current loading
        method
        <br>
        far outweighs the benefits, so we decided to use the same UEFI
        loading
        <br>
        scheme as other architectures.
        <br>
      </blockquote>
      <br>
      FYI I'm still trying to find a way to avoid that, planning to
      discuss
      <br>
      more with libvirt folks. Well, maybe it is a waste of my time and
      I
      <br>
      should just stop worrying / caring about this long standing issue.
      <br>
      <br>
    </blockquote>
    <p>Thank you so much for your attention to this issue</p>
    <p>and your long-standing contributions to the community!!<span
        class="moz-smiley-s1"><span>:-)</span></span></p>
    <p><span style="color: rgb(25, 27, 31); font-family: -apple-system,
        BlinkMacSystemFont, &quot;Helvetica Neue&quot;, &quot;PingFang
        SC&quot;, &quot;Microsoft YaHei&quot;, &quot;Source Han Sans
        SC&quot;, &quot;Noto Sans CJK SC&quot;, &quot;WenQuanYi Micro
        Hei&quot;, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">Best regards,</span></p>
    <p><span style="color: rgb(25, 27, 31); font-family: -apple-system,
        BlinkMacSystemFont, &quot;Helvetica Neue&quot;, &quot;PingFang
        SC&quot;, &quot;Microsoft YaHei&quot;, &quot;Source Han Sans
        SC&quot;, &quot;Noto Sans CJK SC&quot;, &quot;WenQuanYi Micro
        Hei&quot;, sans-serif; font-size: 15px; font-style: normal;
        font-variant-ligatures: normal; font-variant-caps: normal;
        font-weight: 400; letter-spacing: normal; orphans: 2;
        text-align: start; text-indent: 0px; text-transform: none;
        white-space: normal; widows: 2; word-spacing: 0px;
        -webkit-text-stroke-width: 0px; background-color: rgb(255, 255,
        255); text-decoration-thickness: initial; text-decoration-style:
        initial; text-decoration-color: initial; display: inline
        !important; float: none;">Xianglai.<br>
      </span></p>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:168d29d9-b82e-4dd5-abdd-93759037033c@linaro.org">
      <blockquote type="cite">Cc: Andrea Bolognani
        <a class="moz-txt-link-rfc2396E" href="mailto:abologna@redhat.com">&lt;abologna@redhat.com&gt;</a>
        <br>
        Cc: <a class="moz-txt-link-abbreviated" href="mailto:maobibo@loongson.cn">maobibo@loongson.cn</a>
        <br>
        Cc: Philippe Mathieu-Daudé <a class="moz-txt-link-rfc2396E" href="mailto:philmd@linaro.org">&lt;philmd@linaro.org&gt;</a>
        <br>
        Cc: Song Gao <a class="moz-txt-link-rfc2396E" href="mailto:gaosong@loongson.cn">&lt;gaosong@loongson.cn&gt;</a>
        <br>
        Cc: <a class="moz-txt-link-abbreviated" href="mailto:zhaotianrui@loongson.cn">zhaotianrui@loongson.cn</a>
        <br>
        Signed-off-by: Xianglai Li <a class="moz-txt-link-rfc2396E" href="mailto:lixianglai@loongson.cn">&lt;lixianglai@loongson.cn&gt;</a>
        <br>
        Tested-by: Andrea Bolognani <a class="moz-txt-link-rfc2396E" href="mailto:abologna@redhat.com">&lt;abologna@redhat.com&gt;</a>
        <br>
        Reviewed-by: Song Gao <a class="moz-txt-link-rfc2396E" href="mailto:gaosong@loongson.cn">&lt;gaosong@loongson.cn&gt;</a>
        <br>
        Message-Id:
<a class="moz-txt-link-rfc2396E" href="mailto:0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn">&lt;0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn&gt;</a><br>
        Signed-off-by: Song Gao <a class="moz-txt-link-rfc2396E" href="mailto:gaosong@loongson.cn">&lt;gaosong@loongson.cn&gt;</a>
        <br>
        ---
        <br>
          hw/loongarch/acpi-build.c   |  29 +++++++++--
        <br>
          hw/loongarch/virt.c         | 101
        ++++++++++++++++++++++++++----------
        <br>
          include/hw/loongarch/virt.h |  10 ++--
        <br>
          3 files changed, 107 insertions(+), 33 deletions(-)
        <br>
      </blockquote>
      <br>
    </blockquote>
  </body>
</html>

--------------F376EBF4DB57B5BCAEC0DC40--


