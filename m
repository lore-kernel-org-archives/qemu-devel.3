Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 220CDC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 14:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2u6Q-0006ju-Ld; Fri, 03 May 2024 10:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2u6O-0006jW-Uh
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2u6N-0000jB-D4
 for qemu-devel@nongnu.org; Fri, 03 May 2024 10:41:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714747290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=1lgRhC17EQyi1s/6qiW8IKWsPRbKRSeSDhd+BWwKf4I=;
 b=IjZHXVDLcDakDzNj6PelqLG51wz2QRseztMYqG4SCf5cE4noNFTG7v/f9q8qxD9NtYFrl0
 E2iyUUm4a58UdbiI8dCtH5jDWTCcSeMo0MzB1HuQwWdioYsJe0cAv071YyYheD08HRHM7N
 YBahGay8E0AbbJTPUDMldFET6EooQzA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Xcr9oy87OYGTIngbM7LLtg-1; Fri, 03 May 2024 10:41:29 -0400
X-MC-Unique: Xcr9oy87OYGTIngbM7LLtg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6a0e5402962so12114466d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 07:41:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714747289; x=1715352089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1lgRhC17EQyi1s/6qiW8IKWsPRbKRSeSDhd+BWwKf4I=;
 b=EQVI082So8CvJ+Dv6PYvpRTwgZdgx+gV+nC4gbBbuM7M8gwYLx3ZmXs0AvaKVKAfGO
 s0ou6mu4+8iudAmKLkamK+LHM50uIIWTqBphpL/lgcnQNyqjC1KyP9ChwjueyaYnA3FI
 WEUxkL+yJtPHtI1hqmFv1C2DSr+OfG6hjTIobr/6lDzGGEgEPkw8/IlGVnbNHi2mmOam
 ISCOiZZn/wQW6l9YuBKfUQWZbqBxBfFom17CI/6ibpO2TU679jBBse166g0AfaGRp6IO
 hqujWaF4JG2NaZRz0rH/OzJxb10muc0ewFnCxCqFJs4TmNN31aCj2eSnytt3Kw+ho1uh
 6zRA==
X-Gm-Message-State: AOJu0YzP3irvDfgU1lYBZxMjFb52H/KqyoC08XKyOdspzgYk7cQTrv3Y
 By+P9ISMGZL47TePdbDJMmpuPcqMflw28H29Byak2matmCOCseeSM/afQxv/ZCcfs8G9ht3lhSB
 px3HeIdo2aKeZwQ/DpJ0EoRqdGc5zlfIIfrNKhfhwKf9HYpn+Ku7mMBp8DG4vnn65DXmGsWPHAd
 bTWxj0zw7I+OMwDKO7fKcyBNL4Zig2Vh2GzQ==
X-Received: by 2002:ac8:7d13:0:b0:439:9377:3aed with SMTP id
 g19-20020ac87d13000000b0043993773aedmr2873662qtb.3.1714747288557; 
 Fri, 03 May 2024 07:41:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETlwGkJjDrTxrjg39kLCfpyl0TkRLFk7NJHtoFNpMqE5BHSK/sBQqRC3huDNwOFexUyj8AwQ==
X-Received: by 2002:ac8:7d13:0:b0:439:9377:3aed with SMTP id
 g19-20020ac87d13000000b0043993773aedmr2873602qtb.3.1714747287665; 
 Fri, 03 May 2024 07:41:27 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cj14-20020a05622a258e00b0043a5edf024dsm1646254qtb.35.2024.05.03.07.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 07:41:27 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2] hmp/migration: Fix "migrate" command's documentation
Date: Fri,  3 May 2024 10:41:26 -0400
Message-ID: <20240503144126.396597-1-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

Peter missed the Sphinx HMP document for the "resume/-r" flag in commit
7a4da28b26 ("qmp: hmp: add migrate "resume" option").  Add it.

When at it, slightly cleanup the lines around:

  - Move "detach/-d" to a separate section rather than appending it at the
  end of the command description. Add a hint for how to query the migration
  results in detached mode.

  - Add "postcopy" keyword to "resume/-r" help messages, as it only applies
  to postcopy.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Fabiano Rosas <farosas@suse.de>
Fixes: 7a4da28b26 ("qmp: hmp: add migrate "resume" option")
Reported-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
Based-on: <20240430142737.29066-1-farosas@suse.de>
("[PATCH v3 0/6] migration removals & deprecations")
---
 hmp-commands.hx | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index ebca2cdced..06746f0afc 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -912,14 +912,20 @@ ERST
         .args_type  = "detach:-d,resume:-r,uri:s",
         .params     = "[-d] [-r] uri",
         .help       = "migrate to URI (using -d to not wait for completion)"
-		      "\n\t\t\t -r to resume a paused migration",
+		      "\n\t\t\t -r to resume a paused postcopy migration",
         .cmd        = hmp_migrate,
     },
 
 
 SRST
-``migrate [-d]`` *uri*
-  Migrate to *uri* (using -d to not wait for completion).
+``migrate [-d] [-r]`` *uri*
+  Migrate the VM to *uri*.
+
+  ``-d``
+    Start the migration process, but do not wait for its completion.  To
+    query an ongoing migration process, use "info migrate".
+  ``-r``
+    Resume a paused postcopy migration.
 ERST
 
     {
-- 
2.44.0


