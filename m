Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0908BC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ8C-0007PO-5K; Fri, 10 Jul 2026 17:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ8B-0007Op-Bk
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:51:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiJ85-0005z8-Td
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:51:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3VS81714059
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8dxD6J5yAko3ZvjDWBXsFnyOA9q9eVwjuqPJaW0yfCA=; b=bdldFDm2OQhaTOA5
 olw0vS+9oafpGNXYm6crTN2rawua+bNBsRGDjHa8wdm3C0JFLlBRGrBitGgV1gpG
 Fcmj3+T2XNsgaYsWU0s/ErgktWA5piedGxrccV/bOyehcM0O8mb7+grXWdpIXyI6
 x1ihtBLQVgK0j2wjLoJTpKqaNdy/U+dbyZI7hFIdyiFtOF1M4gjqF7nd29/iaw+l
 QVQF+PgnWImJUY/iYHZWB3rcOdjnSaJ+iw4/j8fQcInK0merYLu3qpVuvMOdvvaV
 WIWfLR4WV1w6NZ3MkgVjM8YhBRGwqwNQxSFUpzXgaQx3aYZIYUGrjevWoggVaQir
 cqljjQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339sa4r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:51:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso24843671cf.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720287; x=1784325087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8dxD6J5yAko3ZvjDWBXsFnyOA9q9eVwjuqPJaW0yfCA=;
 b=VBkefUaTNclb9YpyXQyHwuz/KRzdaVjdA7uX26itXcBqCxtb7Lq+PHMQqJIVAVG8Nh
 SJaD9Ps8vKsB2yXq2FyCBKgawbZG71ozcmvwUAsAo1SBzDFMxgBiCQqydoCVTIT2P90F
 kM6t5ZlItuUTvYeC1yv6vmrbN6Mm0aSpeWX9GVB2P1c06XvL6TwVrHb4J1AioahxbPew
 uXun0XPDp4jWXv/KuvPiwW7DuKcj2gaFgNUVyDPJt+MUkhNvz17HLvnAuEV1k/DJ5Q+0
 ul/LsXF40LXaGO2bmnwSdBi0FZ1+2atkaToAvdvbuQL6qe/Ye/ZFtbJFGP8NIp4jJlUL
 tCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720287; x=1784325087;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8dxD6J5yAko3ZvjDWBXsFnyOA9q9eVwjuqPJaW0yfCA=;
 b=hI488W69SxFuc1k8EEAXhd8x4PCdq8BPFPN1ZS41E1xnYnOB2qqQ6b/eO0xsT+pWAO
 aZGUHP48rREv+iHwdg1/33bGr+nD/DRS3S7NvVhB4XutNWgnxWJBPBeQq5+HMTyy9GbH
 2qaFwXFtl8nEHi2N42Q1wby84+4Og65dSMJ/lXMssXBcUaXSZFGkrEQT2mwrSHZj8HpC
 5iJ3VY2TxPZKxkXQzwbBOn9IyVOwkkc+4sKqEqhxEFG6z452VyBnSINxLTEOp2sOgGaw
 cu4TYvswXxAmbC+0WOC5Nd3gKs10Ljb3sb2ULcu1Yo/1P3nIpm6nKdzo0v+igYUuOzWZ
 ZA0g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqRG8qoWjnJ8YtQ0NFbm9p1xCb5Dv059E0cxfj9QQhwiWwVywu5JsLhrIQ2zUIWJNQgbX/FdjND88qi@nongnu.org
X-Gm-Message-State: AOJu0YxkvRVg2rcY5F5Nmh8uTY9CouC2BeQCd1paPZHeWihYxjpggQjL
 FZdvtLSXaXxgV/+CAA8+48yu9jhPAVYt9hTEcbFzT//0GoA77STS1gTZtOyYreedgd6Jl2gjZLo
 kJ9CfOLZtz9gKqPckF5ReJLBFZhG8hnTKEEueFNs+3SDwZAEShOQfXrg91A==
