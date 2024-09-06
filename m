Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4E8CE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWfx-0003pI-3L; Fri, 06 Sep 2024 06:58:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfY-0002uC-Bo; Fri, 06 Sep 2024 06:58:24 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfV-00064X-Hh; Fri, 06 Sep 2024 06:58:24 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2055136b612so19975805ad.0; 
 Fri, 06 Sep 2024 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725620294; x=1726225094; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gOGzTPASlo6K8l2wzpyTbqSY9P+S0/aB+DvBDSW+bJQ=;
 b=bZ1o+2jUX5ovNUdPmsBjYP/pa/FLH3inkZ9eUiijdZbXFa6kDwm6WdjvneR+tyMaaK
 jgwUs/sJ3tCUMrdjnTww0Xz9uObIlATvm/UX6kuFWrdHXDPzoVmK7BUvjcK+c9YsYqba
 M6LezQ08x2D/rlxpF3f6zu8FU0DsEst3STYANta5PP6Jd7ibZY6u5XejZDB2UfQlHU7N
 T9Vkon4SQAyxEZJSPPzLq5gUzTVw2crDzFkEPJEdNP1+McO8hUlWjsfiFTNbzgigNRP7
 OgNh9F5MNRBgzKkOrqYRBtAcbvqwvV4r+69DIPGiD72CCBXmhfBPzuin/xZBpRSDnh6p
 cK8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620294; x=1726225094;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gOGzTPASlo6K8l2wzpyTbqSY9P+S0/aB+DvBDSW+bJQ=;
 b=p+BWe3agKq3pE0oYPGUAHBVPeoou9yv8/2LirfthtjkqSz/8dHjSK2WchhIjuL7qXB
 FjFrdvjsTpETv0oFcNJlEQ5iYxL55bmC7h1bXNl/si+Cov6QfSj+KNbRJWjCQ9Off+H1
 UgXhoGQI4TvFZ1aL3OaJx3IhoMxsbNyggqxHFnaK8TjFIUjl5iRglYm5TFrtgc+ZfB5p
 bNnndeXwsDm3drbWzVA7s6Nb2LiSHiP4VR9c8xczC2kLV5054z2m8QD0X/RvAwxcIisi
 MYo2ojGoct0+dxr1gxkuYKeULQmXFm83kqnTpv0bgLG/tSrL8PY/dDAGSXYdxIGTEAPZ
 qk2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+FOHeRQifNJ424ztaf855druG8SQJlqJ62JltiCzOePjDWtNaKJLnSax/6PVmkfCwcF8dIhFJHhY9@nongnu.org
X-Gm-Message-State: AOJu0Yxt+/PE9f4ZFrsIkP5ZmDtM5iSKtBhCn8j8hBZ+zSPUVQcu501r
 P55FIbPIELDMGwTMdjv1DJT3rCVaTxximv6MkohA5HGJ+42r7YW0s4CY3w==
X-Google-Smtp-Source: AGHT+IGqWqzO1HMl0zOXynCf0/p/MGQzSEeMiTkMJy2GcrUmtdlYFFTVilxFLkh1/8yJNkIvCzQOVA==
X-Received: by 2002:a17:903:41cf:b0:1fa:9c04:946a with SMTP id
 d9443c01a7336-206f04c9dd2mr23303095ad.1.1725620294583; 
 Fri, 06 Sep 2024 03:58:14 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67bc6sm41134575ad.258.2024.09.06.03.58.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:58:14 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 jeongyuchan0629@gmail.com, Yoochan Jeong <yc01.jeong@samsung.com>
Subject: [PULL 4/5] hw/ufs: ufs attribute read/write test implemented
Date: Fri,  6 Sep 2024 19:57:41 +0900
Message-Id: <49ccea4be9400a29477ab20fe959629786b076fd.1725619134.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725619134.git.jeuk20.kim@samsung.com>
References: <cover.1725619134.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Yoochan Jeong <yc01.jeong@samsung.com>

New test function "ufstest_query_attr_request" added, which can check one's
virtual UFS device can properly read and write its attribute data.
It tests if reading and writing attributes work properly. There are
some testcases that are intended to make an error caused by writing an
invalid value, allocating an invalid selector and permission issues.

Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 137 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9f45a078e7..061371414a 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -620,6 +620,141 @@ static void ufstest_query_flag_request(void *obj, void *data,
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_query_attr_request(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    ufs_init(ufs, alloc);
+
+    /* Read Readable Attributes*/
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_BOOT_LU_EN, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_ATTR);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_ATTR_IDN_BOOT_LU_EN);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_BKOPS_STATUS, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    /* Write Writable Attributes & Read Again */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x03, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0x07, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x07));
+
+    /* Write Invalid Value (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0x10, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_INVALID_VALUE);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x03));
+
+    /* Read Write-Only Attribute (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_SECONDS_PASSED, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_READABLE);
+
+    /* Write Read-Only Attribute (Intended Error) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0x01, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_POWER_MODE, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    /* Reset Written Attributes */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_ACTIVE_ICC_LVL, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                   UFS_QUERY_ATTR_IDN_EE_CONTROL, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -689,6 +824,8 @@ static void ufs_register_nodes(void)
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
     qos_add_test("flag read-write", "ufs",
                  ufstest_query_flag_request, &io_test_opts);
+    qos_add_test("attr read-write", "ufs",
+                 ufstest_query_attr_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


