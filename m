Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46412C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 14:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAqD5-0002PS-AY; Sun, 27 Sep 2026 10:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqD3-0002Oz-QE
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:50:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAqD2-0005iU-4i
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 10:50:33 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxUY84013973
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iKL8ijzJRFSu1LUIjvaQXbxkSxFVl88MGe1KV/qrAC4=; b=PqW6WETkGtWmV6GX
 tpa5VKMnpE30rXu4Zmaqsz7M1FInpPxwy04YbKLbSY/sOOooZlWUSmnARQi4Js3N
 K8qENPA+ESm98v3WSDvz9+wfBdQ95x8wl745/nB/9fRZg+hYzz61OUBGSwlnzyRd
 DnP9jMVS4sUiZjqUioPO9X0lPkKcIR6aPaQJYjejqgUVbVsG+8x2teBBCCOsJWaY
 mR2EtXkI55u1mk7e1JaC3W/rRQr8RbzkGPbJlbcwnEOgn7p6S9YJp4d/P7vdkJ2B
 lj7J4dmWpNRMGyMK19CRXNcpmDF0Mr52zcedx2SkCOTUkEvVAtWP9AFNvozK3MRu
 DM8IIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6tek208-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 14:50:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a01d1d1b6so420563585a.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790520629; x=1791125429; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=iKL8ijzJRFSu1LUIjvaQXbxkSxFVl88MGe1KV/qrAC4=;
 b=EovgEbOqR56KxMEueAsMUCyCv7MbqbYu2lC3hRT6u2RYHp2bfMDXTpnn813cXsEGS9
 O4NwOZvaDsO/g3B5KuSq/dbg0k6zXU+e5h/plwgH3oJd68BmKcSTM0C5EjPhF5T6WAhX
 eNu1KPeKni0s/kwtf/MQLwaiHXRRu/+eqp2Can25/dnip4gwCjwAULA/2kKRHjbrwaLh
 LyuVlJftI84hmsngtZvd65UL7dBLqx+XlWHqYqaxZeoR2mfYlcLuSMjqnfJMREYDier0
 0vuaotHecB2votUKEV/CTNw+JawkRvjfICoW1HjGX2/gcrpdjDbt9X7XSBb5CCmnlC5y
 euxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790520629; x=1791125429;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iKL8ijzJRFSu1LUIjvaQXbxkSxFVl88MGe1KV/qrAC4=;
 b=Z9QBfievKuOlCIZBeh6lxBHEJqrOmHrSVUhaBj6DZJahVPSpE5x20OyHKYZhNvjNUp
 DbRrgnYBHFCSsOmKEA/e14232h1lcdligaJSQaM7XlU8cwRxBzY+ZQBrG+eG5G8GtmM7
 yB3Oe0ba6T4YtxGI3qDIpFFIHJFEwGbns25SjXLMK9N5b496oxFn5qKGPh5g2WyYUXX/
 H5A2MYJGqaSPk/cbl5DEZPvroSCDxije/YBtYtqwQ4eRmZCNis5cBk9MlCzla7ZAsw5v
 R2Cz17Lc7p1Txu3rIgHJJJx7ZlMEMbTT50ZRJaLz2NVlt89b5Z5iWwEHuHY1H6gKlT3S
 dAOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcgY1RuAb2noUDzGZATTHSsMKiogZ3sFdgca7qOZiRfwXba7puNr3MePCFO+ikrGfa/MCjVZwerkmT@nongnu.org
X-Gm-Message-State: AFuF++nWFJlDIODgLxQJVYyvnzqo8Yucr8gaXW8xWsDCKF0Y4dbOf4Q+
 gn9WX2mWUMY2a3hB4V8z/rRLCLaw9NDkuYawWlbGhCWKqbmvjyudUVbgD75KHBD5BpksR0h39Lf
 ixE7h7kPcEhVwV2EQeSW/cflkz8PqR/OwP2J0bLt57jg42wleAt7z7UlvlV9B61yrTQ==
