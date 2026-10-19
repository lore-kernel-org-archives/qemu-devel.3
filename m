Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731F0CCF2E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 13:51:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xInm7-0006yo-Q8; Mon, 19 Oct 2026 09:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xInm5-0006yY-Ij
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:51:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xInm3-0002uN-Fs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 09:51:37 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8P7QU2236099
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xy1gDbTfb3LzVQuoNNRtrt5wZnQw3lk5LtjXfvLSBvU=; b=oCmn0ZjPMhbTVq7T
 517YltwX4W8pocdqtoH4XIbVTc6o0KUuobtSOb9f8MuuQDb9mfHmva2AzTWmxVDm
 yrSrc84JZi19OOHOIO55iOWb25w5BirtdfsQW9uz7WuvIigIsNu4+rwBFApGdnKC
 SlBydoCwfAmavVut0WJU9DyPntd3RDvHM7eWEZlP6uAcR0Z0JfBsGRiXVT6s+Ueh
 +qKVU/oMcqHC/7GL1eP4QtbwVgT6Syy4H8vEhRwdzVFEdSdJNW2LcSwypV9N+fc0
 Unb/buHH9sW9JrL2t/iu+awZHVP2pkGE5dMCm3iMD/WkANtb2nh5ABx9scSEU7A8
 P/4XcA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x9d5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 13:51:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-53395d51187so34478591cf.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792417893; x=1793022693; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xy1gDbTfb3LzVQuoNNRtrt5wZnQw3lk5LtjXfvLSBvU=;
 b=NQtG5vkO2PZSbvG7tHwnyboPotwP5AEz31ZvVHtW8D4anV+xh2MFHvWvALm40PTll1
 XR1JlSVCltvatQ7ltOTO97ZJEipCj5L2ex9rzGvOdDRWaiMsX9P/sqEhMLv8Lswj+CjG
 KSEGJDBHhtzCgjbT8hQJG7fv3CSXuRY8LwqjaY+XxRonPL1jE+uX/hfWrOWQcv9y5S8x
 eQAn7V6bWJr4nQU/E4/ratQVAqe5UvOKj4tSmLKzRZPH7tWq4ZmaKrMoxiBbaigU1VhX
 N7rgRv3ZKsSuX1zHUIKWR9GzY6Rs68l67J5UaSEYB9p/Gd9r5Ew6+eS78/ZVOpFLLBtu
 Q+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792417893; x=1793022693;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xy1gDbTfb3LzVQuoNNRtrt5wZnQw3lk5LtjXfvLSBvU=;
 b=T9FMXb/XwKcAr5Dd5QDjTTRumH2DHT+TcKq/o4dvXZLMpJ96XheEFpSOv1R+YbJWZ2
 vCQfVtPPHgMZEELfZtiDZwfPUEPpL6UcqpCd+GukZQmBn1/TEj5O1coPe+cO3lUWMDqs
 ILMOKxqYYrUKNEjhIZH5gvNXNY32P7pTUyMKatdNlj7Atl9kT+AxTAPMg0JWRML2Ym70
 umX7eC/IiOiZYA7eCx2uo6kQNutJLk9zvgcJv3fpXyf49dfshGSHNXh4YyOnOgIRL1Lx
 9Ho+a1Lnv4XEfXaAOQmp9HNK8JB7qSvD8I57gzHDOX3hPTDvDyROuEgUPXddsTyY961b
 lVuw==
X-Forwarded-Encrypted: i=1;
 AKwUvByUfhYp+iup0W6S6gsTvJZd+rH1IpCOVqe4xR4kAR/YSSA3RD2XiJVP8eTve9q5xCPzbTRstem0ViXz@nongnu.org
X-Gm-Message-State: AFq9FYJMLGhJZZKhpgPiEVktBrbTKfsHQnVH/ZVbgpHzWwDcs8PHaB+m
 Qp3W7AattUXNfRMIxzxitcY6Vv3DGMgulwrl/vMAMhNqWaORAavvDYlMwJAUbnMDPE75MrJCAst
 jfpRcRv4NdABNACkYW//KGADZJ2vN4CTO8XZZIAK7nCFrTPdb1eWLrSbWXg==
X-Gm-Gg: AYBFou0ZeKbU1gC7NLRX8/unGmZgjo61rf4DFtHRNfEaL3rhWadKr5GAcoS0dQiYBoQ
 eCIM8QAiBS3ZelMy4y0XOfGyBXY5OYMestEwMIabP9DtVMgNZatd/sKP8c/I0TRa603Ds4vsSPT
 j4MJSwVKhl0V6e9f7+lvHuscI+aappEnGGzW+u9+oZlOgV8Yoc4ozRXf9Tzpb1QYF1SrV8D/Y6l
 TlUnTkA9DPMeM957VoonOz7+yjcKz36hKucYEqeaxkHou0TDDMSdQ1yA+jTkg2YT++YOXeluv/p
 VmB7+aOiLFFEV9CAViG+VXIqOlYs+O1anlhUp02Dl/KUBmHyRYQlMh8Zi7Gq1knLycVS748vHSo
 OK0FZJRvuKNWmCvSAVpSUkqnh2ntlnAIsWrS0CXRfctZze0JXP3BrnxzOVpCWmJS5
