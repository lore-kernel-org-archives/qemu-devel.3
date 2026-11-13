Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA3E606A8BC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o0XwO8dw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VBwvnTMM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtwe-0006ja-2V; Fri, 13 Nov 2026 11:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtv3-0003qJ-I1
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:40 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuy-0000OE-J2
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:26 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRRRB3296046
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AGe1K3hUo4GMTGl5PlhtYLIZgxo7jgD3mMq9y+4cDHg=; b=o0XwO8dw8ur+lgGO
 9cmkVl1FfKE7nSF/i3Y7NWTLW5k++LGG5zpkScquOx1Mg5O9Xg8n/GGfAS27UjCc
 wjGZdYsiw56FujcPg8uuMS9P5u7+qJLGVTKtCd7bjvLQ9nEw2sKUDCZWOAcp2Sxk
 7CkoifD0k1X6iPqVW1fu80C9i2bzgZdqcXn/Pzs06WzAQI2Bg54+acwLbWf92dXQ
 n2wfUkfutcPpUSFv5vck3eoTPdVUMgZDRAaztMdQKv048FyMhspqXgGIo5tFmkKZ
 fOHP8S64neVghLm1EMNPM0MdGDDxvQmNfTFZAcDlsR8yrgLNQ48oygoMHYp0mHYZ
 xk/16w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t3vr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:23 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99b8fbf29a9so331063241.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586463; x=1795191263; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AGe1K3hUo4GMTGl5PlhtYLIZgxo7jgD3mMq9y+4cDHg=;
 b=VBwvnTMM/uceMl96LuhmFP/e5Wmnn4NACUT11Wx/p3zAAh4Bd/FMJcJdjxyyHlAoeJ
 Om97WPLapg+K/IBrSrKTNPg/ypXLhJReI8JjTTd6m8r/6HpPzmqIhp2sxVXH0bazB/tG
 2gyKUT4Xp1oDiUxnRCJEkuMShgVqlcc4P/JWhM8CeKoeEi6Pmwal0HZqiX8TzZREh0Zc
 L58FMv/K8UdvuHTstZZe1SRdKCdKU5K2c2+Jpjnr+Nbi5f8YBxNJIHpw7oM/LAB73Wv0
 R1iwLTdIBk7i/3uo/6wqD0tNNrq3TX2BtyY/pHeCCH35X7mtXfY0ta+fFnucrgxHPZSE
 inlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586463; x=1795191263;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AGe1K3hUo4GMTGl5PlhtYLIZgxo7jgD3mMq9y+4cDHg=;
 b=N05gjfk9Y9abpg8a1ljmxUCvCHwEWYuoN7h+xCvIa6qMqvYI2mKPOj/YDLAn5WRMnE
 luSioavP+fpR6Wqy+DWzfyggZE7ez/zThDpw+bZkesUQ+v3wJn4Ze46I0D6uaOwB3SLO
 WHPxXmcxAbJZ1rhrdPYSCCyAmEvy4sgkRMES4YT+JNht+0cJQa5eACtDzLjQdmBotZ8z
 43YCEbB90OUTv0z3uClDwkAekWoetDeaTkNf7NjNbwLNAwYv6wqcV8wLTJ4b38hGygzM
 17c0IUAomUxEfTRSm4A2UC14rrtCuUx6cvcQEpW/iSdFUUFW1kL8VTo5m4qoZiGCmoY3
 DlqQ==
X-Gm-Message-State: APuU4Z+OW4fqIy18B0oC9ZrI3UMGyfN3dznm/Fmbr7H53PRU5T04661n
 y0ePV+HLSc+Q1EZy3GCgYGP/0UBXFioo6Yb9BoV+jjYwr4J+ZsGbxLsNI8ou5pSER3tOy6HLPEz
 mg1YuPcaG83zyL2Jz7xYXphqwm5ITGHaOfTk4uQ+0ATsV05lidNaHdIYw/xbCYKevfufy
X-Gm-Gg: AYBFou3P85WNulxBWWLAXzXvxY+oiAA+b+LhmLrIMi6sSUVX+fQW0dWhIUdLu4W3kfl
 tyrfSWmLWCUiwchIjmP29Jh+ixwh/8wrbQdRuwly3y+ZKbdWXUi+0+6Ytx9JqisWPhDonYLiNch
 yO19hhVkolvHOXKRlhS0SLa2l9tG3jVNR2Bcq/zDg0ofhPyYAq317KUwlYpIKXPcwCs+73tftJ5
 siQ3uSkmQl/FilqmE7VdfPrvElc63ai14stUWjQ4fe4QdCb+GLzjffw9cZS0ElsjgsDEscUTv6T
 w7GBP4J0PHcer2SPHha//dI/EsZXul2zspinV/xAMCdc0Yc/TfVyQT3OhCsUp6lvy9vUvxrAqgI
 Bz3DbrgVThZ113ryZJGXKiV/q2UeEUGyfTZHKULAcy+5rdJAcdYQfWfy51+Tqb8XvcIh5eAz4/u
 dtdew4xaFN8YugCA==
