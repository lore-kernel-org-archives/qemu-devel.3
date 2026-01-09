Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E735D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 06:58:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6PW-0003p6-Jp; Fri, 09 Jan 2026 01:55:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P5-0003Y8-PI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:25 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6P3-0002oR-Ki
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:22 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c026e074373so2039244a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941720; x=1768546520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cE0jDKqtS7aSGIIwr7yj4Rxy4Z76lwTaUBUlwt7TyeE=;
 b=Qv63CJ4j7qLsdzypxq6XK9/r2U7TOS+WTtIJoJ/3ypWAYHcmHhv4ZsJkdwZ1FJ5UEc
 SSavNspriGE4qBzBK2jHVpcrX9+apsmVrj65lG6J3XhjW6fh+08ui9V777tu3GamX77/
 uiN4dRyB3W145lwzXkQyoQ8o0MkKEG2xLeEFhIF4B1TBJA82xVAKpQOUnRU2WrFhecer
 lAqVFIVZhxNRoBnhIb/PDMNxGNEOnfMclSshNC8UHsF6v5BL+3+NfbJZ6Es6hZdhqnOL
 1Z9iN5/T8tI7dMFpPqOwoc4lY+HA76YzUAqmFUxMzdLTcOERkcLb+PCFSI7+IrOD2TF/
 O5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941720; x=1768546520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cE0jDKqtS7aSGIIwr7yj4Rxy4Z76lwTaUBUlwt7TyeE=;
 b=oapvwK1Z0U31Ucbu5M3HVRlhv0gmNx5Ddgg476MhiEuyck1X1luymG2G558FFQW22g
 NmCb+KB0pBox7L9CEanJVSun0qkbGH+HBeWO/E1OatzswORF/GHtDRmbfueukuyZFCA2
 yUKf1T+bkrryNAUsmeA3+TL07bBD42H8SXakqp+YidnP1SHUHbnJ1RHVYC+SL3voRL/8
 Wz/90XcSH7TIdeIE7F3ogU4Gl9kmiGt/YTcwEiXl3MsH9Sgp9Mj39Mqf5nwMl4bWAET0
 q/4ENnZeD7fZHakOVVFXaxCwn8152usPFkpdRv4QAXHZAZiK2Qg/KhqJYO3f7bhSrAw2
 WftA==
X-Gm-Message-State: AOJu0YyMwfU0dj0kIG+xSYuAKWc69j9XJlh6jm7lkHNdnX7Kvv0oKK7x
 7XADMZXE2vYPU4f44dKOijiIfSGf+WoncHHVmwXGdxK0JNHcUeYByzbxlFh25g==
X-Gm-Gg: AY/fxX7CsLhYvCf1qNwyw8sdPqNfQOrnRlAbWX/6jpbyqQDoKwX07kTCsbPjWCsmZr3
 CkY4dX2AhVvb5OFLY19AFujxW1zsrWF46OBoGQsrjW2Lkg7j8xg4nS3t1XKcSInvq2U550kcOSn
 D7tDIOUuRekJROoZK00DeycFdPum9wqcF+a2sdzq4VesIvD+iirnKhJzbVAKfxkbMcdi9YINc+4
 GQPMKVsVFgJqtNUSbXNT0WYlPdP2XauEHv4sth2YW/bD6oCrKBSm/Mdv9fLcmQJe8FRxQBNdZM2
 3IRJoJEHZbLMzCZYNXjetIEHN8JvTfIZ3VLG1GSPKaA3ehIn30NmV/FGAhDS6seZ9s3NLgNA0AB
 5CZgImlwBz9RTHaeYwtpwG/7PojrFdkcPalgZFsDBJeTXNLBJ9/Ifc9Q4uBv6b8aqqXSDVn8KF2
 /v8bWsS3TnG/aQczXSLmfknaiWyqgjGE0Gu8AIvoUAr8JikVmuGT4yzSD+r6F4v4ctyFTtWvR4Z
 ZU31GMPxriwXbmUOWg=
X-Google-Smtp-Source: AGHT+IE6MYxMFyMUbCtP8Ha/wpNjyqGuxt3nDUkWbYzSmaqQMwZgtjcaZaImMKewCU1M9OJwREzpjQ==
X-Received: by 2002:a05:6a20:9392:b0:389:7d32:c8ad with SMTP id
 adf61e73a8af0-3898f8fc437mr8118164637.34.1767941719632; 
 Thu, 08 Jan 2026 22:55:19 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:18 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PULL 03/34] hw/core/loader: Free the image file descriptor on error
Date: Fri,  9 Jan 2026 16:54:28 +1000
Message-ID: <20260109065459.19987-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Alistair Francis <alistair.francis@wdc.com>

Coverity: CID 1642764
Fixes: f62226f7dc4 ("hw/core/loader: improve error handling in image loading functions")
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <20251030015306.2279148-2-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/core/loader.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index b7638ccd72..3d2c1ae286 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -86,6 +86,7 @@ int64_t get_image_size(const char *filename, Error **errp)
 
     if (size < 0) {
         error_setg_errno(errp, errno, "lseek failure: %s", filename);
+        close(fd);
         return -1;
     }
 
-- 
2.52.0


