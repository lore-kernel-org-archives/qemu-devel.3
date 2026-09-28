Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB71DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBDU4-0005l3-A2; Mon, 28 Sep 2026 11:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDTx-0005dm-LC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:41:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBDTv-0004kK-HC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 11:41:33 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEdsP4378836
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 jTYtNQ6Qtt2S5IQzVNZcyfbjCWNltBdvRUhblxs9Ihs=; b=mytw2GYITWO4VaWz
 BNBNK0VC5chyXr+fBfhqS1EGgLsi3bWjQR41FDxoF60jkG5DOSRp4JJXGQ7B+TeH
 D5vLLZJ4a0xTm8xIoZFR6flZbFiusRcNTdEYHLAl5a+yG8y0R6wejEXf0Tp26HjV
 0gJ9Wj+fuLWwFlYgtRqkWQdrVAjmXWpOw9Rc8TfZVnACdkNvJWybDopVhPt3EOk/
 igcVKVmqU4EfeCHwOgtkECuQv4trSqJoeQPMs41QIfF5a0vnuehEjWzPXbjgor1Y
 Ewq9n2pTrQaRENDZ8yFpfaPFKV8G1kNJ6E39RHG0dIbfumSl8+1KJcq+oTGddynH
 PYEPGw==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyqx38wb7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 15:41:29 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7b48331bd21so139277137.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 08:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790610088; x=1791214888; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jTYtNQ6Qtt2S5IQzVNZcyfbjCWNltBdvRUhblxs9Ihs=;
 b=Ka12rs5eOUj01RHFYmdH4PtEgP3IqqQDJ/KdVmhqv1AbnX8JXFrHXnnIfhBJNGUl8J
 3MhCVWIR2SONBhFEPsdbm2/tYQN6hYWXanKeaCQ0D76whSaKfz9UjLViXnsiA+U/Q0Tv
 IHRHMkYcLbog6weWNBXQPVu5rXDHA+AGxULUv3zeXzzLbB6potcebdH2oSxikvW15EkZ
 /mQB6ZFoYr57wcFCzulnUP9zxvDY6/ioTwXyraJztixxqvbuRCPGjA+V2uSPwrg1CeqA
 QD+UT5gA65aiwL+mH4rqDdsfgRBmCTbYBNx6qnhoxGeCR5CmMvCinCtDv3unY+b0aUw7
 xfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610088; x=1791214888;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jTYtNQ6Qtt2S5IQzVNZcyfbjCWNltBdvRUhblxs9Ihs=;
 b=E00LsO1AEbNUK9c9pKcNfEPQW9KeWlF77FEyM94htS+Us/2DnPy9fmxRxQkiVdv9O/
 XaxcNlpBpM/cffxr2jPPydWMcG305oalUJ0+4u7Y++G5iUQdJ+FT06Q4Y8ifx0fd0EWF
 nO068hTpYxLcxO70/I/ux2j73WDwcLadpMQI1Lkv6A7ZnxDZsFy9aUSwGMm33pnuaD0k
 MxxEQmw/wJa1X87KZXICi8ozSfUKx2VjP7+MmuJpdLfoNpRMdzqqStPnn7KXPVP9bhtd
 XhWYVYujcIjq9Euvp3bId2MkFLxm4JkUoD3zjMktJ9eVUcNvWx8HXCoGnsOz9fCEDYUB
 vdYw==
X-Forwarded-Encrypted: i=1;
 AKwUvByMLO+P/wGFVTgnXPCrRiKwAIOemy9FSRZL+5+0FF9gsu9ziW6sMKKqYmCrFTYyM3q4opV0dPZ2UTrr@nongnu.org
X-Gm-Message-State: AFq9FYIgSpxdPspsjuYiRh+CYfpu40fubbzy2yl6IB1YOzEkmW0fgh6h
 pZnk6PKfcAACFwf7ZssOeTM14CFG8HLHoFHmytvqLdPfFrFaRUUYqGwvEYGyxjUaBUzEN1l11YW
 9rIr/RjZffu4LS1OMrZIEooeVCUIBUvXT+F7oNtQDJY35VhDvKwHWnxvL8A==
