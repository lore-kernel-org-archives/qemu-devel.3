Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8A3C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7MI-0003wh-Eh; Tue, 07 Jul 2026 11:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7MG-0003uA-Tc
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:05:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7ME-0005bC-7m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:05:12 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8hoM3755535
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HFcVRf0yjTAxT3Cfg1PbZSrpP4Ua6zo1dea7MaUwGps=; b=OJ4B0qwIXSypcWjo
 fXamLpJigETXLFpMLSXFdCflTYjmpolvQAwx/KFaNG6Ph4OGikENIEU9Jeq/vvN/
 VS6XD/28qdNPgbBc6pwzjPLQf6ic4Fl+UVa01RV9+FXPogGnfK3I2o5hXvfZSXL1
 5P4l5RTBy84fJ4xGOyoVX0ob6kAEOIhGxwxtmy1zz+Xjl5LItdCpVveySj6GI5Zr
 PaHzlwy95Hl0ZguwMZCt4Mvmwr+Jlxbxl9lA/fA0DhlORESs2ONg1w9pO7bn/aIK
 JbaCC4y0OhDXADqdhOcRTsJWF4uA49BlbxZ4c9O1EHmQg36jckIfvV+ri2xIqbod
 UP1NEw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep1s76-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:05:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-969289fca9dso854242241.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783436707; x=1784041507; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFcVRf0yjTAxT3Cfg1PbZSrpP4Ua6zo1dea7MaUwGps=;
 b=gwE8ZBIl0PL2OCYgP7i1z69OIwxSXmA6dc0u9E3c0PAt6rz9phN0smvo4iG8ZyHfwZ
 m+5HBL7stG70qNm0LyhIABkjkvh0qgrfXzNpRTscQA+kUTWNgtyJ8IfqNyR8lNBdKn8E
 w6lJ7K2Jg+7kgbVjuzqDRE7EVjPXg2FyjqI6OPH71F4f17v66m5O/jvp/A5exr+1lgzh
 ulqPCmESXAsEnsPhRTDGAh6jjSfURBwUht7UUC5ohKr8nqlLEkKbfqLf8VSwz0zxESh5
 atDkwtH+hfSJUPsETbw+WCFQ1Ne5MgAiwL1m+YJYk8rJGiQ43bOX47+m/e76+C5jfVV4
 kApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783436707; x=1784041507;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HFcVRf0yjTAxT3Cfg1PbZSrpP4Ua6zo1dea7MaUwGps=;
 b=Uq0aRIv2sSq8updTvGxiCnG2d/3PKgrXoK6U0t9NB2kCLUlvRlqjc2RA4IhvUkgMCc
 MH/U2i1d2Ss4jRR82SMoun5h00LDeJlVLPIIVN1cLWm8urJoiK8Sp0PabEusmflLsXiq
 Fi84LRO1jYDgcpRCg4RP93m6jXIIhh/vCGn+dZnn1Y8DpIquEqNqf74IUf3rUnuKB7RZ
 LjSASTUVP9JWpWiyyenm8laRy1pvCOzRSwN7Y74+weZjr40AjNJLiO2MoOB4ZWrtpJ6q
 yQGU6qzL2ohBXEw68KlNxY1vcz6NLttA1t22HdxvbVWYSO/p4yHJXJeDH/jywjpMqy09
 Q6cg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYe3kFAIVgnwMFRAMqKHBpTV9O4VAb4c+eCna5cMbg10ZRmWmvmDLDPWlnzSdNqM+fe9S6ewj7TvLx@nongnu.org
X-Gm-Message-State: AOJu0Yy1TGthClVqbW+DUu1PzsGpn9L2WPOwU9Zg+mql2kNq7gfZNvxn
 /p9xAEW6isCt7uG/CFxAq1ELFYrxPOaiSKnIfMZnFouKSa6/XYn/uSDPgdSlqOtndbHdPyR33eX
 UGkWyJ1OEMQV4n/qmjmAWSfRdjMtvbW+UOSKRDZT1HrXXKrmwGgKPEAsj4A==
