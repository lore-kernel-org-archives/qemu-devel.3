Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C125C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 15:48:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvI7w-000439-Ry; Thu, 20 Mar 2025 11:48:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7S-0003X1-Ht
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:53 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tvI7Q-0007op-CS
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 11:47:42 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-399749152b4so440773f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742485658; x=1743090458; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gSf0S4ib6Vee8Me5sVEAde29VMbctL8yWatlMbaa/I=;
 b=Clty6wocDireKBZhtOaco9YY0nNFae1NN60XgQ6gOmnd3a4VgS77X0ThBRxBFKDhdw
 0kAYlQlxDGeTHHDiKE12eDTkso895f+dwK7oOCw9e9udy3efRyJ0tekz7bygQtqku331
 Q2qZkmvhQiVBPYMqVGpREPc7s6ah1DIQPubNck7laPioFaUxt1cMAMkxZ25jsvs8QJJ6
 lALcIIprRXqm7N1aLpdOdKlH6z0JMpVetgsa3JB8UCv6I1qit35TJe1LG5mwXZm19P9d
 RSBQtz4m9WXSRqSBnADhHOoYu/jsLeqO6V5/HONgB2WtDTBAtVkAh8R0X3wM1blQqMOH
 hSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742485658; x=1743090458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gSf0S4ib6Vee8Me5sVEAde29VMbctL8yWatlMbaa/I=;
 b=JpMUnjxlYAIE2Yt+u36ljRL8BNEeGMhGFaEGNvYX4gEKewn33nUZK87zfJoZqM91Bi
 r+Y0zQZvR9PAf7qwG31qXgNuAQ6qvz/bIhKw3H7FK7J7gvTHtupZGeZ2Hsc+w+4Ag+N0
 oMjmT/2bd2UDq+fJKIeEa6QuuXVn0wJZ80xLWtqeENRoPo6/hEm80dQCFiUCCly7g6MM
 Jifx57qLuZ7+aa1C6PVqgsiYYOeOuuDHHRmWnBIw4c4ABsno0ONaJkl8ZQKjbiWBOcWw
 f3C7zKraMvplPa/IPrzaXt/J/uwrFs+To1plzo7cZ3Tp8txxtNF32wZGr+NgkUDav76z
 nQFw==
X-Gm-Message-State: AOJu0YzpTTO0EVQUXp+EK5CXukXx4AvUINurH5rXSsy1tfIX9SWPQFFJ
 GSMEEqBYbweitzT86sGUihSzYogtjACqocPDnTO0l7Eo1e0swbXcve/wTqxZRHnZN7HpSWP9Avx
 v
X-Gm-Gg: ASbGncv0HR82vgsc5iKSCfqt+OnYxiSbnjLP4tJqFff5diwTuwHV8+rodC3xVAONdtK
 NrU7z/4jXhH8kyJGmp6hhJThEWRoy79/wiQnBQfM6GtjoljcDPxmH1z6DngM2Xq3e3JlFzX/j86
 3Orb5q3BakbE6fTuyjrivT2PwnoVERI4TQXb27JMzigw/srCXVXkWCR5GDGwl1nWXACvwM1CCX5
 olapqvBF7rAhKxUzi30Dl4Y4WTl7Ea2b2AatPKv/BDhh4YWSwouduqzgr1nUcpeVTs2D/9l4PnH
 yDiVGWmd4BU8nUxhv41RktagVUK5tY/hSatT0GFO041ILf4mzM2sFqe5pGg2vwVdekOV+MvJ02N
 ocv3OENmIKmTFsExmMBGur/Kj
X-Google-Smtp-Source: AGHT+IHRAsnsJgAcXqM4Zxr6VJIFzbz2WKvKp+Wt8VDjEbtbw1uHiP+4ZJuTJB2NEZHpnpB3IDqZCQ==
X-Received: by 2002:a5d:64af:0:b0:394:d0c3:da5e with SMTP id
 ffacd0b85a97d-39973b313demr7289619f8f.47.1742485658084; 
 Thu, 20 Mar 2025 08:47:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8e43244sm24726286f8f.60.2025.03.20.08.47.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Mar 2025 08:47:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/6] qom: Test object_class_implements_type()
Date: Thu, 20 Mar 2025 16:47:19 +0100
Message-ID: <20250320154722.27349-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250320154722.27349-1-philmd@linaro.org>
References: <20250320154722.27349-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Test TYPE_INDIRECT_IMPL (indirectly) implements
TYPE_TEST_IF (via TYPE_TEST_IF2A or TYPE_TEST_IF2B
interface).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/check-qom-interface.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tests/unit/check-qom-interface.c b/tests/unit/check-qom-interface.c
index c99be97ed8b..c43a63e8b3c 100644
--- a/tests/unit/check-qom-interface.c
+++ b/tests/unit/check-qom-interface.c
@@ -36,6 +36,19 @@ static const TypeInfo test_if_info = {
     .class_size = sizeof(TestIfClass),
 };
 
+#define TYPE_TEST_IF2A "test-interface-level2a"
+#define TYPE_TEST_IF2B "test-interface-level2b"
+
+static const TypeInfo test_if2a_info = {
+    .name          = TYPE_TEST_IF2A,
+    .parent        = TYPE_TEST_IF,
+};
+
+static const TypeInfo test_if2b_info = {
+    .name          = TYPE_TEST_IF2B,
+    .parent        = TYPE_TEST_IF,
+};
+
 #define PATTERN 0xFAFBFCFD
 
 static void test_class_init(ObjectClass *oc, void *data)
@@ -58,6 +71,18 @@ static const TypeInfo direct_impl_info = {
     }
 };
 
+#define TYPE_INDIRECT_IMPL "indirect-impl"
+
+static const TypeInfo indirect_impl_info = {
+    .name = TYPE_INDIRECT_IMPL,
+    .parent = TYPE_DIRECT_IMPL,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_TEST_IF2A },
+        { TYPE_TEST_IF2B },
+        { }
+    }
+};
+
 #define TYPE_INTERMEDIATE_IMPL "intermediate-impl"
 
 static const TypeInfo intermediate_impl_info = {
@@ -86,18 +111,33 @@ static void interface_intermediate_test(void)
     test_interface_impl(TYPE_INTERMEDIATE_IMPL);
 }
 
+static void interface_ambiguous_test(void)
+{
+    Object *obj = object_new(TYPE_INDIRECT_IMPL);
+    ObjectClass *klass = object_get_class(obj);
+
+    g_assert(object_class_implements_type(klass, TYPE_TEST_IF2A));
+    g_assert(object_class_implements_type(klass, TYPE_TEST_IF2B));
+    g_assert(object_class_implements_type(klass, TYPE_TEST_IF));
+    object_unref(obj);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     module_call_init(MODULE_INIT_QOM);
     type_register_static(&test_if_info);
+    type_register_static(&test_if2a_info);
+    type_register_static(&test_if2b_info);
     type_register_static(&direct_impl_info);
+    type_register_static(&indirect_impl_info);
     type_register_static(&intermediate_impl_info);
 
     g_test_add_func("/qom/interface/direct_impl", interface_direct_test);
     g_test_add_func("/qom/interface/intermediate_impl",
                     interface_intermediate_test);
+    g_test_add_func("/qom/interface/ambiguous_impl", interface_ambiguous_test);
 
     return g_test_run();
 }
-- 
2.47.1


