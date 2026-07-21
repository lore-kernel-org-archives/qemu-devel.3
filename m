Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A217C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGX1-00032d-Ju; Tue, 21 Jul 2026 15:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWz-0002rO-37
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWx-0007iZ-Jy
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:53:32 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRLk32494433
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yfc2fNmwnLyuMgvh+jSCxsduIPaduLSEBZx/AI2Wwws=; b=RPqXcRagssiPSDcR
 R/LW8ylTJTNc+U2UNLEN186dBmRUCfeGEN3wMnokclnIzggF9Yw6pQnYUePrt+BB
 9dyoqKFat2ti2Pa34SjqFm8ZXjuCQ38d1nFrZk8z/LI4QATrC7MsNkE7AUCuVW7P
 mWNrfTtUknPDIDcfL3DG0yiPRINbO+Gu/igq7wLPR9QJhbi+LeJWeLyKEufQWycU
 7GPPv4Zoyvs41QFYNyayaAJK1Z34GERqH5570jci8P/xrN+pLViI4aMHNXoWhcNc
 78gtlm+bjVn14ffif1ksIovwGiZUrDcUcsWa6Cfny41QItSTdDCuX+MllTKgH5rH
 ktmP7Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d8nn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:53:30 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5174a23afcbso104543581cf.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663610; x=1785268410; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=yfc2fNmwnLyuMgvh+jSCxsduIPaduLSEBZx/AI2Wwws=;
 b=LSmniZ5N1iKMpdcNpj+N7YDeRCn6XdJ+rx1eKTZ8jX89S/XGfRrHUDKu8LoAZ02UY7
 RrFX9zZglmOpOSz08z/wgyHrH4va+yZsGmJBm5ISKawUhUrV/jGXXO1ZxMrgm627JLOT
 I1/Ft3Gb2xG4s1xZz7pEC5eEk1OVZuF9CjKn4TvzosdyYRXuCQGq4bKHwyQdrmH++QqF
 K/lfDcRxZ9qiuFno50A0Sku++Fs5Zu71RpB9k26+u61YWMdN9U0yh8Eqm5FL3cEutBPg
 7IE2HLnZgo1BJpwj0h2PODtPXooBYgMxt0lP/7K2s2WhKPfTYdGGQAE90bs2Fmv3FRO0
 GQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663610; x=1785268410;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yfc2fNmwnLyuMgvh+jSCxsduIPaduLSEBZx/AI2Wwws=;
 b=LXXwh0pmpluk8Vpx+a/BA8mdecGT+bCVruF7lIxtee2vPe1EgK1bHQgP+nk8lYfCbl
 PF4CgZF4LUTznOICwAEsWzoeeK5enx9uABARXQmRoU6VsPo7HBUBhfW+tR9xlAXaWAbd
 NylikKbBS+ooWrkB3+8QS3OXzCtBsODU7HbMhfETsqTneyTBac+grXHFz74iSG7VvenT
 SEVWq/RrVW/Es6cweciJQgzRq7LladzzaHjByCGbTCH9pFNVe2vu+zaCLrPm+Er3HGvi
 aGzAwTFwDb82vNKO3tPXQuvjtfIUBY+1+3QHLAcBqkbBy/NvW+qPb4P1t+LbcVyUpP87
 iY/Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr7YKs9I+IEWMX7EOK159YP0KZft2p4neHeKcdKqQuOBvSb8zuWTgfCkjsZsa2VEi8M9OO5UE3vbZoc@nongnu.org
X-Gm-Message-State: AOJu0YyAg98tTlV07Rf3N/JuhcnRW0wGki0VyS29o1Pnn9w0vpcXyO7u
 4Tzgq946BNnOI3CxAicTXxp5EbQKT4WZM6DHpyIbG71Ox4Y4B/SoIDKW2DrphIS9IZ2+gEhrM0w
 MCi0LdMTLZ3W8qFRHRW10OL6E0iivKh2Cuj576XGAYJne+qbWZ8TRQzG7/w==
X-Gm-Gg: AfdE7clp6yJ7I4eAXJWjhHI6hojSHVThA8k/sfOgXvQO8+gpy2lf38gxM64DE0nmy2S
 VlUbAURPKuwk1p5htp65R5EwkKVE3SwEr3FNNGIw/tNOvCJ6tx8mv5igrLZA15vRoaWXuBtIp7u
 X1M0H5v8YalDCwoB1bnNaDZ+78h2m8FTFw58XdOoYAIufE3wVPZ7gcnoJaNaay6tsd/0cmgepxb
 2WjkPpBOYsJvjcat2pWZbxfxFeDr2CWJCFf7zS8UjkYwKHzdRcC9IFbRKKVCn8MkPLAVn+hqm3N
 Wi0yL5ofzz5sivH29rKSv0dqJahk3GqAVrXBwseF2t2ExPqDdl4vnp2LOj3NImIndhypKsaQrmQ
 r+dTsdk9FChQyP1HsPCsyn8M0/J0IGtitWDddxvyKQmDczznts3M=
X-Received: by 2002:a05:622a:4d9a:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-5213c10a2a2mr186186911cf.14.1784663609966; 
 Tue, 21 Jul 2026 12:53:29 -0700 (PDT)
X-Received: by 2002:a05:622a:4d9a:b0:516:cee1:4727 with SMTP id
 d75a77b69052e-5213c10a2a2mr186186661cf.14.1784663609559; 
 Tue, 21 Jul 2026 12:53:29 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f67466e09sm45575497f8f.21.2026.07.21.12.53.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:53:28 -0700 (PDT)
Message-ID: <cdee20b5-43b3-4373-9c0a-89eda4148164@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:53:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 08/15] hw/ppc/pnv_xscom: Use qdev_is_realized()
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
 <20260721-qdev-v3-8-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-8-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX2CkD+cVL5t/C
 mVERjfwI2TR05ULgHLNm2AbjrKWvCUrEwW+ylFI4B8FT0QgIpnWputllwX+7dRpxC0qhxh0ikGb
 3XTrqQfYXmdTdYdBsx+hAfwIHt8o8Lw=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a5fce3a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfXw0GP7/wUp6DW
 foD4Tsj/eBWBOdEIKRGzYy1nsO+6icPn42TrCYBJij1gJet5qne0cXI0bw6rpoi19Zim9Rt1+A9
 1gkILj1yIGzV3xnfx4IKpyqFMpc/eqYKwwmHMoPVccm+jbkRYDmkuqsZnfv8QlcwpfSfA/8r8Fn
 G/59Cl0jathToDNWwQIdF5A00XNAFzRLeuh2qR4EJzH66qRgwZDet4S23iAwPXMNUT27pfze83V
 YO/xsba8bDynpkGlmJGAY+h9JlpR9uYOYjQsLCnB+LDOsBjtz855PYunDoB7jlUvQiZk5cVChnZ
 ekaC4PLgaI+IaxXQgLtLLxjbSLkWzlvRaE7VjCf9HvWY68iD72eaKttuW9b3a5KevxI0h2yPCZs
 51P0gLmXgdYYawlFuuwbQjjrxltjJW7mrzN7szNpw9BIi5FQaSfoSI0UrH13rD7UGFCNrt8FWF3
 zB88b35sITw+N+DwgNA==
X-Proofpoint-GUID: pTJlbiQVdATBMGdfhZMyXHCH_m0wysZt
X-Proofpoint-ORIG-GUID: pTJlbiQVdATBMGdfhZMyXHCH_m0wysZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
>   hw/ppc/pnv_xscom.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

