Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03595606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 07:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DBiBmPDW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GhIo+jVg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK9qm-0000CV-8E; Fri, 23 Oct 2026 03:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK9qi-0000C2-8x
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 03:38:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK9qc-0001O4-UX
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 03:37:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69N7FAG52112171
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwN0Hc9/C8B9Yoj9xDOwDWIc4uU6BlHm6lY7SQJwgds=; b=DBiBmPDWFEZXM29h
 83l6i3PiN+7LYe5boiM4onwAFteEwe646UpiZmioHbiy6L/XtuQDWGpF3jgbXwDt
 9Dkm3ueSutz2I5X2E74FdTT0+JNu0gBe8IcmvFFQFdheIF5EX0LnYZz+o4Mqqk+H
 IDPnBOZX8Qlqcy3qwZ5L+b/M0nWgfkOEnAHeRYwFvT7M5UKbNPDLbPhqRPCBq6n+
 bp0xH+SRABprhpvkQagJfz58NSzHqJWRVPdPRDm3fjs+prAGjZTtqMXJ8PepX7pz
 3OfhUeh/c7F7S7OW/iHWIyVGzInGCRcDqoKnFSWvu8UK0GFVvv6Z0qmVML1EiQdu
 SpIrIA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk9xyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 07:37:47 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f26dd2165so205213685a.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792741066; x=1793345866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwN0Hc9/C8B9Yoj9xDOwDWIc4uU6BlHm6lY7SQJwgds=;
 b=GhIo+jVgg1o20c7zljRmRYH1HAnef7+780D1qTIOT44ZzyMXYW9sApcy8dcFNGZhg9
 M59MIqbItpEGf5NL2w4pBRe75VXne9MkrSuVhx7BS3mUA0AlYA9OMirWuw5hKWd90hIY
 xlPQCfA4o+1VXE7ZJ2aAZdi9nE6QfgqAqdR+9qDzhCJ3CpVrfw9Y1OsQC5kI7lzy3PXv
 iFzDaNpgN0aV1CH6XJJy0+IMlsw4MaUJa5o/lkeW91AWNUg02EQ0DtfvjdScExd96H7t
 CZrpOq9DEs3WZlwQsYXxKTHAB7EBDM+Yq7zUMHdSgq6qkwSYY8M0B/eshWGwTGCZJa6U
 hdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792741066; x=1793345866;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwN0Hc9/C8B9Yoj9xDOwDWIc4uU6BlHm6lY7SQJwgds=;
 b=0y8AwEVfyTz1wY5UHi0Qmr0GbYhBXo2a0mYJKH6L+dj1QfgkbqdoLRHaeZtextlam/
 rFgYfT4DpVHF2FbMI1V16b4m002/9mCDvxPmhRddtlN8KjLPrC620DxjCBWb/oqhNQ9g
 CgECRmhpWrXdlRKUsiTEltu9InZvFeu7BoR5BKoa8X/ViyS7MJBaft/WZKoIt0hA70Xo
 g5r47X+0VDx/LkqnqoqnSgLhvQrYKOAxKCh+JtFwuxmk5zbE1/IRicjlzl9KHtUs9X5a
 pe/mBqEUPCyZ6pwTkNwi/roOnmVI3OCmr33HDSQ+UcWniMSEX6lwJ18+KBkcN3zcQkbO
 Cw1w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzzs1qGWyMjzOoHnJRXaj7sp7mYylSkChlAM06oXRJOtUKJTtAxr2i3HbjT55R2ekTkLiNuhy1cRBSy@nongnu.org
X-Gm-Message-State: AFq9FYLurbjN5iAPhvEJ+TaiPPBy8HVNTCN0WlXyj0R5jljZ1vdQZVID
 ZjHpYujFOTOEg7dP2CT4aOJOOo+ui+Nc+G36h9QaH/L3VSPt4y/zK3WMf3CKM6mgLPNq2UdX9Ri
 Uw5H7vGSljmxFaujkSa3XU+vu2bLx18HMsY2tx+NYtZ4BStYKIlcp3I+8TA==
X-Gm-Gg: AYBFou02jrkMZVFWQ+VSmLzr8zkGyebj8e1+FMuWtRYlh3KYZEFGXVqubPO76I4LQgB
 tfyMd4MZOvVOVO8H+jbRpfs5SIV2B3cC1ISvoQ7Llwn8M5H9IEBieLPcifB4d6lLVUGP/Kxpcei
 gEY9YGZ6XY8Bu30Y/44kCqt0nF+NWMk6YYpdJ499Ky1XMJzZ9lMKfpKTpAawGYPhuU4eZWkgMCD
 eEJrIFuCvNHk9aoRoyBS+N7Qty7YCzNqKyr0axvR1a4LmDIHgfMmtVwCY4UtJNwOyvccFYbPIF5
 g/9rz0sGp/2jgr15wLqvn3qh16eJKUFODWPh1nxaU56AzTxnGMN/GMmarNr6jQYWcrpBktgypcy
 bStpVeeMyGsyAmbCJCKAphBIIrkCJrcv24w==
