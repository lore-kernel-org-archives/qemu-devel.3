Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3E7CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 18:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNwwN-0001iQ-KC; Fri, 15 May 2026 14:07:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwwI-0001fw-Fx
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:07:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNwwG-0003wc-TA
 for qemu-devel@nongnu.org; Fri, 15 May 2026 14:07:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBZrIN3795625
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 18:07:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bqC1TyUHZdb9uld5hP14QCgCilOrWHW+MstMLd+yqS8=; b=Ui4j30IDtsAJp/uU
 sHMEHWr6gbQvdwNE8MOBVprt0LUJXXBITOOhboLM2M3+dFCGV2g55Wzkbw1rPB5j
 GCRJhC7+AAT8BEi+EDU2vbn8BLCL4bfdP0zjjKHCuzpepFBxlhI1I2/BwqTtBfWl
 6nxVnsKq0758HmuCcGm5NU4VQmL4g5iBwrrRMU+A+HJJxO/Pd5/d+vIYtum0EloQ
 3KtpU79lOSBhIK7omzw9mGk+cHHXEZwznngAd4EQSn9TmqtAswCYPC+WtL8xXJ+L
 xoaEI+p4guqcwXGTtBCP4r8QP7Rg+yFltkPCR7AY3BFFOjeLoKKVz/EfodB/Yctq
 0LsQ9Q==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1svb36-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 18:07:07 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-135405e4035so244733c88.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 11:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778868426; x=1779473226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bqC1TyUHZdb9uld5hP14QCgCilOrWHW+MstMLd+yqS8=;
 b=jiYUjT1Kt8Fr+nib7iCyOpLnO7EfkcBweW5p6Bq2F19EX5/J1bVzHgzhHEwAvcGS6K
 /SMup2Ktq+UcMMn3GXLvfvN/d4GcX/Xkv1fzbhHCDN0UaYsq1cUvEq9lw3jpJPrx5lZB
 fJzU/Tv66XuDPQEpUy7J3eFLJvJey0XwMB5nHN54uvLhs+zz90gr7gYQFG2LtImmwTHE
 oKN92SXpuW93QkA0PrWdz3aApOO4IAtd7picCCP9ykT7WdPj+qcuc2aJxDP2wH//6Q+g
 23/Z4ggEXPobpTEza4mfWkwH6Op5jjx42sU9TB93G7c8eX5MtnKjNkhaZJ1p7ciC/ysB
 lZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778868426; x=1779473226;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqC1TyUHZdb9uld5hP14QCgCilOrWHW+MstMLd+yqS8=;
 b=IqxCwcVW7Dq6okgD/HYNPY5+MxuKhQb5/8bXYvJUOcxs2YG68jTfc1H3r1rCgNmENK
 q+XxTd36e17gg86h709492uUaugA3qXr+7u6OBBVwbXydcN4igEUi3X9v2a7uIzhxMvL
 kwQuI2fANTzXGzBoDNxNL8qThNPsWoQkUWkxrkucb4+cFxzIFowDpWZsTCs3NjH9lML3
 ttArjZaOdIdJP+X2xRnbPpQ53N5zQbW7VKq95RxARTkm+KZ7r9CTtY5lbGrI0UIhPsmh
 doHzBC5mSMvl0NGr9TBkJEpuZ2F5arjoGU8eG9Hc5KnANhKuKqB/eAHyp25Oj39AWGqI
 BtIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8e3bTBAe1eOUUlPip1HAW5EARTfM2YvdEt2DCFZZOOpVBV1bgZmQ3S00to5EzhiuY3z4rkfrE7HzsM@nongnu.org
X-Gm-Message-State: AOJu0Yy2dSQDs26bJlwY2uRXT9OHNq5dBj140AvrfzJJ2SeM9JvWD4pp
 ZTP3sgzTU2dlb8YRIwA5GWLsU+xXXOrQlrGCdSjxT+v8dPIfxSnJJrxOx0JBN9PUedwON4IR2Il
 Kq6+21ezXFOhzdnOYoOe6UMVdw75CP2B9hs3LjnIOEEYb7uPjNPquxy3rqI2Pxhfk2Fzv
