Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE73606A31F
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nu/Y51/f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D23lCNP/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNEIm-00041U-BJ; Sat, 31 Oct 2026 14:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNEIJ-000404-4S
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 14:59:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xNEIG-0001dB-JJ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 14:59:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VGUD6L3220215
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:59:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aUUSuJ/CMSWVWk4MHFVd4V5rrcVMm1hKJ/KpWDOScdU=; b=nu/Y51/fQPEJMaVH
 Su3dCtdZyinNjpUywG7xGB4GOc231zojBOYkfpiavDDRZr++jrU2FbF06+unW/zw
 9Z4u/UYjMW4AiCEjktNkuCLlkohu3wqZptMa9VvoL31j4Jo2J1D1oTxJyN/Ux7Gc
 yBfuPNkhxyMl2+o0U6p/5rrZAgekyiE7mCCTWK1AbFrf9WGy7wezOSmLqWs0dOol
 S60KZ26Y5Zkejc1k5CUPxUwO2Z+IZo7pZRmEDw9+XaR2pSfvjosQ5YU0NdkBgVxd
 DuB+UeLo6yChmCTGs7QkrzD7tAdBoSMCpaAnf3IW+83OxPauDjsmDQTZv0CkTMrA
 kb0JQw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn7wxhw9r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:59:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-532f343a55bso30723851cf.3
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 11:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793473146; x=1794077946; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aUUSuJ/CMSWVWk4MHFVd4V5rrcVMm1hKJ/KpWDOScdU=;
 b=D23lCNP/a7UNhIYMToGMt6lqyXH1JyMgbvOu4G/+wha0fcaBT1bsYzccELduZRK/Gi
 lK2S5fcZxrPxENm0o1c4hIStNoxKHw7UGDDyNVeRJ3pAR31Jj+bHLT346QucqDtkltyl
 rWNAORrG8GEGGUmoVK2N+LrLJomRb2Ceifi+qGofLDB5TUcNxvR5ccMAHdq7WR3QCM27
 hkHhXxzc1C0fwrrCvoQ1LisDzsn2H1eJHCOhF5evH5EQUYo2DeZxLIQWaXAG4Mf84eBp
 XzNDCG8+owpOgrUsV0cMTAVldbucOVvzGWroJQlXkQvp/ZePt0JkscMvnRTVH3mVaroF
 YGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473146; x=1794077946;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aUUSuJ/CMSWVWk4MHFVd4V5rrcVMm1hKJ/KpWDOScdU=;
 b=YTut+n7sj36ZvEpf44RbwvOFw/nZY2RNLZkETVnOtOUhVlUE0fogp8k4WLE9FqIn7I
 D4fhmbzoBTjZZZoMZFBO4xOpP+l3DbSVIsr7UbdlodjrbTQr160y+hLi5SDpuDtbmxiH
 KhwH0hqq1xpMHJwBQEO49ieoqRBsPNODBtsVxAPhmjCkxjvXf/PaTxfTDJpFOVjblt8J
 CpKPad8Olc6JTBc7aVQ6SqNUpTgFIBqKV64uHO3SmdtyA7wUcDXOPfG4gxLvjtAheus8
 Vu5cwMa3WExNWzocrq+vBLIkc9Z3h91a2bRZV1P56fvx19W/LEwIU+OmUXMLz4Eu8H2m
 JXjw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzNOnRZsFcUaWpknD5wY7WpQBtAO/WP4swaJj+V8oyvON+i1F65kmWubhen/Nn4CTKfdyoODnPDWqRU@nongnu.org
X-Gm-Message-State: AFq9FYLYgxveIBlt2HHmlB/YQPMuZ4BO9Ajywfoy2JdpEwcXqM2LjhYz
 Vp+cPAaH/fnI2KCJ1zV+oBcg+8hwdNm1SXytJr809Lr3J1wINuiN2CkPXZSGGZeOhR51WOzvI73
 p/4vM6nsP42DS7vKZBHkJQEPdLE2Dx/MZCXwedlU2Fmh8IMZzuJPBW7SjAg==
