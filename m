Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20807CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 18:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT26x-0008VZ-BU; Fri, 29 May 2026 14:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT26K-0007z8-GF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:38:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wT26I-0001di-4s
 for qemu-devel@nongnu.org; Fri, 29 May 2026 14:38:31 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2WeX313170
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=; b=GW/xRJlM9ZRr/mju
 lIrg/Dv7QgHIWZRVIGCDNsKz7wIG3uAWMkTmjwuesRxWc2K9EvLJEBQ2ICvZlASR
 mTjkRJ5GqDrXLCl4ot+nckUQkLl2s2cH08e18id3kJ2D351iErlfkj16/P8oFXSQ
 U5CUqzAsMJ4OYQppgrygbjny33clo01K/JzsdDEAtvCNTRmZAiQxpS/ZrwQMTypM
 qyrZg19uiwhPt1EAUlAggmZQ1Z4QVgBQbwSkP0kT9MQx10pW+XGaII+4bAjdf7Lg
 kwZ/6mnT1ZejOpRmGhufS4FPspd4OWkrG2yVfGrdbJDwLViM5DKKyBhU+JX76ypK
 xvkl8Q==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m56xb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 18:38:19 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304ea1eea05so2865717eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 11:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780079898; x=1780684698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=;
 b=CXx3okaO67QeNqmUuLS/GJwVmDJw2F7D2I19P982wYf9KJGWx3J8CkefEbOQRTJz1V
 wolCXGUM4SjeEXbOnOa6613UN0/jPvIQWW3Z4C5jwv6hvmaWrVlJtfMbpJHOQ3fbwYEQ
 IGDpK6v05bEUYNiUHCFTKN//NZuuAE6g7wQFFxE39Vpwr37GZhCXFj1PJ+Sl0dCZoro0
 p7eykv0Xl6HXfbMmmqH7duUl5aarE0s0uYY+zBxe5W9QLbmrmiRhHb17rvMGis/WXXN9
 nfOHBSKjFtkepVHsVqUO1devwZzWUmc1Unjj52BCpPlWqvUpwkrYx7wYTnaZtx4jZ/J3
 JpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780079898; x=1780684698;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3zZ7sVCQ0xTCWhIQM453AbNsQTss553nVYj4rAnmItA=;
 b=ewuHiPuAumFG4XxIhR84J3wPdyWoBuzXGjLscn9gv4j07CsgsdkEi2mdpQOsmpPZN4
 Xzm7xy6Bhrey9ETiAkXrao6SNg5ABdIKxXSAQ1sVtPAJWFa1m6ntpLI70603jhbq8531
 d7OSkDl8Hqo+pAzEvDqwysdCE6a4pYfwRARHbX1LUUzIDD3tI1T73Dgiq9lRhjJs4co1
 K/7D6lopJpJJjJWziQaBmfpxt0ZIijc3xUr9bPbb9oOL3cDlCu/MTG5HbQMfyLZcVbJP
 3h5f3fpodRQLUD+9ymFE0lLjtuxNeqcx+KLV+to48HeiBKPFrOVhr49BrAyx+QY98jmZ
 OrHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+rQt4qyJH/25CTVrPZn02DzGeBwPcFsKFI8g3XaY4YoSR2x29BN025rW6XwEdOdoIzm1JDPApPkopF@nongnu.org
X-Gm-Message-State: AOJu0YxHvyj0girarMdQ/ecCldYfAlktC038vn7sI4Gz+cq//CxG5g6R
 6nrLbdDie9pVGVB7eBe99HlYZja4OkeYm4SBEdfbwkyj2JjIuHnvYkOohL/Q6fLFWfmV1/onAoA
 nQoUz0qRBKGChF5Glo7cTENeBWRiNknMEH/qbZPYAEwSXw6QuXlF1k9un8g==
