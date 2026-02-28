Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E97FEE4CB
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Feb 2026 06:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwDsa-0007MF-Ro; Sat, 28 Feb 2026 01:32:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vwDsY-0007Lu-Ed
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 01:32:42 -0500
Received: from smtpout2.mo529.mail-out.ovh.net ([79.137.123.220])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vwDsW-0003Ay-QR
 for qemu-devel@nongnu.org; Sat, 28 Feb 2026 01:32:42 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.37.169])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4fNFjw5y9Nz5vrW;
 Sat, 28 Feb 2026 06:32:36 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 28 Feb
 2026 07:32:35 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003701eda5c-4e51-4a5e-ba84-88c4c0e28dd3,
 AB8FE0F0092A77660108FB6BE0CCE158015A5ABC) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <1077949c-b378-41f7-8ce8-13f68da96444@kaod.org>
Date: Sat, 28 Feb 2026 07:32:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/22] i3c: aspeed: Add I3C support
To: Jithu Joseph <jithu.joseph@oss.qualcomm.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, 
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>, "komlodi@google.com"
 <komlodi@google.com>
References: <20260225021158.1586584-1-jamin_lin@aspeedtech.com>
 <a19985e2-c9ca-4158-9c64-e0d16ce40c8c@oss.qualcomm.com>
 <e58d1526-d9cf-4f31-b7cb-808a7b0f2c66@kaod.org>
 <08e52599-d4a1-47ad-b828-60a6a20673f3@oss.qualcomm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <08e52599-d4a1-47ad-b828-60a6a20673f3@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG13EX2.mxp5.local (172.16.2.132) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: f9ae14d8-6748-4abc-8236-bb53b8edd677
X-Ovh-Tracer-Id: 10089189067682974535
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFjs6m9+8vhx2XZoQOPIcXBkumVgYl1Ara/EGqiQwH8RyjWrqBFPNoRr12VgOhbVbTthBymXRAOBnSKhFYCLGtXMTu1uySMfJW2LI9LrrvAIiN6g8xs8ojANMr1jFTtK5S/k+Iy5bm4kVlt0GqqGwaIwJuNtEVYCIIfZ2k75uadnAe+NaVI+RTuCNnZaCda4mhf53gQb8wsDOPELRVzXH6M0nvaao5rttMeP1bJ55pQO6vvaYgDPw72P8H+bVm2DBmzU8VWUSjlsWuqOMzTC1ksgq1W6QU80JyfvaDrA8Pr5l2rU7N96yc2vL2OAx6Wj87fJJ8m8XYZf5WS5dvvsDDlB6q82wS3dhdvdse8EhEXs8ateG0JG5XFHUuW20vch7lC1W4JqYyvTubAC7JJdn07o8DXBL+oKxyctJl4tNBFUgvLt7kOdpZpn0D4Rsf77gjTRiH6NtnjF0ihQMNFQI94Q0YJOKDqkPb6xkj2KRdk7K6CmWXPgPWlaohlx08vZJ6M+WtIBI+5+LuBO1i41/J5980sk3xaty70ZG+HLWIq8vz59JedLJcg7dlSMy9L1WZepta7qn3C31Ye/SGEYl3QxgKU+COuHubaRM6uE3YPvB6HK6eo3wSURPjlsrjIJnFfwUJ0dTYoJfolRVNm01sxK479aHbGVMTTX1KiR0fLOw
DKIM-Signature: a=rsa-sha256; bh=lu0rJcBrybyyny1rzMg8EW/EStZVVJrgW0dC8bqJIqM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1772260358; v=1;
 b=H9zFYXMFBJ2ebBtf9pAUt4fZi7iSYOY87Z30DcqF7LnUVa85fGYgQpfDD6tPeWWTxlpo6KQy
 ULTdrRlHLql1rBCJjtVW+NJiNVAtThAMqFpoedoOw+k+C9QnVpt3+CbYhc/pHOSCwDzsjvvck0E
 pw+k+bZeBOIEWn96WYWZqpNhJjO1RUgDKB1JeopdJJBQFbG9J5YgjIPrSfQjMvZHp+1jvmOG81H
 2Y3aUZq1FGShcAmEki3qSNtXpGwrcneAjkuTkvVOzOGltnso9T0MWLLVmGjJgao/AiDOixpv758
 rcabQ5ejDE92UqpikjWKF2KIA0KZ5hMmE+vldkisAMWQA==
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout2.mo529.mail-out.ovh.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706,
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

On 2/27/26 21:03, Jithu Joseph wrote:
> On 2/26/2026 11:53 PM, Cédric Le Goater wrote:
>> On 2/27/26 03:33, Jithu Joseph wrote:
>>> On 2/24/2026 6:11 PM, Jamin Lin wrote:
>>>
>>>>     The initial patch series was based on work by Joe Komlodi <komlodi@google.com>.
>>>>
>>>>     This series adds I3C bus support to QEMU and adds more functionality to the
>>>>     Aspeed I3C controller.
>>>>
>>>
>>> Thanks Jaimin for the series, I was able to test this series to a good extent over the last week
>>>
>>> Tested read/write transfers from guest Linux using i3ctransfer against the mock-i3c-target  on an AST2600 based machine
>>
>> Can you be more precise on the machine used ?
>>
> 
> This is an internal clone of ast2600-evb which is still a "Work in Progress" and not yet upstream.


OK.

For your awareness, qcom-dc-scm-v1-bmc and qcom-firework-bmc machines
will be removed in the next cycle.

   https://www.qemu.org/docs/master/about/deprecated.html#arm-qcom-dc-scm-v1-bmc-and-qcom-firework-bmc-machine-since-10-2

Thanks,

C.


> 
> 
> Thanks
> Jithu
> 


