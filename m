Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07239C44501
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwU-0005lF-J5; Mon, 13 Jul 2026 16:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwS-0005ki-TD
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwR-0006SN-6L
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:52 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9QVO2409517
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kPouZ7jjqZz
 FETADMqYWiMlz+iWC6Spoyk2i6x3PjoY=; b=nm3K7/ZBkJYC4YrrziNB5+H1eOR
 kQ2+npuvoxO1mwryAZpREG4/mwIlmKG10EBBExlA4t4Oog8Di5FlqHX1kjBpbGtN
 778+xQmwzpm4T7QGJgw0W5HbCvWWwsrKQP+eFmZJRyaF0YX3A+q4/zj6KXRagLzD
 rBfHxvY80bHatxYg168VgVPWqDBXoqTj5oHp2vnzAYUPpfuZO3cEzJvsyJqUHZ+F
 SDpUBi1Mf3Uxi7VZAvZPlIniHdptkK+5puGjdwcmqK59obTlXzuaTc23NEPCb37O
 YvcnHMt3F95/+sqHwd1kNGE1KxH/rpzIIVp94E3Cje4TKIHIwbRLO8S3now==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj030rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:40 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e11baa66eso257374a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973259; x=1784578059; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kPouZ7jjqZzFETADMqYWiMlz+iWC6Spoyk2i6x3PjoY=;
 b=UCbBP0rTcrxpMdFatga1yHLoDiGVVBjIgvcYfQ2+f/om2oRgCsfNYpd249AlDpJdDA
 CybbhKKYCMN5KPmouUc26u62THWBCu3s2O+lHpfhDMq2BKtIoSGC3M3hKyIUPec44Dj+
 rLHECsIBCdnvwCAoeziW73r9msCE0hdtfJ4yxQhyGRslyHXeGqwDOAq6jLjQqLHpMAUZ
 jrg3mPgSKSjCZ6amAyUY9RCs7XWGW/MBcsr+/Kx7Zo4UWWBx2MX3odsvNmD61VEqnLH4
 0JLjsxDyCcDleCljuK4YiMA7g4ZY2iBoNIKPlMrQ9XEgHlesi1QrR/kapSaUxwvu01/s
 90Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973259; x=1784578059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kPouZ7jjqZzFETADMqYWiMlz+iWC6Spoyk2i6x3PjoY=;
 b=poEEdsDCa+JFt5ttAcxvriY4ZgYN3k5hrk0ZrMeYLld+FhhHL5tTkTv8T7Fpgd9tzP
 kkWTB719FNZx9PAT0CI69ysAyvYhc+YqVYheGTJo/JzOy2cun88I3JD+fpb6VcZF5I/4
 N7Lvyp4eajZ+/3DA3PBh2DwJc5Tl+/fG9pmw5yVQaSDtNHPIh+NcF5bi6p7gDQK4UR2r
 h6OE1hKYvlOWaw7jLcrYwHRrqWKp7islHeeGzvyE+x8mhD51C9K3eH7KNO4GOfaWh2CA
 +o6b+xsXkBlATZoxI9ROm8JOgNgT8s25RtdDe1J70Wb26E042lXa4hriVmSC6p8ESk5O
 Nd6g==
X-Gm-Message-State: AOJu0YxbdoXqvZrVqs0Prrd5B7BGIU21iKrcbH8+IATdBNgHFv0Ib72w
 uB+EbEoRJdCrx6A3oIISaik3CgP70m+/3Jx6LG283QBfH+/ekDsBD2nkBzV4j6QfznYwgT7crhg
 Jf4OwvBBA8D6tmrfShGUpEdHpZrLNeFWDmd6HME+aejGzMx0ASIUftOwbzLNzxbndyyC4
X-Gm-Gg: AfdE7clrG7H+U5OpYnpu555S9YBxiLsv4aSe/oOfXlMiDISXmMfxOIQnKROK1NkV30w
 u7rZ6sfXXOA/Lx/NPNupoaQ60J/ZQZ96KdUb9kfTsvTilzY16Zv8j16bR/MC2UqG0Zt6DQI0DTB
 3CI4dxRlZ0kh/QrbnQA75DFgU8fJRGzX94t+oBGicZD2Ek/HdBtLwvLr+Z0gmr9VhNtC5RyHbNL
 wndDlL21CXTMTPIBu/Qo4iMVP7ikrjgd/K3C9QE9v73tnxgMKnxKaXob15fy+/Zi1vL6Px137nM
 Mp6D/wksw7/QdKyB+5bjxf8SFNs6BcHEaLrwRypJb2ShYuPl0hkKYI5geao4lIzLw8+Pqo8f0yr
 s90DTry01xqIN5UkjN83thkHjHXn5/Hp1DaCUR0q21Kzj8H/KuJh8aVp1jdZhOnbwK7uuhNnV8g
 ==
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38dc75e3d4fmr9471495a91.12.1783973259139; 
 Mon, 13 Jul 2026 13:07:39 -0700 (PDT)
