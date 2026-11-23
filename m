Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87A606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lCBeAue9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Lc5YttpP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVUHd-0003hV-JK; Mon, 23 Nov 2026 08:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUHU-0003gC-48
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:40:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVUHS-0003DF-GW
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 08:40:27 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANDL2JD2086083
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:40:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SinndvNwezGQAzNIgYWl11ssfbpESHAdAhjKdgnj19I=; b=lCBeAue91EHuUN/d
 kpTUtXlgW7cWdbLMzsizQppyFHWazP43a18hxtrwzg/PHKVVcOs9m/4ngLH7MWsa
 DulLYPcf5Nb7lcWvZ06rJNWNNR2SaccHDpW7L/e0y6qLJpwSoHiDx17c0JJfNs3Q
 PFZeVF3U2TgdVFI1YYGRsWzUPdrQeveIKT6txgFEFQmVMngxjkYf3jtNjQDnCvQ7
 qlf/XjoPk9yPwNn3P909pt0s2zrVV3HpQdQQc5sm1OSQe+xYhB4mlAD09hisV0+/
 gVzo+05T5lQOMSdxJ5bevM4YPENraw2NMwI2YR/BSzBbeoNqiG8f8SYwwoULa/MJ
 t4jbRA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01kvg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 13:40:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso389666485a.2
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 05:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795441223; x=1796046023; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SinndvNwezGQAzNIgYWl11ssfbpESHAdAhjKdgnj19I=;
 b=Lc5YttpPCX6/UOKV9rKbVVtQnhv/0BBS6Pr+Pu+fXeLOhQ0xjQTz8d+z7HvkY2DhvL
 NLxkUE6sYyjRBVyZJAqg5cbmNPsf+8RLekWOUq/zILd5lNJ7zzfzRD0N90+/j0NEz5iw
 Dwgh+WWihLSORxFv2CGdiltQva2MNqE32l6DRHDEXyutAR15zCTRNTFVtuKlaQMUc4bt
 vu32RWwwasai65vWCxst5/iiawPPcdQA3BYxDqLvaqhkyGV+hRS6Hn/nTwgaJEU1vy//
 D/2ITghUYr+s4whNyUo0kISyxyFsuY1jpM/MBlwAz60P9QwAt52IAJx1vqmi7Mc+iuYu
 jaZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795441223; x=1796046023;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SinndvNwezGQAzNIgYWl11ssfbpESHAdAhjKdgnj19I=;
 b=ONnuDmgtJXG5oGK1+j8Hr/4Db1E8ai4JrdiWfbEkNMMUgRu0STnn9ldf3u58cxING8
 A7aNlPLm8Y3xHROfDykbj0sOvhMqu32QJ8oQsVOdJ00EYBFWmraYXVP4mvDBw36sRksV
 r+lpp93L/9EAofdOfUfm4jgHYOHV2t16ka6RY6sH4izXKj34MyGV1rsdzgDJUadfI8H8
 xtvrXoVeGWXgwZdrAZddrF7H9jDMHE2ASyjWJgu/IQwkDC3jhNsbthqH3vOoDFlJgH0J
 GohSX7AWM3nIZ/xoxhXHwMw9ITwFP45EevFegDkCZ3UY+as8i4UbewLloDM+2PL/Y0Ov
 BfzQ==
X-Forwarded-Encrypted: i=1;
 AL+hErETkdP/AhAkXArCGY7dQt1lxwq9cpB2hxxvXHBVchSde1yWUiGinjp9ZpKshas1TyczLKeWsGquHhCc@nongnu.org
X-Gm-Message-State: APuU4Z+HDbe2tzRyYeKuptrycrPuTeSzC1ysXhA93ZIKwR5CHxa6hg/k
 COMNgR1WhRvSN/gCjlldqhBYVp4ywTt6ppSYHX8xHJw47W24I+LpP4x1z6mAhWI1XegnSvknt4p
 i1pI1Bk3rVplCqDDEjIiGvLXcidBz3bavCeW4nfuDkfOw9ZRqUNA3fnu9kw==