X-Received: by 2002:a05:620a:7108:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93f6f9b7f76mr285723085a.58.1792741066582; 
 Fri, 23 Oct 2026 00:37:46 -0700 (PDT)
X-Received: by 2002:a05:620a:7108:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93f6f9b7f76mr285720685a.58.1792741066079; 
 Fri, 23 Oct 2026 00:37:46 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21034b3d0sm70782915e9.3.2026.10.23.00.37.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 00:37:45 -0700 (PDT)
Message-ID: <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 09:37:44 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
References: <20261022130657.6449-1-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022130657.6449-1-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMCBTYWx0ZWRfX1F4Gph4I30Q/
 j2W4iQpCImjJf+0z1fy/Tt07Wbw6nvUVwlG3sKTr+3AmzAH0CTP3K76S+rDbl/MutqJcjiKUuIm
 dTiwlLUCjbXCSJxC1i0jZxdiS2R2N894h6mxrZVAPkWWPx/eq27afthzJ3dELWcI5eKRg4y+izB
 IQHO/uADS+BzOveVpU6ZpmYtzT+vOYeGylIghyb39xNIpcwGXTMdULY5kXRPzgErXsqWgy0JZTb
 wVpYw4zjWvBAb3pvUvbif/FcFPKrw3XN0WT2J3rzh7rSkQK+X1XoJ05aNd8TNWbf6YY3F+2sNX6
 S+7um7dnMkpgFdj1SXSXGprtjYfqeoBwIA/UykR7AoW5ZAkkCoAjEfOBClIQKLpaQTUyIUKlt1s
 ORsz2uEmA8nfLx7gln7NnoFM3fj350gtXBF/n2Kh8Wa1kjtyEWfnGt7+o5AjSAFOY5iUeY9qNNP
 m9tJwv4n/Xn/6XvZp0g==
X-Proofpoint-ORIG-GUID: NerhW8shdPK1QK6hWYDK0sIo7QS-356u
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMCBTYWx0ZWRfX9NlcNsk/3Bel
 HEaGbiASMOr98hI5rMH0+onJ50r53uzccNTSQxYZPgXuK5+EaY9GW/fXDi8Vpa2jBepIHISl139
 5k34ueeS4qA1AOWbtd2lrs7BnBMPvXc=
X-Proofpoint-GUID: NerhW8shdPK1QK6hWYDK0sIo7QS-356u
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6adb0ecb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=8D0aWHW-DKab9n6p2hgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230030
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 22/10/26 15:06, Anton Johansson via qemu development wrote:
> mstatus and mstatus_hs are uint64_t but accessed through
> 
>    tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
> 
> which on a big-endian host running riscv32 incorrectly accesses the
> top 32 bits rather than the lower bits.

   mstatus and mstatus_hs are uint64_t, but mark_fs_dirty() and
   mark_vs_dirty() update them with tcg_gen_[ld|st]_tl().
   On big-endian hosts with 32-bit target_ulong, this modifies
   the upper half instead of the lower one, so the FS/VS dirty
   bits are never set. Use 64-bit accesses instead.

Cc: qemu-stable@nongnu.org
Fixes: 284d697c74e ("target/riscv: Merge m/vsstatus and m/vsstatush into 
one uint64_t unit")
Fixes: 8e1ee1fb571 ("target/riscv: rvv-1.0: add translation-time vector 
context status")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> Widen the operations to 64 bit so the lower bits are modified.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
> index ede9c2563f..79b0f444ef 100644
> --- a/target/riscv/tcg/translate.c
> +++ b/target/riscv/tcg/translate.c
> @@ -693,7 +693,7 @@ static TCGv get_address_indexed(DisasContext *ctx, int rs1, TCGv offs)
>    */
>   static void mark_fs_dirty(DisasContext *ctx)
>   {
> -    TCGv tmp;
> +    TCGv_i64 tmp;
>   
>       if (!has_ext(ctx, RVF)) {
>           return;
> @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
>           /* Remember the state change for the rest of the TB. */
>           ctx->mstatus_fs = EXT_STATUS_DIRTY;
>   
> -        tmp = tcg_temp_new();
> -        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tmp = tcg_temp_new_i64();
> +        tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
> +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +        tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
>   
>           if (ctx->virt_enabled) {
> -            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> -            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ld_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
> +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> +            tcg_gen_st_i64(tmp, tcg_env, offsetof(CPURISCVState, mstatus_hs));
>           }
>       }
>   }

Wondering about being safe (or catching other bad uses)

#define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
#define TCG_ENV_SIZE_(f)    sizeof_field(CPUArchState, f)

#define tcg_gen_ld_env_tl(ret, f)                               \
     do {                                                        \
         QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) !=                   \
                           sizeof(target_ulong));                \
         tcg_gen_ld_tl(ret, tcg_env, TCG_ENV_OFS_(f));           \
     } while (0)

