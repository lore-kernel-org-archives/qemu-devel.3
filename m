Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E765ECE587
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkk1-0000Qu-9v; Mon, 09 Sep 2024 16:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjz-0000Jp-KW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkjx-00052K-J8
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNelb35Lz3HQub41/Z2JM0wVsojlW9d18+WONVrmQ+4=;
 b=Z7MgcqV+oltulFj63pYECY8mYLxvKOiJ97bdObmBuvw2kiH1QBXrwj2Wq2LggJEX3F/mOS
 vX9TMNbINKon9dzL9z1OeFThVldZH3Yya+32REKepw7lZmjSfDIWmKKbnNDSOCF+YyMCHP
 f2coAnkmrjXvt/bnq4APDF8POnDMHrM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-IgE0wJ-0M6SsM6MVj1vShg-1; Mon, 09 Sep 2024 16:11:59 -0400
X-MC-Unique: IgE0wJ-0M6SsM6MVj1vShg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-457cde3fd7bso60821cf.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:11:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912718; x=1726517518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HNelb35Lz3HQub41/Z2JM0wVsojlW9d18+WONVrmQ+4=;
 b=U4FGHxlrfMJnaletVdr/qc0f1YSkkbdQmGAS24hqCL8PnNOsfytgFpSBQeoO010jUJ
 VXsnD/rWVun71H0wkaQPGzOpzS8SMVQchQXlYNo0En2MY/SZrGiYakp4eGcL2ko+LC/E
 AIcwLctDAka3wwvDzDyWNJMXgYXmJcLufysDqmzlEHlQo7iEA4IwyYkFginVexajvpbp
 uc+XHx0Vr9FMqOe0EMTgcWSxw7w151jLd1hl+wG3551/8otqfEg0AzcfffP0skuF5QhY
 9JfRwICyKx9u8ohI9icz+XUfkcR07/UUOKORMoP+fBVi4c++CFhDlvbow+SKmjR3c3Aq
 ltDg==
X-Gm-Message-State: AOJu0YxW7FsYJ2GZcNJkENOVn5oBuv6853RZv26yp25D6bi2imR0depp
 Wf1ZK2O3E9v0yqAieWUWt3KE1zCvgnXl1iIvjH9P/6xdDNMzyqwpzC4aVoeEBNLA+0W7XB6qjac
 fKnCn3NPZSuyymo5ay7WYxTu6ry3B1B+MAEAW/brHm7dqmc7pwWfQVO8qjoJcPDcsllValIoQLw
 438cTt8iIBChMmTKG1CNELsC5/KKj0I93mIA==
X-Received: by 2002:ac8:584e:0:b0:456:45c6:2c30 with SMTP id
 d75a77b69052e-4581f6f6a7bmr100772871cf.53.1725912718098; 
 Mon, 09 Sep 2024 13:11:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOrEkLSxXtaOjmBMWOBgp2bxdh3qkgdOu9VnHMg5IuBwaisJ/KzDkcXGGe+iHlMRl/IVwKUQ==
X-Received: by 2002:ac8:584e:0:b0:456:45c6:2c30 with SMTP id
 d75a77b69052e-4581f6f6a7bmr100772261cf.53.1725912717448; 
 Mon, 09 Sep 2024 13:11:57 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f93978sm22838561cf.83.2024.09.09.13.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:11:56 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Yuan Liu <yuan1.liu@intel.com>,
 Nanhai Zou <nanhai.zou@intel.com>, Yichen Wang <yichen.wang@bytedance.com>
Subject: [PULL 4/9] docs/migration: add qatzip compression feature
Date: Mon,  9 Sep 2024 16:11:42 -0400
Message-ID: <20240909201147.3761639-5-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240909201147.3761639-1-peterx@redhat.com>
References: <20240909201147.3761639-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Yuan Liu <yuan1.liu@intel.com>

add Intel QATzip compression method introduction

Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
Link: https://lore.kernel.org/r/20240830232722.58272-2-yichen.wang@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/features.rst           |   1 +
 docs/devel/migration/qatzip-compression.rst | 165 ++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 docs/devel/migration/qatzip-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index 58f8fd9e16..8f431d52f9 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -14,3 +14,4 @@ Migration has plenty of features to support different use cases.
    CPR
    qpl-compression
    uadk-compression
