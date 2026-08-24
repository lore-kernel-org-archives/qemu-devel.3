Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C55C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:05:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNoT-0005qY-4O; Mon, 24 Aug 2026 02:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNoQ-0005fv-QX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:05:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyNoP-0006uS-9J
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 02:05:38 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O5R4fa2057955
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mNOh3+3AhVioMOpvSHXm0okox7+ZQtIOz/6ydnkI1DA=; b=Ow5sh0+Xa/fYgyck
 rD3SFhsCEsK0CK7MsTPmPNNGTnRBwLhiTBpYobXoCmluALlGndAQGNPBuQ9L+zBg
 BwkYPKaGG7w9xd0RM+wWRrdLnDHCgottv9qZi22Qdrh5DWdN3e88jtOfMdX2Mm1f
 gzIZuG809yWs48WDKO3+JNiCjs1gYESDjQLPMJCJ0a8vG+NaVvMDAmghYP8cfh2h
 FpFzzQXDZbDAL32NlJdJ2/R7Hs3yAI3nkk/GeQq7Zo9gZQAMzRRune0OigUZ7ihM
 fXXpBbDyY7fhhZqSL/jzviS0YRJJS8Ni/x1ju1x/EEKK+Lukxsj8TyOCnKeacMl2
 NKDsug==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr0t75-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:05:36 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-97c3607c924so3885725241.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 23:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787551535; x=1788156335; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mNOh3+3AhVioMOpvSHXm0okox7+ZQtIOz/6ydnkI1DA=;
 b=RSNtH/HtyprQct/WPtL8TqYoYaIthl9Efc4vQQb4tbdSdum3ulTvf76egGlVCJ8gKm
 yz02xUnSmsbZBTMlNbBQ2jucyk7yakk8nVzkRIVr1WQV5gU8pQRYCOqfhSInzXRElwj9
 z8Nllg+W/YfaLy7t/PBzSUnv99wWeciRlwvjwDVSd+oz9rNWU9G4+c5fOwJ+F1j1kfJQ
 9qU6ITM3YPtjqdd8c39fl6ijKZSFRKr54reWNgXfCEPBhQDJmyNSHyFxc4cEdjfxsUN4
 B55kxRrO3v7q276c/5l4Mw3TQiXIDNeLeVMn+UvaBrGUMB5Gifh31nKF0YPoXVGddMbh
 DSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787551535; x=1788156335;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mNOh3+3AhVioMOpvSHXm0okox7+ZQtIOz/6ydnkI1DA=;
 b=fLmx3Qzd6/wUphO3SDaFR3KsBtr3GtjwIO1vQued1RV8ZhfKD5N0OSnbvvG+FMsD2h
 jS4Qgb08hKoboDwkLFdn+ne7o1NFdM5Js/S9kPiSuKeFcOQJtwfeMzvXEbkZWaN19yFW
 qrmpfKb6DsoqHmViMgzafaX2fTW5kSpfTX+AAATKzZ0uts33xlVIOvNycvI780oEXV8X
 963N/Wj1x9iUUuVmz/KjBKeJuPJsimaZk8ILJaTAUOHn2s47l3fKXwD8SSC9oQS1sHbY
 TfUmlacoQQAKtwDbg4hOrfDKmOKZI2EFe+pJpl1etji512BkySrFXYMDezk5DgVtgkrb
 dRCg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqV3ZknADjJzfUCACr6zkFUniv9A2/02PudQ6nVuOjy6liKum3kOj4NxCB1qQoGnZcv2ZzCnaD6Xels@nongnu.org
X-Gm-Message-State: AFuF++kwiS9T2b9mCPVg3leEhAfiWeEmbXbyTmMGddTEmEtRm/YNohGV
 RFdESQ9wQOynuxhFRyYXKywAnzOVWh/Zz0wS5sp+KX4mHWevb/Apd/Ih74oc3866ESJTlYl1drJ
 t7y2qapgN89sjwhPplN2rP91JNnCzvumee7wYUuV82+wUjIx4iYgWHnkGKQ==
