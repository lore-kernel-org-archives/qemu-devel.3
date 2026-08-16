Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE4BC5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 09:19:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvX1L-0007B3-PL; Sun, 16 Aug 2026 05:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX1B-00077S-6J
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:19:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvX19-0002Nd-Pt
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 05:19:00 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71fI13319338
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TxJbK1Jx5j1SAJ/XVnxEVC6s/YuoULEmD2jLDkXYyxg=; b=FN+clObHHz71CuOi
 hDOo7HPRP09ySlOlOhh7SCbTCxEqhmSVrNvp1ndk8Z/IBWhpsdw2RkzYmVlTe7Ud
 SD01KG1G6qAIoAtLI3GjMFKEdgFAao4BHKNNpgB9yVmHpVsSF2y9t9hBKKowyBic
 Dh5t+u9HjL2s6kaETdelWaypG4xNPdFd9ts4ynZU/A3nK9lWXjpnQKaG4bCm4teg
 EKNceO4zpGSXYhXQEVmNEZGoR1rehjX8K+MOiexSFEdqVraJ1SQdB9PL+2j+pQrD
 f/rsDxWOLxwEAV0yi+Vz/myLySGdJVL/BlblvuGyNf5KQRyXSHCfHiX0gOuPu+Av
 Gd045A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwk4j2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 09:18:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52ce3c7cb2eso43839491cf.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 02:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786871937; x=1787476737; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TxJbK1Jx5j1SAJ/XVnxEVC6s/YuoULEmD2jLDkXYyxg=;
 b=Kqus/8/vo39rUrhSLm2vWbtHp4fIE/WqKP6gNpFXJnxQLFlsVeb/gBf+bswgHhcTkE
 kaNZDiMUUzrW08UZdnY3rd8aogX5qIv5RQ7AcIoweHA7SgHQKIcEylhg5wagxFOq+CEM
 TIKR8apcT+ynOS1FCAGQ274KMaTVfYyM0UPcpmVPj0BecqCXqIYVYEoK0YEN6ypdPOzh
 V0VUzQ5mETQestlimdD2LBb9Yx5AVhy8p4KWunpAAEGxUv199EvHzpKpR1qPeEeXPJZ3
 qapmOiMqRMHtSfItd6YVizHsNchKpE1UCXtVuwzfAiTcY5hkRzMvmvA5bKwGe+mBoPen
 tzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786871937; x=1787476737;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TxJbK1Jx5j1SAJ/XVnxEVC6s/YuoULEmD2jLDkXYyxg=;
 b=N7ikE0y35m3wKYefLPzJEM9rxzSC0+sV85a+YeNqVQLWoOXPhcZmSHdqpxShJCSFzz
 7AXVBvz3m1Y7TjgPwUKs7D6spiycxmbdciGQc91GjvvNymsEHG0UdKJlPXbiXTSpc9ZG
 1vUtb34wRRycF79jNRy2hX98novANOx2fOfXJo7/Unz9JRN2St/cXrdPV+bUucQoFWK0
 Mf1H//R87AQMyuvqWrfJP6sx/z/O6aM1tZzPgF5kTJgGSecWnEJFxprttw8lpAC9UjH/
 H4pa+ELfFkIP18s2YQsLKuE0n1ZuB6gr8sQOA1/JB0h1+KsN8fHM+afPPLvBPz6R9q81
 K7bw==
X-Forwarded-Encrypted: i=1;
 AHgh+RobX57mkqvQbBQzzsW0NQ21BB9Od/opnL3Zj2I+fsFP7vREm2loEb+mofZF02sEpoDBHmVMY6ktg5VN@nongnu.org
X-Gm-Message-State: AOJu0YzM3T4SigNMb9mkoVwyIoA7Amhv57AXz/5TS/w0QM1gCePXiTp8
 lUze+uX3R7XkYpo8iLvrPkVAMH3FtUk5D22WO57VdP5X2Xk5gKl6v7GhEEilybkm2T8dluMKXCT
 n7NVgEuoBJW4kXV4JWX/21u4knKHXeHTiGd40y9QuLJtPQ4j7xuKcQeBkyA==
