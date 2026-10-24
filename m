Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A1606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lbPsYTs6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jg3UVWZZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKf6n-00088n-DL; Sat, 24 Oct 2026 13:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKf6j-00088e-UJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:00:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKf6h-0005GL-8U
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:00:37 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExpPM1353375
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A9FvPuRKqzCUgsTK37vm+IpjsqTyedNShIkkx1Pc9WM=; b=lbPsYTs6f9LHMVxI
 OPhhX99Tra5KclpmQf9XeU3ymtc/znwSM88wzUlZ6Fm7oy849OYOWIG0lBwGm+a2
 lv69urFkngT0wgEA6Gy6Cj5vP0Wcw8eYiOYp9XW6bpYoowo6QFxpPpJMTS4byG+Y
 +Gj82U9GBtmc4rhRjfqv9Ejv/UcXVw9AIrktReDPFVLRBLVAVGQNL0zGQ2sZTCjE
 P1A/xDAVbecMtgCCPch7dRV2eESLYk7j400BXJoG8knIGnIbqPgNqtvczyperPCV
 J/cI0z6xf2VPYZjHr3gRUPSo/NBd+gAL+Idy53/AeVunDtIF/Fn5lGM2ZOgY2z/R
 MjQEsA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehha46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:00:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f32050e72so251657885a.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792861225; x=1793466025; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=A9FvPuRKqzCUgsTK37vm+IpjsqTyedNShIkkx1Pc9WM=;
 b=Jg3UVWZZmJn3C+Aznp0kB6496V6qwLyh4qalJ+5igLrZvlIaKY+Yopo4k7CVgfV8g1
 +7gPiG9KWLJestuPiPKLYhamY6zmymPQzzZzhy+CLoQC0g+C+re8Ny+ByREOHWiSvWk0
 KUUb8q3EBBOlJC4pRI3cg0fpK9tmPIljyjB6tVckCdpS080ystGwabFjLpty8tgefOA4
 Jmy+GX/07kLsRSD7IHyVj/DVjDhc7nfC9xNaCIo3/bvnRlatdCw2/1az1pd7pUUhkaFD
 x2Zo+5qSGJvPBf35+3c93QtymaqkW/BxFVY/EQcpTn0bH06nKYh1QJoLtA++D/Esr75R
 AA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792861225; x=1793466025;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A9FvPuRKqzCUgsTK37vm+IpjsqTyedNShIkkx1Pc9WM=;
 b=u+VttWkLx0bmdVtg5fLHj90cBFk+tR7UWUiFQSGRkxFLILGtB5j97Gam/PV15Exffa
 VvHEWw9w7eaK5Xab/U4U+u8juLrKvz69WuGVs6JNpxm9zH6uOYqKep/KL3W80XcS2Btv
 Q9T2ChwKZUG98i2evc3mu3xMsA/kYmW2rC/D6sP2Lvj5U2wJbZ/AFvK649FWkmnnqniP
 ElQ2EB+TcJug5ue47NHzgYVKSIotOycECK9m9wORWwtvGHcfbD7OV5CvC4oZEP0Jzdrh
 IdVRv/whGURGfWv7JlDUSolORGcV74AuyLDD8tLVzCQrI1SPzZwRbId3OR0FFKBLVlQq
 6QyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTuZblJ5e7vnHkgnJvavq5anbvqdYswoY4lOp9tRD0pHf44fZLDuoKZBdOIcAjvsOphnU0nDuoI/39@nongnu.org
X-Gm-Message-State: AFq9FYKutELf54nZsqZ+f0BQjH2kh1XEr+1oLhPQT+zHFmrgvFil8t0B
 7c9mgsBjsl2pk9T/qZpwjByg3bwqAowqvt4Xn4ZOs3Z3DWfzA4pMGHBz0s0byvlo6l0fKVcNoZE
 vLXP34D7lFb7IRDPO2wf3SELTGZxT9EaUN2hVqa4KUkjl1eAJYUw52+HM1Q==