X-Gm-Gg: Acq92OGd6WuO5gPTseQMQghvFRUEjzHDMtDK1LostsZfmfFq/Z+K+JugWejKmf3vAJG
 7+YLLgzxAnmxjnCk3rSy5IC+/Si4cblOSbPVpOPu74jdvjYRVuOt0Bec1hwJHgJpjik4m+rRO7b
 S1K9RLY+MtouWv5/xw9Cj0euafXoOrLniKBZ5ONUNXQooqnJFaVFDqiV2evhGHDWdb9844W4Vas
 jVuG0QIHPvkVxEha0gyQaB0dWVGgmd5SKPeUy3NhOKnYeSZ074MibMun8AwUycP9wu4MMy3VKdf
 dduvQWhCVoRwnaWt3rqGM214MgUQho0bWSLDLFHgGq11XkhJjfl+QUnga2RytzGc7hvrwm7y+XF
 8Up3PyJ+rJOMdUAn46eT1M50WGVKhzxlVMchjnX9nPvqeqi15u/+oQDTfMfLZQuwFEdbvV/XjOe
 hfDhaYff7emlbVoQ==
X-Received: by 2002:a05:7022:220a:b0:12d:de3e:52c1 with SMTP id
 a92af1059eb24-13504a4f603mr2246555c88.37.1778868426217; 
 Fri, 15 May 2026 11:07:06 -0700 (PDT)
X-Received: by 2002:a05:7022:220a:b0:12d:de3e:52c1 with SMTP id
 a92af1059eb24-13504a4f603mr2246536c88.37.1778868425579; 
 Fri, 15 May 2026 11:07:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cbcb9ef5sm10245525c88.2.2026.05.15.11.07.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 11:07:05 -0700 (PDT)
Message-ID: <2b16b9cc-d419-4880-af60-b68eb4dec8ad@oss.qualcomm.com>
Date: Fri, 15 May 2026 11:07:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 27/27] target/riscv: Fix pmp.h/cpu.h circular inclusion
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, philmd@linaro.org, alistair.francis@wdc.com
References: <20260515180437.23620-1-anjo@rev.ng>
 <20260515180437.23620-28-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260515180437.23620-28-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE4NCBTYWx0ZWRfX7+nac1HG5Ush
 SNsV8ww/ocvlH7m0iXftY8UC/wi4CcjCmiNIEGhqLrh5qb93cqJqiqQ2CCdoKc2CAkidu8i5YHw
 Gkrvl/1BOooNVSip7cvWgu28HKKilTYyLBy4408yf2PnqFIlxPO0bJNe0LUV/vtTX6o3kkEK2L1
 6XymAJ8gDR5B3WcqIQF1K5XVsiO7+Wraasvl9yxPDsgAwE+/pSrMq7EtDte+J2ROSllKXDBhZvf
 5JeMRnRSY+FLzEtq34ldw1Dcq/MnUGMKVktvcVOeFzNUBlFJLFacHhjV6Dtpb6I1I1MpSFHzhJ7
 VFyGS0DaYzOV4ui76ItWS+HyyU71iYsTuOiF3IyNFhzfMptL4URgYD1knNcQmUF7s4e/14l18xG
 SmmwVbpmQtSUu4XLT4CSPOqtOFSusaoRMtcP2IUoKinx0tGCRwh4qq444q/1B8t8D2QqUHOSbee
 Ksoi4bccc8PjSz77u2A==
X-Authority-Analysis: v=2.4 cv=cZXiaHDM c=1 sm=1 tr=0 ts=6a0760cb cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=UfBB4S7XuDFzcQH3b88A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: DU66okD5ZJzvU7seZVQ7wXCxso8W-d11
X-Proofpoint-ORIG-GUID: DU66okD5ZJzvU7seZVQ7wXCxso8W-d11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150184
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 11:04 AM, Anton Johansson via qemu development wrote:
> pmp.h is only needed and included for system mode, however relevant
> macros (MAX_RISCV_PMPS, OLD_MAX_RISCV_PMPS, MIN_RISCV_PMP_GRANULARITY)
> are required unconditionally by cpu.c, and so are defined in cpu.h.
> pmp.h then defines pmp_table_t depending on these macros and so requires
> cpu.h, and cpu.h in turn uses pmp_table_t resulting in circular
> inclusion.
> 
> Move PMP macros to pmp.h and only exose PMP properties in system mode.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/cpu.h | 4 ----
>  target/riscv/pmp.h | 4 +++-
>  target/riscv/cpu.c | 6 ++++++
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