X-Gm-Gg: Acq92OHb1JfPRaDgOU6uvDR6tgTdrdm9gMiFKg5BQRz/iF9qResLhz7ChRNIwiAn5Zn
 jd2tBFs8LjmEwb5pXu4N96B3Szc7ox51GvZzx4ozn3oIzf/sQaQfr5LwKijCM8ZC4us064vb/WI
 QNj6aMSwTh4ihW9a0or4J7Pk5c2QJciV/5CBQmybevcinud5c6sEh3OGZ3wxmO0lEHyyRPDGqJb
 bqQYQZJoJQmwKZapr5B07IRWecLupmkxQfcWmtQMjAzvKx7hNrqmSChMgC0j5q/SHc7tBTuXvBA
 eYDRvThxvlCbJoh8uMYpQd8AkHzHNN5ab+30xO89Q4KpVZtCm2gRvs1QMqzz1shxPTuLmiqOjCw
 +0Gq0+cxYOPvZnM1sV4j3nefOrpHr4HYuVD1hhypF37pX1WTUFBVeFse2RSLJRqJu8WfqGH3071
 j/0ZvF8xjqG/hRTdVlH4Qq3uWK
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id
 5a478bee46e88-304fa5295f3mr502797eec.6.1780079898267; 
 Fri, 29 May 2026 11:38:18 -0700 (PDT)
X-Received: by 2002:a05:7300:e58b:b0:304:d32e:65f9 with SMTP id
 5a478bee46e88-304fa5295f3mr502763eec.6.1780079897797; 
 Fri, 29 May 2026 11:38:17 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed30a012sm2190193eec.10.2026.05.29.11.38.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 11:38:17 -0700 (PDT)
Message-ID: <80e2736d-f1cb-4249-b80a-89856ee17661@oss.qualcomm.com>
Date: Fri, 29 May 2026 11:38:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] accel/tcg: Convert X86 AccelCPUClass ->
 TCGCPUOps::cpu_realize
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Anton Johansson <anjo@rev.ng>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <gaosong@loongson.cn>,
 qemu-riscv@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-ppc@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 kvm@vger.kernel.org, Claudio Fontana <cfontana@suse.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
References: <20260529142434.87880-1-philmd@linaro.org>
 <20260529142434.87880-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529142434.87880-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE4NiBTYWx0ZWRfX4XY4iZIpvMZH
 rrN/CbdEKR3OCC6Khxit36GJ8QHkVARgngqp7uPQX8L5Vp2nIuFFw/gqkbNQtZOoJiORfJvN9ak
 UZkZch47sg7tOpb3s5l2QLqciUr4XplIHSAdACrw7mD6XyqBqrrwfjKHcRDvL7HwYfG9NjqPVOr
 kadwTvJ474R6Enl6S66FDQfgbbRJ9Y0JHVsWBLlEKqfzf1b7xn5otZ7nrN9LRYPArvt9Wb5zkaH
 YzRM4XRIolBu0bl5d4ECRupCY2y0D43e5d0vNGpE4FR6H92xrWvprdRKh7yH8aOkJz2U9YcuNvF
 qzJczLBQ6NpP/rdLRtWUXNQOpOG57GIdl9hlM0fFbNGvUVyl2DCn2Vbi2S+BdP7fxp5zcQ1h7rh
 VFAm6gCCTAX9GxtnnGBlKsgUSviQ8LUjF53nYdrWE21PZziXm3IR4F9XCk8RDviVD7LVc3WE7A/
 MWD+peGADatpp6ySMtA==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a19dd1b cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_zWEW-5a1clIKPNZquMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 9eUSUWFFp5qyVR_HF2TGjghVHPNSBYdj
X-Proofpoint-ORIG-GUID: 9eUSUWFFp5qyVR_HF2TGjghVHPNSBYdj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290186
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

On 5/29/2026 7:24 AM, Philippe Mathieu-Daudé wrote:
> Register AccelCPUClass::cpu_target_realize as x86_tcg_ops::cpu_realize.
> X86's ACCEL_CPU_NAME("tcg") TypeInfo is now empty, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/tcg/tcg-cpu.c | 23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