X-Gm-Gg: AYBFou1cmFof/trqzxY/jg/4UIYLo22lxIcrw5FGTlFC3yiHuspfRV9rANgCP+1wVXG
 dMf5BEkPDRA9vM/oyRonQJrqEXzgngdpCjuieHcMZSk9Yguw1/qUhpGOBum7YTyXqyS58rx546u
 eu11QKh1G/n0kibuICsPbc5xE5YjbN/sdpBk4sB8tgE03eMFOqPxjTHJ1Nn5+h49w+o8S4J152i
 If0fy/x3s/XQELwwQd+tvUGO8W06F3qqmxl9w30k2r8W2HDBet+1jB7ltJzLN+/eU1aMuNljO+9
 1LY5NA+0QswUky3nMULVZyhx0hGs5iGrMpJ1OkSBJfTa6lk7haH6EtJ/2BXu4xvifbKJIPOmxz3
 il+P3m+El2TVHjiiEmbnTWblzZzVUBTEDpUcFe0yFz2B1jSu+4zpoDKBaWwr4sfdEfttIDgo6Fl
 hOhHZO8awaWw==
X-Received: by 2002:a05:622a:488b:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-542b704b995mr97094181cf.40.1793473145979; 
 Sat, 31 Oct 2026 11:59:05 -0700 (PDT)
X-Received: by 2002:a05:622a:488b:b0:535:157b:ea22 with SMTP id
 d75a77b69052e-542b704b995mr97093851cf.40.1793473145399; 
 Sat, 31 Oct 2026 11:59:05 -0700 (PDT)
Received: from [192.168.68.102] ([152.234.122.251])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-54312a56289sm43798741cf.22.2026.10.31.11.59.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 11:59:04 -0700 (PDT)
Message-ID: <f88f9867-69b6-4efa-a5bc-9cb8cb9afc37@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 15:59:00 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] target/riscv: do not raise the no-PMP-rule access
 fault from mret
To: tewaro <tewaro@theorem.dev>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, disclosures@theorem.dev, tewaro@tewaro.org
References: <cover.1793217528.git.tewaro@theorem.dev>
 <fbeadd5b2fe5ccfd20b52dbccd4e5856f215ede0.1793217528.git.tewaro@theorem.dev>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fbeadd5b2fe5ccfd20b52dbccd4e5856f215ede0.1793217528.git.tewaro@theorem.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: YDFyn-JCAT-_xr2yVLyn04RwDHLKSU7a
