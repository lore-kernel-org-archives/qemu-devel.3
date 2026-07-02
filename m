Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB442C44500
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHqN-00035A-5M; Thu, 02 Jul 2026 09:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqD-0002u5-Mb
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHqA-0008Ef-0M
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:52:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662DccvP564731
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=; b=Y21unVCPTkPp4Y2Q
 Jkg3FuVZ+JrJH3uuX5ZggGBCzDMz+l4D64A9JxO1fjTa5s0b22kUmveqFS4AKmbP
 g8sSr1Ifoe1X3jxeVQtWNxScP9SaLdQ0ytdrQDLQgOQUuU1GMSs51QLWBlWiFIbC
 /hH2FMCN06/TBCzcAcSsnlKAkBbALhVmj16Z7VDyAj7tj/uR6+0RXjID2sgafwbQ
 u69J1Bl3OntbyTxgwlS/1nXrnOSSE20VS5Ccu6ZsaSokgMbpSl1Xn/g+vyWBCfM8
 ORiS1sMuEauU9BIqxokiHK6P36leil0zLQTst9xBectvjB9nDyTpqWo3sSxDV4+0
 BGrUEw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5s2501we-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:52:18 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9692595fe97so442322241.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000338; x=1783605138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=;
 b=HNWlDdTj3SWfE1JkXLSnbhS5KJCM7jxMyvWOICf1C3NVVlZMadv0T+qcnCZX46/SZV
 kcX3C7l1mMp6eaLFwhwhQlkS9KWczZPZDzj3xN8v/zRbqtirqWIHh6gRy+9diVV5I5iJ
 guVTRJnjFkrUt4okp8zLmPfYnEdiNVWcXYzyzOCPo3OjirHVFoFa5dTGLFbslK7d5gR8
 +gZVccYuvKJ1MHI0Mv06Ad/g9BxHs+u8w4/ZrLYWl+vurCcbYU+GgHUS0TelxUMx/EL4
 0RYbh2l2po3dePBp+2Q6QJRXo9rLruLBpORPxQexBKb1DqFSr+MhCq4ozH3aXBpQaRRB
 Zqaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000338; x=1783605138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DMsulMZdTNgEhpkZipVmmogcRVvgw5giFw0hExul4Nc=;
 b=K4BCHPdZqsn5jwYLCRd3+UPg4XbnHNk5UtpnC0hqBj03+34OFaVwF11do9cKekN1X3
 ozEmC6w2I5MFE7i2cwu9lqWM0FKwTkh3qauvWMR+QJSztNCXnbc6m2oFapiMsRUTgzZc
 XGj6voaPVe/pog4Hr2T+0NlsPYYEXOUg0b37FRcXML66XWWSGlqi3oVZDS6I3APmyB9h
 pLBMgfPTcHAINBVBKr1E2g2PhfZRkOGtyuPhk7T6+8xGPQlSeZE2j4LKGWx5ahr1Kyca
 WACVmE6mondGcjTRjpa39W/BnhtfARl+rUQEAubZY5FY8euEuHKlRMqDmoIJIyIuFB3y
 T04g==
X-Gm-Message-State: AOJu0YyjA4o1q5HTDUL/vVu8EOTYnoHZqF2OEmE/D2AySQYb73UXMXSp
 xcn6kQAAJcjRRo467566PCI20DZ/HUavyLPie8IycweXc60i8LV3nmov7iyvbt1NdV82vTLoFMe
 /FW37ZtuvPpmNCyRhIZMy+XrskDcGf1fBMncVBePK+JUywrCNJvLKcQy3ejg7E6RxVA==
X-Gm-Gg: AfdE7cm3nq883Esvsbxy6HX6qVJNz/XkIDp8dLZ/40Clb6nrSMuU/xPV3q53J3rxO6L
 6wtkoQzHTfVHoKVZwa5o0lkysHjonQpGmHtRiI62cTwReskSNWLRQoW/0D/PpIxdsoEcrSimlf1
 BplgVR+WBn0Fv4ArmAz1eIgumz9rOFhWJ1bvkp2umz7cEtKlvVy2RhmEfV2Op++TAE3G3ExOZ25
 s0DWLF6TfYduVtxjMTRDvOHV+eCdThA6BQmPQ09s07dKTElfBS4gL5ePq95Yji/4rSkp1p2fPrW
 HAgDjw7jXbc8BnywDQplCz/BC//zxUSk13ETC91BUdrZOa3OrysRXUtT+LTfx8hgMy3KLSmQR1z
 xCdICPAL2QyJ03UYEosgwtrtHl3EgYaoZoC3cgP5+oWowvg==
