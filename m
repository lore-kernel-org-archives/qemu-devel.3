Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29147C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 16:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAXem-00060c-Bi; Fri, 24 May 2024 12:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXel-00060D-0I
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAXeX-0006wH-AG
 for qemu-devel@nongnu.org; Fri, 24 May 2024 12:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716567619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k9B/mifen37RkDdPX/cKKRcV68jn85LxP2cbyY6xOFI=;
 b=Uco4wlxSBy1mqB6LASPl2vEowJ1L3yPi4w+i89KvxzcqaqY0orukMVkvDaoDv0M3RRvmtg
 whImTo5n0PR3APvRqbo1qF6VVsOU0RAu5zeEQnczVWuRW01riKnA7Tq+jgRErr6Q7HLtb9
 LpPDO/13zEMRnM1Zk8BbBmvZxOlnANo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-uxyIrGcWNBW5k-EX7Nn_jw-1; Fri, 24 May 2024 12:20:17 -0400
X-MC-Unique: uxyIrGcWNBW5k-EX7Nn_jw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-529a2d60e56so277885e87.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 09:20:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567615; x=1717172415;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k9B/mifen37RkDdPX/cKKRcV68jn85LxP2cbyY6xOFI=;
 b=e/emFEvP4vwkrUhY05SqwWRWGry7wvujkiviQFvxdIcdbKdQQQ1b8+X5A8ZTudahBh
 oyaJzwirvSkxwnqNzCdSrIp0NOWdotXxCqDS/H4jUf0jKXbJ7bnvoyVMRFyoYnSsirvF
 kXBwXOau2vTEgzOgaclVAh3Wfcp3ribKNsbJOW2zcJNGTtleyjeI5GOkFGJh2dJwOOcx
 8bWQ/+ocd/k9AEVrv1xlNI+7K7iSQMIkw0mLapM4nH7ptaB0pF9SZAMKE3hiQMHHV80m
 dkgz9YlnYeOeE9uTQ7/6A3FPdkKEv3brR61NOWrgeWvL13ZPrGisM0Th8sdgh69ZS0Ax
 HPbA==
X-Gm-Message-State: AOJu0YxbSDeAlMk9E1kMx27jiQbTA8wepSBHOUThTvvZwruGKEyN4fKw
 B/NpdcbryUy7zcgSUbQ0OrkQw32E8gEHWfYjiuXYSAAb01lQ2hSvx1Tv99m+Tn9pwgaF78gmhXm
 HKKlUScJ57UE/hLeiaLSeImXk57Z6izzSW0FK671i/CeM1EwB4o4mBzOk8HOEQf/HI4o3ldEirx
 nahLiQuImljlkg6ziKvebx0JjcgO6dEqm35pLI
X-Received: by 2002:a05:6512:3d29:b0:523:70db:7a0f with SMTP id
 2adb3069b0e04-529644ec14dmr2490303e87.8.1716567615510; 
 Fri, 24 May 2024 09:20:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmIQu0q+/jhv/Dk10dmXyCJY752VY4bHYXd6vHa12WuY3kDr28hiiMUEa1R9CZlyylQ3z9ag==
X-Received: by 2002:a05:6512:3d29:b0:523:70db:7a0f with SMTP id
 2adb3069b0e04-529644ec14dmr2490287e87.8.1716567615147; 
 Fri, 24 May 2024 09:20:15 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5296e887c03sm204823e87.34.2024.05.24.09.20.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:20:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/5] tcg: include dependencies in static_library()
Date: Fri, 24 May 2024 18:20:03 +0200
Message-ID: <20240524162006.1271778-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524162006.1271778-1-pbonzini@redhat.com>
References: <20240524162006.1271778-1-pbonzini@redhat.com>
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