X-Received: by 2002:a05:622a:4d8f:b0:536:3638:9553 with SMTP id
 d75a77b69052e-53645fa02damr120006411cf.22.1792417892810; 
 Mon, 19 Oct 2026 06:51:32 -0700 (PDT)
X-Received: by 2002:a05:622a:4d8f:b0:536:3638:9553 with SMTP id
 d75a77b69052e-53645fa02damr120005731cf.22.1792417892033; 
 Mon, 19 Oct 2026 06:51:32 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5364de4d690sm65489411cf.3.2026.10.19.06.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 06:51:31 -0700 (PDT)
Message-ID: <9ee17c2e-5f47-40be-8741-cda9390c1e04@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 08:51:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] tests/functional/hexagon: boot DSP firmware
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
 <20261019055245.1457795-15-brian.cain@oss.qualcomm.com>
 <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <56dee5b4-f1d7-45f6-8a6d-a1d9b3d6e7e6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MUbRqZ8jqg7oSEuNxmH-sHkYsbK7ULMK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1NSBTYWx0ZWRfX97ZUxkmsf3SZ
 dySZCPSe1Of3Tf3HAWC2bcHfthuALeP8pjfhLiziUCjhz3djK7GKqJADmkLD0A0Ewpnrr+IPa4o
 CuEJZfXuIZvy+mrZ0K4JFzjnhmbylTs=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad62065 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=mrrHRRGAi--OirCfiF8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: MUbRqZ8jqg7oSEuNxmH-sHkYsbK7ULMK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1NSBTYWx0ZWRfX/655zF+L7KIP
 078v8ZsUjf+NKPy3HtSwlFaXdB8zo8J3LaAJZMRgosKvfvoeQbIYlIu2U3kARx4dnKXNNdOwl1P
 fKBP/hPyQDzwMq5YOs6awCP3Qp/xHV/uROCn0qCaTxK9BoHxRyEr5podzaBe/KUX8ITUPeralKJ
 20eeLosol8N+hb3zeIVOWxzShBnGhtAXgeAhAYEk79t8mPybLfmkawnFK47EivdNXJBymU4z8sg
 bqGv2VI58RIWro7OjAUm0SNNKqty3BnobWYPPaKW8ihWjgrFkR/6Q23iGOi0o9R2kIkhS5zTTcA
 4OOQqUBcaSwYnGtzb247brhLs5F48t3H6cZx8C3qOoyQnCda9yleClpPeYuv/keT4rZI+seCsBj
 caFZtuBB++e5TJfg0mr830OclgenjDSlzggKFEoiXzzf92w00m8EJl3xo+KN80TE6X+97BGx/7y
 ghA7X3wlm42A+qJO7fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190055
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 10/19/2026 8:47 AM, Philippe Mathieu-Daudé wrote:
> On 19/10/26 07:52, Brian Cain wrote:
>> Download the firmware and run it on the corresponding DSP machine.
>>
>> The images are third-party binaries, so the tests run only when 
>> untrusted
>> code is allowed.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   tests/functional/hexagon/meson.build          |  2 +
>>   .../hexagon/test_qcom_dsp_firmware.py         | 89 +++++++++++++++++++
>>   2 files changed, 91 insertions(+)
>>   create mode 100755 tests/functional/hexagon/test_qcom_dsp_firmware.py
>
>
>> diff --git a/tests/functional/hexagon/test_qcom_dsp_firmware.py 
>> b/tests/functional/hexagon/test_qcom_dsp_firmware.py
>> new file mode 100755
>> index 00000000000..86a0628d9f3
>> --- /dev/null
>> +++ b/tests/functional/hexagon/test_qcom_dsp_firmware.py
>> @@ -0,0 +1,89 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Boot the production DSP firmware on the Qualcomm DSP machines
>> +#
>> +# Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import QemuSystemTest, Asset, skipUntrustedTest
>> +from qemu_test import wait_for_console_pattern
>> +
>> +
>> +class QcomDspFirmwareTest(QemuSystemTest):
>> +    """Base class: the firmware is the ELF that -kernel starts 
>> running."""
>> +
>> +    REPO = 'https://gitlab.com/kernel-firmware/linux-firmware/-/raw/' \
>> +           'd947e4e8e314e9254a1242dc1a5d9cede2cce33d/qcom'
>
> 404: Page not found


Huh.  Maybe I picked a funny commit and somehow the asset cache fooled 
me?  Will take a closer look.


-Brian


