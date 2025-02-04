Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE62C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 12:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfHvB-00082d-PN; Tue, 04 Feb 2025 07:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tfHv8-00081j-EG; Tue, 04 Feb 2025 07:20:50 -0500
Received: from mail-gw01.astralinux.ru ([37.230.196.243])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsogomonian@astralinux.ru>)
 id 1tfHv6-0001o8-Cw; Tue, 04 Feb 2025 07:20:50 -0500
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
 by mail-gw01.astralinux.ru (Postfix) with ESMTP id 7833624D52;
 Tue,  4 Feb 2025 15:20:40 +0300 (MSK)
Received: from new-mail.astralinux.ru (gca-yc-ruca-srv-mail05.astralinux.ru
 [10.177.185.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
 Tue,  4 Feb 2025 15:20:39 +0300 (MSK)
Received: from [10.198.25.85] (unknown [10.198.25.85])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4YnMs252mtz1c051;
 Tue,  4 Feb 2025 15:20:38 +0300 (MSK)
Message-ID: <8d69e742-850f-482a-ad47-d61c8cf6c702@astralinux.ru>
Date: Tue, 4 Feb 2025 15:20:21 +0300
MIME-Version: 1.0
User-Agent: RuPost Desktop
Subject: Re: [PATCH v2] hw/misc: use extract64 instead of 1 << i
To: Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
References: <20241227104618.2526-1-tsogomonian@astralinux.ru>
 <8ff6dac5-067a-430e-90c2-67e07ba221a2@linaro.org>
Content-Language: ru
From: =?UTF-8?B?0KLQuNCz0YDQsNC9INCh0L7Qs9C+0LzQvtC90Y/QvQ==?=
 <tsogomonian@astralinux.ru>
In-Reply-To: <8ff6dac5-067a-430e-90c2-67e07ba221a2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: tsogomonian@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 50 0.3.50
 df4aeb250ed63fd3baa80a493fa6caee5dd9e10f,
 {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 new-mail.astralinux.ru:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 190775 [Feb 04 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854,
 bases: 2025/02/04 04:59:00 #27206785
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1
Received-SPF: pass client-ip=37.230.196.243;
 envelope-from=tsogomonian@astralinux.ru; helo=mail-gw01.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

27/12/24 18:16, Richard Henderson пишет:
> On 12/27/24 02:46, Tigran Sogomonian wrote:
>> 1 << i is casted to uint64_t while bitwise and with val.
>> So this value may become 0xffffffff80000000 but only
>> 31th "start" bit is required.
>> Use the bitfield extract() API instead.
>
> Again, I < 32.  There is no overflow.  The type of value is irrelevant.
>
s->num_leds maximum MPS2FPGAIO_MAX_LEDS (32). For bitwise AND, the 
result of shift 1 << i will be converted to uint64_t because value is of 
type uint64_t (integer promotion) and for i = 31 instead of the expected 
0b10000000000000000000000000000000  we get 
0b1111111111111111111111111111111100000000000000000000000000000000. Need 
to be corrected to value & (1U << i).
>
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
>> ---
>>   hw/misc/mps2-fpgaio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
>> index d07568248d..04a3da5db0 100644
>> --- a/hw/misc/mps2-fpgaio.c
>> +++ b/hw/misc/mps2-fpgaio.c
>> @@ -198,7 +198,7 @@ static void mps2_fpgaio_write(void *opaque, 
>> hwaddr offset, uint64_t value,
>>                 s->led0 = value & MAKE_64BIT_MASK(0, s->num_leds);
>>               for (i = 0; i < s->num_leds; i++) {
>> -                led_set_state(s->led[i], value & (1 << i));
>> +                led_set_state(s->led[i], extract64(value, i, 1));
>>               }
>>           }
>>           break;
>
>