X-Received: by 2002:a17:90a:d88b:b0:381:528a:808c with SMTP id
 98e67ed59e1d1-38dc75e3d4fmr9471473a91.12.1783973258712; 
 Mon, 13 Jul 2026 13:07:38 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:38 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH 11/14] target/hexagon: add OPEN/READ/CLOSE_DIR semihosting
 operations
Date: Mon, 13 Jul 2026 13:07:19 -0700
Message-Id: <db95d3b7af7b0f64102866ce046ad773a2b391b9.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX40uWWM8phKRH
 0XTLOpo9Pv5UqO+klglts6QwBvsGD2JxGgiIjpyRqnFP9jxYV29BKnlRF0oNB528g5mwpGPkz1D
 aqP9LewkyaozaT9BkrWA0Xb71eGVFz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX3pKqHBjboulM
 FmEaTPjqpE46/0Zoca5eMwWi984U29n9C8uK040YPtKr4JdklB/W0W/RMZcTDGZE35rHeePR9kS
 5TcdrRvEr5uj1c65AD1Oc4E2jYU9sA/HWGQoijdkE05+rR6B7yEjFROuDdNrv+njiE/PSsdWn0o
 cHsYbKEWoJjsFboRN4owkGlsXY4+JBG7i29HHnwN/TI66imnWjEjyVvGsQEqSz7BlZXrjL3R1l6
 2wcyjJLTj6iBR9NfSKzCTsTfXCNAMnJ7UfvKN2o38MgHLnNWG/DgS+ADHmusLJkN1FpCRScItgN
 a/WrkcEONob/sy/lSBEMmmy7nMKOSG1p7mEqY6oD2M0Q3s8n1L41tUZEuY+eqfe8/NfXs8bSyeG
 e1cUmKi2RS8Op99GHGXBwk1UEujE9c6JHizfoebXMGzD/f/9eCHuWMrr/140NsweQeB1f/1PgOx
 tVNpLhuOdrYL6tu1cew==
