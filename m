Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCF2C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 11:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrZgY-0005uf-Mk; Wed, 05 Aug 2026 07:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZgU-0005uT-Ao
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:21:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wrZgR-00035F-LD
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 07:21:18 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6758dK623540586
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 11:21:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 txOy2sGM4LGcuY90/lOUtkkrd4M1CeK34gfzRGbhz+4=; b=XqFm6P8+Mgvqw1k4
 VC5CeGdcYKZWAeGi6egctTVCP4RzIyO4mTTtFxaxOzkd5xUw6hLssWp02U6iSE4H
 8BN3T6S+wFKsb1UrpJsEeTVdutkeSZD5Xrq1ipILbXgjoP4BFKjySif+co81pVi6
 ydsTHNdO4O0UjBGT16wmf2aS40TnWsRq8JtR9SQ1eWzr/kXhjLxuOMXq0SctPIsP
 q8MyqfcZFQZJMp2ygE9mGRdFYfBvzwaZpvESqF+GrcQspyTmTH+xRj7HBu6pABxW
 pMesVlbb+hr9youVsE7nVVJJ6WXqCF/YJGgWXUq5X/f3POS0ZSZ1/fEn3azOampd
 tvfTdA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuu3ujdad-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:21:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so8980251cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 04:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785928872; x=1786533672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=txOy2sGM4LGcuY90/lOUtkkrd4M1CeK34gfzRGbhz+4=;
 b=SqS9AYNpCDcCOwbeL5DWBuE7oplEA7leWo/u9ZlMdKmlaefdD8Uyeqgx/EEu4ebTBF
 vhT5rzY93fGkoHFRZyWDc+83VBkRoQ1y6Cq8dzLW6LKbj8bWNfgYIGeoJHplQdDJsdza
 Pl3P9hymytstc2EWt/9NV+rJ4tMkxNNqkSzFfFqIleUnmqAcTESo++/twbcIV6woGZLu
 IpGWLyNWtGxQ2EE1IIQ5IifklNRgtYKpjDZ4dHQNapFVREiRgxKBEEu1SbYNw5mAxyD7
 Ex667YBfmzxhTlJ2YwvndXqsB98ASRpLyP9ZkAzxkxJpo2Apl1M7KL3tquPq03lwSYYj
 3CEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785928872; x=1786533672;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=txOy2sGM4LGcuY90/lOUtkkrd4M1CeK34gfzRGbhz+4=;
 b=Jf9ixVuTsVTlP3jpcOI4BDhfhtMEoBdbZjmn9434fkVOt7PHV4J63lrq2/e/zd9ceL
 6NZeQD//OyTiudAfKAs8rDV6CwVgPpkVP35UBQIGk7Yu+HEUnrAF2OmtkHpk4bEF/DHV
 H4CLzSxjOcSFtD/x3FT8fTthcqWtBZxQk1/4IS2JkpqZa46f1O6FsiEqZraIfzCDhItI
 MfK5+P94M1niDBN7RvOoK4iMQC4hXu9Jicru8DSjuEp5a8GoFUx2RmMSSp9tu+KuMeKA
 HHXTKPfoE6mdhH0pna/jsQH1+xxX7K9+udKhPG3guX78arMOabjaBZrz++1hvwQs+b0s
 Q6lA==
X-Forwarded-Encrypted: i=1;
 AHgh+RowsWKRsNxHzzP4Pd8H40eJUN8hIsvradAcF27QifYbOLXT19zTOtsoh+udWP6LfixgnV2jcxbHDvNF@nongnu.org
X-Gm-Message-State: AOJu0Yz7/iiA8V4kYb5hjhILxWtNaaWEpm6e09viyuJnOE/ZOJUakpWY
 pewiqVIPsd+0IjsozULPbb0ePlhV3CutdSZb+qet/ZULvSyc+slW5Jy15EYJQeUr66/HByt9u1q
 2oMb2K9Mg5mH6Qt/rSmj+f3381HlXjyXDzhhhEDlOzr8PkkOWPtmbDV7tTg==
X-Gm-Gg: AR+sD12QSszG6ddA7qyKYc8Myp82lsTSmmJdRTwTdKvZah588k6ILRBSzlmNbSWrGF4
 jmar7/56PXcvLyAJiK5XNNLvSrZ8sDs615nKpainVvYPuUg5NK7yYxaJlze/dbGbuwRGoxMjGdi
 qDbpWOm+fcZDg+chiamXpbxAX4OoXRANh0EDI/KDxmKKPK/PHItmRcYu+zGcTRJ8QdAMQLur1bm
 YlQLzxkqWFHU6H13WvXlaghUvddZHqL214XbRIgiqYSqhlBkbJUSpqDu6I4AwQYOszjRF1hla2M
 XMJdkXjAjkdj6vZ7Msn/8a0R5k5G9EuBA08hDKquWgug9m2OBALHNsnzB1DHdJmF00Ma/9hEY05
 sUWjARNwno+yl90NmM0668mNJAcD36qypvZA=