X-Gm-Gg: AYBFou3iiaisrCcpZyrPT+obcCe2d7p4vG0ZX8xA3y2+ks6tTIsTslk9MXmHZzV7bLl
 yDAAMexyLFknKCZP0WB1ICiThzku6GbSMEIAk2DZfQV89ljZTGvBaV4WImxWftyT2QWosxc232f
 DSazMHE+9swPgo2AbZOTZKrEssyKMFFL6fIxt0U4fdKsANBEIPIyF0WGU9kEt9u7OVbQUmd2P/+
 2AAIl/s9l82xaZPsw5MGDZUrKm+XBzld4HsV0D9sTahPtMVkGd4Cbmt1sN0zOBfkGY5gzmUF+Xu
 OF54YSRAVm1ZGFTja8Hc1/85kF2Lj1HkBnMeeDvSz5OGZAE3c+RgQPkBnwNB5AM7TISD/dYABfx
 pqI4v48EuPtFDWltjYaLzDR2mJF8/opTT2g==
X-Received: by 2002:a05:620a:7008:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-940ef8be856mr347636385a.25.1792861224643; 
 Sat, 24 Oct 2026 10:00:24 -0700 (PDT)
X-Received: by 2002:a05:620a:7008:b0:93e:4d60:d389 with SMTP id
 af79cd13be357-940ef8be856mr347626485a.25.1792861223719; 
 Sat, 24 Oct 2026 10:00:23 -0700 (PDT)
Received: from [192.168.69.209] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm179043725e9.1.2026.10.24.10.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2026 10:00:22 -0700 (PDT)
Message-ID: <9ca6f711-e886-46a5-80ea-a6c750696a93@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 19:00:21 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tcg/riscv64: Fix vector constant matching for logical
 ops
Content-Language: en-US
To: Aurelien Jarno <aurelien@aurel32.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "open list:RISC-V TCG target" <qemu-riscv@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
References: <20261010174742.3552498-1-aurelien@aurel32.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261010174742.3552498-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA2NyBTYWx0ZWRfX3dYSSMhl3kqx
 UVtAzyyBEYONTrMpC/d0mxTWQIYd2rn8NsRJ6SO/PTTnDMVffllO1jYswg1wsNvmV1AQnOCps3b
 noLPUc+kUDsTmxUrMaRPNsb3XlifznU=
X-Proofpoint-ORIG-GUID: W48vzRh1_IbR2iTb_2N__NaYe5FiTCmh
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adce42e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=hXZgYZo4AAAA:8 a=q0Y7SH5cVIXpF_u_vNMA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA2NyBTYWx0ZWRfX6qiEhbKb3heG
 CE0tvUI8uVg5RGqqFPOTPR7SMPAvbfro6UV9CXauarKBuC7UgtNhroThEeW9CtgCnCzvJghHLfy
 KT9WzXX1js/lvT5wNCL6xIdTPE7nE4uV28o98YxCSTa7yyE9VXEs/rFq0jonrj+QW1pdIt0yOO+
 fxqUapXubKKQxg5/na/4gEvs4IlEuMyEMni2tRncCQ7conc/ud19mxPw/0K4Me2l/I1EQR6xX0j
 iocq5Xf1dxiUcHMO2yMbhTwd6I9YlyT7BhXV2VnTgBQOx8OkbiniDAdIgSRZkmHlPkzzuUamN4d
 dPR6Zx7KJkfp+CvvH87tgsQ6U+GLe0xqC6GPIYOxx/zqdS+F9XJyi7viIEctauWdHtUoY9teMS8
 v80ZwZ3g3gjm8LgkmPsGIEzHdLsbrgD9ZCeLQZyLUqr0QIQ2GlhoXwQUkP9PQ3tc9ebmrHnunLx
 AKymSPfGMnJubIoI5Xg==
X-Proofpoint-GUID: W48vzRh1_IbR2iTb_2N__NaYe5FiTCmh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240067
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

