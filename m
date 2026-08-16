Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CF7C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcBF-0007i9-35; Sun, 16 Aug 2026 10:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBC-0007Jp-EK
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcBA-0001JV-Mc
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:49:42 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkopd3609470
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RssthFJr3Lbp/3ckbKRAPHpFj/rb8+pnvpVX35IpDPM=; b=LvNpfLJ524odi3gY
 L5Xuwt1MLHu9DaAZ5+YsNOjAod1W3hr298o3SjIVUZy0GraZB1IW/OkcAEUF3JqL
 woY2RyfUGY24Es+yebFypxqONDoO3eS4evh0/XbKBvWFtmET5VWhd1erdR6fCEad
 lXgu67hh5LN7jseyhp7VxdqH5swbCj5pM26TzL7Lo3cnijvMgEzcKGDULhJhWivj
 Vm9p5p3yc4hiwMOSB5KnJuKJtSUCQrbnPY+WDMYNldmoAGXAc4MHATw8jd5EXKOw
 LoIXKPczSC6mHmr0g4ywu1QeJa/qMw3TSOTsA9kbO8KzlVY4ScsQ2XEg+YB/kxgn
 /TPA2Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghfuk3p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:49:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e5fc4c7e9so334233585a.3
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786891778; x=1787496578; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RssthFJr3Lbp/3ckbKRAPHpFj/rb8+pnvpVX35IpDPM=;
 b=RslRkcWHqKKjXao0FHZH+fSRa+55TtodJl6prFkbTHmcSXrs4NiikjWAl2qLC7F7IZ
 Pcu0qQahnAffdMiHPdbSMytj2+s5w7ZwDEDAgJAUtbUiPYODe6aJo6XMh0/YChYWsCf0
 yB0cYok1cBUa/OFxfOFtxizFI8NWOLJRpY8in2euRdUclylaYx4GBeKxvqbrDxD7eMmF
 RnQaPi4i8r4D8+0XaszKdTad5ftnULGg7xgKsf6fEZBDNGhlL6uAjCtiPBkY/UDpeQYJ
 hFSdOyOEjjNXih70krLChJ2Ar+lo8ukLCaUq/seSgHnaz8Se7QjXo/RpemQWOzgI0Gxg
 q9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786891778; x=1787496578;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RssthFJr3Lbp/3ckbKRAPHpFj/rb8+pnvpVX35IpDPM=;
 b=Bj8TFU3C3WBtSndOiG55muYtGpWy2OikLDr8Xy7R7HShLR1LR7W9w5juGiJoTmjQqP
 A2n0uT3qP1S1NQoFlGtfKcMaQCHZsMTPPbw0ezrWNsGojSLc4Pi+qICPUukVaYD5R6q1
 oV2zWv/3LDc/14ZvAMhMuN0SGXcFakFmjZ6zKGd4g5txRBAbSkp8Pa1lZRS8dyTAbJDK
 OUEwQE0Yo6OuL7dK4eQ/IdUaSxHLl60bArqED2JGy7curevqdCqu0Z+RRtkO9hA18ErS
 9s+R4MA5as7PgNG6Zi3DCnqz11KEVxsXVKan0yevQtanEVdkd5jXAbOpYEFdd7XriuP0
 N8AQ==
X-Gm-Message-State: AOJu0Yybz0lFcRoGQX6Flb62UYSv72KSG8BDBmPKJzevcdaYVNsZE7g0
 kNFqE+QZJW7IIfGABAP9z2qhGoMQFbVI52sXHnC64sm4olyTxePfzxNQ/90NPogGTbbG7SCXYDA
 5PoISQPvI89Ok89VjeCQ/5x0wGDTYwprVep18KnPlDWDacGMG9/FiW+uYH3WPuYNZzw==
X-Gm-Gg: AR+sD117Y/I3Py5WGU5sXUFOSDjkG9v6H/Craq5n9pRVlNuF+UWFeOZVzimqCuHOPNH
 gS4pYbtizcxy/u+aVXx/zaikTcfiJfZ2CJMtfkNMY2xfvhxiy25WjD0UFcFDJGQcNkHq/atBnbT
 w6DtaVlagVPRrZ33XxlTRHkUB51XkWJFayFGdGAIRHesLVfeW+7yhINU+y6eNBh3ZxafD/qqNfv
 OEiHW3boU2Refe5tLs3G6mEgoLtfGHceR0PI6Lo1QizLIBeGhe7sd91tvRNMusPB388/JN/Kz78
 zULm7uFczYY+ergDM5OI1E/MAqadBLW+CZ6c+nplPVfz7jlgaoUejIiM8CQ3BsKzp/c6cr8gDKq
 z82Zm3uYkVj/2sGRgtLVR1MTFRPPB3rKFjQKiviKEnw==
