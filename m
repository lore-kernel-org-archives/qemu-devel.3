Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D93606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JnSlcf/s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K1evwrt4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHuD-00041c-Ds; Fri, 23 Oct 2026 12:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuA-0003uH-Ik
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHu9-00025A-31
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:06 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6PkC3000350
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kkj+mrrY+1pCpKtFipf6b4036PX/7dNhbqZhqBr1Rxo=; b=JnSlcf/sUEOR2HFg
 qSuXwu2Edf4u01d8wQYHDqog6jHEQCXK1szeW8N7ecF03rT9iR9HzX3deRUxcoX1
 hfHgHWl0vfs9wUE0e1ZhoneebsXshL68dzf2JgmENU85/UaiJzM2mtCeF33VdITy
 MBLQ4DwieULfTvXSzlXzhUXJEYDouT+tIVcPb/V0f+kmUcTHio5TpT+aRicAKS7h
 0MkJrrBIqiI6fxd1FKtzHbW2dDSBdqDH5PSkfLENkVjzvJURLngsoLmERAuqebYq
 16edaeAo/1jbEV9eP2hX2BGeqmoNv2K5TBx/sNJIKcydXCS51tlm9vNXOpZub3XZ
 hcyR8w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0vjn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:04 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f62934ef6so240932685a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772043; x=1793376843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kkj+mrrY+1pCpKtFipf6b4036PX/7dNhbqZhqBr1Rxo=;
 b=K1evwrt4tB0Wv0d1i1xwAp4z0hNr2+n68TM7v9EyeuvaTuvAnuUb7Nq6AZcBip3IO4
 xMoS7qZjh6b9sbP3wc98TIFgbfMfZZ+3XPn60FQ3kSOo7TJatyLi/pM5NjjgPZOFNpSm
 EIsMMfSK+qusosWW6ON+ah42SonJUI3XzUSjkgMg5rWF+ttV1Ue7Mpa3RE8RHJA5NxNw
 FfGXOy/lyt8xRme0FIMOUVwWY9Yp0eE2BQtzTgxB+bDzLoZTtuJIpKirJecHGKkxrEUC
 JvuLk7E7dnnTI8Jwio8+wNvkRmJkBgDF7YrPXrZdqGoKtQdN9GTng2QV2iDRMwrALFlQ
 hkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772043; x=1793376843;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kkj+mrrY+1pCpKtFipf6b4036PX/7dNhbqZhqBr1Rxo=;
 b=fhMRoHMwT9Aaso5s4YsrPwcRKDftWONdit4ZT54qpjQQuTMM6h7i7cTE2BtVBhFpEV
 B4iCDbryZGww/iTOFYds+ExnoHvzX+FDsjgHWobw6rJvPKJlTLlsHCrFCDJTePAFuSat
 lF+wYsLj5J2neiaxEJaecRJxxpWZBPPGABrsHPL4+bVCDAgJR2nBTgh/3ok+3x1e0CWw
 boDchWaHchsyEi5dJJGmx68jcJ2p1PQN3pLNRklQHoevHFoqJMooMByHwdQUHPTvq9aL
 mlQNZ0qA/AoqM8yjZtHNi75nw+q+DuDyf1xWLPemGEfx3fizOiY07MwTGwLVjxJOs8as
 8dVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByBtbiT6ijDZeM6dICyX2JOzKtV7ZuNVMgJ4TWraBg+JuisXnBftLMeU5NWg4LEYNtO2SBT1GMERd+F@nongnu.org
X-Gm-Message-State: AFq9FYK4zY45+vsmWumeeyf8WBfYrfRjjk2M6ahJ213taSjTlYVXQdTu
 iAFBUDNyWZ9YDBUaetPWakHzvAeXmHtGrTdX6VLvUOeNXVgzQI41vTLh+ig4/jg6GNG8Rx90Nue
 OfeHyWxeH03uDJCKC4z7Hg8joIFzBrcjEaQ4AslPrvinoaGO2R4KfIcXeZA==
