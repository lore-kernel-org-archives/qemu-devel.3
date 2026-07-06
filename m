Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A2C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 07:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgdJH-0007lF-3L; Mon, 06 Jul 2026 03:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdJ9-0007jH-KC
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:59:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgdJ6-0002Bo-H8
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 02:59:58 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66641WBD3402248
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 06:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mu47gYgYQiRI45K6wXQlr0qL01aom3LjsiBm5tFl8bs=; b=I5DaQbAGWhiSLOrU
 HyXWrBPloZAhg3wpqFQy2hysqpjIzEWHzseOXy+qaExxdmJQF2MfpZnd6dshsWfV
 qqrlzqXtnOn39SHaFdDwDLlPG0PTWsRjaNtjFPcjcw9on0oM7nORvYtgtF3SImtJ
 lECEthPv1W6GZp4pqqDsBJJT9D+epIar/vA2IdPcxJpxhVs0z53sJXKBk7Dv53SG
 5p0GP1+PGEx36RwR2G2omg0H29or0IlFktFo+2dSO8HH4HeLanjbrEbSjraH8aZe
 6/KWV4Dh0ekz4w1eEeXwWD+7jKkq3OV2F2tg+e/Gpu0RpvhprAZQw8RJRsfJSdAi
 rmo8ow==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgms3s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:59:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e6a2f5995so453053685a.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 23:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783321194; x=1783925994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mu47gYgYQiRI45K6wXQlr0qL01aom3LjsiBm5tFl8bs=;
 b=W4hZCR5pRZjYPKpzSnLBp82bGMSXZfnbo8s2fmttK3Ax7Rp8yQSdUIMrkAweViwlum
 uoVpuul/1ty05VIg2abpEl1FTnrmjGRSyOM4uRyn/g4+g35Hoa8Of6JBf54GV1xMFoBa
 VeFofLA6kvaoOgJtGkjoWo1Lcwi2sJGQdUa51F06zH5Q0V1vOqL9rGoc5FIKzGvJ1R6d
 xVBJ2Nerhs2/ka9VrK4/4hkSIkPJNzToD6EXRHB7lKXP685Y6AqKkdtNAiliOI3w2oLw
 thtrmFWSXZLduXQ9Ta3h3HfTV6SmXWJ4v7RiyF1QmL81vLGQH+EG/nInTT4IAnrhW/To
 z5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783321194; x=1783925994;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mu47gYgYQiRI45K6wXQlr0qL01aom3LjsiBm5tFl8bs=;
 b=QCb5vgJmLPCGr8h3sKIXFJBezyOv4K0wtQwDu6Ey5Ba1ECjKMaLS+MQGBAQjJr+5uh
 xR7DNi7wa61icc+0cv+RPSkfKB+/EnSKqo+gQZFQegQL8jQz+FqlOzSxECDPWKlijFzC
 99bPf5dCtEYRq0egS/nVADBRtk9sNe58rGPqNN2MJJixP664jcuX05hQUlXPDqH/BeKE
 /3p4Ypw0tBrLocwjoe6H1q4b131dScLZP1PNzkJVdCLVa8FNbZ+P8bj+vD5S2EH1MMTc
 xKV2VsPm8eH6o+H+lywz1KcBbs90ZyRwV6VBQEu8vcM8tD1S1Z1WsHaeYpug4cSS/hqG
 72lQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLgZkdczAN2OS7bMKBQxcbNomZh03AIXh71z2EKbgXhyAh3CNngehbhUOQvUe+ahVC+djILu2/AslD@nongnu.org
X-Gm-Message-State: AOJu0YzSnGBefzD5qR6Lur6KLYVeFJ5qOaNiGcbExWeahaSmPS1kDfyn
 y609QlJFVRQn7yu+m6zh9mT0cgYXP1wswwytIY1mA0DJGaMr5idAq8Q4ejh6VSvIk8wAEB9Ojft
 m9XAuEzLY85pgPik+Clbqulo45G524xeg+nn1grZIl7alZ7lg38Y1wtUlcA==
