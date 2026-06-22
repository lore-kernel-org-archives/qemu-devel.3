Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDECCD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 19:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbkUr-00039c-1Z; Mon, 22 Jun 2026 15:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkUp-00039T-CA
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:39:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wbkUn-0002vu-SZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 15:39:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaf9v2176433
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=N33YsxfUbNn
 Q1BMGZTsmV+t73YG+r/2wROA5bZF0Fpc=; b=hEhAB2wE+U7J9h+5Jl3jHCZQGcQ
 T7LBRDAFIQMUoNThjabN5+kY/QjAn/8wvaQCEunU/J5mXvYggSycvdz0tPSEbi3H
 yOF/86oOufzM/57bj8fkMqhICxyrCdiMwZp3sZMCylo06tLIqXSKsecGI9CPCH6n
 YZWbdC3iNyrVhvqSI9gz/XgYfIbztUloZtVuCK/Fp3A5bpoOCDgBaqI3LGK6tuV0
 L8ds5QrGbWHXpf9a9jjytxVPe+b6HTtNvJwtNbaFKgabmE0dMiUWSmxuLyz6un1r
 6Tjb/BXc3oHXZq86tV6PwVQsFlesNI38Z0DIrbbPqhZN8/tSAUJI0VLGXsg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey37ha02a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 19:39:48 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ddefc5be4bso86281976d6.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 12:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782157187; x=1782761987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N33YsxfUbNnQ1BMGZTsmV+t73YG+r/2wROA5bZF0Fpc=;
 b=ZCaga9t6rpcWvqtV9A5NXDjFo+XqntwB9IUpyvVo3GG/XuWA76/GxnaRooKNGyrSPC
 MmkX7zQmnGfaNCjcF3J4feTlVm2P837lrZMqPCMbbBarsRl0WAkCF1RJMJrka5nSM/T/
 r/WpO6a0L+HXbVMfVd4wzqOhQZt+pZLpjVbJDTD9ThYhvp4e9FMUfX4qPkbmbmvynx6B
 bps/lViT4sjXiv5u1se4KgRJ3cIsFaWmaNYAQFnu+Uk4wTVXzynLwcrzoMWbH1GGJaD+
 SSX94Gcjnpc8ZrFxZjlHjUhhR/4SJn5OKmoild/izrcN1gze4/OkkrlrZvkuwv1ALxdP
 aDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782157187; x=1782761987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N33YsxfUbNnQ1BMGZTsmV+t73YG+r/2wROA5bZF0Fpc=;
 b=FSHDCIh399daZQRPy1VWEGZbH3MubQkylW5DZffjLzaQ2aL2dF7xbhvf54EpGla4j0
 67+kmQqNdrrUMiOr3+4NpuCGDn1IaaHS2ShgNvebYVwy9pH9Mm9GU4MS/L98xyI6SN22
 HRcDytO70zBCH6kPq8MzB0wkMXKAjLlROTXB2kVeW6L3J1Ka1n2KUSinsPCJqkciZ6I3
 PurAcC/pjQ1ln5mkMYOrHv3gGm175jB/MPtm4fgDN1tedBcFPlzKOQi54fXwOhqGvxos
 CaDehALuZKftwHEuIsC9zG0sSfcesmL7bkG8+uIpFgwg6Qkn5nCKkZnUMNnHhQIS+q2V
 zjKQ==
X-Gm-Message-State: AOJu0YxPgmmp6x+nLHkPwa6l0JHCcnpJJDwjQ08kpmAw3fYcxRdB8HPN
 aaXO2i6GPi3vub8ZB3T2LLzIWwehQ3LYf04tOM+4qqzvN/hrWVS06M0OhVcPBKkRuM75oKE403/
 BwvFrcE/ftDoR3lDOLpEBhwUMX+BdETbQwo3s+E1Wfi+Z3yU2PMs03YaqdvgZSI+6tw==
