Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFF8C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:29:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgro3-0001sc-9o; Mon, 06 Jul 2026 18:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgro2-0001sR-62
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:28:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrnz-0003nQ-Al
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:28:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEG3o1505081
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Tt3ZJ0jaXq+vZgwQFNvhA0f9TWRO/8zph0i5C9ehrTE=; b=GdKoU9wxXpon6NBu
 WFXsyU61dYQD3sQzyM9Jf/j6aiP2zDqYksd+zp7/MyuoRQEDsq4kPTTeTKqsavS8
 rI3YOI/hoKf2J+uI2o1omvi0MAcfZxQJATd+SYcgubp+Oidh+ozl0LfI5aAT2QVn
 YC/L84ZWo0H3/RfJUTlEG3bBZmJetVnUxFMANozAv7jjFM0Cb2kIrj1IahVzUMV2
 UTRw9Lior+pifN0U+AfPsVz/VrOuTJSwxBXednZATmbi+xE1UafVTSCkS2PXOYse
 yisnjW+pddhGoVz3GrZGYcwbPK+no9mmMIk8GuPY/llxwQRY1o019up/a5PkWc5J
 ytdIvA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k23v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:28:44 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37e24235ce1so5205849a91.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783376924; x=1783981724; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Tt3ZJ0jaXq+vZgwQFNvhA0f9TWRO/8zph0i5C9ehrTE=;
 b=YHLKPPFH0H5N7n0YGgWd/MX/EGhKXHgmbMk18SFrWBM39S+sZV3XvWPDL0Q7E3eDCQ
 ZYt87hfOu9F0wFqxLiCqhx+1mv2Eqb0PKYx6ilsGAjxi+f5l2VtuCRAk1PhO5JOJHsab
 IN+Xkuf2Y2nY7oXihFe6w8+fsxUhV075jFyWOGgeGC1M1dCOCxpDSeEuPP0otQIbiGzl
 dSj1ll2S3916dxRK7fi6y8bhE0kvqH7YCbF8xV9h/BKEAJAr0IcktpJlDX6QFmZlgY/s
 m5XYCEHjsv39Q8eZFDyfAXymdZ5+V8Lh3FB1pXD3XVxQa5y3sxKsQFSXIRIOOyj4IxwR
 A8FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783376924; x=1783981724;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Tt3ZJ0jaXq+vZgwQFNvhA0f9TWRO/8zph0i5C9ehrTE=;
 b=A2+k3TwdzB8I+J+q4QxZi92gE+QnLhmAsXrCiyKUU77Xago159K3oIf6rjZ2Fqcp4A
 isfh8eKJoKi8ctJKhSFsAOb6obJ40opxsxd+by+gfYVCKDNEl8/S7XPdw4bjv+C69cmt
 5yMHkvCLTY9nkR90ZhdJ0pNDWSpB6A066CwXDkbYLHHyhP18e+qnjwfhkCoud0FcHy9U
 LpqwDLsx5ZSq7T7jOYpktJzDpr3cbqV5ijqEi8v5NoxvzPF7yGC2kOm6R3uBjvAdSOCr
 GqyCEHVekTknYtgg153lha2TcPcFENOKljOyqWHUsX00/AAfLlP91FSDYNDjzhIf4R9r
 2IWQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq+RinwFDi3ci24Khsh7paLH4H4EKLNlkdFgA9pyOJnZ6yByXl0kjy/CzTvjr4A5S+sWW4Zua2nrh2s@nongnu.org
X-Gm-Message-State: AOJu0YybAs40ueC1kk9i3w0WMF/aI8mjd+bw5Bs+L1tANXKm8ci/QynT
 uPgs5cYfFbiZuoSVCy4lHyzC8d+6pdttQtWkDj0ej7Vbg8Y0qOJHMYPxHyTJLnUERh/Crh9/7PF
 o8wRzNKe+Fzrf2N+cWFKKZd/APA1qkyoR9XqgxqVl0pGNUdjDgY2GTGoSuA==
X-Gm-Gg: AfdE7ckVms5GHDw4o/KcesTKP9g/rFuJEr3f6XpPVcJD87wj9rIOdWseRjjYRnAzKvk
 RmeoNMM6VTHMPCcuwRWMCYE2CGAgThs73St0iWjFuzGRuGkw705aI/v8a4cCD39g9xWLjAhKGNp
 7T7eg5Ebu30RmPxjpWjpqYP8JjJyK6dCSd8t3k5dDnLLoRd+CalXLmKVLdBA8AYwk6mMlYm5GBR
 Gr9z7MHzpQqvolIItklCY+1f1vV55fngVfxUo5ChquPFt2b9DpeWjc7ArN+i+Z1Np1yKLLipIW8
 FWEN3OM/iBO2AT/rJ2IO1GHaqXJmLfX7EmPtq+iyNi4vewhi4HspscJQp3RI2AUALJH78KRFnCq
 gdngRXvuJ9oKyF7eRNSZ5zWIeDZZsMFzkVeih965h8MEOHAYJkCofaN29lq6ZVvxD/gBWP1KD0A
 eNUgI=
