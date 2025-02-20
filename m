Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78111C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 09:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl33H-0007as-Sc; Thu, 20 Feb 2025 04:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tl33F-0007aN-AH
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:41:01 -0500
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tl33C-0005mQ-VL
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 04:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740044458; x=1771580458;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=0vXW6UBG0ovTGsI+UH2E/W+XqDrBbz4Zdl+n48YdpxQ=;
 b=k8+DUe9Yt9zFbrNvdru5j/MFwpOyLPWz945Yr2Td5crHaMx4Hxt49OXY
 KmqSeyjh4Iw2yCofU4+Wftp2NJxw9ufNwP/dCckWk9MuHavmmkPIFhXms
 7NbEFzTcuCMz0Ep4fcnS9H0x2jcSZx+5JN5k0r19ox+xlxEAFBfQFL3Fk
 mDdXvgEbxMt5c/XuopJ35vxss3P1ScIr8AVu/TT7n9ldx/qy1cME1zPsJ
 G/r2m08la+pAvXZNocL6OxbwxWhTx9FYHWSm3ivdWtIws9+OlHilACoCs
 7vplk5GRMCnwyYQe+DTqMfmE8ztyt3P3ZL+X9jhc84cE8StsWvLuuOVsA A==;
X-CSE-ConnectionGUID: BZGVYLfoQC++om61PuE3oA==
X-CSE-MsgGUID: KSaQ9TYHR8CUFo+PNPXU6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="178645793"
X-IronPort-AV: E=Sophos;i="6.13,301,1732546800"; d="scan'208";a="178645793"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2025 18:40:51 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com
 [192.168.87.60])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 1D719C226C
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 18:40:49 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id CE3AED5619
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 18:40:48 +0900 (JST)
Received: from FNSTPC.g08.fujitsu.local (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0E3DB1A0003;
 Thu, 20 Feb 2025 17:40:47 +0800 (CST)
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] [NOT-FOR-MERGE] Add qtest for migration over RDMA
Date: Thu, 20 Feb 2025 17:40:38 +0800
Message-ID: <20250220094038.1382541-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <Z7Xmkq0nTmZ8TRXU@x1.local>
References: <Z7Xmkq0nTmZ8TRXU@x1.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 19/02/2025 22:11, Peter Xu wrote:
>>>>> then
>>>>> in the test it tries to detect rdma link and fetch the ip only
>>>> It should work without root permission if we just*detect*  and*fetch ip*.
>>>>
>>>> Do you also mean we can split new-rdma-link.sh to 2 separate scripts
>>>> - add-rdma-link.sh # optionally, execute by user before the test (require root permission)
>>>> - detect-fetch-rdma.sh # execute from the migration-test
>>> Hmm indeed we still need a script to scan over all the ports..
>>>
>>> If having --rdma is a good idea, maybe we can further make it a parameter
>>> to --rdma?
>>>
>>>    $ migration-test --rdma $RDMA_IP
>>>
>>> Or:
>>>
>>>    $ migration-test --rdma-ip $RDMA_IP
>> I think --rdma only makes sense if it's going to do something
>> special. The optmimal scenario is that it always runs the test when it
>> can and sets up/tears down anything it needs.
>>
>> If it needs root, I'd prefer the test informs about this and does the
>> work itself.
>>
>> It would also be good to have the add + detect separate so we have more
>> flexibility, maybe we manage to enable this in CI even.
>>
>> So:
>>
>> ./add.sh
>> migration-test
>> (runs detect.sh + runs rdma test)
>> (leaves stuff behind)
>>
>> migration-test
>> (skips rdma test with message that it needs root)
>>
>> sudo migration-test
>> (runs add.sh + detect.sh + runs rdma test)
>> (cleans itself up)
>>
>> Does that make sense to you? I hope it's not too much work.
> Looks good here.  We can also keep all the rdma stuff into one file, taking
> parameters.
> 
> ./rdma-helper.sh setup
> ./rdma-helper.sh detect-ip

Hi Peter and Fabiano

Many thanks for your kindly idea and suggestion.
Please take another look at the changes below.
- I don't copy script to the build dir, just execute the script like misc-tests.c
- It will automatically create a new RXE if it doesn't exit when running in root

[PATCH] migration: Add qtest for migration over RDMA

This qtest requires there is RDMA(RoCE) link in the host.
Introduce a scripts/rdma-migration-helper.sh to
- setup a new RXE if it's root
- detect existing RoCE link
to make the qtest work smoothly.

