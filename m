Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052A8C27C65
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFres-0005Xe-B1; Sat, 08 Jun 2024 04:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrep-0005J5-As
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFren-0001Yu-Ce
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717836156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnPxP++vBG+ZmU6itBpqXWD3WTi6urAUaIoEJnFoGfc=;
 b=hIXYgJ46cTgCsP2b3nNDwdg/DT7qVYHGnUHgonbebnOpoCFPOjE46HPwu1l9IzjWAgMVA7
 Q3+q26LvgJNmcao/wRMPp4E/35cZxe8LYyX6Ki4x3ZR2bk/2fkcNrvNxtXZwnGopFXzDyV
 8QBWvV4FaPiwZD+lb2xeg3ikf9+QIsk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-ntAH_1tsODG4h6L2nQqvVA-1; Sat, 08 Jun 2024 04:42:35 -0400
X-MC-Unique: ntAH_1tsODG4h6L2nQqvVA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a6f0d8b466dso8388666b.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717836153; x=1718440953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnPxP++vBG+ZmU6itBpqXWD3WTi6urAUaIoEJnFoGfc=;
 b=h4T43qIUoBmePGsbJBOxmYYhP+56rQQpypEtD5+uQzsx9Jtu/fK/IHfKJP1f7755Nd
 /rIXYp2DiByqDDZXZdB3vZbNFTXTzKVPVTJiJ2r00NbjYoGDoXnL+q+bUh+CW7hzSJDv
 FljD49KGTJcp20Ubo48X8nejhZhtBHEXzDQFBK4RQOC70nu/4GVHOKTcbrgLBGf7X8ee
 ynSBH2w68tDqcvG37pSUF+2GMpsKi+kTu4UnbcU8MJf8CEMeC9h/6CJ3PrvRn5dbhUYY
 ZV4pheLHHUzUgta+JFWkCJHvMKGIVrr63q74ZEdI+5o4l40qb0vUbajDLE9OiZzKzkMU
 sdDA==
X-Gm-Message-State: AOJu0YzQWhFX+497waaYRWAEkKqmRgS7ogwnGoGajpb4j2UEMDI3vdOq
 JicsOEZmH33zYhMQ6RzH9qjPGPb6Y5UiWHLKwtdLaAy2Re/hIr2M/QtsX7jipFXQ4gRA0j9l6Yr
 X3Yi5xW0t4WaW0x+6DyYkPmH+YI9xxRqo/hZrmiTDj9Zss8frFxp9VL37mVH9tZFrgt4iNv6UdM
 kI/XvBkXVUPg9xqSOa7FuVSZXRkR62SNwQ3HMH
X-Received: by 2002:a50:d4d2:0:b0:579:d673:4e67 with SMTP id
 4fb4d7f45d1cf-57c509a023emr3380251a12.26.1717836152985; 
 Sat, 08 Jun 2024 01:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAVsFMmDT00e3howiiP1j4Z1ZVL2kVvc16pNJotTyJx2mZUcCAJ6BLM6vffM4WrZ52mrkMaA==
X-Received: by 2002:a50:d4d2:0:b0:579:d673:4e67 with SMTP id
 4fb4d7f45d1cf-57c509a023emr3380243a12.26.1717836152658; 
 Sat, 08 Jun 2024 01:42:32 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57c67432820sm1291473a12.75.2024.06.08.01.42.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:42:30 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/25] target/i386: list instructions still in translate.c
Date: Sat,  8 Jun 2024 10:41:10 +0200
Message-ID: <20240608084113.2770363-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608084113.2770363-1-pbonzini@redhat.com>
References: <20240608084113.2770363-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index d75d242e552..7463cf87f1a 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -129,6 +129,24 @@
  *
  *    (^)  these are the two cases in which Intel and AMD disagree on the
  *         primary exception class
+ *
+ * Instructions still in translate.c
+ * ---------------------------------
+ * x87:
+ * 0xD8 - 0xDF
+ *
+ * privileged/system:
+ * 0x0F 0x00              group 6 (SLDT, STR, LLDT, LTR, VERR, VERW)
+ * 0x0F 0x01              group 7 (SGDT, SIDT, LGDT, LIDT, SMSW, LMSW, INVLPG,
+ *                                 MONITOR, MWAIT, CLAC, STAC, XGETBV, XSETBV,
+ *                                 SWAPGS, RDTSCP)
+ *
+ * MPX:
+ * 0x0F 0x1A              BNDLDX, BNDMOV, BNDCL, BNDCU
+ * 0x0F 0x1B              BNDSTX, BNDMOV, BNDMK, BNDCN
+
+ * integer ops - atomic:
+ * 0x0F 0xC7              group 9 (CMPXCHG8B/CMPXCHG16B; also RDRAND, RDSEED, RDPID)
  */
 
 #define X86_OP_NONE { 0 },
-- 
2.45.1


