Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6751CC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Yf8-0006mZ-Tt; Thu, 02 May 2024 11:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Yet-0006U5-OG
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2Yeq-0001UK-4f
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714664858;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VJ3m/HJK72m9vfOG1BSnVSNmbz6rIPXJb86ATxjL8cs=;
 b=axh48UuBfOWRyvsL9bxnyxG62ViU8atdUwygCxTNQGvkR8zaeF4Nmc7wF8TEOk1F9BnePp
 SU74GbASYp1r6dMdgmbXDVAJS6S5+8Km4pscdoibvbTI1MrVCahgzQjWDtoIxfld1+EH/1
 R8x/TWVfkh8ckHQwgPBf+upsugB1GUM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-p0GqViyLNqishjJatK3vZQ-1; Thu, 02 May 2024 11:47:37 -0400
X-MC-Unique: p0GqViyLNqishjJatK3vZQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-43a3632d56aso32859471cf.1
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:47:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714664856; x=1715269656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VJ3m/HJK72m9vfOG1BSnVSNmbz6rIPXJb86ATxjL8cs=;
 b=nRMGG3N4ZdrAZ9m7MZP8apaMQQnTdZMgTIf+KNZTyMXNwrAjJu3bfzrEUx4EEZOLv0
 5a6p5tjwOYLFOHERfhDfwO9ZQbQ6mylVKbKp0TBv+9imVw9dTsjeOJjcBFbBi6gaqwyj
 h+mdOyqIJL2kKmKTiIWJ25snbY27Qa71CCYYmNsZCi4VYl3+qslKLj3Jy0DV9oiyFBTP
 ukQLNfFWc+t7EbrYfDKkjWiO22oRPjF+3ZhcpRRbtVXGCUwh/kKEj6qq/BPRDSAWDIvk
 DbGlG8aNBQrfsgm/jXSGjbFGfO0pBrdUABHASYZIri+RHqyWxPX5JuLfaHqXB3MisyzA
 FGDA==
X-Gm-Message-State: AOJu0YxMoFi74dsRKwGmCN6zF+lmQLQ+JcpuXalsGiRRhAkZqaB4LBbu
 +QyrAV5rxvWrhdnxQye31kKfqE+3oieWzhUsd8FYMLcVr/yzIrUx2qmnja3V768sbolWo38+Exn
 AO5A8gnVGMeCnYtMI9DS4zYed5mDdIxoYkiZYesHQSZEJkjFusdTILF4Pi4NB26hvkZz+XL+AxC
 SSTPozOxWeoWhwMV6bh+sv2+Lcg/J8I2Syuw==
X-Received: by 2002:ac8:5e54:0:b0:437:cc82:9c00 with SMTP id
 i20-20020ac85e54000000b00437cc829c00mr6298565qtx.0.1714664851839; 
 Thu, 02 May 2024 08:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpNG7I3zbt4b5+aGJS4Nb9D+lj7/e1o69VPk2YKsD9WJ6+8UjtyIYPkfU6DGFKn7cajhtEmg==
X-Received: by 2002:ac8:5e54:0:b0:437:cc82:9c00 with SMTP id
 i20-20020ac85e54000000b00437cc829c00mr6298519qtx.0.1714664850886; 
 Thu, 02 May 2024 08:47:30 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 ex8-20020a05622a518800b0043a51b452a3sm579659qtb.20.2024.05.02.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:47:30 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH] hmp/migration: Fix documents for "migrate" command
Date: Thu,  2 May 2024 11:47:29 -0400
Message-ID: <20240502154729.370938-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.  Avoid
adding a Fixes to make life easier for the stable maintainer.

When at it, slightly cleanup the lines, move "detach/-d" to a separate
section rather than appending it at the end of the command description.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

Based-on: <20240430142737.29066-1-farosas@suse.de>
("[PATCH v3 0/6] migration removals & deprecations")
---
 hmp-commands.hx | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ebca2cdced..484a8a1c3a 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -918,8 +918,13 @@ ERST
 
 
 SRST
-``migrate [-d]`` *uri*
-  Migrate to *uri* (using -d to not wait for completion).
+``migrate [-d] [-r]`` *uri*
+  Migrate the current VM to *uri*.
+
+  ``-d``
+    Run this command asynchronously, so that the command doesn't wait for completion.
+  ``-r``
+    Resume a paused postcopy migration.
 ERST
 
     {
-- 
2.44.0


