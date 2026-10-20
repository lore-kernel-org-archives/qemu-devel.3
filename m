Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484CD606A319
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X6smXVOw;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RNHLftYH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJE4D-0004dw-EY; Tue, 20 Oct 2026 13:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJE49-0004da-Vg
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:56:02 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJE48-0003mg-7n
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 13:56:01 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KGu6Mi1926057
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vXQC2HyQwm3FN3LrzOBz5z7AOfmhFr2x8qVf4fVmp3U=; b=X6smXVOwEj5Opk0j
 XFiC5aHf8jmFdU3QQRgm9nX42LSQ7lSADZTyycNgEwm+Z97jqs7+lmsABeD0ClFI
 vrfKqwNtwxbwjVJ6agDb3q2x8DTU5Vv/kzKHMx12UrtizapjdEJEUZRTv9+veJ6l
 xqTJ6uKQRzXGqTFy/Pl8LDuCt/AHv1KWcckr1WJNrt5aoY14c7DGRGo8eD4jG6Uf
 R8k5ibKolCPUlAeI6SBQ8vX8Jt9/H8ZjbvyBzD/FKc4VKkCuX5Sytgv/pt6imocL
 sZYlxvV6vVVWcHuRegoCKCgXeTowlceaC27Oi4gjh4l0ZLM3kWQNjZEpEMig/Dto
 EPYjTA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qbsuc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:55:57 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f54f15b9eso102379085a.3
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792518957; x=1793123757; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vXQC2HyQwm3FN3LrzOBz5z7AOfmhFr2x8qVf4fVmp3U=;
 b=RNHLftYHfYAfZ4TFwMPsql/E5dUfEmkX/1kaEZ4Ui5JkYcqxGUZzHOgu05Vr3m4JUC
 +iF9K7MBC/PLhZyYIVCEqsKSVMSuwWzVT0RXSnYebRM+rh9xp5Kn/2OICAP3pohxl+v9
 f7N3XAAmSvHYweQDrwycS4sXOrIoqly0irUF/pqxsxb5K4F/mtpcBFIpsTOmwBEonD4d
 ONHUyW+R15k/a3p8EcAfbBvVq0NbtGLoEc4KxBc2ydGY6uH1NeOecgN6nKk+JBm2CqY2
 63C/o/BuOmEJYT5qLdsux4SMRRJl9lbTD959SQwubW9wX6e8NfTbW6ebapKTqFjND/X1
 rqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792518957; x=1793123757;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vXQC2HyQwm3FN3LrzOBz5z7AOfmhFr2x8qVf4fVmp3U=;
 b=kg/p6I1yC8y+MUXrLgqNM2YDQtD5DsWBKAHRZE7ETb2gnjuju18T+HrTrIVbITujJF
 N8t8hkGmBUDKyqjzpYlq/51BMGf7hXH7vn7DiYxF/uB0W1brn18ge0y1ZmlGrY+0Pcrv
 4GnHRF7+kUcDH2RBdk3QVR06qYts4paThvV7pN1H91ROBH52/FAlVgsWdxckt+r8Q488
 OHXAKRImW2xHsYDFDyRKV52v7zTBNd6Dky0D1CxmpaZ3wsiBDz+CmVd3I/cxfag6DeYM
 bZeuVlnzhY3CYPvfNQLy/yJ/DhQnCLMeG4OCMwKff+0L1DCFUhNtl16EGZzlbk01LaPj
 no0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdHd13xxMwXv+P5Ih+sR5D8H1xrGoj2oDPmkUJ31pM1r26FHlKX6biOVLrAxXN1mytAgUDSO/uTks4@nongnu.org
X-Gm-Message-State: AFq9FYKUW9ZXr7GajbgPpgQHyMaJg4zE6SLnYKPwO3LlF/fudYlGDKvY
 /Pxfx75gODZA3+UFf3GeIRtn8FXOS1hhck8ut/9GkOkibbEzeV81zP4tAyAW0KZS2/caXpd2w7n
 TRtvIMReryRnyjCgr+tq/LsrPPMSF19nIG0qI20xQ8CWbZ3PNu6BLNzw5bA==
