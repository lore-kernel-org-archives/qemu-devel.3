Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B83BC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 08:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuQlU-0000sj-4O; Thu, 13 Aug 2026 04:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQlS-0000sY-Vv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:26:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuQlQ-0001Ti-Q0
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 04:26:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67D5h1vv2189863
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 evjvH0vFpEX6fJYksxnXYcIksAByjFsyRA5uKPUt0mE=; b=YhaePBmbx51vwptz
 YffA+Y0CPlYgTPzzTCGnsvCn97jlt1s/c6E51T1N1D1MEILmsJuVbx8ZK90Pga2w
 OBTCleGmUoPO/d5Vweoa34/Es/Qs9jWMAk2egoEAK+/jZc+rp5rqAQAEtLbeQMms
 MkkZIvnmO70DPKDKBn1EADi0wEQVYIDipkrfSZLTwSiD5XTke26yTqsaKejhbz+G
 vND/OO7tb9s/CeUFYUspHJRGlg9agYiohe+fAbtROomTcNV1IUFIaVezao2PZpma
 A5NADSYDloPiUL/N5VuTsdqEvliIUX63g1/iIvWHc41q6DUv0Mt8FjsraaisE39c
 e28m9w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g18180mcj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 08:26:11 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5174a236220so18060491cf.3
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786609571; x=1787214371; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=evjvH0vFpEX6fJYksxnXYcIksAByjFsyRA5uKPUt0mE=;
 b=S3iyN7TItCIpyZUKGM1JxpO7kWwMqZygdcqEFGbZDfAwvJZ2MdVXo+LDxMoeWJgbKt
 cABLIpyZ4NjncHuOJDn3+W5cXo3MTmmzw5Owum9Z3iOuQhcsDTviKpg/qaEhnQVXDqll
 nE+2LC2cos50NA3sdz/1imsdAptHW//TQEaljJJi8V8SxnbU2qVGjgaUDNITtUtwFAww
 9K2ADtQlYjogEPcYbHX7VKGISHHPaPTasUCS8/jD0eKD4sWShq/jr0Dl6gG+R0ywbBoQ
 IlEHxRm3szjatzUnHWGyW1hPPuyCtd/3v6T05NWJZIpl6Fzyc6OD4NM9dIA8RoXmqwDs
 AeYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786609571; x=1787214371;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=evjvH0vFpEX6fJYksxnXYcIksAByjFsyRA5uKPUt0mE=;
 b=AMNBzdNHkHXaQsr4+AymiYXH58+wdzIxX71Kd5CZSxzIkMl7Kibqf7fevzhdfWAkxv
 Bai12iSv50uJOLvhYsKMEScj8hCFEKUB8OB2bYY8SVJxWf5AQ/vVoy6LIjJBs2SVjcbl
 jOljDHH9Ri9yMkQrnhokSOCrFxi2RHH4mBPood0ogAJ2D0ohk5cjtHxmFIfT9Gcz+mKp
 wvzxmSrXLwIOUvNTwumE/DrUaps5deEDL9PqllRz9Sr/7/ERAAplUHV4vMsAXfuftxZV
 uo1b2tjXx8VlTKVckKD9zO9yTB7ZsmFyRbasu4kqUk/kMbvEjp2aadq/ouCYSNLZCAzR
 oO/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPO0SkmGZzegxk4TpSnzcben2Xft6GJ8Lj93Pu+ofFgoVypHpyyRdOb7gNaAFiuGW5zz8MKd6RfeRa@nongnu.org
X-Gm-Message-State: AOJu0YyN1CYGJkkvAyYjvQe10Ag53m34MqmbiZ4qD795xSscs+Qm6kX5
 ND5bWd2om4fJ2cKIZ9bVqMjYoGqeOken3Cr1FsW+SM3NgcAShutpn/2PGbzYv1fBS/AVw/HVJxB
 yA7zcgDa9hQp02tjS1gV+zKWFAZnaIIhnwfSX3I5WTWNbxwNZj4txpkmkuQ==