X-Gm-Gg: AfdE7cmxLn8j7EK+qKIt3ff4lnjq4WV1d2HtX9vF5A7UvYUJGwkeleChExE/gJkQGCf
 RVaeIZuAWpx3QHN2BQpIHm3f67uBsE0nMkDMZbuG/fEif4h8fMuv1A0aU/5K/rgGpbsg9blykK6
 cDvbHqZLcYLk4k3EIp+7g6xN8QWANKp3BhGdcyh+huk3KDswSiTy8+ejBKTCiNMaRMMkjpS/APB
 zVyw9K85sCJhuJBHX0SPQ97ZVopo5BuHVF1x0ZxAfKZ4937ugOHbxAqAP5zzI7q0kA48yinpIoV
 bmkOqw1ISEJwyxg5K0+UIHpiFo8eMcsRPFSJ1QAxCEcxOCAjGq14Ad49I+HBoXo9APkaWmJTd/T
 TZUoKLCa+FTeP24ugFBtZaRqLOA+l2ayJi1JQFHSs7fO2sTsjoTD5dKT5m3+1eQ==
X-Received: by 2002:ac8:5808:0:b0:51c:7b12:120d with SMTP id
 d75a77b69052e-51cbf3402b7mr7598201cf.75.1783720287668; 
 Fri, 10 Jul 2026 14:51:27 -0700 (PDT)
X-Received: by 2002:ac8:5808:0:b0:51c:7b12:120d with SMTP id
 d75a77b69052e-51cbf3402b7mr7597991cf.75.1783720287271; 
 Fri, 10 Jul 2026 14:51:27 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6df6d9sm181387215e9.7.2026.07.10.14.51.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 14:51:26 -0700 (PDT)
Message-ID: <02dbbb88-2b9e-4604-a36c-14bcb00e8746@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 23:51:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 16/51] target/arm: Make check_watchpoint_in_range static
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, jcmvbkbc@gmail.com
References: <20260710205401.836304-1-richard.henderson@linaro.org>
 <20260710205401.836304-17-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710205401.836304-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX7vNSwQBWnT4p
 OihqN5PK/eazlehtGxTTKweoOt8rGaQtEx53euraFpSymCYJ32HKmlT1PJKRRl8QbPgJdJdipzw
 ztbHHBmOQcVpxsMwsAYgw5rDoBm+jeo=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a516960 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lg_xICGfZuE_qk3iapQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: NWQ3cmliAALjFMchuemEdCNBSNwVc4Hn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4tpA0YKqFgtX
 rXTdImnLlE6/jOitk1h7fLsdxK/eGXtgay8AJr9e0BY4L3Xim8cu2/1erHwps/FwOd1oPIrDg3q
 539opRcN/2+ft131xK6QuSaRu+K6/f+rbtiEJDf0lwlR+WPVbI+j23cPa8+6Lorn0zk6G2SJkck
 GUfDn4ZsXPd8ttNE6gFgnYws2p0ADbn+N4nxTrFUzuk1ikpZB2FkmE6hu8NhqyJDa6OxdLLapJy
 izzjQ1s/wtgC0MSZO0YQuhS/JxOqXIQH9lhb2+umzJGhR/iZqoFmL2w2oE8mDS5caOVRbgwHtxq
 YDEtMT29ptOsz070MEgmxjpj436KQoVan7EYSdgBTWPwXxIHuU07LRSFq41eRaciiGuPjMcqrll
 EGnKFpTz96Zm9Ue7SsdkDWBZx1VWc48lGj52O24W3USlH5z/S4nsOfC0AD2KKD1nhYRPNPMfpdB
 bIQHOyRHLCMm+7QYA/g==
X-Proofpoint-GUID: NWQ3cmliAALjFMchuemEdCNBSNwVc4Hn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100219
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

On 10/7/26 22:53, Richard Henderson wrote:
> This function is not used outside hyp_gdbstub.c.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/internals.h   | 1 -
>   target/arm/hyp_gdbstub.c | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

