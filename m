Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF95EE6B48
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 18:20:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voQR9-0007Oi-B8; Fri, 06 Feb 2026 13:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQR7-0007OE-Ic
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:09 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voQR5-0004fi-EJ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 13:20:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so22007825e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 10:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770402004; x=1771006804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m0XJalfC5IqgU2W7JDKFGQzzc/v7gEN8vJtThzS7KrY=;
 b=aN2kvCyZgUXK2hvw4PyfahCtC4h2v5FF7L0peT0HcML0aoRdtZCmTixNrzc6WLrIlg
 A4qNm5F88ewY8OWkWvmgeN6ctbxpcL0l+V6iUu2XLn3rsaI1gK5+dFgMz6hkiizLWa9G
 hsnEJDbEWXTNSr64LTjNc0c2jeWq4T3eW3Xy231gDzyX1lqkIKnkxp2J3wpI9UABqhDC
 qPMYJPD3/tJF+9S7O570c5bugb++jygFxLovDAvRql1OTqxW39LG76JJknPTcip/wsDe
 JW8mU8e+ZSWjBbsoWByd9jEOba0totOAoPNb14lGFQALn0r3kfgJpxqFD+97HmVxzrjs
 eRKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770402004; x=1771006804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m0XJalfC5IqgU2W7JDKFGQzzc/v7gEN8vJtThzS7KrY=;
 b=vuhguFbAWRGqLMxzqGUh3lBiRxuXGP9icQlowGnP97cE4IXMzDPs3A26UWGPskd2N7
 byH6VsVGiiYoFW1iuwBBgsg51z7lDNANKiB71ygfCq9oQVGilkUvKF8zuyZGRvwaQRyu
 Vfvy4b4PlD6TUCS04NOPApIM5BOj14WweC1t9g0HZngNcuOj1ILK0AIq8mxpQ+41HNDp
 HlbFAROvMEtUEE7k8NH7dG20Pta9xBQh1bEp3HbpV6YZyKYO+2uwZE8v1GRIOyR8HgGc
 KMMgvDQSbTsOnZLTkU98PMkltLnz1pcXZrPcZnVjS77Z008Ovha86GgnUjqH7HAFsD6u
 ikpw==
X-Gm-Message-State: AOJu0Yx8SqZQvWssiggcaZkA69QtPpzfwHLrIKMJZBelAUZu0kf8pN2y
 pN9BQuRm69svKv+H2PcpWnqiLs2AzYWw94uVt/OgA7KK4Iq1WOyaFln8XGnpad95r0x7z2hLOZk
 fJxWgaDA=
X-Gm-Gg: AZuq6aLup0Efkc5QFMANMismZkZzvUCPbrp4TJE7Gx+Xpfp3abfjJSlE27tQXdS4PUE
 05/hWXSSA95nhCRdJqeQOl7XZqUYVtgSwha+ukD/SzKPUwDoWgbrR1kW1aktHmCqSEL3eu05q/0
 d7kxmCe1kQb2FJq5ly9EE6EYfywIxRsFvHixtM2Wx2jf3VvadYHmy8VNQmcH1KtjQIHKHKqtBKm
 9Fg9dJqwNLtMy9kXptK56dQ4d0GWvbtZHyOW4fQGYbudWXK99zB0rbMczclMN2ScIoUOwGEk/3+
 za+S5VBTesQ2D2RZHLZv+VBh4IqnTX+icB8w5wyNAge+AXt4hzlsK2ErHViNTyI8w38g4PgGa1x
 3wLCS2MHdYMKnvxLMIt2+WB1G29pEz3dbEKKykeulWWhqD6jP2bw6ocL7vnnfsp45CnUhgvblFV
 hqT9wLwihs85LCKHDF9lPPQnJ7aBvgYI9U9CmK+1wSDVl6GMQufeYfQT4X05YhiAnH+0FOZk8=
X-Received: by 2002:a05:600c:6289:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-483203393b7mr60222085e9.33.1770402004199; 
 Fri, 06 Feb 2026 10:20:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483209c1a64sm23607335e9.12.2026.02.06.10.20.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 10:20:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 01/10] target/s390x: Use address_space_ldl_be() in
 read_table_entry()
Date: Fri,  6 Feb 2026 19:19:44 +0100
Message-ID: <20260206181953.18683-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
References: <20260206181953.18683-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

address_space_read/write() is meant for accessing random
amount of memory blobs.  When the access size is known,
use the address_space_ld/st() API which can directly swap
endianness.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/mmu_helper.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 026502a3e40..30f09ec3de4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -108,6 +108,7 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
                                     uint64_t *entry)
 {
     CPUState *cs = env_cpu(env);
+    MemTxResult ret;
 
     /*
      * According to the PoP, these table addresses are "unpredictably real
@@ -116,13 +117,9 @@ static inline bool read_table_entry(CPUS390XState *env, hwaddr gaddr,
      *
      * We treat them as absolute addresses and don't wrap them.
      */
-    if (unlikely(address_space_read(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED,
-                                    entry, sizeof(*entry)) !=
-                 MEMTX_OK)) {
-        return false;
-    }
-    *entry = be64_to_cpu(*entry);
-    return true;
+    *entry = address_space_ldq_be(cs->as, gaddr, MEMTXATTRS_UNSPECIFIED, &ret);
+
+    return ret == MEMTX_OK;
 }
 
 static int mmu_translate_asce(CPUS390XState *env, target_ulong vaddr,
-- 
2.52.0


