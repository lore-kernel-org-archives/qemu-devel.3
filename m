Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD81C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 10:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whmBD-0003rt-JB; Thu, 09 Jul 2026 06:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmBC-0003of-U4
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:40:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whmBA-0001Az-FO
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 06:40:30 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669ANR8j1533610
 for <qemu-devel@nongnu.org>; Thu, 9 Jul 2026 10:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 79XwVJIR3IPv5shmrjRHDiMLrwib01GT/w2p2t6F3GI=; b=VHdtc66+QX6l6fU9
 8brH7iJlL9EyfkuFH3+qtkl8yLxDIKkGtnkR6jc8DSQBSwWgAbt/8MWCkraVz92a
 yUOEC5Nm1H99S48gfbiqzv7gc9oInEd0gTGXA/hV3/BL8XJLHSG6cya6PIDTONVk
 +gjjsWBZz6rYWD5e4/G/Pj4CcsVaealw5Rn8g9lt0sPyJLUogdxIjpZYm7njLsL1
 AtfsY0G/ya8eM/CFxrzxRxIOPGi9XC3Y2G30/PXrZC7tatx9PwAKA1szXyxFmhNp
 Y9GWEPePTVg4mgOWnuVE+vnwL24d4fJzy/ZCXDGLQsxkw4CiJp7O081jYiAoTmid
 EGdZ6w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa418hmk6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 10:40:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso21601211cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783593623; x=1784198423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=79XwVJIR3IPv5shmrjRHDiMLrwib01GT/w2p2t6F3GI=;
 b=RbykaPRIPdGh/XV+shQEFZ2NrB2cwoEZCy/8D34VMbB/k5UheQEy6vkfwgf2JsO99f
 QcnSmzR4LkGCN/iY+wFfJMg8v23zTZX+BAaRJKSfo7PbDrCPCCDE0kRsGtbT3yxmRxEO
 9KqEiMcZ0lb444IuO5mH6/o60Ml5ndwQwaa4TQ4Pk++x/q4JS6oT37/uHrIJPLXAMx7H
 aTgPE/8OiM1aXy+Q+dPYgFZ9SRkkJi3epFXIjPmcRnZv6dsFk/5U3/TwOWau7XCg0wW5
 JJpv0DtPU1a3lSo8cFMlOe2++Ul+I9fitr4MCD5SYrlAREMn1wdVXsZY1YBPHuPPGX6B
 3BiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593623; x=1784198423;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=79XwVJIR3IPv5shmrjRHDiMLrwib01GT/w2p2t6F3GI=;
 b=dgzDcTZL6HCn2PJRi/Re/L9HUU4FTGQLIbgSDBqmKCpWud50kkKs6hPbXax37T7TL5
 Obvg6wCSjSBlfsNNY0eAYJoi/4u4i/3R7nlC/CNbo3zo+756Ylpu4MU/Zf5p8xCp8KlC
 Y4jkvPnkou2JdXulngPhJeavxRtTMnk9bWcB/YcUh3TDFT3NJA/6HB0kxpiQtr2j4R3N
 BpYDOz9cyNXsH0srqj7FndltIeRNtaQlVFC4kdYbxTl0NQQ0x2QdgJsSvUuZNQzujbCW
 WlpvEJPBfflsbfGop1QIPHsNYSoRJruct5xAS8L2wPsu3qyEyUV0+VqvvgJXiR6nZ75y
 j8gQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXHbBN1l1nun+jzmQ+UhIDLvDQssshls4HDtiYMsrTG1QlvoZ6AerpFUOt58yAkTaIiYkWo/KGSaot@nongnu.org
X-Gm-Message-State: AOJu0Yyx7oQSB5oxEVa3a7o1g+tz3anDZGC9tZp4bDCm8vRNjseIr0GY
 UASxf4CtAnQ+FO5Wcz4qan3ACbjXn7UJHZcZyAxkcgcuUopH2FxS/MajPuXd/gYURAsAHWcnizR
 0qfSoZluQVsK4crVZd/G04SzV8vOqAhh2uOmsC6NTmSlNWHC5sZ7wKgeaAA==
