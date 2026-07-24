Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B77C531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 06:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn96g-0003vu-AW; Fri, 24 Jul 2026 02:10:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn96b-0003uz-9j
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:09:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wn96Z-0008Cu-PL
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 02:09:57 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lpvk1869894
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X/dBX7y//cW2nY1FIC247Pf6ql53H0L7jAyqD6Fq7no=; b=cBunQ9UQGA8NUEwe
 +35/fHlrIMz3iEWUzZpyiKZJypszOuzc3EvAEOJgmV9pm6iRngLOpVVRoWZRsN5I
 cGLHevEmMmGYKNNQnMrpJhQs39+lTacvWwOorGl9R6WRUSlsl9k8gFrVDW/+tzmM
 KmgvqN4QdaujrDdHhfq3Uxtm3Hg5p/uUs2/jZ7EgEyI3Lx8vZ9ezbZljRzObFOQj
 rgdGLVyeGcBO3xleyNafcq1aq95/yo96Dx16eolV8j2sPRtjGCsIoPbV7embgzzz
 qnyRTH87cWxnpS6IZK4WY8b+ROX7s3NFTxNlZARyauSJvrLrD1s8/MD2vUWgyNr/
 VEqzTA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm0pw8cea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 06:09:54 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c19493ac2so1432841cf.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 23:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784873393; x=1785478193; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X/dBX7y//cW2nY1FIC247Pf6ql53H0L7jAyqD6Fq7no=;
 b=YAyRz4tytCoU4jBhbeGDs39A8J5MpL4pP0t3xK5zdPlqy1S256piCzpS6lV4BYPnJC
 H7hxw2LBrkI6FfP416PlW+VWfB6aefYgRc8k0fiWx24EQt3nlHTSa70UwuGZqFW+053u
 crDg6bMvRyQlNPEO6Sa5R3gsz0ocvR2y3i9YHbGm23WyjZr2mHhzqoWBvFEZ8ILYRhKl
 OceFSFvVI3qhfqbgYQ1FTFmgnqsXGlR6+prt9gSj1ceoUn9p7oGw1o9Gk1OeEGgXRKB6
 BL5o7H1Gz35Ki9ltij5NNlSIH+WxIE/6BrL2R/o3vFwqGlS/zsNtRv6aFUWsk7+OBhdu
 aMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784873393; x=1785478193;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X/dBX7y//cW2nY1FIC247Pf6ql53H0L7jAyqD6Fq7no=;
 b=JR5QMLXwk/CD0lJC8t33wN6+CrDCr9L/YgsA1XpCum0IGkUV9ft+VvLcq4jyvxXpy8
 6Z3kHNyA3g3FjU/Xvay1KNdYB09qFZPyynTFvA44RORGLVYw087O9C3lA78qPU0wnvu5
 BqfwXPQR5zGsmtIlSUbEMSM6zd1LMw1+OlIQW/WF8KyFb3PPx9tlW+UNP6RmG/c6OzoB
 UvupCrESS0amADN7Zk/wQpfumgM1ZmEr4bfNt5x4mWF9JjJIIODalHno9IjoQIBZZpKx
 tq8JaHMpOsfK87evy3fdOgQiwNZcaYputrO1zvtOMfBGUVLVooNZHTrp+Q9BD6y/ByRy
 XR0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqfkrbmF7wU6jZY3EimHuhl57fZUGF91xoMKIMSWfd4ko791sSBPdbqdxjFHeIO6kPcJfu8x9JFNntT@nongnu.org
X-Gm-Message-State: AOJu0Yzk0bie9d9lN41FrVdpxWo3jdGhuoa20UmafPyPSHo/LfRX3g+4
 BVxNs6TZhYdvY6y2Oy17i5s0xxiOUWcqiS6fPbnVBr22WJval4qNBN7gVVBkPkmW87h1OlSwT3y
 b/B+m8myKssbd7zoZRWyuRAR6jdOBCXzMpWaBYGBy+7kmyaXMhoMQqRCBCg==
