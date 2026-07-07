Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12E9C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8kO-0004d8-4k; Tue, 07 Jul 2026 12:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8kN-0004Z2-6v
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:34:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8kL-0003MI-HV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:34:10 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT3kB4173275
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 16:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2G8H5SRhDO6xl9uTYiPPt8jqrTVbZc0XTNTkwwFewww=; b=B605iCBlWfyKub/X
 Z1hl5Sk+6chF3vJTgB9gEHdXF9HC0f4L4/njh5tdBZtuV+F9Xvcmdn9qPjmwQlCm
 UxjODnNV+/d1m5rrLJLqtMX8qYlsncXVxY/D6sqKQ7WGxd+SzdjLIr/XqZvwNg4U
 Rx2gZne7lyQ/eV7RUE/k7hQbMFrSxqVkB3J5ZYAm1jKiFB/lRQHmbD2rIDZB64KO
 Gw7N/PW/ok+5yizw5Wppsbnd1eYS37xroZd/0lhs2x0x27N/bZL2Lo/Ie+Q/3SeP
 WBaPCdekx7mmPWrrXTLPTM7W42UeDZSoacHWZufC60jsXRw5+j1c5U9nZBCtpRmP
 pbUzUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3tahx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 16:34:08 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so14339155ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783442047; x=1784046847; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2G8H5SRhDO6xl9uTYiPPt8jqrTVbZc0XTNTkwwFewww=;
 b=iFsXu/BqCqBaGadhoGj5bf8d0IHCe3VI3kvnU08k8B0ny71QbjeJ1g2q7f5iFwALGc
 /uFab4XI31GLcDOse31ETGMNYvUDAn1JLPScAX806cHKsuYIU0KSdw4/6Pv4GmubkMm9
 rzI8wR31bUEcWp0Owkj97hCRhI3DRGnXYP3Z5gR4k3yciK2KQYThXubdDUKf+CTTSyCW
 cxbqER5oMIzxMwpe8Xrt5XfP54bKB/bP+fMZxP7YetSgzL0knla+qEfWTu/hI5RAC4NK
 vN2OMZatzqZtjHzE9vHmDnnOm8wINI7QcxSGv9dsvzLL9vExaawvwdVC+Axzj11z2rDc
 82sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783442047; x=1784046847;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2G8H5SRhDO6xl9uTYiPPt8jqrTVbZc0XTNTkwwFewww=;
 b=cfQkAH9jYnMclbXNOpsUHaJVvKN59pcecjbTjX8UOVsz5JHxSfdRGVFXuIj2QN2s0A
 dQKuKQyylk59uIKqLyO8Z37EP6N6F/2+ksmA34lIzZ4tLzPVQvECCldWlRq5nGKHBpP0
 El4H/bXOqGGJUPJBpS60ZykGNd04yWRdSFzoWaGbxiHfP+UG4an2fV1f+y2O/EGtGxEG
 zGw4nhoDVX2MnrRa0NdCiyVx7VSGiNPwjvt2emHkZXoA4HFA2S5KHhAOWd3vO2hee5Hx
 39PbXtgTdPSCc5IygAGJk5LrSYKXyIambKTQ6jOKI4G6JNPjFd230UvXiVdj3gcg50Fq
 H/AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIlrSscKit3xzyuVxEnP9qS+Si3ogphSw2LkMucIkfTX/vn0QQbgekI1kBUTUHG3vkWKx81+b8iW1c@nongnu.org
X-Gm-Message-State: AOJu0YwtiwbDVqJYbuh/QIcqy/f8wPLADb/vLX+JAkc+UbVvbMEF8amB
 JfMPEkAcKUVo1Hw0LoKVv8xrHrYnN6tMBLCmmJx7LRDkpDBG6XHFMboF+1Z96V0z1Cm2JJiXOmh
 hvZmdpuL8GfCrMp2vzbwG7Z0aHL35sLE5N+jP4LsPn6zjdCmLafZJGV42jw==
X-Gm-Gg: AfdE7ck2fPfg5DVI7wuxFFVyKusQE6WObLV2mcEPCi4/Y36sJTp6JwPFiFnrLPMRmZ/
 e6wIzFDSCx7Np8Oc+sXgkO/CMclecOTNfjoxr5Z4MHbFtzPtvbQmbh2eq8SQpe40l7qnflN2syJ
 grafNAWFwVBhwLSsgjyAlTMV7r2lMGxf93W4LwQP8FVBJaL+C5Oaed0h9v226d2+kif8DOdfKY4
 Qs+wjyaFMvWaDSzJE5UgBGpbPKHL0+JVGd9nbpe2+9EJgK5R1SQ6GoadD1JWwG6Jt8dgWr+uvUs
 6oRl+TOV79dTus5xJA2K/ON/thG3FM/hGaqKXOLWOjjIFsbNHXQ2uxB19ZtTh3Cz2qY4jUnIENy
 7/jLagOeBPFyfXRsj/wJr7HexqNQE5f0jo7Z04675kvOvpQ1732rEqM7r6EiACeTeI2WDcnvDvh
 Wir6M=
X-Received: by 2002:a17:902:db01:b0:2ca:de3:15d7 with SMTP id
 d9443c01a7336-2cccad7fe79mr30865215ad.16.1783442045996; 
 Tue, 07 Jul 2026 09:34:05 -0700 (PDT)