X-Gm-Gg: AfdE7cn2hwgHVxTRf1h3rYV3oVT1qmF8JmluOWJdkM0xHRrRZO9TXIgfUkewBp7yI/4
 Nk0SOaXG6XrvaLb+ggWZD+NfhmlFNi29MgenWO5fWtbi87TRgJxCCwgvDgg6PrM5Uy8oBz0xMxW
 Y+x0LCkTmn4Nw5KRCGu03MSl0WUsH2xP2a4An3WXG/eoinsf4A47WvLlMD6Kr40M6XuERek8HN1
 FQmke9N4+YgBVRb7jvluA6KYqkVhlB1/7vEiG8x0u/2R+nGmwxJuNvbx94uO8D6JZOdqkc3Kbjb
 8VmiKfBZoImQzgBN5gW/ZUzj2Y4gSNojdJArpIXcdamwwW7IqPoXB7+yHCvFimppeLBcx6E8eSO
 FBHdSMbA3/A7n0UTPdm89KEMkWUrC6rbMDtkZQ8FZWSsOXRAW1mMn7i6aprh+MA==
X-Received: by 2002:a05:6102:560f:b0:6f0:6293:747d with SMTP id
 ada2fe7eead31-744b7c38ec7mr2758738137.14.1783436706834; 
 Tue, 07 Jul 2026 08:05:06 -0700 (PDT)
X-Received: by 2002:a05:6102:560f:b0:6f0:6293:747d with SMTP id
 ada2fe7eead31-744b7c38ec7mr2758702137.14.1783436706299; 
 Tue, 07 Jul 2026 08:05:06 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0fbb410sm64893915e9.12.2026.07.07.08.05.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 08:05:05 -0700 (PDT)
Message-ID: <1d546694-ce67-4c6b-b68a-578e4982636d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 17:05:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] hw/block: m25p80: Fix dummy byte handling for
 Spansion flash
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair@alistair23.me>, Hanna Reitz
 <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20260707083431.219671-1-bin.meng@processmission.com>
 <20260707083431.219671-5-bin.meng@processmission.com>
 <92dd132e-e4d5-43f9-a207-c59697c87204@oss.qualcomm.com>
 <1e79dc11-0df2-47ac-a1c5-819398303e48@redhat.com>
 <a13c292e-fa89-4953-9893-d09629ac9872@redhat.com>
 <20d58663-a8d1-41ff-9348-cae4982c30f0@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20d58663-a8d1-41ff-9348-cae4982c30f0@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bzZqpzXMW5oTJwO-logPbX2LOVC8ZYW5
X-Proofpoint-ORIG-GUID: bzZqpzXMW5oTJwO-logPbX2LOVC8ZYW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0NyBTYWx0ZWRfX8e+WPthugeg2
 HzIynJACqG+MYoGHBAf1laBlyVmGnfvA3tR+VsnkuqFgjCBHQw7viFJtMGfXdcyGIOJTy2u84zJ
 KxHV4ardWRYqevUUIPgF8eb9B0SFfPOfJk12N5DaQTImG0TxTbbJtQum0ivZwRXVpD61wB2VMQt
 0cx9cVEPDTmBP9o5ZyeAqmyTPmyGABI1piv2emogl1M0OzU83WA0zShBO/a5hRA34dfge/D6cHr
 meKcICVD/rxQzshKfzptFqP/MMomOoyQb3jWqbOKb8rzr0osDQhMzdxMUzuxcjmCbmRsqAmswTc
 xG++M9/lJA93c+1FeaJpEiYuUNc2P6+IbFnNPrhxThvbE6amnxGAo03jCZ23kwGAeDKdvPDAswx
 jnzUqrD6QUoEg5ODvmwf0uJ5BRn3RUOw0Y4Nmi9pcY1WYcdolXhYe1awIYcjZEUi+1HGTBWnukW
 hKm3vdzWmsylKr3arEw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0NyBTYWx0ZWRfX7tKmjQb9TIec
 v1dnIdhv5FzRQ6v+FzumHVNnVF+YebuMh5FmfKL13ircqddHd4ByWyllaNszaZudhn76e9lQLG2
 jKpJF/2MR6yMiQ0IWDxn429hTY6xlwA=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d15a4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070147
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

On 7/7/26 16:26, CÃ©dric Le Goater wrote:

>  From 17ae23e5bc3629a5a301f14f47125f6f685ca9d9 Mon Sep 17 00:00:00 2001
> From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
> Date: Tue, 7 Jul 2026 16:23:29 +0200
> Subject: [PATCH] hw/arm/msf2-som: Fix spansion-cr2nv value for S25FL128S
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The emcraft-sf2 board set spansion-cr2nv to 1, which the old m25p80
> code treated as a byte count. With the dummy cycle to byte conversion
> fix, CR2V=1 at SPI x1 is 1 bit, not byte-aligned, and triggers an
> assertion. Use the S25FL128S default of 0x8 (8 cycles = 1 byte at
> SPI x1), preserving the same runtime behavior.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/arm/msf2-som.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

