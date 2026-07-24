Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92DD6C531CC
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UU-0004mD-J0; Thu, 23 Jul 2026 20:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UT-0004lc-74
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UR-000689-Pl
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:12 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLehiq949329
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=VpkCLinoXIN
 6ph95fB11SnFPUvtJM6GDDDLBdWsKLqY=; b=eTUGIBQwj3SMrRwJ917BUB7EDVI
 b6ieMDEIg3+V/XonwLbWbggCJljM22LQuloKMr3aQLdpQUIs740bTJ0xCANLF5KX
 3EC6JMr4F+BCnYp4LtpGs/vYlps9BE7LsiBSshwpqRG/q42h4D9vIwtOlirFpu6x
 zJYTY8T4ji1B9lj/XfSZZnXb0tZxmvIIXokZQOAYAq0lohRWLoJOfoH1G+IZC+XJ
 CDpJIQhBLr1cE7QMDbOfsTNly9WtgjhsVQlu6Zq2RiQcJ5nrD4x43SwyuEuHrXm2
 waBsjBmss83XQt2VSRGkcsynZOz4vlckyL4F7kPVSAub9AngDcFmB8zVnhw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kv2fg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb11535e6a1so1086435a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851810; x=1785456610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VpkCLinoXIN6ph95fB11SnFPUvtJM6GDDDLBdWsKLqY=;
 b=fuuEMwzue9JBh69FMEboHv+t1Gmi+gYgnIEmaj8hiN078oQDpfYakxDBpx8M7OtENW
 m2U/cesAfAthD2piXIfW3tA017h33+Q7Gucy2Pbt1TVFWFcLnNzYu9+UH91LSmb2NIAf
 mthkQGl0Xs/JdBWoJpz+3c7tgQUfnAss17qh1Q2LUR7GOx/xHueHedy3lXxAO45rJFwF
 K3KEfQeXbUBED/PWgQ5YeecAnQdx5HvG2fAKFwPyg+ZU9ma3hzJtbwBjDxXUfec+6CQb
 OY1Mx+PyGSU18mo/Xw2X0stj7VzWF1HkZDhYIR3gfuUXkZtj1Sj7KPe1wUut/x/lYJ9E
 b5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851810; x=1785456610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VpkCLinoXIN6ph95fB11SnFPUvtJM6GDDDLBdWsKLqY=;
 b=RjwyVkeefLRd6DeF4fBZ0ps7t7ltGvT/lDcy7igFeAooircjsF8gdaImXL7z5gp1uh
 8MRk+3AU0wvZsETmNHZhGXKoxA+wre1AHk2/8fot35JXq8ljdRX9lllGXftNSodu/ABP
 47st0dkdonR8PPB48COtfkD4s1j1qJap6G6MLs1UvLMfnJceyZitS2yPRoOGOocg+V+h
 KZPcQEluRBb1YqIih76fpRwxmuvSFS4A0kDBquwwrTn3wi+ruJogSPia6mlbJkYEo+/d
 ydO++dhkRCGcwaz9HD1z2vI7GBqGFRkUWGo2ZFGSH4QbZYVHeq1ZSGqlxHtQ5VqYm42L
 /6jg==
X-Gm-Message-State: AOJu0YyueGzfASPJ1Z93UFktaUVTME0BMB4zAtDhABui9JrfNyYb3SLP
 G0JSAS+psR+bYbCJNnxty+UA8Q9HuKEQ1d1aUrYBWuk3I725DgZmDvhwl41HU6HtAvVDuONjmc5
 j4NQFd5SY0QLPOd8CQDIijOTfnEXOPNlnddMTNor+kjuLanceuroiNKe4tECUbpTDaQ==