X-Received: by 2002:a17:90b:2583:b0:387:df8f:1402 with SMTP id
 98e67ed59e1d1-387df8f144bmr98291a91.35.1783376923820; 
 Mon, 06 Jul 2026 15:28:43 -0700 (PDT)
X-Received: by 2002:a17:90b:2583:b0:387:df8f:1402 with SMTP id
 98e67ed59e1d1-387df8f144bmr98247a91.35.1783376923112; 
 Mon, 06 Jul 2026 15:28:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a583bcsm1043615eec.19.2026.07.06.15.28.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 15:28:42 -0700 (PDT)
Message-ID: <5a2d7dfa-3e08-4f95-9f22-0c3573d51a62@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 15:28:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: docker-image-debian-all-test-cross errors
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
References: <4b08f4e2-2274-409a-86d8-469c73e21579@linaro.org>
 <0403705b-9af4-4de1-8f66-c56befa5bae9@tls.msk.ru>
 <24d6a029-5f68-4314-820c-fb1786012fb4@ilande.co.uk>
 <87cxx0wm51.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87cxx0wm51.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2c1c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=xNf9USuDAAAA:8 a=n6MYwUk4AAAA:8 a=pcZqCyVeAAAA:8 a=1SnmcqbCXANMZsC70FcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX/5JDlO7dXaZs
 S41ePQjq8HyRRhWJb/DW6Y9mtyUV2BgZ81NZFC6QqoODdJGzyn2Ym676ydRiDXsoEZSoOfPCeff
 dig9ar9kiJEoQW9AO6Ko8rWHE60u2YQa8AybdMZIdMFC+f1O8ojfKxpQgpOUuLI01Hult9Vkzix
 0GrqlL4QC0QaRmJpRpB3ncrZA2Vicc27o7QdhsNLzl1sbhTKkTD+INve/tRCiPPysLu5EGoHDzl
 0ZU0R10Qq5OoguvkvnahCk/h2Ra2nxW32BXtO5NmgWf+AOE5KpVaqxJbgG1kcg7bBBk7WPmSvpU
 m0kq3d0k+ESeEW2DIb/2iIsZ5LkcmvAsE3iocnllTI/E54Jbhgu3tUKs7/DHn0jWSNQL4OeuM2N
 boNV8G7FlQzpedUgDzKAiBTDPhbXXFRJuq6uGixySbKxam9EKQlqGbMAobwaEcOQFFEhPlKEWJF
 Tsg6WCrHJOzalIHR1mQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX768+9JuRTyOq
 /qyUFRdVQJnGAWIBVk3owmWB6vT+t4YBBEu0ug2pv7FP/ZijujNo4yzLLnI51i74Omk6EqrEqnJ
 PoXVifOAsisuP6qAq7LuEDaQuJ9ic8E=
X-Proofpoint-GUID: Iq7LCVU6ubrDtk-HFzAeWihnpp1Hk54x
X-Proofpoint-ORIG-GUID: Iq7LCVU6ubrDtk-HFzAeWihnpp1Hk54x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

On 7/6/2026 1:35 AM, Alex Bennée wrote:
> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> 
>> On 05/07/2026 10:07, Michael Tokarev wrote:
>>
>>> On 05.07.2026 00:20, Richard Henderson wrote:
>>>> Has anyone else been seeing
>>>>
>>>> Error: Failed to fetch
>>>> http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg-
>>>> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
>>> ...
>>> dpkg (and all related packages) has been upgraded from 1.22.21 to
>>> 1.22.22 version quite a while (on Mar-2026).  Initially debian trixie
>>> had dpkg 1.22.21.
>>> I wonder where it is getting the old version reference from?
>>> Should the previous layer be refreshed to point to the current trixie
>>> point release?
>>> /mjt
>>
>> If that is the case then I think you can fix it by doing a manual
>> update of the base image to pull in the latest update locally i.e.
>> "docker pull docker.io/library/debian:13-slim" and then rebuilding the
>> docker images once again?
> 
> You can always trigger a local build:
> 
>   make docker-image-all-test-cross NOCACHE=1
> 
> it looks like the source tree build of images has been broken again as
> UNCHECKED_GOALS isn't being honoured for me.
> 
>>
>>
>> ATB,
>>
>> Mark.
> 

The right fix is to modify our dockerfiles to always combine apt update
and apt install, to avoid those kind of errors.

See this doc for more details:
https://docs.docker.com/build/building/best-practices/#apt-get

Regards,
Pierrick

