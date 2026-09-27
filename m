Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF37C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjNC-0007Ua-Rk; Sun, 27 Sep 2026 03:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMm-0006yv-5M
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xAjMk-0006R5-7l
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 03:32:07 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68R1xbHR1957987
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 m0LnkdItCLFquDLXMlz78TTLSgVLZhaj+R/e+TknJ08=; b=GFYAPK7aXusIMLjq
 BYUCcHi0IzkCBG0KkX/DlDgddvY/UJqZu453TCw30hh4Gce1J4HiIDPkHuf0HtYB
 BogKoO5dLIKOlHZx724zfU+t9DJcRLqRXgX5IYInDY062xfYj4+HeO9/5LZzSBRf
 l5A8KXniNHdr3OBYqzqf6V3D3OlmJ7Lfm3UG/2hvVmaSz+Rao1DxtZVjGZBN1FP9
 J1JqyVOgOHFCys0jv+SNQsILp8v+WuKkRvkqiwQcb9MwttGd3OfDFr6I1PlasVVw
 jFPIAYCMNnwzK5OzXPqlHns//jTQQZLvdbSQWjDN509y4ZUJuVKSQn1LCLAWgdTV
 FkTqbw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx5mwaj32-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 07:32:05 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a082c014aso455248485a.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 00:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790494324; x=1791099124; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m0LnkdItCLFquDLXMlz78TTLSgVLZhaj+R/e+TknJ08=;
 b=eaF1d9E3K7YDX/IWxolJ9t8ydssegjRYLdtPl6gnNOEAH7zWN2/fjmd8CM51vPyVK1
 0iskvbEmLLk1/2/0BKktZvAydG8F4Zbadc0KiONz/CBaT8zWoqKe1ol2rlM3NbZcn/qT
 uSzn0ZnDuchcVJ4BMYyy5lrLjuh7rQDIkMlMSG2E70qvaGEOxCLWiTjevj3RUHWwng8z
 ILRCMWP9mwR/JBnfMZ/3BS3bktwdSm6bkyIdXd1l7YJaWUZFnVrteBASm4LsYfkRX6Uq
 bo6Vit+ZPeX2a01KsInAbBV9ULEzQpgbbYxwGHtbjpBU/GBAto4IwFrovdvhxdVuXJO5
 Bkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790494324; x=1791099124;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m0LnkdItCLFquDLXMlz78TTLSgVLZhaj+R/e+TknJ08=;
 b=Gd1EEOBwPdvpXbHW9zF9qotSGMcX2BpEuLZHuqmHWqJ8oAevhsQsZZLk1aPQ4eNJCD
 DSO7eYqeHm1TkPwRFYLTobXw748gQ/P1juHrwqfzfyV+apAgS+HC3Y05xvXowxGrtzYP
 IfYAE6KI8Qo1aAPO7t/2KHTfpd3cGgORI5y38hy2pkdZytLi4ifmo/MwrNdBk2pzBW5P
 ryl0fGVZOGdxZPEiQpU0uhHRFCvPzHA+8aj/d5dXOb5PFo+/RoMYu/yydtzK6CiesC/f
 Wki51/KK8zQWF2ZpRBKp6nOolgMK9RuskOQ7Iwcp/5Bc5Tnwp+Hb/gx0NX3Sfuj+qOAm
 lkNA==
X-Gm-Message-State: AFuF++k3SVwmD6Y9O3G0MWivrIZ2AshDfXsSV4MEwJlYiExRSwqW7Iq4
 +d7a8XQGu1VZ43Src3xn9wIYsxczoBHTeDw2Zj2NS5VMX9PZTQpTJPYvWVw+oY/SSb59HNwSGi9
 m2tSrGMTeEVClnRS/5Ro4hLw7lVrEwWhv99Nrqb86WVQlXiayZIf7bM+8xqghElkgfw==