X-Gm-Gg: AZFdTZf6Z6GqTC3evP9/9mjRGVrnoN9tOXUGqpzXw2N1s7WgRPsxlqwBjAlX5uumq9v
 qn305l6ZQYabDmpFeub2pMBsJp82i8Cncg0elpujjlHT6rf2sBWIZsp5CnNABQWJL8LUACrMzV9
 b9NXjddbssbQC5aGkV4HfU1dmVgQxc7aKSh2NdQQPCvGaZSXdfp+NdrJZawBpdshN925lQKUZzf
 CNqaEBci6JCE4cnPYQyEAdTEW/TQxcXXbR0vaY8rvifKvZ69OChNQTf3xY3O/IF0JPuukJvE1Gb
 E5QyljJY1q/zmkB1j5zjkEV8GIt/XNsIkmsmi9Yx19KOYlGXkzwWt1+4Xbtx2dLzaqM8ojkr3Ce
 3GJpr4WAN4FGKw3aDlTO59lf/35ygMV+y4I0kDG0JFJ8ShGII6Li5UoNRF0zjNcE5OYZJb7mrRX
 G/Q6H8Jgkd
X-Received: by 2002:a05:620a:4608:b0:949:710e:2cdb with SMTP id
 af79cd13be357-949bab27025mr2004416085a.69.1795441217639; 
 Mon, 23 Nov 2026 05:40:17 -0800 (PST)
X-Received: by 2002:a05:620a:4608:b0:949:710e:2cdb with SMTP id
 af79cd13be357-949bab27025mr2004407785a.69.1795441216865; 
 Mon, 23 Nov 2026 05:40:16 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb34ac11sm809421385a.14.2026.11.23.05.40.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 05:40:16 -0800 (PST)
Message-ID: <fb83b108-b9ee-463a-af25-931a2d8014fd@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:40:13 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] target/riscv: Keep tdata CSRs available for
 disabled slots
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org
References: <20261113084622.738278-1-himanshu.chauhan@oss.qualcomm.com>
 <20261113084622.738278-2-himanshu.chauhan@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261113084622.738278-2-himanshu.chauhan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX2fnNkvhT2gOq
 b55SkhV01vebYbPGai9nW9+In9BUxyqrEij9HZBp6X48JHzjxjQmj0TB0yMv5vzTbRLozvWMN//
 wA3ukH0LMkjKDk+ymu6E/HvUasxJBzuZM5HSz87rY1mkGchz+wBPUC1uKnr+otMnLkhcE7FeNdK
 aWw/fEf3Pr0Q/Vl3ReKidNTsic5JmH1aE7uzx0XCc9/2CXybATsnt5qNvs7BWP5VLb5PY3tkHz5
 xFUaiHjELz1ZLR4WduLyTd9ALHw0AuHAwv/l0uXXVpAp/ajNQuCn9bcG3OPgB+OEOo20ZiEW5/o
 /wZZHvkO34kIDqgDjThX/WRgVJlwJF1//BZS+36Kd8w3CwJXmfoFpkmC5WkHVMduHuB28ZHfol+
 YiBKNj32fFdmmrUZ8ACPru8F1ntyhX0jnvNLGozYgS2EQma/g98dUEtxb0TeS3jOpDbY7+X3d4/
 vyIp+8YrKPXPHlNSWEQ==
