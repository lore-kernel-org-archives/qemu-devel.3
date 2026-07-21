Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6468EC44536
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGWp-00029c-2l; Tue, 21 Jul 2026 15:53:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWk-00020o-EV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWi-0007gW-8A
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRTYn1926636
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:53:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 z13/qupV/DR1u31R8kOQG9JlZZAOHbQKC6IQvHUFffw=; b=F1q0gtKv9VdLKtwU
 4x4hpIp+X35vVmhdO3o0d92w4J+8zA9dppJggBKrcPWnfnjx2a4+VC3jc8RuS/rG
 UoczFIu3m7TjB8SW7KdsZlTPE+QSKPb6xff6OBE+lngjZONJZ6k4IiguKdynDl9e
 0rNuDwfq0tW36lYVQnFNdHbmwTiBM3+sYX2Ke39YsVlsmMkqu7nsP8MDXzC8oGlU
 I83BRu3FQdjHTdoEbTMOjQURPclcz00lTJr29KWQ+25SmPp6aAVMk8f1UMDdqgMu
 YVgcsVEs2kNJ/eXzofdA/X8DNCCgxM5dMdErEyojWoJlgqMzNEtf+TWwMW/SKjZE
 CPlo5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6frnjw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:53:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso238827091cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663593; x=1785268393; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z13/qupV/DR1u31R8kOQG9JlZZAOHbQKC6IQvHUFffw=;
 b=j9JYV49sfnR9P/kJq++h66dJRHMXrRMUuaSNUGUMEyVcZTM/jQ/SyxIFs7eN/EsFG0
 0yel2agZGcYX+D/fn+MDBB1rU8rQIUZwK3gxeoc6T2Wt37RW0ydiOi4Qs7gVvCTd7dGH
 i0l5Vtgiim7mIxQdyFMftAoGlQCSTt3Jh8T5pr8fqExlX1LSyqNB1DKdhuW/hvt9Pxii
 vnsuKVYhiOzWev9v6gwpw6SuYxgvMBt4xqGNf2tVCKx2ruGIP+HqtXxbvibp4Shfgdek
 XKdRV2FiU3ThPI2ivW+MSZIXUHdV6iTJRG1TrAxJd4C45+Rz3g8v27yHDNWsjgEYgQrK
 i02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663593; x=1785268393;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z13/qupV/DR1u31R8kOQG9JlZZAOHbQKC6IQvHUFffw=;
 b=hlI2jLtSUNCDsGZlFfg1bW9tWtKEdUh9pkmZLf2f9/+i4Q5T0XUNePPQtDTpnrgZiD
 gSi994fm0BnGhyPOuy4FiU+k+uaLqO0cPwkzmW88nSlRT3PYs2DEtvrRwANxeoADzxXZ
 io1YlgPs06b/nzUhTksnkHHUGjhtsGkaMiIRwTZ5uBcZc3Otl6jfPGxgth80Y37ZNeDM
 mNCKHVPqd3+C7MNtvfTbJhLtKsQ5IHl1vRiFx/cGnZAYUT6dhpOueoN+7ZAeUPa19pkL
 KyyI0GgjrbAvaOsmJoKk+/5qg5QOadU5LEPzm5utVWb294OkLx43K6kfynAIYCegxydx
 oIVQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrCHcNi1TYOak0iLlMMXrQuA8AGjv4/UKdbmd3AgolrETT33lCQW3e6gtPSgumFPeYzrlm9tj7gyorP@nongnu.org
X-Gm-Message-State: AOJu0Yw0OdLoDeKQX0rq0PT4wXvYDBft3AGmzJBmusE4Y+D785+jcxIQ
 FiMqNbh89FCNfhV+Iy41JNWYUg10ZXVv5akLhXv7ojX6/n/iTKP1peJ7setqW1nK6vls2ZB7PrE
 Ob2+PJZ4zZu92/oOLnPRRtKp8pSC6kKm887aWQDoCgAu2fZkK5eYP4N1elQ==
X-Gm-Gg: AfdE7cnqz6AmLfa6zJ5/bWj5/ZHAzz22U8le7bMvzUWtP7AVPB5I8YyP6jvAQbMw76d
 VUSiDfFtkWWLz9Nom7ddnOXsM2FpLpzY0n4T0Mzbucddwiso3NJH0szFm8sGB4R8bUsMkCJ2ceb
 g0eMb7+ivB7vuFlgpmsjcRPcul2Fp/H/ROvKKnACFvMO7dDlOcVF1jJDzj2CWvfLoiSFtJZ5kiU
 HnaHhbUdQaIcuWYRJ1aVXuLmnuB1QdmusAgDOOcchWnF1oxyoYLYPPeccQeZJNOHOIrZnegucEA
 WNVvK55fjrxsH4vAVuviLtl4p29+wUyckcgyC987fBvVG19ONtuXmlqFkPUFUx8ReV7uCds4NU+
 Rgg3ZdB+PtyMcYhuwhwFXI4nbtsT+AyaHTiOi5BBUMMySwMpuHNo=
X-Received: by 2002:a05:622a:118a:b0:51c:7b13:62f4 with SMTP id
 d75a77b69052e-5213e88b48bmr189095651cf.74.1784663593131; 
 Tue, 21 Jul 2026 12:53:13 -0700 (PDT)
X-Received: by 2002:a05:622a:118a:b0:51c:7b13:62f4 with SMTP id
 d75a77b69052e-5213e88b48bmr189095291cf.74.1784663592625; 
 Tue, 21 Jul 2026 12:53:12 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm43853939f8f.5.2026.07.21.12.53.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:53:11 -0700 (PDT)
Message-ID: <f7e684b5-a407-4873-8e7b-77e6dc4d5c63@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 07/15] hw/nvram: Use qdev_is_realized()
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-7-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-7-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eLNqMt_-cFnhbd5Xgiw3009DLlFkbxFd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX7rVIzEOk9PsY
 qjZavADoGje3/2ZnfmpkT0+rN+hSI/g3+RIk1zG0HhO9x7bkSDXM26fL6+nclULrCSSWEZILvdb
 r2h14VeDJMS93Qhgce9WWPHzaYMe/mID/s4u5qSP90SxBD4ABTO2FZ56lF6nol9f5XkvrN2NSiu
 UIlYqxzJ6RYtfrJIzQmxuwVhv2yZVI4EDza2/PdoG9QGxX71ayRVpZUG41Dsm5cZHg4NLlxMNwc
 uBuzV5DcN0gp4BoQZg9WZaoUOJYByszR4FDbEomoDZbDFQlnIer86tWtzsLjiSGHc2MVWa+OWHG
 iULGiuTLORcvYO8CNTvNpCmKyD+pDC8AIU9yJSTUGib6uGqot9H7sIsTQw/eKDEvIt/U1Ba8t/n
 l7vjHBEZLNLdizdWa3CsQcx0Clolde/Ch8swWT5GHeBDObW6zUL2Mhy+uFbe/VuJdSjBjvqkGl0
 jP+p0whDCmy8Sy9o8pA==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a5fce2a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: eLNqMt_-cFnhbd5Xgiw3009DLlFkbxFd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX3p5irUgOYsCy
 h7L//ym+7VdXzd82jNRQ17lMOo9/3jzBZJZ1u+jQGsA58gGAQ0CXDXtchxAodv/U9cfdVH25SWV
 xMa1va+aU2J9LZ00LPzNzOV/Pt2S7W0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210206
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/7/26 10:16, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/nvram/xlnx-bbram.c | 2 +-
>   hw/nvram/xlnx-efuse.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

