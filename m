Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D91D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgecE-0000kn-2c; Fri, 16 Jan 2026 02:51:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgecB-0000iG-Ks
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:51:28 -0500
Received: from 3.mo548.mail-out.ovh.net ([188.165.32.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vgec9-0001vL-7M
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:51:27 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.161])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dssVT5s3xz5vsD;
 Fri, 16 Jan 2026 07:51:13 +0000 (UTC)
Received: from kaod.org (37.59.142.102) by DAG3EX1.mxp5.local (172.16.2.21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Fri, 16 Jan
 2026 08:51:11 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-102R004dad8d819-7248-4512-901c-8a9c4f9d8349,
 356448E47ECF6FF3573990070D4D23F6C14CAFA2) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2ed6bde8-9a68-4eca-ad2d-12f7b2ee597e@kaod.org>
Date: Fri, 16 Jan 2026 08:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
 1c8e9510b22c
To: Jamin Lin <jamin_lin@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Troy Lee
 <troy_lee@aspeedtech.com>, "wuhaotsh@google.com" <wuhaotsh@google.com>,
 "komlodi@google.com" <komlodi@google.com>, Kane Chen
 <kane_chen@aspeedtech.com>
References: <20260115023758.3600447-1-jamin_lin@aspeedtech.com>
 <20260115023758.3600447-2-jamin_lin@aspeedtech.com>
 <CA+QoejUkn14qq49A5RF5iVUCrcdBN077Ce0FZSw8sWAQ+vU3EA@mail.gmail.com>
 <157bdec0-64f9-43b8-b42c-cf29a34d083b@kaod.org>
 <TYPPR06MB820664D78B0B4F5A780822B8FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
 <14e4bfb8-9458-4f75-a479-878ef8d286c0@kaod.org>
 <TYPPR06MB8206370E45E78812598BB1D4FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <TYPPR06MB8206370E45E78812598BB1D4FC8DA@TYPPR06MB8206.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.102]
X-ClientProxiedBy: DAG1EX2.mxp5.local (172.16.2.2) To DAG3EX1.mxp5.local
 (172.16.2.21)
X-Ovh-Tracer-GUID: 0505ee41-06aa-422f-85d0-3933aac97222
X-Ovh-Tracer-Id: 17145485257014020972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF75+kzNOxj8ic2Y+ZMaeS8rQGb9aS/JsV1HQdUbuDTjMeRMCNnJvWD3qulJIzkMInX4kcrDYiyLyB0PVmQgq7pIC2gVSy+zWSN7c8ejWFRweegZPvbzpiaLkl4qrlD8xucCrKjapyiJ/UVWpuRbtK8TR/3CXs72932amGEL3TvsC6Wn1i0qC4/hPHrCmjXadn2uRWquH/bjRVTGFU7owqk6sNlvwVKxVtecgaqiJlRwtwKOw2wPwVx8B0mtu+LIMdnjX/tDVNpmO7+1zPszusMp4UOsp1f000a2PbRNa+eyWe2i8o4m8y6+bnkgQoBUpkaflk5/YnEipEYFm4gsgk7JZz7Lhse7sBSoRy7SNR+LHL7SWguuRBnneBrMz4B+LSrv/+o/7TDBV0MwMuZSMq8qbw3YQOgnSSamCxgOipcFMcG8vOZZRZkhmQoAInIdh4bTDJa5qGS7sOJ/1sRqqCQxv42ZMmmNWzMwCKjF9aAu+dY+hRixZ6A+BlLJaFuGsk4MlY0x8EMwMLnCFO1w0herTJurA9v1h2besM+7WUX/Zv/OqqYu7wOafvj3mOeKbQgcaej4Dv8hHtOhNGnTai/knpkiPZn+jHD149sTwpIlN7XsRlF2iiUJa4wUvVrU8C6c500AJ0CpcYiJt8HWvwycFxCmk9fOQHWPrISM67HQw
DKIM-Signature: a=rsa-sha256; bh=Va6M5N5WFl1u5+yfqaFMSVEuJd7hSVMtSAbUWDVhTXk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1768549874; v=1;
 b=g6KASnm3A4rcANfkU7G6CTKIZuqiJGmgTQCZiiT4HSKh2sxXV7SjHhp2r2JkMzpGpD/uORrJ
 yz3HkQZzHZS2ZXstDvxvLhAXSRKDOAKIcycIQUeoqyQJoVKMjbR0uZ0wEtVZeAO0sGG66BV+oCm
 ociyiYr8SOIAD+4wVF5ay55HqsWT1jnNJliErc9YumCDnKnM2NNYK9uV5hVH+N/oU07coDY2MSY
 c22L85yFCQvsecnZCxGcidGydOGtHykTWspSPaZZxG3SEsXsNV4AOK13N4BJcvlcTMD0LjbfIT2
 PZtE2Y1FsemDnbOjjTgkoaz/tajUZ3xGA0+i7dQ2yDysA==
