Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C02E606A330
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mtUjyB5T;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B8GzbklA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTS9e-0006gk-Nx; Tue, 17 Nov 2026 17:59:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTS9c-0006gX-Ov
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:59:56 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTS9a-000561-MB
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 17:59:56 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMej6F935097
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:59:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzD55PoGsTfmSC4Lad4gfGg+H9uO8LGrNlCdIZdjF8k=; b=mtUjyB5TVCaaKAox
 lHNxr7bUthTzJ59O1DmkQu5ntJp1kVeKaaAUrVJzX0ZXNXdwMqJ3f6huzry0Oiou
 hZRb0ZSi8JQvEkFO4/MYkYIVg0JWL+igK6YOJKUzOnV8jaUIp2hq7pl8qnn+I0Up
 qAXhtOsHepA+YlOKkuGS/kCCcyYF5fecKBW+aPoVG8DHWFPgX8HW0OEpxlh1hFwd
 bGDiYgDFBvfzKgfvSGvwjRCHy+87GO4r8B607EwwHCu+M6pXQ20eXvQwYxQ3TE6D
 cNprxcTwA76OD8416eRGUhI4vptktU5KfwHzXjl/KB/vfnnGLTp0MUav6jFi/32C
 S21+RQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv902n1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:59:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-94607500fb0so58985885a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 14:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956391; x=1795561191; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qzD55PoGsTfmSC4Lad4gfGg+H9uO8LGrNlCdIZdjF8k=;
 b=B8GzbklA0kFtEy9nrPfv6jY+OzEu7HN7VSrHHYju1cKubmjp9YsHtKtvm+ZSRdrw4v
 mL1Af7ztrVd4SsEVRuGX22Wa8B15fHYFyX/KMWVyjtoC+szcJWS9V9H3KADkZ5w4bCzu
 Wv6tFmEKMz8ZGYIFcE9ta1fS8cxk1rLw4a+EbIX3faTA5fjoW6H/NO5zFIaKF2IAzEFR
 uaozoGiUdQlel44ULe5S1TXIHfbKkddpC713iPcPPTbwfLjt2Acb+3/aZSahHMObDp9/
 i7tHrqKKhwNFYrFm4bs03g6to3J+ZJm8zyi4qg1TczwoxF34LdRSlbq2Bq70lKHtRc5A
 kGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956391; x=1795561191;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qzD55PoGsTfmSC4Lad4gfGg+H9uO8LGrNlCdIZdjF8k=;
 b=WtyKQK/jsEB6NuHbf/dedga/+272eGk/eNQSI8vbHahWrV2zh5zbrHX+Dw24qTp1l2
 icPblRe4eedvJHeUg7dCVaNuCB6UIWMhh1glJGxsPJSOdSZu1qSHH/KzkVJlfi5pI+M/
 CPQqac3V9kKdunG1rH4eAXZospNJJ8onFwSTyXi9aBT7xT12+PWlL5mR2PgVB5wiv8PD
 /vGgleHrctV20bHRlVZxbO8mvZrDvIJkvGw4k8NTp/G8TGW8coPmEWmA64uLNl5RmL63
 s5RLzWoTQVEEcrwJE/vDpU4dE13rk0x6KVq1yzkjQnVJhaKUoEoOyg+YPPprG09ZNyaQ
 UDlA==
X-Forwarded-Encrypted: i=1;
 AL+hErFqz7BzrKfmzg1hobGNiiqYYS8l/TvdJKQRderXDo5g4hkuVFqfL/tXmuqOZN+6onymCs6c+ELx61OH@nongnu.org
X-Gm-Message-State: APuU4Z8InW7LhdApicvoAfStDBIZtLZZw5/WmAjMm++DPXVdUro5lUIo
 DHt27VX4JgTWlYzcUicrhGHbaeh9gl2oafg6PEGiXWSUKwgxKLHgjez/oqDwftR2rdjYT/6KSpq
 O3MJwklqJe/grjjyWVfN+M3Pz+BT8Mew3NnQJkKaCz4EEVeLRRvwQ8OUl8A==