X-Gm-Gg: AR+sD11K3nCtB/NHC8FR8oEKum6Cox2Suqw6+Dyzm9a6s3gS35WKdwCfxVQ8KxNPfPo
 GyTN46vuFuQ+iXXRaDLHW07yzoXb5iKCaEmauZEmLXtWupWxriGk1Pg8Srn0NzObMLVqxcpetTT
 gbBwPVVp42rOvtMRQpUfmXSKVJUoEtxm3EM+2JTetKCUI90txzLxNVzWfGIKthLZMgfTlblk+8a
 WenVFYtznWxUSjZ9YCT2mG/SS6VZdhjbgJ33OcTvWzcfmDO8w/84fs9Eo7ydjcsxyYly9PUSGfd
 GusJVXdYjRfm1y3USxMmSjY/Rqgrgx6NdGpytaF32mcn+P86cNCwluRuNOXCZ9JQKfIbnr9oNpb
 wHVg9slj9+tZ0bFFbjmTQRFyacjs=
X-Received: by 2002:ac8:5f0f:0:b0:51b:fb4f:afdc with SMTP id
 d75a77b69052e-5283dd94f18mr63075841cf.11.1784873393435; 
 Thu, 23 Jul 2026 23:09:53 -0700 (PDT)
X-Received: by 2002:ac8:5f0f:0:b0:51b:fb4f:afdc with SMTP id
 d75a77b69052e-5283dd94f18mr63075651cf.11.1784873393042; 
 Thu, 23 Jul 2026 23:09:53 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bdac28sm20082137f8f.16.2026.07.23.23.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 23:09:52 -0700 (PDT)
Message-ID: <786fe352-24cb-4cd1-aae8-d96a78ca4eac@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 08:09:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] target-info: add target_riscv32 and
 target_base_riscv
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfX6fIw4Bcs08aB
 uBGeYPX+/c1Bzjn8V/5xRo89k9QV8ci8u17V6oTUoQEJW9WmFFrj2GAcGOzNDSsYb2oQMJEhePo
 DwZLk48Cf8z5sNIaHnUakgyWBPbB7VT2S636slu7snu8NXKfQJnOYTKHR5O9Dthy26hJ9SZ43Fd
 fEC0Equx6ULApBEr5KoTtupHdexZ/wevPNbfTqYb5fACGfIhH01kXISv8lNt19TyVOUkrCHConX
 EDLpkQXSKthiMATM02AUdioiy4C58Q+USw7hAZQ5Z8+s53yCRV1WyQKLNygoiMyF7oHbyw8xlCi
 v1kAt8osMfwdYjmZEsr02cY8t2UHPU2VM4WoeMoLe8ejjYLf0F2fTdaMNgB5+nB/WsxG4MfIsQ0
 ElD8moGKcfa4qSzGuIzSBuDzaHxt8iviR6LpgdYWQy2nPlhuT+IowkMRYaY/XPYxCE1QgXA/2cO
 TD5Xuz4TjP1KtS1A8hw==
X-Authority-Analysis: v=2.4 cv=RJeD2Yi+ c=1 sm=1 tr=0 ts=6a6301b2 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: m3wWCBtcTv77nmz1FskJKgtmqdYrgDEL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA1NCBTYWx0ZWRfXzxZtqeUm0wfz
 kR7t+cuTcHymdyWDy0UbTgFR5zUief5F+D3UT4rBSzrVQtpysK5tnL6X/uaFf2ON5pn8r9BlH8E
 GCWrH8CLpd0s5rK2/sEx1c2oE386yZk=
X-Proofpoint-GUID: m3wWCBtcTv77nmz1FskJKgtmqdYrgDEL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240054
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

On 24/7/26 02:09, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info.h | 16 +++++++++++++++-
>   target-info.c              | 16 ++++++++++++++++
>   2 files changed, 31 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

