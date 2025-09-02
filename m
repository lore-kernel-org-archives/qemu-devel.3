Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A405BCA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:57:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI2x-0007qg-N1; Mon, 01 Sep 2025 23:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2O-0006bB-5q
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI2L-0004wF-7l
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:50:27 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822TUGd027881
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:50:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +JnaxFHcskS39CXDwL4DzF2dGzebaqnHGQJgk+Qg4pc=; b=U5RGHOh29OCZUTxB
 zS8AwfkU9LywYkNR57aLol9zJW9Dn2a6QWxtprUYlZNdqLeF4jwUv0/9Z/Wlm+MA
 BU7PiNXwMCGIgBnbHru25Wc1dC5i1msQultBvvvxlmaENAIOfepVJh7veugFAy2h
 EHiNlT5sPQCYhZOhKdbcsCNfRuw5DOdUfcLeBycQI5mRLO99IDVt4DAgyFZbzRZm
 x0AwjJEkz7nFTFMDQx2JHvbqYof2E78ycfjfIugRE5eE1U0iifNE6hqeApde7Nem
 xOgvpq8/Zdgwc1nR7kMZdt3Tn1/aFtrwqTKQ159isguxU7UqdqmJSEpMvcwGINc2
 Zyu7Sw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxeda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:50:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b47173afd90so6838959a12.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756785010; x=1757389810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JnaxFHcskS39CXDwL4DzF2dGzebaqnHGQJgk+Qg4pc=;
 b=MOoB+LGZ8LDtMcvoBhuD9LBccMtPhWu6quqQmlbQCLIxIkySHjAbqlMnNbphuu4lEW
 PvVl8WfU6CN5j0Z9gtbaj6jHqoBDAf86S+7SK+/+yHADber/VbhnC9lrX+D8dR4oRyKY
 0pnjHWqftoqGakwWevnJqgOt4/VDVmUb5iif6F7C5liPKbRRXPzMKuc+NbOqStZUSJ4m
 hv4PyIUmByBiWUrk0pSCBABzA5zv9DXyhDG9We4WgZXXQal4QwyY9rrEkGqwVgdvYer2
 YRkDOyEioCfFWxYYzklc9LlyIU2moIQoYahjoTl1PxezjqqhT9BccADsWmR6k/cfHGuP
 6VJw==
X-Gm-Message-State: AOJu0YyNG7AXGQ5nHzsl3CG4LUErQOYKhgE+RnHhrj/BoWldZnFb8NpS
 IflfYz6/cwNfQkMbeHaEYdG4skKtGzq7rbs4v6zoE9CQmqwCrv5hpG+7qIiUIQZgLOVJKQkeLsU
 ty/kla8FX59JZr72penFNq2Z2g46BSuC/UrvhrXvK2AN8d9XoiQs5cyiG31EtXqaoNlUx
X-Gm-Gg: ASbGncvF+7w9VnKoPO5el0LTyKAxCFRFyceZEr+h5UlErA+fuG+6NJA+5pCRvdv0YYM
 hhHPk2mIb8p6ntrqI6Xb311EDfGymFaTVb/y+c51aDSk/PQV2aGj77yxZTgWoQAAt361QcPpQdb
 0QSY2GbFYGRrLaaukEAn+LpiLx31IF5SVm/ZWUP8i06rOobUkr4TjCPGAnV33Lg1JYFxZf4WodG
 G+TXgXi8jMyyxxhUNOMPlmdVNwbxXCPnfUu+5hjoi0mRjimCWXXjvOZsXpPJCURvWoBqNziZSnS
 2/28UJJlPZQK7Wg5k9wTY4af99eRZTlTzHWkE4T6Dm9q3n8ytJqMCM27NAaMApR8t7zY/7DrWDZ
 wVHDqPcQ0xIZE
X-Received: by 2002:a05:6a20:42a3:b0:240:409:fa91 with SMTP id
 adf61e73a8af0-243d6e00cfemr14102184637.18.1756785009967; 
 Mon, 01 Sep 2025 20:50:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiHSHKac4tzuEGUqFWO2xwrM5tSRsZ5YncF/bawf6bERMxVnJ+SHE0KFBJ4jgXuREWUnVleA==
X-Received: by 2002:a05:6a20:42a3:b0:240:409:fa91 with SMTP id
 adf61e73a8af0-243d6e00cfemr14102155637.18.1756785009546; 
 Mon, 01 Sep 2025 20:50:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327c5fc5055sm14117932a91.14.2025.09.01.20.50.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:50:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com
