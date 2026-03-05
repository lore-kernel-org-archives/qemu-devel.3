Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3BDF3D32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBMY-00089D-GT; Thu, 05 Mar 2026 11:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMV-00088X-NG
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:43 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyBMS-0004Wt-CJ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:15:41 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48372efa020so73420645e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727337; x=1773332137; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V8KBWRCcpWPZCflOJSP2HFyrcMLOOxIFcS3rL5FNkAc=;
 b=E+u13mZs0X9zqlC8dCJqSKDhNSNYsBG6jhOVYNy1PRaJr3u2cVa8RypCzGYOHR9CyB
 fxoFrFAHBepe0f7Y/TwnPm+5ZLf6e4v0JhiKLj6y2JWC6AlNeKMXExEUEV8O44m0WfOV
 qU99UreYz0SJAJQiYw/hoiMKxaCMwpifGHOOWXJlN56Sj9U8+KdqG6v25bVxBOGdVEX9
 Zd9Xu6I/8MRZIDm3V7qZNXsK+R5+qrOTGrHGcZ9E9lw8FTRq4AS+WwVkCiiabEpX3gC9
 JMymb7XUNY1Akt/hwtlqcT75+d6rLxUcI1URbJmULH9ZWXcf9y52C7YcaQ6sAlIhHYD/
 XKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727337; x=1773332137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V8KBWRCcpWPZCflOJSP2HFyrcMLOOxIFcS3rL5FNkAc=;
 b=dRQmLvt+O0/pRFZKeoOWkkeFqrXbVEwN9CmbDARh7IVEzye8T8prm+Cz0fVUm6aj+R
 jau+PXdOM7NdrfnzCmnJNfNhWRlIhIclCnnG9uTneMdQ/iqv1A3yhL1EgtZ3d4sHgOWQ
 yWenswwzgJsdNkXlJPk34elZ98uts/SPoTLvr+iuJwiHEHA/byxydFxpE6CtN+fzikdQ
 7KXMG0iW2B5ZFqTBA2KrujflH+j0Yn1Jq2bNTLSPDv6YhhQ4yHuaon5kF9TZuepOc/JJ
 gbHuVuvRU6edk9UH2d4jHu8q5hVRg+JQACaWha2insv7rJF9pTaVMlyqLhROnvXElf/a
 K5NA==
X-Gm-Message-State: AOJu0Yx6Gdh/jgBwQaPJu2ItEtLOuQXusg8adIv608Uy79ndod4JjIHY
 TG9Bu3nXnpC/A6mkgRWmFZB1P/w4+1PtxkCzZvEW7a7uNlvIsXmgDeFC9GlJfq058RFEfLRDTZy
 IFmhr
X-Gm-Gg: ATEYQzwDNXiel1XTdIiqx9X279IfWdmXFNEAk0FU1PmIejA9Ahi/xwSrTSFAs1GUtFY
 73uHJeUMggN9tq12eTPyocAZCLUTp5C36f7aLvUjvmsYWImFgBPBq8LeN7QqtYNe/3NqjSH+GRQ
 NFl7czk4BQpriLs44NOBNTghTywCk2AxpVSrOLgJ4v861s+gnrUoCtF+n9Tnyj06LtfeuwqafxZ
 A5rTPEq68Zy3ihNA1Jpt2RLdg1zXfVJmSmxtjYzIOGCeotJCFuEaaWcSjp7M0Y2T5Zh7dsfKVV6
 VVVq+4OEs01RolOC0qAJL8CL1ONLBSpVQ1Un04SMr6kc5ic7GODmDeLv7xFOXXjQ8JyXkc+swlI
 T+06xlIiqUw6aIjQSi/raJJ+kIVWtFlwHQgchNLnmj4D2UDnGTxuWv28k94affoaWpJ9ZlvtO15
 jagd89zhXncoM/SJUGrdJ/H+EsDp7bb8W5fZluRz5ecyrJX2FunmF6nHqtUf9+MNem5+7R0/qTk
 XlyV0v/Yan9BWosOHtBlLW0SNK9kV8=
X-Received: by 2002:a05:600c:5252:b0:477:63a4:88fe with SMTP id
 5b1f17b1804b1-48519837bc8mr118919095e9.2.1772727337255; 
 Thu, 05 Mar 2026 08:15:37 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fad01d2sm53466465e9.3.2026.03.05.08.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 08:15:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 3/3] tests/tcg/plugins/patch: Free read_data in patch_hwaddr()
Date: Thu,  5 Mar 2026 16:15:31 +0000
Message-ID: <20260305161531.1774895-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305161531.1774895-1-peter.maydell@linaro.org>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In patch_hwaddr() we allocate a GByteArray for the data we read back
from the guest; however we forget to free it, and the leak sanitizer
complains:

Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x56c00ad48293 in malloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f293) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
    #1 0x7b3e4cc91ac9 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62ac9) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7b3e4cc54c12 in g_array_sized_new (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25c12) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x7b3e44b06b49 in patch_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../tests/tcg/plugins/patch.c:68:29

Indirect leak of 16 byte(s) in 1 object(s) allocated from:
    #0 0x56c00ad486b0 in realloc (/home/pm215/qemu/build/x86-tgt-san/qemu-system-x86_64+0x1a9f6b0) (BuildId: 62e2a7dbe5ff146b2fa14d26e24e443f1967edd9)
    #1 0x7b3e4cc92819 in g_realloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x63819) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #2 0x7b3e4cc54b36  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x25b36) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #3 0x7b3e4cc55276 in g_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26276) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #4 0x7b3e4cc55574 in g_byte_array_set_size (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x26574) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #5 0x56c00be2ccc1 in qemu_plugin_read_memory_hwaddr /home/pm215/qemu/build/x86-tgt-san/../../plugins/api.c:524:5

Mark the variable as g_autoptr(), as we already do in the equivalent
code in patch_vaddr().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/tcg/plugins/patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/plugins/patch.c b/tests/tcg/plugins/patch.c
index 111c5c1f16..eba2f8b8d6 100644
--- a/tests/tcg/plugins/patch.c
+++ b/tests/tcg/plugins/patch.c
@@ -65,7 +65,7 @@ static void patch_hwaddr(unsigned int vcpu_index, void *userdata)
         return;
     }
 
-    GByteArray *read_data = g_byte_array_new();
+    g_autoptr(GByteArray) read_data = g_byte_array_new();
 
     result = qemu_plugin_read_memory_hwaddr(addr, read_data,
                                             patch_data->len);
-- 
2.43.0


