Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D05CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBURR-0003dM-5b; Tue, 29 Sep 2026 05:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBURP-0003dB-Ua
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:48:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBURN-0004yv-Sz
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 05:48:03 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T8XRG61004679
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sb4kfqmcd+sQPlW1h8dBvl8Fl9X5Gza8JTY8Qi5dBiA=; b=Qu9vK2oakp5RPXeX
 /TSIyUJa4r/No48nrxRiRVthHxcUiPZedWaMTzE1BfA1pRAI0IRmW5lS3gGy20GU
 LM3QTwLuBM23yJdTZN6//I+2yhiyuX5On37fXQaog8o21mE8Tm77Ud0FdaIKpljR
 eNp48EP3GuKWTjFlEN3Mw/MnH/Em2Bqppk1vFsWBM8LHDqQTcLPVnWiN7W3RdWze
 kLIm7Po7tNFGuc6CFuclZjNyrrO3gCN6Gsx2R4aoiwqW7TnOnTsX1e3CmlLh4XYZ
 cVrXUBMnlBiPWR2uIFBb4trl5PrOtHaAH8fMfbEAvVnLno4LgEw1Hh79hnQlQ9X1
 Kns65w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h09x4r9u6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:47:59 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so817526085a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 02:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790675279; x=1791280079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sb4kfqmcd+sQPlW1h8dBvl8Fl9X5Gza8JTY8Qi5dBiA=;
 b=H5petsEAy8p8s3ChfdCh/QeHX2yqgiR4PVdaf3CYXzIEWy0Bgt+EaRlo9p+t5w/3LE
 JtMm1nR8Yc4DvbtND5u86cLFkyJQyvKZf7GwUvlba5+9G5ndmNC9xfuDRR3MFGSX3A2T
 y2VCI1iNLuSoc/+ZhoRvvOrS+1j2kPB8u3Y/IyFxa/e9eb/z//XNrUecncqXFPCTOCq2
 Pq9vu+TXGRjfyIpeiZz48x8wYODo1rze89EQosjxQpm7TqugWxCD/FirI1VvaUX4UULs
 3vEPaPXULK/TEAm5T8kdrQuEtuCJZ03lnhLCH22QWDPQ3Hs7hYWkpCQitiTicc4BaX7h
 9HbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790675279; x=1791280079;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sb4kfqmcd+sQPlW1h8dBvl8Fl9X5Gza8JTY8Qi5dBiA=;
 b=UiXcdYUxu7dja2y58QdUFmOb9FkMokp5q7X7IlRuB2Cdkle+L+fDZOIC7vZRlyZOm/
 9D+ckiHCENgOlHXjy3kQOpiqyaVw/5Zdgab80R1NeQ6m3e7UmfpgVnfD/IDzs2TLgiXL
 5IOABKu69b0xJwXEn/K6wk17VpC9gXvVztvogqTOHkPMLGG7JhSISDf5GWeG3gBkpssI
 UuPBs3DLb1G8Zj3LZCrHRbGXjr9uw7xFk30QfE8O37rEFrNLI5oMQIivAeVC34OCie+n
 hNcGjGYEnD6kOMbzV9eTyZ82CnhiMG9yAlv0SbM0oui9Qwro+Lw2NTueCUVvloRFkH+k
 qbyg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgoiwhHMSe9hrvy2N8so2AVABYAnHzPssPP84YTORJpubvqEAFmbuxFxpSzyAxQLHG9Q3SiTIFQ9Tz@nongnu.org
X-Gm-Message-State: AFuF++ldv9P6lOh727g8bTKdrT+OW25O2nUl7qh14W4xjnqX5dZv98O5
 3BNjhwRYmo2S1Sj/SmoqKaRgL59o7Xhat5pbE2CNLDhuwsieA2XQBPEUsni1Q2qB1ydBSOnUya2
 HKql/GFJx/Ob7Rq5Mk1OWP8SiuncEObwHfonuKdMM8IaS5KORYDY75GnCCg==
X-Gm-Gg: AYBFou16cB5KO2o1WspV+fhNT5jh2NKLpg3JY5igKKorXBacv2rQ8XizUA1b2VcJXs1
 V5xaMKI2zOg46gMU1CboCWJhgZCqqMy6eMH3POzOxCqSaKf/dcs8CXe/7rXufZtFi7mOCMFEx1p
 3HXdkWnZKy/7vmQR5XzjmHmO8l5OZvsRhJOpE4E5VVTpqGdsqET+aUH+2lmaDQpBQLWyGigr0lh
 3fywAmSdik67WEMMPXiYK8bHhWwRF02HiHjyIt0nSuFo9JRGS9VeEV5Bm+v78Do01MlYdjoL4RV
 t2tTMVRLdDH2bJYLHpJZwDG3kh4XA3bbKAZVBxgVWiNE1dObDnksu57Ai6Ny/ISSGMp8KDF7kFk
 hdNxn7PWYh5SxxcStFI1G+UHrt+cYbA4/Rw==