X-Proofpoint-ORIG-GUID: -A4-OBHgEmj4Ju5aimufOi40h0Jyxa_r
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b044248 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Pk_qp4Yd0QN3FsfdVUAA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: -A4-OBHgEmj4Ju5aimufOi40h0Jyxa_r
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NCBTYWx0ZWRfX2o8F8TaHF8Hi
 I5VYjYy1plykEb15zOXW8c4JylzHg/VijnDfluziqbLXxn2pVpRqHffBY4u4V0fizyQB0MiMWzs
 BLFpJataus6qNukxfND1ELisTGv7Rlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230054
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 11/13/2026 5:46 AM, Himanshu Chauhan wrote:
> The tdata CSRs belong to an implemented trigger slot, not only to the
> trigger type currently selected in tdata1. Writing zero to tdata1 disables
> the trigger by selecting type zero, but it does not remove the slot.
> 
> Keep tdata access tied to the selected slot being present and let type-zero
> slots accept those writes while clearing any active breakpoint state.
> 
> Fixes: 95799e36c15a ("target/riscv: Add initial support for the Sdtrig extension")
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/tcg/debug.c | 50 ++++++++++++++++++++++++++--------------
>   1 file changed, 33 insertions(+), 17 deletions(-)
> 
> diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
> index 8b58cbd07a..2067657c81 100644
> --- a/target/riscv/tcg/debug.c
> +++ b/target/riscv/tcg/debug.c
> @@ -53,20 +53,6 @@
>    *     1 |    2 |         tdata1, tdata2 | Address / Data Match
>    */
>   
> -/* tdata availability of a trigger */
> -typedef bool tdata_avail[TDATA_NUM];
> -
> -static tdata_avail tdata_mapping[TRIGGER_TYPE_NUM] = {
> -    [TRIGGER_TYPE_NO_EXIST] = { false, false, false },
> -    [TRIGGER_TYPE_AD_MATCH] = { true, true, true },
> -    [TRIGGER_TYPE_INST_CNT] = { true, false, true },
> -    [TRIGGER_TYPE_INT] = { true, true, true },
> -    [TRIGGER_TYPE_EXCP] = { true, true, true },
> -    [TRIGGER_TYPE_AD_MATCH6] = { true, true, true },
> -    [TRIGGER_TYPE_EXT_SRC] = { true, false, false },
> -    [TRIGGER_TYPE_UNAVAIL] = { true, true, true }
> -};
> -
>   /* only breakpoint size 1/2/4/8 supported */
>   static int access_size[SIZE_NUM] = {
>       [SIZE_ANY] = 0,
> @@ -165,13 +151,17 @@ static inline target_ulong build_tdata1(CPURISCVState *env,
>   
>   bool tdata_available(CPURISCVState *env, int tdata_index)
>   {
> -    int trigger_type = get_trigger_type(env, env->trigger_cur);
> -
>       if (unlikely(tdata_index >= TDATA_NUM)) {
>           return false;
>       }
>   
> -    return tdata_mapping[trigger_type][tdata_index];
> +    /*
> +     * tdata CSRs belong to the trigger slot, not to the currently selected
> +     * trigger type.  A type-zero trigger is disabled, but the slot still
> +     * exists, so software must still be able to write tdata2/tdata3 before
> +     * selecting a supported trigger type.
> +     */
> +    return env->trigger_cur < env->num_triggers;
>   }
>   
>   target_ulong tselect_csr_read(CPURISCVState *env)
> @@ -729,6 +719,30 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
>       }
>   }
>   
> +static void no_trigger_reg_write(CPURISCVState *env, target_ulong index,
> +                                 int tdata_index, target_ulong val)
> +{
> +    /*
> +     * OpenSBI programs DBTR slots by first writing type zero to tdata1, then
> +     * writing tdata2/tdata3, and finally writing the desired trigger type.
> +     */
> +    switch (tdata_index) {
> +    case TDATA1:
> +        type2_breakpoint_remove(env, index);
> +        env->tdata1[index] = 0;
> +        env->itrigger_enabled = riscv_itrigger_enabled(env);
> +        break;
> +    case TDATA2:
> +        env->tdata2[index] = val;
> +        break;
> +    case TDATA3:
> +        env->tdata3[index] = textra_validate(env, val);
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
>   /* icount trigger type */
>   static inline int
>   itrigger_get_count(CPURISCVState *env, int index)
> @@ -995,6 +1009,8 @@ void tdata_csr_write(CPURISCVState *env, int tdata_index, target_ulong val)
>                         trigger_type);
>           break;
>       case TRIGGER_TYPE_NO_EXIST:
> +        no_trigger_reg_write(env, env->trigger_cur, tdata_index, val);
> +        break;
>       case TRIGGER_TYPE_UNAVAIL:
>           qemu_log_mask(LOG_GUEST_ERROR, "trigger type: %d does not exit\n",
>                         trigger_type);


