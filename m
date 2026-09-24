Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243CDC9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:13:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9fVD-0002vT-9v; Thu, 24 Sep 2026 05:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9fVB-0002ux-2J
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:12:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x9fV9-0001MY-3V
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 05:12:24 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5eNL41532419
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 09:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kzV++CRtAZ9jkQo6PLESBvDy8sbzPeMn2k3MEQH7sCk=; b=fbf5UCNSWDXxSi2l
 260KjthnJQAHWYj01UHhlhvL89PDRL1IfEuMzGkUwqC9t9LokQKTH9R2kl+Rp4eg
 1UEFPxsXW5tnGipBLfFM30R+MP8wgDQesPVp/Z1X3JPx+b6kLbSCj1AoPgWJMd7d
 K8U3CD74c6MBUtZeWaKWjd7xTmc6vuknFVVEnhrkwOfZBeoJ8AblwPKCRD+MaHuG
 YZ6c431IlN158ZLBWDiS/7pMYdNx5kMOWX+vnIKFSX2He7+7aLmsE68MCBVQmFhe
 k5T8OUVkRGj2DV3aP5Gu5NG64Yc8pgnvB8OjzLaKfk7cYAVwI5aZ4d9tNT5ZDLY3
 +lGpHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvsfgsnd1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 09:12:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936708f129aso287735185a.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 02:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790241140; x=1790845940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kzV++CRtAZ9jkQo6PLESBvDy8sbzPeMn2k3MEQH7sCk=;
 b=KPzIEijuX734ceA4jaAqMrUHHATXKFp62/r2JYarVueKZKnHfi1qV1ZPdEuC+TRHo0
 XdIRffc+4p3NzRkAusHKR38SPyOpM9peHv/bWmzaIMX5tdw2Xug2kKxAVWQGppf45xVa
 4HmssviG4OSqrZKVGu0uQAL4ALmWOlJ/rFKI4/KC2IBbCdXo7QBK7qFu3GsbTeRWs2q2
 DovMhClF8aZIiwQI6ZKs9L3fE9PxFX7GvkoEI1FTrFHoIPI06Ls12TQw7t3UANq6f7TF
 TWW8Qo8ppLzqeDALLi7VH8haEDJt3tDsG7MDSx4UcHl/YYRDIetKGnRTDzHroBFbt/BQ
 mBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790241140; x=1790845940;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kzV++CRtAZ9jkQo6PLESBvDy8sbzPeMn2k3MEQH7sCk=;
 b=0ISqVc6MdrvPiuvbXQarrTjh14PKHLJcVJadf1au5ehiM2y3aKhDbatBLlHEf+aJcC
 rJSC8bh0mfwnF6AYVY6HMiQ/zcuYYSl6DJZh6AYOr03qEDn/v6xdn7bQvFdRA0y/QoYK
 RNoBsqGYJDjiChB2TcHoJu1mse7oMrx5k2TqK95fKCd1KWWWCuWgh7/Kx8vTJsLnIwiD
 Aw1P/haq/MWUNBetxJg3mIAqmTaGlNMUPwOg6ijvOjMih2qK6j4smt3hwA6cadfuhDcw
 wxz5zbmm7JDW/tVWRCnyA+DOWQHL5CBvg4SpHvjpvyWRFpgnfOr/Dc58F8+7a4NbNZg3
 tiWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwUigzIFMWEds4GetgC+rUWgWyWvkx4mGK65eg0PFGtekFpQh9ZLwg4JeP1M8UjMJI24/5XotdTD1L@nongnu.org
X-Gm-Message-State: AFuF++kkKmspVfVbVT8NP/nL8UiWB28L2pj5isoTGsGbbbbk/W9SE4r1
 ndUXe9lwLLPweKQTOcZ5aGyknC1acLv6ao3ZQyndiQayjZLsa+3H2qTTVIi/VuTkudqBqfZjPK8
 RZ98/IQKETP8LX+bv/aUlWXN8PBu/faXg7vlL22ZD/krjObfg10Hl3TsRPg==
