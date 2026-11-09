Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F3A606A332
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cet3k/u9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BzcDQqpl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQSap-0000Aj-FD; Mon, 09 Nov 2026 11:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQSak-00008i-Mf
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:51:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xQSaj-0001dA-4N
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 11:51:34 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF82W334877
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 16:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hKk7GjOZn/Ja67icRAEtqmTix+vUzlrtHZ6Rnx79pc8=; b=cet3k/u9vPAdysbh
 E0YJ5G4zvbDYCXSaprRJKEvtugP2YdYOk/R0XlCqPHlmpboOw+M59YMUhYpkXOLe
 vXbNRWGamsLuOS7h+MKBN/5eHI7fm2Db4EyJovySKJKTO1mBpQ8tFEmV/QZTDQRd
 P79qP1VdSlIE97SD86YyfF4++KKRRrGCVLSVqgtfGrI+6SAuw0u2srbaSaqbC4np
 yyMcCP7tyskwgko3U5ciXDWpQdEJl36Lsw8A0D4Kbtxhp8TA/a6D06DVny55pA1w
 3pOOuh5n2xvNNBzAyo7K+/aJdlLaRvu471P0qKKPsJF03IIOf7pbUWH2PJgSJJU2
 JlSF1A==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf595c6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 16:51:31 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806e283b0eso843694241.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 08:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794243085; x=1794847885; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hKk7GjOZn/Ja67icRAEtqmTix+vUzlrtHZ6Rnx79pc8=;
 b=BzcDQqplrHi3Ip+PTV7CFEDfjl3bw0KQ/5WnzPtLg6rypjyGv2o/tE9SF2rvCxKcA8
 Sw6lGptWRETvBTyz7uKKKtlu0mzgBTRMN6+y8H++7hrwgagvpEuv4uBzKa1/H2eHUpnr
 9ex+RpVpF9SPCFr2cKcFkZImuG4fZO8k5ylsxOShOGuLxfCBsAYtvRFw48GJ0Iq+d+fq
 DczgHYxvH1EmX4YL8X+MMHbCMbLikT1Nwbv/ZN1LQERhLL1wWEHUUXOt5m0wvWNDzRca
 S1Qb5l0lenQuWUHGAIZ04NoBaoaVLiCp+ZCGBgP6yf0gAP4baPQ54OpwWnafYDzGqHzo
 +fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794243085; x=1794847885;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hKk7GjOZn/Ja67icRAEtqmTix+vUzlrtHZ6Rnx79pc8=;
 b=PmPq461k7O62uGmzqOYV7MJYldQ6y3jrFM9+H4N3tfSIqNDQEUkL4cjuUxsSA41TbF
 TcUTj+bIve0vUKByXTk9ebWxzyGrS4//TAOBOhYxanTEe9lTfMqZRF+kek3pdG3lFdiu
 xnu03vjztlSm+mTWkbYZcyn0LPlPphLh+H9YDI/KSMre3Dcs0st4BCENIMxwUegfbjPD
 2q5lRu//YpioNbM+C/mCN5GDMdm+WQd3xkFkuI0LgMONAF3zo1yVB2fIPa7HKAEvNLYO
 Ns4hqHi7wdherAzeMGUjh3jPiTg4/kbsPyz9GQY7GEV5yN5WdE5dcXv56nCaD1i6ccso
 GTKQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEJAWMn2h66yEbfQ0T8F6KbUe3AfdKIFUBBVj9BGfcPI/zKZuDZJkm8PbI77sExx5W5FznlKAPAXVIw@nongnu.org
X-Gm-Message-State: APuU4Z9sUcvCp9C7ucWVhO9386a/9GQeSsxQzRsmxWTyebhIkrhaKxkJ
 DEHB0Mzuj4yyanZqTYdgGXOv0n4I3243P0EE6CpCJ0+7ktRV56ViOHH/Aa+/Tl8s9qpwyfiAwko
 y9eikPR9zZ0tWZ1ak/jcK6feOIjDwToUi/ooAQy4k6Q8inF5czZvd3dCXJw==
