Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F151E73157
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 10:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmrUH-0006Bi-Jt; Mon, 02 Feb 2026 05:48:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmrUF-0006BB-QL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 05:48:55 -0500
Received: from 5.mo552.mail-out.ovh.net ([188.165.45.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmrUD-0002RA-FU
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 05:48:55 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.52])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f4NdZ0sRPz5w1Q;
 Mon,  2 Feb 2026 10:48:50 +0000 (UTC)
Received: from kaod.org (37.59.142.98) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 11:48:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0029dff3ce2-9fd0-4734-98de-e9695cc14381,
 7652E71065C1D671F0F2B67E69D7E7AF66B0F117) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <57fcf2ba-fd8c-4978-af29-18c5dcc7a152@kaod.org>
Date: Mon, 2 Feb 2026 11:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP SDRAM
 remap
To: Kane Chen <kane_chen@aspeedtech.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Peter Maydell <peter.maydell@linaro.org>, Steven
 Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Andrew Jeffery
 <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, "open
 list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>
References: <20260120092939.2708302-1-jamin_lin@aspeedtech.com>
 <20260120092939.2708302-5-jamin_lin@aspeedtech.com>
 <588fa41c-a5ff-455d-b64d-b36b986ee781@kaod.org>
 <TYPPR06MB8206FD6566DFDE3BA513FBFDFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F928E28C7FE78BA9E3BEFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <TYPPR06MB8206F3CB33A135C5AC246E2CFC90A@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <SI6PR06MB763182A3E4BC0C6ADC0555CEF79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
 <05782501-e775-4065-820e-1b599674f478@kaod.org>
 <SI6PR06MB763184DBA59EA9E61B97C3A5F79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI6PR06MB763184DBA59EA9E61B97C3A5F79AA@SI6PR06MB7631.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: ac19688e-42c7-4289-801a-548b245a03f5
X-Ovh-Tracer-Id: 9300496181729332146
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8OkvuyA96IadqD1vu1jr4kCD10OkEyit592JuuLvTCh63YN4ehE+mk6MYZAaNuu7tISsx/b8L4KU4m/8lm3d2cfZhWXavofEgMe72Kvo6+L7os8Rjnmlzye1ny3rRuHSKQTuPG5CqEAPs6rZ5aB/tuYtxMFPhHYMJrDaQ1R9d3RtP/aVwIGRbAQCe48tVSIz4WtMbZXXDP2FwBxmEw7+x+hh0iU/nRzYje/xi1Ol9ZW57vvAMqarYQ77VBaHtV8n9hkuvDR56/bAt4nv5LSmPZBwvua2s89v8pcP2aEeAG42YCjpDyM+Ao0j6aJlm055yV/Odm9QAKBFGfYwAbTTOBL7+kt/mGmykR817aXwezz3NkdeaIfiClVwZSrpFRXi++4x+5Vpc69exB8znr3uuQg/+31c4eepySXQWKX4WmquJkWenZV6tZOzP4db+6zCu1w45FZr5FK9FdZsbuq2XSYo/J5FyaVdK6l/cCLizDUqVw6OIhwtg1uys0mFBkbrwSrmQCVVlhm42FCmu7bTfFmJnOQul4VoooVvDZPv7RApDGPI+A1bIIrhow3LmMK0Tr+PijdbZuvDoKMP5UMe6LCzNGfA6ahaIwqf2mgIJRUQk6z1/Jh+CmxUJgPuGqdr+ctfQleuFaTWiZrP4BS9OCp25LKWT56nsHIyFuzJd5Q
DKIM-Signature: a=rsa-sha256; bh=JbQmnnfA1aQ1N/b0i3Q2V3vIPZpwurIiHcxxu/oHJ3M=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770029330; v=1;
 b=Jucpm1HKx5XOACnnUJgqJTSiHJpCc192VYMlEQDsm/v6kqPl4sgnPGmcZnyJlZTbJW/K+kVQ
 a62XXJ7XQVSracfXtKrfOPatrqMalbnaZvs7A1PaJ+2dcKhEAFSCI+NYYb6PXTH/Dais95Eoss3
 FLgx1CASAkK3M2GTegzfvddpwH//bvStDFS5VH0Y81JEupRQyVrcVRxG7og2EtCny4EBZk9qfD2
 vSKchX9sH9gaNxxt6uVFMT54xSWu3uVMfhO8Xd+t0DkVya3Axz6GVMokcxS086hbYtot3yQ+q1U
 XDsYwiUgetujFbap5IjgOkXQUn/CtSslMzGcJPeOf2McQ==
Received-SPF: pass client-ip=188.165.45.220; envelope-from=clg@kaod.org;
 helo=5.mo552.mail-out.ovh.net
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 2/2/26 10:46, Kane Chen wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Monday, February 2, 2026 5:34 PM
>> To: Kane Chen <kane_chen@aspeedtech.com>; Jamin Lin
>> <jamin_lin@aspeedtech.com>; Peter Maydell <peter.maydell@linaro.org>;
>> Steven Lee <steven_lee@aspeedtech.com>; Troy Lee <leetroy@gmail.com>;
>> Andrew Jeffery <andrew@codeconstruct.com.au>; Joel Stanley
>> <joel@jms.id.au>; open list:ASPEED BMCs <qemu-arm@nongnu.org>; open
>> list:All patches CC here <qemu-devel@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v1 04/11] hw/arm/ast27x0: Add DRAM alias for SSP
>> SDRAM remap
>>
>> Hi,
>>
>>> Working with our IT team, we've transitioned to a Microsoft mail
>>> server to ensure DKIM is correctly included. Could you please confirm
>>> if you've received the below patch series?
>>>
>>>
>> https://patchew.org/QEMU/SE3PR06MB8199F4B0069F9326034585D6FC9AA
>> @SE3PR0
>>> 6MB8199.apcprd06.prod.outlook.com/
>>
>> I did. Although, the series is not threaded. Probably due to the way it was sent.
>>
>> Thanks,
>>
>> C.
> 
> Hi Cédric,
> 
> Thanks for the confirmation.
> 
> It's possible that the threading issue was related to some extra 'From' info in the
> mail body. I've updated the script to remove it, so we'll see if that fixes the issue in
> the next version.

OK. I can not fetch the series with b4. So you will have to resend.


What about the v6 of "hw/arm/aspeed: AST1700 LTPI support and device
hookups". Do you plan to resend soon ?

Thanks,

C.