X-Proofpoint-ORIG-GUID: YDFyn-JCAT-_xr2yVLyn04RwDHLKSU7a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA3NSBTYWx0ZWRfX9xuKj2dXfSd0
 z1XUCt7rkOzXIJBW0wSGlCx4R++LV1m3JJX3Wrtnt7rZ0JwHkCPl/kMqQCm70ppawRVbkjB7E9a
 wuT1W0OIg5z5mIMM+Gm/UomazRIjLXY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA3NSBTYWx0ZWRfX3pYuO4oJRe2Q
 /Mp4bngM/ieFXVGMjXiZsgC2f/4N2jbq59yxvwpFfmkpnCuLMa0DhSQm94F1uwdzUertuOkVo4g
 pyzFfJwwf+F/HPdvUmUKfzLGk9S7NPdxd9WUN6Xo/dwYB/FJ44bjnLtEeI79B4WPTxxTImTqxOJ
 xGDlXQM+HBIj+EgFh0cKtDEB7mBZ55dMLPAeihmYBxlZwQQIa0REZfsp/G1kMptgFcj251frB6E
 7/i4udXJLXHv+Fns3FOCRrGwZkiKeevBrBdrzqj1iBpl97r3Ul8Da5iBqo5CoUqAzPRvltW0zM3
 +jOUqJF3156Nx4IoEfUVwnNkMInI1xpvWueiKXJ9pbJD5bs9hxHIH1JVLQywa3Va6WvdLuClSyD
 4DDq5jfDRWZS6uVKE79OC26wGn7ZRD++iETnzlW5yDzLOK/JajRu80V+Yk0WvyVRgnO5j8m1B21
 dB+0Ncx4StXZZWDCbwg==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6ae63a7a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QOY8BskYDu05dfarAz2gNQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=xvfqbYfxAAAA:20 a=p0WdMEafAAAA:8 a=4DrwxvsbF9mSuPFYZSoA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310075
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/28/2026 5:01 PM, tewaro wrote:
> Consider a CPU that implements PMP but has no PMP entry configured.
> If M-mode executes mret with MPP set to S or U, QEMU raises an
> instruction access fault on the mret. The trap is taken in M-mode,
> with mepc pointing at the mret, mtval zero and MPP equal to M.
> 
> The spec says the mret succeeds and the first S/U-mode fetch fails
> [1][2]. The trap should therefore be taken from S/U-mode, with mepc
> and mtval equal to the mret target [3][4] and MPP equal to S/U [5].
> 
> The early check in check_ret_from_m_mode() is what moves the fault
> onto the mret. Without it, the fetch at the target misses the TB and
> TLB caches, which are keyed by privilege level, and reaches
> pmp_hart_has_privs_default() through riscv_cpu_tlb_fill(). That
> function already denies S/U-mode when no rule matches. Nothing
> executes between the privilege switch and that fetch, so no other
> behaviour changes.
> 
> As it stands, S/U-mode can never be entered on such a configuration,
> and a handler that steps mepc past the apparent fault resumes in
> M-mode at the S-mode entry point (GitLab issue #2074).
> 
> The check was added by commit d102f19a208 alongside the pmp.c change
> that makes the no-rule path M-mode-only, and I believe it was already
> redundant then. Building v6.0.0 and v7.2.0 with only the check removed
> confirms the fetch faults as expected. Later commits (0fbb5d2d3c9,
> 4c48aad1, 3157a553, 16aa7771) changed its gating, cause and location
> but not the normal path. Remove it and the now unused prev_priv
> parameter.
> 
> The bug was found and debugged with the help of Claude (Anthropic),
> used as a research and debugging aid; the patch was written by hand.
> 
> [1] Privileged ISA v1.12, 3.7.1 "Physical Memory Protection CSRs",
>      Priority and Matching Logic
> [2] Privileged ISA v1.12, 3.3.2 "Trap-Return Instructions"
> [3] Privileged ISA v1.12, 3.1.14 "Machine Exception Program Counter"
> [4] Privileged ISA v1.12, 3.1.16 "Machine Trap Value Register"
> [5] Privileged ISA v1.12, 3.1.6.1 "Privilege and Global
>      Interrupt-Enable Stack in mstatus register"
> 
> Privileged ISA v1.12 (ratified, 2021-12-03):
> https://github.com/riscv/riscv-isa-manual/releases/tag/Priv-v1.12
> Current source, same wording:
> https://github.com/riscv/riscv-isa-manual/blob/4877e41a/src/priv/machine.adoc
> 
> Fixes: d102f19a2085 ("target/riscv/pmp: Raise exception if no PMP entry is configured")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2074

The code LGTM but I don't think this is the right bug.  This points to:

"riscv64 cannot use the mret instruction to jump to the address corresponding to s mode"

A bug that is currently close as non-reproducible since Jan 2024.


Thanks,
Daniel

> Signed-off-by: tewaro <tewaro@theorem.dev>
> ---
> v2: rebased onto current master; no change.
> 
>   target/riscv/tcg/op_helper.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
> index f9c79fe6b9..e46190079a 100644
> --- a/target/riscv/tcg/op_helper.c
> +++ b/target/riscv/tcg/op_helper.c
> @@ -388,7 +388,6 @@ target_ulong HELPER(sret)(CPURISCVState *env)
>   }
>   
>   static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
> -                                  privilege_mode_t prev_priv,
>                                     uintptr_t ra)
>   {
>       if (!(env->priv >= PRV_M)) {
> @@ -400,11 +399,6 @@ static void check_ret_from_m_mode(CPURISCVState *env, target_ulong retpc,
>                                       env->misa_ext) && (retpc & 0x3)) {
>           riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, ra);
>       }
> -
> -    if (riscv_cpu_cfg(env)->pmp &&
> -        !pmp_get_num_rules(env) && (prev_priv != PRV_M)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ACCESS_FAULT, ra);
> -    }
>   }
>   static target_ulong ssdbltrp_mxret(CPURISCVState *env, target_ulong mstatus,
>                                      privilege_mode_t prev_priv,
> @@ -430,7 +424,7 @@ target_ulong HELPER(mret)(CPURISCVState *env)
>       privilege_mode_t prev_priv = get_field(mstatus, MSTATUS_MPP);
>       uintptr_t ra = GETPC();
>   
> -    check_ret_from_m_mode(env, retpc, prev_priv, ra);
> +    check_ret_from_m_mode(env, retpc, ra);
>   
>       bool prev_virt = !!(get_field(env->mstatus, MSTATUS_MPV) &&
>                        (prev_priv != PRV_M));
> @@ -548,7 +542,7 @@ target_ulong HELPER(mnret)(CPURISCVState *env)
>       bool prev_virt;
>       uintptr_t ra = GETPC();
>   
> -    check_ret_from_m_mode(env, retpc, prev_priv, ra);
> +    check_ret_from_m_mode(env, retpc, ra);
>   
>       prev_virt = !!(get_field(env->mnstatus, MNSTATUS_MNPV) &&
>                   (prev_priv != PRV_M));


