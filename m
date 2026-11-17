Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D59606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kF4vPrrC;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JFbsgE9a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOKk-0003JS-Ar; Tue, 17 Nov 2026 13:55:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOKi-0003I1-PY
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:55:08 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xTOKg-00025A-Pk
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 13:55:08 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHFR2UH3503890
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w4wKIyqOUthFRwdfMwzcpGk2y43jMohhvAkby51d+WM=; b=kF4vPrrCNWs6XMdw
 COsx5L2gweSUNKjj2g6AJddspGcmora/1NKvqXzH4FThtUXlF08drzpsmFvSwYLf
 AMmCJ4chwHtA/LnkOTtPl8eX9+T8HPmZxL0vnILL+ha0PYd5Or0oBK1FEl54ZK1h
 H2GMYtn+rHYdXLHybw3ozO5i6iDI/MXHIQ+T2clpBMio3bsdeDZs/9FFF0mcn8Yz
 9sc08NBrRTFeBE/Sn8hHaQVKVSzgR1lnc2lOxXh530y4diz+j/WcRl/l+k2H1CQw
 hS25mBSJ2f6buUVBczYCA13kvpjguvMuCDD1+5JbY593n7kwR+nLN/0X84tjHXVN
 1yX5XA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0mv127nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 18:55:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f26dd2165so48450885a.3
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 10:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794941704; x=1795546504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w4wKIyqOUthFRwdfMwzcpGk2y43jMohhvAkby51d+WM=;
 b=JFbsgE9aBzzyAFkBylJRiNL84LoWFAs8DTFtbFWBNBrJwiW63ssqLd9mMGfWVgRG7q
 L411pAL226F54fi6aRQ0jVp/jkggtmmmUxeO7Wm/645mDVXYbV64m4rzHZ8KVJun6FJq
 kOIYNaPjVDxmkri+PFjX99NeCKzMkmtG9Yv4IppZblqMcrL+Eq2bBL51g4/TUdfTyJJH
 /kSH4RMaKq4Y5P4wOm5EDw+LS+FwoyklvMXLPQhkKi/0i9t2/J/AA9o2U2B4BdOEjqwX
 hx4M66xuD+98tR5IYCBZqQjzerYfeBjbpUwvvuVYg63Z30owMSfVvEHGzAqAegTjozML
 L1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794941704; x=1795546504;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4wKIyqOUthFRwdfMwzcpGk2y43jMohhvAkby51d+WM=;
 b=054zy93AN6It3UoLjTV1Xl+lqjtWk3ahkNDY0iPqeG553v8tEiUo2kBMEzRMLrY5ec
 VLoN8apospVXITb1M1A6LXaEh6dixP4IhsphDEDSYacnocUmaewEwqvSV5efJyuq78jL
 Q/g+sSSw3X8v/9pM98CjjBhu5qobNg0erw5XmMZqotbTYDxxBXKTYYLhPOTo1va92wX7
 y9ZUzm4pYMG6MrEGVx4yuVjVH29Z8Bx/fZAkCGzPlGPnhIjjyi9XaUvug0GZuY2swG19
 ZJmWygOgtDUpNgz5byBu6bJ3OThyMLXxwI2dJT+HVvyO4GsHIe2i3UnQr5v9R1YDUgf7
 8Fkg==
X-Forwarded-Encrypted: i=1;
 AL+hErFLpmz8LCfzGBhwb0GpnjrsQYot84xIKDw/wVb1F19nZFRKn0dlCYPBV9PqfcUQ+z4+egv+uutRZW1/@nongnu.org
X-Gm-Message-State: APuU4Z+IKUnteIspSTWp8bIn/+NB22CKSQtOkEw2caITxBjaQ2VovDuC
 CdzJokMSJKxEFGJrK83HhlrO93oy32wzJ9QKEuEo9pbbninXAmSgq6DbfJZMXSzyZ7656qNtMPe
 UPffPThlpnUs6MHGgl5iS8I760yo3S47fhNB/uYKhZggC2YGOI2eMYPcBzw==
X-Gm-Gg: AYBFou3A+77A8SilrzUABnSHtv/1dVzB0UnPftTy+rV+WAw46MW6Lt8PqK6aGuC6/n3
 MjHdPQ6CwCKIPslN+5Db+FMGfAY7UmoSYmjXLxuGfnBBYwmIlUmCVYpV4W4t2w1V5Q3/SgWgmvq
 ditgFfQtmmE3qGYdOqn1pKzCWopAUOz15iGiU3bY+NQukeCC1QfNtxo3/SVcyBKjfXUKHLKPgR6
 pPptrBndEQRCWE4XRHoVv1nvocaVMzmHzI9pKIpofpCEaqz3Lt3aCiUro+JV16GSSo23svzLjtn
 YhwFmMnqAZOtsii16fwCnKDRbhTOLbd7dD7nY+jmLcNh9rNaqoyvheBUt4Rhq7MCWrKHi9JsbO2
 db9fKQN2k1ugVpxig7eLBiN9va1GJUpXOCyb37+XirgGYnu4Sn47YvlWxFVs0HI9Nj04Y+dQvUK
 HGnXptw6UgzytsEYHDvPYT+xuhX28m7QHPHYlPjw==
X-Received: by 2002:a05:620a:284f:b0:93e:c12c:fbba with SMTP id
 af79cd13be357-9499962e6eamr82106085a.71.1794941703773; 
 Tue, 17 Nov 2026 10:55:03 -0800 (PST)
X-Received: by 2002:a05:620a:284f:b0:93e:c12c:fbba with SMTP id
 af79cd13be357-9499962e6eamr82100385a.71.1794941702889; 
 Tue, 17 Nov 2026 10:55:02 -0800 (PST)