X-Gm-Gg: AYBFou0doA94dTrjrxSD3ggf2a19ooaI+Esp+s9iMPeU63JDZHns9rFfYIoPCWzoS3h
 D9il+WLhWDRrw1lj9Vwj+DN76Ppz5SXtJ5KfXvV9LVixK8S0afjD7jonvD2CEONFKV5wtwS5IzV
 OxL5RIA5b/T5S+qF/GGxDwQuHF72hz+1kvAuW94hvtM1Q3GfyQAr0gClatyd7WXAB0sKshxR8mj
 EBLCEo45R3skVyc5aWxBPeUe4q50FiFXZsp3mSTN85u34E7LePRhfoLEc9ox+pPiCcHntaLaX2c
 4Mb+XVjoa6cBrBeV6q5VgU/tEUVY0hq74/gtxZxsyDwiHqqCrq/kgDG/B5tcEzn+FaddlV/7Y9V
 rx5V1L1vTQD+IGsIzM65obSqrOJXBi2mcBw==
X-Received: by 2002:a05:620a:2952:b0:92e:8310:7369 with SMTP id
 af79cd13be357-93f6f7cf26emr427228585a.37.1792772043575; 
 Fri, 23 Oct 2026 09:14:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2952:b0:92e:8310:7369 with SMTP id
 af79cd13be357-93f6f7cf26emr427224285a.37.1792772043139; 
 Fri, 23 Oct 2026 09:14:03 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2a9062d50sm15960515e9.2.2026.10.23.09.14.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 09:14:02 -0700 (PDT)
Message-ID: <0b87ad35-c93d-445f-ac96-63e307b9e083@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:14:01 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] alpha, avr, or1k, rx, tricore: Convert to
 translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX9pWcD86IQcgD
 TIksrqCnSTo9hMMG+s8ZKWP4sENELOKMR/lcKs1T92xjpk4ZnpSaDeyxYnYaOmlfkrUrw7j8Sa8
 V7hAmipbYw7Zn7qGfbUIppuvYwgDAuxCx1i9isU2Kxvek49MhKghVFmS0eleFs3Jhi/PLoxgDRw
 wnBLDQAfgVZz+yZ9mDQSnGs7ANjmtb9ar8/tvnOYzdIu6rAsLyRY2MY1H0Xz6oC7SwgNsxrIJW7
 G+BbSPSHjEeJ82AQdrfFE3eTslCZDqhmep3OUfO+FxeOZ+qrPkGX0FZOMlHf4+dlDkp9G3hSGEX
 3S4yG5WMdvFlYtlkizcogsMuUxQSrilIrEh4wNwqq6IrPahSs4xaFQ0VSfPBmBVo82PSgzLZTtN
 bByxPWbZc+PEU+/y9TdpWt+Mx2ZCibfh6Qh9f30mLn+e26rMg4keGZm9k5jTqWhpTXx9AJlu+GY
 yj8K4DP+1Y2+Hd6l7FQ==
X-Proofpoint-GUID: 0oszAhYwgnBVAxvnKEzJa1Ou5r7MKxrY
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb87cc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=RkFevBr6zMaV0Rq0CbQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: 0oszAhYwgnBVAxvnKEzJa1Ou5r7MKxrY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX4Bw6ERbG5mAU
 N0zMLHZRd07N7wobWfzGlwcX7xfM5oF6xiwfkb0lev5uW/iayhY9r4qlqsCJq7Y/CaeW5t7fE1z
 aY/IdtsiYKbBQ14I21xmrvGLIUFLbbI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 14:27, Peter Maydell wrote:

> Peter Maydell (5):
>    target/alpha: Convert to translate_for_debug
>    target/avr: Convert to translate_for_debug
>    target/or1k: Convert to translate_for_debug
>    target/rx: Convert to translate_for_debug
>    target/tricore: Convert to translate_for_debug

Queued, thanks.