+   qatzip-compression
diff --git a/docs/devel/migration/qatzip-compression.rst b/docs/devel/migration/qatzip-compression.rst
new file mode 100644
index 0000000000..862b383164
--- /dev/null
+++ b/docs/devel/migration/qatzip-compression.rst
@@ -0,0 +1,165 @@
+==================
+QATzip Compression
+==================
+In scenarios with limited network bandwidth, the ``QATzip`` solution can help
+users save a lot of host CPU resources by accelerating compression and
+decompression through the Intel QuickAssist Technology(``QAT``) hardware.
+
+
+The following test was conducted using 8 multifd channels and 10Gbps network
+bandwidth. The results show that, compared to zstd, ``QATzip`` significantly
+saves CPU resources on the sender and reduces migration time. Compared to the
+uncompressed solution, ``QATzip`` greatly improves the dirty page processing
+capability, indicated by the Pages per Second metric, and also reduces the
+total migration time.
+
+::
+
+   VM Configuration: 16 vCPU and 64G memory
+   VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
+   QAT Devices: 4
+   |-----------|--------|---------|----------|----------|------|------|
+   |8 Channels |Total   |down     |throughput|pages per | send | recv |
+   |           |time(ms)|time(ms) |(mbps)    |second    | cpu %| cpu% |
+   |-----------|--------|---------|----------|----------|------|------|
+   |qatzip     |   16630|       28|     10467|   2940235|   160|   360|
+   |-----------|--------|---------|----------|----------|------|------|
+   |zstd       |   20165|       24|      8579|   2391465|   810|   340|
+   |-----------|--------|---------|----------|----------|------|------|
+   |none       |   46063|       40|     10848|    330240|    45|    85|
+   |-----------|--------|---------|----------|----------|------|------|
+
+
+QATzip Compression Framework
+============================
+
+``QATzip`` is a user space library which builds on top of the Intel QuickAssist
+Technology to provide extended accelerated compression and decompression
+services.
+
+For more ``QATzip`` introduction, please refer to `QATzip Introduction
+<https://github.com/intel/QATzip?tab=readme-ov-file#introductionl>`_
+
+::
+
+  +----------------+
+  | MultiFd Thread |
+  +-------+--------+
+          |
+          | compress/decompress
+  +-------+--------+
+  | QATzip library |
+  +-------+--------+
+          |
+  +-------+--------+
+  |  QAT library   |
+  +-------+--------+
+          |         user space
+  --------+---------------------
+          |         kernel space
+   +------+-------+
+   |  QAT  Driver |
+   +------+-------+
+          |
+   +------+-------+
+   | QAT Devices  |
+   +--------------+
+
+
+QATzip Installation
+-------------------
+
+The ``QATzip`` installation package has been integrated into some Linux
+distributions and can be installed directly. For example, the Ubuntu Server
+24.04 LTS system can be installed using below command
+
+.. code-block:: shell
+
+   #apt search qatzip
+   libqatzip-dev/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library development files
+
+   libqatzip3/noble 1.2.0-0ubuntu3 amd64
+     Intel QuickAssist user space library
+
+   qatzip/noble,now 1.2.0-0ubuntu3 amd64 [installed]
+     Compression user-space tool for Intel QuickAssist Technology
+
+   #sudo apt install libqatzip-dev libqatzip3 qatzip
+
+If your system does not support the ``QATzip`` installation package, you can
+use the source code to build and install, please refer to `QATzip source code installation
+<https://github.com/intel/QATzip?tab=readme-ov-file#build-intel-quickassist-technology-driver>`_
+
+QAT Hardware Deployment
+-----------------------
+
+``QAT`` supports physical functions(PFs) and virtual functions(VFs) for
+deployment, and users can configure ``QAT`` resources for migration according
+to actual needs. For more details about ``QAT`` deployment, please refer to
+`Intel QuickAssist Technology Documentation
+<https://intel.github.io/quickassist/index.html>`_
+
+For more ``QAT`` hardware introduction, please refer to `intel-quick-assist-technology-overview
+<https://www.intel.com/content/www/us/en/architecture-and-technology/intel-quick-assist-technology-overview.html>`_
+
+How To Use QATzip Compression
+=============================
+
+1 - Install ``QATzip`` library
+
+2 - Build ``QEMU`` with ``--enable-qatzip`` parameter
+
+  E.g. configure --target-list=x86_64-softmmu --enable-kvm ``--enable-qatzip``
+
+3 - Set ``migrate_set_parameter multifd-compression qatzip``
+
+4 - Set ``migrate_set_parameter multifd-qatzip-level comp_level``, the default
+comp_level value is 1, and it supports levels from 1 to 9
+
+QAT Memory Requirements
+=======================
+
+The user needs to reserve system memory for the QAT memory management to
+allocate DMA memory. The size of the reserved system memory depends on the
+number of devices used for migration and the number of multifd channels.
+
+Because memory usage depends on QAT configuration, please refer to `QAT Memory
+Driver Queries
+<https://intel.github.io/quickassist/PG/infrastructure_debugability.html?highlight=memory>`_
+for memory usage calculation.
+
+.. list-table:: An example of a PF used for migration
+  :header-rows: 1
+
+  * - Number of channels
+    - Sender memory usage
+    - Receiver memory usage
+  * - 2
+    - 10M
+    - 10M
+  * - 4
+    - 12M
+    - 14M
+  * - 8
+    - 16M
+    - 20M
+
+How To Choose Between QATzip and QPL
+====================================
+Starting from 4th Gen Intel Xeon Scalable processors, codenamed Sapphire Rapids
+processor(``SPR``), multiple built-in accelerators are supported including
+``QAT`` and ``IAA``.  The former can accelerate ``QATzip`` and the latter is
+used to accelerate ``QPL``.
+
+Here are some suggestions:
+
+1 - If the live migration scenario is limited by network bandwidth and ``QAT``
+hardware resources exceed ``IAA``, use the ``QATzip`` method, which can save a
+lot of host CPU resources for compression.
+
+2 - If the system cannot support shared virtual memory (SVM) technology, use
+the ``QATzip`` method because ``QPL`` performance is not good without SVM
+support.
+
+3 - For other scenarios, use the ``QPL`` method first.
-- 
2.45.0


