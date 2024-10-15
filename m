Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD446D216A2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 13:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0hRS-00028O-9p; Tue, 15 Oct 2024 09:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRP-00027V-RB
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t0hRN-0001Mq-3h
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 09:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728998300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B1nRIJjPfPQ6iCRHb6OEJ4R5L0lI8jOfA213Zh847Ko=;
 b=VI5XiTQAP2fdQM/Bdnh9AqfGvLFrOm7pw5lD2m9sBruqlMqItQU1P6g7zDqzzWYEzbjjHT
 Vah/FTDKgukINLwh0FV+34pk+R721HwgCSL9+WgcCekDn2egCdxrP5nXaMuZa8MnIlWmnb
 D/P33T/2zts7ubDLsI5vSSlIhHMa+0E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-comyW0wQPtqIfJ9C8BHQAA-1; Tue, 15 Oct 2024 09:18:17 -0400
X-MC-Unique: comyW0wQPtqIfJ9C8BHQAA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43113dab986so47355335e9.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 06:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728998296; x=1729603096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B1nRIJjPfPQ6iCRHb6OEJ4R5L0lI8jOfA213Zh847Ko=;
 b=HvzJ8a+v7qtyjrNs1Fz44QvR3E1W0kNUAlyAtGoVKeYbS4M0Gl6DdRqTuk8/PbwzQA
 trq0SEB3ykko8Y67P4NZFznjlk5LwqLfjxjWCo6zWqP4D4yEeGbOjOann2cX7wbKS0mL
 QHRU993Fj2qjxS3peqsJfM6OJgZhSnJ3b9iXuW7M8Abp5l8EqBXZdpPRrNFNoolxmf8T
 DWivHu9zr7lzcLo4xOdijttCXRzajhKilhXw8oXyDfRK+o8YmjZcLuYnRlwuF4xD4UfE
 3G00Q/xDvapF4bmDEpklLfX6x6Dp8TNb0wRGGG6Xa1/iCupeKPh1xcPAGvqEE3vJpDCg
 X5dA==
X-Gm-Message-State: AOJu0YwhT/EYdquQQzHgP+9HGem+V4V7qAqOJbxCpZXnXgtTD9jKppxw
 +VE+8nHGiOzxyjQ9dLKH2HUbYEgs8DpTutP17+T/eH5K7lDM5JXN3A0irpvFVvqreoshG/J11kd
 Evn07AKownaRyS1D//dET/GnAOeTZRsCncQO+LfLOawOnuauz2yFLB/1TOquN+M0zEOXkZb8vQc
 Xg12+unKbe5hhpAYbRWyA2y1F9UgrbYGQTv4+5840=
X-Received: by 2002:a05:600c:3ba1:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-431255e052amr143334755e9.16.1728998296355; 
 Tue, 15 Oct 2024 06:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEx2tOw1Hd09qk4rvu2lR7WPCt0QMOWXGK0FQW617AJ+IZzf/t88eLzSztqQ0zCtm5ZpsAFYA==
X-Received: by 2002:a05:600c:3ba1:b0:42c:c401:6d6f with SMTP id
 5b1f17b1804b1-431255e052amr143334335e9.16.1728998295887; 
 Tue, 15 Oct 2024 06:18:15 -0700 (PDT)
Received: from avogadro.local ([151.95.144.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56eab2sm17749705e9.26.2024.10.15.06.18.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 06:18:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/16] rust: allow version 1.63.0 of rustc
Date: Tue, 15 Oct 2024 15:17:30 +0200
Message-ID: <20241015131735.518771-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015131735.518771-1-pbonzini@redhat.com>
References: <20241015131735.518771-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

All constructs introduced by newer versions of Rust have been removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 175b8d82228..0e279d245b4 100644
--- a/meson.build
+++ b/meson.build
@@ -76,11 +76,11 @@ if not get_option('rust').disabled() and add_languages(=
'rust', required: get_opt
     and add_languages('rust', required: get_option('rust'), native: true)
   rustc =3D meson.get_compiler('rust')
   have_rust =3D true
-  if rustc.version().version_compare('<1.80.0')
+  if rustc.version().version_compare('<1.63.0')
     if get_option('rust').enabled()
-      error('rustc version ' + rustc.version() + ' is unsupported: Please =
upgrade to at least 1.80.0')
+      error('rustc version ' + rustc.version() + ' is unsupported: Please =
upgrade to at least 1.63.0')
     else
-      warning('rustc version ' + rustc.version() + ' is unsupported: Disab=
ling Rust compilation. Please upgrade to at least 1.80.0 to use Rust.')
+      warning('rustc version ' + rustc.version() + ' is unsupported: Disab=
ling Rust compilation. Please upgrade to at least 1.63.0 to use Rust.')
       have_rust =3D false
     endif
   endif
--=20
2.46.2