X-Gm-Gg: AYBFou1rhElGuMOcPat5zjdFXZ0vluPZGCdwzlhX/q1b/JiwzsL/FWveVZucmG6Pu1N
 3LhOBrK+oGp/NjZXzXRL43ouFBjwxLB1yrUwg6TW40x++EE3fYD4HiiKQVXhLVc3XHbooD1Mmmr
 ukFnBnJdGElZA6QFrA+wKhd1H+oEgdLrUx2VD9RCOhLHXEZVticyzR2zH1G1jJ8KJ1m9+fOzsxp
 0TwVLunJJSwPqvguL88w6ddEBlrxRkRmkvL6NfHMjRX/5Fkd0yFoi/JREFwMD+S4Dp+4+gK7m2m
 82/OYUERywGKMkFcwQZ/AnvOAhBg9g2rPayf5EUzb14MqP7Em3/w5fa4bD4FAbCjVtZGbjhsvb2
 S/q9tmK05HW2TTwr9oDgoor9iRaqQmevzwIDSK3ELWHyJMZzuMhXMxygi+Li/0YhXqqC9W3tgcH
 ErpEqT+nY=
X-Received: by 2002:a05:620a:1a0e:b0:949:7710:37ef with SMTP id
 af79cd13be357-949995f3a7emr212021985a.61.1794956391057; 
 Tue, 17 Nov 2026 14:59:51 -0800 (PST)
X-Received: by 2002:a05:620a:1a0e:b0:949:7710:37ef with SMTP id
 af79cd13be357-949995f3a7emr212018285a.61.1794956390545; 
 Tue, 17 Nov 2026 14:59:50 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d2ac6e0sm21913285e9.8.2026.11.17.14.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 14:59:49 -0800 (PST)
Message-ID: <8d01f99f-74dd-4cec-b103-cd360944d8a3@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 23:59:48 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/19] target/mips: Don't set forbidden slot on
 never-taken nanoMIPS branches
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-18-philmd@oss.qualcomm.com>
 <4d7da53d-8c5a-4080-9407-a6f4e186e3d1@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <4d7da53d-8c5a-4080-9407-a6f4e186e3d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX/89xipB3lsn3
 QGZMTX3LYuePhEm+argm/j/RCK3c8h6FH5WjiDWFF0srlkQfL4REsLpnVF9u1fxhrMNo7qiFu8h
 x3vt3FDfpbFzRTKWHy9Jn82ZM36xZxU1gzCJoLP6kP9YCWV4tDlppYL8LL8NpGIC3Zw6FauvyLq
 4OPNhPzV5EN4TSTAuA/ZqfJiVz3TCcUubj/lwzEpuW6zWqdXyxoeQ5h2y4vlRe00CqIfVyDME0k
 /MI3nfPSslqWXAfyM+f+npZAPBA81nULsOKjt9Sl3k50CBEFn8xr4OJNbV59tbn0Ade4gSNU6C6
 QoXaCp1YYn3MTL5hLjWUSM71xyXPDYSNdxkZYJX+OosY8BlOe1TeBP74h+mLK/8UDLkhEaa7qr/
 0gDOID9N2ReaqJoQkzqpEyismscWdXDEvKRr+G4t0A6sOt5Uw0YaW+vRxP8EoK1pcItHucyw7XA
 xK4njDpilKrNCGzfN4Q==
X-Proofpoint-GUID: CphmKQoqWALh03pcqTmBV3dZTg5DL5J-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX8+fmaTLqdgtm
 kElgmrqgawQp6Rce9tEgrJAoks4rfMc7/9eifKIxCwru2o5cBNyByTun0QaoU6ZiJoxheQYqiYG
 RX5cB5v3O5xLS/VNL6DB1GhV3BlC3Uo=
