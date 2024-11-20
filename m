Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C24D6E2C9
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 07:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDf7g-0001yD-Mp; Wed, 20 Nov 2024 02:27:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7d-0001xV-9A
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tDf7b-00080C-O7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 02:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732087650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a9gy6dA9pZyQbx//Xc1zrgngdyVqqly2dozo3VuB5MA=;
 b=PUDZ6+2fgCcI5zbRhFWd+/l7lYNCvl/m3qdJJwk/7ji0sMDKOpktCQ3S7SXaktKlXuIZxr
 s08dph5+RlUrr+y8y9mrRuvEDFaUCWnTB69K0r7B/M8pBP4j44EOBOc1fGTj5qQzqJBxgx
 sdWFjbmy+VWtDuhLWiiS5MEo4CTFnDw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Ynmeb4u0OIq19Ng4IuaMPw-1; Wed, 20 Nov 2024 02:27:29 -0500
X-MC-Unique: Ynmeb4u0OIq19Ng4IuaMPw-1
X-Mimecast-MFC-AGG-ID: Ynmeb4u0OIq19Ng4IuaMPw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4314c6ca114so37949845e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 23:27:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732087647; x=1732692447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a9gy6dA9pZyQbx//Xc1zrgngdyVqqly2dozo3VuB5MA=;
 b=BPo+pcCrPgholzytyGIgiFB/vBFzBz/KCUrWCDXb9fNHwuKHhGWUHoiZBPHf5KgE01
 LxWu+iFdvA0vPwZQVxFoKh8FgGFQCd86Q+v68zI9Asx7jnT9JtsZKGirSoYtsCTpN/gG
 o2LcyAxgnkBjptmVuUdqUvfjvxp0ocRg8tnkzcxsIuZn+BeJaQPk9w0DZQDohyIIE4/9
 TI8hiHFElQmnDDdWmi2RDr2NePzlkAwPDzGOdtsF4nsc+0W3Jb1v1nslNz07ZHL9/Wiq
 lyuLYwI0B5lQW0J3oMWTrJHeOYLJ4ETLRd2mkjcgE99cv/8AtFGwL7fVKXB3+Dxko+mI
 oH4g==
X-Gm-Message-State: AOJu0YyMXUwSObp/jF32ZZp6MfwZZLyxhzD0dVx7SPJXutsqFFaWI74m
 C+LQYQ4UyVD7HhaUHK4QUfJg9Xhim3mlwIhrsGhzjlVHHRHnlxpsR6uDV5o7HR+D07IQwBHVXfO
 A9KY5iv+qVbUrc3wgERfH/y3SYoQ4n92XdL0qBcftga4ZV4miDBkmnbjPDBozFiC5bajTiCZ8Ox
 MVSbGbByKuJu+Y5aWm2t+nw9zHScesY48BoRS4
X-Received: by 2002:a05:600c:3d18:b0:431:58bc:ad5e with SMTP id
 5b1f17b1804b1-4334f025ee8mr11883175e9.28.1732087647495; 
 Tue, 19 Nov 2024 23:27:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmWqdBsaQnqwGJr8X6vac5RxZSoaXjkTdy5HeFad9rUVDvLop9QacpENgNvYauoDldsjVnA==
X-Received: by 2002:a05:600c:3d18:b0:431:58bc:ad5e with SMTP id
 5b1f17b1804b1-4334f025ee8mr11883065e9.28.1732087647165; 
 Tue, 19 Nov 2024 23:27:27 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b463ad1fsm9021245e9.38.2024.11.19.23.27.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 23:27:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Kamil=20Szcz=C4=99k?= <kamil@szczek.dev>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] hw/i386/pc: Remove vmport value assertion
Date: Wed, 20 Nov 2024 08:27:19 +0100
Message-ID: <20241120072723.103477-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120072723.103477-1-pbonzini@redhat.com>
References: <20241120072723.103477-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Kamil Szczęk <kamil@szczek.dev>

There is no need for this assertion here, as we only use vmport value
for equality/inequality checks. This was originally prompted by the
following Coverity report:
 >>> CID 1559533:  Integer handling issues (CONSTANT_EXPRESSION_RESULT)
 >>> "pcms->vmport >= 0" is always true regardless of the values of
 >>> its operands. This occurs as the logical first operand of "&&".

Signed-off-by: Kamil Szczęk <kamil@szczek.dev>
Reported-By: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/ZwF9ZexNs1h-uC0MrbkgGtMtdyLinROjVSmMNVzNftjGVWgOiuzdD1dSXEtzNH7OHbBFY6GVDYVFIDBgc3lhGqCOb7kaNZolSBkVyl3rNr4=@szczek.dev
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9147fecbdc..317aaca25a0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1228,7 +1228,6 @@ void pc_basic_device_init(struct PCMachineState *pcms,
         isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
     }
 
-    assert(pcms->vmport >= 0 && pcms->vmport < ON_OFF_AUTO__MAX);
     if (pcms->vmport == ON_OFF_AUTO_AUTO) {
         pcms->vmport = (xen_enabled() || !pcms->i8042_enabled)
             ? ON_OFF_AUTO_OFF : ON_OFF_AUTO_ON;
-- 
2.47.0


