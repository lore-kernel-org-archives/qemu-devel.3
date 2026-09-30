Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FEDCA5FC2
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoz1-00065e-Sf; Wed, 30 Sep 2026 03:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoz0-00065K-FU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:44:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoyy-0004TJ-Ui
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:44:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U7dMFl4047228
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:44:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 guMnZOe3J4SVqKhTvYXDE/ri7tiwtRw5Fdf3nRFfqf8=; b=ktIAGPWTuJAEfyUR
 0fi2JtSdoYP2LATdxsUvtSlQ4sYrrklKbEyLwE5SW/1wntBqbayGCYbhMt09oD3l
 ADgzWYs7x178GKt1qVtXvsreuyDOxVuToAw2pgafFBzB1zgIilCuu/fSeb71RGwH
 rY/UXiOnomkXbgjwwzMD7l4YhquYU+pd9ovdjw+TXJ8t5aYNRjSMGMksiyiX/i7q
 pgR+KSr1kmVKKP9dg0qowIIthmNyLcrhx+kI3XQYtbCKCKysPIUEHQFdvA83aplL
 URL1RJR+W+zVJL7bTvmS9pcMrWTbVzZe+wsxmpbHrSmacXv0rzFkWQQ4tzKVlMNc
 KCGVfw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0mfaadff-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:44:02 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0312937eso675965485a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790754241; x=1791359041; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=guMnZOe3J4SVqKhTvYXDE/ri7tiwtRw5Fdf3nRFfqf8=;
 b=fZtjPKAsAJ7hkPlpK5NymFzFC1XU5tmmQFNF4bvOqHVI6S+tBObKCyaAh5qSVNOfUM
 4RnU1FUBOOSUyNR2cnDbX7iM8lsH6WKDabQJW+zdRuHfWiJnJZcVgX357WZ4hYdaKMjC
 xDslnNAvsK0JERw1dkZSB7HMOCW1ashoymv/zU1OCvwb5Tm//ISHQS1Aix0JZ5BITEV7
 qi4IE7E8wOZPO6wPooE4hY3x04LrC/7RlX/vC+qMj4O1q0Q/MAU4KaTsH9LJLhrqMmym
 1MmVlil54C/FnGGMNUlY9q8EyqKKB7OMnZ2jWxOgfb3ZDuF1gUy5psyPNMu/W3HvnUb8
 flTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790754241; x=1791359041;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=guMnZOe3J4SVqKhTvYXDE/ri7tiwtRw5Fdf3nRFfqf8=;
 b=zzNzD3Usc/CM5OMNtUiFwHJU/smof+5YytXzN006N7VLIaN0xdBuAhiKgFEwipFSux
 r+q5XBVkSsdVhyuYJLExfWY0ly+vH6GnDfaqAFsnBsRlv7ybPuXaN6ULLOTIBiEfMPpd
 vtv6K4avGkEafiMG+fJQwMyHhJ1taQkURLJWfSR2+6Nm1GzElRsYnfLbR0FfHbLvD/HA
 hitp/vk1azI9gNR42mYJR50EaGSswsIVgf1TudbTxNfC+ZkLPW/4JTVARpbM0JjYJUV1
 0JL9QOVc5zQdQb8krIerAf/8qbVb7Z8e2XCQuN3vJ5/vsGBhg2r30gYFLI/EcYlrFY4V
 /4Bg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwaVWAtSXDH2jaaZbs/QXAAupk+k6TY/OEhyxJZBzC+KlZrEFORHPSOUtaX8uh54PztZ1GnK7fDCe1@nongnu.org
X-Gm-Message-State: AFuF++maRUUkGES67k7+UiOP1ABVja37BXXXZBqHqmtVZYnJuiAm13Os
 amNWlVyitqutPASM8kgJtbKeq2HK4lBBq7/oNDc3FQLG6+blXxZXgzSnKXKDvJbMAHfsILvcdv+
 BB/W+oFXxsrsMxtx6ZsC+MrMTRD5TzvVVSuS311cPOrn9mzbs+PXVxWPdCQ==
