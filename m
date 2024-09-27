Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0598CDD1B2
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 14:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suBZe-0002Ae-Bb; Fri, 27 Sep 2024 10:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@yeah.net>) id 1suBZb-0002A9-1l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:03:55 -0400
Received: from mail-m16.yeah.net ([220.197.32.18])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chao.liu@yeah.net>) id 1suBZW-0002Hs-0b
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 10:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
 s=s110527; h=Content-Type:Message-ID:Date:MIME-Version:Subject:
 From; bh=gaXNlViUM7krQ8Krz6jV1aIoi24Hxt3hFxv0GbccttY=; b=bg14MNn
 cfJU7MGO11NzsBxkiIrlL56DSr6WEL7Pn/3gMC/ix1Z4kIo7NghQ2rs1ytOTonUQ
 /uZQMWz/BwyhsYvHiz04q3+gbqR2wDg8UKg1Dvt2lCdoOBnCjUBP6uc4AuifQlj1
 6jyuJop5hb6e9smuyNfXP0wKuFooD48so09A=
Received: from [192.168.1.27] (unknown [])
 by gzsmtp1 (Coremail) with SMTP id Mc8vCgDHpKo0u_Zm5C48AQ--.50739S2;
 Fri, 27 Sep 2024 22:03:32 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------MTZnhK0WUxdmzQqofl9cOc1c"
Message-ID: <c9bfa6ba-7399-4edb-a882-7cb11e9d7b58@yeah.net>
Date: Fri, 27 Sep 2024 22:03:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Drop ignore_memory_transaction_failures for
 xilink_zynq
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, bin.meng@windriver.com, edgar.iglesias@gmail.com,
 alistair@alistair23.me
References: <cover.1727425255.git.chao.liu@yeah.net>
 <CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com>
From: Chao Liu <chao.liu@yeah.net>
In-Reply-To: <CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com>
X-CM-TRANSID: Mc8vCgDHpKo0u_Zm5C48AQ--.50739S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF48ZF17AFWfCw1UuryxuFg_yoW5WryUpr
 WxG3yUK3yktFyxuan7Zws7XF4qvws7Cr43Jr1rCw4v93Z8CwnrZrW0ga4Yva4UJr1vva1U
 Xw4UCw4DZ3WjyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07juCJPUUUUU=
X-Originating-IP: [117.173.247.123]
X-CM-SenderInfo: pfkd0hxolxq5hhdkh0dhw/1tbiEQlnKGb2lOZWxQAAsm
Received-SPF: pass client-ip=220.197.32.18; envelope-from=chao.liu@yeah.net;
 helo=mail-m16.yeah.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------MTZnhK0WUxdmzQqofl9cOc1c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/9/27 20:18, Peter Maydell wrote:

> On Fri, 27 Sept 2024 at 09:52, Chao Liu<chao.liu@yeah.net> wrote:
>> Hi, thank you for your prompt reply, it's a great encouragement to me!
>>
>> Based on your review suggestions, I have improved the v1 patch.
>>
>> By using create_unimplemented_device() during the initialization phase,
>> I added a "znyq.umip" device early on, which covers the 32-bit address space
>> of GPA. This can better serve as a replacement for the effect of the
>> ignore_memory_transaction_failures flag.
>>
>> Since create_unimplemented_device() sets the priority of the
>> memory region (mr) to -100, normally created devices will override the address
>> segments corresponding to the unimplemented devices.
>>
>> Even if our test set is not sufficiently comprehensive, we can create an
>> unimp_device for the maximum address space allowed by the board. This prevents
>> the guest system from triggering unexpected exceptions when accessing
>> unimplemented devices or regions.
> What would be the benefit of doing that? If we're going to
> say "we'll make accesses to regions without devices not
> generate faults", the simplest way to do that is to
> leave the ignore_memory_transaction_failures flag set
> the way it is.
>
> thanks
> -- PMM

