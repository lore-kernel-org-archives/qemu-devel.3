Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712CDC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGa5-0006TU-Ra; Tue, 21 Jul 2026 15:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZz-0006Nq-Fw
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:56:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGZy-0000Vq-2D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:56:39 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRO6r2446214
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pCW827M1pBepVwCokHHS0doFxAT6Sk8stCKkY7NAS6o=; b=HICMm60fwsZX1dtK
 vMnQOEx3+KpW90Y0zD4MepnZmJIljvZo+r+btVOsN4M2nPsmNNPVOkoY3PAWGDGs
 3fto+609Ubn4EFLVt+bD0o591yE39sKzjFOJdm05KXkgHh5+nmuowNLc/p2kFpEW
 cwrsLiyy9uRlqyZxWRIj0Ptv7N/IG8ZyoyPcN0oaQ41H3U4xJiP2vhtLr7MhmuH3
 UNhpfHVvCiBKtOg5YtCsSB9DJjQgVJl5SENmQI/omvr0YcGdb7KQzcjLh77svqTw
 ogxUT1YfjC3eU7ArdV73Oa/uOgxnKTWduOtGM6i/ROs1txyA7eZAOWggoW/jTGnT
 CiTllg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d0nx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:56:36 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52769fc3f2eso11641281cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663796; x=1785268596; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pCW827M1pBepVwCokHHS0doFxAT6Sk8stCKkY7NAS6o=;
 b=AJ5EKXsq0q7tk9sldJdDA+LW8qBtbak8RTor2eI30Nk8wRHInru5/UpPV818lSVk6/
 zJ0WIyGPYaqCIq+5fuDKjhxYw5gBnoxva0QUGelvBe0o8f4bT1s/y8E48yBocvpjHwQ7
 MDJmqZHCZB1ACPy7n8rnRMHKcR78XBX1/n8Og/9Qx2oPmcnkkGfQfn1bPKztVkHTBN7s
 3rHISPqNGfyzMsjDr2SOTAOuLHCcnR/B1DWR9W1SSdiALgDLTJMpxlkshK0+xmsLtytv
 QoG72AlAp5ydAkXq11dchSqoO/gtMvKuOkqDyuxC2+pTnIXP7kvXhxN6JceWCgkM9Mho
 /ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663796; x=1785268596;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pCW827M1pBepVwCokHHS0doFxAT6Sk8stCKkY7NAS6o=;
 b=CVYVqXlZTOiiIVFphp09c5TkgIeOrO/mQdTGT/yNBGo5UzHbVtMpVWuva+MidAfP1R
 IrbAPLb0CO/t03ZOKyrx4euJjNO9lf9TBCqr3+MwOqDcOm+Bh7RKyZUQx8GlW7Tw9Ofp
 pmLZkc6jLOfJLg6MHBN+HlFaYpvuJaDSVlx7Tlixv+2T8SFBWaK+yxXoStsvyQ6Cv2xU
 whVCgFqTm7DfE40LqK6kNxBOT0rsWv4/WVeRxveiV5FYaInpfkMDI+xUdYoLGqJoqK5m
 ZwmuCzPqGIaXgeLmc4IUZh92m/1qJegKUqA0zPuCxPvvSpQ+IyrREjo2IyeVqXTQN0Z9
 L/zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRERbNnuxmkwwlEjb7dGrnEldtAcziaeHnKOU5xdm7km2Y7LNqaraX4B9q/eqF+AkMyrqY6MJA0DXa@nongnu.org
X-Gm-Message-State: AOJu0YyEQpOi7d/am59vYwUbn/QSrZ40tcJnDkq5bwY2w50Dpi4wPR0X
 hpEgEmo0zoRWMtffztOlYcmDB/wFIUByjdOb8kGRYouZcy/nfC1tNq0K0gFJrjL+1TO8UgjDjeS
 QLd4fwDc8l8wqrrrnUAqmBkF6jBZ7pT8XU+FRQitwbvxQBYVDaGuztoIeww==
X-Gm-Gg: AfdE7cmR+KBQ8GoAWsmQE5K0xJQbTPZnes7eHh2d/aDWc+EqPDuDrCidPv1yOVDsbqf
 anrA1vc4mEX+27D5kAYD2tdCiDJ3SrPtleYO0ywleA16y2e4OMTSXv3wxIq4BcgpjDs0in2OMVk
 GZrOrwu1NBotkbw2XHFcYaGtilAjczCy803gFfQAsmSTfUhs4nNzWuCiwsi1A6Q201zX2YIqf1d
 MUAuqtUTGPJP2zU5KA55Y8rSC17Lo9Qg6dQmRzN1RJ1NeeftQaBko2nEOhEaiz/0GKDc6V/4sTD
 tARDvtQz/XOgJ+ut9KzNKmfcAOvUdhJR+mOWdr1WqQSRMXXyn9h5XQ4TD3oupFaTA2sNyui1Zbi
 3pdX3UhWMoZkOVdPE84MEh7IVRxiNX9d2RaseSKsM1hAx/viKP0E=
X-Received: by 2002:a05:622a:614:b0:517:8e65:68ea with SMTP id
 d75a77b69052e-5213e28f73emr195286971cf.54.1784663796252; 
 Tue, 21 Jul 2026 12:56:36 -0700 (PDT)
X-Received: by 2002:a05:622a:614:b0:517:8e65:68ea with SMTP id
 d75a77b69052e-5213e28f73emr195286521cf.54.1784663795854; 
 Tue, 21 Jul 2026 12:56:35 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c6besm86632845e9.8.2026.07.21.12.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:56:35 -0700 (PDT)
Message-ID: <66e9c826-0b0b-40a2-a0e6-088e7d86e73e@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 03/15] hw/hyperv/balloon: Use
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
 <20260721-qdev-v3-3-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-3-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mOgzvCemXJe8oFeNxzpoLEV8FFzKw8DF
X-Proofpoint-ORIG-GUID: mOgzvCemXJe8oFeNxzpoLEV8FFzKw8DF
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5fcef4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX3ESqMp4aIAKt
 ZQsotDOin135gW3uC9VYMFWJqwPVLJqkT8LFu3/ESkwnvhpWEaojuCILQ20osnemQZ7uRzSHsSv
 kIyRMAbdrRYq/+YubnDAiELIpEQxYHIxaGDBMTMj23bwBGn5PXDsrABRYGxL2NJI6C0dTH6tv8I
 YqpMwP2wvkr+7TH0NCTNFyRVkgON81/gKqR5cZtL0dD2cJ/XkSAUoAE6fNG63YMLjYU8XiTpQxp
 4MV7XfpGbm3P4ZgWAnOTnNmF0CS3osf1oD8yo2sm2EKNBuuwllMzpDV43E3raSbj4Y0URu2jf0e
 Yp5Ene887s/AcA+eX45LYCHQ+6HkwNpd6azCCiOsvDY2tvD516Ty/RXUErZcVj3fSDeIX0HJT2f
 jBJvD6fjvAV3LQXuqsP2k7tWPCrB8orAXUHF4IyR+arkQuxLQmQsXs30IHE9vLpwnsBLX81VvNC
 37NhJg1tYgUqdClCciw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX8k3EutifBjOx
 sp/+qA53GepOissJQZiiKpqWREMXsOnn3fdAWAPjQLIm6v8OB9+6i+c1CrBH8ZNSDVIxVX3jTl1
 C/3h5weXSnz9oCRkkhMKLJp2wrvaxHM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210206
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
>   hw/hyperv/hv-balloon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

