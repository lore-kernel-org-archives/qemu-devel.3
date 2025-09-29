Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55BDCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F6L-0004tv-Ik; Mon, 29 Sep 2025 10:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5n-0004i5-Q4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:43:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5T-0001l0-PX
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:43:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso34955935e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156954; x=1759761754; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w24qu0TlEZnI2t5vQ3QHQiMaGU0xSwrCWCvZb2/QTzs=;
 b=fCanxPzOXk1ul7UARe7RmXpPM/swr9fKoSFT0mcVWS/58A1n7TiOytWvWWiL3RFliF
 xjwHU0SlQdMXkoUXMzPdMukeUBWcNajpcX0h+pVYWIfi0H2+Pegcx+qq/aJ0ibBXCyWj
 W1+ifDfFesxLiWXV3G41p49yOpd5OQcuIzcfiHJVBKjNkE1U/rB4SXTg7lTkijPrzJsT
 /nzVjSC3KzwIozl/+H1K0L/SVxmGiKwzOvk7ZhPemAtZ72yO4baglwsaP8GxRVzK0GHJ
 pl0cKw6OP26Uv2aXGEp4TYxcRV8v0x78K55wELx/9KC4G2FbQ0zFJQFlt6KSk6cxc7Z7
 6Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156954; x=1759761754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w24qu0TlEZnI2t5vQ3QHQiMaGU0xSwrCWCvZb2/QTzs=;
 b=SHEXWevOb0IBzG4t5qbNj4HE30Jgd39CIzh85K7BBmSegNebb+L6BO9pSi2KYSkjRP
 PFQzZ8/qmmzaH3u+6OmXlnJIifTDRY+nFOrQkmoVl7jv4BrGrHXYvu6aBWJWwLXMbr1D
 nrobtOYbWWLNheFOe7enN+jTn5WKisQWAh7RJfje4Wao7LlVWb98iDOgwRfZ0zOlogC1
 Zt0u3C8LrF2W2/CaPwczSRtCnQE9fyfUzueV/WAcML0T51ohuzyP+W+NZjL5CXsfmVnS
 UULKCK3SrpNDPeuMbyJ7Yx8ypeHrVk87cRXhktpyF47Bg+3escySGMw4zadzGN32lV98
 N8cw==
X-Gm-Message-State: AOJu0YwZTn+gGSfahAGlpOMJI78WjDFNNYRphA+7xqUHin9l25A5Jxxd
 /0uTRpRPs4xqwOnvn+lu56+9U7tzFapy68oQ003LOrKjYRFeKRIsOkGJ01WINWEU3QUynnWGNk0
 UEsDC
X-Gm-Gg: ASbGncshWh/pp3w8OV4b1SrfkITZZR0SyvAEXUdM9yocnHRYlFGPKqZ6JdwTcclsEEN
 CmqKWyCnRWzjKGsT2XAXJkf4e7Mi1X0Jqc0Pczcw2BlmZlF79iG1WUOH83eSUAHqPC6RvtIO8Mj
 mKasPqRntV8skVxnj4Tzg1ql91iP2fSqCFtuOR7ykIisMgSoZQtDNXwJa5cBoNeP/tIOXHXjbJY
 iYQl3VFxBxB0QoZIwXZLVD1q21JArYmRov4lgceA+h/xnOenbZnzzMlFZadlnU5H7D9LbcaJhdk
 SNNuikj3TxQw7yjqMCA5p4Cs6mr0cYioXbHiAdlGa+554M0/goWrJLnYLObk0NXORYlbrl3SG8D
 ggiUziyTT6gh3XHQtH+oYUiElOPL7EHhPQpMD1Bg=
X-Google-Smtp-Source: AGHT+IH5A1aeWf+tjZIeSnnITMHdb6amqzXI03BaBCJc0m/SRksCW4hFdydw5f2EYyB21BgEKlFe4g==
X-Received: by 2002:a05:600c:8519:b0:46e:3978:ba71 with SMTP id
 5b1f17b1804b1-46e3978bfffmr122280325e9.21.1759156954260; 
 Mon, 29 Sep 2025 07:42:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64849sm15893885e9.11.2025.09.29.07.42.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:42:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 2/3] memory: New AS helper to serialize destroy+free
Date: Mon, 29 Sep 2025 15:42:27 +0100
Message-ID: <20250929144228.1994037-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929144228.1994037-1-peter.maydell@linaro.org>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

If an AddressSpace has been created in its own allocated
memory, cleaning it up requires first destroying the AS
and then freeing the memory. Doing this doesn't work:

    address_space_destroy(as);
    g_free_rcu(as, rcu);

because both address_space_destroy() and g_free_rcu()
try to use the same 'rcu' node in the AddressSpace struct
and the address_space_destroy hook gets overwritten.

Provide a new address_space_destroy_free() function which
will destroy the AS and then free the memory it uses, all
in one RCU callback.

(CC to stable because the next commit needs this function.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
[PMM: Expanded commit message with motivation, tweaked comment]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/system/memory.h | 13 +++++++++++++
 system/memory.c         | 20 +++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 827e2c5aa44..08daf0fc59e 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2735,11 +2735,24 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
  * Note that destruction of the AddressSpace is done via RCU;
  * it is therefore not valid to free the memory the AddressSpace
  * struct is in until after that RCU callback has completed.
+ * If you want to g_free() the AddressSpace after destruction you
+ * can do that with address_space_destroy_free().
  *
  * @as: address space to be destroyed
  */
 void address_space_destroy(AddressSpace *as);
 
+/**
+ * address_space_destroy_free: destroy an address space and free it
+ *
+ * This does the same thing as address_space_destroy(), and then also
+ * frees (via g_free()) the AddressSpace itself once the destruction
+ * is complete.
+ *
+ * @as: address space to be destroyed
+ */
+void address_space_destroy_free(AddressSpace *as);
+
 /**
  * address_space_remove_listeners: unregister all listeners of an address space
  *
diff --git a/system/memory.c b/system/memory.c
index cf8cad69611..fe8b28a096b 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -3278,7 +3278,14 @@ static void do_address_space_destroy(AddressSpace *as)
     memory_region_unref(as->root);
 }
 
-void address_space_destroy(AddressSpace *as)
+static void do_address_space_destroy_free(AddressSpace *as)
+{
+    do_address_space_destroy(as);
+    g_free(as);
+}
+
+/* Detach address space from global view, notify all listeners */
+static void address_space_detach(AddressSpace *as)
 {
     MemoryRegion *root = as->root;
 
@@ -3293,9 +3300,20 @@ void address_space_destroy(AddressSpace *as)
      * values to expire before freeing the data.
      */
     as->root = root;
+}
+
+void address_space_destroy(AddressSpace *as)
+{
+    address_space_detach(as);
     call_rcu(as, do_address_space_destroy, rcu);
 }
 
+void address_space_destroy_free(AddressSpace *as)
+{
+    address_space_detach(as);
+    call_rcu(as, do_address_space_destroy_free, rcu);
+}
+
 static const char *memory_region_type(MemoryRegion *mr)
 {
     if (mr->alias) {
-- 
2.43.0


