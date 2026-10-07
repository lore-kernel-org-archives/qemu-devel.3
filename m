Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94523CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:52:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xER8R-0001CW-K2; Wed, 07 Oct 2026 08:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xER8N-0001CO-UY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:52:36 -0400
Received: from 10.mo528.mail-out.ovh.net ([46.105.37.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xER8J-0006e0-SU
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 08:52:35 -0400
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net [79.137.60.37])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4j0Ch50wwCz67Rh;
 Wed,  7 Oct 2026 12:52:20 +0000 (UTC)
Received: from director4.derp.mail-out.ovh.net
 (director4.derp.mail-out.ovh.net. [127.0.0.1])
 by director4.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed,  7 Oct 2026 12:52:20 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.188.202])
 by director4.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j0Ch42gRVz1yMs; Wed,  7 Oct 2026 12:52:20 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 261021B42C61;
 Wed,  7 Oct 2026 12:52:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006b04ba86f-41e1-4429-b1c1-8cbf7aca10c6,
 55F3741E86F82430FE8C443D65E56F6716F373F4) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 92.184.136.188
Message-ID: <2853cb5b-e3c5-4beb-a777-ff42a905d939@kaod.org>
Date: Wed, 7 Oct 2026 14:52:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <th.huth@posteo.eu>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261005015015.3466808-1-jamin_lin@aspeedtech.com>
 <SEZPR06MB73627886C2A3216639C727D4FC962@SEZPR06MB7362.apcprd06.prod.outlook.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SEZPR06MB73627886C2A3216639C727D4FC962@SEZPR06MB7362.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 4648840718776839352
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTENFtFgRrw1qM9fc5XPMKxLH0VPFnpN3df/PxJVjZhaRZ6o1HGluHznLY5SR/+aQWP2r2pWwyerTqmXZzVttaCVmhev2H83svmPRHZWFDic+TCS2PlYupKeUUONXTKLf6MlKhRYfvHad0WrshhWkYGnMuLzx0P1+tpPj6GnVvBFN56z6YRQ+JW72pTMWJfgP9t9MnouOJkwmgD1GN9YPsb2c1jWNx6CuADugCy4/ORUaA0bDY+J0Se6LkanvONDz2s2BAGCz+PExtf+PFtJJixwGz/a8Lcih+RN4h4nutPWmKR8bf93KME5OoUDjtpy3IP9qL7NP7eHhqfboDI3Eb1dRVUSGa6ia1tpbWY5LliPKBULaEJaIR7tKv6xbC9n73ExscEJUNpWaisMvHvMo2ZxZ2McAkGWhTOiJlpVzQLY7Ad0xXJYmOcMsjpqtvhajDghwnbZZS1UffTUbA+y0rWrGN//F5IAWEBKr1O99XfaLbYX8r70mP8LTxu578DREpz9QLAF82heFPd+Yvqbuqau17SMdcKiG4CeFGOQYxjoeNk4v9zOKw/IsXQU9o0kFWRepihQIUId+cu0czTrvvgxCqbxPbQEZ609/gIpquk6QqZOy2sx5evFMS48nmv7TfMlb/YrZdzCxxBUvgfXmt0ZrHf+j1OyPZ+kznHoBqHY2w
DKIM-Signature: a=rsa-sha256; bh=2Wouvq5mqDTJCAMwxL9vbIlaepw8KBEGKEPZ0i8DB2Q=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1791377541; v=1;
 b=I1ySkTxJkkTVS3pmn6M5eOoxoF6FmC3SpxEtiszzXOqfXxBMFeS6EKrYFR/6x8oJmlQu7poR
 VPJUC7V9ic0O4VloY+D4MXPJ5GE2wVpbHfGc472KMeZ0alG5DubffRaPQrel6uFqE8niBB7/m2u
 71DSVI1wTuu5qoIEgznOnqRleup0cMRaxyZTnE+gbDyFQSWCVd6s6qD7L5oWUat5Wqhai5N6EJd
 HP3sW6t08rb2SwAzr+4zXSS4hKoFSCJtezapVly6fNLEfaYmWUwF0lpVt58NNrjQa8Nhhb7fBUS
 SnZJNRAmAxdh93szXGR80rO/K5vzXtD5BeOgU5DM+A/CQ==
Received-SPF: pass client-ip=46.105.37.93; envelope-from=clg@kaod.org;
 helo=10.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/5/26 03:51, Jamin Lin wrote:
> + Cédric Le Goater <clg@kaod.org>
> 
>> -----Original Message-----
>> From: Jamin Lin <jamin_lin@aspeedtech.com>
>> Sent: Monday, October 5, 2026 9:50 AM
>> To: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Markus Armbruster <armbru@redhat.com>;
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>; Thomas Huth
>> <th.huth@posteo.eu>; open list:All patches CC here
>> <qemu-devel@nongnu.org>
>> Cc: Jamin Lin <jamin_lin@aspeedtech.com>; Troy Lee
>> <troy_lee@aspeedtech.com>
>> Subject: [PATCH v1] MAINTAINERS: Update ASPEED BMCs reviewers
>>
>> Update the ASPEED BMCs reviewer list to reflect the current active reviewers.
>>
>> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
>> ---
>>   MAINTAINERS | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1312bbd1bd..93a23526d7 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1265,12 +1265,8 @@ F: tests/functional/arm/test_emcraft_sf2.py
>>   ASPEED BMCs
>>   M: Cédric Le Goater <clg@kaod.org>
>>   M: Peter Maydell <peter.maydell@linaro.org>
>> -R: Steven Lee <steven_lee@aspeedtech.com>
>> -R: Troy Lee <leetroy@gmail.com>
>>   R: Jamin Lin <jamin_lin@aspeedtech.com>
>>   R: Kane Chen <kane_chen@aspeedtech.com>
>> -R: Andrew Jeffery <andrew@codeconstruct.com.au>
>> -R: Joel Stanley <joel@jms.id.au>
>>   L: qemu-arm@nongnu.org
>>   S: Maintained
>>   F: hw/*/*aspeed*
>> --
>> 2.43.0

Applied to

     https://github.com/legoater/qemu aspeed-next

Thanks,

C.