X-Received: by 2002:a17:902:db01:b0:2ca:de3:15d7 with SMTP id
 d9443c01a7336-2cccad7fe79mr30864975ad.16.1783442045435; 
 Tue, 07 Jul 2026 09:34:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm14984704c88.14.2026.07.07.09.34.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:34:04 -0700 (PDT)
Message-ID: <a8716845-c989-46fc-b9d0-ea9162d1da04@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:34:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: docker-image-debian-all-test-cross errors
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87mrw3up0e.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mQ4rsFdGW2Y4SbSJdM-4H8KPV4YJhYXk
X-Proofpoint-ORIG-GUID: mQ4rsFdGW2Y4SbSJdM-4H8KPV4YJhYXk
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4d2a80 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=xNf9USuDAAAA:8 a=n6MYwUk4AAAA:8 a=EUspDBNiAAAA:8 a=pcZqCyVeAAAA:8
 a=bA3UV0whqcauOiWFQnMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=SGy6VSG0Ue1xmPAwIFl9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX54sG0HD3DnQU
 qdU7zoGyuTcs0/tuu7SLRQLGvKrnsUJJNU/k91E1T54afa1bJsmTQUYx+F7Jhlc/eor+cDWhpTV
 6Xo8H8PNeLv/XBYLqUq4gdCqjVhxYGmcf+TN8J79kTheB9FNTU5VN8BfCI33hphFZtem7kgfOUy
 qalxNVuZkDV3cKowXOZ8ZA+8ia95zpzfGO9JTAFOOAxmyte92TPuye+jkpz5v+Vq7BCQLgqGlhx
 cYvTrvSR9CRb8nRWXpPyJTcMNJdmJ8N6p3PLRmjl5sDUF0AGJDaQcO3Crg12jXQ3SG/Cal11Xe2
 5NbojvAJ0S0iTb9YfWo0zZ2p2PbZYSgMqK3mRcPKldeooIO84WbQ4T+TqQW69AA57Ov+2yS6hdy
 rdwSmbw9eGhqlIVzSoeK7MG/khr8m+hWe7w2IyTKS0mLzXrh04ng7rkhkNuExCc1fBkIkGjOztq
 WbOwXI3VNRjl25JHtwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX7Kn8szOELdLB
 pHaa9f8NZDjXJtQ2QhJ0DyYFMF+tJ3O9P59XiVYveE7D6I2ts2OY1cS1rH4Y4jKiiKPbCy2010J
 9g/78Zh+Ei/ZCUi4pYoS9jSjSZxxJpc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070162
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 7/7/2026 2:29 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/6/2026 1:35 AM, Alex Bennée wrote:
>>> Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
>>>
>>>> On 05/07/2026 10:07, Michael Tokarev wrote:
>>>>
>>>>> On 05.07.2026 00:20, Richard Henderson wrote:
>>>>>> Has anyone else been seeing
>>>>>>
>>>>>> Error: Failed to fetch
>>>>>> http://deb.debian.org/debian/pool/main/d/dpkg/ libdpkg-
>>>>>> perl_1.22.21_all.deb  404  Not Found [IP: 151.101.22.132 80]
>>>>> ...
>>>>> dpkg (and all related packages) has been upgraded from 1.22.21 to
>>>>> 1.22.22 version quite a while (on Mar-2026).  Initially debian trixie
>>>>> had dpkg 1.22.21.
>>>>> I wonder where it is getting the old version reference from?
>>>>> Should the previous layer be refreshed to point to the current trixie
>>>>> point release?
>>>>> /mjt
>>>>
>>>> If that is the case then I think you can fix it by doing a manual
>>>> update of the base image to pull in the latest update locally i.e.
>>>> "docker pull docker.io/library/debian:13-slim" and then rebuilding the
>>>> docker images once again?
>>>
>>> You can always trigger a local build:
>>>
>>>   make docker-image-all-test-cross NOCACHE=1
>>>
>>> it looks like the source tree build of images has been broken again as
>>> UNCHECKED_GOALS isn't being honoured for me.
>>>
>>>>
>>>>
>>>> ATB,
>>>>
>>>> Mark.
>>>
>>
>> The right fix is to modify our dockerfiles to always combine apt update
>> and apt install, to avoid those kind of errors.
> 
> We do for the main part of the dependencies from lcitool. We then do a
> second step for the cross compilers for which there are shenanigans to
> deal with non-x86 arches before installing them.
> 
> But the original failure from perl should have been picked up by the
> first bit.
>

If you look at original failure from Richard, it's this reason:

```
Error: Unable to fetch some archives, maybe run apt-get update or try
with --fix-missing?
Error: building at STEP "RUN DEBIAN_FRONTEND=noninteractive eatmydata
apt install -y --no-install-recommends   clang  dpkg-dev  gdb-multiarch
libclang-rt-dev"
```

apt is even polite enough to say we should do an apt update before :)

I'll send a series fixing this, I found 3 dockerfiles that have missing
apt update.

>>
>> See this doc for more details:
>> https://docs.docker.com/build/building/best-practices/#apt-get
>>
>> Regards,
>> Pierrick
> 

Regards,
Pierrick

