Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F663C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 16:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD3uh-00089p-WC; Thu, 08 May 2025 12:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3ue-00089a-P5
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD3ud-0007by-62
 for qemu-devel@nongnu.org; Thu, 08 May 2025 12:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746720954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N3cKX666Bi8FN5j4sXz69W+1rVvNDKX62XzUMC75xX0=;
 b=S4zQcQnmU48mig25NFBoaTMl2MkRihTv4sjWgxWfTHdllzWwKG/j776hwmPYJStML6qPVQ
 HJ7MrT3g7BpM4LXmYQWEklyME4A2zkB6RNhSP0Adl+zvTl1TLqUv9zFSo5gAInBGisNfUX
 QL4JVB6PJBEep/BPAlEhnUMnkdW8/8I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-Ds6sSIvAPnu47t7Lc-zc-A-1; Thu,
 08 May 2025 12:15:50 -0400
X-MC-Unique: Ds6sSIvAPnu47t7Lc-zc-A-1
X-Mimecast-MFC-AGG-ID: Ds6sSIvAPnu47t7Lc-zc-A_1746720948
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41828180045C; Thu,  8 May 2025 16:15:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 53477180049D; Thu,  8 May 2025 16:15:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, devel@lists.libvirt.org,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/6] tests/qtest/q35-test: Remove the obsolete
 test_without_smram_base test
Date: Thu,  8 May 2025 17:15:31 +0100
Message-ID: <20250508161536.865866-2-berrange@redhat.com>
In-Reply-To: <20250508161536.865866-1-berrange@redhat.com>
References: <20250508161536.865866-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

With the release of QEMU 10.1, the pc-q35-4.1 machine will be older
than 6 years and thus will get disabled automatically by the
MACHINE_VER_DELETION() macro. Remove the related test to avoid
that the q35-test is failing when the machine is not available anymore.

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/q35-test.c | 37 +------------------------------------
 1 file changed, 1 insertion(+), 36 deletions(-)

diff --git a/tests/qtest/q35-test.c b/tests/qtest/q35-test.c
index 75d4078b79..62fff49fc8 100644
--- a/tests/qtest/q35-test.c
+++ b/tests/qtest/q35-test.c
@@ -246,41 +246,6 @@ static void test_smram_smbase_lock(void)
     qtest_quit(qts);
 }
 
-static void test_without_smram_base(void)
-{
-    QPCIBus *pcibus;
-    QPCIDevice *pcidev;
-    QTestState *qts;
-    int i;
-
-    qts = qtest_init("-M pc-q35-4.1");
-
-    pcibus = qpci_new_pc(qts, NULL);
-    g_assert(pcibus != NULL);
-
-    pcidev = qpci_device_find(pcibus, 0);
-    g_assert(pcidev != NULL);
-
-    /* check that RAM is accessible */
-    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN);
-    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, SMRAM_TEST_PATTERN);
-
-    /* check that writing to 0x9c succeeds */
-    for (i = 0; i <= 0xff; i++) {
-        qpci_config_writeb(pcidev, MCH_HOST_BRIDGE_F_SMBASE, i);
-        g_assert(qpci_config_readb(pcidev, MCH_HOST_BRIDGE_F_SMBASE) == i);
-    }
-
-    /* check that RAM is still accessible */
-    qtest_writeb(qts, SMBASE, SMRAM_TEST_PATTERN + 1);
-    g_assert_cmpint(qtest_readb(qts, SMBASE), ==, (SMRAM_TEST_PATTERN + 1));
-
-    g_free(pcidev);
-    qpci_free_pc(pcibus);
-
-    qtest_quit(qts);
-}
-
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -293,6 +258,6 @@ int main(int argc, char **argv)
     qtest_add_data_func("/q35/tseg-size/ext/16mb", &tseg_ext_16mb,
                         test_tseg_size);
     qtest_add_func("/q35/smram/smbase_lock", test_smram_smbase_lock);
-    qtest_add_func("/q35/smram/legacy_smbase", test_without_smram_base);
+
     return g_test_run();
 }
-- 
2.49.0


