Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BECFCD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 15:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKeBQ-0002Xh-Ow; Wed, 06 May 2026 11:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wKeBO-0002X9-H9
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:29:06 -0400
Received: from 6.mo533.mail-out.ovh.net ([54.36.140.181])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wKeBL-00008A-Rn
 for qemu-devel@nongnu.org; Wed, 06 May 2026 11:29:06 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4g9fRw2tCZz5whT;
 Wed,  6 May 2026 15:28:59 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  6 May 2026 15:28:59 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.54.185])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4g9fRv4nXfz7tkr; Wed,  6 May 2026 15:28:59 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 866FF24034E7; Wed,  6 May 2026 15:28:58 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-113S007d6ea0064-ddb0-46ef-9800-0928aa03a61e,
 610448112A712636EE1F401D7B64CCFD68C41A17) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <56a6b369-ecfd-4e6b-a841-6ed1ad1c2a71@kaod.org>
Date: Wed, 6 May 2026 17:28:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] aspeed/hace: security fixes
To: Kane Chen <kane_chen@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20260504213421.710035-1-clg@redhat.com>
 <SI6PR06MB7631B46DF67C1532B154FFE1F73F2@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB7631B46DF67C1532B154FFE1F73F2@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 6790020864508668952
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGmUyvcEWgQrp14Fd/a6B9DTN4c8SOD5AEJmSX459uCYgiT8V7k4RrCtag1xIhvjNIcjkV9JdDMAz3Jn0U6lS/IohDHID53ZeRNWk7tPmH1Zv8OYaVofR8k0ehqvv8/N5T0UH8Ah6B80B+LqXXhZH6vRu3kqohRypXOwlTTEnQUn1/8LJ95JRcIU4M3lF4/0gp0F6PSwEudzBFPN9H7rDuO94ozu5cybHix7GALGC76JfIDzX/Nbx7iP9yoD/qRScfT8eNAYbibKaZ+EloEdQFxzmI1U88YR4YhO+ePMwlpigfjUhI/Lcq2AtOIKc4gJ9ofTT2a0M4NbaV6wL53Er8aKaxj6klgMe0f+N67vdiYlBzFWfmyBS5KN55TxPhjo7O10QIU+ChiJru/maQOopgndaTFrltbkXLhpDLGuuwOfvaiW9W1+vQtbFmnSCQG7Ckdm60W/anZD1GXsbWoeILYpACdo2EuUUm9oIJ40s9/IaYNxlxlR7NpLasLs5XXrrBSkQiSDnKj35LZ6tCxgx5jbI3NeFFOtAd7Dx8Ir2+CfNLstPGKDl/18b4b6kPagz1ROuxXdjM9UZncYJVKldN0AGB9s5afSj8WSFhZd2lCQbAHv3ImY7MaM1IhCyqRmGbTZ/2WHm9SOe2v9JWuBNVhJHzb+z8uIx2XQetXIAqA7A
DKIM-Signature: a=rsa-sha256; bh=MVs0vaJrN1ohoq7WcFHfWPYGm3ljBklJT6mEDC21mbY=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1778081340; v=1;
 b=tmkui5lzBJa9Gn956Els6y7xf2GAdn1Ryzc3HkAJbm6xC3bM0xTA5v/rpSOyeb/0dEwCg/1G
 R+a5K9DMnEv//K4j/nQwhbMJigRwtv9hn8yr3pYzFLfDqeZnR4lU9CbvdE1eVThz/L5exgGF/UG
 e9Gb8yu+YYG9jXV6TJ1nIe/IRqoC82ZqdgItiuSv9FZeODS89DYzkHxN+yBR0fNqhCXx0aFoHXv
 J0jxw8rPX9LPNn6mdp8jbG15/l5yH/W95uRDX3gL+hHMchChN0JYOvJkMEJ6V/QnCEPb1p2+8lf
 oTS7KcwWYadqpJaWYd1QpQehbi+VeVvOPuP8bWDgGsDiQ==
Received-SPF: pass client-ip=54.36.140.181; envelope-from=clg@kaod.org;
 helo=6.mo533.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/6/26 11:53, Kane Chen wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Sent: Tuesday, May 5, 2026 5:34 AM
>> To: qemu-devel@nongnu.org; qemu-arm@nongnu.org
>> Cc: Peter Maydell <peter.maydell@linaro.org>; Steven Lee
>> <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>; Kane Chen <kane_chen@aspeedtech.com>; Cé
>> dric Le Goater <clg@redhat.com>
>> Subject: [PATCH 0/2] aspeed/hace: security fixes
>>
>> Hello,
>>
>> A couple of issues in the Aspeed HACE model were reported on the
>> qemu-security list. Here are fixes.
>>
>> Thanks,
>>
>> C.
>>
>> Cédric Le Goater (2):
>>    aspeed/hace: Fix out-of-bounds read in has_padding()
>>    aspeed/hace: Prevent total_req_len overflow
>>
>>   hw/misc/aspeed_hace.c | 29 +++++++++++++++++++++++++++--
>>   1 file changed, 27 insertions(+), 2 deletions(-)
>>
>> --
>> 2.54.0
> 
> Hi Cédric,
> 
> Thank you for fixing the defects. These changes look good. However,
> I have one question regarding another potential issue.
> 
> In the do_hash_operation function, after calling hash_prepare_sg_iov
> and hash_prepare_direct_iov, the function may return early if iov_idx
> is -1. In this case, the code flow will not reach hash_execute_acc_mode
> or hash_execute_non_acc_mode, which means the mapped address may not be
> unmapped properly.
> 
> I think we may also need to unmap the address when this error condition
> occurs. Do you think this should be included in this patch series, or
> would a separate patch be preferred?
> 
> If a separate patch is preferred, then for this patch series:
> Reviewed-by: Kane Chen kane_chen@aspeedtech.com

Should be :

Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>

Thanks,

C.

