Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6195C4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:53:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGWJ-0001WZ-2u; Tue, 21 Jul 2026 15:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWB-0001SE-JY
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:52:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGWA-0007cf-0k
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:52:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LHRQxB2446237
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:52:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X/sJyTzHvXSG2g9M/9NsbO5y3g2WVN2DQtcA9lMfCRU=; b=JTyrP70TE6zIVU9B
 JEfjHuHhV0gNoRXoZadoLhYnCpJ+dsDe/kLcaUFzOT1kUsKY0zFu66dYcz0jZ6Vo
 8GM9NZY3WAwF+OTFA1Dbddrvyk84dpWN1tBKhhRSfRvdLjsxDBePRnB8t+73tx6n
 usYhAsZpkr8ZO0PNeS4PNnq6xus7l2FN5rr6bGUdDxAJrtjxEMidhGhPNuxwxG/w
 Eo7W7vvmMpXxQK4clll2lQ5btAA5wqzOirlTGTwPFrqKdJZWeK1IMypeiAjWdIXS
 UJGaiMTm6mLReEUU1EiC3YyYqifHQNuqCYSNIYEl4ATWoQ5FThOgsYJfSHnoWUp1
 CH5+Eg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d0nbc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:52:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso38092561cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663560; x=1785268360; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/sJyTzHvXSG2g9M/9NsbO5y3g2WVN2DQtcA9lMfCRU=;
 b=V4KwVT4S6f+qdrBe6cHaFcy+7bQ+QVo1isYZmMdXd8syTbGThmuri8MDYfg4nxS/Fx
 8CuiZPRkuxCNwWuskdphro+ztjT1GOx69N4cNYuwhv44KuXM/zT8yM9aDIhK6aHDLRTo
 q3thS5awWlg920yB04FCeUAWPBTqpJTVPkqw3OSsNXnP7A7Vx7p/CSGpkiNiRSif/+mg
 Jre9jJhx2e60m07+3EHA/QOqZIjhEoq0uOcWS9OgZOS/v2jsWt8+ktuYyKWUelknM6QG
 GlFtfetcRYKfSkshrOsShN4G5ivapw0tt7zkdj1mSW20w4RKfmF7DC9sjTDG0ztHHBax
 6QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663560; x=1785268360;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/sJyTzHvXSG2g9M/9NsbO5y3g2WVN2DQtcA9lMfCRU=;
 b=c9jQ6jLWXO7vN6CMDs8A7CO0rU4DNVSPuwZhEopeOv0E7RMFLQ3asqGoZ2NwNqHchi
 1zpgII5hz1kZyXOMXutmcxPPs1kBBCz0xB+RjYkF7sUZvEmBJ20t7GC+jL9jekgr79St
 uNisRyvZwqEgV/Wno30m45Hp4uMP92JKvndE348hpgVePe+j6eGv0j1zg1T2TXclpL3G
 i14PVto6aCIIojrK0fkVW5celOTCyCcwRo1TioS4EXvMtdhv2lZ8bIkJnyuu2a+SRM0m
 QfJgQcsS+rDjHXdJy79ehmPuTcyg68sgvRbXSyVrmtm9x/uL20h21lQ6Yly39zS1/EyH
 VQUw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roa/XNtV9dyVlJCG8fsOXlikSxF3Igb4ZszHugDwmdq/iHilBhE0alMLQykPKMbVbJsNN8DAFfEhLrc@nongnu.org
X-Gm-Message-State: AOJu0Yy2cKYZXxl/Uf8u5kpA2+SN0NyQhGIdBAdbFpfClW+CZDy2ZZHJ
 dfmv0Q2lO+FgR9wlTQT1r/Zeh30FaDrOVSOoIs3OTsKQivi/Q9Kwmu/nsDiKBtRKAR17PENyoPi
 mZIjJEQSYpl5ibFkLM6Dkj/8kX//jdIz3zfu7eA9+mOgIMKK2zMj/YTIXhw==
X-Gm-Gg: AfdE7cnptvBdlIfdQplaa0R5trrhzlmPrFrvSAhTsFhd9AWhrOcFtpvUPnOy+6fc9I1
 SzXZ1wEeMmmA3FjS+5jRhM/v9F/RuvV+rv1FzThc44kNaayazlfEsRDE+QRiZneovZzuG4TI0l3
 nlHjH3A3laUcVhePF9mhZJ2Ziso0AfdrmUivNEoE7p79MhLGmd607ImGAnGAF58pbRgIBYNQSL1
 +CsLLYfjHyQCMk85iZvotAtRFx3mW9rlw1MwE500y1P7bjdAn/98WwdLf0CUvDe3RTY570ajnVb
 8WCytsGeLFMOVFjYNrkMLVBzNlKx/1RprnCI5HbrSPR9q/r0ZMKF8InLrvalkJM8p32mtXKLN1l
 sX6y4L44jKmVePZ/OAK5KLmq2iKfgy9YjRlhMXnNjvgF1ozT3QYM=
X-Received: by 2002:a05:622a:653:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-527a9cfdd3emr12724831cf.42.1784663560632; 
 Tue, 21 Jul 2026 12:52:40 -0700 (PDT)
X-Received: by 2002:a05:622a:653:b0:51e:aa39:4fc0 with SMTP id
 d75a77b69052e-527a9cfdd3emr12724331cf.42.1784663560183; 
 Tue, 21 Jul 2026 12:52:40 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed1911sm44379998f8f.22.2026.07.21.12.52.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:52:39 -0700 (PDT)
Message-ID: <f7e9f91f-6e88-44a6-a97d-3d56229c27bf@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:52:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 13/15] target/s390x: Use qdev_is_realized()
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
 <20260721-qdev-v3-13-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-13-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qbv0V-sAEb2GAEd8d5ClBgdyN63tNw_z
X-Proofpoint-ORIG-GUID: qbv0V-sAEb2GAEd8d5ClBgdyN63tNw_z
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a5fce09 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX8V3I7R9S09Ax
 9VHRHyiQ+6s6odGNp8B+84QGPbow+orI9nRpl6MrL5LJGvU0c+CqgH+eZS/WlyltmvOJ6dpx/44
 WSt+1c9plPUrteB9KFel0NbSSS0eQsIIFaVMorwTw4YJYzEpjbeygRF6GXgosjG1oZJhK2m6IJa
 OAkiYm4El2GYfm+AOdBd/FAYj5t3pOrgrAqcr2EfXasyxnZOwGQXRNI2nliD/bt60di98ISXbxH
 WLnaeAHmTot/QGE63pefw7i4qhVMWlNOYAuAraDs5E77BcNvy56vyVGLhCGBLHeIWhu4bdhh99/
 bNEhkq+qcNoIhDHPNOj6zZR6qqPxVL6N15egj6wuqVvTqeVJmFhtG+6taDyYOskANvxeQvMercA
 oXBcyZN53NCTBbmXj2jA4thClR3NGoLYn+CeFPCVdahC9ia0HS4tTUux/IcM/lMfbOC3uxfLtkP
 WAihH6cAFfybtkG971A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfXx4+d8fyoxRL+
 QuApgFa7Ex2mJxFIDHSnX2vQnSx2Nf1VNFQHhrTDUTDboyWui+ApRUKhiVHRNgUGJjxj5zasc92
 BnP2IKPPH8e0zbanH3zbIwN4a9w2SE8=
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

On 21/7/26 10:17, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   target/s390x/cpu_models.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

