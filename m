Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585AFC44500
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvn-0008PZ-EQ; Fri, 03 Jul 2026 12:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvj-0008A7-Jz
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvb-0008Qj-FL
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:53 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIjMI499331
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DX7N5baSLNWo28XL7Yla9xA9xJlKE33supZnlBMANrY=; b=aepKGwXx4qlZ960Q
 JffurNyRFxv0as0qsitf+mqShsPuVBK+VuR6ihP+oe4M9HjCV37iqV6MMqykjhYX
 EXCLJk33f4C+ZsOdaGmOmfPyMLK7AofUR6m34sdXrrgx1sCgSULRL47pxG1VlRhC
 /UpN9No6tJwItG+oGzBOTmVOE20pAGM74sxj1fY8MTiNb7xjueJKVoCpe9TxJxDc
 Owct3oOyZybdgEn4BCIwGtdkW08g95ms3YdoyRVlf3WDYKR32JXP/zn83wfXYrz7
 ihRrCHKagY/Gl/G/G1XhD0VzV+6hXUU6f6tug2JZp2lPndl0xkteQbrWHPPEH/vY
 xRhdeg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5b6ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:38 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e53b8a302so70602785a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096778; x=1783701578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DX7N5baSLNWo28XL7Yla9xA9xJlKE33supZnlBMANrY=;
 b=B6Aea4QpCM/bkQr491ola5IIPKAzzqfHUXeZlkZgZR9EHKWC4N30aRHEY/vAg4jFRY
 /zRZCsVBuenWZXzbYSSSIzg0PFPOIQlNDiikU7UbZDe/9I+PN0V25E5jQhBMKzkOZp3P
 7w3JfkuUe23ih/srALw4NVUah4X/mFfYR+xVp9oKculDU36fSHuaV2NyvgiYuWlCjWWl
 eqmBHO7gfetVgmes1MArhWC5v2Tt6UQrvq4OHondEbiPiB9Ey1x0AWt2c97aLwunApPO
 8IX0FPbyOQfxbp+h9BtssP70RM2WwlxJDk/ZjjM1zSPWa47k+UAufjyXh4wnE5trtL6e
 S7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096778; x=1783701578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DX7N5baSLNWo28XL7Yla9xA9xJlKE33supZnlBMANrY=;
 b=dxu6FsQK6C1lszZTheQSXd/1s3Ic3iO55+Y/J51MrW90UF5InJReiTQr7m45JFiV1j
 CKsR21C8buhS7X6NQJcp28tiwQxN1/6+xTPswh20MdgPehpvHpmQVxO5eJ98qb9O2Lv6
 JiH8IN6T18xqS1aJNcSeiix8vWhkz9rZaEckMwfThb8tafRUbA9amvSSPoBFXr9CtALe
 c6aO/xlNeeMkw+/33xKiPeRIraU5GLDybeyJGvQ8FY/8/xopVoF+wkqpiWXNY4R17N3N
 nwCMtX9LlC9qNTQJW945JedX6cVgSAbc21DNYuApZn3biGMJRH0dMKxk/Wsl7QJG8hun
 05Rw==
X-Gm-Message-State: AOJu0YxM9Ji445mpvC8qF6KqZFu+M/UW4T0M9iA1WphjC5gmo6N4smG6
 Skni+X8v/GOVevyEZXXWN38DmHzvV+knGzr01P+S5UQB9hq4o75FdXiR80EiMryRVGTlxvi7Xhv
 lB912/FiROY0KDpZk/Aj6tPlana/iy728iPPiCRZj7ZcvUA2HCQgmTIWKuF0Q04qRvA==
X-Gm-Gg: AfdE7clkHMbw/2TJ1TtKzoO3WZq1zy672dQULF3M6LVnj3o2cMU9vLj1eTg/elu90K6
 4tv7gqGZMDLhDq9ZjRb5k+8+kyMrwrnAUMrWzjouSvwBrSVfo63wQHlSkNtE88fRQWsCrOrHh2K
 sttqapoe155nwBOmQdXbTXumAmhOwjAA+MhWXXpYDQw7/pwVdRYjvYV19qnlNzbeehmWoU2nqvj
 vkNHfQDi89Re4KUQ+6WmtM0VPzy3XLonaxXqKcZjg8yHBLGUCKPB9yZJUf6AeKrbNatMdmPJQlB
 rxtKjs6/R2yIPJWJafOb2uXPmrbYtz1+1SG5ED+E3kF8xBE665Vh4yzEwDZx1+bWcRvHA8pkN4I
 os7zKxxhsMlAFCaw0wy65YU3e4fLAjT27h1Ds+PbsE83jWSFiyQ4VtT8A7qS2H11Nxgjv
X-Received: by 2002:a05:620a:890f:b0:92e:8734:b721 with SMTP id
 af79cd13be357-92e9a3b8a72mr29558685a.29.1783096777728; 
 Fri, 03 Jul 2026 09:39:37 -0700 (PDT)
X-Received: by 2002:a05:620a:890f:b0:92e:8734:b721 with SMTP id
 af79cd13be357-92e9a3b8a72mr29553285a.29.1783096777096; 
 Fri, 03 Jul 2026 09:39:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm177457575e9.2.2026.07.03.09.39.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 13/33] gdbstub: Move supported_sstep_flags in
 AccelGdbConfig structure