X-Received: by 2002:a05:622a:481a:b0:516:dbf6:f8e7 with SMTP id
 d75a77b69052e-52ce6035cf4mr62369631cf.17.1785928872338; 
 Wed, 05 Aug 2026 04:21:12 -0700 (PDT)
X-Received: by 2002:a05:622a:481a:b0:516:dbf6:f8e7 with SMTP id
 d75a77b69052e-52ce6035cf4mr62369131cf.17.1785928871850; 
 Wed, 05 Aug 2026 04:21:11 -0700 (PDT)
Received: from [192.168.69.212] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a0fca55sm183593945e9.13.2026.08.05.04.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 04:21:11 -0700 (PDT)
Message-ID: <f76c7662-09d5-4f70-a72f-90dcbe9cfef9@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 13:21:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] runstate: set crash_occurred on guest crashloaded
Content-Language: en-US
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>,
 Wen Congyang <wency@cn.fujitsu.com>, Hu Tao <hutao@cn.fujitsu.com>,
 Mihai Carabas <mihai.carabas@oracle.com>,
 Mihai Carabas <mihai.carabas@oracle.com>
Cc: viktor.prutyanov@phystech.edu, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <178592075881.15274.7510279315190894277@linux.alibaba.com>
 <178592075881.15274.581512283969292515@linux.alibaba.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <178592075881.15274.581512283969292515@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfXz04HymRhuEG2
 IHg3irNuSnDufAFdXh2WGOfHJLASZKvTVkbqQAwvo/f6ovSr/25FZNULF4wsvtW6iHCJ/EKhXLm
 gQUwvBGdtgcl/gHlv6SSV4hfFHtIKZA=
X-Proofpoint-GUID: zOtd5Zd6CVWNZIL5x54e2zWB6y7cDqBj
X-Authority-Analysis: v=2.4 cv=B5aJFutM c=1 sm=1 tr=0 ts=6a731ca9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=SRrdq9N9AAAA:8 a=yPCof4ZbAAAA:8 a=omOdbC7AAAAA:8 a=zVtR0TOrse4S4XSZyCYA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zOtd5Zd6CVWNZIL5x54e2zWB6y7cDqBj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA5MCBTYWx0ZWRfX0QJe3ngimMSV
 BvUIt74gCCnMVGg5e9An9JcVqeDoGX6v5oAnkKDpYkuH5BhXW+jSiEopReGm4wkAtkEN7EeR/+S
 n7nf9dBYB+3WhZa9XTT49F9dGnhaIrvUPV22SXr67Qt2qmWoNyVUyv9FRthKyw1DD/a/AJLYFC3
 ybVHPfNDdqXXY4OuECm1mZhTHZ75WT9/cUdNz5/9Az4t35YnFDWPJidwyheej7lbKQg6Td6pytP
 k5EvyGdgKZuS7qY9baiVvKiw2bWNsOfkXDHB38G1+wK07N0z+pVClmtCYn44KXivCH1mnPXqV1S
 XIfOo2Ns+/tc2Q4pWy1dJPkxEAl5ZxyQ2SFHDzAafKE8elnvgHhZ8CZ9xO0H6Vt3zACb4XShQu8
 XDpIDFSermFw1i/xESeg4wL/jqmEsHH94HE3ZXR8mht3ieWOL0QSJcNI6zm7H+bq14aFcZPCF68
 2zG3nQAR4NsOBTO0G8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050090
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

On 5/8/26 11:05, Zhengrong Li wrote:
> Windows pvpanic driver writes PVPANIC_CRASH_LOADED (bit 1) on
> bugcheck, not PVPANIC_PANICKED (bit 0). As a result,
> qemu_system_guest_panicked() is never called and crash_occurred
> stays false for Windows guests.
> 
> Set crash_occurred in qemu_system_guest_crashloaded() as well,
> so the faulting CPU can be identified in the guest dump.
> 
> Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
> ---
>   system/runstate.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index 08acf801b0..c7961cc1df 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -724,6 +724,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
>   void qemu_system_guest_crashloaded(GuestPanicInformation *info)
>   {
>       qemu_log_mask(LOG_GUEST_ERROR, "Guest crash loaded");
> +
> +    if (current_cpu) {
> +        current_cpu->crash_occurred = true;

This is generic code, I'm surprised we need to update the vCPU thread
here. Could it be the reponsibility of the caller? As you described,
pvpanic so add this change in handle_event()? I'm also surprised
qemu_system_guest_panicked() does that -- the change comes from
commit bac05aa9a77 ("cpu: Add crash_occurred flag into CPUState")
which doesn't explain much. Unfortunately the pvpanic code doesn't
have any maintainer listed...

Cc'ing some developers active in this code...

$ git grep @ $(git ls-files|fgrep pvpanic)
hw/misc/pvpanic-pci.c:7: *     Mihai Carabas <mihai.carabas@oracle.com>
hw/misc/pvpanic.c:7: *     Wen Congyang <wency@cn.fujitsu.com>
hw/misc/pvpanic.c:8: *     Hu Tao <hutao@cn.fujitsu.com>

> +    }
> +
>       qapi_event_send_guest_crashloaded(GUEST_PANIC_ACTION_RUN, info);
>       qapi_free_GuestPanicInformation(info);
>   }


