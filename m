Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED45C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGZr-0006IB-Sp; Tue, 21 Jul 2026 15:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZg-00069E-Sc
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:56:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZd-0000Tk-W1
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:56:20 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH30UJ2281494
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 twFte/jQ197fxoVJSSNTAmxvPMhghW30uqtlcJWFFZ8=; b=j6zlmZHERWKy5zgy
 Qm/7Fkm0qzB1PuIv3YJNL5oy8vdMSnn4CNe80vIKFvj6TNstxbt1z4oABdxBwFei
 2oovOmroTgMQQdIwfJAOYMEbWxM9mBwS1q0kUcUyiTL+YhCnwYCFczROKmhaQbAq
 GII3fb4XkgfRHFmVl5wRu0gVHH2hTtgniDJeiuDY/X+vukS9+gxPcwKDLIUOeWGF
 pqYgZSIx+L/gqZ1rHB7JovenhUTygLj90iGR4FzgnFd09zn0uAUrXy156HX5eUA8
 PDgEWtxpyWA1J6tKmZW0jztVLmNDgyrOr+uVq0lm0L7QGPOmACTi4li22moh17Ty
 EMIPOw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6paarg3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:56:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so16911751cf.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663776; x=1785268576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=twFte/jQ197fxoVJSSNTAmxvPMhghW30uqtlcJWFFZ8=;
 b=Z6S2gz9U8DO68MO1nmtwpJfLdCdFny5KWXN/pYZjkTIuC64NIzskZdAu9WbElT3QyS
 C4P9Z24EpRESm6rkZk1ExJY14Yz4jD8Mqn+7FeYHKXOG7T/Hmo9+5SUdVueAg8OmCOAQ
 QBmh0fVjlDvpyHqBhn1JNg/xCZnfRTE5USoZd3uWfpwagfsI8BCUaeOf7phWQ6wTaw6W
 KrMnCTz3AQT0JOfi9BBRWGIx2fq1V/JbdcRez+ZJPh6XN07iu+Zg9va2MkXK/t6BIAXg
 0C4RwomCVVJC72DcjzyT9NK0wN60ofmo0YEdmPhWCcuAxDllOlt/dvjIsvXEDQXpD+cs
 uRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663776; x=1785268576;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=twFte/jQ197fxoVJSSNTAmxvPMhghW30uqtlcJWFFZ8=;
 b=Rzn6RVRWUPO/tiNPGzMsEYZvOI3Yc2HIFxwQq0Bl9Hpg1yvTFLDbFJLL7iBZZbAUKm
 oWJ+VSHS5FzOE7lGkEns+u7zVOUlwV/kz2s6+1eN4txxCOyRW6tU0+VoHViloFLHsKG6
 40h6JtptmikFDlDeF6KTCvRI1Jg781H0tVEcz1ByIiInAGHtrMC5TUyQZgCq2NQEBG0r
 RuBDVv9iXt5twRr2DdF4AZOo/uwcn6vfjVilox6XCa3AUvtNjYtEyetJzGBDjQ2mjdk2
 6BZhZ9FwIul9a8nUTdRbwhupjCRM1BokCkYlCQyIf/2MtohSn+dnANbCC/9biGiDPiiq
 NBmA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9ZjtYrPdXSuHN4416HFwCXbt5E1F4mZj3FkTbMrGMTBHMjp6kqWw9LNVQLhYq3pdfHk5rKD0gy/Iq@nongnu.org
X-Gm-Message-State: AOJu0YwbwOC8jYQJQUnK5eWld485uJnGt1soKE+oeYw1fj+VIxE/dH2y
 JkMXX65nVRG55O0mRucbSoK7v/vh+ov3evC5VPKC2Sx1dAM+02O3xiBjchxdltUiKiQpkzWY9ux
 g+ABdKioZl74wCBAyvZk+hfilq8R6Ca/O+m49rAWbuIOFnUH4UOROHvv1SQ==
X-Gm-Gg: AfdE7cnkMFx7XtgAy31WoFEyouDcNqWoe9WPAu5hV3SaxHJwFPUXcU7aCDXqrXtPS7S
 vRLVtEx8aFhMRdVUtLUf16ycZKVwKfHtfGYghWPXDd5utniJX8poEpOHlLBnvexR9N1JEzykd6h
 z2U6IH5hDEdRUL2kAbZU6rCUf0cFDnp505bgeD8DmyZ6W2MvPOYPou3pzLcwEfBoLG2awwCfVFj
 QPpymR/FvAvNZhm9VlyEmq5dwGZyrL/F7RVpmCIC9xJWKDHKg6eoY+mIMF6M2f6dkT9mRj3LMZ9
 6EEEEeQKAQ12TzKhEdxVRSDzMvF8Ep/n1UxyWVdxhKRGyREzDl9at2MIbnJNHoMe7b600UkrVqd
 3w3tmYkGMnDWjJFcdtLRPkGiOmAeYAcV3sAqypoinCgaPuFvJhbE=
X-Received: by 2002:a05:622a:4d44:b0:51c:7b11:41b5 with SMTP id
 d75a77b69052e-5213f374d31mr191429681cf.81.1784663775832; 
 Tue, 21 Jul 2026 12:56:15 -0700 (PDT)
X-Received: by 2002:a05:622a:4d44:b0:51c:7b11:41b5 with SMTP id
 d75a77b69052e-5213f374d31mr191429471cf.81.1784663775373; 
 Tue, 21 Jul 2026 12:56:15 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b00e512sm4397035e9.3.2026.07.21.12.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:56:14 -0700 (PDT)
Message-ID: <9745c136-8029-418b-9b24-bc2fce0c536f@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:56:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 05/15] hw/mem/memory-device: Use
 qdev_is_realized()
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
 <20260721-qdev-v3-5-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-5-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7PLuq61HIaq5QhiedImAJRQ8_8kdXRkK
X-Proofpoint-ORIG-GUID: 7PLuq61HIaq5QhiedImAJRQ8_8kdXRkK
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5fcee0 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX4x9TD3WonP5a
 9zMqZvfbubalqEhFevl+La5KCGK7guaZ8qF7pz+Ftzlqfj+LExs6qdlzSKIJyWLAdetABDDFE2o
 jTBiAKMURF2dGq+aQiUMiz6oihQ11esBP8o3Vekjr33g45ZzuJm0rQ6aL0YGe1cPs+PkFEFUpsg
 Gjg2xSnOcUyf9ueMarwmCXubCna2LuEN4+p1Ho9fqqopHc/ZCiK+kE4L3cHmEV8nUftk2zN6uMo
 EGurGPM0qQVT0JBUcaNTYFdmLU26ylbmsQFgCEJFqHU5jmArmfhhhFNvRP7AmQXL+tUJs267X9M
 bSYDd0FdUZ2vfz0QZ2bekFJl4NTJTMFgTRxz6RA7a+Cb56gD5WmI6d/TycmjaJHSASgp64nno0X
 II7igZwe7O7wYu8v0UZBaVvDe/+Ww7ZX1/XZxtvBMfq80scs7dowocUxQ5TXttzPd+OMAsxarTm
 FTlbdq+irOhE0hH373A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX0EyHW/5dZ/vD
 TP6wNiEnJFsSf5hJu3HZVTJHJ6Myhju2To6BzvQ9DDDUroOgilpUUECNqZPaqiAs00aGTRmbTmk
 s8stCQO6U5dr2yoORqqdDqGI6BlyZsA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210206
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
>   hw/mem/memory-device.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

