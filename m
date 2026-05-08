Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C118CD3445
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 15:25:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLN4I-0000tO-Ua; Fri, 08 May 2026 11:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN4A-0000qn-Q4
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:39 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wLN49-0005Qz-3j
 for qemu-devel@nongnu.org; Fri, 08 May 2026 11:24:38 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso1289516f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 08:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778253875; x=1778858675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ya8REFq1GNiRFitCgeUY5GjcL4xv8AyqiH5kxj8IAQw=;
 b=Ke/lqZ3jRWt21ZRnElSXQ14F73h75wbx0PvVxZtTgBtCdpWaXAADMG1fZYQBuvmiIf
 lMC8qeoQrWQWkBDperx9kAx0xwe75DlzpCqlGxVcFlpP2aGqjfagZS554xh7KjDtsZq2
 SiE4pLRHTGLWQK+tL8MLEfdn22FCo2Rpa3AmR+3N0mSNJ6eBFJOMSKPXchzJVVhoERp1
 RbIvpYquxSXXN4lC1apvc+dpw3YjoxnHljTuy+fMy4xdLQr+Y6dn4MdsOwKJbymSVVQq
 kvm9M+gPjf90WcNVp3r3o66qVPQX4tawZMGy5p4D91DovG2XkLyj5VOooIG5FatF38Y0
 GZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778253875; x=1778858675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ya8REFq1GNiRFitCgeUY5GjcL4xv8AyqiH5kxj8IAQw=;
 b=IlI8SD4iBAg+OcoK6lg3nTzlKM60LtWsKz05M+fdqaP8Vggiqr6SYSp/B/5DIEINTG
 VvplYwQVVXEdefgL2gapezwZOI+DTG8rVCE+wkLg09wadXIWNYoFJUjyfIgKZLiHgcN9
 BPB4peQx9GUyKddMuRIl0oKN7b8zA0QkB4EIwhhxzC5ueOCA7jXq0DD+ikucei/dYPHe
 G+GV4IPaSmjpl6MxZ4afEFg6B7pNJfaksG7cZu+tAaxNREqyDIUhQNwlKf6fw7i3FLve
 TPH8gbUDD7kXxGCEkrahsyhtAhVf7QlCfPjzdLhbEeCpj4wXuAMSOGxgp6URcUMIWGbF
 u0hA==
X-Gm-Message-State: AOJu0Yw2EUzIKPNYOeJmuEhcfJ6gXIpINvhrpOV6q3iRTwqN7cyJRGax
 MUeDQxe5MaMOMtN6tSyanC11vTEb9n7tc5kLBrUWKj5AXmpH32oVjralSFyv/x68xUefGXevSVN
 LQm6D
X-Gm-Gg: Acq92OEwcd47rceSCm9DqRp+MZh1KAgRCDqE/9lO30KD7qNK3yoxWdFZ/e5XiHwS1Ok
 0+L3tcAgjC4E/DplCg7Z3sbv4gK/S1EWA/uMGSe9TVBH/I2wtyWCwxFhUbMMk5kROaCBoAd0kaj
 79eejsriJ+NBbXS120hx4ku3aO14ur1MQUHaQVVRM5tJsg2UHWWXkY4AuWTtNWWOuAplKPO9V/+
 zjsztXOpRZKZZA0/PlWEEqEznscl8BjSvIUREL7Ij+SE30cY3MN/BrGFZRzbuJoT+staXLBh02R
 fQRXVGGGwo2GaC67aLOguHxwsB1RysmXSLrfXBvtlCggJQxOOHlB0d1YN4zg1kOyRXM53FdTat3
 U5XZKh0/pmG2GkrvX0Z5cTeAZuoQYUbHcLjNxWQPP3qJUdxaZeyLoX1pGtsQkqK4/gDwkbfrrRE
 SXDNCY2d0AiUDBSjdXzPaLYldHj/MCYxWSe0Y6d3eC9qTDBLjZXRphfulZflYAmwFWpGMrRjEA0
 rF+4umVKvcyfGoR7D6kJi3KxaIuYbw=
X-Received: by 2002:a5d:584e:0:b0:44b:8fb6:9a2e with SMTP id
 ffacd0b85a97d-4515ce1ca99mr19529559f8f.20.1778253875500; 
 Fri, 08 May 2026 08:24:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548ec6c221sm4940453f8f.13.2026.05.08.08.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 08:24:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5/9] tools: Move qemu-io sources to tools/ directory
Date: Fri,  8 May 2026 16:24:24 +0100
Message-ID: <20260508152428.2648560-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508152428.2648560-1-peter.maydell@linaro.org>
References: <20260508152428.2648560-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the qemu-io sources into the tools/ subdirectory.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                            | 2 +-
 meson.build                            | 4 ++--
 qemu-io-cmds.c => tools/qemu-io-cmds.c | 0
 qemu-io.c => tools/qemu-io.c           | 0
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename qemu-io-cmds.c => tools/qemu-io-cmds.c (100%)
 rename qemu-io.c => tools/qemu-io.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ef9655c94..0f89bf2642 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3108,7 +3108,7 @@ F: include/block/
 F: include/system/block-*.h
 F: tools/qemu-img*
 F: docs/tools/qemu-img.rst
-F: qemu-io*
+F: tools/qemu-io*
 F: tests/qemu-iotests/
 F: util/qemu-progress.c
 F: qobject/block-qdict.c
diff --git a/meson.build b/meson.build
index 5d34ea39ed..1f34ed71ab 100644
--- a/meson.build
+++ b/meson.build
@@ -3810,7 +3810,7 @@ if have_block
     'block.c',
     'blockjob.c',
     'job.c',
-    'qemu-io-cmds.c',
+    'tools/qemu-io-cmds.c',
   ))
   if config_host_data.get('CONFIG_REPLICATION')
     block_ss.add(files('replication.c'))
@@ -4526,7 +4526,7 @@ if have_tools
   qemu_img = executable('qemu-img', [files('tools/qemu-img.c'), hxdep],
              link_args: tools_link_args, link_depends: block_syms,
              dependencies: [authz, block, crypto, io, qom, qemuutil], install: true)
-  qemu_io = executable('qemu-io', files('qemu-io.c'),
+  qemu_io = executable('qemu-io', files('tools/qemu-io.c'),
              link_args: tools_link_args, link_depends: block_syms,
              dependencies: [block, qemuutil], install: true)
   qemu_nbd = executable('qemu-nbd', files('qemu-nbd.c'),
diff --git a/qemu-io-cmds.c b/tools/qemu-io-cmds.c
similarity index 100%
rename from qemu-io-cmds.c
rename to tools/qemu-io-cmds.c
diff --git a/qemu-io.c b/tools/qemu-io.c
similarity index 100%
rename from qemu-io.c
rename to tools/qemu-io.c
-- 
2.43.0