X-Gm-Gg: AfdE7cm+SjK0WQklIjtPMPxEobezlI9K+f5xK4rzk+qSUeN2MtHb+dQUqy4EMEUrps+
 /4kDwzx5UJ8cMCavvQ4LnCgRsyOf6dW4rced+X6JVN+BxW/FxYBRnXs1hPqY5fRYAPS0YXeqSUt
 XMp6+cblBp8O4AhhLIdq465CYLIA0BP4+k7M3j17d7ce0MVwOKWsVDksGw3y4rcczxgn4PyPmGC
 AKisnG/SQtZP69Dw6FR1bOMejURSgdX4LfnXMK0DUANsWYiHTVTLZ2CdSXqN/I0ePMG6tq/Et9l
 KhLSKDlftALx/PmYcjCHct0FEzBp7bv0VepHp2/ktdXLhYzqsGyKKAXu0FmJCL5kDHI4/8riTrm
 XTbnqnaHK6h4wWEw6/9btJCQdRTpqWP7w72uHQVu3McTVfw==
X-Received: by 2002:a05:620a:4445:b0:915:77d0:2ceb with SMTP id
 af79cd13be357-921cd9036e6mr1755076885a.0.1782156727745; 
 Mon, 22 Jun 2026 12:32:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4445:b0:915:77d0:2ceb with SMTP id
 af79cd13be357-921cd9036e6mr1755072385a.0.1782156727222; 
 Mon, 22 Jun 2026 12:32:07 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm61489585a.34.2026.06.22.12.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 12:32:06 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 philmd@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 05/24] target/riscv: make some riscv_sysemu_ops TCG only
Date: Mon, 22 Jun 2026 16:31:21 -0300
Message-ID: <20260622193141.1449724-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
References: <20260622193141.1449724-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IbZ_4VY2glmi-OGPl615fZQ6VCOVh8r_
X-Authority-Analysis: v=2.4 cv=ecANubEH c=1 sm=1 tr=0 ts=6a398f84 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=fajYm1E7_uVK9srsrG8A:9 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE5MCBTYWx0ZWRfX5VItl30Dk/KE
 Myd28Mp9RrhxGT/1q2CT2Ca8rwVxrdmb2iz2AaAPnbkbq/NBzF4AhCe5qjms6QjJZ5aQjP11uxA
 quZmIqNIiS3XqruLuvbSYFcwcw0XSAs=
X-Proofpoint-GUID: IbZ_4VY2glmi-OGPl615fZQ6VCOVh8r_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE5MCBTYWx0ZWRfX5xlFDlv3E0d5
 nGbnR/Z8EWrud2FhmKqzOLV1y1pZpFg/xw/Sh7OrH/2GwOWaRcfxztnlfbfgJUSxthSZk2sFmu7
 Orzk30SxTPVfxFm5cPcRROisr6MjZYwumAs3s1SfVdE+w5/CDiUkq877HQZ88eGUeMvVrtV/PWC
 CoAUMcAUwU62DogGLnGIHnpjrvowtvl8pE0kOQpFGqvlqv81SHjrKPDbslIJHAwtgV41FataYvM
 fpmGiwCiCKXMZV01ch2jBF2tKDSHNS3pRyMQVw4z7B3pIU4FUKpTfJ+0HNKSPioJ1zl73AclIAP
 kGqwKu+6L1GAlZRfnS5qUis7DLcYSmGc6zNRF1D99RIP8bSR/UmVdPNb5B1DwtbF6Wr/0jblCxC
 KHAirbHYL2CE3CDCfTl5SS1BshqjUMyW4mLdsWJdrMl/E1qXAjwles215zztIzintsg7Z1kkHP1
 jA8ieYVdUGT/adc6Nsg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220190
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

monitor_get_register and phys_add_debug are TCG only.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c     | 6 ++++--
 target/riscv/monitor.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4e96bbeb60..0a7e6f6ed0 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2669,11 +2669,13 @@ static int64_t riscv_get_arch_id(CPUState *cs)
 
 static const struct SysemuCPUOps riscv_sysemu_ops = {
     .has_work = riscv_cpu_has_work,
-    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
     .legacy_vmsd = &vmstate_riscv_cpu,
+#ifdef CONFIG_TCG
+    .get_phys_addr_debug = riscv_cpu_get_phys_addr_debug,
+    .monitor_get_register = riscv_monitor_get_register_legacy,
+#endif
 };
 #endif
 
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 3e89dcaf7c..7aacd1d89c 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -245,6 +245,7 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict)
     mem_info_svxx(mon, env);
 }
 
+#ifdef CONFIG_TCG
 static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
                                  target_ulong *val, bool is_gprh)
 {
@@ -379,3 +380,4 @@ int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
 
     return -EINVAL;
 }
+#endif
-- 
2.43.0