Received-SPF: pass client-ip=188.165.32.156; envelope-from=clg@kaod.org;
 helo=3.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/16/26 08:40, Jamin Lin wrote:
> Hi Cédric
> 
>> Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
>> 1c8e9510b22c
>>
>> Hello Jamin,
>>
>> On 1/16/26 02:20, Jamin Lin wrote:
>>>> From: Cédric Le Goater <clg@kaod.org>
>>>> Sent: Friday, January 16, 2026 12:21 AM
>>>> To: Nabih Estefan <nabihestefan@google.com>; Jamin Lin
>>>> <jamin_lin@aspeedtech.com>
>>>> Cc: qemu-devel@nongnu.org; peter.maydell@linaro.org; Troy Lee
>>>> <troy_lee@aspeedtech.com>; wuhaotsh@google.com;
>> komlodi@google.com
>>>> Subject: Re: [PATCH v1 1/1] pc-bios: Update vbootrom image to commit
>>>> 1c8e9510b22c
>>>>
>>>> hmm, I didn't receive the initial email.
>>>>
>>>
>>> Cédric,
>>>
>>> I used the following command to generate a patch to update the pre-built
>> vbootrom images:
>>>
>>> git format-patch -o ../v1-patch HEAD~1
>>>
>>> However, when I ran get_maintainer.pl, it could not find any maintainers and
>> printed the following message:
>>>
>>> ./scripts/get_maintainer.pl -f
>>> ../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e9510b.
>>> patch
>>> get_maintainer.pl: No maintainers found, printing recent contributors.
>>> get_maintainer.pl: Do not blindly cc: them on patches!  Use common sense.
>>
>> Weird. MAINTAINERS has :
>>
>>     Nuvoton NPCM7xx
>>     ...
>>     F: pc-bios/npcm7xx_bootrom.bin
>>     F: pc-bios/npcm8xx_bootrom.bin
>>     F: roms/vbootrom
>>
>> We do lack a MAINTAINERS entry for Aspeed :
>>
>>     F: pc-bios/ast27x0_bootrom.bin
>>
>> Can you please send an update ?
>>
>>
>>>
>>>
>> fatal: ../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e95
>> 10b.patch:
>> '../v1-patch/v1-0001-pc-bios-Update-vbootrom-image-to-commit-1c8e9510b.p
>> atch' is outside repository at
>> '/home/jamin_lin/upstream/qemu/vbootrom/qemu'
>>> qemu-devel@nongnu.org (open list:All patches CC here)
>>>
>>> As a result, only the mailing list was suggested:
>>> Eventually, I sent the patch using the following command
>>>
>>> git send-email -cc jamin_lin@aspeedtech.com -cc
>>> troy_lee@aspeedtech.com -cc --to qemu-devel@nongnu.org --to
>>> peter.maydell@linaro.org --to clg@kaod.org ../v1-patch/*.patch
>>> --no-smtp-auth --smtp-domain=mail.aspeedtech.com
>>
>> Looks correct.
>>
>> I hope my provider OVH is not silently dropping email :/ The same thing
>> happened with an email from Kane. Was any email returned to you ?
>>
>>> It seems that I included you in the --to list. Do I need to resend the patch?
>>
>> You do need to resend for another reason : roms/vbootrom needs an update
>> too.
>>
>> Also, for updates with large binaries, for FW updates typically, we prefer
>> subsystem PRs :
>>
>> See an example for a SLOF update from Thomas :
>>
>>
>> https://lore.kernel.org/qemu-devel/20251027074404.25758-1-thuth@redhat.c
>> om/
>>
>> Some docs here :
>>
>>     https://www.qemu.org/docs/master/devel/submitting-a-pull-request.html
>>
>> Ping me if you need help setting up your environment,
>>
> 
> This is my first time submitting a pull request.
> Please let me know if there is anything incorrect.
> https://patchwork.kernel.org/project/qemu-devel/patch/20260116073024.3485812-1-jamin_lin@aspeedtech.com/
The subject should be:

   [PULL SUBSYSTEM vbootrom 0/x] ...

I didn't get the email again :/

C.