X-Gm-Gg: AYBFou37Xo4lZ+suahlwC3GT+6PyWPuYbRqsuvhbye5xfOXs0G1pyLfWkRCwv50KdVd
 WWc8XlOBxxKyO0te1koHgEvX5y+XNXdAArxlvpsaM4PFE/sq71VYv5gsBF9uK1v0yPabPwtLLf+
 bBGyIM0AzU2jaEXNIzHqBVyd1e6vtFpiBSQdlNT7RKw/wU7mB9yuP5ZXySVLKhgbhAy0/vsb0KS
 930XhybEMBcvceZaKnuo2EzBqi2OmZJw7hm0uznn4tgZ6ZdGAkNqOOgF/fQjCtoq9U5l60IPwmd
 7hCp7NlqCNFrV0UHLxiu5UrH+kg9KpPbrvXUqcYN7ma7gfaWlHISWphz0ip+KdnmKK97eYBqsyP
 6oYtq47uPj3JieMgVFy+lzz2JaMiK0rJjWw==
X-Received: by 2002:a05:6102:5707:b0:7a4:85a8:fbc5 with SMTP id
 ada2fe7eead31-7af1d1bb461mr4315647137.16.1790610088288; 
 Mon, 28 Sep 2026 08:41:28 -0700 (PDT)
X-Received: by 2002:a05:6102:5707:b0:7a4:85a8:fbc5 with SMTP id
 ada2fe7eead31-7af1d1bb461mr4315630137.16.1790610087081; 
 Mon, 28 Sep 2026 08:41:27 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00178174dsm139387825e9.10.2026.09.28.08.41.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 08:41:26 -0700 (PDT)
Message-ID: <591e9f48-d149-4e31-9289-868ee9b3c27a@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 17:41:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 028/101] tcg: Generic expansion of tcg_gen_andi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-29-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX80EevJbdc2cO
 VPjumbQ2jlZtvtbMiS6VV8Xkhn2uH7L6Ce/QC6TJYyL4s3D/NUZXCEAP71Tmok+kxN8XR8J2Crk
 e+1+WuvK+KKJXypUaHOvikA8SsSmqcwdJ20BWVcmp+ib/0mVY6i0AdcleLE4Ejn/JGI/NfL8xYe
 qyfLqKK6STEwLNxihysuPLZTSy05bVI9/WVM1mBDM8ERrwSOIkl1O2EWXChuEYfuhL/FUpd/FCv
 mXwd1Cv+Zl3fBRyIDHWvCuRELjO5sRybFdRPyqHh0w8y0z388WRfbhh3XBPvZJjHzVr6kTna4aV
 BENUNXK2kFRyDN+2D8vvLVHz0o9qXoa9bPLbsGrcPnpCeCtHe+IiQpSHm6MbxJpQVAV4YZ/xLxa
 hJtFiSPvRhsbSay9eW5M6kdcVpgDoMW9aEa2BkhyZj/d+9DC2Qntrm5LtC2T4rn4OQ+VZQEz+yK
 cl4cVuTzVpcIfw8B11w==
X-Authority-Analysis: v=2.4 cv=f7jdl+yM c=1 sm=1 tr=0 ts=6aba8aa9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=gYDTvv6II1OnSo0itH1n:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: hrsKMEkyE9ScI2YKCQOR8sDFJuwv1PdQ
X-Proofpoint-GUID: hrsKMEkyE9ScI2YKCQOR8sDFJuwv1PdQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2MiBTYWx0ZWRfX1WLRCUmvYQ4x
 0I6Q3NQgVGQHaHJyvh+7yMAINgF0C2mqEUTG6zDEcq0f45Pos14RIKq0L1Q9zeEmgRX8RLUdrOC
 HpA0aZsA7Ost4WIQ3zGQvKnXp+ZSV4g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280062
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 -
>   tcg/tcg-internal.h           |  6 +++
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 84 +++++++++++-------------------------
>   4 files changed, 31 insertions(+), 62 deletions(-)

"Directly call CTO instead of CTZ(~)".

"Avoid recursive op_extract call".

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

