Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B77FFEFB6C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 16:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw0Te-0006C0-0r; Fri, 27 Feb 2026 11:14:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw0Ta-0006Bl-3M; Fri, 27 Feb 2026 11:14:02 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vw0TX-0007SI-Dc; Fri, 27 Feb 2026 11:14:01 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwB3f2O4wqFpbk6YBw--.275S2;
 Sat, 28 Feb 2026 00:13:44 +0800 (CST)
Received: from [192.168.31.151] (unknown [113.246.232.133])
 by mail (Coremail) with SMTP id AQAAfwDHIO6mwqFpD7odAA--.51609S2;
 Sat, 28 Feb 2026 00:13:37 +0800 (CST)
Message-ID: <30491a30-6b3a-4fff-8325-da665ceed935@phytium.com.cn>
Date: Sat, 28 Feb 2026 00:13:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 31/31] [NOT-MERGE] hw/arm/smmuv3: temporarily enable SEL2
 bit and sone other features
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101933.2998060-1-tangtao1634@phytium.com.cn>
 <36f2aa40-1b01-4cb8-8546-06d9e770b30b@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <36f2aa40-1b01-4cb8-8546-06d9e770b30b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDHIO6mwqFpD7odAA--.51609S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQATBWmguFMsVgAPsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtF43Jr1fXr1UGFWUGFyrXrb_yoWkKrg_uw
 s2vrykurn7Zr48W3ZIyFn3ZFyku3WUtF9rKw1jyrWSqr9rJrZ0krs3K3s5Z3yYgan2k39x
 ZFnI9w43Z3y3ujkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Pierrick,

On 2026/2/26 05:31, Pierrick Bouvier wrote:
> On 2/21/26 2:19 AM, Tao Tang wrote:
>> Temporarily:
>> - enable S_IDR1.SEL2,
>> - change AIDR to 0x2 to indicate SMMUv3.2,
>> - use smaller SID size and Cmd/Evt queue size.
>>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> ---
>>   hw/arm/smmuv3.c                | 3 ++-
>>   include/hw/arm/smmuv3-common.h | 6 +++---
>>   2 files changed, 5 insertions(+), 4 deletions(-)
>>
>
> I have been able to boot hafnium with:
> - instructions at 
> https://hnusdr.github.io/2025/08/09/Test-Secure-SMMU-with-Hafnium-ENG/
> - the current patch
> - qemu-system-aarch64 -global arm-smmuv3.secure-impl=on ...
>
> In case someone else wants to reproduce this easily:
>
> ```
> git clone https://github.com/p-b-o/qemu-linux-stack
> cd qemu-linux-stack
> git checkout optee-secure-smmu
> ./build.sh # only requires podman and qemu-user-static
> ./run.sh /path/to/qemu-system-aarch64
> ```
>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


Thanks for the test!


Hafnium is indeed a good way to exercise Secure register and Secure 
command queue access.


Best regards,

Tao