X-Gm-Gg: AR+sD13UviJBrLd2b61rbrGMzo+NM4tS5Bvl/zgIglwvYp7uEAQE7lhNbAl5+CP7Ir+
 t85U6hT1LSrHqMOrSXCwW8xxWWjm5Jo6FmZhyA2UOQL8ONlEjy3BypMrsY8BT6EEt7Rarg87325
 gHKpo9emDAEFP593UfMWy2/K/lJ7MST6Pc9ns0Iz1QrSNV/1t0bNqlkS32eJ79z/WmUPnjftis1
 xivXMaDfuk16WLRpI5YDqFLRIHqiYvsM4KvA3Fs/LLqAkX4QP/+d0sPwRu7gEiKUigCt1vzsJLk
 FgxsI9SE4R4Zc97FdVVKG1OgMp5PA8ZfFzEkpMLXvPbbvZ7BkadB7OwJ7UUlBc4NJAIugjxTm4l
 b7aJle8w9TICB+bePfGnFZxHNAd2xv88LAVE=
X-Received: by 2002:a05:622a:14b:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52d8530dbc7mr187279421cf.6.1786871937035; 
 Sun, 16 Aug 2026 02:18:57 -0700 (PDT)
X-Received: by 2002:a05:622a:14b:b0:52b:4e1f:941d with SMTP id
 d75a77b69052e-52d8530dbc7mr187279191cf.6.1786871936690; 
 Sun, 16 Aug 2026 02:18:56 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm45762395e9.2.2026.08.16.02.18.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 02:18:56 -0700 (PDT)
Message-ID: <942483b0-8009-4e23-b192-f36a10b40e1a@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 11:18:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 09/18] accel/tcg: Allow phost to be NULL in
 probe_access_flags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260815203730.1468365-1-richard.henderson@linaro.org>
 <20260815203730.1468365-10-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260815203730.1468365-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yKfTWNZpCwAY360axgUuR83oH8Zteqon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfX+a/7ajV1owRD
 wUvIr3AVLcnr7rwR8t6MBusGhYq4WXNIXsmF3XhRV48KsIIqYQFaUBQdod+88/25qxwan9+9CMH
 V1qEa+LDkEni87Xgr5fEx2axVXQmJ2O9r3cFd5f8aSuWRMAvU23k0l1PzBBK7cv+MfN8o89Lz79
 7fCKyue3Bkk5wHyEUVJW++m6x/5vLta/lPUqcf+lOSe1fi7RmBHsVP749yj/eLydc/VepS1dPPk
 alhKyaUJveXMkmr249L9uTI39qWwcCWKbVQ05WIPkdzqNcgOnDaLuSglKOOznpi4HuyVyC+zYpq
 hv3l3eL+0uJ13j/JmOfHYkdOWCXkNf26iyfEP0vHHxJ42Ah8SwbPowWDiS0KovdIQs87d57qhHP
 t4Glu+eRuyMZDPDWkxe/Dub9ieLLhmGsZQOLLdUXb44NHtovaLsBC73mDHRSwqhz4vg1ieII1fF
 Sjrr5BCU8OdspAMji2Q==
X-Proofpoint-GUID: yKfTWNZpCwAY360axgUuR83oH8Zteqon
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a818082 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2OSBTYWx0ZWRfX8C/2a2FdAqow
 oc9UauVwjsibEoMYu4TrYxVKzEuwhbPKtXfkPlHDAFqZ3GKFv36SOYMoNwMk5TB7Sjq/HeFJll9
 wsHnx4wA7v2QabYAkpEBrgsdFs0AP6E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 15/8/26 22:37, Richard Henderson wrote:
> Do not require the caller to create a dummy variable.
> The one instance so far is riscv check_zicbom_access.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/probe.h    | 3 ++-
>   accel/tcg/cputlb.c           | 4 +++-
>   accel/tcg/user-exec.c        | 5 ++++-
>   target/riscv/tcg/op_helper.c | 3 +--
>   4 files changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

