Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E514FE98FDD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 09:47:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAlyU-0005pU-Rc; Thu, 09 Apr 2026 05:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAlyR-0005ow-7g; Thu, 09 Apr 2026 05:46:55 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAlyO-00053C-9I; Thu, 09 Apr 2026 05:46:54 -0400
Received: from [10.213.22.34] (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowAAn0Wx8dddpsii6DA--.39971S2;
 Thu, 09 Apr 2026 17:46:36 +0800 (CST)
Message-ID: <18a3a770-9d57-47d1-9edf-ac55edccb8f9@iscas.ac.cn>
Date: Thu, 9 Apr 2026 17:46:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
 <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qwCowAAn0Wx8dddpsii6DA--.39971S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWkCr4rXFWfAFWUJF47Arb_yoW8Jw1UpF
 Z7GFyYkF1Skr4xGa9I93WIqF17KrsYga1jq34ayw18WF98ZrySqr4I93s0gw1UXFs7GFWY
 vFZIv3Z5XFZ5ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
 8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
 64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJw
 Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
 c7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
 1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
 14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
 IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
 87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
 UI43ZEXa7IUYh_-JUUUUU==
X-Originating-IP: [36.110.52.2]
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.21;
 envelope-from=wangruikang@iscas.ac.cn; helo=cstnet.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/9/26 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/4/26 08:40, Vivian Wang wrote:
>> The node unit addresses should be based on the reg value (which is in
>> turn based on MPIDR), rather than some arbitrary number [1]. Also, the=
y
>> should have been in hex, not decimal, as per de facto convention [2].
>> Fix them.
>>
>
> Maybe worth to add:
>
> =C2=A0=C2=A0=C2=A0 Cc: qemu-stable@nongnu.org
>
As Peter Maydell mentioned in other replies in this thread, most
software don't really care about these node names, so I don't think this
needs backporting to stable.

I'm unsure if this is still worth fixing then. Peter expressed that it's
not something worth fixing.

Thanks for your review,
Vivian "dramforever" Wang

>> Link:
>> https://github.com/devicetree-org/devicetree-specification/blob/v0.4/s=
ource/chapter2-devicetree-basics.rst#devicetree-structure-and-conventions=

>> # [1]
>> Link:
>> https://lore.kernel.org/devicetree-spec/CAL_JsqJFv3+UJ-bjLGk0i7Wc+spso=
wCrqQZ_s3P4gN8r1W-Q-w@mail.gmail.com/
>> # [2]
>> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
>> ---
>> =C2=A0 hw/arm/sbsa-ref.c | 4 ++--
>> =C2=A0 hw/arm/virt.c=C2=A0=C2=A0=C2=A0=C2=A0 | 7 +++++--
>> =C2=A0 2 files changed, 7 insertions(+), 4 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>