X-Gm-Gg: AYBFou3jw/PjuCVA9V3SmkCKrFrgRCss4lF8vw2Pp1FFf24o3+5LGZ5e9YtLzE0Pm2Q
 2ua5xSPVtPrZ7noxDXSA/iSCkOpZPYUGlSMO5gjD7WWj2G0E9fD41GI7YayQ+/L0uJVM15bcIIS
 8SumoZTgMtT1vuyLuNPRdQKySyeRN2y446f03220uIFpFZV24IN4Rc5QiThWDnLUosht9dUiSIC
 g/Af6zOpGA64/jAgQbGrAE9czxfTjg5RSlKz3moBRSdx+H+yD6d9kXF5Ks8XE+dSrfG+lheUBZm
 4TGKJUQ/UrCZYNL6W4AHwJqEU2EL4nRwJbl5WoBh7atDKLZV4a4MrHYHYfujHME3IZOrkblXpjC
 Af7Uz3Dk0Zv05TepaCvWswDRgStIRcp3Qsw==
X-Received: by 2002:a05:620a:29d2:b0:939:fc74:b6af with SMTP id
 af79cd13be357-93c362b4a71mr190217485a.11.1790241139747; 
 Thu, 24 Sep 2026 02:12:19 -0700 (PDT)
X-Received: by 2002:a05:620a:29d2:b0:939:fc74:b6af with SMTP id
 af79cd13be357-93c362b4a71mr190215885a.11.1790241139265; 
 Thu, 24 Sep 2026 02:12:19 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-488682676c7sm12514938f8f.3.2026.09.24.02.12.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 02:12:18 -0700 (PDT)
Message-ID: <563a8d0b-02a3-49f0-a349-557a4e29fb32@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 11:12:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/7] hw/usb/hcd-xhci: Limit DMA transfers to plain memory
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260924090558.801845-1-thuth@redhat.com>
 <20260924090558.801845-3-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260924090558.801845-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=YfoodARf c=1 sm=1 tr=0 ts=6ab4e974 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=bf1h9C0hqdaEUqCFuNcA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: cIOl76sD-4TON22qcMIValOn_E3c6GEg
X-Proofpoint-GUID: cIOl76sD-4TON22qcMIValOn_E3c6GEg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfXxlUKO11Awb3n
 KPuMsSuC5jTPL0mjeu8/f/PKhbZC4haeSYu7ojPVueWeDOpmSL4Rmnfxe657k6+0v02dyDWqCqv
 J2GrYX5Ka1R9tfPjTZm/UKenb2YwclA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzOCBTYWx0ZWRfX1ziBLqpMNgmV
 Qrlh+eGIWimrSgixMTWWXlngSLXNjcvqouCIANAAVN7RU9QqxjN0Lg4h9kuHyy8Zj1EtM/1/DlU
 4qKjJEgxuVCSJdWapl1l25XOhR9h2I8/jCtiY1FsLrmu3hqGIjTKg3DmXqlV1L7BhjUx58RrfIe
 8GRYDY4PfoKDhUTPJ+ipwv5VHtQ9/gJt3nylOD76xXl9UWcManZUsuN82q4dxxDMbbiBoRqvk/v
 wz5YlpDjA5V/Q5FZ3kx21lrDcQSr+2WbaPQ0tpx2Q9amBg6ZNFgOBrqUELSxcZVqiqR9In+S4mt
 +6+4SC3AWgP3njUu7obwIPMRPsNQBHt1eGtTg3k3u8axb+E5xmwYlb3V60Abv8814VXX1pkOxEb
 TKTAvypo7rzdemc/VucSt3RcV+7oDhOxWVy0yMFzt0bCU1w4lSwx0sUiBU8Lh3ZcsKWK8SiOLfe
 1SwPgMja56oOnVOOdEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240038
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

On 24/9/26 11:05, Thomas Huth wrote:
> XHCI is a complex controller, involving lots of descriptors that
> are written and read via DMA transfers. As some recent bugs like
> https://gitlab.com/qemu-project/qemu/-/work_items/3926 revealed,
> this can sometimes be exploited from the guest side to crash or
> stall QEMU.
> 
> The code currently does DMA writes with the MEMTXATTRS_UNSPECIFIED
> attribute, i.e. the controller is allowed to write to other MMIO
> regions, too. However, in normal operation, this should not be
> necessary, all descriptors should reside in normal memory. So let's
> decrease the attack surface a little bit and limit the DMA writes
> to normal memory here.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Message-ID: <20260915123242.549150-1-thuth@redhat.com>

I had this tagged to review but low priority since RFC, anyhow LGTM.

> ---
>   hw/usb/hcd-xhci.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