I noticed that the `ignore_memory_transaction_failures` flag
was introduced in ed860129ac ("boards.h: Define new flag
ignore_memory_transaction_failures")

This approach was wise given the circumstances at the time.

Initially, this flag was added to ensure compatibility with the
RAZ/WI behavior in the ARM legacy board model.

Currently, only the ARM legacy board model uses this flag.

Introducing this flag provides a straightforward way to suppress
memory access exceptions by checking if the flag is enabled after
a CPU memory access failure; however,its primary purpose is to
ensure compatibility.

The purpose was to ensure that the ARM legacy board model behaves
as expected under conditions where thorough testing was not feasible.

Since we can designate unimplemented device memory ranges with
"unimplemented-device," this represents a more standard approach in QEMU
for managing RAZ/WI behavior.

However, this approach requires some effort.

Consequently, I have prioritized the removal of the
ignore_memory_transaction_failures flag on the Xilinx Zynq board
and aim to replace it with a more general solution to enhance design
simplicity and consistency.

If my approach is approved, I am very glad to systematically remove the
ignore_memory_transaction_failures flag from other ARM legacy boards and
ultimately eliminate it from the MachineClass.

This is my first attempt at contributing patches to the QEMU community,
and there is much for me to learn, and thanks for your patience and efforts!

Best regards,
Chao Liu

--------------MTZnhK0WUxdmzQqofl9cOc1c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <pre>On 2024/9/27 20:18, Peter Maydell wrote:</pre>
    <blockquote type="cite"
cite="mid:CAFEAcA8Kb-ym=Zd1TzcWuqRVbaKAG4TDF3VmZ8EfnBWW-B_Cyg@mail.gmail.com">
      <pre wrap="" class="moz-quote-pre">On Fri, 27 Sept 2024 at 09:52, Chao Liu <a class="moz-txt-link-rfc2396E" href="mailto:chao.liu@yeah.net">&lt;chao.liu@yeah.net&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">
Hi, thank you for your prompt reply, it's a great encouragement to me!

Based on your review suggestions, I have improved the v1 patch.

By using create_unimplemented_device() during the initialization phase,
I added a "znyq.umip" device early on, which covers the 32-bit address space
of GPA. This can better serve as a replacement for the effect of the
ignore_memory_transaction_failures flag.

Since create_unimplemented_device() sets the priority of the
memory region (mr) to -100, normally created devices will override the address
segments corresponding to the unimplemented devices.

Even if our test set is not sufficiently comprehensive, we can create an
unimp_device for the maximum address space allowed by the board. This prevents
the guest system from triggering unexpected exceptions when accessing
unimplemented devices or regions.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
What would be the benefit of doing that? If we're going to
say "we'll make accesses to regions without devices not
generate faults", the simplest way to do that is to
leave the ignore_memory_transaction_failures flag set
the way it is.

thanks
-- PMM
</pre>
    </blockquote>
    <pre>I noticed that the `ignore_memory_transaction_failures` flag
was introduced in ed860129ac ("boards.h: Define new flag
ignore_memory_transaction_failures")

This approach was wise given the circumstances at the time.

Initially, this flag was added to ensure compatibility with the
RAZ/WI behavior in the ARM legacy board model.

Currently, only the ARM legacy board model uses this flag.

Introducing this flag provides a straightforward way to suppress
memory access exceptions by checking if the flag is enabled after
a CPU memory access failure; however,its primary purpose is to
ensure compatibility.

The purpose was to ensure that the ARM legacy board model behaves
as expected under conditions where thorough testing was not feasible.

Since we can designate unimplemented device memory ranges with
"unimplemented-device," this represents a more standard approach in QEMU
for managing RAZ/WI behavior.

However, this approach requires some effort.

Consequently, I have prioritized the removal of the
ignore_memory_transaction_failures flag on the Xilinx Zynq board
and aim to replace it with a more general solution to enhance design
simplicity and consistency.

If my approach is approved, I am very glad to systematically remove the
ignore_memory_transaction_failures flag from other ARM legacy boards and
ultimately eliminate it from the MachineClass.

This is my first attempt at contributing patches to the QEMU community,
and there is much for me to learn, and thanks for your patience and efforts!

Best regards,
<span style="white-space: pre-wrap">Chao Liu
</span></pre>
  </body>
</html>

--------------MTZnhK0WUxdmzQqofl9cOc1c--


