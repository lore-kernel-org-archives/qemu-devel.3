Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28158606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H4K0OuR4;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=ig2pWPX0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYwI-0001Ia-FT; Thu, 12 Nov 2026 12:50:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYw2-0000gl-29
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xRYvy-0001cb-HU
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7QL21SCHAnTc/sjLhbOdkmAnmWKM2FACLfo4J3ysDQc=;
 b=H4K0OuR4w/HUQiDlhsHSnDbupRne64jIlOZpv/mywnFppQwW281g2DS++c8858oMye/6G6
 DGvlX1GU1ICz3YB+tSEO6HEfSv7bk2D5EP/qEhlIhMW7TftysD6VnVOcOPNw3Rh/AwLGMR
 nU+j0xliiiFhGtxqOT/E2ZZXEZ2nYOc=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-JNFttI28PJ-ewuQlwegpMg-1; Thu, 12 Nov 2026 12:49:59 -0500
X-MC-Unique: JNFttI28PJ-ewuQlwegpMg-1
X-Mimecast-MFC-AGG-ID: JNFttI28PJ-ewuQlwegpMg_1794505798
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3b0ac277beaso28234a91.1
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 09:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1794505798; x=1795110598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7QL21SCHAnTc/sjLhbOdkmAnmWKM2FACLfo4J3ysDQc=;
 b=ig2pWPX0z9kqn1SFmRW8rIMB4gnOpG1/f3tcFwJSIzkWW/5URmXqcuLket0ACf+Q16
 b+P75wGQAtVo+UEtCWVdLt6VWaOGasZPccTPzW82TO2ozddjqKZ7bTFYXqqb/abv7fQO
 2EJ3findlv0AHd3g19W1OwSoKe5F/EF/0DM7AKLHMa4kBT8C2HuFdPW0HO3gSvFmzqDc
 Uqsuydtd9uQ33zuPXPgrpR6etTwuWsTIdswROnLljriqbRmjFSz9yNjsqtcHqUQTCSda
 WTKMljrIW0heI2NPQdylMYpOxZcEQrmOh32qTvyzNVwWD/kExPpgDG+bDEP7FboXcOa8
 zYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794505798; x=1795110598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7QL21SCHAnTc/sjLhbOdkmAnmWKM2FACLfo4J3ysDQc=;
 b=kMfBgLhD+R+kcN6AzEIVkr6lEhBA6biHxh/EGePKYR/8BtJdDHn4h1flwW/01/pyDB
 kWq/mAQUH6RY9+0dZALD+c0Lhp6r8oFDUOU3l+bVKN5lkgv+P1ybiNgJq96aNylzJtGV
 0abi8ojM2NBBttbzXlSZrd4e6rfkCo2u0OGikDQSUQd+urHDQQmqEsnLxxNxFUYxails
 SdMZa+FX9eFkVPS9kBOILm6OCvChxi4EoqL74WXBQYhGinTBfElzOVx8WJ9BNxaYrOku
 8GLozvSv2SQCEbYNqz+1wdLOoID17rWh4Xmy05WHp7tmpvsgQL0Oc0Yu6goNBnGTg3yF
 F6vw==
X-Gm-Message-State: APuU4Z96SF20JFmjUP5OXey/F1XvAJsGzA6k/OkC8raLMSgOJaZthRzL
 DifkFpJj/YOL59WnCyuns20s6voYLQGHXioLqay0kBH3SF0kPYXTFnwDBz5nAfQj4A3UqhPB4TS
 OIW36qpfMIewXSQ5IfrUMJXGD9WTiqLIfNL3j209CADD9CfEKDh369vu4CEVvkZpcrrw0cS35Hl
 sh8hc4NSLBqBvLv0s4Tl1to/1HvDYJhijPww7Ha8Lb+g==