X-Gm-Gg: AYBFou3oKvPfDavuvq1R/1cUnFrdqjyj7hUpWD32K1Hg0AEElq5V2P8MLp0Lft/hpdw
 ofDEldff1uLZaJDLZOOlqp4nZ4qEoFSqGou7geRYTA47L7vt9Ejr65TqCyxA+dsrdSCRqsV95jI
 a5ml4q0b/fW7i3RQxWsuvNZZxwzYsK6Ti7lRg/Bt9x+7+4Nd03VDCcg56wmwd9XZFZKOhK4Je4O
 mxUa0mcCNo+VP1Ug3wUWihRlXEG2ns5okTf+wa1MmH9vhBB1xBCoz59T4TYe/odOknLA75u/hxj
 khUrJfqCMlqSN5GV6C1U8Bl1RwDYa8605hUdxZaYYhOSrf635h7bisreZ7deA4WWddfenzOKreK
 d6GbCUEJ3mVGI0HJpx/WNcetrebDFhaTotXs6tHC3k5/QQf8ohyh1b2a0BHNeI7Rk5HtFlbSSIp
 aXYerVwg==
X-Received: by 2002:a05:6102:914:b0:7cc:25bc:3b30 with SMTP id
 ada2fe7eead31-7d2db10230dmr1586806137.21.1794243085539; 
 Mon, 09 Nov 2026 08:51:25 -0800 (PST)
X-Received: by 2002:a05:6102:914:b0:7cc:25bc:3b30 with SMTP id
 ada2fe7eead31-7d2db10230dmr1586796137.21.1794243085050; 
 Mon, 09 Nov 2026 08:51:25 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01d8c3b9sm1359695e9.4.2026.11.09.08.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 08:51:24 -0800 (PST)
Message-ID: <bef647fc-1805-4ecd-8c78-12cb45aa3a5a@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:51:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] accel/tcg: Drop DEBUG_TLB_LOG_GATE
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20261109161016.43218-1-richard.henderson@linaro.org>
 <20261109161016.43218-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261109161016.43218-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YI2ycPCIhNd7n0RWfztI8LgaK1CZyeB8
X-Proofpoint-GUID: YI2ycPCIhNd7n0RWfztI8LgaK1CZyeB8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX0Azph/Hdq3Ob
 mqQrEs4jD/DwaRMl8JgEoh5zfRgNDi4tdbuGGvBXNXZl46Xq+RzZWXxWWwoimjJr5ClqHhDzemR
 qAN6WZ7PsUcvpBroF3Q12gZF+w35ijg=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af1fa13 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=710_oyBJgAdZIzdjKFMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NyBTYWx0ZWRfX1tKuwN3xSy75
 RAKQuTl3o8DSQTiB3RcQitIjZn0iPtxwj68QVJRy5BvPH67CIocjE7vqJdg8BRf8of1Lu1dsrr7
 a3l2XvOmvPTkv4+jJik+m0pxuSf8uPTtDmLsQUr3lohLhHqvB5tklAYrAC3Z51VgbSYlFmvRRPc
 g5fR6nKVFZZWx5qScqu2t9Rw2Bc5sJC+7SjKGI/9ZLR+cm+CDtmokgjI5L7S5lsNE1sBIagM2dv
 XTKkCsuKev+QRxXFf+4XPOltBqOEUm2V4ZTx7TbQ1tRm9hPeAPqP/MDPmjHT+QWkc6FbXojcLKO
 Nl82zyrEsGRupBAe8FUC35w6ZxFTcrGP80mZGbcobSiHh77drAjtZAvdXT35vPH1d4sLFg9L+XC
 6d+pV6e14H7MBRwz3otN6oPGaLXQGH1Y3vznBeyx8mbWUF1HGUbdhCfD67xU71fFdQYK7ZIHdmp
 3yfWRnK7BUkymLFtGEg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090067
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

On 9/11/26 17:10, Richard Henderson wrote:
> These disabled logs could be transformed to trace events
> needed at at later date.  Just delete them for now.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/cputlb.c | 48 ++--------------------------------------------
>   1 file changed, 2 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