Subject: [PATCH v2 07/11] target/hexagon: add build config for softmmu
Date: Mon,  1 Sep 2025 20:49:47 -0700
Message-Id: <20250902034951.1948194-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
References: <20250902034951.1948194-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX4Mf1LVX2dAt9
 f8Uc4Ki9UVriKfr3m9PDHG786dF1eA+//0tngU0CALVKK3T6iQ0gUKRIBQGprZMc2zVMS8ylNFP
 cJwlmaoIEM9UJqtYJ3uomsCywsF2wQHLjOKG0Q7FPGZa3QcMKJRJZWQsmwJrK9NqVVvfJGYQpxV
 yPS1cPIlzp8AsyFVmcvJavw4wMp0KhWtCIQgDNgitVRBRfSV3zZ7zar6LowOKsaiyfQo5hB+elF
 r367xrA9hJF0jEEF0HiMUECOpkzkUJTn8D9odNSrtWAt5mQ+Pny07IkFEt9Nc6wqH7WoBLZxZLo
 YaJ3Jojq52hi5ObCnLtIymXk7f4Po0bpjCk/0XJsCoiOpPfR5B70vlC7L3NlauIUKGiIeS37/np
 qYCcTVcV
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b66976 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=7U61yWmk6EQC0jbKVGMA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: ZRtC3ky84GYAwxhmYByNWAV3Q1BzRn8w
X-Proofpoint-GUID: ZRtC3ky84GYAwxhmYByNWAV3Q1BzRn8w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 MAINTAINERS                                 |  1 +
 configs/devices/hexagon-softmmu/default.mak |  7 +++++++
 configs/targets/hexagon-softmmu.mak         |  6 ++++++
 target/hexagon/cpu.h                        |  4 ----
 target/Kconfig                              |  1 +
 target/hexagon/Kconfig                      |  2 ++
 target/hexagon/meson.build                  | 12 +++++++++++-
 7 files changed, 28 insertions(+), 5 deletions(-)
 create mode 100644 configs/devices/hexagon-softmmu/default.mak
 create mode 100644 configs/targets/hexagon-softmmu.mak
 create mode 100644 target/hexagon/Kconfig

diff --git a/MAINTAINERS b/MAINTAINERS
index efc237b27b..e19fcf9e69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -237,6 +237,7 @@ F: linux-user/hexagon/
 F: tests/tcg/hexagon/
 F: disas/hexagon.c
 F: configs/targets/hexagon-linux-user/default.mak
+F: configs/devices/hexagon-softmmu/default.mak
 F: docker/dockerfiles/debian-hexagon-cross.docker
 F: gdb-xml/hexagon*.xml
 F: docs/system/target-hexagon.rst
diff --git a/configs/devices/hexagon-softmmu/default.mak b/configs/devices/hexagon-softmmu/default.mak
new file mode 100644
index 0000000000..08e709aea7
--- /dev/null
+++ b/configs/devices/hexagon-softmmu/default.mak
@@ -0,0 +1,7 @@
+# Default configuration for hexagon-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_HEX_DSP=y
+# CONFIG_L2VIC=y
diff --git a/configs/targets/hexagon-softmmu.mak b/configs/targets/hexagon-softmmu.mak
new file mode 100644
index 0000000000..8c208bf468
--- /dev/null
+++ b/configs/targets/hexagon-softmmu.mak
@@ -0,0 +1,6 @@
+# Default configuration for hexagon-softmmu
+
+TARGET_ARCH=hexagon
+TARGET_SUPPORTS_MTTCG=y
+TARGET_XML_FILES=gdb-xml/hexagon-core.xml gdb-xml/hexagon-hvx.xml gdb-xml/hexagon-sys.xml
+TARGET_LONG_BITS=32
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 86fbe30dbb..57840d2100 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -33,10 +33,6 @@
 #include "mmvec/mmvec.h"
 #include "hw/registerfields.h"
 
-#ifndef CONFIG_USER_ONLY
-#error "Hexagon does not support system emulation"
-#endif
-
 #ifndef CONFIG_USER_ONLY
 #include "reg_fields.h"
 typedef struct CPUHexagonTLBContext CPUHexagonTLBContext;
diff --git a/target/Kconfig b/target/Kconfig
index d0c7b59d9c..37781146b9 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -16,6 +16,7 @@ source sh4/Kconfig
 source sparc/Kconfig
 source tricore/Kconfig
 source xtensa/Kconfig
+source hexagon/Kconfig
 
 config TARGET_BIG_ENDIAN
     bool
diff --git a/target/hexagon/Kconfig b/target/hexagon/Kconfig
new file mode 100644
index 0000000000..7e556f3506
--- /dev/null
+++ b/target/hexagon/Kconfig
@@ -0,0 +1,2 @@
+config HEXAGON
+    bool
diff --git a/target/hexagon/meson.build b/target/hexagon/meson.build
index 3ec53010fa..d2b56b9e65 100644
--- a/target/hexagon/meson.build
+++ b/target/hexagon/meson.build
@@ -245,6 +245,7 @@ decodetree_trans_funcs_generated = custom_target(
     command: [python, files('gen_trans_funcs.py'), semantics_generated, '@OUTPUT@'],
 )
 hexagon_ss.add(decodetree_trans_funcs_generated)
+hexagon_softmmu_ss = ss.source_set()
 
 hexagon_ss.add(files(
     'cpu.c',
@@ -264,6 +265,13 @@ hexagon_ss.add(files(
     'mmvec/system_ext_mmvec.c',
 ))
 
+hexagon_softmmu_ss.add(files(
+    'hex_mmu.c',
+    'hex_interrupts.c',
+    'hexswi.c',
+    'machine.c',
+))
+
 #
 # Step 4.5
 # We use flex/bison based idef-parser to generate TCG code for a lot
@@ -273,7 +281,8 @@ hexagon_ss.add(files(
 #     idef-generated-enabled-instructions
 #
 idef_parser_enabled = get_option('hexagon_idef_parser')
-if idef_parser_enabled and 'hexagon-linux-user' in target_dirs
+if idef_parser_enabled and ('hexagon-linux-user' in target_dirs or
+                            'hexagon-softmmu' in target_dirs)
     idef_parser_input_generated = custom_target(
         'idef_parser_input.h.inc',
         output: 'idef_parser_input.h.inc',
@@ -400,3 +409,4 @@ analyze_funcs_generated = custom_target(
 hexagon_ss.add(analyze_funcs_generated)
 
 target_arch += {'hexagon': hexagon_ss}
+target_system_arch += {'hexagon': hexagon_softmmu_ss}
-- 
2.34.1


