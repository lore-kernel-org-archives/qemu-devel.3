Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA53DC5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 21:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuGMi-0004ar-PS; Wed, 12 Aug 2026 17:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMh-0004Ue-DA
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wuGMf-0007xV-NZ
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 17:19:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK2b6N4038350
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 y52kfZzk7yEGBWT0Tv1PNp0kbACCLm5xxPwX+55JRIE=; b=SGXVkeGDNXe8jfZ8
 SzkGZbHa+hk64RY9jVMCSitr4hxhjMwgdGehD3YDunzcPcBtI/8h5EbgkzetmO+U
 B7nmdzrXc5hNAJ29sjkU6Vi9r8IJrcPQMtcVvFTvCvvK/8DfaBHxMWohQcQFkgkP
 VYwRDAwYzUl1mha9IWvSJQgGhR2vDj7qQj2Vd6qDHwm2Mt8B2rjLQimgsWyudloE
 FHXwmcq6xn9hgE4DuKevHUyFpEuTn3/lTlLFqQWl1oL9tdI3fUmkLFRlzMdlVj2P
 ziCkTDNeIAscmCRn6rXJnoCbzHluLVb6Xi8dugHtAJ7IoeDrwZI/Q1rMbfBPaotB
 5Zxpsw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0mndbft9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 21:19:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c19493ac2so14038641cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786569595; x=1787174395; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y52kfZzk7yEGBWT0Tv1PNp0kbACCLm5xxPwX+55JRIE=;
 b=Id3Ciq2PH9u8BXYflHkC0sqPBYB8utpkmKneqNoGMb0KaOI+Tpv2GVdD3CGPC7WSzw
 aEiEg4TI9J5msQn3mTy+7dfzi5B2eGpbLvOCDINpKVlNNtlfRrX2EvLh+MUxWA3Qf3xC
 flIji3nZdCVEJYxkOEuN4YZhI+c/k2y75uvjRmjTL5eQ0BhfTVIPEi6o0b/H8i3YHbaE
 6/7eIPHYxMQwwkU6Diw+sxsrEC6OAGueSmmeLQEyQ0pVPyxxDug5YU2gYa+eaJD+32+f
 V+/SJSIU4zKyO9sFEycYHS8v8ANyDhv1D7H5Y3d76knSI7dHrEL9Y0LeuQ2Ym/32EV46
 S6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786569595; x=1787174395;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y52kfZzk7yEGBWT0Tv1PNp0kbACCLm5xxPwX+55JRIE=;
 b=p2O6fxq7wvYAKhiFDuvg1yS1mnFmalClnSLmbsYHuXxjQVpEvfblt4G1UrJPYZEyco
 NiCK7X0jYJphik9Ld9BukUo5mcohAmDgr5/WqKInytslvMrAi2VgNieldl8V4z0YM/lz
 /rcws8W2bbQgjxbTgWSwD5kKbM0q/A46zOfFERKndIk7Hkr4eMB9SQO+jQ09CgIA++d7
 CIiCjUL3l3Pb+5RogtvUAd1K/BdjaqhKQo/a9fB2DENjkPDlcn81Etmv0KD/geynphSr
 LXuO2xcDYXzOpP/d1U6qeQOkTuAB9nDIXLUCm5wVMdeFQYXOMPQ7IK6K0Y4PhC/pflck
 Qt9Q==
X-Gm-Message-State: AOJu0YzyyPKmHP8wXKSsFmRNkzrXey2iCG+k9M3LlOMVbFKmIKyzyuK5
 5dZ0Wz5xpCNSBroBztJfu0vJ32ifcPNCwUTp5qZWQUBHDjNypdXTjHiQM3l7NLs5h+CqIeHKwfh
 mXh721K2M5ZG10kGERVFKs4Wvl99GyGmWArc6xckdOpyc6lxT/QtcS306Q+g9VTeOaQ==
X-Gm-Gg: AR+sD10p1KYi/Nxp5eWI6Uj7wsa9uz+0OPEGyxsDfvhQbHiLkij3SSk8IWOZA1wrLMg
 YUQMP8xOPHhL2duYJYziYXBaVyNAmdMRyFRq14ij7yDcnVKEp9fw5vShRPeVH7blD18EsOoW3HY
 qj5o133Vz+czHpG0fTAXYmWOK7NRaBwRYUtbqr7YPwX3tyTenBJxA6qglnL0XzXV8UJlwHJyF4D
 KZ2FfzqPXgAzfvBR8B5c1UjHCZSqiPPzczFQso2s48fA4QRMdXrwBZAzgBfH9PqfAjECBfEfm3Z
 dMjjgzL3fiBn6kE1TjfRNOWBxTJC37p2QplMWwmLOo50BVDvGR2N+ShwECARRzS3nSaY0WDbFeg
 J1PbSchnTfcG+GhNpqfy35t1rYe11VAmLMnW9YACI8w==
