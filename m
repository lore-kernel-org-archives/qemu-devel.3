Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546E9CF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swlHR-0000uZ-7M; Fri, 04 Oct 2024 12:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGu-0007mr-OV
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1swlGt-0006QY-22
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 12:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728059714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGZU21yTeRuoz0XDxPyGfwViDrODDgVqraasQLedj+o=;
 b=cafS5SpoMqTZVZwSlWSC4qyLDoY/BmQA0ph/69g9qy8ICyIcZwpPt1ar8RomyGq6TZYGVQ
 eQX7x3std3G2l67CNIJA5XIwAGyJxSe0BTgCM9Ds4ZcLxAdwOizAeCsYfwnJMAJgjM+MMU
 ElGf3Lsr4Rh/F3LNeawHLeiKFKf+y0s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-YUrbTIb9PaeJMO8rSPGScA-1; Fri, 04 Oct 2024 12:35:13 -0400
X-MC-Unique: YUrbTIb9PaeJMO8rSPGScA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd4ec04a1so1076053f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 09:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728059711; x=1728664511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGZU21yTeRuoz0XDxPyGfwViDrODDgVqraasQLedj+o=;
 b=HyFK/DN68SDhjOpnZnZN2wx34e3fb6h5nsjogxZvG9XuaW2QkPBnoDWAmGQYaczt44
 xo5Bc0KMeLEWpyqkb0CnnYQhMaXRXtiQb8VDSKX8BSmpLNR1IP1U+r16ELPqe6mpA20p
 ajcIw7+7aHcgI9bF4eqaxOCQlcNsaFW16zcyqvp+GQjA3drd1kg6xj94Rdsu0Ur1wHuL
 KfFoAHcK6BahcR1/VutSGbv4bsRv9v87MhitBInIRwN7qvz/m7cwqBG0Tlt4+n727+E+
 jpfGP9kCDQB9lNgh8BByYqYYKum0DwaO+pbK+uNhDoiswGCaw1UthEbYIMESI4vZduvv
 es+Q==
X-Gm-Message-State: AOJu0YzhfDdMekSwuf2YueBD+/hfJbqq3zuIGWloLeaSEu+88qO9Cqgt
 bpKpPGX3NM2xqyXy2HaX2lCBg2hVcslmeDbr/E+DOoWxlTzq3TqsxnkRivKz5l4ut1Tb4cA1KoG
 EAjrL6S8cFaQtoXuTp3Dr/qnXu20DcvPQFOG8MJapv9kSkCLA1eYRvjOKEmqUCmNPITN2GldO8s
 /2kAyJIsat+10l1RrEuByADf7u0W3XiZsVzHg3Lsg=
X-Received: by 2002:a05:600c:5493:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-42f85aee7d9mr24700715e9.26.1728059711110; 
 Fri, 04 Oct 2024 09:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2OpTpzhrBnn+iKZ4dnehm97fDNEQ6RqYTguZ1dNxwuEyxKfJ4s1PtJxHkMcgbV41XiSGvsA==
X-Received: by 2002:a05:600c:5493:b0:426:6308:e2f0 with SMTP id
 5b1f17b1804b1-42f85aee7d9mr24700525e9.26.1728059710724; 
 Fri, 04 Oct 2024 09:35:10 -0700 (PDT)
Received: from avogadro.local ([151.95.43.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86b1d5fesm19411035e9.24.2024.10.04.09.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 09:35:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/23] minikconf: print error entirely on stderr
Date: Fri,  4 Oct 2024 18:34:09 +0200
Message-ID: <20241004163415.951106-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241004163415.951106-1-pbonzini@redhat.com>
References: <20241004163415.951106-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.146,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

While debugging an invalid configuration, I noticed that the clauses debug
ends up on stderr but the header ("The following clauses were found..."
ends up on stdout.  This makes the contents of meson-logs/meson-log.txt
a bit confusing.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index bcd91015d34..6f7f43b2918 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -112,7 +112,7 @@ def has_value(self):
         def set_value(self, val, clause):
             self.clauses_for_var.append(clause)
             if self.has_value() and self.value != val:
-                print("The following clauses were found for " + self.name)
+                print("The following clauses were found for " + self.name, file=sys.stderr)
                 for i in self.clauses_for_var:
                     print("    " + str(i), file=sys.stderr)
                 raise KconfigDataError('contradiction between clauses when setting %s' % self)
-- 
2.46.1