X-Received: by 2002:a05:620a:d88:b0:93c:8ad:4eee with SMTP id
 af79cd13be357-93c43d2562cmr2672556885a.59.1790675278767; 
 Tue, 29 Sep 2026 02:47:58 -0700 (PDT)
X-Received: by 2002:a05:620a:d88:b0:93c:8ad:4eee with SMTP id
 af79cd13be357-93c43d2562cmr2672554485a.59.1790675278245; 
 Tue, 29 Sep 2026 02:47:58 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c11a9d2sm77410135e9.3.2026.09.29.02.47.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 02:47:57 -0700 (PDT)
Message-ID: <605d1b4b-b837-4aeb-8469-832390aa159c@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 11:47:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] tests/tcg/mips64/test_mips64r6: fix call to
 check_results_64
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20260929074007.118970-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929074007.118970-15-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929074007.118970-15-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX3RpdHm7A+8Bz
 LPzbHSYDeFjKuBfgAfVO+Aala0SfZdZyWqGDLYd57phTfkIp2ellfowwIlohDCeri218pTLQ3Mb
 vzzIAZf4j1gUvSd4lF2M2EgtODm6zIU=
X-Proofpoint-GUID: LG6BzDMebLKaMusG5yWKDaL3oELdniF0
X-Authority-Analysis: v=2.4 cv=I5Hw19gg c=1 sm=1 tr=0 ts=6abb894f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=kD1aHXNoiUmW-fgF_RsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: LG6BzDMebLKaMusG5yWKDaL3oELdniF0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAzOCBTYWx0ZWRfX55FyTDU4Y7ks
 2AYPM88DoF+I4fz+2a9Ds2KJGi+89HCItwkgTYHf+/iDJaRU9os/4yG6GXTGPHDVMQI70pntOuL
 w18ccffv8dxF0sbUDKwxJjtQaDdySG4FTSfK0edtQIcWPFo6/KoRnolj1OFy4BrCOByVtz5eEPs
 hdpNL4pwavVc8JjzXqY7mitCmHW0mHBdTS6PHmyP/+huxrKwCoWysmmONxGPZiMpmxAMsFtMf06
 Wsg9Dl/+gZ5ag+JoYQQFqOVGq7qwdO3WA4oMIHgo6yTZyPEj0ZZCo5D4gGJRjodGkrcGaRO9qMT
 /UWUSMbJquSVTOIdXThF5w3AzntOBgXgqvMWd88xSWg9fg3rdtgizVBEJRkG5JO529tfO0hwxkI
 NbiWyQ0mQB/0aAutqL0wfFOXr3KHcebEttGkneV1hcljN4bZNiWA2/UpiJZq7j2mRjjZvpGEeDw
 h7L0BmM/DdHcY3RvI8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290038
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

On 29/9/26 09:40, Pierrick Bouvier wrote:
> isa and group names were present in all files, but not passed to
> check_results_64, which expects them.

🤦‍♀️

> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   tests/tcg/mips64/test_mips64r6_and.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_bitswap.c  | 3 ++-
>   tests/tcg/mips64/test_mips64r6_clo.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_clz.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_crc32b.c   | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32cb.c  | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32cd.c  | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32ch.c  | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32cw.c  | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32d.c   | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32h.c   | 6 +++---
>   tests/tcg/mips64/test_mips64r6_crc32w.c   | 6 +++---
>   tests/tcg/mips64/test_mips64r6_dbitswap.c | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dclo.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dclz.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dmuh.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dmuhu.c    | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dmul.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dmulu.c    | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dsllv.c    | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dsrav.c    | 3 ++-
>   tests/tcg/mips64/test_mips64r6_dsrlv.c    | 3 ++-
>   tests/tcg/mips64/test_mips64r6_muh.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_muhu.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_mul.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_mulu.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_nor.c      | 3 ++-
>   tests/tcg/mips64/test_mips64r6_or.c       | 3 ++-
>   tests/tcg/mips64/test_mips64r6_sllv.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_srav.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_srlv.c     | 3 ++-
>   tests/tcg/mips64/test_mips64r6_xor.c      | 3 ++-
>   32 files changed, 72 insertions(+), 48 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

