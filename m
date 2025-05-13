Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F76C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:10:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExon-00060M-Vp; Tue, 13 May 2025 18:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExod-0005yV-2F
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExob-0006GE-JM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747174172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BZrWDD7DA8j5qiqOylSQQfuIsOy+c9WRkCmwViTrZB4=;
 b=dB6Av1msoR3paOulDUhieGYXpYJdeAN7RHXsR2xBTUxRzlGtYx12BDKanZ8s9uZfXZxfFj
 nIHQEauq+O5MhHboqekOrg8eRO/cNLr9+rv86enm9XuLLTPEJoE3ll5S5xjWd+uKE+I03u
 CRluizMy45UjyvLRcVKH6qXB331xjTs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-HnMVonrSNR6C5pTUhevfLw-1; Tue, 13 May 2025 18:09:31 -0400
X-MC-Unique: HnMVonrSNR6C5pTUhevfLw-1
X-Mimecast-MFC-AGG-ID: HnMVonrSNR6C5pTUhevfLw_1747174171
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f6ef385d1bso37478106d6.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747174170; x=1747778970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BZrWDD7DA8j5qiqOylSQQfuIsOy+c9WRkCmwViTrZB4=;
 b=qhF43EV5xVOBzkRdYBdPb+9GAL3GpdRtOBRHvJgLSUkqHkywx56UXnTKtaDgSavpd5
 r/J/iDHL0JvnruJeKFoOOzSPfJxJqxGDy4o8NmVkTRgHckIEeoLBKJoCtL+JaRNp+5Da
 Fz6KiE+I995F53ZyJXsVQyXu+wt7pRS+NKmzwgyoo9YnZcnrIm9Xl9Mlb8y2/wZJEYqg
 00BjVrEodpCHtAHSSd1uU7q0DZTW/1e3Cs9PF18ar2mJuAgkFScUlnT0ZaFpD6MVSrhh
 gDcIPH0qEEc2rlwV52QpHfwFJW0Ti0z9SxQj/Dz9hOYjmn4SYva0tu5ojLcuHV4+Tz8O
 Tfjw==
X-Gm-Message-State: AOJu0Yx8c/cxiN+pthtIYznGqzqH/r1wuRtSR/Rlmi4WJkx97BuogNDc
 j+hHbsDIkLlnugSFPWCG7ZuLLR/CkphWiwfYHkIKxYluJjfDHfVdTGTuY1apPVHbThFPu9QEu4S
 vg5/v/U2rpAYyzO8lKsDhlcrMqqR78wVuMt6u21+kTyj5Q2XwuWwZNyOMjlfW4LHFOqSBaRyH9h
 jpftb/ZrKxNv07uzFMEPh8ARMjXSp9OAgthQ==
X-Gm-Gg: ASbGncs+m+6xtrBfspZj5O8iPL+76h9GpPfDB4usMli4ipDvK/XkS0YRsQPt+DL9YQu
 oYn9RgZZqT5l0FZQcVIekaRgYGiBOrbeXf/oNAhy68kDZn/nsiS/id07uLefyH3SC94AZj62/q5
 PDLMtEY+cXhnq2HLRwUByAHYGRkOzuwLKb87sZet67FQ/hL5Q1vjMPdPTtbIILFfoNmnH46Nkhd
 XW3SmBbiIvUub1SDdPoo2vBAcnuPydpssOy6q38cthYX+ZOa5IX+la9SOlmouh3NxhSL+Uvw1W4
X-Received: by 2002:a05:6214:4111:b0:6ea:d629:f47f with SMTP id
 6a1803df08f44-6f896ec3367mr16453976d6.42.1747174170534; 
 Tue, 13 May 2025 15:09:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTwH5WJmONcRPFWO76ka4HrWbQQLL7JjAdptCtMSR1DbWXpb8nRmKO7YHZSPy7s7JlQgEEOQ==
X-Received: by 2002:a05:6214:4111:b0:6ea:d629:f47f with SMTP id
 6a1803df08f44-6f896ec3367mr16453566d6.42.1747174170060; 
 Tue, 13 May 2025 15:09:30 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a0c5e3sm71708616d6.63.2025.05.13.15.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 15:09:29 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com
Subject: [PATCH 2/3] migration/hmp: Dump global in "info migrate_parameters"
 instead
Date: Tue, 13 May 2025 18:09:22 -0400
Message-ID: <20250513220923.518025-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513220923.518025-1-peterx@redhat.com>
References: <20250513220923.518025-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

"info migrate" is the command people would frequently use to query
migration status.  We may not want it to dump global configurations because
dumping the same things over and over won't help.

The globals are just more suitable for a parameter dump instead.  Hence
move it over.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 49c26daed3..0034dbe47f 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -58,8 +58,6 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
 
     info = qmp_query_migrate(NULL);
 
-    migration_global_dump(mon);
-
     if (info->blocked_reasons) {
         strList *reasons = info->blocked_reasons;
         monitor_printf(mon, "Outgoing migration blocked:\n");
@@ -235,6 +233,8 @@ void hmp_info_migrate_parameters(Monitor *mon, const QDict *qdict)
 {
     MigrationParameters *params;
 
+    migration_global_dump(mon);
+
     params = qmp_query_migrate_parameters(NULL);
 
     if (params) {
-- 
2.49.0


