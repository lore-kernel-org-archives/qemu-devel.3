Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1007C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:14:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQI9-0003Si-EI; Wed, 27 Mar 2024 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rpQI7-0003SW-Px; Wed, 27 Mar 2024 06:13:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rpQI4-0003xY-Fm; Wed, 27 Mar 2024 06:13:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48D085959F;
 Wed, 27 Mar 2024 13:15:11 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 09FF1A4743;
 Wed, 27 Mar 2024 13:13:40 +0300 (MSK)
Message-ID: <04da79ed-75f5-4a90-b301-7aa11084d347@tls.msk.ru>
Date: Wed, 27 Mar 2024 13:13:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/15] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20240322085319.1758843-1-alistair.francis@wdc.com>
 <5eb1ce03-639a-4db3-a1e2-aba61fa295d1@tls.msk.ru>
 <76c065d8-41ee-433d-ba40-e1d13579b4a4@ventanamicro.com>
 <6d1ea7ad-0a81-4f5e-8210-80b5150bc521@tls.msk.ru>
 <6fb5ca42-8e86-4144-b9a9-9d98d30f8fb9@ventanamicro.com>
 <19d5ffb8-8cf1-4d88-b66a-2cf961621b93@tls.msk.ru>
 <CAKmqyKOG1sr269TDERsGEvbAJfJ_MTtW-smMCdDUBbYaGwkPGA@mail.gmail.com>
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 xsBLBETIiwkBCADh3cFB56BQYPjtMZCfK6PSLR8lw8EB20rsrPeJtd91IoNZlnCjSoxd9Th1
 bLUR8YlpRJ2rjc6O1Bc04VghqUOHgS/tYt8vLjcGWixzdhSLJgPDK3QQZPAvBjMbCt1B6euC
 WuD87Pv5Udlpnzf4aMwxkgfTusx+ynae/o+T5r7tXD+isccbC3SiGhmAPxFyY3zGcFk4+Rxc
 0tP8YY2FWE/baHu+lBDTUN79efWAkHhex1XzVZsV7ZD16rzDbXFK5m6ApvGJWlr5YDEEydTF
 WwmvwBfr4OINVxzEG/ujNiG4fpMf2NsnFGyB9aSbFjXZevB4qWkduYYW+xpK1EryszHtAAYp
 zSBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1PsLAlgQTAQoAQAIbAwYLCQgHAwIE
 FQIIAwQWAgMBAh4BAheAAhkBFiEEbuGV0Yhuj/uBDUMkRXzgoIBEZcUFAmBbcjwFCS5e6jMA
 CgkQRXzgoIBEZcUTIQgA1hPsOF82pXxbcJXBMc4zB9OQu4AlnZvERoGyw7I2222QzaN3RFuj
 Fia//mapXzpIQNF08l/AA6cx+CKPeGnXwyZfF9fLa4RfifmdNKME8C00XlqnoJDZBGzq8yMy
 LAKDxl9OQWFcDwDxV+irg5U3fbtNVhvV0kLbS2TyQ0aU5w60ERS2NcyDWplOo7AOzZWChcA4
 UFf78oVdZdCW8YDtU0uQFhA9moNnrePy1HSFqduxnlFHEI+fDj/TiOm2ci48b8SBBJOIJFjl
 SBgH8+SfT9ZqkzhN9vh3YJ49831NwASVm0x1rDHcIwWD32VFZViZ3NjehogRNH9br0PSUYOC
 3s7ATQRX2BjLAQgAnak3m0imYOkv2tO/olULFa686tlwuvl5kL0NWCdGQeXv2uMxy36szcrh
 K1uYhpiQv4r2qNd8BJtYlnYIK16N8GBdkplaDIHcBMbU4t+6bQzEIJIaWoq1hzakmHHngE2a
 pNMnUf/01GFvCRPlv3imkujE/5ILbagjtdyJaHF0wGOSlTnNT4W8j+zPJ/XK0I5EVQwtbmoc
 GY62LKxxz2pID6sPZV4zQVY4JdUQaFvOz1emnBxakkt0cq3Qnnqso1tjiy7vyH9CAwPR/48W
 fpK6dew4Fk+STYtBeixOTfSUS8qRS/wfpUeNa5RnEdTtFQ9IcjpQ/nPrvJJsu9FqwlpjMwAR
 AQABwsBlBBgBCAAPBQJX2BjLAhsMBQkSzAMAAAoJEEV84KCARGXFUKcH/jqKETECkbyPktdP
 cWVqw2ZIsmGxMkIdnZTbPwhORseGXMHadQODayhU9GWfCDdSPkWDWzMamD+qStfl9MhlVT60
 HTbo6wu1W/ogUS70qQPTY9IfsvAj6f8TlSlK0eLMa3s2UxL2oe5FkNs2CnVeRlr4Yqvp/ZQV
 6LXtew4GPRrmplUT/Cre9QIUqR4pxYCQaMoOXQQw3Y0csBwoDYUQujn3slbDJRIweHoppBzT
 rM6ZG5ldWQN3n3d71pVuv80guylX8+TSB8Mvkqwb5I36/NAFKl0CbGbTuQli7SmNiTAKilXc
 Y5Uh9PIrmixt0JrmGVRzke6+11mTjVlio/J5dCM=