X-Received: by 2002:a05:620a:800b:b0:936:41fe:2351 with SMTP id
 af79cd13be357-936d22e74f3mr2236372085a.30.1786891778143; 
 Sun, 16 Aug 2026 07:49:38 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:936:41fe:2351 with SMTP id
 af79cd13be357-936d22e74f3mr2236368185a.30.1786891777646; 
 Sun, 16 Aug 2026 07:49:37 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999610e381sm72825185e9.9.2026.08.16.07.49.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 16 Aug 2026 07:49:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 26/56] hw/cpu: Rename cpu_exec_unrealizefn() ->
 cpu_common_unrealize()
Date: Sun, 16 Aug 2026 16:45:25 +0200
Message-ID: <20260816144556.69009-27-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816144556.69009-1-philmd@oss.qualcomm.com>
References: <20260816144556.69009-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfXwYGJ0FUkwSt1
 /MYMO/oyYr1nBD3oVvJIpJYKbwnqzWh1bE8XdNjRoC2Ps/wYDuiWqkqTs2aewoQN9NnC83UL6Oh
 rNXV2iZH2ZcKKjI42DaMmuHAQVmR29c=
X-Proofpoint-ORIG-GUID: B5x3FLBWGoTgDxXuwQNEtGQHUWkKRcEy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOCBTYWx0ZWRfX/7qhWyFjqCg3
 EOUg3IqbWm9Fm2/dtL+LM0rQNN+ZpdDThmS+u+5beZWH0TlIF0ETR70JvyF0VCD0rdwp34VXaBd
 NMG5I80IMlL9OSDm/BPoZ0xPMmAaPdf0Rinjjmrjy/ZWzloOtj+P841VT5XgpYugGK7ID8DZKwv
 JuO3BMU4A8dwoFO7Nof6OvxdAVPFufdFJnio9AeppoCxOWSYUMKV0h6CPiyMhCK/mN/zYkn+loI
 XM9ng082JmKpzXGm+ITh83GsssK+RnxOxO2C/iTN1ibh3J2UqtSKJqKAAT7r4eX4E9DLYuBtn0H
 hmpOI9AsUZZZHzXAtHmMG8tNY7CDAcHcuyMdTtXjEEiKKBUWffGkend4rhU/kp+oWXGZ4TSinhS
 wYun/RUU5qgBt9hgmIiiOXfiim9qie5roKm8/+mSUvtNJ7aOZLP7a0yxngrkebSP2bFCRFkhc+F
 YeqJDlFHT3LOJFQP43A==
X-Authority-Analysis: v=2.4 cv=TMJ1jVla c=1 sm=1 tr=0 ts=6a81ce03 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: B5x3FLBWGoTgDxXuwQNEtGQHUWkKRcEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160118
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

Keep cpu_common_*() pattern for publicly exposed common methods
used by target code. Use cpu_exec_*() pattern for internal ones,
mostly to distinct between system / user mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260811183410.22428-7-philmd@oss.qualcomm.com>
---
 include/hw/core/cpu.h | 4 +++-
 hw/core/cpu-common.c  | 4 ++--
 target/ppc/cpu_init.c | 2 +-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 7b7cf330cde..81af7b9ee1a 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -1180,7 +1180,9 @@ void qemu_process_cpu_events(CPUState *cpu);
 
 /** cpu_common_realize: CPU DeviceRealize common handler */
 bool cpu_common_realize(CPUState *cpu, Error **errp);
-void cpu_exec_unrealizefn(CPUState *cpu);
+/** cpu_common_realize: CPU DeviceUnrealize common handler */
+void cpu_common_unrealize(CPUState *cpu);
+
 void cpu_exec_reset_hold(CPUState *cpu);
 
 extern const VMStateDescription vmstate_cpu_common;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 732e32fade2..59cd489b713 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -284,10 +284,10 @@ static void cpu_common_unrealizefn(DeviceState *dev)
 #endif
 
     /* NOTE: latest generic point before the cpu is fully unrealized */
-    cpu_exec_unrealizefn(cpu);
+    cpu_common_unrealize(cpu);
 }
 
-void cpu_exec_unrealizefn(CPUState *cpu)
+void cpu_common_unrealize(CPUState *cpu)
 {
     cpu_vmstate_unregister(cpu);
 
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index b07e9c3ff9c..e3a1075aad3 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6956,7 +6956,7 @@ static void ppc_cpu_realize(DeviceState *dev, Error **errp)
     return;
 
 unrealize:
-    cpu_exec_unrealizefn(cs);
+    cpu_common_unrealize(cs);
 }
 
 static void ppc_cpu_unrealize(DeviceState *dev)
-- 
2.53.0


