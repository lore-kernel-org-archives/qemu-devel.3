Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8139606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=wOc1xmAO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdp0-00052F-R6; Tue, 27 Oct 2026 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xLdoy-000519-Aq; Tue, 27 Oct 2026 05:50:20 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1xLdov-0002JL-Rg; Tue, 27 Oct 2026 05:50:20 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4jDQhX0Xswz42xS;
 Tue, 27 Oct 2026 09:50:04 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Tue, 27 Oct 2026 09:50:03 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.227])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jDQhW6F9Yz1xr0; Tue, 27 Oct 2026 09:50:03 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 688B124031F5; Tue, 27 Oct 2026 09:50:01 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S00104b5ff27-a6eb-49bb-b08a-57798213bcfa,
 6907BB2C17AE28529708C059842524B2B81EE5B9) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.66.77.115
Message-ID: <ceb9d0f6-0df6-44dc-ab59-ac9c41c4c1b8@kaod.org>
Date: Tue, 27 Oct 2026 10:50:00 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to w25q33pw
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
 <20261015055642.106204-4-jamin_lin@aspeedtech.com>
 <d4a1ce6f-96c9-422f-9380-b8c0bbdfa775@kaod.org>
 <TYZPR06MB73734264E93D567EF7AF1E0CFC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYZPR06MB73734264E93D567EF7AF1E0CFC602@TYZPR06MB7373.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8343762737986120749
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTG1KICf9vnL2AxDo0vdIdbwCvuonb5HKIEsoHxseoZLyJiWl/YmpqGDc97JRhYBejW2AIrfMJGb6z5eJcr+nKHwkHlB1On/loV18lGcythxJ5j+x5mjBw3dQc5kcDyB41rnEd9Toip4q06F3WWyCzlZFF0qCx2Jk5UYy6TT7mbWqEaw00UC2GVLOG1tEdbqRpcKQpb0FCB0IVFLnEr8uJKt2CCBM94jO925Ia3F74Onyqe4tRKJnR5q7AK18KPe8XWxRVmju+vFsFEQkNd7Ww7nM23O8pNh4jdB7j8LJLtP46eYcjvEJayOOUpIyLuwCnFsh8RvMzxi2mPo5gSMz/3mMEZ5mopttxyQ1ivHaqAgmPhQvhZbnXHfk9eK3uARIvc5CnCGBPzTWzFFKt/X4uMHbi+nHXMSlyrv32ouN9JzBiKiq5CFGrTf8X0akzvhHA+bWi2Go5+JS/h32yEDwZvWQHGaDd9vbhc95Wkw/cQmUTNNj5ZkLG7g+3bGna0XORetS1zS/Evg3CYpA+sZtXSLQQqE13y9a2NrdhoFmY2d+YPJ3lL0Elgyva5Q9q4tLu85GyChVJFAstxPzq5nVMzoFbZT9H0+vbYLm+Txmq6h/IW3IYL0ejXLiVeGqhJ9DWiAgejaGBVzS/pvjn+7h1iv0UEtRINZnT7z5Ddiuzar/g
DKIM-Signature: a=rsa-sha256; bh=SiDf8pUyugPourU+mSORLt0cIPEPHwC0tp0Av/wuqdQ=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1793094606; v=1;
 b=wOc1xmAOhANOCA3qt44Iaf8u+NwPINw2+jIt1zPebe6aTln9dsLAUuyPd4basmfzAIVkewxL
 s/af/4pbYgJe6mMF9sEBK9teCipy9dT3p9hBgEah7gFtbRYCNV48gusjbo4/yC9Vuk4XTXb/cdy
 8dUfER1dz9eEPVVUJeR8JjL0fh/zvanCschv8aCzz02Wnz6yrdxDWhyVZzZiYfEIgMvNtKxIH0m
 3U2/Q2Bun0L3aRb2ia2cXz7BctKUFTPVX7KercXy2S6/bWV0KbiabcgckWYWjBsZZpTpaW/+YyZ
 UtbCPTsUQhRa/OUnkMtA/R8uzPlLVuMhXB+7VuynybJqg==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/27/26 02:32, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 03/14] hw/block/m25p80: Rename w25q32dw to
>> w25q33pw
>>
>> On 10/15/26 07:56, Jamin Lin wrote:
>>> The W25Q32DW and W25Q33PW use the same JEDEC ID (0xef6016), but
>> have
>>> different part names. Since the JEDEC ID is used to uniquely identify
>>> a flash model in QEMU, both parts cannot be added as separate entries
>>> with the same ID.
>>>
>>> According to Winbond, the W25Q32DW has been end-of-life for many years
>>> and the W25Q33PW is its next-generation replacement. The W25Q33PW is
>>> compatible with the W25Q32DW and uses the same JEDEC ID.
>>>
>>> Rename the existing w25q32dw model to w25q33pw to reflect the
>>> currently supported part.
>>>
>>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>>> ---
>>>    hw/block/m25p80.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c index
>>> 545e0b5728..e88efd913b 100644
>>> --- a/hw/block/m25p80.c
>>> +++ b/hw/block/m25p80.c
>>> @@ -353,7 +353,7 @@ static const FlashPartInfo known_devices[] = {
>>>        { INFO("w25x16",      0xef3015,      0,  64 << 10,  32,
>> ER_4K) },
>>>        { INFO("w25x32",      0xef3016,      0,  64 << 10,  64,
>> ER_4K) },
>>>        { INFO("w25q32",      0xef4016,      0,  64 << 10,  64,
>> ER_4K) },
>>> -    { INFO("w25q32dw",    0xef6016,      0,  64 << 10,  64, ER_4K) },
>>> +    { INFO("w25q33pw",    0xef6016,      0,  64 << 10,  64,
>> ER_4K) },
>>
>>
>> Instead please add a new "w25q33pw" device and keep "w25q32dw".
>>
> Thanks for the review and suggestion.
> 
> The reason for renaming the device is that both w25q32dw and w25q33pw use the same JEDEC ID (0xef6016).

yes. that's fine. See :

     { INFO6("mx25l25635e", 0xc22019,     0xc22019,  64 << 10, 512,
             ER_4K | ER_32K), .sfdp_read = m25p80_sfdp_mx25l25635e },
     { INFO6("mx25l25635f", 0xc22019,     0xc22019,  64 << 10, 512,
             ER_4K | ER_32K), .sfdp_read = m25p80_sfdp_mx25l25635f },

The only way to distinguish the mx25l25635e device from the mx25l25635f
is to read the sfdp table. That's what the kernel does.

> I can add w25q33pw as a new flash model and keep w25q32dw, so both models will use the same JEDEC ID. If you have no concerns about this, I will update the patch accordingly.
> Alternatively, I can drop the rename patch and only add the SFDP table to w25q32dw, since w25q33pw is compatible with w25q32dw.

as you wish. But don't drop the w25q32dw please. This would be a user
visible change.

> Please note that the SFDP table was dumped from a real w25q33pw flash. I don't have the SFDP table for w25q32dw because this device is old and has reached end of life.
> Please let me know which approach you prefer.

The simplest is to add a new "w25q33pw" device with its SFDP table.


Thanks,

C.

> 
> Thanks,
> Jamin
> 
>> Thanks,
>>
>> C.
>>
>>>        { INFO("w25x64",      0xef3017,      0,  64 << 10, 128,
>> ER_4K) },
>>>        { INFO("w25q64",      0xef4017,      0,  64 << 10, 128,
>> ER_4K) },
>>>        { INFO("w25q80",      0xef5014,      0,  64 << 10,  16,
>> ER_4K) },
> 


