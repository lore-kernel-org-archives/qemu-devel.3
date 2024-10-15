Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97A2D216AF
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 14:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0iNS-0006zP-OX; Tue, 15 Oct 2024 10:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNP-0006jB-M4
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0iNI-0003MN-Jc
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 10:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729001891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cpJdA83nBEhswvkhtf7QXYXBo8SHoSaSMr1r6sVgYmo=;
 b=BBuyZrZcuXjEKKH+n+MkzabdytoSh0T9wRToks/+Pdt+n6Yuxi7Nl0PMGZB5264J9bNPQ8
 jOeC0+ItRrBo0DieLn+8ilrJ+BD8ebbvo8IQ/JfIrz7L3kLaIaGyAzbUE0ti5bRzHo6mzL
 VzVB2+UGaIqCG4lVZj6TWz7dGOUhYLY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-G4HuPkm9O3iFsWSU4zDfBg-1; Tue, 15 Oct 2024 10:18:10 -0400
X-MC-Unique: G4HuPkm9O3iFsWSU4zDfBg-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-539fb5677c9so1812784e87.0
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 07:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001889; x=1729606689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cpJdA83nBEhswvkhtf7QXYXBo8SHoSaSMr1r6sVgYmo=;
 b=MVwU3r/vUK7uIZjvdJiXG8r+2ocNqk45ssaRzQXNBpxRTqhqC+PTXJpypMm7YsGHPG
 lELjhTDupEUTDaoAmFMWXKh12ROvmQrdRo4icqQ1JMxcp9UQfHN/I20sjLVO4XSYtreo
 WgSwZVocr24ayglZYeaBShfefKGQ1TavEOosqXt1KdkaTe0c5Ltkf9E3Y02qmxYKNLhh
 mWWhsrIZatsCNMD+s3jh2+z/uLZgYbJLqcyM6O0H2ep9RXkwTgwyg9hQnP2YasFT2X2r
 vvRfjnQZlbBdXKiVBsIiN1yJVlLuN/9WweG9TWrRe11L2BUUQG324G/Ibu1zfWjFVg2B
 UfYQ==
X-Gm-Message-State: AOJu0YxPYXSbCvwLXtuNiNMhwGvP3e2Gp9dNQP954OlHN4TS34/Frj2c
 LkOt/LLnVafH2mSeQTCQW+u7IP9fmwziTbl26wn6+bkXOAgnxWu5d4DV6QAwlgLSxHZYZopusWG
 FuS4FE9jS3CBEAQ5LjOP0V/tWN6s7uS47KPuhH6PXmLeA9TpltLtvYydN8oPRCTDJD8vabhDjj2
 J9bqmWIbunbQACi/eXJ5RtwUEELlg62r2p2BV4qCk=
X-Received: by 2002:a05:6512:1091:b0:539:f13c:e5ce with SMTP id
 2adb3069b0e04-53a03f77ea6mr386776e87.46.1729001887181; 
 Tue, 15 Oct 2024 07:18:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4z10lFHeI9bXOxGZUppvUsyPYkz54Qw4BgbmqCDzrlGGtNbfbLkXYk6eGVmJX8h1WBPd4Kw==
X-Received: by 2002:a05:6512:1091:b0:539:f13c:e5ce with SMTP id
 2adb3069b0e04-53a03f77ea6mr386689e87.46.1729001885131; 
 Tue, 15 Oct 2024 07:18:05 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7fc405a6sm1682317f8f.102.2024.10.15.07.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:18:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 15/25] target/i386: list instructions still in translate.c
Date: Tue, 15 Oct 2024 16:17:01 +0200
Message-ID: <20241015141711.528342-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015141711.528342-1-pbonzini@redhat.com>
References: <20241015141711.528342-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

Group them so that it is easier to figure out which two-byte opcodes to
tackle together.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index fe3bfed147a..487c376032f 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -129,6 +129,37 @@
  *
  *    (^)  these are the two cases in which Intel and AMD disagree on the
  *         primary exception class
+ *
+ * Instructions still in translate.c
+ * ---------------------------------
+ * Generation of TCG opcodes for almost all instructions is in emit.c.inc;
+ * this file interprets the prefixes and opcode bytes down to individual
+ * instruction mnemonics.  There is only a handful of opcodes still using
+ * a switch statement to decode modrm bits 3-5 and prefixes after decoding
+ * is complete; these are relics of the older x86 decoder and their code
+ * generation is performed in translate.c.
+ *
+ * These unconverted opcodes also perform their own effective address
+ * generation using the gen_lea_modrm() function.
+ *
+ * There is nothing particularly complicated about them; simply, they don't
+ * need any nasty hacks in the decoder, and they shouldn't get in the way
+ * of the implementation of new x86 instructions, so they are left alone
+ * for the time being.
+ *
+ * x87:
+ * 0xD8 - 0xDF
+ *
+ * privileged/system:
+ * 0x0F 0x00               group 6 (SLDT, STR, LLDT, LTR, VERR, VERW)
+ * 0x0F 0x01               group 7 (SGDT, SIDT, LGDT, LIDT, SMSW, LMSW, INVLPG,
+ *                                  MONITOR, MWAIT, CLAC, STAC, XGETBV, XSETBV,
+ *                                  SWAPGS, RDTSCP)
+ * 0x0F 0xC7 (reg operand) group 9 (RDRAND, RDSEED, RDPID)
+ *
+ * MPX:
+ * 0x0F 0x1A               BNDLDX, BNDMOV, BNDCL, BNDCU
+ * 0x0F 0x1B               BNDSTX, BNDMOV, BNDMK, BNDCN
  */
 
 #define X86_OP_NONE { 0 },
-- 
2.46.2


