Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D4FF483CC
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:52:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iW9-0001OR-AB; Mon, 23 Mar 2026 12:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iW5-0001No-CO
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:37 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iW3-0000Sl-Q1
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:52:37 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-48541edecf9so3187545e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284754; x=1774889554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CAevgdd/811+4PMNTmxklyJ0NzddPJDt1FLri2SnKSU=;
 b=rJhy2WimQB9NNvXfsMkM1g+aqB/9W7FI9SZsMZKr5rDYqZic0mj1gaBlRIPx8FpYUp
 +PwPZ5XVZnXFfhTOxlDf6VuxI9ZI+II4TIc1XDQSUOcFqnp1rNhUhUvxZCYaFj05jk2/
 C79heqMCIzAcMxPaJWrgToxDJioeYl78yUtv7Oc0FOxl0EfnteY3As14JBuaHM/Mlr2P
 Q0DZ/+ekiFoTZHye73dFJ0ho5bSNNCrSpKwgS1kS2uxP2IIcG6MQqxdDhv+JheOK3Vjn
 Y/iddpkORH5gzvVWM9h6paRKRrhWSmqWzyrjHTYIyPFP/oDDdOyYG6gPKZynys2WWt9q
 L52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284754; x=1774889554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CAevgdd/811+4PMNTmxklyJ0NzddPJDt1FLri2SnKSU=;
 b=E0wENm5lp2kNLefORlJAp91sldvXhHxr+vSQjWGKOnNB9cEplZNvgD0K6SEq4L2rSu
 4WHORVzE1q1AYIUwFv5KSLtW4Wh/binqJdPMYmhbk1f1ldqaeuY49w71XJRIsVWHNt+H
 WgrGiKAoW6u3eHyXadzXpjmyWKPHnkF5gS9Cblv0gLAw1UoiO6qc9m+UZWvAZ7TeOVPH
 wKwdjwRmO3i1vuGeifxt3sWWD3sTILwZOWIQxVFlSBRPiZA7RJk6sOTCUYDEh5mEMjRw
 jbQTfFvJMsioe8dUiedVd2IQ8cwoxAJCs7Ec+2UFrvGh/ADt3GLQdLh5ZrfomLoeMn+I
 kymA==
X-Gm-Message-State: AOJu0YwlwnOFBOWS/FFfGE19L8mRdxZ4SJxIvE/FjfN4Qa8est0aalsM
 tZqtKBnJcfsIa8adCkmaf2q0chnJWYrbs5JAIkJS6YIqawTUNZBKpP6AlR3OwfYKxp+dWhOTBqS
 ODiZ7j8M=
X-Gm-Gg: ATEYQzwdj+5LE8giX6J2chI8qiGmorO9wc0G8I3HjjOlNJVju/EGb1BMi9Io3jLiKUe
 aM1/L49xrD3YnALQhWBw/c88H5bPufdhJ9EWoWi50/DOrYR3awCfTm04V2lZNLr+F2/ukAzXVB4
 L4N7wxnVuW1x/+om7Wd9PRHn3LrqImOxwGel10FtCloUqoBFH7MVXGlLXZ1CH0EyXWFId02t3KS
 N/iAGtvnZOZ09SjC/d5C2c7xkIQlAHecz5YNsZ65koBib8xclQyroZt46tfEIJMB0a1hasZZiV6
 eA8oFmEDLnuINvqlIorOzdcBoSnnM3WPKZ78AIsn89DqlDGCg551cuai1ZaJUvIlIBc4JGGQ+uB
 DDPjywYpFzJ8u8viRdzh8kU63ufW6IBdyP+3Kc+5dmv7ss+3LRmdOj54ZpuuG2vzfeVZ0eEJ3t5
 De+/HLCDvfEzHKQ0ehtZX2Ks/IvVvJFpDwAO7CtxBi+FhaZTz+/WhW/rrF3XzQgLW8rhb2i+Bq9
 VB1hIUhjpE=
X-Received: by 2002:a05:600c:630d:b0:485:2c61:9459 with SMTP id
 5b1f17b1804b1-486fedc3835mr194690935e9.8.1774284753819; 
 Mon, 23 Mar 2026 09:52:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b949e1sm600911165e9.9.2026.03.23.09.52.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:52:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/27] hw/cxl: Use HPA in cxl_cfmws_find_device() rather than
 offset in window.
Date: Mon, 23 Mar 2026 17:51:53 +0100
Message-ID: <20260323165218.96607-3-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

From: Alireza Sanaee <alireza.sanaee@huawei.com>

This function will shortly be used to help find if there is a route to a
device, serving an HPA, under a particular fixed memory window. Rather than
having that new use case subtract the base address in the caller, only to
add it again in cxl_cfmws_find_device(), push the responsibility for
calculating the HPA to the caller.

This also reduces the inconsistency in the meaning of the hwaddr addr
parameter between this function and the calls made within it that access
the HDM decoders that operating on HPA.

Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Gregory Price <gourry@gourry.net>
Tested-by: Gregory Price <gourry@gourry.net>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-ID: <20260318171918.146-2-alireza.sanaee@huawei.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/cxl/cxl-host.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index f3479b19914..a94b893e999 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -168,9 +168,6 @@ static PCIDevice *cxl_cfmws_find_device(CXLFixedWindow *fw, hwaddr addr)
     bool target_found;
     PCIDevice *rp, *d;
 
-    /* Address is relative to memory region. Convert to HPA */
-    addr += fw->base;
-
     rb_index = (addr / cxl_decode_ig(fw->enc_int_gran)) % fw->num_targets;
     hb = PCI_HOST_BRIDGE(fw->target_hbs[rb_index]->cxl_host_bridge);
     if (!hb || !hb->bus || !pci_bus_is_cxl(hb->bus)) {
@@ -254,7 +251,7 @@ static MemTxResult cxl_read_cfmws(void *opaque, hwaddr addr, uint64_t *data,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base);
     if (d == NULL) {
         *data = 0;
         /* Reads to invalid address return poison */
@@ -271,7 +268,7 @@ static MemTxResult cxl_write_cfmws(void *opaque, hwaddr addr,
     CXLFixedWindow *fw = opaque;
     PCIDevice *d;
 
-    d = cxl_cfmws_find_device(fw, addr);
+    d = cxl_cfmws_find_device(fw, addr + fw->base);
     if (d == NULL) {
         /* Writes to invalid address are silent */
         return MEMTX_OK;
-- 
2.53.0


