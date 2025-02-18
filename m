Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F875C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 08:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIbS-0005Ma-Tt; Tue, 18 Feb 2025 03:05:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIbQ-0005Lx-Ru
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:05:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tkIbK-0007j3-Mh
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 03:05:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739865904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rRHv0VAGXKvzhgsoXOj/6ynjCFigFeP4/lBHiQ/K8J0=;
 b=PImpy4RqRhE2gnXj3pY0dRtgYWJJYAgfZnWoWxta66OqMHUkkuBokM+6YM4O+Mx1iK/J08
 17VfkKdj9zTByLaM6zXhVQVzY3tkKpxN/jEZMHzy2feApEFPq4rY4pnaIDwkPQGeXT/ShO
 eWCXCY85EzQof1BdYQtJgJXGUBI1ApU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-UaMaoc1XNbu8hIycntdA5Q-1; Tue, 18 Feb 2025 03:05:02 -0500
X-MC-Unique: UaMaoc1XNbu8hIycntdA5Q-1
X-Mimecast-MFC-AGG-ID: UaMaoc1XNbu8hIycntdA5Q_1739865901
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38f4e3e9c70so510134f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 00:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739865900; x=1740470700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rRHv0VAGXKvzhgsoXOj/6ynjCFigFeP4/lBHiQ/K8J0=;
 b=YH6a+DMgMBCShbMAyeDP+FKJjRONko3ZhK4LpBV5rDHal4MgFN6yHLauY+3Ok6Ca9x
 Pfe3T+Tr3gdxOp0EyaNFb7go/KuCqzZzM0XUytVzUw2qHC9wPahiXFR5lyj46OdXkLhV
 Zswhtxt8hIJkoIXrJEBRGMlbqE+iaR0CAHoX3uuYlDWQiFzT+6SQv8HANv+4sTG+XSCe
 eovyVDjIl7igdxk2cPPKi4SPlFzdo8hT0EEYAOlpBAsxQ+kflCg8ctd+1kotJte9PF/e
 h46AMYJsAuuOv9Cvngn/bLoV7y/Z1dhJfK3w/ee6Ur1L0Or1UkyJ+UlBpj30j2JhSJAO
 BzZA==
X-Gm-Message-State: AOJu0YwlvU+XqytzbKUKo9r1Zgm84zSSr1bp5a0xsFiqlG8BMRnjNnfo
 7Lzk6dT+Lv09QMM712sHlPZn8G8SLveMqwzPnEUyd5Yq2o1vpIKy1hRbsZcg3/DZAL7185wULlc
 zHt2YW4na1pAG7yShNacPj9vzmiJaUh4FV2K+Ahf08WUSQVNc6tSfLCxjANKYVt6GLa22gy/dLt
 wsb0l8gLOxvXUwX6ligz7v8KkopXNQ9gkGiuArmzc=
X-Gm-Gg: ASbGncsGP/kjq31cOf/dOq/o8pgrF/f3FmMvf17GtVTC37Mt/xSlZNtLbIO2JpTEHYd
 my63GIfLuuH7Dyo1K1nVTkVuICBi9m/4zhOi1hvU9H/yRAitBTfVomCDk4d02aiJnumcdtx6qfE
 LfaHN1FFQ9xjURNBOtZCYls2+pl9xGp/kTqM9Nf5oZMwZc1ohKwVerNncBk95Ltk1pRClHkPsas
 /HJqdizSq/LYN2hbSIugU9xeZE2Oc9GdrX3bTynvgCgmJHyuVBIK/jYUWY7eSHM+26TWaLu/Q52
 YYgy1r3TBbw=
X-Received: by 2002:a05:6000:71c:b0:38f:2b64:5327 with SMTP id
 ffacd0b85a97d-38f2b6457ccmr12524038f8f.24.1739865900561; 
 Tue, 18 Feb 2025 00:05:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExdTXtJsJlWpXL8sWoHyZsgMcjfgiDRw9KCtr6MC9mkHmwCs3Q1dxFw7+DOnfgc7MecXG+gw==
X-Received: by 2002:a05:6000:71c:b0:38f:2b64:5327 with SMTP id
 ffacd0b85a97d-38f2b6457ccmr12524011f8f.24.1739865900115; 
 Tue, 18 Feb 2025 00:05:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.122.109])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b4118sm14650555f8f.18.2025.02.18.00.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 00:04:59 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH] docs: rust: fix typos
Date: Tue, 18 Feb 2025 09:04:58 +0100
Message-ID: <20250218080458.426402-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/rust.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/rust.rst b/docs/devel/rust.rst
index 90958e5a306..7964e1fd327 100644
--- a/docs/devel/rust.rst
+++ b/docs/devel/rust.rst
@@ -293,7 +293,7 @@ to a Rust mutable reference, and use a shared reference instead.  Rust code
 will then have to use QEMU's ``BqlRefCell`` and ``BqlCell`` type, which
 enforce that locking rules for the "Big QEMU Lock" are respected.  These cell
 types are also known to the ``vmstate`` crate, which is able to "look inside"
-them when building an in-memory representation of a ``struct``s layout.
+them when building an in-memory representation of a ``struct``'s layout.
 Note that the same is not true of a ``RefCell`` or ``Mutex``.
 
 In the future, similar cell types might also be provided for ``AioContext``-based
@@ -349,7 +349,7 @@ Writing procedural macros
 '''''''''''''''''''''''''
 
 By conventions, procedural macros are split in two functions, one
-returning ``Result<proc_macro2::TokenStream, MacroError>` with the body of
+returning ``Result<proc_macro2::TokenStream, MacroError>`` with the body of
 the procedural macro, and the second returning ``proc_macro::TokenStream``
 which is the actual procedural macro.  The former's name is the same as
 the latter with the ``_or_error`` suffix.  The code for the latter is more
-- 
2.48.1


