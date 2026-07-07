Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A16C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDef-000441-1k; Tue, 07 Jul 2026 17:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDed-00043W-8a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:48:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDeb-0003Wj-G2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:48:35 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5CcE356737
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E9GQzvxUEenpgPNHP/AaImSPW44cHuxVE3VaCDoRX9s=; b=Fr/FiLieeh46jYUA
 DeDPJW2znYn1LKBPu8UeBTtXEPIS979KBGlyZeaED9MJZIiBXmZd17bO59QOXxp9
 m2HX6/eR13hQAn+SVO6iqDB+b7eYo5t5+iL78+1ysjtNo9Rc3iKXgTcaxi7HYCiU
 xuC6Z51vg647X4y+624tWCUGjGy3Aza1mjMgke+UYOxCpMCbQjZi1L29wYIJAAPN
 RuZPm8Cs6ZoXEyTRsz4miUZS3OPZg04cIVCjFYL8kpmf0uYTfketx8N66+nMrstS
 J+udSjMR/Y/5VqGzKE3/OvJE5TOUr+wABTFlFoWuR5nHN566JoNFxdTauDhwYZq0
 hWnS7g==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8sm8m9uq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:48:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8952346bb9so4153488a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460911; x=1784065711; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E9GQzvxUEenpgPNHP/AaImSPW44cHuxVE3VaCDoRX9s=;
 b=APcTwCMrVHxVbTypL5XKzOvZBFzJTifT1hYy4fZZRylFIuxayYu86HEjC6/W7xMwib
 oq3dWZx9O20HIrsbelBTI85jKKJ+O1g+dDCSieY6FzxNaF3hs94OYLpj6kh6aJX2YPFs
 Trl/acRv+4zTxg2cx2sW931RMpj+sPaQAuCGtNWYuoZIfvPfcIIoJY7wAFK2IfwJMZ+z
 IPkt6vqzJMg4X/YDK3hwKM3JR+hg8tF9FN2FKqE1A/E6Q6N0yY0nKbGShY4BS4odYpay
 UlDsk0Ce5sqA0zYgIawVm/t2zbGi1uvC8pHL24n1bdXA9QCZ+5GSQxhlf3jw1runsvWf
 CNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460911; x=1784065711;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E9GQzvxUEenpgPNHP/AaImSPW44cHuxVE3VaCDoRX9s=;
 b=LanGQe/t5JYLKMYltzBOx0Xe2EsInwqwwkhNDN4H3Q1x1TFD/lIMvoBD9INsBpx5t4
 FiB3s1Jjjs1lYtqEdK2eUlXn7yrmvfNbhKtfrF3MRtuOTzPAVQPJePxVveldejiVjb13
 sZem+OwXSQtairVYI6HuWUSozIrbFm4qlFI0+0J/NeQudgyFDFbLiBf3/73vwO7AM0G9
 7VfUQ6tbcup6jon8GU3449pRyJkkjvcocka7BMVtT4LqacZgqnqNej4YBmsNvvvov5U3
 lRzaFWVrne5zCz+IeaZUkjv92ZHsI3iOp8EUGGJJk6hqzDvSsXA1cKgT8vyyj91qs5YS
 e7qQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpptnmSXkDfHUsqUlv9SUmtscG1QenWMeS5yDt2iNmVkbS/o90vfB6LSSSUQDdLlFH30rpsgvOQQMCO@nongnu.org
X-Gm-Message-State: AOJu0Yy0JbmiCZo1+uNgNiYoW93+fduU5EwdcBjeqtopzo+H1tPmxUW4
 b4sjv/dv8US/4cawF9uP64FoUmm/1+IAbzDedjXg7yYUr68XUCyLiiLyqj+uHrYwoNZWrqvUJ99
 JuuHh5AK0T21Nn41UDBMPPNM5qBt+lRkEdlWflbMMG3Y2fxP1FknwhwLbbPg0fyWhHQ==
X-Gm-Gg: AfdE7cm/uUGL8nbkGJSDrsT88k18bELM1BQZpjiaol5ymdp+6SdRJnNjrpkxOCxKgPR
 hlBP4ELUqT3+QLCI1W83/kEuwTT6UKkMNfbJ32LtPEMjHIHeS7s782VGSD5epOzl0NbV9RPZ8GA
 5cRHUmlAry3XOclMaKgxcGQ/8zWkndlSovbM+nXZIhZJbjnILuOBMnEdSngR3opVjE3SRxc6wtL
 cvRNmY0JyJs8GrX7Wh2GQTwVThOG3ted1CH1yXTf9gOcKE6hkv2hpH5n+OzJFLoazfQXgjpQDSF
 tv973qXfvZKxMTLIOpAr6M/UYedX6s40XTfGmSqNHLkpelTonjJS/B9hbln4OnvVKQEGTCj9fl6
 4PlhRZvfYF6NuI9f1JVoxDI1I6DPuxNghkZLKca/+G1Xvkw3XrOnh/pcKFcF0AUK8fJuPl9H1A6
 1qdTA=
X-Received: by 2002:a05:6a21:62cc:b0:3bf:63af:859 with SMTP id
 adf61e73a8af0-3c08ef1766cmr8508274637.45.1783460911271; 
 Tue, 07 Jul 2026 14:48:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:62cc:b0:3bf:63af:859 with SMTP id
 adf61e73a8af0-3c08ef1766cmr8508246637.45.1783460910831; 
 Tue, 07 Jul 2026 14:48:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c76dsm11841203c88.3.2026.07.07.14.48.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 14:48:30 -0700 (PDT)
