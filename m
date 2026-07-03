Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB278C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:46:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbPD-0006fp-1d; Fri, 03 Jul 2026 06:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbPB-0006eZ-5V
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:45:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfbP9-0007HN-Lx
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:45:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6636h0IC3144253
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ixg0UDTQ9MH5JgOTydO1TghSvE1eY1eUxTdbt14+/Ks=; b=pKjYFDkUswnD/VQ0
 JJQt3GSphNqYJhOOW1s6vv1MovD6KKFcVUdVL5YB5Cw05L2EpaCwOXXTvGXmYggK
 nTHmc/L/n37ebD9UxHGPvQ2zuNHWEI6rqkAeurS5QZNKZdBuUZrydErWgP2IH2Un
 VEj6KaTfKKg84Dnz/MP1O0hsl9rcQSQfRzOrN1+JLSJ4xaWMf85UXgLA/TWZ+JrP
 My0pmtODOI2nwqgGgIxN+msmN0emP896+wTZvdiTMAMajkWvINyy1EDZVdCgKjxH
 W5VQJfLAnNWXibIwv3THSoHkBTyH0tNLS2H4jDOrGE0s2rLar/5V1+wVK6rhvkjA
 /RboLw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f682brvgt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 10:45:53 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92e73fc29bfso67572085a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783075553; x=1783680353; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ixg0UDTQ9MH5JgOTydO1TghSvE1eY1eUxTdbt14+/Ks=;
 b=dumr17+kcFuSNrp1Bk2iWQ+5jq62YM4DViorwR8dMII3tp/Adcb//QbF+uSc1zB3//
 KHuJaqP+/QgGTX1/2l6OcVH2/PgTOw+Ahwi+8WqQgi9aq0YsIhhYlSZEQv4L6v4sDwyv
 b24+hvl31mz9Dg3VjjSJ/ILB7+NM2JrO8/GW9ibKr0epJKCwbJG1nEKSq92fnY8Nlt5m
 3onaBZDilNOWXFrBWhC1oHGmvyXHwsSYHrgkVeWmfAF0yVRl0gMTvUN2V/ViGx8fH3uW
 fTF4IhXLsmFaizFBOAgJK2okNDU9IJsT96oYR9lWFUKLAWKDvAwu+8sgN9VzTormHLJ2
 2Vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075553; x=1783680353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ixg0UDTQ9MH5JgOTydO1TghSvE1eY1eUxTdbt14+/Ks=;
 b=MkyMhNTw1E05YfN4ehCa7O2g3nHCTmkEKWDvwepp8ehrjOWNkJ+PJHATMl3AtdekTX
 zejor/YMW8fVM1hkUh/7sXiEabkmV9/MqdE17KRrURF4zBPeQSCWjqoPENA0+7WzZhcO
 V/sXlZkk6EX5ZiTmYy/9sVgT++uPHVho/b+0S94l7Px2DbzkwJTKD3PP2+YWsltqMHaV
 UTxejudEgGXy3uCXiw6xBjNaGinrU+SAmR0LqJJylHv1lmV7L+iR1rbQdomElC/QjT7l
 SuU1+co8GNnw4KnRDF2KlkVjUnZIifBQYx+NrNN6BzIo3BRtvZZtLORQXKG3Z7gRxbrb
 1tPg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9BQCt7IKlpKsolRWtgIZlzu0sGWtCbkztw+mmd335g3nzLKSHizgzX1+bw40+GJEDLY1H1Apjaei/c@nongnu.org
X-Gm-Message-State: AOJu0YyeJNHXNQ8M3bL1f7uIDv7v4dByB6snlBvWlkzgBdp+OcrxkvlK
 j3rrcXQSkYkiORNbbqIhhSnJiFT/MHRxPg8NYeM4NYV2wM/N6NgaIzbKgiUNLxqbP+AsZDzivCF
 jAaAzFuxx2B7nzc5Opjq37dCmPw3Cm3QO8s8j9AXVKV1BRP1CPG4qx9rWNA==