On 10/10/26 19:46, Aurelien Jarno wrote:
> For logical vector operations (in the case of the RISC-V backend that
> corresponds to and_vec, or_vec and xor_vec), VECE is unused. However,
> tcg_target_const_match() always treat it as an element size to extract
> the corresponding constant element from the whole constant.
> 
> This causes the following aarch64 instruction
>    bic v4.8h, #0xf0
> to be translated into the following op:
>    ...
>    and_vec v128,e8,tmp5,tmp4,v128$0xff0fff0fff0fff0f
>    ...
> which is then translated to the following RISC-V instruction:
>    vand.vi v1,v1,15
> 
> Fix that by, when VECE is 0 aka MO_8, only extracting the element if the
> it can actually be represented as a duplicated constant.
> 
> Fixes: 5a63f5998791 ("tcg/riscv: Add support for basic vector opcodes")
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
> ---
>   tcg/riscv64/tcg-target.c.inc | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> Changes v1 -> v2:
> - Use dup_const() instead of open coding the constant duplication.
> 
> diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
> index 14a397117a..1262b71a62 100644
> --- a/tcg/riscv64/tcg-target.c.inc
> +++ b/tcg/riscv64/tcg-target.c.inc
> @@ -392,8 +392,15 @@ static bool tcg_target_const_match(int64_t val, int ct,
>           return 1;
>       }
>       if (type >= TCG_TYPE_V64) {
> -        /* Val is replicated by VECE; extract the highest element. */
> -        val >>= (-8 << vece) & 63;
> +        /*
> +         * For vector logical operations, VECE is unused and equals to 0, so
> +         * we need to check that the constant can properly be represented after
> +         * replication.
> +         */
> +        if ((vece != MO_8) || (val == dup_const(vece, val))) {
> +            /* Val is replicated by VECE; extract the highest element. */
> +            val >>= (-8 << vece) & 63;
> +        }
>       }

This fixes the BIC case, but I don't think it is sufficient.

I tested with qemu-aarch64 built for a riscv64 host, run under
qemu-riscv64 -cpu max, guest -cpu max,sve-default-vector-length=16.

NEON bic v0.8h, #0xf0 // fail on master, now OK

add z1.b; and z0.d, #0xf // FAIL
add z1.d; and z0.b, #0xf // FAIL
add z1.b; orr z0.d, #-16 // FAIL
add z1.d; eor z0.b, #0xf // FAIL

Not accepting constants for and/or/xor_vec at all
(using C_O1_I2(v, v, v) to get them loaded into registers)
makes all five cases pass (I'm not sure we want to keep
the .vi forms):

-- >8 --
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2779,15 +2779,15 @@ static void tcg_out_vec_op(TCGContext *s, 
TCGOpcode opc,
      case INDEX_op_and_vec:
          set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VAND_VV, OPC_VAND_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VAND_VV, a0, a1, a2);
          break;
      case INDEX_op_or_vec:
          set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VOR_VV, OPC_VOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VOR_VV, a0, a1, a2);
          break;
      case INDEX_op_xor_vec:
          set_vtype_len(s, type);
-        tcg_out_opc_vv_vi(s, OPC_VXOR_VV, OPC_VXOR_VI, a0, a1, a2, c2);
+        tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2);
          break;
      case INDEX_op_not_vec:
          set_vtype_len(s, type);
@@ -2976,15 +2976,15 @@ tcg_target_op_def(TCGOpcode op, TCGType type, 
unsigned flags)
      case INDEX_op_rotli_vec:
          return C_O1_I1(v, v);
      case INDEX_op_add_vec:
-    case INDEX_op_and_vec:
-    case INDEX_op_or_vec:
-    case INDEX_op_xor_vec:
      case INDEX_op_ssadd_vec:
      case INDEX_op_sssub_vec:
      case INDEX_op_usadd_vec:
      case INDEX_op_ussub_vec:
          return C_O1_I2(v, v, vK);
      case INDEX_op_sub_vec:
          return C_O1_I2(v, vK, v);
+    case INDEX_op_and_vec:
+    case INDEX_op_or_vec:
+    case INDEX_op_xor_vec:
      case INDEX_op_mul_vec:
      case INDEX_op_shlv_vec:
      case INDEX_op_shrv_vec:
      case INDEX_op_sarv_vec:
      case INDEX_op_rotlv_vec:
      case INDEX_op_rotrv_vec:
      case INDEX_op_smax_vec:
      case INDEX_op_smin_vec:
      case INDEX_op_umax_vec:
      case INDEX_op_umin_vec:
          return C_O1_I2(v, v, v);
---