X-Gm-Gg: AYBFou2Sul3gDgc8bHIrcKCdCPVSqH+WJFQcFj6fCUsFzFbhpS+VrkA6tQvDVz6KiUW
 re7QsqXaHbErJywLf/BO8hBko1GHGrX6ZoayBa7aTAdBBhDI45A5pBsd5QX4e9OOuesr+Ewb7uT
 VKTq+fjp87kPJFOLUMfbr4AEqqnwZvq5BN7CFYGO8YcTQrqrQyvS6DIsKakuqAlWK5HCC9OnZiu
 C/1+IeMOFF+sCLJtZ9s3dhbU0U8Fcg3zTi/bFSDHv2Kdmdyn9gXqLpdC8JvJ3SOzhOc4ZzbNM9S
 UiCUY01HgfFFAaZfuXQmdE13uF20iyeDgxkxxvG3JTrdag/LrvyUGx0yxPWHQctNWTS1V6Nd7Y6
 lwvAKqqzP3GE7oJuZqs4=
X-Received: by 2002:a05:620a:838b:b0:93c:812a:4c93 with SMTP id
 af79cd13be357-93ca96932f5mr85564385a.16.1790754241186; 
 Wed, 30 Sep 2026 00:44:01 -0700 (PDT)
X-Received: by 2002:a05:620a:838b:b0:93c:812a:4c93 with SMTP id
 af79cd13be357-93ca96932f5mr85561985a.16.1790754240682; 
 Wed, 30 Sep 2026 00:44:00 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b02a00421sm1431214f8f.31.2026.09.30.00.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:43:59 -0700 (PDT)
Message-ID: <e0697201-29dc-4d01-9823-41d4acb8328f@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] hw/arm/aspeed_ast27x0: Use unimp array and table
 for unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260930072501.2612119-1-jamin_lin@aspeedtech.com>
 <20260930072501.2612119-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260930072501.2612119-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX9+xdKEqeD/Ib
 1kNNkaISK123wJb33Ah+XyFOtdtgS9ZBh38GK2U0WgE3rnV8Itun6YwjL/qQzinP2navXKe+EkW
 DmzK3dVi8EHddrVRBVk2DWBpS8lAq8QtUfpjlYPFQ/TNSd9eh7mSz9Ayh258VHLk0tvy83sMHf6
 v2AjBfJtPdSGnPGnoUvGiQWqDTIjSeKnAbIP2N3DtY9a/FOwSZ+2rbXwhUv6ktf7/wCQ7zyu/kr
 ozCrJfAJeHCMd7bjHrHaAFWve91RKnj/dCaCi+BEzHp5WAG6i/HqlBtEIKDEcsm573DRWhdP4Os
 NNJV1SNhuUzsyzt0kwzAvEW2ELVCnm1C2Z7EZEdpko1hzZDKbInT0mZdU2UIDDIkvrc9+DmPJbt
 GbZrpCcT6mTff7DB/Mh+br/8q5VvpRPvdVpN7v7aApTRtiMj+ZyAhNN6qaYbLqipDTxGYRL/Kmv
 9H4n2Qsju5aeNdXN4zA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAzMCBTYWx0ZWRfX6fXxXSZxZdEm
 06WlV+kwpfNEhlActipObBKq+xMphJnd52a+5snmWU2nxA4BMJUX8u3mk9XF2E+bjuBN6+8o6wn
 Bir42hTIKAINHw8m4fFSlTOThy6/kjM=
X-Authority-Analysis: v=2.4 cv=RZEFmFtv c=1 sm=1 tr=0 ts=6abcbdc2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=7g8aA7A78AY7OC82r+w+4g==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=V2NxCb60AAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-GUID: JtBFzGtOjMtdnjMOSz4etdwLmkZ8R-oI
X-Proofpoint-ORIG-GUID: JtBFzGtOjMtdnjMOSz4etdwLmkZ8R-oI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300030
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

On 2026-09-30 9:25, Jamin Lin wrote:
> Before this change, each unimplemented device needed its own field in
> AspeedSoCState. This made the variable names confusing. For example,
> AspeedSoCState has "udc" as an unimplemented device, but
> Aspeed2600SoCState also has "udc" as the real UDC model.
> 
> Use the "unimp" array in AspeedSoCState for all unimplemented devices,
> and use the AspeedUnimpDevice table to describe them. This makes the
> code easier to maintain and read. Convert AST2700 to use them.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0.c | 49 ++++++++++++++++++-----------------------
>   1 file changed, 21 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