X-Gm-Gg: AR+sD131Q5qYPbOFmQBW+dhzCr4WWtWbaZN+oB+YG8ltKXU6kc3tiaHc7kU1ynn3Lg5
 s8wEtf06On1RLIPN99/DMfTqfi03T2+P7dz35vQB0+ZAsTfDOJHaNsuieyU4G4+So9MouqTqgy2
 rVQqbHBaVvMyLCWyX9ivUbeD4O5jzLHskxSkRJto/Px0kII9m1KNn50iTLrWIvWKdiFNF5+2tEV
 GDcDGTMzQ0kshpMVwFhYQrdTUsemAHRNpNjf0ue9A6QsRTULRgjgeqVub8VxQO/4o3SuKuL8sGw
 ylcUU7hqXTRf+DIw9BOaQkZCjKrs2HmJnoshD5UpAweY5PAabDc4c78KpmDLCeEFGalEAIAJw8h
 20qI5jUQrRnzQDPmAMT+KZbDk1fAGGdZb67eOIJx7JE+jd65OGg==
X-Received: by 2002:a05:6102:244d:b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-778ed3945cfmr5546563137.0.1787551535313; 
 Sun, 23 Aug 2026 23:05:35 -0700 (PDT)
X-Received: by 2002:a05:6102:244d:b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-778ed3945cfmr5546545137.0.1787551534832; 
 Sun, 23 Aug 2026 23:05:34 -0700 (PDT)
Received: from [10.254.188.74] (241.170.88.92.rev.sfr.net. [92.88.170.241])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e012f84sm9765847a12.8.2026.08.23.23.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Aug 2026 23:05:34 -0700 (PDT)
Message-ID: <5259d5dd-04d5-4df3-a8f0-2970342648a1@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:05:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] hw/riscv/atlantis: Document QEMU-only I2C device tree
 nodes
Content-Language: en-US
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260824055642.41098-1-joel@jms.id.au>
 <20260824055642.41098-5-joel@jms.id.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824055642.41098-5-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX8R9joJqiLzY2
 hRbLo23yLBvIv1LL4aXXiOZW9rfSSDfWfg+F2X1yyNC3yI/JX/7TygrKZ8n80DQJIFvVcQg40X1
 9xUbbE8L7CoA7+AVs+U46u80RrsnZvnPyNrFcjLZlw156oA1wu7lAALXT1fljVaxtgXczbK1VLi
 M2x6g+4q7FvbplsGt8e4rXXOd0m3r+VY2ENT+Hj/MSBU8jUx+WQaFpyvP2b2UdEQPOsXTI7LYWb
 xWHM76yQywqSkZovob1JQpgf4fHAlXq8JCXI+ftEdjjp2f7yrZCoRvIMa6qQFLEolzuiqutsYqO
 AdGcHfwFmA9zRYinXCGe29cUF2i+/2OCmTmAD5PXrJCRlKAwOrTTO9rLpThBCTF+H6kh/5n9tJZ
 EyxpmglAAwtkVdbhAjTrE+qTtj3v+td5LfaB7hruSQLxsorFDkvqX84XATMqXQQ8ka7ivHbiJ2O
 4R1DBbtT+CwAtWuwh3g==
X-Proofpoint-GUID: 23YpGWnRmf2LI-VIHxfB56ruD3hdmq-T
X-Proofpoint-ORIG-GUID: 23YpGWnRmf2LI-VIHxfB56ruD3hdmq-T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA1MSBTYWx0ZWRfX8ZS5R5K3FEeN
 pkKD2SSC4cuerVV+K2UiZiFbk0V3NfVluFDvcOLgYmM/vGlfFW/Fk1ZmcgxZ0qX/F6H0GexfAke
 oAu+WAgYXsjcUlERoimyD0b77YeOn+U=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8bdf30 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=+Tg70iCNDwYGP/1Xem9bLg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YWV-e9l3BiEZpfse0y0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240051
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

On 24/8/26 07:56, Joel Stanley wrote:
> The QEMU only I2C devices have a comment next to them, do the same for
> the corresponding device tree entries.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   hw/riscv/tt_atlantis.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

