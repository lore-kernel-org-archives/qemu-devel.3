Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A778FD006E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 15:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwiP8-00066V-JL; Sun, 01 Mar 2026 10:08:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwiP4-000665-8q; Sun, 01 Mar 2026 10:08:18 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vwiP1-0000Ue-OH; Sun, 01 Mar 2026 10:08:18 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXrUVWVqRpnEahAA--.19820S2;
 Sun, 01 Mar 2026 23:08:06 +0800 (CST)
Received: from [192.168.31.94] (unknown [113.246.118.211])
 by mail (Coremail) with SMTP id AQAAfwCH3epVVqRpDzAeAA--.37148S2;
 Sun, 01 Mar 2026 23:08:06 +0800 (CST)
Message-ID: <db70af79-b9ef-4da7-a561-850ad75ccb61@phytium.com.cn>
Date: Sun, 1 Mar 2026 23:08:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 13/31] hw/arm/smmu-common: Add sec_sid field to TLB
 entries
To: Mostafa Saleh <smostafa@google.com>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101640.2993566-1-tangtao1634@phytium.com.cn>
 <aaGuGuevX8HFqx0x@google.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <aaGuGuevX8HFqx0x@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwCH3epVVqRpDzAeAA--.37148S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWmiCd8FiAAHsT
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWruF48CFWfKFW3uF1DAw15CFg_yoWktrb_u3
 WkJryIyw4DJF45JF13KF4FyrWv9ayjgr18XrW8Xa9IkryUJFs7CanavwnYg3WfGws09r4a
 yr15Wa45C3sIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Mostafa,

On 2026/2/27 PM10:45, Mostafa Saleh wrote:
> On Sat, Feb 21, 2026 at 06:16:40PM +0800, Tao Tang wrote:
>> This is a non-functional preparation step that adds storage for
>> resolved security state in SMMUTLBEntry.
>>
> I am not sure about this, when I added stage-2 I re-used the same
> TLB instance as it might be used for nesting, and we can have
> end-to-end cached entires.
> For secure state, I think it’s cleaner to instantiate a new TLB, as
> both states can never mix, and in this case we can re-use the same
> functions without adding the secure bit in the TLB.


Thanks for the suggestion.

I agree that keeping separate TLB instances per security state is 
cleaner and avoids having to carry a sec_sid tag through every cache path.

The only downside is a bit more plumbing: we’ll need to make sure the 
translation/PTW paths always pick the right per-bank TLB (otherwise some 
call sites may still default to the NS one). This also means touching 
the common layer since smmu-common currently assumes a single s->iotlb.


Although some refactoring work is still needed, I’m happy to follow your 
approach and will rework this in V5.


>
> Thanks,
> Mostafa


Best regards,

Tao


