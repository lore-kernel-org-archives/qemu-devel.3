Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824D4C36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 22:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txD0K-0001jT-KG; Tue, 25 Mar 2025 18:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzs-0000u3-W0
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1txCzr-0006yS-At
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 18:43:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so30983215e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742942626; x=1743547426; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nzqWg6apFTmrvlzKNkVE/DNpvTLzQXt9JAyNTfEbkHg=;
 b=gdNBCWWI6gAs8m7v05zYj0ItwDQlMvWg356mNwUEH7wfNqOK9xLUU2j8u6iAHxFbpK
 9AoE2buGVuj9+Ep6K2yZeIYWnE7CEhqn6slMUIBwsExl8yFbj1iyjAatt9ZpKX04Af20
 ZRxGP4f+BIGJaBH4EjbIWApoD15lyoJAj6IKKjQV9hThKNTPnjzkzl+MzxiAF2KEamyO
 HZqDvW9PkQF68VxAamWONrJi0I0iW3jAsSLG5PZS6PrV8KQc0TbJTl5GlLtj7mmg8SZU
 yzg5w9rrSBQ3SYdrfBiSXrjEP0q+EEqogguwJg56icgV5uqMNwqWndZ2+GdvUzTvJVZs
 5U3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742942626; x=1743547426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nzqWg6apFTmrvlzKNkVE/DNpvTLzQXt9JAyNTfEbkHg=;
 b=e7uGkL4IBzt2F+GS0ArMPkc7KwNIJF6htDSntJN0XcAyf6P9PJEGqeB8nzg0cynr0L
 j32Yc8RMy9PAeomATc6Hzhp2kHJ2fl0WMdu5PwqbsIY28DTrOfLwcr95K9emYcXd3riD
 DEmJX41G66pptpy1Vf2FzMSqCTJggtGvbIfRW0oaeQVslWB62Mk01uiTl/DgFo65LWhx
 2RXVLTQYlz2UZ3yo53gB2NfwBCsaVtTPEZW67jqVee/vyuH9y6P88JaO14b1N9WQgpO5
 jlqTwj0xIX/3aBmthiewka8oBVl2r8UmZ263l6KZVZxyC8l+8ZpjnmTmgX8VfAnNzJRR
 QqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+G0qj+PVUVcZkdrBKNl/DKSF/7FJdWQJFirc2MWCDOoNrLfAd17Inkr5aktfvY8mpLgg7MXVHoa6s@nongnu.org
X-Gm-Message-State: AOJu0YzmLdwf8Tm9boGbgpqDCuS3glDAfRf9KScooAAVF4XQ2COBIFMg
 PvTzqKYc4MIItMMK3+AzHgLURn9ULmYCrNCi6XMqyw5/KwxUwLPlssEAdDFNSOk=
X-Gm-Gg: ASbGncuFX/BWdb/HJ264vJwuLrv5qCv9roKwOdq0lMLor5wUPPhUyBYwix1XVCm3a51
 slxvLYR+/vWQKJKeiq7Yty7GV2n6/zNa2K2U1WAuY0jDqs2E7E5YfqI9PC6WS3TYQzUXBPQXFtU
 9zt1IPHYVMmTxk1vFLFjeCL5e1v0Jjo7YmD1wb0sWvS/fe9IAwjO2a1KTMr+K+iJ5uUnOFURQGW
 /FRCnZ/UhtuJ3ts/909yfP2gbz/M/e8naniJU7I6JOpnzBdDanH5AeEjcsmogTZD6m7ingt8YOb
 yPHO+zKIZV6pG7lkUvfmMYvEaQCJ/MZO3aQkhhymnKDnIgKpMDpzgtj7UMPk0cEPfDJHMt1zg+m
 pfa1KvGsVY5RIZxnTc+tCRNWIqK2dQg==
X-Google-Smtp-Source: AGHT+IHs4UQHBwFObHDTNeiYxdNcM9vTxmJmo8Rr+pkZo5Yzr0PBtMCZ8vgGTj9Sd9VPusd/HyANOA==
X-Received: by 2002:a05:600c:1c19:b0:43d:db5:7b1a with SMTP id
 5b1f17b1804b1-43d509efb48mr157940585e9.12.1742942625793; 
 Tue, 25 Mar 2025 15:43:45 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b565bsm15149881f8f.58.2025.03.25.15.43.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 15:43:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Glenn Miles <milesg@linux.ibm.com>, Samuel Tardieu <sam@rfc1149.net>,
 qemu-block@nongnu.org, Patrick Leis <venture@google.com>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Bernhard Beschow <shentey@gmail.com>, Hanna Reitz <hreitz@redhat.com>,
 Hao Wu <wuhaotsh@google.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org
Subject: [PATCH-for-10.0 06/12] hw/i2c/pca954x: Categorize and add description
Date: Tue, 25 Mar 2025 23:43:04 +0100
Message-ID: <20250325224310.8785-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325224310.8785-1-philmd@linaro.org>
References: <20250325224310.8785-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/i2c_mux_pca954x.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/i2c/i2c_mux_pca954x.c b/hw/i2c/i2c_mux_pca954x.c
index 779cc4e66ed..100b8d86093 100644
--- a/hw/i2c/i2c_mux_pca954x.c
+++ b/hw/i2c/i2c_mux_pca954x.c
@@ -175,12 +175,18 @@ I2CBus *pca954x_i2c_get_bus(I2CSlave *mux, uint8_t channel)
 static void pca9546_class_init(ObjectClass *klass, void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PCA9546 I2C multiplexer";
     s->nchans = PCA9546_CHANNEL_COUNT;
 }
 
 static void pca9548_class_init(ObjectClass *klass, void *data)
 {
     Pca954xClass *s = PCA954X_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->desc = "PCA9548 I2C multiplexer";
     s->nchans = PCA9548_CHANNEL_COUNT;
 }
 
@@ -226,13 +232,13 @@ static void pca954x_class_init(ObjectClass *klass, void *data)
 
     rc->phases.enter = pca954x_enter_reset;
 
-    dc->desc = "Pca954x i2c-mux";
     dc->realize = pca954x_realize;
 
     k->write_data = pca954x_write_data;
     k->receive_byte = pca954x_read_byte;
 
     device_class_set_props(dc, pca954x_props);
+    set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
 }
 
 static const TypeInfo pca954x_info[] = {
-- 
2.47.1


