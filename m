Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FC2C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdXA-0008L5-Sd; Tue, 04 Mar 2025 20:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdV0-0003lD-L1
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:38 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUy-0007GR-FL
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:38 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43bc0b8520cso18285865e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137874; x=1741742674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mWnfHltEj6tHRnPRGRMEHYizLDHaaGta9SL21+nd1o=;
 b=hc/LkIRUATJSRI49wJ2RBhflEIAKYAB7myCjrhabHKx/Uw4g5TX9DGd/uQeC3oWcJz
 3u+OQsEo9lycpw+1R+0nbExp+dbeHHNnPMQZWioAgBTvN3SUgQNq47uqpW7QZN7ez31w
 plMZuWtQkCorpCotRyKJXGtq1cmRl+sGIj+DdueaQzMvFflIFnrpXTY0nRuy/Q17Jb9R
 w1aLfR7SvHdjEjq8Vju/B3FiQlQGL0zpbQcf36w5W0QlVnJ39wU8Sj9YgChV96c2Ibdw
 /XANeIw8OitxcRywjUdnA7Dd2BLz47dE0nO67+HNmXsN39TlVl2qvQRa4CqDjFiRnTAo
 2spA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137874; x=1741742674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mWnfHltEj6tHRnPRGRMEHYizLDHaaGta9SL21+nd1o=;
 b=kF1LseIIktEfLe8eHWJgrmR717O2XaAI0qLadOxiCbsV5pyiTAHuDrcsl/zNNEA+dh
 1g87pnBrk58Eai49n+Ck1pb132Mro8aUSKOLjqna6npADAhIQ0wkj+L8Fv9yFa6V+lqL
 fzfXO8vjqc4zuBbDGkf1nVKNCQ3tbGLC3qEGyxKgN3X2PnWvWGgTd+J0dlfwxMGnkyEx
 mXkERBm10FI1QRLrGAUnujUa3I1FfpKkbf9RJUT9PbZc7xdSZr6bwUnhWZWjRU6Ew8xs
 ysyF3LkbLTOwENLniMElSwjmRODYKSSVbxONRsd09sfToQK+uwA/xa1qkPlI/5QrwyHl
 fe1w==
X-Gm-Message-State: AOJu0YweaJUAfBCWd2a3NlrKkT6oYp34sntAFO4flwWZ3/A515c7QrpB
 1NC5rBeGOGKvslUpz/juRhhg67lMxTe4HgGCEG6ELPl0tWgVIWfcU8l/rxxsCgDuwnqJhaTjZUD
 vVwo=
X-Gm-Gg: ASbGncu1J0LD2uihG/yH3oM/mNkqLkW72dCk9D8+g+fWqSk94KpgMdwQcspXw4/DXRY
 osWDXWMDKln12Qa4haDkWzX+SlH7Rk+TSYmPa5rFKq7EJTHg+ni1hOy+sRBybnbmfvN3LxP6+ai
 7ow1JpplNJFuBenf1ZCIsvNEz2G2yDYwRv3FB5+S4hVTjRCnq1c1K/hCs5YQ2suzW5NOT2seC8a
 56Jff0+Qcn025trtArQv4c5pa0hEUHjhMrjRNqUlyjqSjyVlmUFngA+GUTYGpuoxyOQkJEZaUaA
 htOhyXLaUyL+WRDONDb7O7qoH7WQZCgwbL+VJRY0A8zL/A1ZH9VCf6AuMecW/6dSOszWSlbTfRJ
 c9LjF1lhwgoRyIdBNqKM=
X-Google-Smtp-Source: AGHT+IFD3pgOlhis6f0S3UKzIuGTZWgOG/uOLqazzWAzAiVz/aQlZPTA3PivA+kPSv2VnG0oHSTbig==
X-Received: by 2002:a5d:56c7:0:b0:390:f55b:baa4 with SMTP id
 ffacd0b85a97d-3911f7c3383mr449324f8f.42.1741137874653; 
 Tue, 04 Mar 2025 17:24:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795983sm19152823f8f.6.2025.03.04.17.24.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Keoseong Park <keosung.park@samsung.com>, Fabiano Rosas <farosas@suse.de>,
 Jeuk Kim <jeuk20.kim@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 32/41] tests/qtest/ufs-test: Add test code for the temperature
 feature
Date: Wed,  5 Mar 2025 02:21:47 +0100
Message-ID: <20250305012157.96463-33-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: Keoseong Park <keosung.park@samsung.com>

This commit adds tests to verify the correctness of query attribute
results related to the temperature feature. It ensures that querying
temperature attributes returns expected values.

Signed-off-by: Keoseong Park <keosung.park@samsung.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
Message-ID: <20250225064243epcms2p8b7b59e7bf381bd68d30a6f59b40dea9f@epcms2p8>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/ufs-test.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/qtest/ufs-test.c b/tests/qtest/ufs-test.c
index d5076bdeb54..4867ccf08a1 100644
--- a/tests/qtest/ufs-test.c
+++ b/tests/qtest/ufs-test.c
@@ -784,6 +784,30 @@ static void ufstest_query_attr_request(void *obj, void *data,
     g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
     g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
 
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_CASE_ROUGH_TEMP, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(0x00));
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_HIGH_TEMP_BOUND, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(160));
+
+    ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_READ_REQUEST,
+                         UFS_UPIU_QUERY_OPCODE_READ_ATTR,
+                         UFS_QUERY_ATTR_IDN_LOW_TEMP_BOUND, 0, 0, 0,
+                         &rsp_upiu);
+    g_assert_cmpuint(ocs, ==, UFS_OCS_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.header.response, ==, UFS_COMMAND_RESULT_SUCCESS);
+    g_assert_cmpuint(rsp_upiu.qr.value, ==, cpu_to_be32(60));
+
     /* Write Writable Attributes & Read Again */
     ocs = ufs_send_query(ufs, UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST,
                          UFS_UPIU_QUERY_OPCODE_WRITE_ATTR,
-- 
2.47.1


