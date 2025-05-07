Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D97BC3ABC0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCnyq-0000mK-Vp; Wed, 07 May 2025 19:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyn-0000kD-Q3
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:09 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCnyi-0007HL-BZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:15:09 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-22e3b069f23so4363465ad.2
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746659703; x=1747264503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tSW/JXELQWVl1oBMnbsYzBzqBXzXdfdQUa0WkEee6XM=;
 b=SbH/MeenbjohYLTYEVoLsgbgsRV+via2WW0fwwtYCixmdgP9a9SvZy2QyrvWOWJOh2
 ypymYMJSjKbULuo82rmQim3/uS4Huo2Q5hEh86Cj0H4awRdMp6zFaznW2cRHZBRJkfKO
 ND7I0LjXDInfFO+KBsvABPj1gp15wRxG2eZOr5H4P4ktkpchoNgzAsT/c0JcFgxHxDoR
 bgr4ylqRjhnn3uHnoD4toO0wncanVNN63xMQ40W69of/2t+i9QSh+HUDwBDVL8kI8oTn
 ANX3cW7DdrILcsKJA91L5n1tbgD+eQhuEfVxCmA0STuqJiwx7jfkD3Qx8TXUYh1Z7EYB
 C7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746659703; x=1747264503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tSW/JXELQWVl1oBMnbsYzBzqBXzXdfdQUa0WkEee6XM=;
 b=UENR7inc7dZRtRUxK0g42f9XmxZbNuOCs/ZCe9aswDNtiPHJ4TxDhGwjyLzxdRSml3
 WxtlHYJYodbFqTVyXy+n/QY8jMyg4gR1JPjz0WXLVqOw/PTC1wc4wmj5so79oWrpnhoB
 cuM/Nbwp5tkK5DWZMvb8a1d6oYT1vJK0/4Ntjg9O9HKbgAA3vNsz/8z0fq44Y0MI/BMa
 1ubneKteW5rhlCRspjAnVxW6o4D8nYjO0u+zNm/oZ9eHZNq5jP1XB4FN+O28NcCZCoFQ
 qxK710/6c4hxVMYxlcP7mmSNPB0ldbWj2rz+Auq8G+PZ6tZkeTEB9QeooTLYqMc/mwlt
 WfKg==
X-Gm-Message-State: AOJu0YzMY9NyiWW+or+GgitDEiy+GPtGZbUAoGE1/ACatr3D0QluKikb
 ajqOR/Weac2E0kT3lHPiC+3JYrvczPURUAqdW3Q4QdD0VU1IV8PV+QseCVDJY/TGUDdAnxKs4Va
 rPVdaPw==
X-Gm-Gg: ASbGnctActgyOBN7UjgCUePyxdJ4CtW83oM4/KK83G2C9V7Z3p36Z+UcD3pNAanBfbK
 2PnFLFrVcCLv0hgE7uNUArGdoXycXUOjgqROdXVdVg02sEs8UPI+QVKh5O9D2IkLczznJ6c8vY4
 Q5oKLb4is2NCg8QbdtuaCYKqiK7cV66s7GVoT7AmCrbOK+CNg/TmjbjWArOJcVnG1DIZXyRldF3
 6rJc/Bk06q7bDUhO1hBPk/Ti9WA9S3c0CDD8JtolUzbUfMbNU8DrsYvFJ2AV5yHkjKVfp4EkGsg
 5As/7D8+30GmNGhCsCPIlFZ+3acSKH+jpVuiQLA+
X-Google-Smtp-Source: AGHT+IHAcBObsjK9SxNLYczXvxaQvwZcMvFcZBzCCUVN0fG2gODGKbA5kqYZBBXPLfTbJAIFs4CcgA==
X-Received: by 2002:a17:902:d50f:b0:215:7421:262 with SMTP id
 d9443c01a7336-22e5ea7c56fmr90334955ad.12.1746659702272; 
 Wed, 07 May 2025 16:15:02 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e421a7dafsm40103205ad.69.2025.05.07.16.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:15:01 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, alex.bennee@linaro.org,
 stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, philmd@linaro.org,
 berrange@redhat.com, thuth@redhat.com, Michael Roth <michael.roth@amd.com>
Subject: [PATCH 13/13] [ANNEX] build/qapi: after series
Date: Wed,  7 May 2025 16:14:42 -0700
Message-ID: <20250507231442.879619-13-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In this patch, you can see all the changes in generated QAPI code.
Feel free to review inline if you want to highlight some parts.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 build/qapi/qapi-commands-machine-target.h |  12 -
 build/qapi/qapi-commands-misc-target.h    |  22 --
 build/qapi/qapi-events-machine-target.h   |   2 -
 build/qapi/qapi-introspect.h              |   2 +-
 build/qapi/qapi-types-machine-target.h    |  58 -----
 build/qapi/qapi-types-misc-target.h       |  84 -------
 build/qapi/qapi-visit-machine-target.h    |  24 --
 build/qapi/qapi-visit-misc-target.h       |  36 ---
 build/qapi/qapi-builtin-visit.c           |   1 +
 build/qapi/qapi-commands-acpi.c           |   1 +
 build/qapi/qapi-commands-audio.c          |   1 +
 build/qapi/qapi-commands-authz.c          |   1 +
 build/qapi/qapi-commands-block-core.c     |   1 +
 build/qapi/qapi-commands-block-export.c   |   1 +
 build/qapi/qapi-commands-block.c          |   1 +
 build/qapi/qapi-commands-char.c           |   1 +
 build/qapi/qapi-commands-common.c         |   1 +
 build/qapi/qapi-commands-compat.c         |   1 +
 build/qapi/qapi-commands-control.c        |   1 +
 build/qapi/qapi-commands-crypto.c         |   1 +
 build/qapi/qapi-commands-cryptodev.c      |   1 +
 build/qapi/qapi-commands-cxl.c            |   1 +
 build/qapi/qapi-commands-dump.c           |   1 +
 build/qapi/qapi-commands-ebpf.c           |   1 +
 build/qapi/qapi-commands-error.c          |   1 +
 build/qapi/qapi-commands-introspect.c     |   1 +
 build/qapi/qapi-commands-job.c            |   1 +
 build/qapi/qapi-commands-machine-common.c |   1 +
 build/qapi/qapi-commands-machine-target.c |  23 +-
 build/qapi/qapi-commands-machine.c        |   1 +
 build/qapi/qapi-commands-migration.c      |   1 +
 build/qapi/qapi-commands-misc-target.c    |  37 +--
 build/qapi/qapi-commands-misc.c           |   1 +
 build/qapi/qapi-commands-net.c            |   1 +
 build/qapi/qapi-commands-pci.c            |   1 +
 build/qapi/qapi-commands-pragma.c         |   1 +
 build/qapi/qapi-commands-qdev.c           |   1 +
 build/qapi/qapi-commands-qom.c            |   1 +
 build/qapi/qapi-commands-replay.c         |   1 +
 build/qapi/qapi-commands-rocker.c         |   1 +
 build/qapi/qapi-commands-run-state.c      |   1 +
 build/qapi/qapi-commands-sockets.c        |   1 +
 build/qapi/qapi-commands-stats.c          |   1 +
 build/qapi/qapi-commands-tpm.c            |   1 +
 build/qapi/qapi-commands-trace.c          |   1 +
 build/qapi/qapi-commands-transaction.c    |   1 +
 build/qapi/qapi-commands-uefi.c           |   1 +
 build/qapi/qapi-commands-ui.c             |   1 +
 build/qapi/qapi-commands-vfio.c           |   1 +
 build/qapi/qapi-commands-virtio.c         |   1 +
 build/qapi/qapi-commands-yank.c           |   1 +
 build/qapi/qapi-commands.c                |   1 +
 build/qapi/qapi-events-machine-target.c   |   2 -
 build/qapi/qapi-init-commands.c           |  69 ++---
 build/qapi/qapi-introspect.c              | 294 ++++++++--------------
 build/qapi/qapi-types-machine-target.c    |  14 --
 build/qapi/qapi-types-misc-target.c       |  28 ---
 build/qapi/qapi-visit-acpi.c              |   1 +
 build/qapi/qapi-visit-audio.c             |   1 +
 build/qapi/qapi-visit-authz.c             |   1 +
 build/qapi/qapi-visit-block-core.c        |   1 +
 build/qapi/qapi-visit-block-export.c      |   1 +
 build/qapi/qapi-visit-block.c             |   1 +
 build/qapi/qapi-visit-char.c              |   1 +
 build/qapi/qapi-visit-common.c            |   1 +
 build/qapi/qapi-visit-compat.c            |   1 +
 build/qapi/qapi-visit-control.c           |   1 +
 build/qapi/qapi-visit-crypto.c            |   1 +
 build/qapi/qapi-visit-cryptodev.c         |   1 +
 build/qapi/qapi-visit-cxl.c               |   1 +
 build/qapi/qapi-visit-dump.c              |   1 +
 build/qapi/qapi-visit-ebpf.c              |   1 +
 build/qapi/qapi-visit-error.c             |   1 +
 build/qapi/qapi-visit-introspect.c        |   1 +
 build/qapi/qapi-visit-job.c               |   1 +
 build/qapi/qapi-visit-machine-common.c    |   1 +
 build/qapi/qapi-visit-machine-target.c    |  29 +--
 build/qapi/qapi-visit-machine.c           |   1 +
 build/qapi/qapi-visit-migration.c         |   1 +
 build/qapi/qapi-visit-misc-target.c       |  37 +--
 build/qapi/qapi-visit-misc.c              |   1 +
 build/qapi/qapi-visit-net.c               |   1 +
 build/qapi/qapi-visit-pci.c               |   1 +
 build/qapi/qapi-visit-pragma.c            |   1 +
 build/qapi/qapi-visit-qdev.c              |   1 +
 build/qapi/qapi-visit-qom.c               |   1 +
 build/qapi/qapi-visit-replay.c            |   1 +
 build/qapi/qapi-visit-rocker.c            |   1 +
 build/qapi/qapi-visit-run-state.c         |   1 +
 build/qapi/qapi-visit-sockets.c           |   1 +
 build/qapi/qapi-visit-stats.c             |   1 +
 build/qapi/qapi-visit-tpm.c               |   1 +
 build/qapi/qapi-visit-trace.c             |   1 +
 build/qapi/qapi-visit-transaction.c       |   1 +
 build/qapi/qapi-visit-uefi.c              |   1 +
 build/qapi/qapi-visit-ui.c                |   1 +
 build/qapi/qapi-visit-vfio.c              |   1 +
 build/qapi/qapi-visit-virtio.c            |   1 +
 build/qapi/qapi-visit-yank.c              |   1 +
 build/qapi/qapi-visit.c                   |   1 +
 100 files changed, 226 insertions(+), 630 deletions(-)

diff --git a/build/qapi/qapi-commands-machine-target.h b/build/qapi/qapi-commands-machine-target.h
index 4b9cd2616ba..3c1cc46e8fc 100644
--- a/build/qapi/qapi-commands-machine-target.h
+++ b/build/qapi/qapi-commands-machine-target.h
@@ -16,29 +16,17 @@
 #include "qapi-commands-machine-common.h"
 #include "qapi-types-machine-target.h"
 
