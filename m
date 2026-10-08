Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CB5CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEwzq-0008Mk-Dh; Thu, 08 Oct 2026 18:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEwzk-0008MW-Nx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 18:53:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEwzh-000296-KH
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 18:53:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L05MB2976862
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 22:53:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Y3qFp+zMDqc3cIrvPsKuxCQUpQzdM8TmoPVWdL2yG4=; b=N96+qhttmdk2dsLQ
 imuWezNrWHgZeqGWS3aAi7zPKC5Ah3WZ5m74zIzf6ftEqTx1EPLI5qIb+GKABcBz
 VpfhvaLuba4o5kFuWhgORwFq0eO/KQF2FnInmUrRpLehFedEYxwKTlF3lYZRNNRP
 BV5FGv8XxzhnCQJSaiD1y6vwqOOxUe6Cb6cna9AjI7AVXXudVIJDJ26hYDkOvaix
 vy1JSqojZHm/y9neAo7un0aAqGmOB9a3/zR9q9zgru44akfxgVmeXELRMouUraYP
 3yioYKF2U54bog1TICHORSNz70FHkR9ieKlTv2xF/JKHFeWvAh5mySGadt8weNgL
 h8JKrQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxu0xsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 22:53:41 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso10923914eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 15:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791500021; x=1792104821; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Y3qFp+zMDqc3cIrvPsKuxCQUpQzdM8TmoPVWdL2yG4=;
 b=QIqeb4PePXKTMTGSxIGNVwzI7fQpBZ8nxQn0K1w3a9okFmDFPxCppX/lsyZt+CxzVH
 zSg+imD0m41tArGnVICVIysEy5nBweYtM5J3gBUuDXNH4szLiC+0HgK6NWAjeVRGC9n+
 mc9ze6/LbKwbuNtxXbaE8V/K5NksBz0Ky7kfzXcbw1sqCIC5zxhU6P60Pfkak4w+bJ1R
 uxdJVw26y8P1izQwM84RZn6t+SKaBm6k7Lyl/mgKfCvdSj3UBUckwZQ8puFyj0IHvsH4
 bf/q8vuKKUvnywj80YPKIDFLhIinhPIhzeMH5Ohi/4LVJ1FRPJQMn3FUCz1MDzAOvh8E
 xWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791500021; x=1792104821;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Y3qFp+zMDqc3cIrvPsKuxCQUpQzdM8TmoPVWdL2yG4=;
 b=vWaTlOiwjXSS34JVOGh7LBi+OIEwupBTv5Xpw504/nYjjJy7Tno7B/2InFXERUNBjd
 BsWrW1QQZ6vVPXeoDDdpHFybMCduFi1E+G1+0lW150RnR151scqUjbF2aXVXlxO5wue6
 n6v975/vqzwJzJq/lI3vrB8DBBz3xB/QhupP6Trxa6LLXObKkwXpqyhIZUKOtCEAfQiH
 aTLPs8K20J5nfJQMnGJSUO+pD97gKzJYe4HCOnvBK+fZaXgcO5kFGkY3i0+snQaxTh0f
 YA/37d96WDFtBudCTHSBg6OpgNnVd612irvVvOIOoBmokt6RP9ra/LrLRDj2joeMGIRo
 VQ7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByHSbc5Tzr3bmqXlBFnldLQf1qfzaZL7kuqRn2ZRtwCwFz393eq4t2ewyh/b1ywDO0MDa8AoMceFIC+@nongnu.org
X-Gm-Message-State: AFq9FYLrzq+vm0wEuO2Q04O4izGD8Vd9kTMAZxoSZ2ymOxlS5H1OHYug
 NW2PhufsTD9OT8rceApp9uIFwPq6npJaS+vXW9PKO1kGvKKsQMxISTYU8cFWCrUTlHGPqEtiVDq
 0DVo/pHH5uC/xnf/0/7TmRjRFu3VsUIo7gGnE/rjhis8EDHLUGhANEAfW+A==
X-Gm-Gg: AYBFou0gRxQCP6dktcQOwW9CqCQApUgZqloTRyHsevvybUpB11bMOItgV4hc12wdh0/
 tSg2NVEd+ePmMDPhkElLjeJ83OAW3lRmOSfTnIw90XDjayaK0CS1feIW2Xu3rbnPteBT4A9249Q
 XQXLkgvF23rGRH+Z85xNAW+6dcJttoFvaBRSLB+Gu1y8//H0u58qejSKYK2EZFnHavpZRTIqaD+
 89QzZoaG+WgRuf2O9AiWXlABKjCzYyy/9d+SouJsSU86x31LA49k/FIvrGwCgv1AFWfCUViUxo8
 cLJ67ulZaVOQ4d89Vf+cMf0VHnhz04ddPZ6ijMUnfC+9Ugtsxoq3XDZ6pPFEzTjC3ba95VxrfMV
 5LZYAj5RgzAKT9JQ3WTAktdfUL85bsThiozrXZsT3xF7xuDvDLiP67arhmRMtYQ7OHFjQYQ==