X-Received: by 2002:a05:6102:2ac4:b0:7d2:7c63:5a0a with SMTP id
 ada2fe7eead31-7d64d81ed4bmr805717137.23.1794586462899; 
 Fri, 13 Nov 2026 08:14:22 -0800 (PST)
X-Received: by 2002:a05:6102:2ac4:b0:7d2:7c63:5a0a with SMTP id
 ada2fe7eead31-7d64d81ed4bmr805706137.23.1794586462357; 
 Fri, 13 Nov 2026 08:14:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e29d24dsm168133005e9.11.2026.11.13.08.14.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:14:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 18/19] target/mips: Do not sign-extend partial LWR results on
 Octeon
Date: Fri, 13 Nov 2026 17:11:56 +0100
Message-ID: <20261113161158.25811-19-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX01FqNYs+zqhX
 Y0j+hufn6tB1FbrtTNR3nehCueoZ5tE9YOUZ4TevOCI68uZeGlTBSXHUTvtcNqCDFpWWay2Zocj
 339k0BgY4LsZu5w0LLZ9rU3E+tTOvber2bkTUI3MHPVBYHyenbhx49SpVeBfnxFrfwhzBWYYGvy
 7CZiw7u1/7094FeDqN84MCtG/B7nLWlIirrg3adV4MZyWttWwt9tRSvEQIPRWpSTJDLMS79jNlg
 D5cYSf+PP5NydIkuvBy7Y1Tmc4s9JanaeBWS5Udx+ihzK+VII1sq7kIU3kE5R2/ktpB4Zuo0bJr
 1x3tzDhJf525RGWR++Hzh+mSoD9LovfxyXQKcpZmILItK3GNtTZzt3mTdrBGw1wkT85R8hZo/0O
 jar3vEdOlBZ53gYNxfIUpw/fd9wFRM+s3/jzmIPEWL1T4tdx+nkghe109z2PQR2EF9m0adCHyK1
 YeWDDPAPH6D5wUXP1yw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX+C+wBVwk+7n5
 5m//aIblQtq/qUepbmEI2JT6EtZ4PzzUgXE/iX/V2DCrJDQaNiJvv1PjXm5XwrDaSbHf24xGb7D
 +aESBTcuhTaczeQH/GQvf73AC5htbsI=
X-Proofpoint-GUID: 0fcKRT0jfHZs46JN4eG_4PGkx3uUqebi
X-Proofpoint-ORIG-GUID: 0fcKRT0jfHZs46JN4eG_4PGkx3uUqebi
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af7375f cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=3UIKva1vFuA4V1yXjwQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The MIPS64 Release 6.05 manual (LWR description) says that when bit
31 is not loaded, bits 63..32 of the destination are implementation
dependent: either unchanged or a copy of bit 31. Both behaviours are
architecturally allowed.

Octeon III CN71XX hardware leaves bits 63..32 unchanged unless the
whole word is loaded (vAddr[1:0] = 3 for big-endian, 0 for
little-endian). QEMU always sign-extended the merged low word.

Seen replaying a risu trace recorded on a Cavium Octeon III CN71XX:
"lwr s7,26334(a2)" left r23 = 0004114d368db793 on the hardware where
QEMU had 00000000368db793.

Only change the behaviour for Octeon CPUs (INSN_OCTEON); all other
CPUs keep sign-extending the result. LWL always loads bit 31 and is
unchanged.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6966b7e56abb..607384292633 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -2063,7 +2063,7 @@ void gen_lx(DisasContext *ctx, int rd, int base, int index, MemOp mop)
 static void gen_ld(DisasContext *ctx, uint32_t opc,
                    int rt, int base, int offset)
 {
-    TCGv t0, t1;
+    TCGv t0, t1, t2, t3;
     int mem_idx = ctx->mem_idx;
 
     if (rt == 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2F |
@@ -2176,7 +2176,17 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
         t1 = tcg_temp_new();
         gen_load_gpr(t1, rt);
         gen_lxr(ctx, t1, t0, mem_idx, mo_endian(ctx) | MO_UL);
-        tcg_gen_ext32s_tl(t1, t1);
+        if (ctx->insn_flags & INSN_OCTEON) {
+            t2 = tcg_temp_new();
+            t3 = tcg_temp_new();
+            tcg_gen_ext32s_tl(t3, t1);
+            tcg_gen_andi_tl(t2, t0, 3);
+            tcg_gen_movcond_tl(TCG_COND_EQ, t1, t2,
+                               tcg_constant_tl(disas_is_bigendian(ctx) ? 3 : 0),
+                               t3, t1);
+        } else {
+            tcg_gen_ext32s_tl(t1, t1);
+        }
         gen_store_gpr(t1, rt);
         break;
     case OPC_LLE:
-- 
2.55.0