X-Gm-Gg: AYBFou1DEUWgmOoMuK26Qe20hOKgVaVJVpx1Aig37pxXu5JKUfy7ewxkSnMepR446zB
 V5qZ9KYvic3Cdt6NCK6wN28aynnAaRSNSwYzT4FJH5TgKIS5SeTqU+9OT6dofjJY1V10GmU0ynU
 doUN4W7Sz2EKG4qyW264SzU+crYt2khFLEQOsqhSj2gAlL6BzN83bQC/N+Bo0INQlk/QlpcxfkQ
 RXnIgFRjm7i6c/MAs9pvZXK+++nHBvMuzhENF0Zqc+24pVx/8vJUkcJo69kQ4VpIyS92k2Zxb81
 O0sPlInTKYkXVI+ZDpcQS6VyNLuxT3Etn981F37Fr1I538i1cAGLVA6rHuzHwnhQyKzU6dMvAH4
 EqabY0+gF5E6/wio5Ob6IX+v22dCEDWdbSNFUXVp4
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93c6e1d9a63mr200814285a.17.1790494324444; 
 Sun, 27 Sep 2026 00:32:04 -0700 (PDT)
X-Received: by 2002:a05:620a:2956:b0:93c:6e1d:96b0 with SMTP id
 af79cd13be357-93c6e1d9a63mr200809385a.17.1790494323632; 
 Sun, 27 Sep 2026 00:32:03 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ffd137346sm71460265e9.1.2026.09.27.00.32.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 27 Sep 2026 00:32:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/9] hw/i386/isapc: reject modern x86 CPU models
Date: Sun, 27 Sep 2026 09:31:34 +0200
Message-ID: <20260927073140.41422-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927073140.41422-1-philmd@oss.qualcomm.com>
References: <20260927073140.41422-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aYbQBLkeRZa_DqeT-jZpWpYbJKGycGfI
X-Authority-Analysis: v=2.4 cv=QvPLTlyd c=1 sm=1 tr=0 ts=6ab8c675 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=64Cc0HZtAAAA:8 a=EUspDBNiAAAA:8 a=zX-5KU0OjsM3FtIwGpUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: aYbQBLkeRZa_DqeT-jZpWpYbJKGycGfI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfX+cCc6jzROkfL
 N3nEtOFIikznrtdJBSxLEsUjRPw7MCF2uCfbrQKDHjoLGxDyTkd906FNn58sOyLBfqlNPUOpGTq
 FM/aUmOuq9dwZxlxgt9ZtFuVx7FO1FIZxMaqumlxuLIw7qiPKdf9E4cvMtRnJAVA2FYImeA/yH4
 /usww0dt13ACBVeCn5hYm2mDxBIBh1N4PrJsdTWjjmgRvVnrR0QUeOPOJ9K6gzTPtaqhhegTHu9
 GvCFaPIs9jyX0g6mYNRApdwxdDm0RkOg2O3WrB0UCs40cEzS4nrvM1RYRmd8AZNVun9/aVO81Wq
 4jfq/8+0BPMwedNAX94dfVNdGG2CaSLEkLPBGE5gIKG1I36XOEDglfHk6DQJt6gH8NwU829bkYg
 /XoPAOSgRieKgrGwI40SBepNNL7zqjvhD8F9NwwPZM+bcQ+Eo+dHecCkwnkijy2xTXB6rDUBogJ
 lZ1IAeolumYMGyFDzVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI3MDAyOSBTYWx0ZWRfXxEh8sx9JEc7g
 j+0EuO4d9BLO9STzHukfFKTMG2l3PWBqwKshRbdg6rV/tc8+uNAfJ5I9hFN9VlXVpUaLyLEUOgb
 5mdsUOTdOzwKfBgv87rw11wUrX6wtVU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609270029
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

