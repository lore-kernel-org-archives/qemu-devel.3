Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E38CEA3C21
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 10:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAmOJ-00069Y-3k; Thu, 09 Apr 2026 06:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAmOF-00069K-Bo; Thu, 09 Apr 2026 06:13:35 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <wangruikang@iscas.ac.cn>)
 id 1wAmOA-0003uG-Jc; Thu, 09 Apr 2026 06:13:33 -0400
Received: from [10.213.22.34] (unknown [36.110.52.2])
 by APP-01 (Coremail) with SMTP id qwCowADXfmq6e9dpZJm6DA--.7959S2;
 Thu, 09 Apr 2026 18:13:15 +0800 (CST)
Message-ID: <4a1718a3-aac0-47ce-a18a-8c3be6278d2c@iscas.ac.cn>
Date: Thu, 9 Apr 2026 18:13:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/arm: Fix unit addresses of FDT CPU nodes
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Jia Liu <proljc@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org
References: <20260409-fix-unit-address-v1-0-946840930af2@iscas.ac.cn>
 <20260409-fix-unit-address-v1-1-946840930af2@iscas.ac.cn>
 <b7273509-0161-4b2e-bf4d-28b648f71209@linaro.org>
 <18a3a770-9d57-47d1-9edf-ac55edccb8f9@iscas.ac.cn>
 <CAFEAcA-mTY3VksBcANok4+49UvVDv_w9X6ubKooQZ-kvWZ7r1Q@mail.gmail.com>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <CAFEAcA-mTY3VksBcANok4+49UvVDv_w9X6ubKooQZ-kvWZ7r1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: qwCowADXfmq6e9dpZJm6DA--.7959S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw47tw4rJrW5ZFWrWF48Zwb_yoW8tr48pa
 93KF1IkFs2yr1xW34vva17Zw1Ikwn3Gr4UX3s0q342y398WF1fKF4Igryaga48Gw48GFWj
 van0qas5JF1Fv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUU9Eb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
 0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
 A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
 jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
 A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
 w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ec7CjxVAajcxG14v26r1j6r
 4UMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l
 FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr4
 1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
 67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
 8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAv
 wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
 v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUYmksPUUUUU==
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

On 4/9/26 18:01, Peter Maydell wrote:
> On Thu, 9 Apr 2026 at 10:46, Vivian Wang <wangruikang@iscas.ac.cn> wrot=
e:
>> On 4/9/26 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 9/4/26 08:40, Vivian Wang wrote:
>>>> The node unit addresses should be based on the reg value (which is i=
n
>>>> turn based on MPIDR), rather than some arbitrary number [1]. Also, t=
hey
>>>> should have been in hex, not decimal, as per de facto convention [2]=
=2E
>>>> Fix them.
>>>>
>>> Maybe worth to add:
>>>
>>>     Cc: qemu-stable@nongnu.org
>>>
>> As Peter Maydell mentioned in other replies in this thread, most
>> software don't really care about these node names, so I don't think th=
is
>> needs backporting to stable.
>>
>> I'm unsure if this is still worth fixing then. Peter expressed that it=
's
>> not something worth fixing.
> For the virt board, I think it depends whether the spec really says
> that the node name must have the MPIDR in it and that consumers
> can rely on that as a source of the MPIDR. I hope it does not.
> If it's just a node name, then I don't see why it matters what
> node name we generate as long as we're not generating the same
> nodename twice. We're not trying to generate DT files that are
> intended for submission upstream.
>
> There are other places where our nodenames don't match the
> conventions upstream prefers; I generally prefer not to mess with
> the existing working code in QEMU unless there's something actually
> broken about what we're doing. Thread from the last time this came up:
>
> https://lore.kernel.org/qemu-devel/CAFEAcA9OWDiWh3S=3D0Co7Z27EtOp-1B9H7=
FxyQy1T2sFnTyNdqA@mail.gmail.com/
>
> Essentially, the set of things that it makes sense to have a
> convention for and perhaps to validate for a hand-written DTS
> file is stricter than the set of actual requirements for a
> generated DTB, and I prefer not to potentially break some
> guest code that's looking for a particular node name purely
> to bring us in to line with conventions intended for
> hand-written DTS files.

Thanks for the explanation. I can understand that these DTBs don't
really need to be held up to the same standards/pedantry as Linux
upstream DTS files.

Thanks,
Vivian "dramforever" Wang