Date: Fri,  3 Jul 2026 18:37:36 +0200
Message-ID: <20260703163757.55500-14-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXwqxcNHYa1g7u
 IFulPSjqMOX9RU/i55HMYLh5KzVWJ1PnaHuncyRgO31MzDGu2z+LZqnFDsxQOF/OjYdoyh6bRPG
 lxDBAdROxVTozGtR4XOxjfb0cIivd5w=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47e5ca cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=2uWoCNkfsxSLpB2ydr4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: U3OjT4eJuY0j7QedQtgAzXmsGlBdnx3g
X-Proofpoint-GUID: U3OjT4eJuY0j7QedQtgAzXmsGlBdnx3g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzZ5Yp43EMUCy
 5WGLwIrDZF4p801XF3sYszThfUoggO0wKlOx36qEtoOikkJx9Jk6R8+z0sLjmA8NXWOwADaDKEq
 9UoTXTKgLG7yTa7ZQts2On65v0nnt4RHzfw8YEUqaExrHOrdC+XvwGBRmxMpGBPSoapTTSP37gy
 AkIiGPLK53QsvYNW3UYsq676uXLu4QLe0bldGEWiXzIPwueS0Lqf8G+wrJw4oSqjRAF6RAIC6vo
 IOcGYrJgS5ycIRKzPKy25eWlu5UCdamBEnrB6EXo6XyCuOHPuQhi58+EfxpBagu2nKwHREO8C4c
 ytHFcgjOPcpXwyi0kxGG2aTZVreXNiRVrMV3c1ftiuhy9R/gFcl3GKDKEdIDyUBgW7rDk1hXH8Q
 GcgtG3Kh5SJ06/qncbBLcYhmcMzHItiCRxYE2anLyXD9D6RyZSyVNKAcllwzROf86xNN02ZofMS
 25AAHJgg2mrhXVAGHHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030164
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

supported_sstep_flags are per-accelerators. Move them
to a new AccelGdbConfig structure, still in GDBState.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h  |  3 ++-
 include/qemu/accel.h |  9 +++++++++
 gdbstub/gdbstub.c    | 10 +++++-----
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 60ddc146661..0444dee2246 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -9,6 +9,7 @@
 #ifndef GDBSTUB_INTERNALS_H
 #define GDBSTUB_INTERNALS_H
 
+#include "qemu/accel.h"
 #include "exec/cpu-common.h"
 
 /*
@@ -83,8 +84,8 @@ typedef struct GDBState {
     int process_num;
     GString *str_buf;
     GByteArray *mem_buf;
+    AccelGdbConfig accel_config;
     int sstep_flags;
-    int supported_sstep_flags;
     /*
      * Whether we are allowed to send a stop reply packet at this moment.
      * Must be set off after sending the stop reply itself.
diff --git a/include/qemu/accel.h b/include/qemu/accel.h
index d3638c7bfda..052b4c59313 100644
--- a/include/qemu/accel.h
+++ b/include/qemu/accel.h
@@ -73,6 +73,15 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp);
  */
 void accel_cpu_common_unrealize(CPUState *cpu);
 
+/**
+ * struct AccelGdbConfig - gdbstub configuration for an accelerator.
+ *
+ * @sstep_flags: Set SSTEP_* flags that accelerator supports for guest debug.
+ */
+typedef struct AccelGdbConfig {
+    unsigned sstep_flags;
+} AccelGdbConfig;
+
 /**
  * accel_supported_gdbstub_sstep_flags:
  *
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index f54415a9db7..31eb0ca6a5d 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -72,9 +72,9 @@ void gdb_init_gdbserver_state(void)
      * By default try to use no IRQs and no timers while single
      * stepping so as to make single stepping like a typical ICE HW step.
      */
-    gdbserver_state.supported_sstep_flags = accel_supported_gdbstub_sstep_flags();
+    gdbserver_state.accel_config.sstep_flags = accel_supported_gdbstub_sstep_flags();
     gdbserver_state.sstep_flags = SSTEP_ENABLE | SSTEP_NOIRQ | SSTEP_NOTIMER;
-    gdbserver_state.sstep_flags &= gdbserver_state.supported_sstep_flags;
+    gdbserver_state.sstep_flags &= gdbserver_state.accel_config.sstep_flags;
 }
 
 /* writes 2*len+1 bytes in buf */
@@ -1537,12 +1537,12 @@ static void handle_query_qemu_sstepbits(GArray *params, void *user_ctx)
 {
     g_string_printf(gdbserver_state.str_buf, "ENABLE=%x", SSTEP_ENABLE);
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOIRQ) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOIRQ) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOIRQ=%x",
                                SSTEP_NOIRQ);
     }
 
-    if (gdbserver_state.supported_sstep_flags & SSTEP_NOTIMER) {
+    if (gdbserver_state.accel_config.sstep_flags & SSTEP_NOTIMER) {
         g_string_append_printf(gdbserver_state.str_buf, ",NOTIMER=%x",
                                SSTEP_NOTIMER);
     }
@@ -1560,7 +1560,7 @@ static void handle_set_qemu_sstep(GArray *params, void *user_ctx)
 
     new_sstep_flags = gdb_get_cmd_param(params, 0)->val_ul;
 
-    if (new_sstep_flags  & ~gdbserver_state.supported_sstep_flags) {
+    if (new_sstep_flags  & ~gdbserver_state.accel_config.sstep_flags) {
         gdb_put_packet("E22");
         return;
     }
-- 
2.53.0