Test will be skip if there is no available RoCE link.
 # Start of rdma tests
 # Running /x86_64/migration/precopy/rdma/plain
 ok 1 /x86_64/migration/precopy/rdma/plain # SKIP There is no available rdma link in the host.
 Maybe you are not running with the root permission
 # End of rdma tests

Admin is able to remove the RXE by passing 'cleanup' to this script.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/rdma-migration-helper.sh      | 40 +++++++++++++++++++
 tests/qtest/migration/precopy-tests.c | 57 +++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100755 scripts/rdma-migration-helper.sh

diff --git a/scripts/rdma-migration-helper.sh b/scripts/rdma-migration-helper.sh
new file mode 100755
index 0000000000..4ef62baf0f
--- /dev/null
+++ b/scripts/rdma-migration-helper.sh
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+# Copied from blktests
+get_ipv4_addr() {
+    ip -4 -o addr show dev "$1" |
+        sed -n 's/.*[[:blank:]]inet[[:blank:]]*\([^[:blank:]/]*\).*/\1/p' |
+        tr -d '\n'
+}
+
+has_soft_rdma() {
+    rdma link | grep -q " netdev $1[[:blank:]]*\$"
+}
+
+rdma_rxe_setup_detect()
+{
+    (
+        cd /sys/class/net &&
+            for i in *; do
+                [ -e "$i" ] || continue
+                [ "$i" = "lo" ] && continue
+                [ "$(<"$i/addr_len")" = 6 ] || continue
+                [ "$(<"$i/carrier")" = 1 ] || continue
+
+                has_soft_rdma "$i" && break
+                [ "$operation" = "setup" ] && rdma link add "${i}_rxe" type rxe netdev "$i" && break
+            done
+        has_soft_rdma "$i" || return
+        get_ipv4_addr $i
+    )
+}
+
+operation=${1:-setup}
+
+if [ "$operation" == "setup" ] || [ "$operation" == "detect" ]; then
+    rdma_rxe_setup_detect
+elif [ "$operation" == "cleanup" ]; then
+    modprobe -r rdma_rxe
+else
+    echo "Usage: $0 [setup | cleanup | detect]"
+fi
diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index ba273d10b9..8c72eb699b 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -99,6 +99,59 @@ static void test_precopy_unix_dirty_ring(void)
     test_precopy_common(&args);
 }
 
+#ifdef CONFIG_RDMA
+
+#define RDMA_MIGRATION_HELPER "scripts/rdma-migration-helper.sh"
+static int new_rdma_link(char *buffer) {
+    const char *argument = (geteuid() == 0) ? "setup" : "detect";
+    char command[1024];
+
+    snprintf(command, sizeof(command), "%s %s", RDMA_MIGRATION_HELPER, argument);
+
+    FILE *pipe = popen(command, "r");
+    if (pipe == NULL) {
+        perror("Failed to run script");
+        return -1;
+    }
+
+    int idx = 0;
+    while (fgets(buffer + idx, 128 - idx, pipe) != NULL) {
+        idx += strlen(buffer);
+    }
+
+    int status = pclose(pipe);
+    if (status == -1) {
+        perror("Error reported by pclose()");
+        return -1;
+    } else if (WIFEXITED(status)) {
+        return WEXITSTATUS(status);
+    }
+
+    return -1;
+}
+
+static void test_precopy_rdma_plain(void)
+{
+    char buffer[128] = {};
+
+    if (new_rdma_link(buffer)) {
+        g_test_skip("There is no available rdma link in the host.\n"
+                    "Maybe you are not running with the root permission");
+        return;
+    }
+
+    /* FIXME: query a free port instead of hard code. */
+    g_autofree char *uri = g_strdup_printf("rdma:%s:7777", buffer);
+
+    MigrateCommon args = {
+        .listen_uri = uri,
+        .connect_uri = uri,
+    };
+
+    test_precopy_common(&args);
+}
+#endif
+
 static void test_precopy_tcp_plain(void)
 {
     MigrateCommon args = {
@@ -1124,6 +1177,10 @@ static void migration_test_add_precopy_smoke(MigrationTestEnv *env)
                        test_multifd_tcp_uri_none);
     migration_test_add("/migration/multifd/tcp/plain/cancel",
                        test_multifd_tcp_cancel);
+#ifdef CONFIG_RDMA
+    migration_test_add("/migration/precopy/rdma/plain",
+                       test_precopy_rdma_plain);
+#endif
 }
 
 void migration_test_add_precopy(MigrationTestEnv *env)
-- 
2.41.0


