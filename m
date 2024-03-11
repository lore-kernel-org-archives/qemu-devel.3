Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D98C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeO7-0005B8-S1; Mon, 11 Mar 2024 08:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rjeO0-00057w-Jp
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:04:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rjeNu-0005I7-Sh
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710158641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=T2ijriOUscBduP8XMUrQHkASSXRp/fhKTcLofPcteR4=;
 b=emekGOscxjibD52foWwN96DGYURuNK+Wn9WH6UcC5pcSDJc3kD+jB9Jyv0t8/UsWWq8Z9j
 FTxQj2rE42vVQ2FFopfvDrpICeETv+jgjWF8JtrLRrbg266TRI5bkJH/0YfyrMyCMg9EeB
 r5psSO91Qdrx4W8wwx2HhXmnFWLHw4U=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-YgSeAdhdNN6vF7qp-vJRBQ-1; Mon, 11 Mar 2024 08:03:59 -0400
X-MC-Unique: YgSeAdhdNN6vF7qp-vJRBQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5c6245bc7caso2516346a12.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158638; x=1710763438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T2ijriOUscBduP8XMUrQHkASSXRp/fhKTcLofPcteR4=;
 b=fxm0BtKjKD5ln4gu2psnVM06mVOcHxwH1ttQbrYgojddmVqE8+hTfTgHOO5wRyEYso
 mqcvn1Fceh8j/Xrsbm4YdwDII83O6r0RJaFWPt1lAbA2HC2ikLPz4Lurd5V/WnR6Frvp
 257BCs7DmvUe3RsnFUBh1+k2gYPH7N3jglr7mwc4ztYAqZuZxaeFLQ5AL+CrohkTmCce
 h1MPEJuego9rwx9qe0nwiB64mzPF7L6quPK5+xqinHDhy/nhtFYMQp7PgCl4tSpI/tuH
 H+8eubcqb4OOruaV7wzSoKaX/S16PH6sqZNCzkxAHOtLSstj0EzeY/rlYqtQhi6IjKdK
 +28w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZSiisPDWxKFP/0XrQa8Ccvd6UHUHMT+kgSDEXjGkTJXHic1ddHV6RPyzlWBVAiCtWqgTNBf4AglqMdJZyJ03CVI58QAs=
X-Gm-Message-State: AOJu0YyojMn4kaqTy10hPAiJvEz2uTgNjTB7cABxEsT6Hzs8W6hyPGzE
 trLeplbDvZOAQ2fAKFnHrYyfPc+HdMKagPe4cAEO3mkJ7VkZZVU3M1fZwzCgl22yF58WiSKtxsW
 zKHvCxw0gBStkEf4L448OYALewHi+RGnLCM2SNe/21fT1wv3tq2eh
X-Received: by 2002:a05:6a20:8f0a:b0:1a1:6978:fd6f with SMTP id
 b10-20020a056a208f0a00b001a16978fd6fmr4036590pzk.5.1710158638505; 
 Mon, 11 Mar 2024 05:03:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5vHO//NowsbzBM2k7ZE97NHrDhttrlD6TvbMTL376G2ygrHB2t7wsHuHQL6cD62U3kYQt2g==
X-Received: by 2002:a05:6a20:8f0a:b0:1a1:6978:fd6f with SMTP id
 b10-20020a056a208f0a00b001a16978fd6fmr4036556pzk.5.1710158638099; 
 Mon, 11 Mar 2024 05:03:58 -0700 (PDT)
Received: from fc37-ani.redhat.com ([115.96.143.99])
 by smtp.googlemail.com with ESMTPSA id
 h7-20020a632107000000b005d8be4c125csm4040968pgh.80.2024.03.11.05.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 05:03:57 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH] docs: update copyright date to the year 2024
Date: Mon, 11 Mar 2024 17:33:46 +0530
Message-Id: <20240311120346.9596-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

We are already in the third month of 2024 but the copyright notices still refer
to 2023. Update the date to 2024 in documentation and help texts.

Cc: peter.maydell@linaro.org
Cc: qemu-trivial@nongnu.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 docs/conf.py              | 2 +-
 include/qemu/help-texts.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index 1b2afa241c..aae0304ac6 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -88,7 +88,7 @@
 
 # General information about the project.
 project = u'QEMU'
-copyright = u'2023, The QEMU Project Developers'
+copyright = u'2024, The QEMU Project Developers'
 author = u'The QEMU Project Developers'
 
 # The version info for the project you're documenting, acts as replacement for
diff --git a/include/qemu/help-texts.h b/include/qemu/help-texts.h
index d0359f82e0..353ab2ad8b 100644
--- a/include/qemu/help-texts.h
+++ b/include/qemu/help-texts.h
@@ -2,7 +2,7 @@
 #define QEMU_HELP_TEXTS_H
 
 /* Copyright string for -version arguments, About dialogs, etc */
-#define QEMU_COPYRIGHT "Copyright (c) 2003-2023 " \
+#define QEMU_COPYRIGHT "Copyright (c) 2003-2024 " \
     "Fabrice Bellard and the QEMU Project developers"
 
 /* Bug reporting information for --help arguments, About dialogs, etc */
-- 
2.39.2


