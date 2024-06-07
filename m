Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF8FDC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFa2p-0004pG-KT; Fri, 07 Jun 2024 09:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa2o-0004ow-65
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shameerali.kolothum.thodi@huawei.com>)
 id 1sFa2l-00087a-Le
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:54:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VwjH85WDmz6H6sf;
 Fri,  7 Jun 2024 21:49:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 530ED140B55;
 Fri,  7 Jun 2024 21:54:07 +0800 (CST)
Received: from A2303104131.china.huawei.com (10.202.227.28) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 14:53:59 +0100
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>, <farosas@suse.de>
CC: <yuan1.liu@intel.com>, <pbonzini@redhat.com>, <berrange@redhat.com>,
 <marcandre.lureau@redhat.com>, <thuth@redhat.com>, <armbru@redhat.com>,
 <lvivier@redhat.com>, <linuxarm@huawei.com>, <linwenkai6@hisilicon.com>,
 <zhangfei.gao@linaro.org>, <huangchenghai2@huawei.com>
Subject: [PATCH v2 1/7] docs/migration: add uadk compression feature
Date: Fri, 7 Jun 2024 14:53:04 +0100
Message-ID: <20240607135310.46320-2-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
In-Reply-To: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
References: <20240607135310.46320-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=shameerali.kolothum.thodi@huawei.com;
 helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
From:  Shameer Kolothum via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Document UADK(User Space Accelerator Development Kit) library details
and how to use that for migration.

Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
---
 docs/devel/migration/features.rst         |   1 +
 docs/devel/migration/uadk-compression.rst | 144 ++++++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 docs/devel/migration/uadk-compression.rst

diff --git a/docs/devel/migration/features.rst b/docs/devel/migration/features.rst
index bc98b65075..58f8fd9e16 100644
--- a/docs/devel/migration/features.rst
+++ b/docs/devel/migration/features.rst
@@ -13,3 +13,4 @@ Migration has plenty of features to support different use cases.
    mapped-ram
    CPR
    qpl-compression
+   uadk-compression
diff --git a/docs/devel/migration/uadk-compression.rst b/docs/devel/migration/uadk-compression.rst
new file mode 100644
index 0000000000..988b92631e
--- /dev/null
+++ b/docs/devel/migration/uadk-compression.rst
@@ -0,0 +1,144 @@
+=========================================================
+User Space Accelerator Development Kit (UADK) Compression
+=========================================================
+UADK is a general-purpose user space accelerator framework that uses shared
+virtual addressing (SVA) to provide a unified programming interface for
+hardware acceleration of cryptographic and compression algorithms.
+
+UADK includes Unified/User-space-access-intended Accelerator Framework (UACCE),
+which enables hardware accelerators from different vendors that support SVA to
+adapt to UADK.
+
+Currently, HiSilicon Kunpeng hardware accelerators have been registered with
+UACCE. Through the UADK framework, users can run cryptographic and compression
+algorithms using hardware accelerators instead of CPUs, freeing up CPU
+computing power and improving computing performance.
+
+https://github.com/Linaro/uadk/tree/master/docs
+
+UADK Framework
+==============
+UADK consists of UACCE, vendors' drivers, and an algorithm layer. UADK requires
+the hardware accelerator to support SVA, and the operating system to support
+IOMMU and SVA. Hardware accelerators from different vendors are registered as
+different character devices with UACCE by using kernel-mode drivers of the
+vendors. A user can access the hardware accelerators by performing user-mode
+operations on the character devices.
+
+::
+
+          +----------------------------------+
+          |                apps              |
+          +----+------------------------+----+
+               |                        |
+               |                        |
+       +-------+--------+       +-------+-------+
+       |   scheduler    |       | alg libraries |
+       +-------+--------+       +-------+-------+
+               |                         |
+               |                         |
+               |                         |
+               |                +--------+------+
+               |                | vendor drivers|
+               |                +-+-------------+
+               |                  |
+               |                  |
+            +--+------------------+--+
+            |         libwd          |
+    User    +----+-------------+-----+
+    --------------------------------------------------
+    Kernel    +--+-----+   +------+
+              | uacce  |   | smmu |
+              +---+----+   +------+
+                  |
+              +---+------------------+
+              | vendor kernel driver |
+              +----------------------+
+    --------------------------------------------------
+             +----------------------+
+             |   HW Accelerators    |
+             +----------------------+
+
+UADK Installation
+-----------------
+Build UADK
+^^^^^^^^^^
+
+.. code-block:: shell
+
+    git clone https://github.com/Linaro/uadk.git
+    cd uadk
+    mkdir build
+    ./autogen.sh
+    ./configure --prefix=$PWD/build
+    make
+    make install
+
+Without --prefix, UADK will be installed to /usr/local/lib by default.
+If get error:"cannot find -lnuma", please install the libnuma-dev
+
+Run pkg-config libwd to ensure env is setup correctly
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+* export PKG_CONFIG_PATH=$PWD/build/lib/pkgconfig
+* pkg-config libwd --cflags --libs
+  -I/usr/local/include -L/usr/local/lib -lwd
+
+* export PKG_CONFIG_PATH is required on demand.
+  Not required if UADK is installed to /usr/local/lib
+
+UADK Host Kernel Requirements
+-----------------------------
+User needs to make sure that ``UACCE`` is already supported in Linux kernel.
+The kernel version should be at least v5.9 with SVA (Shared Virtual
+Addressing) enabled.
+
+Kernel Configuration
+^^^^^^^^^^^^^^^^^^^^
+
+``UACCE`` could be built as module or built-in.
+
+Here's an example to enable UACCE with hardware accelerator in HiSilicon
+Kunpeng platform.
+
+*    CONFIG_IOMMU_SVA_LIB=y
+*    CONFIG_ARM_SMMU=y
+*    CONFIG_ARM_SMMU_V3=y
+*    CONFIG_ARM_SMMU_V3_SVA=y
+*    CONFIG_PCI_PASID=y
+*    CONFIG_UACCE=y
+*    CONFIG_CRYPTO_DEV_HISI_QM=y
+*    CONFIG_CRYPTO_DEV_HISI_ZIP=y
+
+Make sure all these above kernel configurations are selected.
+
+Accelerator dev node permissions
+--------------------------------
+Harware accelerators(eg: HiSilicon Kunpeng Zip accelerator) gets registered to
+UADK and char devices are created in dev directory. In order to access resources
+on hardware accelerator devices, write permission should be provided to user.
+
+.. code-block:: shell
+
+    $ sudo chmod 777 /dev/hisi_zip-*
+
+How To Use UADK Compression In Qemu Migration
+---------------------------------------------
+* Make sure UADK is installed as above
+* Build ``Qemu`` with ``--enable-uadk`` parameter
+
+  E.g. configure --target-list=aarch64-softmmu --enable-kvm ``--enable-uadk``
+
+* Enable ``UADK`` compression during migration
+
+  Set ``migrate_set_parameter multifd-compression uadk``
+
+Since UADK uses Shared Virtual Addressing(SVA) and device access virtual memory
+directly it is possible that SMMUv3 may enounter page faults while walking the
+IO page tables. This may impact the performance. In order to mitigate this,
+please make sure to specify ``-mem-prealloc`` parameter to the destination VM
+boot parameters.
+
+Though both UADK and ZLIB are based on the deflate compression algorithm, UADK
+is not fully compatible with ZLIB. Hence, please make sure to use ``uadk`` on
+both source and destination during migration.
-- 
2.34.1