In-Reply-To: <CAKmqyKOG1sr269TDERsGEvbAJfJ_MTtW-smMCdDUBbYaGwkPGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

26.03.2024 12:56, Alistair Francis пишет:
> On Tue, Mar 26, 2024 at 7:53 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
>>
>> On 24.03.2024 21:12, Daniel Henrique Barboza wrote:
>>> On 3/24/24 12:07, Michael Tokarev wrote:
>>
>>>> Unfortunately this doesn't quite work, the following changes
>>>> fail to apply to 8.2:
>>>>
>>>> 929e521a47 target/riscv: always clear vstart for ldst_whole insns
>>>> b46631f122 target/riscv: remove 'over' brconds from vector trans
>>>> d57dfe4b37 trans_rvv.c.inc: remove redundant mark_vs_dirty() calls
>>>> bac802ada8 target/riscv: enable 'vstart_eq_zero' in the end of insns
>>>> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
>>
>>> The amount of work can be non-trivial for this backport, so I'd say we should
>>> leave it aside for now. If someone has a good argument for this work then we
>>> can re-evaluate.
>>
>> So, out of 15 patches in this series (minus the first one already
>> mentioned) - should I pick 9 remaining patches for stable (the ones
>> which applies) or none at all? :)
> 
> Sorry for the confusion.
> 
> The 9 patches that applied and
> 
> 385e575cd5 target/riscv/kvm: fix timebase-frequency when using KVM acceleration
> 
> should all be picked for stable.

Got it, picked all plus 385e575cd5 which needed just trivial context fixup.
Thank you for the clarification!

> PS: What is the best way in future to help ease some of the stable
> burden? Should I try and cherry pick them beforehand and then mention
> that as a follow up to the PR?

The only problem for me so far is the patch selection, - this is why I'm
asking to Cc changes which should go to stable, to qemu-stable@.  So far
I was a bit pro-active and asked about some changes which I *feel* are
suitable, like in this case.  It is much better if someone who actually
has knowledge about the area being changed, decides if it's stable material
or not.  At the same time, I don't mind at all if more changes than needed
are Cc'ed like this, - at least as long as it's obvious they're not really
needed (like fixing a bug introduced in commit which isn't in any release
yet).

I usually don't have any issues with applying patches which don't apply
directly to stable - this is not a burden.  In some cases when this happens,
I can edit the commit (like I just did for 385e575cd5), or pick some previous
changes too if they're okay, or in even more rare cases, ask for clarification
or even for help with back-porting, - but this last category is really rare.

Some changes gets rejected for stable in the end due to too much back-porting
effort or requiring too much prior context.

So the only real issue for me is to know which changes are to pick, - that's all.
And this is the only thing I'm asking, - in this thread and elsewhere.

Thank you!

/mjt

