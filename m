Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBD4FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:57:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIVdf-0006KA-Ua; Thu, 30 Apr 2026 13:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wIVdN-0006Fd-K2; Thu, 30 Apr 2026 13:57:11 -0400
Received: from smtpout9.mo534.mail-out.ovh.net ([178.33.251.187])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wIVdI-0006C6-J0; Thu, 30 Apr 2026 13:57:09 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [51.68.94.138])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4g621Q2h8Zz6G69;
 Thu, 30 Apr 2026 17:56:57 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 30 Apr 2026 17:56:57 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.131])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g621P3Fbtz7tlB; Thu, 30 Apr 2026 17:56:57 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.6])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 9F3CC1B434C0;
 Thu, 30 Apr 2026 17:56:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R0054db59235-6891-4e65-b1c7-7b93527e40a2,
 9F47DE0B15482FF6BC55B1CE858CC0DAC5AE7A4F) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 90.14.253.154
Message-ID: <0e8d1755-3354-4e81-ac80-24d3b65247ae@kaod.org>
Date: Thu, 30 Apr 2026 19:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] hw/misc/aspeed_sbc: Add bounds checking for OTP
 write operations
To: Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>
Cc: Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20260428055254.76581-1-kane_chen@aspeedtech.com>
 <20260428055254.76581-2-kane_chen@aspeedtech.com>
 <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <CAFEAcA8i+v_7KVPBMHGkjf=tuGuVCW_d-XUBb1cr-ezmD_F7xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 10946280371420179480
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF5GneqQL7z9mPF0lejjtz1El37lCvZlaD/z2Mgo0S8EU15XDjeZoakE1etBVuRNxGxqikfGtpJvBMJSC5nnUlUoR679SZoRMlZbtUmoCHoAF77tgICSgSQ272GNHODoiWlePgVu42EmMDVObDOZFHzbEoB6jkxDd6NEhd0TKJuyDmJsSKA/01BPEZkQt/VgZFjUgXRBqfb3hrlEp6nUCHLJ/vkRLUtKHyCRV0sYFDgDDAgtjqnMpRwlzqsYGHp4sPLs0kie/ijNWIWIEa5fSJzETx2V/++NY5wtKR4chIudW+yhP9pVE2gGFM9WkohGcESa564xcyRc32W7pUS1Wx3L65TVtL2lAE4lFjmsVWuvkgxs2Fx4B2o4/dmc8Kt3Q4X0fdGQB+I354UikPyJwI0sgsHKuz2+UmoVsGzYhGXT7rWomam19gF+xSAnsYHX3BlYAsgWYEZjvfXfCh9gdCOaTEm8RXVuFs4phAipudIeu5zaDWWq9kvqkcYksPUB+VA7TWlzYMsll7AorB6VpkrUuG2TLSFPUCn1Gez7balhgfwSlbQ9m6ZN3RtpWFImbYqTHmXYntKQAauIBWPEudMQyst0YXNp9/WFHTtSLqQyuZypuQnORbgpl38PxQ55yYLOvJ5bRLow1mF2up4SEf+idpSdn/+W2UJvR7gFIWHzg
DKIM-Signature: a=rsa-sha256; bh=YrJO5/lPIBYq2vjVwAo+ggjBZr+bT94S9Ur+wI5dAEo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1777571819; v=1;
 b=W6zxUBwQJSw6dsRZ0f2Pi+34wgBYCyL9jMXeZxmnuhiDjTZ3MhBix8RM7yLFoA28XQq4IK4C
 Pj72kY+ClFS8jKTPDE40qw4hK6CqQ+b+lQ6HoX3qNhOnBgHMO8l7mdybESnpNLqdyRqY9wPNvCQ
 Rt7a13WByPmBS1xq19Lsj3CCaR2FKhhGDytw4TUK8Wqm3/DvUz1UaIHMh5L8+KdaVnPtUAV28OK
 ryB5YzuTYMGYTuNXersUglbCgF7DOyZBKsSTK399K1XDyjLG2YxA917eFkn0DErgs70kNc7kZNy
 GPU3q+zvUuK/YNPCr/qLeIgrQdoQJKjbvoiJRLqY9aDaQ==
Received-SPF: pass client-ip=178.33.251.187; envelope-from=clg@kaod.org;
 helo=smtpout9.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/30/26 13:03, Peter Maydell wrote:
> On Tue, 28 Apr 2026 at 06:53, Kane Chen <kane_chen@aspeedtech.com> wrote:
>>
>> There is a mismatch between the Aspeed OTP model and the Aspeed SBC
>> model in how the guest-provided address is handled.
>> aspeed_sbc_otp_prog() passes a word-indexed address directly
>> to address_space_write() without converting it to a byte offset,
>> whereas aspeed_otp_write() expects a byte offset and applies an
>> additional shift (otp_addr << 2). This double-shift confusion means
>> that an out-of-range word address can lead to a write beyond the
>> allocated storage.
>>
>> Fix this by adding bounds checking on the word offset before
>> converting to byte offset and passing to address_space_write().
>> This matches the existing bounds check in aspeed_sbc_otp_read().
>>
>> Cc: Kane-Chen-AS <kane_chen@aspeedtech.com>
>> Cc: qemu-stable@nongnu.org
>> Fixes: 1a00754ccf15 ("hw/misc: Add Aspeed Secure Boot Controller model")
>> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3436
>> Reported-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> Signed-off-by: Kane-Chen-AS <kane_chen@aspeedtech.com>
>> ---
>>   hw/misc/aspeed_sbc.c  | 14 +++++++++++---
>>   hw/nvram/aspeed_otp.c | 13 ++++++-------
>>   2 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
>> index 065e822e70..8b74dca13c 100644
>> --- a/hw/misc/aspeed_sbc.c
>> +++ b/hw/misc/aspeed_sbc.c
>> @@ -159,13 +159,21 @@ static bool aspeed_sbc_otp_prog(AspeedSBCState *s,
>>       MemTxResult ret;
>>       AspeedOTPState *otp = &s->otp;
>>       uint32_t value = s->regs[R_CAMP1];
>> +    uint32_t otp_offset = otp_addr << 2;
>>
>> -    ret = address_space_write(&otp->as, otp_addr, MEMTXATTRS_UNSPECIFIED,
>> -                        &value, sizeof(value));
>> +    if (otp_addr >= OTP_TOTAL_DWORD_COUNT) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "Invalid OTP addr 0x%x\n",
>> +                      otp_addr);
>> +        return false;
>> +    }
>> +
>> +    ret = address_space_write(&otp->as, otp_offset, MEMTXATTRS_UNSPECIFIED,
>> +                              &value, sizeof(value));
>>       if (ret != MEMTX_OK) {
>>           qemu_log_mask(LOG_GUEST_ERROR,
>>                         "Failed to write OTP memory, addr = %x\n",
>> -                      otp_addr);
>> +                      otp_offset);
> 
> I would stick to reporting otp_addr here:
>   - it's the value the guest actually writes
>   - it matches the logging for "invalid OTP addr above"
>   - it matches what aspeed_sbc_otp_read() logs in the equivalent case
> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>



Applied to

     https://github.com/legoater/qemu aspeed-next

with this change.

Peter,

Feel free to pick the change if needed.

Thanks,

C.