X-Gm-Gg: AfdE7cnZ0d5cWaZzYtUXg/775ovaxcVca2ns69d9sd4wwqXbaH6fTQM2qVVVAFYLb9B
 PNjrticNwBjphxHZwz1PWds5nmIuqEcz+7TU54qAmbbF8gDrXb+1G7x5cI3O85FKQTCd8Ky91yC
 JWv5SBrZAQutwvMA6mOz5LQOxrFXO3VMaibYqI1Nt3y7G72JTgHPKsKzPCdASOHlUibbLnC1HED
 4w//zmgB8yI/zAMD4BKF1pWL1s1NdC5KlU46nQ4YrvSEPPsWOMEbiY9c/qG91prcpvOQG4HglIb
 AfR3ZvTozNi5JU/pLW3e1sJR+OgHF+CYSwqBFn7V02S3zNRfo0z3H4J2XFp43bRIB9KKJjexRJh
 xs/Q4x6/kohdF2fyxCIbisVnkscHpytn6IUP9X0rGcGrAfz5XPLeCzfe1CJLuGA==
X-Received: by 2002:a05:622a:1810:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-51c8b3c6834mr71579261cf.42.1783593623443; 
 Thu, 09 Jul 2026 03:40:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1810:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-51c8b3c6834mr71579041cf.42.1783593623038; 
 Thu, 09 Jul 2026 03:40:23 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d7a375sm9157300a12.15.2026.07.09.03.40.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 03:40:22 -0700 (PDT)
Message-ID: <2fbac1e2-cb04-498d-954d-8815e0305868@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 12:40:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] mailmap: add fix for Zhongyao Chen
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: chen.zhongyao@zte.com.cn
References: <20260709080040.4157324-1-alex.bennee@linaro.org>
 <20260709080040.4157324-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260709080040.4157324-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=UI3t2ify c=1 sm=1 tr=0 ts=6a4f7a98 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=1RTuLK3dAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22 a=kRpfLKi8w9umh8uBmg1i:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwMiBTYWx0ZWRfXw9mXQSyaWegd
 niupQVtpIC8wSSl1irkOEHuTPboAItkkSK8GNzMxd/3k5pmd0sCRnFi8RQpeg0xuzM58NK+Hj40
 a6joY3J1GPk+5YkQ4YD9OyROAxIMnjSCU+Vvy6mXaX6rFOM/CUVvnCH1B81pNSnv5FoTliMhIJ1
 HOS7h8iTEuImdPNdumIl+IlxGdiuhkvhQPeYzx85CDnuR9GKnFNB4dxH9ujpLcuDFmUaSOyJ5hQ
 wF3SkZmTMfDYpM7kkmvyPHcKBSZ9/zgvzmPUWpdEzyGhAAkpyA+YJg95TqCYS63rhoDeSTR/XYu
 Acw7A2l1VrnXMLGIv7k1fBXE5JXJR896vg7Y0C/cL3eJ7xu36LBgaS6z/pAB3XYHihqHthFwJyf
 Ha71qghFPmQ3y9zeKUXkcTP9QXcIW8r8BSWb2z16n0ZdDxn9PpT95hvbrY8f/lcFhEgHKwq+qjq
 pYUOOQTE3oCno/vLaaw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwMiBTYWx0ZWRfX0JBBLPMZA0vn
 g/cMc1UsLoHygenM5TfrETEVapqy45sLbWmhBURHooy016SqHtdPUvelZ03GSeDMZgDHVqdSdDN
 7OEvUnzcdu86SDMLqtrgf9AnoQBWGqI=
X-Proofpoint-GUID: MzQESyk0gWndz2CpgmNYEb-o3uoEMB48
X-Proofpoint-ORIG-GUID: MzQESyk0gWndz2CpgmNYEb-o3uoEMB48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090102
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

On 9/7/26 10:00, Alex BennÃ©e wrote:
> Fixes: c24f58d5322 (target/riscv: Fix tail handling for vmv.s.x and vfmv.s.f)
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Cc: <chen.zhongyao@zte.com.cn>
> ---
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