X-Received: by 2002:a05:6102:80aa:b0:739:d787:be8 with SMTP id
 ada2fe7eead31-73da7bd49femr2752306137.9.1783000338335; 
 Thu, 02 Jul 2026 06:52:18 -0700 (PDT)
X-Received: by 2002:a05:6102:80aa:b0:739:d787:be8 with SMTP id
 ada2fe7eead31-73da7bd49femr2752281137.9.1783000337364; 
 Thu, 02 Jul 2026 06:52:17 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:52:16 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 17/24] target/riscv/cpu.c: filter TCG only bits in
 riscv_cpu_reset_hold()
Date: Thu,  2 Jul 2026 10:51:19 -0300
Message-ID: <20260702135128.1188021-18-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=6a466d12 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VLRNWGNRl9IGrp3TKBsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: kdoa4tJqLbTy3ajQvHNNL3HBQg9AIXH5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxifK//DesagB
 BdPnXrejPFyhtKOqn3iDo5IrcmEZgtCY1sxyz46lH27VKz81p8h4smxMmr9XcdReLzcwMLgBSuc
 VlrYqjtw7X4tZvavxg20vag6osohBTsZdTic5apXpizGpmSyttmjvgctC9wYLXMi9AwmcngLNVE
 SZ3ce/PJ1Q91t0qyjZVmwnUTqcMxuqUGGrqBVgKMTlIpuHHD70LVQDvJih3HmmEs54wRCziDPv6
 8ebGV8Nsovf+RXU6ddYmWwGE2EKkOOevUAB9tXMFkM9ByF/yMWOkogwG6U/8jDlVrDT9qu0lhou
 LpPY9YAcZqo2C0TgRg/FO5luf/Mvy09+EoEbq9AVO7XM/7tR7fMxMTMvzT5MTEB4yYwgIH2Ph0n
 8I0G73FzR+DuHsERgWZcYLA1tg3aTohYxAAFsq+C1BYxtEBaifH4UiJeO4WYeHSmefkRaBVZdsj
 OTnBiQKaP/Jdb1sechQ==
X-Proofpoint-GUID: kdoa4tJqLbTy3ajQvHNNL3HBQg9AIXH5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfX9nphr/jrAluj
 66CU3cNYzASAs7l2TKy5/yjr30PS+02hCJoWR3pv9wbsg7CtfZEBIv2IgKF4mHpUV5KCa4w8AXi
 7HLhYhneFn4zKpz7LWC+asieimKpfdI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We have a lot of TCG only initialization in the common cpu_reset_hold
callback that prevents --disable-tcg to work.

Put a CONFIG_TCG ifdef around those bits to make the build work.
Eventually we'll create a TCG specific reset function in tcg-cpu.c but
for now this suffices.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/riscv/cpu.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 6b79dcc5ee..5a82e6563b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -965,10 +965,6 @@ bool riscv_cpu_has_work(CPUState *cs)
 
 static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 {
-#ifndef CONFIG_USER_ONLY
-    uint8_t iprio;
-    int i, irq, rdzero;
-#endif
     CPUState *cs = CPU(obj);
     RISCVCPU *cpu = RISCV_CPU(cs);
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1020,6 +1016,10 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
                     MENVCFG_ADUE : 0);
     env->henvcfg = 0;
 
+#ifdef CONFIG_TCG
+    uint8_t iprio;
+    int i, irq, rdzero;
+
     /* Initialized default priorities of local interrupts. */
     for (i = 0; i < ARRAY_SIZE(env->miprio); i++) {
         iprio = riscv_cpu_default_priority(i);
@@ -1057,11 +1057,12 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
     }
 
     pmp_unlock_entries(env);
+#endif /* ifdef CONFIG_TCG */
 #else
     env->priv = PRV_U;
     env->senvcfg = 0;
     env->menvcfg = 0;
-#endif
+#endif /* !CONFIG_USER_ONLY */
 
     /* on reset elp is clear */
     env->elp = false;
-- 
2.43.0