-#if defined(TARGET_S390X)
 CpuModelCompareInfo *qmp_query_cpu_model_comparison(CpuModelInfo *modela, CpuModelInfo *modelb, Error **errp);
 void qmp_marshal_query_cpu_model_comparison(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X)
 CpuModelBaselineInfo *qmp_query_cpu_model_baseline(CpuModelInfo *modela, CpuModelInfo *modelb, Error **errp);
 void qmp_marshal_query_cpu_model_baseline(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type, CpuModelInfo *model, Error **errp);
 void qmp_marshal_query_cpu_model_expansion(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 CpuDefinitionInfoList *qmp_query_cpu_definitions(Error **errp);
 void qmp_marshal_query_cpu_definitions(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qmp_set_cpu_topology(uint16_t core_id, bool has_socket_id, uint16_t socket_id, bool has_book_id, uint16_t book_id, bool has_drawer_id, uint16_t drawer_id, bool has_entitlement, S390CpuEntitlement entitlement, bool has_dedicated, bool dedicated, Error **errp);
 void qmp_marshal_set_cpu_topology(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 CpuPolarizationInfo *qmp_query_s390x_cpu_polarization(Error **errp);
 void qmp_marshal_query_s390x_cpu_polarization(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 #endif /* QAPI_COMMANDS_MACHINE_TARGET_H */
diff --git a/build/qapi/qapi-commands-misc-target.h b/build/qapi/qapi-commands-misc-target.h
index 366711c22a2..8b449d314de 100644
--- a/build/qapi/qapi-commands-misc-target.h
+++ b/build/qapi/qapi-commands-misc-target.h
@@ -15,49 +15,27 @@
 
 #include "qapi-types-misc-target.h"
 
-#if defined(TARGET_I386)
 void qmp_rtc_reset_reinjection(Error **errp);
 void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 SevInfo *qmp_query_sev(Error **errp);
 void qmp_marshal_query_sev(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 SevLaunchMeasureInfo *qmp_query_sev_launch_measure(Error **errp);
 void qmp_marshal_query_sev_launch_measure(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 SevCapability *qmp_query_sev_capabilities(Error **errp);
 void qmp_marshal_query_sev_capabilities(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 void qmp_sev_inject_launch_secret(const char *packet_header, const char *secret, bool has_gpa, uint64_t gpa, Error **errp);
 void qmp_marshal_sev_inject_launch_secret(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 SevAttestationReport *qmp_query_sev_attestation_report(const char *mnonce, Error **errp);
 void qmp_marshal_query_sev_attestation_report(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_ARM)
 GICCapabilityList *qmp_query_gic_capabilities(Error **errp);
 void qmp_marshal_query_gic_capabilities(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_ARM) */
-#if defined(TARGET_I386)
 SGXInfo *qmp_query_sgx(Error **errp);
 void qmp_marshal_query_sgx(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 SGXInfo *qmp_query_sgx_capabilities(Error **errp);
 void qmp_marshal_query_sgx_capabilities(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 EvtchnInfoList *qmp_xen_event_list(Error **errp);
 void qmp_marshal_xen_event_list(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
 void qmp_xen_event_inject(uint32_t port, Error **errp);
 void qmp_marshal_xen_event_inject(QDict *args, QObject **ret, Error **errp);
-#endif /* defined(TARGET_I386) */
 
 #endif /* QAPI_COMMANDS_MISC_TARGET_H */
diff --git a/build/qapi/qapi-events-machine-target.h b/build/qapi/qapi-events-machine-target.h
index 95b65d92535..beba27a650c 100644
--- a/build/qapi/qapi-events-machine-target.h
+++ b/build/qapi/qapi-events-machine-target.h
@@ -17,8 +17,6 @@
 #include "qapi/util.h"
 #include "qapi-types-machine-target.h"
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qapi_event_send_cpu_polarization_change(S390CpuPolarization polarization);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 #endif /* QAPI_EVENTS_MACHINE_TARGET_H */
diff --git a/build/qapi/qapi-introspect.h b/build/qapi/qapi-introspect.h
index 2ae03416453..e94f33abb2d 100644
--- a/build/qapi/qapi-introspect.h
+++ b/build/qapi/qapi-introspect.h
@@ -14,6 +14,6 @@
 
 #include "qobject/qlit.h"
 
-extern const QLitObject qmp_schema_qlit;
+QObject *qmp_schema_qobject(void);
 
 #endif /* QAPI_INTROSPECT_H */
diff --git a/build/qapi/qapi-types-machine-target.h b/build/qapi/qapi-types-machine-target.h
index e9a7ef113d9..1042a3672e4 100644
--- a/build/qapi/qapi-types-machine-target.h
+++ b/build/qapi/qapi-types-machine-target.h
@@ -42,39 +42,22 @@ typedef enum CpuModelCompareResult {
 
 extern const QEnumLookup CpuModelCompareResult_lookup;
 
-#if defined(TARGET_S390X)
 typedef struct CpuModelBaselineInfo CpuModelBaselineInfo;
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 typedef struct CpuModelCompareInfo CpuModelCompareInfo;
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 typedef struct q_obj_query_cpu_model_comparison_arg q_obj_query_cpu_model_comparison_arg;
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 typedef struct q_obj_query_cpu_model_baseline_arg q_obj_query_cpu_model_baseline_arg;
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 typedef struct CpuModelExpansionInfo CpuModelExpansionInfo;
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 typedef struct q_obj_query_cpu_model_expansion_arg q_obj_query_cpu_model_expansion_arg;
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 typedef struct CpuDefinitionInfo CpuDefinitionInfo;
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 typedef struct CpuDefinitionInfoList CpuDefinitionInfoList;
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X)
 typedef enum S390CpuPolarization {
     S390_CPU_POLARIZATION_HORIZONTAL,
     S390_CPU_POLARIZATION_VERTICAL,
@@ -85,19 +68,12 @@ typedef enum S390CpuPolarization {
     qapi_enum_lookup(&S390CpuPolarization_lookup, (val))
 
 extern const QEnumLookup S390CpuPolarization_lookup;
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 typedef struct q_obj_set_cpu_topology_arg q_obj_set_cpu_topology_arg;
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 typedef struct q_obj_CPU_POLARIZATION_CHANGE_arg q_obj_CPU_POLARIZATION_CHANGE_arg;
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 typedef struct CpuPolarizationInfo CpuPolarizationInfo;
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 struct CpuModelInfo {
     char *name;
@@ -107,65 +83,44 @@ struct CpuModelInfo {
 void qapi_free_CpuModelInfo(CpuModelInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuModelInfo, qapi_free_CpuModelInfo)
 
-#if defined(TARGET_S390X)
 struct CpuModelBaselineInfo {
     CpuModelInfo *model;
 };
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 void qapi_free_CpuModelBaselineInfo(CpuModelBaselineInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuModelBaselineInfo, qapi_free_CpuModelBaselineInfo)
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 struct CpuModelCompareInfo {
     CpuModelCompareResult result;
     strList *responsible_properties;
 };
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 void qapi_free_CpuModelCompareInfo(CpuModelCompareInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuModelCompareInfo, qapi_free_CpuModelCompareInfo)
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 struct q_obj_query_cpu_model_comparison_arg {
     CpuModelInfo *modela;
     CpuModelInfo *modelb;
 };
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 struct q_obj_query_cpu_model_baseline_arg {
     CpuModelInfo *modela;
     CpuModelInfo *modelb;
 };
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 struct CpuModelExpansionInfo {
     CpuModelInfo *model;
-#if defined(TARGET_S390X)
     strList *deprecated_props;
-#endif /* defined(TARGET_S390X) */
 };
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qapi_free_CpuModelExpansionInfo(CpuModelExpansionInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuModelExpansionInfo, qapi_free_CpuModelExpansionInfo)
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 struct q_obj_query_cpu_model_expansion_arg {
     CpuModelExpansionType type;
     CpuModelInfo *model;
 };
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 struct CpuDefinitionInfo {
     char *name;
     bool has_migration_safe;
@@ -177,14 +132,10 @@ struct CpuDefinitionInfo {
     char *alias_of;
     bool deprecated;
 };
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qapi_free_CpuDefinitionInfo(CpuDefinitionInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuDefinitionInfo, qapi_free_CpuDefinitionInfo)
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 struct CpuDefinitionInfoList {
     CpuDefinitionInfoList *next;
     CpuDefinitionInfo *value;
@@ -192,9 +143,7 @@ struct CpuDefinitionInfoList {
 
 void qapi_free_CpuDefinitionInfoList(CpuDefinitionInfoList *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuDefinitionInfoList, qapi_free_CpuDefinitionInfoList)
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 struct q_obj_set_cpu_topology_arg {
     uint16_t core_id;
     bool has_socket_id;
@@ -208,23 +157,16 @@ struct q_obj_set_cpu_topology_arg {
     bool has_dedicated;
     bool dedicated;
 };
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 struct q_obj_CPU_POLARIZATION_CHANGE_arg {
     S390CpuPolarization polarization;
 };
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 struct CpuPolarizationInfo {
     S390CpuPolarization polarization;
 };
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qapi_free_CpuPolarizationInfo(CpuPolarizationInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(CpuPolarizationInfo, qapi_free_CpuPolarizationInfo)
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 #endif /* QAPI_TYPES_MACHINE_TARGET_H */
diff --git a/build/qapi/qapi-types-misc-target.h b/build/qapi/qapi-types-misc-target.h
index 5d0c4db219d..d3cb640e7ea 100644
--- a/build/qapi/qapi-types-misc-target.h
+++ b/build/qapi/qapi-types-misc-target.h
@@ -15,7 +15,6 @@
 
 #include "qapi/qapi-builtin-types.h"
 
-#if defined(TARGET_I386)
 typedef enum SevState {
     SEV_STATE_UNINIT,
     SEV_STATE_LAUNCH_UPDATE,
@@ -30,9 +29,7 @@ typedef enum SevState {
     qapi_enum_lookup(&SevState_lookup, (val))
 
 extern const QEnumLookup SevState_lookup;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef enum SevGuestType {
     SEV_GUEST_TYPE_SEV,
     SEV_GUEST_TYPE_SEV_SNP,
@@ -43,61 +40,35 @@ typedef enum SevGuestType {
     qapi_enum_lookup(&SevGuestType_lookup, (val))
 
 extern const QEnumLookup SevGuestType_lookup;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevGuestInfo SevGuestInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevSnpGuestInfo SevSnpGuestInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct q_obj_SevInfo_base q_obj_SevInfo_base;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevInfo SevInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevLaunchMeasureInfo SevLaunchMeasureInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevCapability SevCapability;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct q_obj_sev_inject_launch_secret_arg q_obj_sev_inject_launch_secret_arg;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct SevAttestationReport SevAttestationReport;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct q_obj_query_sev_attestation_report_arg q_obj_query_sev_attestation_report_arg;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 typedef struct GICCapability GICCapability;
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 typedef struct GICCapabilityList GICCapabilityList;
-#endif /* defined(TARGET_ARM) */
 
 typedef struct SGXEPCSection SGXEPCSection;
 
 typedef struct SGXEPCSectionList SGXEPCSectionList;
 
-#if defined(TARGET_I386)
 typedef struct SGXInfo SGXInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef enum EvtchnPortType {
     EVTCHN_PORT_TYPE_CLOSED,
     EVTCHN_PORT_TYPE_UNBOUND,
@@ -112,44 +83,28 @@ typedef enum EvtchnPortType {
     qapi_enum_lookup(&EvtchnPortType_lookup, (val))
 
 extern const QEnumLookup EvtchnPortType_lookup;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct EvtchnInfo EvtchnInfo;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct EvtchnInfoList EvtchnInfoList;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 typedef struct q_obj_xen_event_inject_arg q_obj_xen_event_inject_arg;
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevGuestInfo {
     uint32_t policy;
     uint32_t handle;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevGuestInfo(SevGuestInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevGuestInfo, qapi_free_SevGuestInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevSnpGuestInfo {
     uint64_t snp_policy;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevSnpGuestInfo(SevSnpGuestInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevSnpGuestInfo, qapi_free_SevSnpGuestInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct q_obj_SevInfo_base {
     bool enabled;
     uint8_t api_major;
@@ -158,9 +113,7 @@ struct q_obj_SevInfo_base {
     SevState state;
     SevGuestType sev_type;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevInfo {
     bool enabled;
     uint8_t api_major;
@@ -173,25 +126,17 @@ struct SevInfo {
         SevSnpGuestInfo sev_snp;
     } u;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevInfo(SevInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevInfo, qapi_free_SevInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevLaunchMeasureInfo {
     char *data;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevLaunchMeasureInfo(SevLaunchMeasureInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevLaunchMeasureInfo, qapi_free_SevLaunchMeasureInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevCapability {
     char *pdh;
     char *cert_chain;
@@ -199,53 +144,37 @@ struct SevCapability {
     int64_t cbitpos;
     int64_t reduced_phys_bits;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevCapability(SevCapability *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevCapability, qapi_free_SevCapability)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct q_obj_sev_inject_launch_secret_arg {
     char *packet_header;
     char *secret;
     bool has_gpa;
     uint64_t gpa;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct SevAttestationReport {
     char *data;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevAttestationReport(SevAttestationReport *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SevAttestationReport, qapi_free_SevAttestationReport)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct q_obj_query_sev_attestation_report_arg {
     char *mnonce;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 struct GICCapability {
     int64_t version;
     bool emulated;
     bool kernel;
 };
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 void qapi_free_GICCapability(GICCapability *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(GICCapability, qapi_free_GICCapability)
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 struct GICCapabilityList {
     GICCapabilityList *next;
     GICCapability *value;
@@ -253,7 +182,6 @@ struct GICCapabilityList {
 
 void qapi_free_GICCapabilityList(GICCapabilityList *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(GICCapabilityList, qapi_free_GICCapabilityList)
-#endif /* defined(TARGET_ARM) */
 
 struct SGXEPCSection {
     int64_t node;
@@ -271,7 +199,6 @@ struct SGXEPCSectionList {
 void qapi_free_SGXEPCSectionList(SGXEPCSectionList *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SGXEPCSectionList, qapi_free_SGXEPCSectionList)
 
-#if defined(TARGET_I386)
 struct SGXInfo {
     bool sgx;
     bool sgx1;
@@ -279,14 +206,10 @@ struct SGXInfo {
     bool flc;
     SGXEPCSectionList *sections;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SGXInfo(SGXInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(SGXInfo, qapi_free_SGXInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct EvtchnInfo {
     uint16_t port;
     uint32_t vcpu;
@@ -296,14 +219,10 @@ struct EvtchnInfo {
     bool pending;
     bool masked;
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_EvtchnInfo(EvtchnInfo *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(EvtchnInfo, qapi_free_EvtchnInfo)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct EvtchnInfoList {
     EvtchnInfoList *next;
     EvtchnInfo *value;
@@ -311,12 +230,9 @@ struct EvtchnInfoList {
 
 void qapi_free_EvtchnInfoList(EvtchnInfoList *obj);
 G_DEFINE_AUTOPTR_CLEANUP_FUNC(EvtchnInfoList, qapi_free_EvtchnInfoList)
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 struct q_obj_xen_event_inject_arg {
     uint32_t port;
 };
-#endif /* defined(TARGET_I386) */
 
 #endif /* QAPI_TYPES_MISC_TARGET_H */
diff --git a/build/qapi/qapi-visit-machine-target.h b/build/qapi/qapi-visit-machine-target.h
index fe5ea755987..3a8cff39ebe 100644
--- a/build/qapi/qapi-visit-machine-target.h
+++ b/build/qapi/qapi-visit-machine-target.h
@@ -29,69 +29,45 @@ bool visit_type_CpuModelExpansionType(Visitor *v, const char *name,
 bool visit_type_CpuModelCompareResult(Visitor *v, const char *name,
                  CpuModelCompareResult *obj, Error **errp);
 
-#if defined(TARGET_S390X)
 bool visit_type_CpuModelBaselineInfo_members(Visitor *v, CpuModelBaselineInfo *obj, Error **errp);
 
 bool visit_type_CpuModelBaselineInfo(Visitor *v, const char *name,
                  CpuModelBaselineInfo **obj, Error **errp);
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_CpuModelCompareInfo_members(Visitor *v, CpuModelCompareInfo *obj, Error **errp);
 
 bool visit_type_CpuModelCompareInfo(Visitor *v, const char *name,
                  CpuModelCompareInfo **obj, Error **errp);
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_q_obj_query_cpu_model_comparison_arg_members(Visitor *v, q_obj_query_cpu_model_comparison_arg *obj, Error **errp);
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_q_obj_query_cpu_model_baseline_arg_members(Visitor *v, q_obj_query_cpu_model_baseline_arg *obj, Error **errp);
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuModelExpansionInfo_members(Visitor *v, CpuModelExpansionInfo *obj, Error **errp);
 
 bool visit_type_CpuModelExpansionInfo(Visitor *v, const char *name,
                  CpuModelExpansionInfo **obj, Error **errp);
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_q_obj_query_cpu_model_expansion_arg_members(Visitor *v, q_obj_query_cpu_model_expansion_arg *obj, Error **errp);
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuDefinitionInfo_members(Visitor *v, CpuDefinitionInfo *obj, Error **errp);
 
 bool visit_type_CpuDefinitionInfo(Visitor *v, const char *name,
                  CpuDefinitionInfo **obj, Error **errp);
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuDefinitionInfoList(Visitor *v, const char *name,
                  CpuDefinitionInfoList **obj, Error **errp);
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X)
 bool visit_type_S390CpuPolarization(Visitor *v, const char *name,
                  S390CpuPolarization *obj, Error **errp);
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_q_obj_set_cpu_topology_arg_members(Visitor *v, q_obj_set_cpu_topology_arg *obj, Error **errp);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_q_obj_CPU_POLARIZATION_CHANGE_arg_members(Visitor *v, q_obj_CPU_POLARIZATION_CHANGE_arg *obj, Error **errp);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_CpuPolarizationInfo_members(Visitor *v, CpuPolarizationInfo *obj, Error **errp);
 
 bool visit_type_CpuPolarizationInfo(Visitor *v, const char *name,
                  CpuPolarizationInfo **obj, Error **errp);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 #endif /* QAPI_VISIT_MACHINE_TARGET_H */
diff --git a/build/qapi/qapi-visit-misc-target.h b/build/qapi/qapi-visit-misc-target.h
index bd94799ff65..63f3bee9858 100644
--- a/build/qapi/qapi-visit-misc-target.h
+++ b/build/qapi/qapi-visit-misc-target.h
@@ -17,81 +17,55 @@
 #include "qapi-types-misc-target.h"
 
 
-#if defined(TARGET_I386)
 bool visit_type_SevState(Visitor *v, const char *name,
                  SevState *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevGuestType(Visitor *v, const char *name,
                  SevGuestType *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevGuestInfo_members(Visitor *v, SevGuestInfo *obj, Error **errp);
 
 bool visit_type_SevGuestInfo(Visitor *v, const char *name,
                  SevGuestInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevSnpGuestInfo_members(Visitor *v, SevSnpGuestInfo *obj, Error **errp);
 
 bool visit_type_SevSnpGuestInfo(Visitor *v, const char *name,
                  SevSnpGuestInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_SevInfo_base_members(Visitor *v, q_obj_SevInfo_base *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevInfo_members(Visitor *v, SevInfo *obj, Error **errp);
 
 bool visit_type_SevInfo(Visitor *v, const char *name,
                  SevInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevLaunchMeasureInfo_members(Visitor *v, SevLaunchMeasureInfo *obj, Error **errp);
 
 bool visit_type_SevLaunchMeasureInfo(Visitor *v, const char *name,
                  SevLaunchMeasureInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevCapability_members(Visitor *v, SevCapability *obj, Error **errp);
 
 bool visit_type_SevCapability(Visitor *v, const char *name,
                  SevCapability **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_sev_inject_launch_secret_arg_members(Visitor *v, q_obj_sev_inject_launch_secret_arg *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevAttestationReport_members(Visitor *v, SevAttestationReport *obj, Error **errp);
 
 bool visit_type_SevAttestationReport(Visitor *v, const char *name,
                  SevAttestationReport **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_query_sev_attestation_report_arg_members(Visitor *v, q_obj_query_sev_attestation_report_arg *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 bool visit_type_GICCapability_members(Visitor *v, GICCapability *obj, Error **errp);
 
 bool visit_type_GICCapability(Visitor *v, const char *name,
                  GICCapability **obj, Error **errp);
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 bool visit_type_GICCapabilityList(Visitor *v, const char *name,
                  GICCapabilityList **obj, Error **errp);
-#endif /* defined(TARGET_ARM) */
 
 bool visit_type_SGXEPCSection_members(Visitor *v, SGXEPCSection *obj, Error **errp);
 
@@ -101,32 +75,22 @@ bool visit_type_SGXEPCSection(Visitor *v, const char *name,
 bool visit_type_SGXEPCSectionList(Visitor *v, const char *name,
                  SGXEPCSectionList **obj, Error **errp);
 
-#if defined(TARGET_I386)
 bool visit_type_SGXInfo_members(Visitor *v, SGXInfo *obj, Error **errp);
 
 bool visit_type_SGXInfo(Visitor *v, const char *name,
                  SGXInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnPortType(Visitor *v, const char *name,
                  EvtchnPortType *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnInfo_members(Visitor *v, EvtchnInfo *obj, Error **errp);
 
 bool visit_type_EvtchnInfo(Visitor *v, const char *name,
                  EvtchnInfo **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnInfoList(Visitor *v, const char *name,
                  EvtchnInfoList **obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_xen_event_inject_arg_members(Visitor *v, q_obj_xen_event_inject_arg *obj, Error **errp);
-#endif /* defined(TARGET_I386) */
 
 #endif /* QAPI_VISIT_MISC_TARGET_H */
diff --git a/build/qapi/qapi-builtin-visit.c b/build/qapi/qapi-builtin-visit.c
index 09a2e00d52b..51f0b0af111 100644
--- a/build/qapi/qapi-builtin-visit.c
+++ b/build/qapi/qapi-builtin-visit.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
 
diff --git a/build/qapi/qapi-commands-acpi.c b/build/qapi/qapi-commands-acpi.c
index 874eee92937..3ea63671ffe 100644
--- a/build/qapi/qapi-commands-acpi.c
+++ b/build/qapi/qapi-commands-acpi.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-audio.c b/build/qapi/qapi-commands-audio.c
index afc0e1457ee..8d53e4325c7 100644
--- a/build/qapi/qapi-commands-audio.c
+++ b/build/qapi/qapi-commands-audio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-authz.c b/build/qapi/qapi-commands-authz.c
index 0b63dcd080b..51dcf3e1049 100644
--- a/build/qapi/qapi-commands-authz.c
+++ b/build/qapi/qapi-commands-authz.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-block-core.c b/build/qapi/qapi-commands-block-core.c
index a28bafe1645..6cd3d7bb5d9 100644
--- a/build/qapi/qapi-commands-block-core.c
+++ b/build/qapi/qapi-commands-block-core.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-block-export.c b/build/qapi/qapi-commands-block-export.c
index ddb844a9389..a8c9ef852a8 100644
--- a/build/qapi/qapi-commands-block-export.c
+++ b/build/qapi/qapi-commands-block-export.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-block.c b/build/qapi/qapi-commands-block.c
index 23063ed2dbe..bbd8c66d53a 100644
--- a/build/qapi/qapi-commands-block.c
+++ b/build/qapi/qapi-commands-block.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-char.c b/build/qapi/qapi-commands-char.c
index 715200ec081..b6c065f8bc8 100644
--- a/build/qapi/qapi-commands-char.c
+++ b/build/qapi/qapi-commands-char.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-common.c b/build/qapi/qapi-commands-common.c
index b4480f93264..b1482337014 100644
--- a/build/qapi/qapi-commands-common.c
+++ b/build/qapi/qapi-commands-common.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-compat.c b/build/qapi/qapi-commands-compat.c
index 2ae394f0223..caf395d16c0 100644
--- a/build/qapi/qapi-commands-compat.c
+++ b/build/qapi/qapi-commands-compat.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-control.c b/build/qapi/qapi-commands-control.c
index 264951abf58..49ee9b7c91e 100644
--- a/build/qapi/qapi-commands-control.c
+++ b/build/qapi/qapi-commands-control.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-crypto.c b/build/qapi/qapi-commands-crypto.c
index e1ff9aeb7bb..606989f243b 100644
--- a/build/qapi/qapi-commands-crypto.c
+++ b/build/qapi/qapi-commands-crypto.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-cryptodev.c b/build/qapi/qapi-commands-cryptodev.c
index 01899e075fb..24c6a12c20d 100644
--- a/build/qapi/qapi-commands-cryptodev.c
+++ b/build/qapi/qapi-commands-cryptodev.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-cxl.c b/build/qapi/qapi-commands-cxl.c
index 7e181fd6038..43b1b65c20d 100644
--- a/build/qapi/qapi-commands-cxl.c
+++ b/build/qapi/qapi-commands-cxl.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-dump.c b/build/qapi/qapi-commands-dump.c
index f2f75bb8b01..f28ed412e19 100644
--- a/build/qapi/qapi-commands-dump.c
+++ b/build/qapi/qapi-commands-dump.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-ebpf.c b/build/qapi/qapi-commands-ebpf.c
index 55b50d655f2..d5184c57f3f 100644
--- a/build/qapi/qapi-commands-ebpf.c
+++ b/build/qapi/qapi-commands-ebpf.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-error.c b/build/qapi/qapi-commands-error.c
index b389572a039..cf276ff0504 100644
--- a/build/qapi/qapi-commands-error.c
+++ b/build/qapi/qapi-commands-error.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-introspect.c b/build/qapi/qapi-commands-introspect.c
index a5d8b87eeb1..5c73bb09326 100644
--- a/build/qapi/qapi-commands-introspect.c
+++ b/build/qapi/qapi-commands-introspect.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-job.c b/build/qapi/qapi-commands-job.c
index adaab4d5785..1e91e01be26 100644
--- a/build/qapi/qapi-commands-job.c
+++ b/build/qapi/qapi-commands-job.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-machine-common.c b/build/qapi/qapi-commands-machine-common.c
index a81689deb63..d3e39993990 100644
--- a/build/qapi/qapi-commands-machine-common.c
+++ b/build/qapi/qapi-commands-machine-common.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-machine-target.c b/build/qapi/qapi-commands-machine-target.c
index 902a7cbcb8c..ce49ae3231f 100644
--- a/build/qapi/qapi-commands-machine-target.c
+++ b/build/qapi/qapi-commands-machine-target.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
@@ -21,7 +22,6 @@
 #include "qobject/qjson.h"
 #include "trace/trace-qapi_commands_machine_target_trace_events.h"
 
-#if defined(TARGET_S390X)
 static void qmp_marshal_output_CpuModelCompareInfo(CpuModelCompareInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -36,9 +36,7 @@ static void qmp_marshal_output_CpuModelCompareInfo(CpuModelCompareInfo *ret_in,
     visit_type_CpuModelCompareInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 void qmp_marshal_query_cpu_model_comparison(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -88,9 +86,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 static void qmp_marshal_output_CpuModelBaselineInfo(CpuModelBaselineInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -105,9 +101,7 @@ static void qmp_marshal_output_CpuModelBaselineInfo(CpuModelBaselineInfo *ret_in
     visit_type_CpuModelBaselineInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 void qmp_marshal_query_cpu_model_baseline(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -157,9 +151,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 static void qmp_marshal_output_CpuModelExpansionInfo(CpuModelExpansionInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -174,9 +166,7 @@ static void qmp_marshal_output_CpuModelExpansionInfo(CpuModelExpansionInfo *ret_
     visit_type_CpuModelExpansionInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qmp_marshal_query_cpu_model_expansion(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -226,9 +216,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 static void qmp_marshal_output_CpuDefinitionInfoList(CpuDefinitionInfoList *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -243,9 +231,7 @@ static void qmp_marshal_output_CpuDefinitionInfoList(CpuDefinitionInfoList *ret_
     visit_type_CpuDefinitionInfoList(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qmp_marshal_query_cpu_definitions(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -291,9 +277,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qmp_marshal_set_cpu_topology(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -336,9 +320,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 static void qmp_marshal_output_CpuPolarizationInfo(CpuPolarizationInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -353,9 +335,7 @@ static void qmp_marshal_output_CpuPolarizationInfo(CpuPolarizationInfo *ret_in,
     visit_type_CpuPolarizationInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qmp_marshal_query_s390x_cpu_polarization(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -401,7 +381,6 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_commands_machine_target_c;
diff --git a/build/qapi/qapi-commands-machine.c b/build/qapi/qapi-commands-machine.c
index d428655ccd3..7b19d36cd80 100644
--- a/build/qapi/qapi-commands-machine.c
+++ b/build/qapi/qapi-commands-machine.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-migration.c b/build/qapi/qapi-commands-migration.c
index 040632a2fa8..4bd5776decd 100644
--- a/build/qapi/qapi-commands-migration.c
+++ b/build/qapi/qapi-commands-migration.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-misc-target.c b/build/qapi/qapi-commands-misc-target.c
index fe07b76a8b0..b7535ef2df1 100644
--- a/build/qapi/qapi-commands-misc-target.c
+++ b/build/qapi/qapi-commands-misc-target.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
@@ -21,7 +22,6 @@
 #include "qobject/qjson.h"
 #include "trace/trace-qapi_commands_misc_target_trace_events.h"
 
-#if defined(TARGET_I386)
 void qmp_marshal_rtc_reset_reinjection(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -60,9 +60,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_SevInfo(SevInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -77,9 +75,7 @@ static void qmp_marshal_output_SevInfo(SevInfo *ret_in,
     visit_type_SevInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sev(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -125,9 +121,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_SevLaunchMeasureInfo(SevLaunchMeasureInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -142,9 +136,7 @@ static void qmp_marshal_output_SevLaunchMeasureInfo(SevLaunchMeasureInfo *ret_in
     visit_type_SevLaunchMeasureInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sev_launch_measure(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -190,9 +182,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_SevCapability(SevCapability *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -207,9 +197,7 @@ static void qmp_marshal_output_SevCapability(SevCapability *ret_in,
     visit_type_SevCapability(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sev_capabilities(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -255,9 +243,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_sev_inject_launch_secret(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -300,9 +286,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_SevAttestationReport(SevAttestationReport *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -317,9 +301,7 @@ static void qmp_marshal_output_SevAttestationReport(SevAttestationReport *ret_in
     visit_type_SevAttestationReport(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sev_attestation_report(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -369,9 +351,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 static void qmp_marshal_output_GICCapabilityList(GICCapabilityList *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -386,9 +366,7 @@ static void qmp_marshal_output_GICCapabilityList(GICCapabilityList *ret_in,
     visit_type_GICCapabilityList(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 void qmp_marshal_query_gic_capabilities(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -434,9 +412,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_SGXInfo(SGXInfo *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -451,9 +427,7 @@ static void qmp_marshal_output_SGXInfo(SGXInfo *ret_in,
     visit_type_SGXInfo(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sgx(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -499,9 +473,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_query_sgx_capabilities(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -547,9 +519,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 static void qmp_marshal_output_EvtchnInfoList(EvtchnInfoList *ret_in,
                                 QObject **ret_out, Error **errp)
 {
@@ -564,9 +534,7 @@ static void qmp_marshal_output_EvtchnInfoList(EvtchnInfoList *ret_in,
     visit_type_EvtchnInfoList(v, "unused", &ret_in, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_xen_event_list(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -612,9 +580,7 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qmp_marshal_xen_event_inject(QDict *args, QObject **ret, Error **errp)
 {
     Error *err = NULL;
@@ -657,7 +623,6 @@ out:
     visit_end_struct(v, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_commands_misc_target_c;
diff --git a/build/qapi/qapi-commands-misc.c b/build/qapi/qapi-commands-misc.c
index cc10565a251..68e07f583e4 100644
--- a/build/qapi/qapi-commands-misc.c
+++ b/build/qapi/qapi-commands-misc.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-net.c b/build/qapi/qapi-commands-net.c
index 48005e68ca4..8c66a9e1b90 100644
--- a/build/qapi/qapi-commands-net.c
+++ b/build/qapi/qapi-commands-net.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-pci.c b/build/qapi/qapi-commands-pci.c
index a93b6be872d..3fb3cac2aa1 100644
--- a/build/qapi/qapi-commands-pci.c
+++ b/build/qapi/qapi-commands-pci.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-pragma.c b/build/qapi/qapi-commands-pragma.c
index ded9d905d12..c49a4a7ec48 100644
--- a/build/qapi/qapi-commands-pragma.c
+++ b/build/qapi/qapi-commands-pragma.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-qdev.c b/build/qapi/qapi-commands-qdev.c
index 0527bcc42f2..1c43b8aa201 100644
--- a/build/qapi/qapi-commands-qdev.c
+++ b/build/qapi/qapi-commands-qdev.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-qom.c b/build/qapi/qapi-commands-qom.c
index 3cc1f56162f..f61ede2f987 100644
--- a/build/qapi/qapi-commands-qom.c
+++ b/build/qapi/qapi-commands-qom.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-replay.c b/build/qapi/qapi-commands-replay.c
index 67758365e12..55c4e98102f 100644
--- a/build/qapi/qapi-commands-replay.c
+++ b/build/qapi/qapi-commands-replay.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-rocker.c b/build/qapi/qapi-commands-rocker.c
index 8601446a542..153d0ec24bb 100644
--- a/build/qapi/qapi-commands-rocker.c
+++ b/build/qapi/qapi-commands-rocker.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-run-state.c b/build/qapi/qapi-commands-run-state.c
index d629c6fd5ac..11fbea9ca6f 100644
--- a/build/qapi/qapi-commands-run-state.c
+++ b/build/qapi/qapi-commands-run-state.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-sockets.c b/build/qapi/qapi-commands-sockets.c
index 1efed55889c..80b631e4c0a 100644
--- a/build/qapi/qapi-commands-sockets.c
+++ b/build/qapi/qapi-commands-sockets.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-stats.c b/build/qapi/qapi-commands-stats.c
index e8eb8322f96..563edccf03a 100644
--- a/build/qapi/qapi-commands-stats.c
+++ b/build/qapi/qapi-commands-stats.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-tpm.c b/build/qapi/qapi-commands-tpm.c
index 2550155771c..317f0007227 100644
--- a/build/qapi/qapi-commands-tpm.c
+++ b/build/qapi/qapi-commands-tpm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-trace.c b/build/qapi/qapi-commands-trace.c
index 0518c3c586b..79b8ecf4baa 100644
--- a/build/qapi/qapi-commands-trace.c
+++ b/build/qapi/qapi-commands-trace.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-transaction.c b/build/qapi/qapi-commands-transaction.c
index 25ebee37918..1de65d98993 100644
--- a/build/qapi/qapi-commands-transaction.c
+++ b/build/qapi/qapi-commands-transaction.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-uefi.c b/build/qapi/qapi-commands-uefi.c
index 43e18e05cf3..28dbfe9d0a0 100644
--- a/build/qapi/qapi-commands-uefi.c
+++ b/build/qapi/qapi-commands-uefi.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-ui.c b/build/qapi/qapi-commands-ui.c
index ecd0e5a9c71..49995203443 100644
--- a/build/qapi/qapi-commands-ui.c
+++ b/build/qapi/qapi-commands-ui.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-vfio.c b/build/qapi/qapi-commands-vfio.c
index 2bde1f7302f..02a6ee7403a 100644
--- a/build/qapi/qapi-commands-vfio.c
+++ b/build/qapi/qapi-commands-vfio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-virtio.c b/build/qapi/qapi-commands-virtio.c
index f305a5504d1..a12c9602c71 100644
--- a/build/qapi/qapi-commands-virtio.c
+++ b/build/qapi/qapi-commands-virtio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands-yank.c b/build/qapi/qapi-commands-yank.c
index 48943fccb70..632a3bc86a8 100644
--- a/build/qapi/qapi-commands-yank.c
+++ b/build/qapi/qapi-commands-yank.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-commands.c b/build/qapi/qapi-commands.c
index e1219b4e500..7a2b1bbd0ce 100644
--- a/build/qapi/qapi-commands.c
+++ b/build/qapi/qapi-commands.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/compat-policy.h"
 #include "qapi/visitor.h"
 #include "qobject/qdict.h"
diff --git a/build/qapi/qapi-events-machine-target.c b/build/qapi/qapi-events-machine-target.c
index aee7f0e2ef1..00e5b4e4a84 100644
--- a/build/qapi/qapi-events-machine-target.c
+++ b/build/qapi/qapi-events-machine-target.c
@@ -19,7 +19,6 @@
 #include "qobject/qdict.h"
 #include "qapi/qmp-event.h"
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qapi_event_send_cpu_polarization_change(S390CpuPolarization polarization)
 {
     QDict *qmp;
@@ -53,7 +52,6 @@ void qapi_event_send_cpu_polarization_change(S390CpuPolarization polarization)
     visit_free(v);
     qobject_unref(qmp);
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_events_machine_target_c;
diff --git a/build/qapi/qapi-init-commands.c b/build/qapi/qapi-init-commands.c
index 2148e704e27..0a1865a7a16 100644
--- a/build/qapi/qapi-init-commands.c
+++ b/build/qapi/qapi-init-commands.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi-commands.h"
 #include "qapi-init-commands.h"
 #include "qapi-features.h"
@@ -419,30 +420,30 @@ void qmp_init_marshal(QmpCommandList *cmds)
                          qmp_marshal_x_query_interrupt_controllers, 0, 1u << QAPI_FEATURE_UNSTABLE);
     qmp_register_command(cmds, "dump-skeys",
                          qmp_marshal_dump_skeys, 0, 0);
-#if defined(TARGET_S390X)
+if (target_s390x()) {
     qmp_register_command(cmds, "query-cpu-model-comparison",
                          qmp_marshal_query_cpu_model_comparison, 0, 0);
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X)
+} /* (target_s390x()) */
+if (target_s390x()) {
     qmp_register_command(cmds, "query-cpu-model-baseline",
                          qmp_marshal_query_cpu_model_baseline, 0, 0);
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
+} /* (target_s390x()) */
+if (target_s390x() || target_i386() || target_x86_64() || target_arm() || target_aarch64() || target_loongarch64() || target_riscv32() || target_riscv64()) {
     qmp_register_command(cmds, "query-cpu-model-expansion",
                          qmp_marshal_query_cpu_model_expansion, 0, 0);
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
+} /* (target_s390x() || target_i386() || target_x86_64() || target_arm() || target_aarch64() || target_loongarch64() || target_riscv32() || target_riscv64()) */
+if (target_ppc() || target_ppc64() || target_arm() || target_aarch64() || target_i386() || target_x86_64() || target_s390x() || target_mips() || target_mips64() || target_loongarch64() || target_riscv32() || target_riscv64()) {
     qmp_register_command(cmds, "query-cpu-definitions",
                          qmp_marshal_query_cpu_definitions, 0, 0);
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
+} /* (target_ppc() || target_ppc64() || target_arm() || target_aarch64() || target_i386() || target_x86_64() || target_s390x() || target_mips() || target_mips64() || target_loongarch64() || target_riscv32() || target_riscv64()) */
+if (target_s390x() && target_has_kvm()) {
     qmp_register_command(cmds, "set-cpu-topology",
                          qmp_marshal_set_cpu_topology, 0, 1u << QAPI_FEATURE_UNSTABLE);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
+} /* (target_s390x() && target_has_kvm()) */
+if (target_s390x() && target_has_kvm()) {
     qmp_register_command(cmds, "query-s390x-cpu-polarization",
                          qmp_marshal_query_s390x_cpu_polarization, 0, 1u << QAPI_FEATURE_UNSTABLE);
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
+} /* (target_s390x() && target_has_kvm()) */
     qmp_register_command(cmds, "query-replay",
                          qmp_marshal_query_replay, 0, 0);
     qmp_register_command(cmds, "replay-break",
@@ -487,50 +488,50 @@ void qmp_init_marshal(QmpCommandList *cmds)
                          qmp_marshal_query_fdsets, 0, 0);
     qmp_register_command(cmds, "query-command-line-options",
                          qmp_marshal_query_command_line_options, QCO_ALLOW_PRECONFIG, 0);
-#if defined(TARGET_I386)
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "rtc-reset-reinjection",
                          qmp_marshal_rtc_reset_reinjection, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sev",
                          qmp_marshal_query_sev, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sev-launch-measure",
                          qmp_marshal_query_sev_launch_measure, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sev-capabilities",
                          qmp_marshal_query_sev_capabilities, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "sev-inject-launch-secret",
                          qmp_marshal_sev_inject_launch_secret, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sev-attestation-report",
                          qmp_marshal_query_sev_attestation_report, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_ARM)
+} /* (target_i386() || target_x86_64()) */
+if (target_arm() || target_aarch64()) {
     qmp_register_command(cmds, "query-gic-capabilities",
                          qmp_marshal_query_gic_capabilities, 0, 0);
-#endif /* defined(TARGET_ARM) */
-#if defined(TARGET_I386)
+} /* (target_arm() || target_aarch64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sgx",
                          qmp_marshal_query_sgx, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "query-sgx-capabilities",
                          qmp_marshal_query_sgx_capabilities, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "xen-event-list",
                          qmp_marshal_xen_event_list, 0, 0);
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
+} /* (target_i386() || target_x86_64()) */
+if (target_i386() || target_x86_64()) {
     qmp_register_command(cmds, "xen-event-inject",
                          qmp_marshal_xen_event_inject, 0, 0);
-#endif /* defined(TARGET_I386) */
+} /* (target_i386() || target_x86_64()) */
     qmp_register_command(cmds, "query-audiodevs",
                          qmp_marshal_query_audiodevs, 0, 0);
     qmp_register_command(cmds, "query-acpi-ospm-status",
diff --git a/build/qapi/qapi-introspect.c b/build/qapi/qapi-introspect.c
index 6f7aad0c0a5..71ffb9d420a 100644
--- a/build/qapi/qapi-introspect.c
+++ b/build/qapi/qapi-introspect.c
@@ -10,9 +10,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi-introspect.h"
 
-const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
+QObject *qmp_schema_qobject(void) {
+    const QLitObject res = QLIT_QLIST(((QLitObject[]) {
     QLIT_QDICT(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
@@ -1742,44 +1744,35 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "ret-type", QLIT_QSTR("0"), },
         {}
     })),
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("221"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-cpu-model-comparison"), },
         { "ret-type", QLIT_QSTR("222"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("223"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-cpu-model-baseline"), },
         { "ret-type", QLIT_QSTR("224"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("225"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-cpu-model-expansion"), },
         { "ret-type", QLIT_QSTR("226"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x() || target_i386() || target_x86_64() || target_arm() || target_aarch64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-cpu-definitions"), },
         { "ret-type", QLIT_QSTR("[227]"), },
         {}
-    })),
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_ppc() || target_ppc64() || target_arm() || target_aarch64() || target_i386() || target_x86_64() || target_s390x() || target_mips() || target_mips64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("228"), },
         { "features", QLIT_QLIST(((QLitObject[]) {
             QLIT_QSTR("unstable"),
@@ -1789,10 +1782,8 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "name", QLIT_QSTR("set-cpu-topology"), },
         { "ret-type", QLIT_QSTR("0"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x() && target_has_kvm()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("229"), },
         { "features", QLIT_QLIST(((QLitObject[]) {
             QLIT_QSTR("unstable"),
@@ -1801,10 +1792,8 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("event"), },
         { "name", QLIT_QSTR("CPU_POLARIZATION_CHANGE"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x() && target_has_kvm()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "features", QLIT_QLIST(((QLitObject[]) {
             QLIT_QSTR("unstable"),
@@ -1814,8 +1803,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "name", QLIT_QSTR("query-s390x-cpu-polarization"), },
         { "ret-type", QLIT_QSTR("230"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
+    }), (!(target_s390x() && target_has_kvm()))),
     QLIT_QDICT(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
@@ -1982,105 +1970,83 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "name", QLIT_QSTR("VFU_CLIENT_HANGUP"), },
         {}
     })),
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("rtc-reset-reinjection"), },
         { "ret-type", QLIT_QSTR("0"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sev"), },
         { "ret-type", QLIT_QSTR("251"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sev-launch-measure"), },
         { "ret-type", QLIT_QSTR("252"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sev-capabilities"), },
         { "ret-type", QLIT_QSTR("253"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("254"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("sev-inject-launch-secret"), },
         { "ret-type", QLIT_QSTR("0"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("255"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sev-attestation-report"), },
         { "ret-type", QLIT_QSTR("256"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_ARM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-gic-capabilities"), },
         { "ret-type", QLIT_QSTR("[257]"), },
         {}
-    })),
-#endif /* defined(TARGET_ARM) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_arm() || target_aarch64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sgx"), },
         { "ret-type", QLIT_QSTR("258"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("query-sgx-capabilities"), },
         { "ret-type", QLIT_QSTR("258"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("xen-event-list"), },
         { "ret-type", QLIT_QSTR("[259]"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("260"), },
         { "meta-type", QLIT_QSTR("command"), },
         { "name", QLIT_QSTR("xen-event-inject"), },
         { "ret-type", QLIT_QSTR("0"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     QLIT_QDICT(((QLitDictEntry[]) {
         { "arg-type", QLIT_QSTR("0"), },
         { "meta-type", QLIT_QSTR("command"), },
@@ -10010,8 +9976,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         {}
     })),
     /* "221" = q_obj_query-cpu-model-comparison-arg */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("modela"), },
@@ -10028,11 +9993,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("221"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
+    }), (!(target_s390x()))),
     /* "222" = CpuModelCompareInfo */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("result"), },
@@ -10049,11 +10012,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("222"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
+    }), (!(target_s390x()))),
     /* "223" = q_obj_query-cpu-model-baseline-arg */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("modela"), },
@@ -10070,11 +10031,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("223"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
+    }), (!(target_s390x()))),
     /* "224" = CpuModelBaselineInfo */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("model"), },
@@ -10086,11 +10045,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("224"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
+    }), (!(target_s390x()))),
     /* "225" = q_obj_query-cpu-model-expansion-arg */
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("type"), },
@@ -10107,42 +10064,34 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("225"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
+    }), (!(target_s390x() || target_i386() || target_x86_64() || target_arm() || target_aarch64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
     /* "226" = CpuModelExpansionInfo */
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("model"), },
                 { "type", QLIT_QSTR("524"), },
                 {}
             })),
-#if defined(TARGET_S390X)
-            QLIT_QDICT(((QLitDictEntry[]) {
+            QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("deprecated-props"), },
                 { "type", QLIT_QSTR("[str]"), },
                 {}
-            })),
-#endif /* defined(TARGET_S390X) */
+            }), (!(target_s390x()))),
             {}
         })), },
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("226"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_s390x() || target_i386() || target_x86_64() || target_arm() || target_aarch64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "element-type", QLIT_QSTR("227"), },
         { "meta-type", QLIT_QSTR("array"), },
         { "name", QLIT_QSTR("[227]"), },
         {}
-    })),
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
+    }), (!(target_ppc() || target_ppc64() || target_arm() || target_aarch64() || target_i386() || target_x86_64() || target_s390x() || target_mips() || target_mips64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
     /* "227" = CpuDefinitionInfo */
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("name"), },
@@ -10187,11 +10136,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("227"), },
         {}
-    })),
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
+    }), (!(target_ppc() || target_ppc64() || target_arm() || target_aarch64() || target_i386() || target_x86_64() || target_s390x() || target_mips() || target_mips64() || target_loongarch64() || target_riscv32() || target_riscv64()))),
     /* "228" = q_obj_set-cpu-topology-arg */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("core-id"), },
@@ -10233,11 +10180,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("228"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
+    }), (!(target_s390x() && target_has_kvm()))),
     /* "229" = q_obj_CPU_POLARIZATION_CHANGE-arg */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("polarization"), },
@@ -10249,11 +10194,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("229"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
+    }), (!(target_s390x() && target_has_kvm()))),
     /* "230" = CpuPolarizationInfo */
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("polarization"), },
@@ -10265,8 +10208,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("230"), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
+    }), (!(target_s390x() && target_has_kvm()))),
     /* "231" = ReplayInfo */
     QLIT_QDICT(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
@@ -10709,8 +10651,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         {}
     })),
     /* "251" = SevInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("enabled"), },
@@ -10761,11 +10702,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
             {}
         })), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "252" = SevLaunchMeasureInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("data"), },
@@ -10777,11 +10716,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("252"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "253" = SevCapability */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("pdh"), },
@@ -10813,11 +10750,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("253"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "254" = q_obj_sev-inject-launch-secret-arg */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("packet-header"), },
@@ -10840,11 +10775,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("254"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "255" = q_obj_query-sev-attestation-report-arg */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("mnonce"), },
@@ -10856,11 +10789,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("255"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "256" = SevAttestationReport */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("data"), },
@@ -10872,19 +10803,15 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("256"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_ARM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "element-type", QLIT_QSTR("257"), },
         { "meta-type", QLIT_QSTR("array"), },
         { "name", QLIT_QSTR("[257]"), },
         {}
-    })),
-#endif /* defined(TARGET_ARM) */
+    }), (!(target_arm() || target_aarch64()))),
     /* "257" = GICCapability */
-#if defined(TARGET_ARM)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("version"), },
@@ -10906,11 +10833,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("257"), },
         {}
-    })),
-#endif /* defined(TARGET_ARM) */
+    }), (!(target_arm() || target_aarch64()))),
     /* "258" = SGXInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("sgx"), },
@@ -10942,19 +10867,15 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("258"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    }), (!(target_i386() || target_x86_64()))),
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "element-type", QLIT_QSTR("259"), },
         { "meta-type", QLIT_QSTR("array"), },
         { "name", QLIT_QSTR("[259]"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "259" = EvtchnInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("port"), },
@@ -10996,11 +10917,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("259"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "260" = q_obj_xen-event-inject-arg */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("port"), },
@@ -11012,8 +10931,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("260"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     QLIT_QDICT(((QLitDictEntry[]) {
         { "element-type", QLIT_QSTR("261"), },
         { "meta-type", QLIT_QSTR("array"), },
@@ -22774,8 +22692,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         {}
     })),
     /* "528" = S390CpuPolarization */
-#if defined(TARGET_S390X)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("horizontal"), },
@@ -22795,8 +22712,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
             {}
         })), },
         {}
-    })),
-#endif /* defined(TARGET_S390X) */
+    }), (!(target_s390x()))),
     /* "529" = ReplayMode */
     QLIT_QDICT(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
@@ -22943,8 +22859,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         {}
     })),
     /* "535" = SevState */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("uninit"), },
@@ -22984,11 +22899,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
             {}
         })), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "536" = SevGuestType */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("sev"), },
@@ -23008,11 +22921,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
             {}
         })), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "537" = SevGuestInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("policy"), },
@@ -23029,11 +22940,9 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("537"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "538" = SevSnpGuestInfo */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("snp-policy"), },
@@ -23045,8 +22954,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         { "meta-type", QLIT_QSTR("object"), },
         { "name", QLIT_QSTR("538"), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     QLIT_QDICT(((QLitDictEntry[]) {
         { "element-type", QLIT_QSTR("539"), },
         { "meta-type", QLIT_QSTR("array"), },
@@ -23073,8 +22981,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         {}
     })),
     /* "540" = EvtchnPortType */
-#if defined(TARGET_I386)
-    QLIT_QDICT(((QLitDictEntry[]) {
+    QLIT_QDICT_HIDDEN(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
             QLIT_QDICT(((QLitDictEntry[]) {
                 { "name", QLIT_QSTR("closed"), },
@@ -23114,8 +23021,7 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
             {}
         })), },
         {}
-    })),
-#endif /* defined(TARGET_I386) */
+    }), (!(target_i386() || target_x86_64()))),
     /* "541" = AudiodevDriver */
     QLIT_QDICT(((QLitDictEntry[]) {
         { "members", QLIT_QLIST(((QLitObject[]) {
@@ -32264,6 +32170,8 @@ const QLitObject qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
     })),
     {}
 }));
+    return qobject_from_qlit(&res);
+}
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_introspect_c;
diff --git a/build/qapi/qapi-types-machine-target.c b/build/qapi/qapi-types-machine-target.c
index d3d2c9e5d65..c8f7e6d2920 100644
--- a/build/qapi/qapi-types-machine-target.c
+++ b/build/qapi/qapi-types-machine-target.c
@@ -47,7 +47,6 @@ const QEnumLookup CpuModelCompareResult_lookup = {
     .size = CPU_MODEL_COMPARE_RESULT__MAX
 };
 
-#if defined(TARGET_S390X)
 void qapi_free_CpuModelBaselineInfo(CpuModelBaselineInfo *obj)
 {
     Visitor *v;
@@ -60,9 +59,7 @@ void qapi_free_CpuModelBaselineInfo(CpuModelBaselineInfo *obj)
     visit_type_CpuModelBaselineInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 void qapi_free_CpuModelCompareInfo(CpuModelCompareInfo *obj)
 {
     Visitor *v;
@@ -75,9 +72,7 @@ void qapi_free_CpuModelCompareInfo(CpuModelCompareInfo *obj)
     visit_type_CpuModelCompareInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qapi_free_CpuModelExpansionInfo(CpuModelExpansionInfo *obj)
 {
     Visitor *v;
@@ -90,9 +85,7 @@ void qapi_free_CpuModelExpansionInfo(CpuModelExpansionInfo *obj)
     visit_type_CpuModelExpansionInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qapi_free_CpuDefinitionInfo(CpuDefinitionInfo *obj)
 {
     Visitor *v;
@@ -105,9 +98,7 @@ void qapi_free_CpuDefinitionInfo(CpuDefinitionInfo *obj)
     visit_type_CpuDefinitionInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 void qapi_free_CpuDefinitionInfoList(CpuDefinitionInfoList *obj)
 {
     Visitor *v;
@@ -120,9 +111,7 @@ void qapi_free_CpuDefinitionInfoList(CpuDefinitionInfoList *obj)
     visit_type_CpuDefinitionInfoList(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X)
 const QEnumLookup S390CpuPolarization_lookup = {
     .array = (const char *const[]) {
         [S390_CPU_POLARIZATION_HORIZONTAL] = "horizontal",
@@ -130,9 +119,7 @@ const QEnumLookup S390CpuPolarization_lookup = {
     },
     .size = S390_CPU_POLARIZATION__MAX
 };
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 void qapi_free_CpuPolarizationInfo(CpuPolarizationInfo *obj)
 {
     Visitor *v;
@@ -145,7 +132,6 @@ void qapi_free_CpuPolarizationInfo(CpuPolarizationInfo *obj)
     visit_type_CpuPolarizationInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_types_machine_target_c;
diff --git a/build/qapi/qapi-types-misc-target.c b/build/qapi/qapi-types-misc-target.c
index ed859f7d8fc..4e90fc28756 100644
--- a/build/qapi/qapi-types-misc-target.c
+++ b/build/qapi/qapi-types-misc-target.c
@@ -16,7 +16,6 @@
 #include "qapi-visit-misc-target.h"
 #include "qapi-features.h"
 
-#if defined(TARGET_I386)
 const QEnumLookup SevState_lookup = {
     .array = (const char *const[]) {
         [SEV_STATE_UNINIT] = "uninit",
@@ -28,9 +27,7 @@ const QEnumLookup SevState_lookup = {
     },
     .size = SEV_STATE__MAX
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 const QEnumLookup SevGuestType_lookup = {
     .array = (const char *const[]) {
         [SEV_GUEST_TYPE_SEV] = "sev",
@@ -38,9 +35,7 @@ const QEnumLookup SevGuestType_lookup = {
     },
     .size = SEV_GUEST_TYPE__MAX
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevGuestInfo(SevGuestInfo *obj)
 {
     Visitor *v;
@@ -53,9 +48,7 @@ void qapi_free_SevGuestInfo(SevGuestInfo *obj)
     visit_type_SevGuestInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevSnpGuestInfo(SevSnpGuestInfo *obj)
 {
     Visitor *v;
@@ -68,9 +61,7 @@ void qapi_free_SevSnpGuestInfo(SevSnpGuestInfo *obj)
     visit_type_SevSnpGuestInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevInfo(SevInfo *obj)
 {
     Visitor *v;
@@ -83,9 +74,7 @@ void qapi_free_SevInfo(SevInfo *obj)
     visit_type_SevInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevLaunchMeasureInfo(SevLaunchMeasureInfo *obj)
 {
     Visitor *v;
@@ -98,9 +87,7 @@ void qapi_free_SevLaunchMeasureInfo(SevLaunchMeasureInfo *obj)
     visit_type_SevLaunchMeasureInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevCapability(SevCapability *obj)
 {
     Visitor *v;
@@ -113,9 +100,7 @@ void qapi_free_SevCapability(SevCapability *obj)
     visit_type_SevCapability(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_SevAttestationReport(SevAttestationReport *obj)
 {
     Visitor *v;
@@ -128,9 +113,7 @@ void qapi_free_SevAttestationReport(SevAttestationReport *obj)
     visit_type_SevAttestationReport(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 void qapi_free_GICCapability(GICCapability *obj)
 {
     Visitor *v;
@@ -143,9 +126,7 @@ void qapi_free_GICCapability(GICCapability *obj)
     visit_type_GICCapability(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 void qapi_free_GICCapabilityList(GICCapabilityList *obj)
 {
     Visitor *v;
@@ -158,7 +139,6 @@ void qapi_free_GICCapabilityList(GICCapabilityList *obj)
     visit_type_GICCapabilityList(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_ARM) */
 
 void qapi_free_SGXEPCSection(SGXEPCSection *obj)
 {
@@ -186,7 +166,6 @@ void qapi_free_SGXEPCSectionList(SGXEPCSectionList *obj)
     visit_free(v);
 }
 
-#if defined(TARGET_I386)
 void qapi_free_SGXInfo(SGXInfo *obj)
 {
     Visitor *v;
@@ -199,9 +178,7 @@ void qapi_free_SGXInfo(SGXInfo *obj)
     visit_type_SGXInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 const QEnumLookup EvtchnPortType_lookup = {
     .array = (const char *const[]) {
         [EVTCHN_PORT_TYPE_CLOSED] = "closed",
@@ -213,9 +190,7 @@ const QEnumLookup EvtchnPortType_lookup = {
     },
     .size = EVTCHN_PORT_TYPE__MAX
 };
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_EvtchnInfo(EvtchnInfo *obj)
 {
     Visitor *v;
@@ -228,9 +203,7 @@ void qapi_free_EvtchnInfo(EvtchnInfo *obj)
     visit_type_EvtchnInfo(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 void qapi_free_EvtchnInfoList(EvtchnInfoList *obj)
 {
     Visitor *v;
@@ -243,7 +216,6 @@ void qapi_free_EvtchnInfoList(EvtchnInfoList *obj)
     visit_type_EvtchnInfoList(v, NULL, &obj, NULL);
     visit_free(v);
 }
-#endif /* defined(TARGET_I386) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_types_misc_target_c;
diff --git a/build/qapi/qapi-visit-acpi.c b/build/qapi/qapi-visit-acpi.c
index d84e825417b..78c816a6c2d 100644
--- a/build/qapi/qapi-visit-acpi.c
+++ b/build/qapi/qapi-visit-acpi.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-acpi.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-audio.c b/build/qapi/qapi-visit-audio.c
index a4dd2f16668..064358b66ea 100644
--- a/build/qapi/qapi-visit-audio.c
+++ b/build/qapi/qapi-visit-audio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-audio.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-authz.c b/build/qapi/qapi-visit-authz.c
index de493708650..a858ef9aebf 100644
--- a/build/qapi/qapi-visit-authz.c
+++ b/build/qapi/qapi-visit-authz.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-authz.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-block-core.c b/build/qapi/qapi-visit-block-core.c
index 453e6e4a789..dbcfe09d7ff 100644
--- a/build/qapi/qapi-visit-block-core.c
+++ b/build/qapi/qapi-visit-block-core.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-block-core.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-block-export.c b/build/qapi/qapi-visit-block-export.c
index b746271f479..61fe484132f 100644
--- a/build/qapi/qapi-visit-block-export.c
+++ b/build/qapi/qapi-visit-block-export.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-block-export.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-block.c b/build/qapi/qapi-visit-block.c
index 37819714e5a..138aff1c32c 100644
--- a/build/qapi/qapi-visit-block.c
+++ b/build/qapi/qapi-visit-block.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-block.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-char.c b/build/qapi/qapi-visit-char.c
index c41648bf194..43aa49b3418 100644
--- a/build/qapi/qapi-visit-char.c
+++ b/build/qapi/qapi-visit-char.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-char.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-common.c b/build/qapi/qapi-visit-common.c
index 37688ec8429..18f09d3b846 100644
--- a/build/qapi/qapi-visit-common.c
+++ b/build/qapi/qapi-visit-common.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-common.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-compat.c b/build/qapi/qapi-visit-compat.c
index fdd47d422dd..858b15a9c1c 100644
--- a/build/qapi/qapi-visit-compat.c
+++ b/build/qapi/qapi-visit-compat.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-compat.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-control.c b/build/qapi/qapi-visit-control.c
index 5b298514772..4aff918cd39 100644
--- a/build/qapi/qapi-visit-control.c
+++ b/build/qapi/qapi-visit-control.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-control.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-crypto.c b/build/qapi/qapi-visit-crypto.c
index b0a98a0e8dc..5b61877593b 100644
--- a/build/qapi/qapi-visit-crypto.c
+++ b/build/qapi/qapi-visit-crypto.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-crypto.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-cryptodev.c b/build/qapi/qapi-visit-cryptodev.c
index efe60bcad23..c5dd74c6a94 100644
--- a/build/qapi/qapi-visit-cryptodev.c
+++ b/build/qapi/qapi-visit-cryptodev.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-cryptodev.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-cxl.c b/build/qapi/qapi-visit-cxl.c
index 9391f1cdc3e..e89a642e2cb 100644
--- a/build/qapi/qapi-visit-cxl.c
+++ b/build/qapi/qapi-visit-cxl.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-cxl.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-dump.c b/build/qapi/qapi-visit-dump.c
index 80aa6d900d4..858f6e670b6 100644
--- a/build/qapi/qapi-visit-dump.c
+++ b/build/qapi/qapi-visit-dump.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-dump.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-ebpf.c b/build/qapi/qapi-visit-ebpf.c
index 991643ed8c6..79a4983c933 100644
--- a/build/qapi/qapi-visit-ebpf.c
+++ b/build/qapi/qapi-visit-ebpf.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-ebpf.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-error.c b/build/qapi/qapi-visit-error.c
index 0df6770fa00..c9948d60448 100644
--- a/build/qapi/qapi-visit-error.c
+++ b/build/qapi/qapi-visit-error.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-error.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-introspect.c b/build/qapi/qapi-visit-introspect.c
index 7fe3350e91a..7b701b04bc0 100644
--- a/build/qapi/qapi-visit-introspect.c
+++ b/build/qapi/qapi-visit-introspect.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-introspect.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-job.c b/build/qapi/qapi-visit-job.c
index 22a14dc97ab..f8b6b59214c 100644
--- a/build/qapi/qapi-visit-job.c
+++ b/build/qapi/qapi-visit-job.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-job.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-machine-common.c b/build/qapi/qapi-visit-machine-common.c
index 3fd491682b0..b35a4df40da 100644
--- a/build/qapi/qapi-visit-machine-common.c
+++ b/build/qapi/qapi-visit-machine-common.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-machine-common.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-machine-target.c b/build/qapi/qapi-visit-machine-target.c
index e0b86544820..548c57958d6 100644
--- a/build/qapi/qapi-visit-machine-target.c
+++ b/build/qapi/qapi-visit-machine-target.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-machine-target.h"
 #include "qapi-features.h"
@@ -75,7 +76,6 @@ bool visit_type_CpuModelCompareResult(Visitor *v, const char *name,
     return ok;
 }
 
-#if defined(TARGET_S390X)
 bool visit_type_CpuModelBaselineInfo_members(Visitor *v, CpuModelBaselineInfo *obj, Error **errp)
 {
     if (!visit_type_CpuModelInfo(v, "model", &obj->model, errp)) {
@@ -110,9 +110,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_CpuModelCompareInfo_members(Visitor *v, CpuModelCompareInfo *obj, Error **errp)
 {
     if (!visit_type_CpuModelCompareResult(v, "result", &obj->result, errp)) {
@@ -150,9 +148,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_q_obj_query_cpu_model_comparison_arg_members(Visitor *v, q_obj_query_cpu_model_comparison_arg *obj, Error **errp)
 {
     if (!visit_type_CpuModelInfo(v, "modela", &obj->modela, errp)) {
@@ -163,9 +159,7 @@ bool visit_type_q_obj_query_cpu_model_comparison_arg_members(Visitor *v, q_obj_q
     }
     return true;
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X)
 bool visit_type_q_obj_query_cpu_model_baseline_arg_members(Visitor *v, q_obj_query_cpu_model_baseline_arg *obj, Error **errp)
 {
     if (!visit_type_CpuModelInfo(v, "modela", &obj->modela, errp)) {
@@ -176,19 +170,17 @@ bool visit_type_q_obj_query_cpu_model_baseline_arg_members(Visitor *v, q_obj_que
     }
     return true;
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuModelExpansionInfo_members(Visitor *v, CpuModelExpansionInfo *obj, Error **errp)
 {
     if (!visit_type_CpuModelInfo(v, "model", &obj->model, errp)) {
         return false;
     }
-#if defined(TARGET_S390X)
+if (target_s390x()) {
     if (!visit_type_strList(v, "deprecated-props", &obj->deprecated_props, errp)) {
         return false;
     }
-#endif /* defined(TARGET_S390X) */
+} /* (target_s390x()) */
     return true;
 }
 
@@ -218,9 +210,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_q_obj_query_cpu_model_expansion_arg_members(Visitor *v, q_obj_query_cpu_model_expansion_arg *obj, Error **errp)
 {
     if (!visit_type_CpuModelExpansionType(v, "type", &obj->type, errp)) {
@@ -231,9 +221,7 @@ bool visit_type_q_obj_query_cpu_model_expansion_arg_members(Visitor *v, q_obj_qu
     }
     return true;
 }
-#endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuDefinitionInfo_members(Visitor *v, CpuDefinitionInfo *obj, Error **errp)
 {
     bool has_alias_of = !!obj->alias_of;
@@ -294,9 +282,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
 bool visit_type_CpuDefinitionInfoList(Visitor *v, const char *name,
                  CpuDefinitionInfoList **obj, Error **errp)
 {
@@ -324,9 +310,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_PPC) || defined(TARGET_ARM) || defined(TARGET_I386) || defined(TARGET_S390X) || defined(TARGET_MIPS) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */
 
-#if defined(TARGET_S390X)
 bool visit_type_S390CpuPolarization(Visitor *v, const char *name,
                  S390CpuPolarization *obj, Error **errp)
 {
@@ -335,9 +319,7 @@ bool visit_type_S390CpuPolarization(Visitor *v, const char *name,
     *obj = value;
     return ok;
 }
-#endif /* defined(TARGET_S390X) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_q_obj_set_cpu_topology_arg_members(Visitor *v, q_obj_set_cpu_topology_arg *obj, Error **errp)
 {
     if (!visit_type_uint16(v, "core-id", &obj->core_id, errp)) {
@@ -370,9 +352,7 @@ bool visit_type_q_obj_set_cpu_topology_arg_members(Visitor *v, q_obj_set_cpu_top
     }
     return true;
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_q_obj_CPU_POLARIZATION_CHANGE_arg_members(Visitor *v, q_obj_CPU_POLARIZATION_CHANGE_arg *obj, Error **errp)
 {
     if (!visit_type_S390CpuPolarization(v, "polarization", &obj->polarization, errp)) {
@@ -380,9 +360,7 @@ bool visit_type_q_obj_CPU_POLARIZATION_CHANGE_arg_members(Visitor *v, q_obj_CPU_
     }
     return true;
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
-#if defined(TARGET_S390X) && defined(CONFIG_KVM)
 bool visit_type_CpuPolarizationInfo_members(Visitor *v, CpuPolarizationInfo *obj, Error **errp)
 {
     if (!visit_type_S390CpuPolarization(v, "polarization", &obj->polarization, errp)) {
@@ -417,7 +395,6 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_S390X) && defined(CONFIG_KVM) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_visit_machine_target_c;
diff --git a/build/qapi/qapi-visit-machine.c b/build/qapi/qapi-visit-machine.c
index 4c70e99c9d1..60be8b9a1ec 100644
--- a/build/qapi/qapi-visit-machine.c
+++ b/build/qapi/qapi-visit-machine.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-machine.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-migration.c b/build/qapi/qapi-visit-migration.c
index a03b6551667..403104cc48b 100644
--- a/build/qapi/qapi-visit-migration.c
+++ b/build/qapi/qapi-visit-migration.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-migration.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-misc-target.c b/build/qapi/qapi-visit-misc-target.c
index e7b895a8e6d..395de1faa05 100644
--- a/build/qapi/qapi-visit-misc-target.c
+++ b/build/qapi/qapi-visit-misc-target.c
@@ -11,11 +11,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-misc-target.h"
 #include "qapi-features.h"
 
-#if defined(TARGET_I386)
 bool visit_type_SevState(Visitor *v, const char *name,
                  SevState *obj, Error **errp)
 {
@@ -24,9 +24,7 @@ bool visit_type_SevState(Visitor *v, const char *name,
     *obj = value;
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevGuestType(Visitor *v, const char *name,
                  SevGuestType *obj, Error **errp)
 {
@@ -35,9 +33,7 @@ bool visit_type_SevGuestType(Visitor *v, const char *name,
     *obj = value;
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevGuestInfo_members(Visitor *v, SevGuestInfo *obj, Error **errp)
 {
     if (!visit_type_uint32(v, "policy", &obj->policy, errp)) {
@@ -75,9 +71,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevSnpGuestInfo_members(Visitor *v, SevSnpGuestInfo *obj, Error **errp)
 {
     if (!visit_type_uint64(v, "snp-policy", &obj->snp_policy, errp)) {
@@ -112,9 +106,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_SevInfo_base_members(Visitor *v, q_obj_SevInfo_base *obj, Error **errp)
 {
     if (!visit_type_bool(v, "enabled", &obj->enabled, errp)) {
@@ -137,9 +129,7 @@ bool visit_type_q_obj_SevInfo_base_members(Visitor *v, q_obj_SevInfo_base *obj,
     }
     return true;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevInfo_members(Visitor *v, SevInfo *obj, Error **errp)
 {
     if (!visit_type_q_obj_SevInfo_base_members(v, (q_obj_SevInfo_base *)obj, errp)) {
@@ -182,9 +172,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevLaunchMeasureInfo_members(Visitor *v, SevLaunchMeasureInfo *obj, Error **errp)
 {
     if (!visit_type_str(v, "data", &obj->data, errp)) {
@@ -219,9 +207,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevCapability_members(Visitor *v, SevCapability *obj, Error **errp)
 {
     if (!visit_type_str(v, "pdh", &obj->pdh, errp)) {
@@ -268,9 +254,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_sev_inject_launch_secret_arg_members(Visitor *v, q_obj_sev_inject_launch_secret_arg *obj, Error **errp)
 {
     if (!visit_type_str(v, "packet-header", &obj->packet_header, errp)) {
@@ -286,9 +270,7 @@ bool visit_type_q_obj_sev_inject_launch_secret_arg_members(Visitor *v, q_obj_sev
     }
     return true;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_SevAttestationReport_members(Visitor *v, SevAttestationReport *obj, Error **errp)
 {
     if (!visit_type_str(v, "data", &obj->data, errp)) {
@@ -323,9 +305,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_query_sev_attestation_report_arg_members(Visitor *v, q_obj_query_sev_attestation_report_arg *obj, Error **errp)
 {
     if (!visit_type_str(v, "mnonce", &obj->mnonce, errp)) {
@@ -333,9 +313,7 @@ bool visit_type_q_obj_query_sev_attestation_report_arg_members(Visitor *v, q_obj
     }
     return true;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_ARM)
 bool visit_type_GICCapability_members(Visitor *v, GICCapability *obj, Error **errp)
 {
     if (!visit_type_int(v, "version", &obj->version, errp)) {
@@ -376,9 +354,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_ARM) */
 
-#if defined(TARGET_ARM)
 bool visit_type_GICCapabilityList(Visitor *v, const char *name,
                  GICCapabilityList **obj, Error **errp)
 {
@@ -406,7 +382,6 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_ARM) */
 
 bool visit_type_SGXEPCSection_members(Visitor *v, SGXEPCSection *obj, Error **errp)
 {
@@ -474,7 +449,6 @@ out_obj:
     return ok;
 }
 
-#if defined(TARGET_I386)
 bool visit_type_SGXInfo_members(Visitor *v, SGXInfo *obj, Error **errp)
 {
     if (!visit_type_bool(v, "sgx", &obj->sgx, errp)) {
@@ -521,9 +495,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnPortType(Visitor *v, const char *name,
                  EvtchnPortType *obj, Error **errp)
 {
@@ -532,9 +504,7 @@ bool visit_type_EvtchnPortType(Visitor *v, const char *name,
     *obj = value;
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnInfo_members(Visitor *v, EvtchnInfo *obj, Error **errp)
 {
     if (!visit_type_uint16(v, "port", &obj->port, errp)) {
@@ -587,9 +557,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_EvtchnInfoList(Visitor *v, const char *name,
                  EvtchnInfoList **obj, Error **errp)
 {
@@ -617,9 +585,7 @@ out_obj:
     }
     return ok;
 }
-#endif /* defined(TARGET_I386) */
 
-#if defined(TARGET_I386)
 bool visit_type_q_obj_xen_event_inject_arg_members(Visitor *v, q_obj_xen_event_inject_arg *obj, Error **errp)
 {
     if (!visit_type_uint32(v, "port", &obj->port, errp)) {
@@ -627,7 +593,6 @@ bool visit_type_q_obj_xen_event_inject_arg_members(Visitor *v, q_obj_xen_event_i
     }
     return true;
 }
-#endif /* defined(TARGET_I386) */
 
 /* Dummy declaration to prevent empty .o file */
 char qapi_dummy_qapi_visit_misc_target_c;
diff --git a/build/qapi/qapi-visit-misc.c b/build/qapi/qapi-visit-misc.c
index 09b14915147..f1b7344a8cf 100644
--- a/build/qapi/qapi-visit-misc.c
+++ b/build/qapi/qapi-visit-misc.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-misc.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-net.c b/build/qapi/qapi-visit-net.c
index dfa997909b9..ed46cb8f46e 100644
--- a/build/qapi/qapi-visit-net.c
+++ b/build/qapi/qapi-visit-net.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-net.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-pci.c b/build/qapi/qapi-visit-pci.c
index 9b25a684b8c..371f750858e 100644
--- a/build/qapi/qapi-visit-pci.c
+++ b/build/qapi/qapi-visit-pci.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-pci.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-pragma.c b/build/qapi/qapi-visit-pragma.c
index 9e88b232d6f..12e616f946e 100644
--- a/build/qapi/qapi-visit-pragma.c
+++ b/build/qapi/qapi-visit-pragma.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-pragma.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-qdev.c b/build/qapi/qapi-visit-qdev.c
index 5b456eceed8..391dfd00b3d 100644
--- a/build/qapi/qapi-visit-qdev.c
+++ b/build/qapi/qapi-visit-qdev.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-qdev.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-qom.c b/build/qapi/qapi-visit-qom.c
index 9b9b595c061..591763a9ab7 100644
--- a/build/qapi/qapi-visit-qom.c
+++ b/build/qapi/qapi-visit-qom.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-qom.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-replay.c b/build/qapi/qapi-visit-replay.c
index da6de7e30a9..78913d5d3ed 100644
--- a/build/qapi/qapi-visit-replay.c
+++ b/build/qapi/qapi-visit-replay.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-replay.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-rocker.c b/build/qapi/qapi-visit-rocker.c
index bccef3f1d57..30cfe22f221 100644
--- a/build/qapi/qapi-visit-rocker.c
+++ b/build/qapi/qapi-visit-rocker.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-rocker.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-run-state.c b/build/qapi/qapi-visit-run-state.c
index 22569fb84dc..0c6578c35dc 100644
--- a/build/qapi/qapi-visit-run-state.c
+++ b/build/qapi/qapi-visit-run-state.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-run-state.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-sockets.c b/build/qapi/qapi-visit-sockets.c
index 90e339f3615..c3aad4b24a3 100644
--- a/build/qapi/qapi-visit-sockets.c
+++ b/build/qapi/qapi-visit-sockets.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-sockets.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-stats.c b/build/qapi/qapi-visit-stats.c
index 3722c2ca43d..fa8b36df0da 100644
--- a/build/qapi/qapi-visit-stats.c
+++ b/build/qapi/qapi-visit-stats.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-stats.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-tpm.c b/build/qapi/qapi-visit-tpm.c
index 209f71c461c..89f81e374cc 100644
--- a/build/qapi/qapi-visit-tpm.c
+++ b/build/qapi/qapi-visit-tpm.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-tpm.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-trace.c b/build/qapi/qapi-visit-trace.c
index 393af1ed7e7..0e158ed4bad 100644
--- a/build/qapi/qapi-visit-trace.c
+++ b/build/qapi/qapi-visit-trace.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-trace.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-transaction.c b/build/qapi/qapi-visit-transaction.c
index 04ca76ff8d7..32b2e720bcd 100644
--- a/build/qapi/qapi-visit-transaction.c
+++ b/build/qapi/qapi-visit-transaction.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-transaction.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-uefi.c b/build/qapi/qapi-visit-uefi.c
index 7743183b045..b2869b58ed4 100644
--- a/build/qapi/qapi-visit-uefi.c
+++ b/build/qapi/qapi-visit-uefi.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-uefi.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-ui.c b/build/qapi/qapi-visit-ui.c
index 88cadba2644..170428b2919 100644
--- a/build/qapi/qapi-visit-ui.c
+++ b/build/qapi/qapi-visit-ui.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-ui.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-vfio.c b/build/qapi/qapi-visit-vfio.c
index 41a05e57c7b..12c4116e0cf 100644
--- a/build/qapi/qapi-visit-vfio.c
+++ b/build/qapi/qapi-visit-vfio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-vfio.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-virtio.c b/build/qapi/qapi-visit-virtio.c
index 0b3b314f0e3..ed83afd1b76 100644
--- a/build/qapi/qapi-visit-virtio.c
+++ b/build/qapi/qapi-visit-virtio.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-virtio.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit-yank.c b/build/qapi/qapi-visit-yank.c
index 547c94de5ff..4b0d3864a3c 100644
--- a/build/qapi/qapi-visit-yank.c
+++ b/build/qapi/qapi-visit-yank.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit-yank.h"
 #include "qapi-features.h"
diff --git a/build/qapi/qapi-visit.c b/build/qapi/qapi-visit.c
index 4fbbc419ea4..69438643a42 100644
--- a/build/qapi/qapi-visit.c
+++ b/build/qapi/qapi-visit.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi-visit.h"
 #include "qapi-features.h"
-- 
2.47.2


