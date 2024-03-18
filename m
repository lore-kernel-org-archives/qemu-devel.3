Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58467C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFeZ-00077g-U7; Mon, 18 Mar 2024 12:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeV-000766-6L
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmFeT-0004cd-HO
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9GIqYF1ojYqPGWd3cMEoiuZhI6Rp902S/5cqNYYeWpo=;
 b=JSCsWGNJN1FseCp4u7wfqXlusaaxqXvCqgerXdHgZjx/3eUfvYxTVfxXTWGZv82WFxJ317
 wOPi4hB96GsLDoXDQMZ22e0asL9fODgQTcVjLh6pK4PpbKVLa+DQXuSWBRGmNXFiZGlMT9
 8cTyDgew73ZDLQOSpmIGmZHlETNvAvI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-di3o6JOSORSJRzslYO9q5w-1; Mon, 18 Mar 2024 12:15:51 -0400
X-MC-Unique: di3o6JOSORSJRzslYO9q5w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-413f7a2167dso20477905e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:15:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778550; x=1711383350;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9GIqYF1ojYqPGWd3cMEoiuZhI6Rp902S/5cqNYYeWpo=;
 b=TFFZrhKOGMpLM3RtAOZJTutKkWd7O/UFf8OMvDfB2e6OdnolTovTy3H9UZ8qRksBm7
 GAe3gl6lysJ9+OsBag+Xbp3fBHcKf07bu6mWLhaL168516uQEKO4l3625PBFAPh2WhfZ
 Nn8ueXhIQKg4CfYebj0itvHIgIgzUhyEaEgAZ8fhYFJrgONUjOc53pqM2wqdG5xJBB4W
 q2e+ttolj+kZ3/OSzvhxO22760FPuXMQGH0R7TI/3so/jfQAqu2sLPixAzcw45OEgjwS
 KOTIPj7eN81zoN3V1Bx5dV2wyhLfFQjtgw67oArCtuqY9X+H8fiuuf2drgIn/B4HVXcj
 9w8w==
X-Gm-Message-State: AOJu0YxjreHySogQ4cjK35tDnFJ10h7a+/jYtVI2kXdfWq6LxwiQvaNd
 pzKSxZKTwxcmjQzOn8RTfyf7wxBnOJV5nAf/TyLpF1pYdb4Mds/gl1eDB4dFGEn9LxBadLr10qX
 yYnyZExf2Y+/2YbIG+ftt3iOXV85/N4HAi1A1B8hQiD/RcuDPQi3+qElCTkM4K+OBZ0hsu23E23
 sJHyMCkQ7ZPszvBpv/zOQx6Nlc1t3xUg==
X-Received: by 2002:a5d:648e:0:b0:33e:d5ff:a53b with SMTP id
 o14-20020a5d648e000000b0033ed5ffa53bmr8004189wri.44.1710778549799; 
 Mon, 18 Mar 2024 09:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbMII1CZWQsuEA2yEJMgdufY9vbtTEfDBvZ1wqTeZ4yH//GOhL8ZoEtcLLsgvjm37vm3COtA==
X-Received: by 2002:a5d:648e:0:b0:33e:d5ff:a53b with SMTP id
 o14-20020a5d648e000000b0033ed5ffa53bmr8004160wri.44.1710778549260; 
 Mon, 18 Mar 2024 09:15:49 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 f6-20020a5d50c6000000b0033e891d97d6sm10102807wrt.107.2024.03.18.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:15:48 -0700 (PDT)
Date: Mon, 18 Mar 2024 12:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>
Subject: [PULL 06/24] tests: smbios: add test for legacy mode CLI options
Message-ID: <579094cb995b605af07ba3ced3d0a5dc1545509c.1710778506.git.mst@redhat.com>
References: <cover.1710778506.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710778506.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Unfortunately having 2.0 machine type deprecated is not enough
to get rid of legacy SMBIOS handling since 'isapc' also uses
that and it's staying around.

Hence add test for CLI options handling to be sure that it
ain't broken during SMBIOS code refactoring.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Ani Sinha <anisinha@redhat.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240314152302.2324164-4-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c       |  17 +++++++++++++++++
 tests/data/smbios/type11_blob.legacy | Bin 0 -> 10 bytes
 2 files changed, 17 insertions(+)
 create mode 100644 tests/data/smbios/type11_blob.legacy

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a116f88e1d..d1ff4db7a2 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2106,6 +2106,21 @@ static void test_acpi_pc_smbios_blob(void)
     free_test_data(&data);
 }
 
+static void test_acpi_isapc_smbios_legacy(void)
+{
+    uint8_t req_type11[] = { 1, 11 };
+    test_data data = {
+        .machine = "isapc",
+        .variant = ".pc_smbios_legacy",
+        .required_struct_types = req_type11,
+        .required_struct_types_len = ARRAY_SIZE(req_type11),
+    };
+
+    test_smbios("-smbios file=tests/data/smbios/type11_blob.legacy "
+                "-smbios type=1,family=TEST", &data);
+    free_test_data(&data);
+}
+
 static void test_oem_fields(test_data *data)
 {
     int i;
@@ -2261,6 +2276,8 @@ int main(int argc, char *argv[])
                            test_acpi_pc_smbios_options);
             qtest_add_func("acpi/piix4/smbios-blob",
                            test_acpi_pc_smbios_blob);
+            qtest_add_func("acpi/piix4/smbios-legacy",
+                           test_acpi_isapc_smbios_legacy);
         }
         if (qtest_has_machine(MACHINE_Q35)) {
             qtest_add_func("acpi/q35", test_acpi_q35_tcg);
diff --git a/tests/data/smbios/type11_blob.legacy b/tests/data/smbios/type11_blob.legacy
new file mode 100644
index 0000000000000000000000000000000000000000..aef463aab903405958b0a85f85c5980671c08bee
GIT binary patch
literal 10
Rcmd;PW!S(N;u;*n000Tp0s;U4

literal 0
HcmV?d00001

-- 
MST