X-Gm-Gg: AR+sD10wiwGb7h7QIr/8UbEi2nVxg9MMe61UZM0fMKSPWoUZfta2CQs91tkncQHf44p
 NCle6+VWA556on0xq46Bx6braK7n1lb/o+qwban7YxlCVLlUHmDTHFCdJmCiU+feyyuRKgEOKXI
 KRgeZi6bCz/9b2DfPnGjVgJZKrsNcmq6hyMEykT1miOZj290GbngvEeAImu/VZK6A+mGLamcBaF
 YNbYzvdGRDTd07fMsUNTP0TDiRaKkPKfAmm71ciyNGf+uTC9Uyg5ij9bQtMh25Pxdyhb/6avTXM
 6omj4CnrkJqar1Cgg/ppK9MEiE2XoqqDclxfxd3EFCbRpdl2JhsYsdav6Xu7d/hl2KQZkI22sNH
 ZaZY5R+see3eVawWMB3LVoFie4lDKsLxGeNI=
X-Received: by 2002:a05:622a:549:b0:519:e020:6087 with SMTP id
 d75a77b69052e-52d73c66316mr39230121cf.11.1786609570867; 
 Thu, 13 Aug 2026 01:26:10 -0700 (PDT)
X-Received: by 2002:a05:622a:549:b0:519:e020:6087 with SMTP id
 d75a77b69052e-52d73c66316mr39229851cf.11.1786609570450; 
 Thu, 13 Aug 2026 01:26:10 -0700 (PDT)
Received: from [192.168.69.208] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981e37525sm43435175e9.3.2026.08.13.01.26.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2026 01:26:07 -0700 (PDT)
Message-ID: <166a4988-a374-4d07-a747-9a5408e10c52@oss.qualcomm.com>
Date: Thu, 13 Aug 2026 10:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: fix build against nettle >= 4
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20260813074048.3624651-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260813074048.3624651-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfX9zH6FJBzIg/j
 4RI4lOAOYl+ZzYH60rF4P5jZyXYY7fPUCXxcavT+/qY2SrjOZcA2iAZWYalR//40BhNSoX2PpLO
 nlKZCELSRDHLgQ/at4dvCwiPM6a1b9g=
X-Authority-Analysis: v=2.4 cv=I45Vgtgg c=1 sm=1 tr=0 ts=6a7d7fa3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: t8ef6iBQPnWIu8xskCG1CIRSavlZzi3Y
X-Proofpoint-ORIG-GUID: t8ef6iBQPnWIu8xskCG1CIRSavlZzi3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1NyBTYWx0ZWRfX+EOTW3s/Xvk2
 PB/SWYMHVA8YeHYbbQDi3p1T6zIAJXNHZUSXw8DAJtnCfI1lB1qlErRWoNzLunbCZSX6dkVtAlL
 JWYweHpZdyWBrI9wkcZh8S2bifWT+x1Qa8YFOp8eDriwPsGj3qjGF2b7LAOoZEvu7WeYn7zOpqS
 Xc9rTVfJziu7Do6JhWFh/wp53dDkny2MDR4SiG/I9bOHGWiWoC2oiEvVjmM5SKjQ9T+f7jgCqVm
 2yRo+VPAWShG6QVsezLiCu7igdJlop+JnPuow7ku6lkYT2fWG4TTb08JeJY6p+yTRBQxZes6v6N
 zCP7L8s7/T25R434qqhpxnODLvyfUcpjS6hMihpBwZiGE2soWIdBfY5q8nZTF4/rBQu/qGKr1IZ
 NdKX8qUDxR7Zdpw+QOOfKA6fQVgjAZk/3ryBYZCHt/068pHqw6Lo4e02UpndDDgnLNfmoUGXMdI
 Xoil3ihCsF36h2BR6Og==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 13/8/26 09:40, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> sha.h has been deprecated. It seems we could just rely on sha1.h/sha2.h
> for older versions too, but I didn't check.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4184
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   crypto/hash-nettle.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