X-Gm-Gg: AR+sD13pd3/yphauPlbShA/XzN2CV2GT86TY0L0QGpLQlx8R708KemnaMMEoi8YCMyj
 DlIM3ylQFWigJhRdLk9VmX9K0D6WtUleCxTED6bdSScZZfTaq+16r8bjgxk+oyDQVbe43VbDdVb
 6OFD4H16L4UufUQ1a0U2YuYj94Bn5bi3RHZbtR3ZZbLru8dQNqyLcXK86bBYzcWixR6ykTioMPw
 SzL6Xd0d1uIldC3uJNuPhkYj7H7UZYS/AhhXOHSGwvq+wiZh/W6wk6Tw6LOpTkMKtyng4DmO3Xy
 r4TOg2UJi1CosXHJhV8GgaWcgGr8W3bo+nS6wb999VRXmjTDY2svCBhHF7zcXHXi/Fi/RxS9wC9
 A99rJzaCEJs6oGhDfhe0bBOnG4b1VZztBWgvPzi1nHbSOwMqIm2BlUGXHgXF+tleGvlu0Qmc=
X-Received: by 2002:a05:6a20:2591:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c44b06e27amr5529356637.32.1784851809908; 
 Thu, 23 Jul 2026 17:10:09 -0700 (PDT)
X-Received: by 2002:a05:6a20:2591:b0:3b1:a9ce:507e with SMTP id
 adf61e73a8af0-3c44b06e27amr5529327637.32.1784851809534; 
 Thu, 23 Jul 2026 17:10:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 10/27] hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:30 +0000
Message-ID: <20260724000948.234657-11-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: xka87WNXa8JTsi9FzudjIiNdYnadK-Wq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwXlqxbBQQNod
 pvb83agcsuSXei8qlchx+AMc2E18XnFBt8OCpobhyqHkGn88iuG4W8hByttmpmvmtv/n2gr+Hn6
 m3IcZEM4a1DVh8QrJfsxwiYJx0b/87g=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a62ad62 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=V-MMSkP_WKV6QPw9nakA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: xka87WNXa8JTsi9FzudjIiNdYnadK-Wq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX3//r2Lw3OFsJ
 fteY3n11l5INEfcwGrJNLnaiy34YS6CNWzRTAArNs8DN6qw9TBeMaSqhsLDhiW9Xz0gvcunPJ+b
 V8fAG2gioqy7voTvjVfj+vNqPcFcZm0m/qCVArl8d8XOMW69fUB61JDyDHghgbn2jLOdXg48DEI
 V/dCf0Ef8s7UpmJKWwNG3BlLWLTAonpDR/XUutpzzQx1+q1rnx5fZW0yZgCrE3b4HplWw5a/5Lb
 4xkIIa5gpeFh2Yr6fiLkSHyU1mgxZT7UBuQBUPxe6tFlw0mo6EMwBL6xOm0TW47MlyN53MPZnIv
 rog3JkZ1nt1bGzXZ5x6VZ9zebdu8NQP5CZqCud0x6izBlmGh+42L9KimQDkaNXM1nnqeAdY/kcc
 Gi9NiOdDDHNSjaBPf2tdHZzyRw0crEXAYurW3U/RvNAjYPz4qHWZLBlPmXh86C6zwl1avI0llS3
 dR0rtiG6XAf199V9iWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/xenpv/xen_machine_pv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/xenpv/xen_machine_pv.c b/hw/xenpv/xen_machine_pv.c
index c406821c34c..40b975d0e16 100644
--- a/hw/xenpv/xen_machine_pv.c
+++ b/hw/xenpv/xen_machine_pv.c
@@ -63,10 +63,11 @@ static void xen_init_pv(MachineState *machine)
 
 static void xenpv_machine_init(MachineClass *mc)
 {
+    TARGET_SPECIFIC_CLASS(mc)->is_available = target_config_xen;
     mc->desc = "Xen Para-virtualized PC";
     mc->init = xen_init_pv;
     mc->max_cpus = 1;
     mc->default_machine_opts = "accel=xen";
 }
 
-DEFINE_MACHINE("xenpv", xenpv_machine_init)
+DEFINE_MACHINE_TARGET_SPECIFIC("xenpv", xenpv_machine_init)
-- 
2.43.0