#define tcg_gen_ld_env_i64(ret, f)                              \
     do {                                                        \
         QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) != 8);               \
         tcg_gen_ld_i64(ret, tcg_env, TCG_ENV_OFS_(f));          \
     } while (0)

or even using _Generic:

#define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
#define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)

#define tcg_gen_st_env_i32(arg, f)                              \
     _Generic(TCG_ENV_FIELD_(f),                                 \
              bool:     tcg_gen_st8_i32,                         \
              uint8_t:  tcg_gen_st8_i32,                         \
              int8_t:   tcg_gen_st8_i32,                         \
              uint16_t: tcg_gen_st16_i32,                        \
              int16_t:  tcg_gen_st16_i32,                        \
              uint32_t: tcg_gen_st_i32,                          \
              int32_t:  tcg_gen_st_i32)                          \
         (arg, tcg_env, TCG_ENV_OFS_(f))

#define tcg_gen_st_env_i64(arg, f)                              \
     _Generic(TCG_ENV_FIELD_(f),                                 \
              uint64_t: tcg_gen_st_i64,                          \
              int64_t:  tcg_gen_st_i64)                          \
         (arg, tcg_env, TCG_ENV_OFS_(f))

#if TARGET_LONG_BITS == 32
# define tcg_gen_ld_env_tl  tcg_gen_ld_env_i32
# define tcg_gen_st_env_tl  tcg_gen_st_env_i32
#else
# define tcg_gen_ld_env_tl  tcg_gen_ld_env_i64
# define tcg_gen_st_env_tl  tcg_gen_st_env_i64
#endif

Then replacing (a cheap replacement that can be done with coccinelle
spatch):

@@ -704,14 +757,14 @@ static void mark_fs_dirty(DisasContext *ctx)
          ctx->mstatus_fs = EXT_STATUS_DIRTY;

          tmp = tcg_temp_new();
-        tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_ld_env_tl(tmp, mstatus);
          tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-        tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, mstatus));
+        tcg_gen_st_env_tl(tmp, mstatus);

          if (ctx->virt_enabled) {
-            tcg_gen_ld_tl(tmp, tcg_env, offsetof(CPURISCVState, 
mstatus_hs));
+            tcg_gen_ld_env_tl(tmp, mstatus_hs);
              tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
-            tcg_gen_st_tl(tmp, tcg_env, offsetof(CPURISCVState, 
mstatus_hs));
+            tcg_gen_st_env_tl(tmp, mstatus_hs);
          }
      }

triggers:

FAILED: [code=1] libqemu-riscv32-softmmu.a.p/target_riscv_tcg_translate.c.o
../target/riscv/tcg/translate.c:760:9: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
   760 |         tcg_gen_ld_env_tl(tmp, mstatus);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:86:29: note: expanded from macro 
'tcg_gen_ld_env_tl'
    86 | # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i32
       |                             ^
../target/riscv/tcg/translate.c:45:14: note: expanded from macro 
'tcg_gen_ld_env_i32'
    45 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:41:29: note: expanded from macro 
'TCG_ENV_FIELD_'
    41 | #define TCG_ENV_FIELD_(f)   (((CPURISCVState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:762:9: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
   762 |         tcg_gen_st_env_tl(tmp, mstatus);
       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:87:29: note: expanded from macro 
'tcg_gen_st_env_tl'
    87 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
       |                             ^
../target/riscv/tcg/translate.c:69:14: note: expanded from macro 
'tcg_gen_st_env_i32'
    69 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:41:29: note: expanded from macro 
'TCG_ENV_FIELD_'
    41 | #define TCG_ENV_FIELD_(f)   (((CPURISCVState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:765:13: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
   765 |             tcg_gen_ld_env_tl(tmp, mstatus_hs);
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:86:29: note: expanded from macro 
'tcg_gen_ld_env_tl'
    86 | # define tcg_gen_ld_env_tl  tcg_gen_ld_env_i32
       |                             ^
../target/riscv/tcg/translate.c:45:14: note: expanded from macro 
'tcg_gen_ld_env_i32'
    45 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:41:29: note: expanded from macro 
'TCG_ENV_FIELD_'
    41 | #define TCG_ENV_FIELD_(f)   (((CPURISCVState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:767:13: error: controlling expression 
type 'uint64_t' (aka 'unsigned long long') not compatible with any 
generic association type
   767 |             tcg_gen_st_env_tl(tmp, mstatus_hs);
       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:87:29: note: expanded from macro 
'tcg_gen_st_env_tl'
    87 | # define tcg_gen_st_env_tl  tcg_gen_st_env_i32
       |                             ^
../target/riscv/tcg/translate.c:69:14: note: expanded from macro 
'tcg_gen_st_env_i32'
    69 |     _Generic(TCG_ENV_FIELD_(f),                                 \
       |              ^~~~~~~~~~~~~~~~~
../target/riscv/tcg/translate.c:41:29: note: expanded from macro 
'TCG_ENV_FIELD_'
    41 | #define TCG_ENV_FIELD_(f)   (((CPURISCVState *)0)->f)
       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~
4 errors generated.


