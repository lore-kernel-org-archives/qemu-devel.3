Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B3BD29C43
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhsTP-0000Tr-KK; Mon, 19 Jan 2026 11:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhsTN-0000TW-Ag; Mon, 19 Jan 2026 11:51:25 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vhsTK-000672-3S; Mon, 19 Jan 2026 11:51:25 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnrCQDYW5pJag4Aw--.20932S2;
 Tue, 20 Jan 2026 00:51:15 +0800 (CST)
Received: from [192.168.31.151] (unknown [222.244.183.203])
 by mail (Coremail) with SMTP id AQAAfwBXse4BYW5pWfMUAA--.22069S2;
 Tue, 20 Jan 2026 00:51:14 +0800 (CST)
Message-ID: <0e71fdee-3569-4f83-afc8-46e0cbe565d0@phytium.com.cn>
Date: Tue, 20 Jan 2026 00:51:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v9 2/8] hw/arm/smmuv3-common: Define STE/CD fields via
 registerfields
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mostafa Saleh <smostafa@google.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
References: <20260119161112.3841386-1-tangtao1634@phytium.com.cn>
 <20260119161112.3841386-3-tangtao1634@phytium.com.cn>
 <fa73ef10-4a1e-486d-9d80-550c91eef11f@linaro.org>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <fa73ef10-4a1e-486d-9d80-550c91eef11f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwBXse4BYW5pWfMUAA--.22069S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWltPrkFOAACs4
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtrW5Gr43Jr18XF17CF18AFb_yoWkZFb_AF
 WvqFy8ur4DGFs3JFyUGF13Zr93Kw4jkrWUXFs8Xr45Gr90qryDZFs8t39Yvw43Wa1DJryr
 GanIv3yrJFyjqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

On 2026/1/20 00:38, Philippe Mathieu-Daudé wrote:
> On 19/1/26 17:11, Tao Tang wrote:
>> Switch STE/CD bitfield definitions and accessors to the
>> 'registerfields.h' REG/FIELD API.
>>
>> FOLLOW-UP: Fix CTXPTR_HI/S2TTB_HI/TTB0_HI/TTB1_HI high bits width
>> (should be 24 bits, not 16).
>
> Right, but ...
>
>> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>   include/hw/arm/smmuv3-common.h | 169 +++++++++++++++++++++++----------
>>   1 file changed, 120 insertions(+), 49 deletions(-)
>
>
>> -#define STE_VALID(x) extract32((x)->word[0], 0, 1)
>> +REG32(STE_0, 0)
>> +    FIELD(STE_0, VALID, 0, 1)
>> +    FIELD(STE_0, CONFIG, 1, 3)
>> +    FIELD(STE_0, S1FMT, 4, 2)
>> +    FIELD(STE_0, CTXPTR_LO, 6, 26)
>> +REG32(STE_1, 4)
>> +    FIELD(STE_1, CTXPTR_HI, 0, 16)
>
> ... not followed up?


Sorry, there's a typo here. What I was thinking at the time was that I 
would submit a separate patch follow this series.

Do you need me to resend this series?

Best regards,

Tao


