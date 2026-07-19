Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81037C4450A
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2026 21:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlYvG-0007XH-OT; Sun, 19 Jul 2026 17:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvF-0007Vn-3j
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:41 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wlYvD-0006pn-KX
 for qemu-devel@nongnu.org; Sun, 19 Jul 2026 17:19:40 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so12327815e9.0
 for <qemu-devel@nongnu.org>; Sun, 19 Jul 2026 14:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784495977; x=1785100777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c7xQW0Y2c2Ttvhuy3nxoGn0GEZdics6zlvTb6qkTGRA=;
 b=QeDpfyCNG65BGoQfL9W7iQ9CbrPytC0sCp7CKS0RLs/DXSluBtsfgNgvsAYaQmMgLr
 /4D923B4fP25qir18G95gP7kMZq9SZorclYAJdw6QiUVwgB5I7AE+vAlrsXbdxbOCuSN
 FjLCEBBYdRTXhQ4cwn5cMTmDFfpNC02HZriJDWYz5iWU0DW8xryDD1J2v6n0GJQX22mD
 fn6iMMHBhs/ppEqn2i7bDALlDRvHbMNA43dj1OL+7mksa0NfEXNfpzC7VkWN5Zyw2tUW
 kqPBYcg+NdfkUUCa4BXBy0A3XrS+EgUhhx+Xl1ABph2NUH29fuHrv0SIPRRL3T6iMtI9
 P35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784495977; x=1785100777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c7xQW0Y2c2Ttvhuy3nxoGn0GEZdics6zlvTb6qkTGRA=;
 b=Cnf+kh6rAqJi7SXBp03bYk5/QLcDxFUWizkAdAIVBRYH94PUaOPy5a74CWyOnxwyHJ
 muvbP5ok5lmq3CBlmDfSyHapw4kwZKEpcUcJUktNBIsjJUrB+NXmJo9GZ1dBJHT9QREV
 1oa/E8Fk1BJGedmZODaEQzz1HWaO8RyFwGdzMmvtH3tJVgnhE9sBZ0P8AW9Lm6rI7hkY
 gkf0KipFjz1Arv+F/TrVNtZ83J3yyPPSNdHmahnvuYAbBtw6sIzA8VEPEdF/vyx4+HsZ
 wX65EbgJCsH8TbkFj7ADoulb4UCH9DOTtM0gcBu/VWvwkjD1/Kgh/Ccmt9tWn8WKWYrd
 cWFg==
X-Gm-Message-State: AOJu0Yy7XoOgbzq72uyOiMPwyw2ck/n3rybpyANRiDYG6tp3uwblXwJQ
 dBXIutNOpm3Q6qN3QnXjvfnzhcdtoEHIT5peZHtJEcv50JmVIQUHQBxhzjJLkQ==
X-Gm-Gg: AfdE7clxYYfU+Wz6cEnhazvX7aig6WN1VlxSxjKFeOvjqo5P0oqNNy0dD0ZuhVtjEmc
 gGaM77F/RnNerJYOedZYJRi34nUK1fgoAtqSNHBCKd5jBsLODLlkAXmszrU6juUs76RJZqlpxQT
 yxRlgNEVEJYoG2TSZFV4TUfoxk+AEvXswEWxx061thj5nhXaMMhpMVST8arMic1l6fa7rXG7D/k
 mcA6bsk5ZFD0bXH83wzmygGgic+mJtQfp5SFuBN4GjddQf/0+uL7Sl6RLGg+f4S2f7InP+HAZ2h
 hw9ttvoA3ju4gQkuPndbruhTIOmtLsN9fZUpqHj36COkq820tHWoDpKKn66Pd7OcWZWBQAGnBZ2
 eyauLOGng7VXOe/+H/cNi90eWW5AmEZRx3yCYc1A7BTjpT0K2lNYxcWQTia9BqtVSnGFNVBm+eO
 eq+0V/yZZPQPFFurocXD1me/K3PX0U5mrRlbG2Y4NpD2WVYOD+3pHf5H4hs+FK4q0JLi+8+IIbX
 nrVa/X6YS1Aftt7bCebeCjbaYHD7sdlokYi
X-Received: by 2002:a05:600c:3b91:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-4954a3d0065mr154286965e9.3.1784495976828; 
 Sun, 19 Jul 2026 14:19:36 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1c56-1500-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c56:1500:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2a24b6sm234235155e9.3.2026.07.19.14.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 14:19:36 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Christian Speich <c.speich@avm.de>
Subject: [PATCH 1/2] hw/sd/sd: Fix error case for CMD18
Date: Sun, 19 Jul 2026 23:19:22 +0200
Message-ID: <20260719211923.1079282-2-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260719211923.1079282-1-shentey@gmail.com>
References: <20260719211923.1079282-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

In commit 468fa450a7e0 ("hw/sd: Switch read/write primitive to
buf+len"), `sd_read_byte()` changed its contract to return the read size
rather than the read value (and was renamed to `sd_read_data()`
accordingly). In an error case, however, `sd_read_data()` returns 0 by
means of `dummy_byte` which is the code for the old contract. Moreover,
`sdbus_read_data()` asserts the virtual method `read_data()` (and thus
`sd_read_data()`) to return a non-zero size, i.e. to make progress and
not loop forever. Fix the code to behave like the "DAT read illegal for
command" case.

Fixes: 468fa450a7e0 ("hw/sd: Switch read/write primitive to buf+len")

---
cc: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3360757004..a30c541df0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2860,7 +2860,8 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                return dummy_byte;
+                *value = dummy_byte;
+                return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
-- 
2.55.0


