Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA639CA9EDE
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 17:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGJz1-00029H-D5; Mon, 12 Oct 2026 13:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGJys-00027E-Lp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:38:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGJyq-0003e8-96
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 13:38:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so26219185e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 10:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791826710; x=1792431510; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=usZFRkws+j7TzH9xq3wKZiKiY9W93M5uvsiD1aeslcY=;
 b=Y3E+LyLPzaoAU0AceUM76NubHnfbK2pW9g4XAKJ8F8QQCbvDfj9EJy3gG6uzXklaHz
 ib/x6KYhiZcTDYO5QAeZXZHEosmuUy2bLFE5/fkytD+kop9YfCAeROyfoc4B+qe4DaJs
 ep4ziroAPc4LWchJB9XU2B6qfpY3C/7igHHdD7ZMggKO+tSTrM12tktVHdgeskGMj1sX
 D2HCurGojoC5yHKn6GyUm3VEp+ocecYmV0NtC8UnasNGE1NubZmdz3qQVdog7MfTpawI
 jjxnZ8u4rSxwKkws0jOOiwHTTvsAfqx8snOPYIRnMYGJQMSGikuF5JrtzWCo0wd9Mmk+
 oDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826710; x=1792431510;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=usZFRkws+j7TzH9xq3wKZiKiY9W93M5uvsiD1aeslcY=;
 b=zvbnWr7YsJC1DQdMACVEYAj0xCHVFGx844bSuD2kqBT1ztUasb/7OgQrnGN9uHlBRw
 OVA4sjua2enUUmsuBX19a5Futip1eGaM2Jg23qLjReLrCsyeMyx03QcqiD4NWRd/9fhb
 S2/85bZSwxZPanWLw3i0tVfKOjFnWO0dBPtbgUI2OPpVG6qWxleFNmfxp9dD1jjlYdm/
 t4Vrf1r+IKJjaIL7i949YIR4806HEvCgxTz3Eha2fMCVJWE3IYsQgog9Ck1THhqvX4O6
 wRbFRZXlvWhALkW00GNMsZkA5xoc9n0X3IC+xccwu4YW06cWLdy+Xie21bc/n4aTSO6X
 aY4A==
X-Gm-Message-State: AFq9FYJAN3xCbeRJ21aObnwX70fBvWv9oVAM1omoHokhfnni1lkAkQdg
 v3e7b0mPzmfejERSpWJpbm00mqAPH/+OdmIzWf8LnQlPG0Xjm8KwV6xTtt2ZzwBP
X-Gm-Gg: AYBFou3EzAfwMJtpbzYuiKycK1+q+nQbblLJ0Ni+v7pwmYvtwJuRHBc+1JQviYC0NMl
 fAJHVdO1OkDzd+SmsWA+cMeL+evG/NykL/CT8viXngfUR8JltsP4mh0o/WkjB2a7UwGq3+oLwat
 ZqaXIbSWRafYsVEsoHy6Ah31pzX9Hu5XQ1ELrAeXyFnXqvbVe++9fdxzR1Gcs5QN52oGSmPkChA
 d3IboPFUuNeP39BPLUpICKkRN2Dv87lotSOgnY7dp1oYtJJ4wIq+NOs+aZ5XCBZvBQlgkt4pZ61
 Tv+7D3ABCBO168hYoo4XIASZkXp9xqJXaRs9xQM2xEwwXG83gW1OMlxtRP+fdQ0iB9o5bqjMqSB
 JBTACmGBD9203XRXQ28VQhaDQLzeDfV5SJrKRaLbELc66rZW+jrxkxi+rhqlv6UXRK67Kw2kcbD
 +I+W5Mr1dakTmOnJIJFSl88uhd9Wq+fQO329pED370/rH7vHfskzZUAxN7aLEN9yri99ahQdaik
 q24cGOJRcur25pGlXs+WCDt22I=
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-4a18e4c05e5mr200478805e9.19.1791826710489; 
 Mon, 12 Oct 2026 10:38:30 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf1358asm307493095e9.4.2026.10.12.10.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:38:29 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 19:38:14 +0200
Subject: [PATCH TRIVIAL] io: avoid potential double close of
 qio_channel_file's fd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-fix-double-close-v1-1-d37f2224dcb0@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0Mj3bTMCt2U/NKknFTd5Jz84lRd86Rk0yRDE5PkZEsTJaC2gqJUoBq
 wkdFKIUGeYZ6OPkqxEIni0qSs1OQSkIFKtbUAQdbsh30AAAA=
X-Change-ID: 20261012-fix-double-close-7bc5b144cc94
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 qemu-trivial@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791826708; l=1494;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=5dvrwQ9mqfHO4Xa7PXXmIvECRDsR2GyNuRN5/WgwZ5g=;
 b=taQ/jvVmUm682R0Usl8bWtHO2OWnlAbyhnPdRoKkyxjuIP3FTh5/AVG5udufnr0uAcwtwNmij
 fYTApx2gPZ7B1t9n5vGMM8ELsPEjnZ1lEZO6YozdjJ4heeo5oWnVqoT
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32f.google.com
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

Make qio_channel_file_close() set fd to -1 even if qemu_close() returns
an error so that qio_channel_file_finalize() doesn't call close again.

On Linux, close() always closes the fd, even when it returns an error.
Because the fd can be reused after it is closed, the close must not
be retried.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 io/channel-file.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/io/channel-file.c b/io/channel-file.c
index 5cef75a67c..afc9640518 100644
--- a/io/channel-file.c
+++ b/io/channel-file.c
@@ -255,12 +255,18 @@ static int qio_channel_file_close(QIOChannel *ioc,
 {
     QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
 
-    if (qemu_close(fioc->fd) < 0) {
+    int ret = qemu_close(fioc->fd);
+    /*
+     * The fd should now have been closed even if we got an error. There are
+     * obscure systems where this isn't always the case, but an fd leak on
+     * obscure systems is less bad than double close on common systems.
+     */
+    fioc->fd = -1;
+    if (ret < 0) {
         error_setg_errno(errp, errno,
-                         "Unable to close file");
+                         "Got an error while closing file");
         return -1;
     }
-    fioc->fd = -1;
     return 0;
 }
 

---
base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d
change-id: 20261012-fix-double-close-7bc5b144cc94

Best regards,
--  
Filip Hejsek <filip.hejsek@gmail.com>