X-Proofpoint-ORIG-GUID: soco32gXQsbsNdCAD5_blJQIAHSfkXOM
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a55458c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=wKTLz1ccYnAIe_aMEg4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: soco32gXQsbsNdCAD5_blJQIAHSfkXOM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130208
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Baremetal Hexagon programs use semihosting to enumerate host
directories via OPENDIR, READDIR, and CLOSEDIR calls.  Track
open directory handles per-CPU in a GList so that guest
index values map back to host DIR pointers across calls.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h     |  1 +
 hw/hexagon/hexagon_dsp.c |  5 +++
 hw/hexagon/virt.c        |  5 +++
 target/hexagon/hexswi.c  | 79 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 90 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 7694fd91fa8..536843584f4 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -144,6 +144,7 @@ typedef struct CPUArchState {
     uint32_t tlb_lock_count;
     uint32_t k0_lock_count;
     uint64_t t_cycle_count;
+    GList **g_dir_list;
 #endif
     uint32_t next_PC;
     target_ulong new_value_usr;
diff --git a/hw/hexagon/hexagon_dsp.c b/hw/hexagon/hexagon_dsp.c
index 315733cded3..be47daa0d82 100644
--- a/hw/hexagon/hexagon_dsp.c
+++ b/hw/hexagon/hexagon_dsp.c
@@ -147,6 +147,7 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
 
     for (int i = 0; i < machine->smp.cpus; i++) {
         HexagonCPU *cpu = HEXAGON_CPU(object_new(machine->cpu_type));
+        CPUHexagonState *env = &cpu->env;
         qemu_register_reset(do_cpu_reset, cpu);
 
         /*
@@ -156,6 +157,10 @@ static void hexagon_common_init(MachineState *machine, Rev_t rev,
         qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
         if (i == 0) {
             hexagon_init_bootstrap(dms, cpu);
+            env->g_dir_list = g_malloc0(sizeof(GList *));
+        } else {
+            CPUHexagonState *env0 = cpu_env(qemu_get_cpu(0));
+            env->g_dir_list = env0->g_dir_list;
         }
         object_property_set_link(OBJECT(cpu), "global-regs",
                                  OBJECT(glob_regs_dev), &error_fatal);
diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
index a3638998b87..62100c08277 100644
--- a/hw/hexagon/virt.c
+++ b/hw/hexagon/virt.c
@@ -283,10 +283,12 @@ static void virt_init(MachineState *ms)
     cpu0 = NULL;
     for (int i = 0; i < ms->smp.cpus; i++) {
         HexagonCPU *cpu = HEXAGON_CPU(object_new(ms->cpu_type));
+        CPUHexagonState *env = &cpu->env;
         qemu_register_reset(do_cpu_reset, cpu);
 
         if (i == 0) {
             cpu0 = DEVICE(cpu);
+            env->g_dir_list = g_malloc0(sizeof(GList *));
             if (ms->kernel_filename) {
                 uint64_t entry = load_kernel(vms);
                 qdev_prop_set_uint32(cpu0, "exec-start-addr", entry);
@@ -294,6 +296,9 @@ static void virt_init(MachineState *ms)
                 uint64_t entry = load_bios(vms);
                 qdev_prop_set_uint32(cpu0, "exec-start-addr", entry);
             }
+        } else {
+            CPUHexagonState *env0 = cpu_env(qemu_get_cpu(0));
+            env->g_dir_list = env0->g_dir_list;
         }
         qdev_prop_set_uint32(DEVICE(cpu), "htid", i);
         qdev_prop_set_bit(DEVICE(cpu), "start-powered-off", (i != 0));
diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
index 7efd33d3533..edadb40bed6 100644
--- a/target/hexagon/hexswi.c
+++ b/target/hexagon/hexswi.c
@@ -30,6 +30,9 @@
 #include "semihosting/guestfd.h"
 #include "system/runstate.h"
 
+/* We start from 1 as 0 is used to signal an error from opendir() */
+static const int DIR_INDEX_OFFSET = 1;
+
 /* non-arm-compatible semihosting calls */
 #define HEXAGON_SPECIFIC_SWI_FLAGS \
     DEF_SWI_FLAG(OPEN,             0x01) \
@@ -566,6 +569,82 @@ static void sim_handle_trap0(CPUHexagonState *env)
     }
     break;
 
+    case HEX_SYS_OPENDIR:
+    {
+        DIR *dir;
+        char buf[BUFSIZ];
+        int rc = 0, err = 0;
+        int i = 0;
+
+        do {
+            hexagon_read_memory(env, swi_info + i, 1, &buf[i], retaddr);
+            i++;
+        } while ((i < BUFSIZ) && buf[i - 1]);
+
+        dir = opendir(buf);
+        if (dir != NULL) {
+            *env->g_dir_list = g_list_append(*env->g_dir_list, dir);
+            rc = g_list_index(*env->g_dir_list, dir) + DIR_INDEX_OFFSET;
+        } else {
+            err = errno;
+        }
+        common_semi_cb(cs, rc, rc != 0 ? 0 : err);
+        break;
+    }
+
+    case HEX_SYS_READDIR:
+    {
+        struct dirent *host_dir_entry = NULL;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+        DIR *dir = g_list_nth_data(*env->g_dir_list, dir_index);
+        uint32_t rc = 0, err = 0;
+
+        if (dir) {
+            errno = 0;
+            host_dir_entry = readdir(dir);
+            if (host_dir_entry == NULL) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+
+        if (host_dir_entry) {
+            uint32_t guest_dir_entry = arch_get_thread_reg(env, HEX_REG_R02);
+            hexagon_write_memory(env, guest_dir_entry, 4, host_dir_entry->d_ino,
+                                 retaddr);
+            for (int i = 0; i < sizeof(host_dir_entry->d_name); i++) {
+                hexagon_write_memory(env, guest_dir_entry + 4 + i, 1,
+                                     host_dir_entry->d_name[i], retaddr);
+                if (!host_dir_entry->d_name[i]) {
+                    break;
+                }
+            }
+            rc = guest_dir_entry;
+        }
+        common_semi_cb(cs, rc, err);
+        break;
+    }
+
+    case HEX_SYS_CLOSEDIR:
+    {
+        DIR *dir;
+        int ret = -1, err = 0;
+        int dir_index = swi_info - DIR_INDEX_OFFSET;
+
+        dir = g_list_nth_data(*env->g_dir_list, dir_index);
+        if (dir != NULL) {
+            ret = closedir(dir);
+            if (ret != 0) {
+                err = errno;
+            }
+        } else {
+            err = EBADF;
+        }
+        common_semi_cb(cs, ret, ret == 0 ? 0 : err);
+        break;
+    }
+
     case HEX_SYS_COREDUMP:
         coredump(env);
         break;
-- 
2.37.2