X-Gm-Gg: AYBFou0I9j6GOSiXZwv0yV3peLPc2uwniNuxg4k0UKecsVIT63/7WShRV+T+mxTxpB/
 em4wE6bIAcfAwCx6S34I9PIF2RqgtluByeM88NtblmeTV9Ycq+pGrQRQRK5WJUOQyxnVldojfG5
 k9BNyRLTSAQydnnWvYJXDSLbbqp7EttuULSgqkyQ1T2O0u6JB+UmbUUloV9YtNeAtYLjfVQx72v
 tjhwOzS+uVQR+d2z66BqLIVhAMYrGi1yYBP2lAnbPJn2lAYi91P4VcWNiQmXqVxDBF/rFe200qS
 XY+kX0mavGHwXjKwpfslYJ0rx4pWJB8+1KsOqN3ON/811lrvULmrZEtYnKOyQ/nXl5B4oO2wQvF
 oF+r5LIb78LBKyLX4FYtlNtfHzDq2guhOwLoQ/D58feNABg==
X-Received: by 2002:a17:90b:4408:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3b182d697d7mr5216913a91.0.1794505798061; 
 Thu, 12 Nov 2026 09:49:58 -0800 (PST)
X-Received: by 2002:a17:90b:4408:b0:3ab:2ad1:f10a with SMTP id
 98e67ed59e1d1-3b182d697d7mr5216895a91.0.1794505797428; 
 Thu, 12 Nov 2026 09:49:57 -0800 (PST)
Received: from tcalifan-p1g8.csb ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1aed74024sm331352a91.15.2026.11.12.09.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:49:56 -0800 (PST)
From: Tommaso Califano <tcalifano@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Junjie Cao <junjie.cao@linux.dev>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Tommaso Califano <tcalifano@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH 4/9] hw/usb/dev-mtp: Handle invalid characters in
 utf16_to_str()
Date: Thu, 12 Nov 2026 18:49:01 +0100
Message-ID: <20261112174907.158825-5-tcalifano@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112174907.158825-1-tcalifano@redhat.com>
References: <20261112174907.158825-1-tcalifano@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

wcstombs(NULL, wstr, 0) returns (size_t)-1 when the string contains a
character that cannot be converted. The return value was not checked, so
dlen + 1 wrapped to 0, g_malloc(0) returned NULL, and
usb_mtp_write_metadata() dereferenced it in strchr().

Use size_t, return NULL on conversion failure, and reject the
filename in usb_mtp_write_metadata() when that happens.

Cc: qemu-stable@nongnu.org
Fixes: 6de02a13232a ("usb-mtp: fix utf16_to_str")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4529
Suggested-by: Hui Peng <https://gitlab.com/benquike>
Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
---
 hw/usb/dev-mtp.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1a26f681ce..7233470558 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1563,7 +1563,8 @@ static void usb_mtp_cancel_packet(USBDevice *dev, USBPacket *p)
 static char *utf16_to_str(uint8_t len, uint8_t *str16)
 {
     wchar_t *wstr = g_new0(wchar_t, len + 1);
-    int count, dlen;
+    int count;
+    size_t dlen;
     char *dest;
 
     for (count = 0; count < len; count++) {
@@ -1572,9 +1573,13 @@ static char *utf16_to_str(uint8_t len, uint8_t *str16)
     }
     wstr[count] = 0;
 
-    dlen = wcstombs(NULL, wstr, 0) + 1;
-    dest = g_malloc(dlen);
-    wcstombs(dest, wstr, dlen);
+    dlen = wcstombs(NULL, wstr, 0);
+    if (dlen == (size_t)-1) {
+        g_free(wstr);
+        return NULL;
+    }
+    dest = g_malloc(dlen + 1);
+    wcstombs(dest, wstr, dlen + 1);
     g_free(wstr);
     return dest;
 }
@@ -1739,7 +1744,7 @@ static void usb_mtp_write_metadata(MTPState *s)
     filename = utf16_to_str(MIN(dataset->length, filename_chars),
                             dataset->filename);
 
-    if (strchr(filename, '/')) {
+    if (!filename || strchr(filename, '/')) {
         usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,
                              0, 0, 0, 0);
         g_free(filename);
-- 
2.56.0


