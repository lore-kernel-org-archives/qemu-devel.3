Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D64C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqeX-0007dW-2W; Sun, 27 Sep 2026 11:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqeV-0007dN-Qy
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:18:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqeU-0008JE-GB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:18:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1mfWY1937555
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:18:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=MuYYlnyS7fq+J2wP
 54Q2kaq7y4DmqSXtiy2GeRjp7t+EqwUxJQ2NdwPM1NRqQstgSiOCk81xLTc7d/KV
 gg09zF1OUk+YOJ0LhfsJ+987nr9HM3EZzShGrEY5aTLqdACqkwcc6sNbCYIIjiIU
 Cp2Vsj3csHW/5SKDrLVuA8LnqRXT0eUuLoXatnRR6JHyC9mtGdo/O9iIVsj9rL3Y
 H8kNIOy2vewbOxL3UPBWMfE1RZK73eK1hj61uqJMmI85e6Qs8xQv/sHKgt92TsQ1
 XUhF3XFBQJZWzkXTQa89MNhdFoe8nulHVT6djAwLY2fU5ylXGGitsVkGwPb5r5S2
 hF/60g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb743-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:18:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390a2c895bso691868885a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790522332; x=1791127132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=f9Y4qqFbPAJb7Mfx9U/BZq2FYKgGZsLVEUnrjfqOOT4vk9fEc6NNOdyGNHTA8QAG4g
 HEN0oH5K9nKMvHGrHUTtHaqfivP7H6c6MO1HkfgQ0ALuq8CP3zzjjgxHwllXfw3p7rBj
 m4uHlrk7kW+EjVPaPotF1GPGHl34Y0f5tyTLy0wzDAvAjVQRjC3dmjuR/XDrA0nl/JRF
 h3IEBN7pHZRjxSEvSPkXaBPpyeIynIgxMWyvA0Jn5uv0qPzTr3iaJIn0y+cCnSGf85AL
 R9uosyRwJ5gDlGEqOSfBHgFsLNyAoYTPJPmHWj9lELVWsCE22MyNzAkmn/5s6aoQByb/
 BUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790522332; x=1791127132;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=0MNLcahdMYM9ZacJd6u1naO9hZpi6wuI4m/XVzhwxoyZ2de4VkaYwL3zPYSi9E4vjV
 6Oa5Ig8M8EX8fC7uI++SluLAW+EAHjKJ8s8TiwbajToEz5I9SKxyFClDunuxKSGJ3Me/
 AxHV9UHpIpnNVROs/0zQVArUOE70aJHpymE9nkwHXbV5rMnlm8rOWFoUvzTlccH14ywL
 5rczMCK1BTaAoYEE+drMERLfjp3tvOFk4n/8aY+PiSDLJtAd/g6OA8nGiSr10NQQCCUw
 RaCKgjp0KppPB7DYSIc4C5TWaGXbzKKWf0/tTFPcwM3h0pW5VhQhL1WV5ALSJFnTRL5J
 7Mng==
X-Forwarded-Encrypted: i=1;
 AKwUvBxWuUSvjMNGrCi4ODZYuj4Bg9RVH1HBxoGjwwkGrqvawo5zeb8kSkwkXtvrgNqqkZp3SyrAAN2mabet@nongnu.org
X-Gm-Message-State: AFuF++nMSICpEsuAXK3JM9jOpUgs3MOJyQmLoJLBbc6ymL1X9DpwnrXm
 ETkzH8KEj647LVDChAKLI7Hej3AWKxDcdEOS6aPaxSbs2vkL1vQoJHzq7SIIPh1LN5YHBnz6pEG
 QdtILU8HEwGPtAOY1ajruZVerAe1aHENH7a4X7oLp1CSSdn9MJRZzwxc0uv72HDZxKA==
X-Gm-Gg: AYBFou1DCnTpLb9f9tMixJAO5trq6Q4GnrRqWtUNnuiJAwp+svA8mF6zWmk+JatgEHK
 Du/IMZ6kJvTGtD114Kv/m0FNvR3cj3E8XsJEax1xUMwagkkBWUcNBk96rw+Ub3NCvKqpuKQURwg
 I4K0K0HR9znwEj+uBRugNQD0QvQPVUx2ttHAtIxXmLCXcw/wxxzv1PehdsIEJZrtcVdhkm7ud5t
 6VLXDRVB/V9jN7emKupNNvipNoIx8dTJSmwStpikCm0TOQqIabbqapn8Q48NcN6G9UFNVYChv4n
 iwTA2Gr5v4GzPa950BmrD7IXmCY3AaHx586GmElY4dGJVDPaEly6kEuudsbIqsEuWSYi+gmBHrp
 fKHoHAHAtOQs6E+uDsDKcQYu09H7JrhJwuA==
X-Received: by 2002:a05:620a:44cb:b0:93c:5dee:f04a with SMTP id
 af79cd13be357-93c5deef177mr825564985a.7.1790522331879; 
 Sun, 27 Sep 2026 08:18:51 -0700 (PDT)
X-Received: by 2002:a05:620a:44cb:b0:93c:5dee:f04a with SMTP id
 af79cd13be357-93c5deef177mr825561485a.7.1790522331428; 
 Sun, 27 Sep 2026 08:18:51 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0018e54fesm58488415e9.4.2026.09.27.08.18.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:18:50 -0700 (PDT)
Message-ID: <70d553f6-1e25-49e7-8c2d-26d441aee3d7@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:18:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 010/101] tcg: Generic expansion of tcg_gen_movi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-11-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ySZpagJC3KhM9KYY0g0ICM_Y85HDww64
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab933dc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ySZpagJC3KhM9KYY0g0ICM_Y85HDww64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfX6gp/M7mGTTM1
 a164Y13xsZSPqJ4w6fXSUNE7bZOPKL/TZu7+CewMoc/2jx0Zy0u6f0jfNALbUrgnYkoV77h6UT7
 OnwXm4A7D01PD1veAh+H01aK6vBbceEjekJSsC0c5v5uVI8vuXNoiis/9xlKEvJTx1s+tHgZzZQ
 8dLA5kaYTlew+KTGDlYE6uXvKc/f7SO6oq819/x2LOAq9eWj+aoZCBSYeE/sx2rmB8usPu1DIQz
 AZUzWuEYqJ4eZ1CLopahaNjZb1w50b3SiNFVcbqYgqbGYQ0LvEF8T5Z1VX/fY/7eMu/qxklG299
 KHDRgSkGSbjhQ2vboERWp4/iTQiLNWCrFkzfmRdPCRUrI6w82BEwSwewI3fMWiWK+DTd8BcZVee
 wv3twqcvGzTWi09at0i4p1ugIB/ANycgt4wpWEvSvQ1CJA5hvC8QPocypbuPkXkwBbwdRBYREUM
 KZasAL88ltHzofbqdqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MCBTYWx0ZWRfX95iMARGfnCVQ
 GmrK9LKl9MyFS1iA7ykN/YO3ywSAddBsqYViydb8rWM05k/xQq1ffhFaaR54sn+5up9iqgvpkUL
 g+imLuS6oOAtpMoOfXVSDrghc1pY9sM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270060
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

On 27/9/26 10:58, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-op-common.h  |  2 --
>   include/tcg/tcg-op-def.h.inc |  1 +
>   tcg/tcg-op.c                 | 15 +++++----------
>   3 files changed, 6 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