X-Authority-Analysis: v=2.4 cv=LuQHWXdc c=1 sm=1 tr=0 ts=6afcdc68 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=qvnYRN0sXtf6bQQIUHMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: CphmKQoqWALh03pcqTmBV3dZTg5DL5J-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 17/11/26 20:26, Richard Henderson wrote:
> On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
>> BNEC (rs == rt), BLTC (rs == rt != 0) and BLTUC (rs == rt) are NOPs,
>> but flagged the next insn as a forbidden slot. A following branch
>> then raised RI, and a fault there got a wrong EPC/Cause.BD. nanoMIPS
>> has neither delay nor forbidden slots (MD01247 p.12), so just fall
>> through.
>>
>> Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit 
>> branch")
>> Fixes: 14668cfaaf4d ("target/mips: Fix emulation of nanoMIPS BNEC[32]")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>> ---
>>   target/mips/tcg/nanomips_translate.c.inc | 18 ++++++------------
>>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> The problem would appear to be elsewhere: Why would 
> gen_compute_branch_nm *ever* set forbidden slot, given that nanomips 
> doesn't have them?

forbidden slots is not set in the branch helpers path but in the
decoder, see for example commit 14668cfaaf4d in the NOP path:

--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4528,7 +4528,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState 
*env, DisasContext *ctx)
              switch (extract32(ctx->opcode, 14, 2)) {
              case NM_BNEC:
                  check_nms(ctx);
-                gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
+                if (rs == rt) {
+                    /* NOP */
+                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
+                } else {
+                    gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
+                }
                  break;

I'll reword for clarity as:

   The decoder NOP special-cases for BNEC/BLTC/BLTUC (rs == rt) set
   MIPS_HFLAG_FBNSLOT, an idiom imported from the R6 compact-branch
   decoder; nanoMIPS has neither delay nor forbidden slots (MD01247
   p.12). With the flag set, the next branch hit gen_branch()'s default
   case and raised RI, wrongly reported with Cause.BD set and EPC at
   the NOP branch (stale hflags snapshotted by save_cpu_state()).

   Fall through instead: no nanoMIPS path sets MIPS_HFLAG_FBNSLOT
   anymore.

> 
> 
> r~
> 
>>
>> diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/ 
>> tcg/nanomips_translate.c.inc
>> index 68e9ca9cdb03..72d72f6f84a0 100644
>> --- a/target/mips/tcg/nanomips_translate.c.inc
>> +++ b/target/mips/tcg/nanomips_translate.c.inc
>> @@ -4370,26 +4370,20 @@ static int 
>> decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
>>               switch (extract32(ctx->opcode, 14, 2)) {
>>               case NM_BNEC:
>>                   check_nms(ctx);
>> -                if (rs == rt) {
>> -                    /* NOP */
>> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
>> -                } else {
>> +                /* rs == rt is never taken: NOP */
>> +                if (rs != rt) {
>>                       gen_compute_branch_nm(ctx, OPC_BNE, 4, rs, rt, s);
>>                   }
>>                   break;
>>               case NM_BLTC:
>> -                if (rs != 0 && rt != 0 && rs == rt) {
>> -                    /* NOP */
>> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
>> -                } else {
>> +                /* rs == rt != 0 is never taken: NOP */
>> +                if (rs == 0 || rt == 0 || rs != rt) {
>>                       gen_compute_compact_branch_nm(ctx, OPC_BLTC, rs, 
>> rt, s);
>>                   }
>>                   break;
>>               case NM_BLTUC:
>> -                if (rs == rt) {
>> -                    /* NOP */
>> -                    ctx->hflags |= MIPS_HFLAG_FBNSLOT;
>> -                } else {
>> +                /* rs == rt is never taken: NOP */
>> +                if (rs != rt) {
>>                       gen_compute_compact_branch_nm(ctx, OPC_BLTUC, 
>> rs, rt, s);
>>                   }
>>                   break;
> 
> 


