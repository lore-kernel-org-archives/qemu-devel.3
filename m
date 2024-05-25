Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D4A8C25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApfi-0003WV-NF; Sat, 25 May 2024 07:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfg-0003PK-Ur
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApff-0004BS-Fg
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9B/mifen37RkDdPX/cKKRcV68jn85LxP2cbyY6xOFI=;
 b=YPV8XdNgqgGG0Gd0FKLalhEgQJnugE2U2qEddqDb2XwtNoAUc660MrDuuwKMwp2q78TAG+
 DQN4YLpVIG2xvsDoIO6iCgysAf6V4ryTWNTPVSm2Uq8mG/H1+pz1mikWhAorcAXV8pNG5S
 zlA9FmxQLjea2jEO3MH8uIdmr7seegc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-vzhl6wPBMCWcxVTGljyMww-1; Sat, 25 May 2024 07:34:41 -0400
X-MC-Unique: vzhl6wPBMCWcxVTGljyMww-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6266ffd2fcso76780666b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636880; x=1717241680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9B/mifen37RkDdPX/cKKRcV68jn85LxP2cbyY6xOFI=;
 b=fsQPG+LXESysr7BhK1Jp7Eo+CEpj1VB8m8wqlZmh9kIc7zmAv7rQcygNrPncDdPOjX
 HOCKJO2y76P/Z4yzr700j4aRgoocEHOBFzjR6S/0pkPzXTLjR29R3rwaI8uryu9ofpY9
 8Pvg/nsj7sFUabcJ5o3uCVxmBdco/U7t1QH3oeeqWNFgs4QzU42YyoociKp/leD00MUY
 1ugfC+IVI7DonW4eLP0dQO+NDF3vjgjxXyhO0Odm+OQM3Y2lB81s09YEzgrP3w94/8uZ
 vCKquC9wxFX++exHB+MPAC+I3RUqpcz5MhLPw9UKHP39umk2FNfuaP7nIdAzZdjCTEFx
 VwlQ==
X-Gm-Message-State: AOJu0YzTVaibYUQ80axDMN8ZhYB41pO5kRtc1M1cEt/WwEEvNL/d6cWG
 zkq/kxJUwSUdmLR/a1vOZR29RnjKNO7nzoH6u40fGAV+/dRqja1Ijo/RSudEUe9Llp5r38v/85Q
 eyTCXm3AtJ018GtoLD2OTkIoX/Sot4nEpJ5TYPsA3HR3ebRF2VcLE5pgwawn2lC9s5xAIn56H35
 L5KoehMi26qolkCPo4O22fFvE49NF2FJ6erfKF
X-Received: by 2002:a17:906:4bd8:b0:a59:aae5:b0bc with SMTP id
 a640c23a62f3a-a62646d7f53mr295625066b.42.1716636879906; 
 Sat, 25 May 2024 04:34:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsCn+IOtYJifazZo7o49GJuGWVIT+Af3gjJR/6CMDuUbB3fmFUcLa887X/kCSUX+tKq/22qw==
X-Received: by 2002:a17:906:4bd8:b0:a59:aae5:b0bc with SMTP id
 a640c23a62f3a-a62646d7f53mr295624666b.42.1716636879558; 
 Sat, 25 May 2024 04:34:39 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cda1c32sm243947366b.190.2024.05.25.04.34.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 22/24] tcg: include dependencies in static_library()
Date: Sat, 25 May 2024 13:33:30 +0200
Message-ID: <20240525113332.1404158-23-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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

This ensures that for example libffi can be reached even if it is not
in /usr/include.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tcg/meson.build | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/meson.build b/tcg/meson.build
index 8251589fd4e..ffbe754d8b3 100644
--- a/tcg/meson.build
+++ b/tcg/meson.build
@@ -32,19 +32,19 @@ tcg_ss = tcg_ss.apply({})
 libtcg_user = static_library('tcg_user',
                              tcg_ss.sources() + genh,
                              name_suffix: 'fa',
+                             dependencies: tcg_ss.dependencies(),
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
-tcg_user = declare_dependency(link_with: libtcg_user,
-                              dependencies: tcg_ss.dependencies())
+tcg_user = declare_dependency(link_with: libtcg_user)
 user_ss.add(tcg_user)
 
 libtcg_system = static_library('tcg_system',
                                 tcg_ss.sources() + genh,
                                 name_suffix: 'fa',
+                                dependencies: tcg_ss.dependencies(),
                                 c_args: '-DCONFIG_SOFTMMU',
                                 build_by_default: false)
 
-tcg_system = declare_dependency(link_with: libtcg_system,
-                                 dependencies: tcg_ss.dependencies())
+tcg_system = declare_dependency(link_with: libtcg_system)
 system_ss.add(tcg_system)
-- 
2.45.1