Message-ID: <c32187f6-6e1b-4cc3-8384-d498496cd521@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 14:48:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: docker-image-debian-all-test-cross errors
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
 <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk>
 <87cxx0wm51.fsf@draig.linaro.org>
 <5a2d7dfa-3e08-4f95-9f22-0c3573d51a62@oss.qualcomm.com>
 <87mrw3up0e.fsf@draig.linaro.org>
 <a8716845-c989-46fc-b9d0-ea9162d1da04@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a8716845-c989-46fc-b9d0-ea9162d1da04@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxNCBTYWx0ZWRfXylW0i7D/MQ15
 pAwTcZVFk9hJpvdWmHOK1zXlgnyUYwK1y3zBNdFQ46txxmaJER6dtn/chzQomt60bZjqxu10OGN
 /wnfbHiSxsXnwikqdZeRAP26jtV7IjIADwu1nik2c/UdBRG1WhicIQvDY16BEvRwFLtcKpNeeQu
 F7O5bddBQD6JKvBqn6AmGphL59lolaf4yU+zuCp7MLZC0D4BysWvTs9LbG8K7BaTByJ0rUxUPob
 pcLIeHwqbELm+CYKuu9nlG0N3idtuYyo5bKLhiG11hPn57NRm6AU9YwhLUgh/OuaFnraXTa4Wj7
 jD5iDlzHLdswQIBzAdOoCy40/U0Gacns30zLeFHMCkpTivDBWWOVFOGjtzwpnH1skOxUFghvZnC
 v2mZslAMX8rYpjn7uWnexqs0sYK5qOZxZnnkmfjQwXspZa+ACU9YMCq19lmznlE0YgkInkWZb3N
 zkdNarDYbYySkWqP6oQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxNCBTYWx0ZWRfXzIyhyhykEuYG
 UydqifKSgE0G3zjI5BTx3QK5416zNtojDlvcw3KpicIvsKG2468RvcDRNVGxhFG2OfqygbCdOvu
 cxHks94zhOvR+ekcSmYvLu/ArEoFuVA=
X-Proofpoint-GUID: Itu_fGhXc-mXxfSuFEnnZqTicwlvzOzk
X-Authority-Analysis: v=2.4 cv=UvdT8ewB c=1 sm=1 tr=0 ts=6a4d742f cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=xNf9USuDAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=pcZqCyVeAAAA:8
 a=75C_dwgdASpFbcq-otMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-ORIG-GUID: Itu_fGhXc-mXxfSuFEnnZqTicwlvzOzk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 7/7/2026 9:34 AM, Pierrick Bouvier wrote:
> On 7/7/2026 2:29 AM, Alex Bennée wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>
>>> On 7/6/2026 1:35 AM, Alex Bennée wrote:
>>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>>
>>>>> On 05/07/2026 10:07, Michael Tokarev wrote:
>>>>>
>>>>>> On 05.07.2026 00:20, Richard Henderson wrote:
>>>>>>> Has anyone else been seeing
>>>>>>>
>>>>>>> Error: Failed to fetch
>>>>>>> http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg-
>>>>>>> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
>>>>>> ...
>>>>>> dpkg (and all related packages) has been upgraded from 1.22.21 to
>>>>>> 1.22.22 version quite a while (on Mar-2026).  Initially debian trixie
>>>>>> had dpkg 1.22.21.
>>>>>> I wonder where it is getting the old version reference from?
>>>>>> Should the previous layer be refreshed to point to the current trixie
>>>>>> point release?
>>>>>> /mjt
>>>>>
>>>>> If that is the case then I think you can fix it by doing a manual
>>>>> update of the base image to pull in the latest update locally i.e.
>>>>> "docker pull docker.io/library/debian:13-slim" and then rebuilding the
>>>>> docker images once again?
>>>>
>>>> You can always trigger a local build:
>>>>
>>>>   make docker-image-all-test-cross NOCACHE=1
>>>>
>>>> it looks like the source tree build of images has been broken again as
>>>> UNCHECKED_GOALS isn't being honoured for me.
>>>>
>>>>>
>>>>>
>>>>> ATB,
>>>>>
>>>>> Mark.
>>>>
>>>
>>> The right fix is to modify our dockerfiles to always combine apt update
>>> and apt install, to avoid those kind of errors.
>>
>> We do for the main part of the dependencies from lcitool. We then do a
>> second step for the cross compilers for which there are shenanigans to
>> deal with non-x86 arches before installing them.
>>
>> But the original failure from perl should have been picked up by the
>> first bit.
>>
> 
> If you look at original failure from Richard, it's this reason:
> 
> ```
> Error: Unable to fetch some archives, maybe run apt-get update or try
> with --fix-missing?
> Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive eatmydata
> apt install -y --no-install-recommends   clang  dpkg-dev  gdb-multiarch
> libclang-rt-dev"
> ```
> 
> apt is even polite enough to say we should do an apt update before :)
> 
> I'll send a series fixing this, I found 3 dockerfiles that have missing
> apt update.
>

Series sent:
https://lore.kernel.org/qemu-devel/20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

