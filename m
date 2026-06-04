Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EA4CD6E6D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVA4h-0007DA-2R; Thu, 04 Jun 2026 11:33:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wVA4P-0007C4-E3
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:33:25 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wVA4L-00069H-TX
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:33:21 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gWT9N02N8z5vvS;
 Thu,  4 Jun 2026 15:33:11 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu,  4 Jun 2026 15:33:11 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.244])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gWT9M27Lhz5vLS;
 Thu,  4 Jun 2026 15:33:11 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 8CB6C1923063; Thu,  4 Jun 2026 15:33:10 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001c11afcf0-67ac-4123-b87b-69f328dfc0f8,
 CF95B39D1A067B05C916C5BD8336C8853742392C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <6b932f59-7d34-4931-a68d-56e96030e67d@kaod.org>
Date: Thu, 4 Jun 2026 17:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/i3c: fix DW-I3C FIFO depth advertisement
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, jamin_lin@aspeedtech.com,
 komlodi@google.com
Cc: nabihestefan@google.com, philmd@linaro.org, qemu-devel@nongnu.org
References: <20260529014034.864722-1-jithu.joseph@oss.qualcomm.com>
 <20260604000734.1094382-1-jithu.joseph@oss.qualcomm.com>
 <4696cf03-08ad-4de4-b782-4d5c253b2cef@kaod.org>
 <3a076897-ee9f-4422-8daf-ea44223eab59@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <3a076897-ee9f-4422-8daf-ea44223eab59@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 11148379403761134614
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGGsKR/gwKAzusTuWTRzoTeGCUXlZFkFd5+hGDCCq5gSwbP+DE2qNtPxfbRCMAXLfps1AF2VdF9KbMy41roGCof/u3tdUH/N3oZcpLvK93ZjFx6ECidfgGwSWErvMtmMMYiwOEJUOm16zfA8+qU9l8izUAkjs5a/+l+JvTNsobAUMH0NaFs0EZjScRQ/rfRQ2MRKRZ5uhqrYqs8hpEiwszRwuwfpF0cbkKY0WUQ8AR2rESPitrYanQJyFJxpO1CNtFWEX7WklXx+rk7FNunOQSssyJYKvp0jVEOCp7iotUGSn9Rkap2E2Tn42Ro9/kTC34CoP/L+9U/85rWxS5IY+ffjtkmAe3WvRUsvJ7Zv5EiwjLIJkk0gO5PZYaXzHusocF811GEup5Ixr1wZ3BTOhU/T5zgfnuO1IRbWD+zsnMqcI7tp9hvMsfg6DpWTpzdfuQSk9rIOy+4An+0IJ3UYiTho602i/u3NEedDKdkB2eJ9gnTNEZVpPCiun5GX3V+M0JD66bdzrXd7fQis1PBtcglY8WVO0jRODJB3wJzvhbng9cqM1HR2QE+cs3zI6YIJ2FxkTffJy8Asm9eVTflS/E0R6j2DvDFlObHgPVnuIi4Ngl3W+8Ysy+29/7iqq3Pfemdp5HJeEzxU9BZOdteSr7+AF/YesAMFdWk1s0cHSPPKg
DKIM-Signature: a=rsa-sha256; bh=s1P6TBWw0Kj8Ms8NY8g4VhY0jGwpaJHEnwTlV9HShMc=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780587192; v=1;
 b=lqL58r1sRqO0n4UyOORvfdrMfyVPycTMiBF0v+SJcUOLg+21b7VsSvx6CuY5gbLs6GW2miSu
 HV0egY6BHeKtYEWnjN26OoIKSJMVbgVJkdZYL9KWUNhagPs5iQ4NHzO40l/UMvnV6mW8ZaakJqy
 iBkQS+FX5x5bAzHWShcdNEGXex4Liv/8K2RP2W7K1GbAFheYOpg/nVUGNPb+C/paCYmLTgZ0AW0
 NTKC+axvIsar0xjluYrIhdwluejDFn9VVFJKEDZGLGv02yf/T6/iDVBN2EYgHgTcvlImvAxeBtA
 WxBFjDY6AIUBOWsznr2I7uE9qDMOGHbXI1c40e0BsaOPw==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/4/26 17:24, Jithu Joseph wrote:
> On 6/4/2026 1:28 AM, Cédric Le Goater wrote:
>> On 6/4/26 02:07, Jithu Joseph wrote:
>>> This series corrects the DesignWare I3C controller's advertised CMD/data
>>> FIFO depths and cleans up the misleading queue-capacity field names that
>>> made the bug easy to overlook.
>>>
> 
> ...
>>
>>
>> Jithu,
>>
>> When you sent this v2, you did as a thread reply to :
>>
>>    https://lore.kernel.org/qemu-devel/20260529014034.864722-1-jithu.joseph@oss.qualcomm.com/
>>
>> This confuses the b4 tool and, in consequence, Jamin's Reviewed-by
>> is not collected it seems.
> 
> Sorry Cédric that it broke your MAINTAINER flow ...

Well b4 isn't smart enough to grab the trailers on v2. Try it.

> (I used to follow similar threading while sending newer revisions in LKML a while back)

I would recommend  to start a new email thread for each respin else
the newer version of a series is "hidden" under the previous thread.

>>
>> Can you please resend as new thread ? If you can can collect Jamin's
>> Reviewed-by trailers it would be nice.
> 
> I just sent out v3 with Jaimin's tag here
> https://lore.kernel.org/qemu-devel/20260604142207.2118098-1-jithu.joseph@oss.qualcomm.com/


Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