X-Received: by 2002:ac8:5715:0:b0:51c:2554:a8f5 with SMTP id
 d75a77b69052e-52d73d73411mr11200361cf.36.1786569595428; 
 Wed, 12 Aug 2026 14:19:55 -0700 (PDT)
X-Received: by 2002:ac8:5715:0:b0:51c:2554:a8f5 with SMTP id
 d75a77b69052e-52d73d73411mr11199841cf.36.1786569594864; 
 Wed, 12 Aug 2026 14:19:54 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5af13csm535615f8f.21.2026.08.12.14.19.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Aug 2026 14:19:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 22/23] monitor: Replace container_of(MonitorHMP,
 parent_obj) -> MONITOR_HMP()
Date: Wed, 12 Aug 2026 23:17:06 +0200
Message-ID: <20260812211708.92824-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812211708.92824-1-philmd@oss.qualcomm.com>
References: <20260812211708.92824-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX9cXhwjbHMmzN
 LMyCDe0duA1qHRitWk9mKfFF0B8ccaLvBVI+S4wElitwNSzNJ5jZSVwSAljTHiLEi6DNUs5oT6I
 2z2h4p6/YUp0xpAoJxkDNOk3xi4EilE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MSBTYWx0ZWRfX48omq8GSwk9h
 YXi9xWpwkm67JTrRwubuNxmgHbz8ydadPswWwu+kL66CEnfqW1A3uCQgdhanHfVewveVopsF4dh
 ohhJfHFQ/GFn0mywkCFm9NTdk2HWNG4IBp6CceOB8tI2OK+Y1Wv+QtbehUfhBFCY/6F7cPvQO7W
 e9sKZAp2u/vcu9yWu5H2oFmEJvyioNy9uQf1jHSe0zZ9cIThFkIxMWHLTfMjxmHDy3CygyyRsnC
 zVct2IFOPL8dKRgCflst/gDMFqEXg6eoC4i7BRbeaDuSyZpHkgX5dhNNyUVhCxf7HjdeLKHTUbe
 jHJr07tXHDWxY6GocnMAkpc2WG/Lh/Npkrmr7Pb2cVxI9exeFsG5ytVM29L6cv22Ldm121IwqEh
 iI/EnOOVb70yU2dzfBDv9eQ6tmJARPM6CN6Ku3bYlT83jteHuz4kbtoQwKbizc/HUaK7vlcE+Th
 hdSZETIgx4Htb+aXhqQ==
X-Proofpoint-GUID: X6kfg6B8UmaqmmDP2c1bgHY-3jKlXORp
X-Authority-Analysis: v=2.4 cv=C87ZDwP+ c=1 sm=1 tr=0 ts=6a7ce37c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=16vVVadSk7Frugt840YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: X6kfg6B8UmaqmmDP2c1bgHY-3jKlXORp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120171
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

By replacing the container_of(MonitorHMP) use in ui/ui-hmp-cmds.c
we can remove its incorrect inclusion of "monitor/monitor-internal.h"
header, using the public "monitor/monitor.h" instead.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 monitor/hmp-cmds.c | 2 +-
 monitor/hmp.c      | 2 +-
 ui/ui-hmp-cmds.c   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 71d7df6d013..19d71708394 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -290,7 +290,7 @@ void hmp_info_sync_profile(Monitor *mon, const QDict *qdict)
 
 void hmp_info_history(Monitor *mon, const QDict *qdict)
 {
-    MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmon = MONITOR_HMP(mon);
     int i;
     const char *str;
 
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 428ef014284..4eadf7c2e7d 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1523,7 +1523,7 @@ cleanup:
 static void monitor_read(void *opaque, const uint8_t *buf, int size)
 {
     Monitor *mon = opaque;
-    MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
+    MonitorHMP *hmon = MONITOR_HMP(mon);
     int i;
 
     if (hmon->rs) {
diff --git a/ui/ui-hmp-cmds.c b/ui/ui-hmp-cmds.c
index fb13eca0b0c..eca3a82003f 100644
--- a/ui/ui-hmp-cmds.c
+++ b/ui/ui-hmp-cmds.c
@@ -19,7 +19,7 @@
 #endif
 #include "monitor/hmp.h"
 #include "monitor/hmp-completion.h"
-#include "monitor/monitor-internal.h"
+#include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qobject/qdict.h"
@@ -343,7 +343,7 @@ void hmp_change_vnc(Monitor *mon, const char *device, const char *target,
         return;
     }
     if (!arg) {
-        MonitorHMP *hmon = container_of(mon, MonitorHMP, parent_obj);
+        MonitorHMP *hmon = MONITOR_HMP(mon);
         monitor_read_password(hmon, hmp_change_read_arg, NULL);
     } else {
         qmp_change_vnc_password(arg, errp);
-- 
2.53.0


