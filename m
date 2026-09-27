Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63157C98332
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 15:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqqx-0002BA-Lh; Sun, 27 Sep 2026 11:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqqr-0002AB-Vs
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:31:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqqq-000282-3d
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 11:31:41 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QH02EX880291
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:31:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=; b=YYX/742qVB072ZAA
 fBNyhRSWDVck4xmKe353U3Grhvk9RYnVV1K/snirvYR8LjtUywtXiYkBnqrf6K1j
 N0w8vz/er2yPbc8N1Xe3Jx7gqKU1v5dI5e2PrPoViQIYDMf+0dXlqRbnqjijOpuQ
 ufQYkHjNt2E4B9scU5YW6YxZu4rEc4hvfB7MeD1axq6DKcXPONquJVCrEtvP1gs1
 H9Z2CUliK/HrqrYfP4si0rZouy13TvPWZBDPIBEkBFbYMreaZEBCqZzB7aflwpAq
 dgBFFPnW5nAvb2cgi4oNGCU9Vz1AEoPFWEnhOvp/HDeRSD2TZt+UK3/FpNWFbKTj
 gmpIcg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwb7rb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 15:31:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934956beec8so511903385a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 08:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790523098; x=1791127898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=idstpHh8KOF+sUdJ1iEnmG5FO943lAjT7T3ooiqUZjIHCLVFzYetwKtb36iaEJO+LI
 IaiNNKcTs0dkVJTK1sQK39Iculkqg7LcnXZEHBGMChprZrqesEiAu2dec6PfgpAo6K/+
 9HeJ9CDf33weqsrby2/lsipvi+Zy6scXsTzRanpYAYefegDlYx1Qrfg08+4QLRoeOpZN
 WMz9Agh4mVemSYpNrp2eTgZyMf0SxW9Q+LGdbSRLA8Sz0WGkMHf2OHVJR2E6GMs1RPl/
 YP22wjkCFSDzKObXacnJ2WSuZTLdzJAglaNP06BbISgcOnP38iwKJvRpknJTMgv4+SIc
 G/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790523098; x=1791127898;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TGkphUfTf4gqeXFby5SwhdtvaQle+0klGjtrxplR6z0=;
 b=PC1faGV5DtI9KtRipuBkyKctRSeIj5yHIxOmqRSePZWy+C7JGO/ADWYhciJ8ncC80D
 sQmfHtJ7PW748ht+pfTwKLCpHEUsGpBxtRvpck+r4Gd8WAVDYffcwiCRF0Y5EUGMfmQ9
 1hXJKG/pbPRQ7JnUyF5uF7ooMUM/W+O0W/jfBT7gAcwHt2C76fwmieMSn+3H+c7sKgZi
 Z+pF9qBXC3P0AG1/6vrL9axQGJk3H6CW49Bk+WJQurSfLNWvbtkT6BKe2vaVmUt+4muj
 9v8spOAgD/qbqRwuWIYX4l7ZhTlWYsOJvtpUVrZQFiLWhjFPn0GuMwi3Q43e3kjJTscT
 6RhQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwJEH2npI5sqjrPd/9dUTySz1gk8HoZJZq6T+m8tLi7bQNdraD6xejOhhfRy/DoLXqH6fhG/agRiaxU@nongnu.org
X-Gm-Message-State: AFuF++mVFRj6W3NsW/D8cpX7KKpS/2ohGJ/ZmQkOw7d6F7SL127nM0jp
 QUZwiqHLKfgS8c+/pR+cGn0hTwBguBH25+wXmfhVNVPhzrhlHddZwJeIga5cPMwCOJB41jNeeaM
 oJ+qT9hhtzMD9VZeI09FUq3in4ibG25KKNOItZRQaMABjtx4x2xCDmeTQICbCB5c3AA==
X-Gm-Gg: AYBFou1R2nAP9EeV3XafITEpMUmUlFhaUDmy/hmrNNi2i3nLcwIpRklGDHutyXWHGVN
 bFNq6Zpc3vbYVYrfYnyUWz95uBGoJiKg9wBxUEHEfuvmnMPAZ/Tn+iaS1U5BF0I0Gbe7ic65Zfo
 wQBSF1Bfv0bVk0jpq7ZzeoqjLycE6F/f4b4EdvL4z4CHwoV02PfEeXdjnjC+uRodtKPuAU4DR3I
 X7A7/FKYO/ZUPATFP63h2mbMzya3lTrdKeb7ZXrkf6GOPLFlupSAZ4NDCgwlgC9eINdefRQGZzl
 ZrOIgquih4rYRK9AzQEyEsw889cNquqi8PE6JAPYLvNLFXtuupEz7DM+eM+esoHS1KVyjhy3K79
 CkLGcnPsnIR2a0DlmrJcvNRs38KU4+v5ndQ==
X-Received: by 2002:a05:620a:4045:b0:93a:12eb:b62b with SMTP id
 af79cd13be357-93c43bc49c6mr1608758285a.20.1790523098199; 
 Sun, 27 Sep 2026 08:31:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:93a:12eb:b62b with SMTP id
 af79cd13be357-93c43bc49c6mr1608754385a.20.1790523097803; 
 Sun, 27 Sep 2026 08:31:37 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001904513sm96286695e9.10.2026.09.27.08.31.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 08:31:37 -0700 (PDT)
Message-ID: <30c8606a-30e9-4445-9206-1ab13ae94e8e@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 17:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 015/101] tcg: Generic expansion of tcg_gen_subi_*
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _VfuIQO30XQolSEaR0xE2bl_ivGc8szc
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab936db cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: _VfuIQO30XQolSEaR0xE2bl_ivGc8szc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfX0dKYV2XunPCa
 0B4Tj1Z1tODTA7RsyJ0NvWylx83ccYCXQYZXGRFXQe0no1GazEAidpC4br3XIHQuBb5V/4/rdEi
 v+zoolGm9ZfD8Aem3yWbaAAZE3VzStUzlt58+ToQt6iwqEiyGz2z2bhi0fIzpVLmEbuipmRykiN
 WNvPpqWAz3ZUkXyxsjREctiA61wcPGE1H5gRZZZcLw5CZ7nbvH88jH768ZJAk6zbrFu9qaoGqCO
 dK5ygbAYxfYeg4/PAbx3f4xZeUJyb0rLH3M7ROoXuwpyX8kowYRK1kLKNO6jDiRi8UL1QxDj2yJ
 cizDb9K6kBNCPXJqZOzJsOLtoWZQv4oW1VLNHWGA8gSItdKDIKnWRgpyeb5s323Yk7QoATYwJPw
 JRDzQyrPBgRZrspE5+oF3SzEeCxg71b22HpeUUVcbrK3J7zb+j2e6SmIRGiB/btAKv93885RUgm
 i3WDsBgCM8oe11typAw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA2MSBTYWx0ZWRfXxKLMTJeKdelb
 vNfzSIeBcsR57gAi36BhHolIazX/57C5V3o7p1QFhW9AhS1bfeoBURwa7iwOk2LT8vgODXc4BF0
 cehdA0IzpKeoBET0HVbun61f5x4gArI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270061
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