It was originally intended as part of the work to split out the isapc machine
from the pc machine to restrict the isapc machine to using only 32-bit CPUs.
Before the 10.2 release it was decided in commit 329e36af94 ("hw/i386/isapc.c:
warn rather than reject modern x86 CPU models") to follow the official
deprecation process due to concerns this would have an adverse effect on users.

Now that the deprecation period has expired and there have been no reported
problems, update the isapc machine to reject modern x86 CPUs by reverting
commit 329e36af94 ("hw/i386/isapc.c: warn rather than reject modern x86 CPU
models").

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260824111054.575149-1-mark.caveayland@nutanix.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/i386/isapc.c | 53 +++++++++++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/hw/i386/isapc.c b/hw/i386/isapc.c
index 1ba9ae22cc3..44f4a446724 100644
--- a/hw/i386/isapc.c
+++ b/hw/i386/isapc.c
@@ -41,31 +41,29 @@ static void pc_init_isa(MachineState *machine)
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int i;
 
-    bool valid_cpu_type = false;
-    static const char * const valid_cpu_types[] = {
-        X86_CPU_TYPE_NAME("486"),
-        X86_CPU_TYPE_NAME("athlon"),
-        X86_CPU_TYPE_NAME("kvm32"),
-        X86_CPU_TYPE_NAME("pentium"),
-        X86_CPU_TYPE_NAME("pentium2"),
-        X86_CPU_TYPE_NAME("pentium3"),
-        X86_CPU_TYPE_NAME("qemu32"),
-    };
-
     /*
-     * The isapc machine is supposed to represent a legacy ISA-only PC with a
-     * 32-bit processor. For historical reasons the machine can still accept
-     * almost any valid processor, but this is now deprecated in 10.2. Emit
-     * a warning if anyone tries to use a deprecated CPU.
+     * There is a small chance that someone unintentionally passes "-cpu max"
+     * for the isapc machine, which will provide a much more modern 32-bit
+     * CPU than would be expected for an ISA-era PC. If the "max" cpu type has
+     * been specified, choose the "best" 32-bit cpu possible which we consider
+     * be the pentium3 (deliberately choosing an Intel CPU given that the
+     * default 486 CPU for the isapc machine is also an Intel CPU).
      */
-    for (i = 0; i < ARRAY_SIZE(valid_cpu_types); i++) {
-        if (!strcmp(machine->cpu_type, valid_cpu_types[i])) {
-            valid_cpu_type = true;
-        }
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("max"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu max is invalid for isapc machine, using pentium3");
     }
 
-    if (!valid_cpu_type) {
-        warn_report("cpu type %s is deprecated for isapc machine", machine->cpu_type);
+    /*
+     * Similarly if someone unintentionally passes "-cpu host" for the isapc
+     * machine then display a warning and also switch to the "best" 32-bit
+     * cpu possible which we consider to be the pentium3. This is because any
+     * host CPU will already be modern than this, but it also ensures any
+     * newer CPU flags/features are filtered out for older guests.
+     */
+    if (!strcmp(machine->cpu_type, X86_CPU_TYPE_NAME("host"))) {
+        machine->cpu_type = X86_CPU_TYPE_NAME("pentium3");
+        warn_report("-cpu host is invalid for isapc machine, using pentium3");
     }
 
     if (machine->ram_size > 3.5 * GiB) {
@@ -156,6 +154,18 @@ static void pc_init_isa(MachineState *machine)
 
 static void isapc_machine_options(MachineClass *m)
 {
+    static const char * const valid_cpu_types[] = {
+        X86_CPU_TYPE_NAME("486"),
+        X86_CPU_TYPE_NAME("athlon"),
+        X86_CPU_TYPE_NAME("kvm32"),
+        X86_CPU_TYPE_NAME("pentium"),
+        X86_CPU_TYPE_NAME("pentium2"),
+        X86_CPU_TYPE_NAME("pentium3"),
+        X86_CPU_TYPE_NAME("qemu32"),
+        X86_CPU_TYPE_NAME("max"),
+        X86_CPU_TYPE_NAME("host"),
+        NULL
+    };
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
     m->desc = "ISA-only PC";
@@ -170,6 +180,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->valid_cpu_types = valid_cpu_types;
     m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
-- 
2.53.0