X-Gm-Gg: AfdE7ckrunDeXSJH5w7B7tuy/VcIdGq4UUmrvstQmM+devcyaZht1eyP6PE7LEnLE9G
 61Qqgse5orP7nR9phO7tDr25E0tVJF98G/IhaiSnQBGcuEoGGktt7ZTlNc0pHvtTJwgccQCY1U0
 S7C5SGfborfBIxSLqi5fiXlq5Yyc7bkll83pVIH6GxnlgL0O24eFnOiJBOGiyhL6fBxXlwDXyq0
 N77yC7AWYBqGv3n3mFNRGsJy4WuR6ZWugQ9LUbXPU0wWTUSaRS9w8l3pR1E41o0kSvgX2QpRxBq
 6tD4DhWa/d729Hn4Rvjx5hW0vVhivzi72m2+u+ZLP30PA/QlEb4pWKeZmCsZHtRi/O4S31+Oidz
 bU8ujqGZ/N9pDqoLPd8QkG/WFC3d++xaACBIwNH6zDZN3dz0V7yoMJTbfnFqmaA==
X-Received: by 2002:a05:620a:808c:b0:920:fa37:f249 with SMTP id
 af79cd13be357-92e78254b55mr1388144485a.22.1783075552992; 
 Fri, 03 Jul 2026 03:45:52 -0700 (PDT)
X-Received: by 2002:a05:620a:808c:b0:920:fa37:f249 with SMTP id
 af79cd13be357-92e78254b55mr1388140385a.22.1783075552556; 
 Fri, 03 Jul 2026 03:45:52 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bf11eba5sm133964855e9.0.2026.07.03.03.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jul 2026 03:45:51 -0700 (PDT)
Message-ID: <1a8929a2-9adc-4b98-92e3-9544ed4d6506@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 12:45:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/24] target/riscv: tidy up riscv_sysemu_ops
Content-Language: en-US
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
 <20260702135128.1188021-6-daniel.barboza@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702135128.1188021-6-daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfX5FseEH/uSAXK
 IWTCZ7gGKL5PGv0cn/prleFS8PBeYcbSYE+XpcLzbTqNLRGxDCccH0Bb8ef1QD7ihjHHPrGLbjc
 yIcUVpupXDRhaawlKTBFy3KsW9cIqUttxDDXtG1tWPVgGhdDAv+NVACV3rwVFCFM4XQsiYiP3Rh
 DItgvFNnFWcYPJwieer8HYIrytEeqKcCvhFcYWAK9xFi0DDRVxcnWkbegC2WcqhR66t4Cw3YW8i
 tAG/1R1WabjbjkL1hfICp0v0W59prpaYmxJ+juXRUbxA2dZcwk4wCVHJvbyNPy8yrq6OCCwya/b
 2HiKfVm4KylEX94P8rqO//TcVWIcp+12mJk77a+Ey+xYcnKjGmuFk1vzw0Mqx6J4o1bqXu424UO
 QTY/NtYcszycF3Tn5VjeBlYLpKe3RMTT6F8d2BslQy3Dvyo2p871SpnO4jBKg1LVBVVrvr4HkSU
 JLXQ/e3t3vRkK3i8jYw==
X-Proofpoint-ORIG-GUID: Tl-5mdl4yKbL-EXv9XB7uFADkt8WV1o0
X-Authority-Analysis: v=2.4 cv=cc3iaHDM c=1 sm=1 tr=0 ts=6a4792e1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=kyii6vYQG7FJyop5uQkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEwNCBTYWx0ZWRfXy2lmAwKCIE31
 kcNcQdIL2vZtzB/gY5QWVTh6Fc/b1uzt/E8bZPmNnMtUvcFQjJSXwK/8tkxPw0fqbOuuLcMhNB1
 xpprbEAyF5A8CK+SShiWhnW6mam3Xpw=
X-Proofpoint-GUID: Tl-5mdl4yKbL-EXv9XB7uFADkt8WV1o0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030104
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

On 2/7/26 15:51, Daniel Henrique Barboza wrote:
> monitor_get_register at this moment has a TCG exclusive implementation
> for RISC-V, even though the callback is supposed to be arch independent.
> Until we address how KVM is going to implement it we need to filter it out
> in cpu.c.v

"v"

> Same goes for get_phys_addr_debug - it has a TCG only implementation and
> KVM can't use it for now.  It would also need to be filtered out, but
> since we're at it, let's convert it to the newer 'translate_for_debug'
> API too.  Same restrictions apply.

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/cpu.c            |  6 ++++--
>   target/riscv/cpu.h            |  3 ++-
>   target/riscv/monitor.c        |  2 ++
>   target/riscv/tcg/cpu_helper.c | 14 ++++++++++----
>   4 files changed, 18 insertions(+), 7 deletions(-)