Received: from [10.222.168.147] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494da53030sm1146663385a.35.2026.11.17.10.55.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 10:55:02 -0800 (PST)
Message-ID: <00d24457-7597-4e84-accb-2ac348616eb5@oss.qualcomm.com>
Date: Tue, 17 Nov 2026 12:55:01 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] target/hexagon: probe scalar packet memory in slot
 priority order
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20261117183629.2002840-1-marco.liebel@oss.qualcomm.com>
 <20261117183629.2002840-12-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261117183629.2002840-12-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: skzeA8YIhZ1e-Aqts8PYbh42VNSRuOXz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX3E4T7LKvTP/m
 E1LgKJqkVI8jRX14MdxG0MDEfhj7D8DgjNN/uRzuVabCdN+euZI/GEojhO8x71lSyDbINLB6+Wy
 6OGhZ5Gq65Vum2w8NDcXy2jWbSd7ID4=
X-Proofpoint-ORIG-GUID: skzeA8YIhZ1e-Aqts8PYbh42VNSRuOXz
X-Authority-Analysis: v=2.4 cv=Cuwq4X4D c=1 sm=1 tr=0 ts=6afca308 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=x73u1wceA7cg3wlgrH4A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA3NSBTYWx0ZWRfX9dPFQua6IaLN
 G6jpKFaHycurgHW2OArvVVSv1+ibXc6FwvjaiM9SnGTeIvRRXvThUBeWIgH3hKj9WafN03PREmP
 q/O7rDWeHBN5tWE6HYJitGCf2As6yrfkMvOSoILqeGzdOsVHEbl9apcLaNTZzwdp0iAK/6KtAbc
 ZKTBwQLtRa36gJJ2B9mwNLwjgqlUbGdd9BsyUiwJWeZxfSB2L1CzUgSmvJgLytURsJSFSjay4BJ
 imv0GoB7otqGQn4POgMtlhj2O+A2aGUnu1xomHFzyAD+Ey2Bf1LtWo8nbYqHsqB1Lgc8ISiVNMZ
 8c00s3KyxMZsVRwcMLs9l+WpCIJX8MKlbRaAy7Pz3kPe+ZAwIPplXgjEHbiwZ/2WM5iFfrTF3lG
 XaEa3a7dfW7lPDrqO4whoGuqhO3SnLloMxbzYts9+5dkOOhsLQzGOVz5EtiSj3GrlxAMoJ0wauw
 V9R/lsKMtUO6yi8gi7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170075
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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


On 11/17/2026 12:36 PM, Marco Liebel wrote:
> Probe slot 1 before slot 0 without committing either access. A slot 1
> store miss must win over a slot 0 load miss in a mem_noshuf packet.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/helper.h    |  1 +
>   target/hexagon/op_helper.c | 18 ++++++++++++++++++
>   target/hexagon/translate.c |  2 ++
>   3 files changed, 21 insertions(+)
>
> diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
> index ccd55e385d..32d71d84b5 100644
> --- a/target/hexagon/helper.h
> +++ b/target/hexagon/helper.h
> @@ -25,6 +25,7 @@ DEF_HELPER_1(commit_hvx_stores, void, env)
>   #ifndef CONFIG_USER_ONLY
>   DEF_HELPER_3(hmx_check_address, void, env, i32, i32)
>   DEF_HELPER_5(log_mem_address, void, env, i32, i32, i32, i32)
> +DEF_HELPER_2(probe_packet_mem, void, env, i32)
>   #endif
>   DEF_HELPER_FLAGS_4(fcircadd, TCG_CALL_NO_RWG_SE, s32, s32, s32, s32, s32)
>   DEF_HELPER_FLAGS_1(fbrev, TCG_CALL_NO_RWG_SE, i32, i32)
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index af7e9c3de4..0814a32fa3 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -66,6 +66,24 @@ void HELPER(log_mem_address)(CPUHexagonState *env, uint32_t va,
>       env->mem_access_store[slot] = store;
>   }
>   
> +void HELPER(probe_packet_mem)(CPUHexagonState *env, uint32_t mmu_idx)
> +{
> +    uintptr_t ra = GETPC();
> +
> +    for (int slot = 1; slot >= 0; slot--) {
> +        if (env->mem_access_valid & (1U << slot)) {
> +            env->mem_slot = slot;
> +            if (env->mem_access_store[slot]) {
> +                probe_write(env, env->mem_access_va[slot],
> +                            env->mem_access_size[slot], mmu_idx, ra);
> +            } else {
> +                probe_read(env, env->mem_access_va[slot],
> +                           env->mem_access_size[slot], mmu_idx, ra);
> +            }
> +        }
> +    }
> +}
> +
>   void HELPER(hmx_check_address)(CPUHexagonState *env, uint32_t va, uint32_t pc)
>   {
>       HexagonCPU *cpu = env_archcpu(env);
> diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
> index 137fe60ca8..130e1be8ed 100644
> --- a/target/hexagon/translate.c
> +++ b/target/hexagon/translate.c
> @@ -1021,6 +1021,8 @@ static void gen_insn(DisasContext *ctx)
>                   }
>               }
>               ctx->insn = saved;
> +            gen_helper_probe_packet_mem(tcg_env,
> +                                        tcg_constant_i32(ctx->mem_idx));
>               ctx->mem_addresses_generated = true;
>           }

IIUC this is an unconditional helper call for all instructions? 
Hopefully we can find a way to leverage what we know at translation time 
to mitigate the need for this call.


>           tcg_gen_st_i32(tcg_constant_i32(ctx->insn->slot), tcg_env,