X-Received: by 2002:a05:7300:cd91:b0:351:dbc:b663 with SMTP id
 5a478bee46e88-3537e13248cmr491077eec.31.1791500020699; 
 Thu, 08 Oct 2026 15:53:40 -0700 (PDT)
X-Received: by 2002:a05:7300:cd91:b0:351:dbc:b663 with SMTP id
 5a478bee46e88-3537e13248cmr491039eec.31.1791500020064; 
 Thu, 08 Oct 2026 15:53:40 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537ca1b556sm1372222eec.9.2026.10.08.15.53.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 15:53:39 -0700 (PDT)
Message-ID: <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 15:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
 <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX8Sa6kmnoCybC
 DxbIsPIgMhy7XfOUj7YxDmSKBDxKGXf1SIaZ7JU8lCyE0BXe8sO0xX2nSY+ZI/iB7iGWjA8IzDv
 0eYKDZe8Zrh/xKP5ncMyekjx/nIjtd31NHm7YqMVWUuD2GEH0BIF2PWLMDCuSvOZDn+xTkL8Qyq
 q6T3F8yg23chzDPGiijqQ/5BHioEzz3HVzwGJqRPoWV8db9SV+zm/yNP+1eNpk1x2WP4AO/vsQq
 rE09r1xr6hPVOKh/fqTw3RLDUcfA98QdlcKM31VMvEzi9czxdAZ8tKeoRYvEVwLXsXg1BrU55Gn
 5ntAD9imQ5UTIInHnld9ktPqjfEUJ5CUdPRuI5RHdmj4N56JaS08IYqtPu2V8SNE5bfumYs53ij
 TD88+S5DZCFcT0hXyi3x9f0wYFMtFG/WL4hD/2rGiBVmR2HgAC9RQodBJbIKN5dcUEghBAwpWfR
 JTcjwSA0/6sUtnDr2VQ==
X-Authority-Analysis: v=2.4 cv=QbjzLcbv c=1 sm=1 tr=0 ts=6ac81ef5 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=FqUiBRMJaK9R2m1BEpEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: UxrM_vSeDjL4V00oswaR9cGxq7bBsPHS
X-Proofpoint-ORIG-GUID: UxrM_vSeDjL4V00oswaR9cGxq7bBsPHS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MSBTYWx0ZWRfX4JSd16FSLDPd
 TgZx8mUJVswu0hvQbMR9YuSuhdpN19RyF4An5OHxg2Poum0VmbFaCeqsZ6I9yXN0rk9H01LjYbh
 ha66FvcrWAO+oELeQD9wC0rE5p36wTk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080091
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

On 10/8/2026 3:26 PM, Philippe Mathieu-Daudé wrote:
> Hi Brian,
> 
> On 8/10/26 23:10, Brian Cain wrote:
>> Hand the k0lock/tlblock lock implementation functions the packet PC as a
>> constant instead of relying on next_PC's opcode-dependent staging.
>>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/hex_mmu.h    |  2 +-
>>   target/hexagon/sys_macros.h |  4 ++--
>>   target/hexagon/hex_mmu.c    | 16 +++++++++-------
>>   target/hexagon/op_helper.c  | 16 +++++++++-------
>>   4 files changed, 21 insertions(+), 17 deletions(-)
>>
> 
>> -extern void hex_tlb_lock(CPUHexagonState *env);
>> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
> 
>> -void hex_tlb_lock(CPUHexagonState *env)
>> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
> 
>> -static void hex_k0_lock(CPUHexagonState *env)
>> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
> 
> Please do not re-introduce more target_ulong uses.
> 
> @next_PC was converted from target_ulong to uint32_t in commit
> 613653e500c ("Hexagon Remove next_PC from runtime state").

That's ideally "cleaner", but in practice, since hexagon currently has a
single variant (32 bit only), it's not a problem.

In general, for targets having a single variant (only 32 or 64 bit), I'm
not sure we gain anything from chasing down usage of target_*long.

Regards,
Pierrick

