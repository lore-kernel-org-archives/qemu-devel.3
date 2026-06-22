Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60344CD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkO8-00011S-NT; Mon, 22 Jun 2026 15:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkO5-0000ww-Hd
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkO1-0001uN-Rt
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:32:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MFXh2b1647837
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F7D8VHI79dV
 67Zew7czHHb8GjJNhn3Nn4r6Iq8m8kRk=; b=MF01BdQbKM8u+mJ6PLIPdyfwOeo
 2oW6IYJD2wWvEnMLJmjBh2mqgXKiQ8qvSW+rfSS368n93rf6Pk5W0sZan5Kn9/ow
 QURV8n+fIQn5PAm/Eoxy3t66Xi+XJj1XEKEoN2D1otrE09mCzeoW5OAtsWhv8wVw
 OZkZgJBCYvip29a4tLtCzdTPiwSJ//SeR+83Ie0sYpKW2OlwdRoHBc4qbfpfWFjp
 hc2KIrASCQpuroPcg2uSwQ82aMKAjUwZjNANMlYfaZ0oT/RWqs58mKD7KVFCeDc6
 97PrnF6QRLcrvdIjKQWkMntMEcUF45hWK5k6aWxgsxGcEa8G+iIUdOgy0yQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37h9yby-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:32:48 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-91576c147a4so1191988085a.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782156768; x=1782761568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7D8VHI79dV67Zew7czHHb8GjJNhn3Nn4r6Iq8m8kRk=;
 b=X7+nctbQPiwLG486c2770bGtwhWn7q+bvAbbVT7Zjt8QS6q0L4R+rq2agyqbw1lEwa
 FqZTSd8K24fHMZX2vwxyNZbDX4ThQQYIdX0d4yVUAG6MePC/914T3OSiuWSyVcTjCCRX
 lubmv53UlNqrS+nhufjxbK4+aoaWCpVND8l+aGgmXE2UB3nGEe2cMH+E7nLclQuploOf
 LBjGo2ezZPXwaxHxz2ebU8/+Cb7TT/CS3JwEDGCHu/cox9xaWwnLk7e0G5LBQbCrquke
 On8frwvbizTiM1YU7cU7YSXVqwOhPeGqmju2NnrkYrPcAch3tRSJem6H3XOfPY15tyLd
 CWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782156768; x=1782761568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7D8VHI79dV67Zew7czHHb8GjJNhn3Nn4r6Iq8m8kRk=;
 b=q0j4rMEHnlF8VfgsuNGu0H82a1Kf6VFQGrlMYEnGIjXAeqAgfBFHBexx9F3Zc8mhxO
 QGF5x69SWjtyG5o3RyVP19zdq7JtxwcL/OxGauS9uRzBdZrKfFpwM2rz97/SkgunBQg9
 T7qbq/gNhMxPX2G3uLY7GG/UiqtTMNFNfZ9PI0jrtOGuL0nN4A8Yyglqp+ECToc09D+3
 lJUdjsgsbhOALA2Bj2royoiwlQB1VuBwy8wrz8phnXnhytIsq8UocVUUnf1oeUtJlwCb
 RXw40VcMXzgbW5gsWZuci9htzfGCQ5sWEwxKVe3VDTzxzuFbFozNSmJArNm+Qv9Gzk7w
 9Pig==
X-Gm-Message-State: AOJu0YyI/CcLpEzBA26r1efRgDab4LwHRUg/i2rHcdLUALd7hZDk/tpg
 GNDbQTQ+cv1uEbaCrAl6XqWVBzqV6j+75Nw4EZIfDxPvExdyq3CcQqlSt+JA4NYJs4L7TmMOG95
 GvKO2XB/KPg2fMsvNX1fGXyWwCBR3TGBJJ2FZRvD2Pkd+391ukUTG3U4ca0Nh31TTmw==
X-Gm-Gg: AfdE7cnGCbMCoSHXFmZ9bMZFrXwO+3WjdhGaoQjri9a362aymAgb1q25F9VfKtdzbE1
 mQhpxjwKKqoW9U4YhwgUmyHl2BCAL5e5FXVEJs7Dy1opTfY4zWi84oz41c23lU2PgblRL/5lpD6
 HQizyzm4vqaOKCNY3vsMi1zS1z87ZI1uDfZPzvreKqBQjbM2LcvzuOJBmvJDLc8St7jKiqnfeSG
 INGUvN28p9dPTrXG0zEdUWpvCig0sXP7db5Md3qFpcLZaghyRN6193q9K/AgUnJpW6kYe1KYCpQ
 dH59KrS+CYSKnJYyFhrkKdkjOAnoGTzLm4us6cfQtDRzuhEFmTpXSpiUbXKO6vXUQMZafiCQFqm
 aqgEaB3dxbjuG7qOPalpR4IRZJL1pd40H+7x1vHEZdebNKg==