X-Gm-Gg: AfdE7cn4RWSLl2VT2bixTquT70pNI2QXuxBWKescf5OmKOiwBBdqlt/sUxmHfTSZE8z
 e7AwYWBAOoWyMoUWtAgITeSnq7dxuYfhhQo6APv+2vobqhgd8RWcShtJmUZg3aeBmy8J8P+ywCm
 DMFLdpYuemc1ZaozA36M2eXVceR2ufvCfFoFcN4sDxBwFDK7PXutZF1/grziTc1Z8lvSylwb9Kr
 3hqXMMK5Qxuc5cJ3+M1gWluvCoq27BcsDqNkN37IO3d/ffmoDofFXJx/SPSFGCI8qYZlSlCJ24B
 YlQmPHNoWJ9JGNcIl2/aUVOQDklbAdvrz/sD8KPX4NbRDwgyaNoc7Q9SkTS6BQ6Li/LHor8WmSR
 ru8241Zf8rcCCPb7PPoPw5T+O9tsjruMrpTX02PO0hpJPj78xubSht+km4mO0rQ==
X-Received: by 2002:a05:620a:4407:b0:923:8612:f15 with SMTP id
 af79cd13be357-92e9a3a4f82mr1152131885a.18.1783321193925; 
 Sun, 05 Jul 2026 23:59:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4407:b0:923:8612:f15 with SMTP id
 af79cd13be357-92e9a3a4f82mr1152130085a.18.1783321193512; 
 Sun, 05 Jul 2026 23:59:53 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce0a7cfsm258601735e9.9.2026.07.05.23.59.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 23:59:52 -0700 (PDT)
Message-ID: <5ab4ace8-4f2f-4674-8048-5db37cf551d3@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 08:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] hw/adc/npcm7xx_adc.c: convert NPCM7XX_ADC object
 props to class props
Content-Language: en-US
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, kfting@nuvoton.com,
 wuhaotsh@google.com, alistair@alistair23.me, peter.maydell@linaro.org,
 berrange@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20260703143408.3235231-1-mark.caveayland@nutanix.com>
 <20260703143408.3235231-2-mark.caveayland@nutanix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260703143408.3235231-2-mark.caveayland@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA2OCBTYWx0ZWRfXx+kWjMWFQY47
 4BX5F9Kr6OOtJ80dr3MjFBZutrTanecqlJZya596AFQC+W3akRS2biBGf8LgKy9XGeyubIt+z2M
 7ORH+uxd1E3smb2JIBOBk8Q0OpFnGc0=
X-Proofpoint-ORIG-GUID: ymtaZ4iqxmeR7-uNOfG5S4p9AUnJ-sAJ
X-Proofpoint-GUID: ymtaZ4iqxmeR7-uNOfG5S4p9AUnJ-sAJ
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4b526a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=AqYkckc_seYA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA2OCBTYWx0ZWRfX02H7DCGIfOxy
 mGqBy2VF4wTporYkyVlDCJAWvKOGBPrQjVJS6CSWRGWEYEF6IEmcT4Q1Untrz92Va+6qGmw3uV1
 TAJGthgPkOmdjGPuUPepApSaWBaMzZBrsZ7mPKj9kJWPHZ0cHiOzZ34WXEZAj1qKRQyRH9YYbbE
 yxkZm7pVjesk6h2whjxB8pVAe9jryf7yq9ANes3RHb2HpChlmmej+WSY8zUCj3je5HF1xjlPEm1
 LI8kBjefU+9Cv0Qaq0mdm+3yZA3wAa41PKUd9AmPtO2cL0A1v25S2wdOjmfnzwhKLBWBD2BTXS/
 PK28D+M1ffEVG+GfS2fTYXaZhZz4MlI5PaKqjYLu4UyMjcb0ESnFb41QzztOJ44ZCbBgewmOSu4
 DCZ7tZaibbSMQHa6ar/PeNMaqZLikxRG3Cght1bYvbaJQatX1lj2N5DNj08zv01q+2BzL59+lyy
 pSKY2eVjpNvMvZ3xaHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060068
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

On 3/7/26 16:32, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>   hw/adc/npcm7xx_adc.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