X-Gm-Gg: AYBFou1sNIvHDfsk9xfRTgWkFOZWHVoFWm2zWoKjA35eqUX8VRSo5qytgsfBKWh5ekn
 J/OQx5NN47d5CmlwPLPc8tqMtWHTTRwXOCSZDyA5ULADJUlEFJtFPqv6nZ7bxruDZADxVlKtqEZ
 GTTHfXVjQkd3OpIQ2P3pgQ6TCvUs5ubFdxe0HWGPnwrFPw/Ukk3xqaK8/y68AuKFP4DS1w96jAY
 kq5YL72zkxTB1QqdRSxrOW+qLMgkrvqJS0lhD1NvSwYw0JbLz0fEed6mrC99in+4Y0tX8jcht0J
 hzspZfjabr3nKQq/d6mC/k5l2qs+pGCPD9PCNXHB497xKfkbdjAcwSDtGg46xIKS2/hiCxsCzeA
 AsgCUt1vXl25oeB5qmxo8Kz3deTVBlYabQQ==
X-Received: by 2002:a05:620a:4544:b0:93c:1bc8:c5fb with SMTP id
 af79cd13be357-93c43d4225cmr1492273085a.58.1790520628906; 
 Sun, 27 Sep 2026 07:50:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4544:b0:93c:1bc8:c5fb with SMTP id
 af79cd13be357-93c43d4225cmr1492270785a.58.1790520628489; 
 Sun, 27 Sep 2026 07:50:28 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017998dbsm97549205e9.14.2026.09.27.07.50.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Sep 2026 07:50:27 -0700 (PDT)
Message-ID: <8bf7fa28-d735-406e-882f-7b87d5e7e42c@oss.qualcomm.com>
Date: Sun, 27 Sep 2026 16:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 004/101] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260927090011.10724-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX/UnEb8tNwGw2
 5en2ylp4jXIlBTF/LNlzgObb+CHms5rR/CWjFVeuGYqlRgJfd9mxbpfaNK6yB6JclPaG18YDGpC
 bWcbtKPmknVdPClskW0RLv03/tb9AiuIvyGFa/iW+fkmavW7ab4tWFTTAT3/LEIG6n/9hbfq6VS
 MGhXHIG6FNNPBpVg6sXoGuSQrfwGNT5pUe+k1xzWs/ZTNdTkvNpmSw3rwV3ZZ5v5YsRWZXrrjLJ
 BPUCySBziqz5ulVblzkhxYcDzwv19PstYqckmyp23rW5KM99rDyTnzmpyTKnnONWDlcMBNShzA5
 RjUV3OPYbl665UriCqoOXC6mCl0DTw0n0/tlEr+i5dKc1IL5wxtdiG7TAea4i2ly+WjLPwn53WW
 m9y2u1cXC31+f5Sj+C4x5cwvcd9G7oK5Za9e45ZlACVJBmGEwHvZx6Qq7fmoW/HiVH4QNYqoUxi
 4/DFvt6tXHW7jI7L1Vg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDA1OSBTYWx0ZWRfX1Gheev0cc4Xf
 ZpYDLn1VaZvKmsv5Adwjb+9MB4LqyUej4wlWqkN7VuFFEmxhslftU3jO5ocQ/YKULUtWNUturxC
 RRL3QVE20DqoRsZld98NaN3HSu8KsGQ=
X-Proofpoint-ORIG-GUID: 4iAU4XE0-vHefHmo28xQZhH2AjZHaDTq
X-Authority-Analysis: v=2.4 cv=X9LHu2Te c=1 sm=1 tr=0 ts=6ab92d35 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=NFOGd7dJGGMPyQGDc5-O:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 4iAU4XE0-vHefHmo28xQZhH2AjZHaDTq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270059
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
>   include/tcg/tcg-op-mem.h | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