X-Received: by 2002:a05:620a:2701:b0:915:cda5:27f9 with SMTP id
 af79cd13be357-92092e37e1amr2249684585a.56.1782156768429; 
 Mon, 22 Jun 2026 12:32:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2701:b0:915:cda5:27f9 with SMTP id
 af79cd13be357-92092e37e1amr2249676685a.56.1782156767944; 
 Mon, 22 Jun 2026 12:32:47 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:47 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 20/24] target/riscv: move riscv_cpu_set_rdtime_fn to
 riscv_aclint
Date: Mon, 22 Jun 2026 16:31:36 -0300
Message-ID: <20260622193141.1449724-21-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: X5h_Vr40clVgyE-PrC5_PFhDbE123k0P
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a398de0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=u0cZ2EjT8PS4VQJ4ig0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX4PHrFgwGzBSg
 DtwC/vYn83+CPFunhxHs1OepzDYlm8fneMTYwSg1tpB5iuAIHV2pOuTeP8grzqWnvFFqkAdNKTH
 siz8a2YFBG4RxuCfvv88V41Q5+ICV/s=
X-Proofpoint-GUID: X5h_Vr40clVgyE-PrC5_PFhDbE123k0P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE4OSBTYWx0ZWRfX7Z1+0DvQ9RRx
 i26GkaAgLbR5d083bD+IRCJMpc/a2dg9QK+6m4ZSjd3idLnZp6eFlndrnmPInnt+JAdksS8YTnS
 K56Erb/N4ndRFJz3SV6bGlOxF8x/Wj27S2B6Pasaw+zzcCRxgkDBGk8cmwBwDIEZC9rpiqsqFDf
 5d639xk44ZTCLKyqocAtjYi6aHfLWhnPZj4gskTiuXhLcWMR0yibzkl+b+voywgx46D6IhoBD3d
 tdyyXl9e+Qb/VInWTYFL+YdhFhelo+AQMzm+7hMROWYwzHqWW4CSb3eqUh55DtmE0QXlXVx1HFt
 AUsy3u8N9k96V0BoUAn+SHOfclal0YEm5ppi4YrrfE63AW37SbXo1VWR5Zwixpp6NW4BmQ1zad2
 UIlXx6qZ2Su7JX0KQz89kRJ9xtAQOdTCucMYD91sQI8JaelL5aLT24FkByxuY95ROEMwZ7XsOR3
 CUmbvMv/osfRFZc+jZQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220189
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

There's no need for it to be in cpu_helper since riscv_aclint is the
only caller.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/intc/riscv_aclint.c        | 8 ++++++++
 target/riscv/cpu.h            | 2 --
 target/riscv/tcg/cpu_helper.c | 7 -------
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
index e27e5fb394..361a8d1bcb 100644
--- a/hw/intc/riscv_aclint.c
+++ b/hw/intc/riscv_aclint.c
@@ -40,6 +40,14 @@ typedef struct riscv_aclint_mtimer_callback {
     int num;
 } riscv_aclint_mtimer_callback;
 
+static void riscv_cpu_set_rdtime_fn(CPURISCVState *env,
+                                    uint64_t (*fn)(void *),
+                                    void *arg)
+{
+    env->rdtime_fn = fn;
+    env->rdtime_fn_arg = arg;
+}
+
 static uint64_t cpu_riscv_read_rtc_raw(uint32_t timebase_freq)
 {
     return muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL),
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index c45ee228f4..9ec86069a6 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -679,8 +679,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask,
 void riscv_cpu_set_rnmi(RISCVCPU *cpu, uint32_t irq, bool level);
 void riscv_cpu_interrupt(CPURISCVState *env);
 #define BOOL_TO_MASK(x) (-!!(x)) /* helper for riscv_cpu_update_mip value */
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg);
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg);
diff --git a/target/riscv/tcg/cpu_helper.c b/target/riscv/tcg/cpu_helper.c
index f99fa636c7..d0d74c3597 100644
--- a/target/riscv/tcg/cpu_helper.c
+++ b/target/riscv/tcg/cpu_helper.c
@@ -612,13 +612,6 @@ uint64_t riscv_cpu_update_mip(CPURISCVState *env, uint64_t mask, uint64_t value)
     return old;
 }
 
-void riscv_cpu_set_rdtime_fn(CPURISCVState *env, uint64_t (*fn)(void *),
-                             void *arg)
-{
-    env->rdtime_fn = fn;
-    env->rdtime_fn_arg = arg;
-}
-
 void riscv_cpu_set_aia_ireg_rmw_cb(CPURISCVState *env, privilege_mode_t priv,
                                    aia_ireg_rmw_fn rmw_fn,
                                    void *rmw_fn_arg)
-- 
2.43.0


