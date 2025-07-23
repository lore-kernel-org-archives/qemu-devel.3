Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C813C83F1A
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 14:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueath-0008T1-N0; Wed, 23 Jul 2025 10:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1ueasy-0008Mp-S0; Wed, 23 Jul 2025 10:56:04 -0400
Received: from imap4.hz.codethink.co.uk ([188.40.203.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ben.dooks@codethink.co.uk>)
 id 1ueasu-00071g-Bl; Wed, 23 Jul 2025 10:55:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F/NAJFev1Ct4QYlgSCbImDamTclaCPREwngnuK16hFI=; b=hdYkuFYEjfYEIADMS9q+j/Jigm
 94B2m/GqJV0pF3q77W+Ra6nneF9ZHl0NQyHDSO4t6UD9/AwA0bOIcsU/kLzz+AIHxSXLPcohahwMH
 YjhMPQFWRoTlAP4MqDllkBthMBpBIRymWFjswwbUr2YbOx96/p2AI8EBCSktUcorFKk2EcN0RsP/x
 +6sTcOCOWKz/+hwa81dv/cBxHL8WSVeXafK9uTafel7s1KDAIqqdpK21Gct2k1vwDAUnfYWT6lePz
 RQYAO3zKD9zPJ3//sVfjjdh0ZWxLKqCGpyrgNb5uEKxzj/4iJicro8cx0fMxLOJ/QcOb6thPw7uj/
 iOlB5Smw==;
Received: from [63.135.74.212] (helo=[192.168.1.249])
 by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
 id 1ueask-0012xW-8u; Wed, 23 Jul 2025 15:55:47 +0100
Message-ID: <197dd05a-eda5-44e0-9592-b886e953086f@codethink.co.uk>
Date: Wed, 23 Jul 2025 15:55:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/sd: print bad s->arglen in unexpected response
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>
References: <20250722090547.109117-1-ben.dooks@codethink.co.uk>
 <87seinulb7.fsf@draig.linaro.org>
 <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
Content-Language: en-GB
From: Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <CAFEAcA8c0GRxvXUANBbNvMdTqBwBgCjTZkqc2RNjE8bRQo772w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=188.40.203.114;
 envelope-from=ben.dooks@codethink.co.uk; helo=imap4.hz.codethink.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 23/07/2025 14:38, Peter Maydell wrote:
> On Wed, 23 Jul 2025 at 13:47, Alex Bennée <alex.bennee@linaro.org> wrote:
>>
>> Ben Dooks <ben.dooks@codethink.co.uk> writes:
>>
>> (Add maintainers to CC)
>>
>> You should get your patch workflow to use scripts/get_maintainer.pl so
>> they get CC'd and reduces the chance of it being missed in the fire-hose
>> of qemu-devel.

$ git show | ./scripts/get_maintainer.pl
"Philippe Mathieu-Daudé" <philmd@linaro.org> (odd fixer:SD (Secure Card))
Bin Meng <bmeng.cn@gmail.com> (odd fixer:SD (Secure Card))
qemu-block@nongnu.org (open list:SD (Secure Card))
qemu-devel@nongnu.org (open list:All patches CC here)

so, no maintainers listed, just sent to the two lists.

>>> If we get "ssi_sd: error: Unexpected response to cmd" then having
>>> the bad s->arglen would be useful debug and does not add any complexity
>>> to the code.
>>
>> Generally we should be removing the old-style DPRINTF debug and
>> replacing them with tracepoints where they are warranted. The main
>> problem with the old style DPRINTF's is the format strings tend to
>> bitrot because they are not enabled by default.
>>
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>> ---
>>>   hw/sd/ssi-sd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/sd/ssi-sd.c b/hw/sd/ssi-sd.c
>>> index 6c90a86ab4..f1441d2c97 100644
>>> --- a/hw/sd/ssi-sd.c
>>> +++ b/hw/sd/ssi-sd.c
>>> @@ -183,7 +183,7 @@ static uint32_t ssi_sd_transfer(SSIPeripheral *dev, uint32_t val)
>>>                   s->response[0] = 1;
>>>                   memcpy(&s->response[1], longresp, 4);
>>>               } else if (s->arglen != 4) {
>>> -                BADF("Unexpected response to cmd %d\n", s->cmd);
>>> +                BADF("Unexpected response to cmd %d, arglen=%d\n", s->cmd, s->arglen);
>>
>> That said BADF is defined in both cases (although the exit(1) for the
>> debug leg is a bit aggressive). Is this an error of the guest
>> miss-programming the device with invalid data?
>>
>> There could be an argument for using:
>>
>>    qemu_log_mask(LOG_GUEST_ERROR, "Unexpected response to cmd %d, arglen=%d\n", s->cmd, s->arglen);
>>
>> instead.
> 
> This unexpected response comes from QEMU's SD card emulation,
> so I'm not sure to what extent LOG_GUEST_ERROR is appropriate.
> Is this triggered by the guest doing something silly, or by
> a bug in QEMU itself?

I am currently trying to track down two errors with mmc-spi.

The first looks like u-boot is sending a couple of CMDs (9, 10)
in the wrong state (currently this works however with a real SD
card) so I have a tmp-fix in to just ignore the two checks in
these and u-boot is now working.

I'm also getting multiple versions of linux failing with QEMU10
on Debian/testing and my own close to the current git tree with
Linux and CMD13...

[    0.579845] EXT4-fs (mmcblk0): INFO: recovery required on readonly 
filesystem
[    0.580222] EXT4-fs (mmcblk0): write access will be enabled during 
recovery
ssi_sd: error: Unexpected response to cmd 13, arglen=16
ssi_sd: error: Unexpected response to cmd 13, arglen=16
ssi_sd: error: Unexpected response to cmd 13, arglen=16
ssi_sd: error: Unexpected response to cmd 13, arglen=16

Then the system stops working.

Systems are riscv sifive_u and my own cva6 machine

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