X-Gm-Gg: AYBFou3T7XWLd0URIqOL7LzjvjjTbfTuWTZgyUk5Pi3/aAEuD9UD6uTpEc+U6XBMeNu
 cl3nmEI8i8UEKQZypm3sHgl5JVDVjmYXsPKNVUzKrvqA2v/3MYyUPOT2IyoYeHZXbxRAYLkBG71
 2zdOpJhI8oGtrKG9+6DAsKTHNuMPv8bIOEUpGqNzbFYwqF9vluDUkBa5JVcw72ENpWX4ApSpuV6
 m28z31pG8UM+X01FCTEW7zKwTw4+hD7UoqmkQLKe7IqQpbZAXDvl62S7EsqSI/aCEHRvA2G0U3l
 IN+VOV2aAhiWU/BIn0zTLv8GVaEtr35ARB9xYa9LgFYvIUlbcKuKxUSipnx6G/wrvb3QzvvTUlw
 i8tU8pNPG4vCc3TeGmb8HDKmc4BVOUQxmCw==
X-Received: by 2002:a05:620a:6504:b0:93c:a40d:e3cf with SMTP id
 af79cd13be357-93f57e40493mr4127985a.1.1792518957052; 
 Tue, 20 Oct 2026 10:55:57 -0700 (PDT)
X-Received: by 2002:a05:620a:6504:b0:93c:a40d:e3cf with SMTP id
 af79cd13be357-93f57e40493mr4117785a.1.1792518955656; 
 Tue, 20 Oct 2026 10:55:55 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc1b227dsm3592725e9.6.2026.10.20.10.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 10:55:54 -0700 (PDT)
Message-ID: <2a8d9f93-6a7b-4810-a139-5626576e9aa6@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 19:55:53 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] target/rx: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: fAfreUc-EFw7Zfx94Gs40GXfKBr3xGGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX4MYSw/yO1t0E
 0pWa993B/N+T9hqDJ95BqRWhr/GVeeKC3rGpb9SWKxTPlLCBL5wjwl7nvovr8BWxuR2dolI4GDA
 qdkDEXmr8lz24Iff1BDf29bE2VM/utPxuQmJnFE9NzSYIDogNki/yN7nnnyR/Vleb915t2fQgwz
 ywoNHpCABDND6VqG6+jpk1uC6StGGFE2pBBr3QBbYzKu9805sdVDrsEGwq9vMwNHH0VWRMMV998
 1mgxjh1yTn52+qW74UE5wKsX6PkNqxD5hH+JKE6f+2Mwn5Yx5t7Kn1y7ntVH+oFsANKA0as/nJD
 pSFEiZn6Zbr4cqZshBXPqcBUw+WSlTRM0qjBbvvobygNWNxVKmyHlErKfBf9MbM/XLXtGpAvlCO
 yN1bKuPHfKC4wFedPQUPJFpV2h5MX9VeYEi9GFIDVOLs3wy0h9ppVebvkRxKatzMVbR16B3P4Zd
 9nIfyYvq824df9dWTmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3MSBTYWx0ZWRfX737BZPh/vBH1
 3+/GsoTyGfs9X/ljEQbl3DQMMJT9N6hXzV53Qrnh+86sVa+8PlBy+ze+tSoOoUxhmTo8dWqMGyI
 qvbsdDHCiiOMquDYf/N+Zkm4fl+H4K8=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad7ab2d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ZIMcefOCBMOu5CnVuPEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: fAfreUc-EFw7Zfx94Gs40GXfKBr3xGGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200071
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 14:27, Peter Maydell wrote:
> Convert rx to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/rx/cpu.h    |  3 ++-
>   target/rx/cpu.c    |  2 +-
>   target/rx/helper.c | 10 ++++++++--
>   3 files changed, 11 insertions(+), 4 deletions(-)

No MMU, easy :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

