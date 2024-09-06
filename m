Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07C4CE7AFB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 10:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWfp-0003Kd-Ot; Fri, 06 Sep 2024 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfW-0002rf-Gf; Fri, 06 Sep 2024 06:58:22 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1smWfP-00063t-Vl; Fri, 06 Sep 2024 06:58:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-718a3b8a2dcso712396b3a.2; 
 Fri, 06 Sep 2024 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725620292; x=1726225092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DpglpDUM4OlF9COFJkrNkQ6UFuQoFP0oapIAUazllKc=;
 b=BNQWIwHBhYUSgwyH6PVE2yKSUWQx7kdhYEQeQKFbbAQJ9zNFGzGt9ynVkuksD11AxV
 VUsEuXGVla9DDAAKROB3L2IiwJ6XGirpnOtxE1jV/9cW2zwe+OSINDcPfMTTHnjYVfqZ
 GX9moxTaAUHPijBxt3ASkOv6h6DxVXkd1jgAmv0k2iiYCVRucktfFa8kQ1uID6Qrw6t9
 rtEnAg3Cea+Gf/NCWg1yrmYFzbgnLQEsFFvXeShTBosMzv8HCzCni+CF7vQpUurrr1d2
 NEGRacTyrmiD2wuUHlT9IbHTQbr3BJQXpfsGRuT/Q2+0WT8eqez2vwiSOu5i+hPsrWe7
 TE4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725620292; x=1726225092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DpglpDUM4OlF9COFJkrNkQ6UFuQoFP0oapIAUazllKc=;
 b=pV8LOzJvjXQarKtL7pUPOzdjWVqX+4T3ELnOJDh0pOdzKRljb423t9rTmw9YLK2IhA
 paA1xIbA/IRPEtCABWKZjLfcJM1jdwAV5as+JkVQBvUvuJH3z1DQW9y88F0MT4tmLPEa
 sqVvZCpSUS6Y+wb3uWnq3Xc+kas/24eEYZpiTPFB33tqU1UEmWq7Oph9RX5OFnTr8w6X
 VBs2QL52Jyr29s14XqNXifFEAp5cPGHcwnAFK0x+r2oOcdUMnof9lWdd9X9HDGh3P6wF
 3Afyht4F0bW8y7CDn/MQbJcjT0AYVi6tqkjPxDty13axy8gdwXb7d8JN2Y01UV6zNU0k
 g/8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1cV2f8OCZpk5wsTdyHNJWsVPG1SHqBUNSlrU6UT8DknmaXCSqqUwPNHSXBYuCICCUxO+94Sn82BPC@nongnu.org
X-Gm-Message-State: AOJu0YxtIPTrcVvypG35yfGn1SAyLELamtK7OP0+6BmdAz+uu2BDpS+5
 7KFYs/wsNkzg23/7sLQmlHAPuheVqonAUJGt/0w/RdPuMn6RgBrGz4UXrg==
X-Google-Smtp-Source: AGHT+IEGIvCp3LqA9RxnJ3RUOlyXkADb27C7M6LxM+npN9b3ritDzoHXLT9At3eYLPfWghwZAi/7nA==
X-Received: by 2002:a05:6a20:2d06:b0:1c4:6a86:e40d with SMTP id
 adf61e73a8af0-1cf1d1b2da9mr2386556637.38.1725620291595; 
 Fri, 06 Sep 2024 03:58:11 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([175.119.5.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-206aea67bc6sm41134575ad.258.2024.09.06.03.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 03:58:11 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 jeongyuchan0629@gmail.com, Yoochan Jeong <yc01.jeong@samsung.com>
Subject: [PULL 3/5] hw/ufs: ufs flag read/write test implemented
Date: Fri,  6 Sep 2024 19:57:40 +0900
Message-Id: <4aac30299b742f594f52016d4133487ad33459e7.1725619134.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725619134.git.jeuk20.kim@samsung.com>
References: <cover.1725619134.git.jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x42f.google.com
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

New test function "ufstest_flag_request" added, which can check one's
virtual UFS device can properly read and write its flag data. It tests
if reading, setting, clearing and toggling flags work properly. There
are some testcases that are intended to make an error caused by
permission issues.

Signed-off-by: Yoochan Jeong <yc01.jeong@samsung.com>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 tests/qtest/ufs-test.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index 9cc9e578ff..9f45a078e7 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -539,6 +539,87 @@ static void ufstest_read_write(void *obj, void *data, QGuestAllocator *alloc)
     ufs_exit(ufs, alloc);
 }
 
+static void ufstest_query_flag_request(void *obj, void *data,
+                                       QGuestAllocator *alloc)
+{
+    QUfs *ufs = obj;
+
+    UtpTransferReqDesc utrd;
+    UtpUpiuRsp rsp_upiu;
+    ufs_init(ufs, alloc);
+
+    /* Read read-only flag */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_FDEVICEINIT, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.opcode, ==, UFS_UPIU_QUERY_OPCODE_READ_FLAG);
+    g_assert_cmpuint(rsp_upiu.qr.idn, ==, UFS_QUERY_FLAG_IDN_FDEVICEINIT);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    /* Flag Set, Clear, Toggle Test with fDeviceLifeSpanModeEn */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_SET_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_CLEAR_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(1));
+
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_TOGGLE_FLAG,
+                   UFS_QUERY_FLAG_IDN_LIFE_SPAN_MODE_ENABLE, 0, 0, 0, &utrd,
+                   &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, be32_to_cpu(0));
+
+    /* Read Write-only Flag (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_READ_FLAG,
+                   UFS_QUERY_FLAG_IDN_PURGE_ENABLE, 0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_READABLE);
+
+    /* Write Read-Only Flag (Intended Failure) */
+    ufs_send_query(ufs, 0, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
+                   UFS_UPIU_QUERY_OPCODE_SET_FLAG, UFS_QUERY_FLAG_IDN_BUSY_RTC,
+                   0, 0, 0, &utrd, &rsp_upiu);
+    g_assert_cmpuint(le32_to_cpu(utrd.header.dword_2), ==,
+                     UFS_OCS_INVALID_CMD_TABLE_ATTR);
+    g_assert_cmpuint(rsp_upiu.header.response, ==,
+                     UFS_QUERY_RESULT_NOT_WRITEABLE);
+
+    ufs_exit(ufs, alloc);
+}
+
 static void drive_destroy(void *path)
 {
     unlink(path);
@@ -606,6 +687,8 @@ static void ufs_register_nodes(void)
     }
     qos_add_test("init", "ufs", ufstest_init, NULL);
     qos_add_test("read-write", "ufs", ufstest_read_write, &io_test_opts);
+    qos_add_test("flag read-write", "ufs",
+                 ufstest_query_flag_request, &io_test_opts);
 }
 
 libqos_init(ufs_register_nodes);
-- 
2.34.1


