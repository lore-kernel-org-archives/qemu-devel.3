Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56971C2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGte-0000FJ-5z; Mon, 17 Jun 2024 14:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtO-0000Bs-01
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtL-0006Hw-L8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648141;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wzpRVcMoHJuiYGTTUkqQjk7ezIIqhok8HbPaC8esF3E=;
 b=NGCQpu00Ea7Y9k9G9tG8OiV7l9vORl3tKUNlmj5fk5HQUQWr4KIxEiGWUgQGnsdYDyCKQU
 tYCeHjFyjlYKSo0pCFpuUnf7IT0VTy8yRmOWE5zdPHdtnZ+8HHZ2e/A4bhpTIDmgUIRnIM
 VMIGZE180VNJvBhEISQMPtB4ofnhr0o=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-uvCyQBXeN2aQwzhJ_YhMfw-1; Mon, 17 Jun 2024 14:15:39 -0400
X-MC-Unique: uvCyQBXeN2aQwzhJ_YhMfw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-440aedca77cso14293911cf.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648139; x=1719252939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzpRVcMoHJuiYGTTUkqQjk7ezIIqhok8HbPaC8esF3E=;
 b=B3zL8coh+JQDmIbDRLHL7BeV525DcPXu1KScqUozm0IganzvU4hZKmbOH5bwg91F7m
 eDFF4oRa0t9Owzh+qGD6Wf3owLhlg05Epo+ZA7KTwS2IPaEZ0Dm2BL65p5eUw16jTotH
 jp5R4iT524Fhh6SXmNA0hM7EUt8MrqB6b3ykuaGDSXVdn98uLqdlo9MGhYDSF3HwhD1V
 Rxi1vimOo763OlMs8u+N3taIl++efrb1IQrrta+RnszPXMSEb57MY7kump+ZoPuaiRiU
 ZhHTa1EAROiOvCnW1AXaGSQ2qEPHY4CsEuHHUr5YPu5pVDPaY2qskKYvsApoKSuw1Gry
 D1cA==
X-Gm-Message-State: AOJu0Yy0lgTiv6YG1L67/CwICTqO3Mq9B/h2mhdaBbbEUzF/6Vyu0iUG
 yvr6T2hjo1jAvGg4DQOE1xiWk+HS798s+fV+pm59BP2YpzRPpvqHLDQnQ4VuytGuVMyBZC7kIF9
 IFKWq0up0ONseXZcGSCL6UKy8H6exzbKhm7qUL0W/Xi8hnWA0hYxaABmhYxZSp+6OVRaGRucNjE
 puvgYpQb5KtuqFqJ94pVWDD0h4JG88owRezg==
X-Received: by 2002:a05:620a:4143:b0:79b:a816:94a4 with SMTP id
 af79cd13be357-79ba81696efmr13774285a.7.1718648138858; 
 Mon, 17 Jun 2024 11:15:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7sBaRIfIps3Np7Rt/g9UGAi6zcND7K/RdpvZpNNRHjHyaIHqOuiaaIJbnGuMweoxcZVHZ+Q==
X-Received: by 2002:a05:620a:4143:b0:79b:a816:94a4 with SMTP id
 af79cd13be357-79ba81696efmr13769785a.7.1718648138169; 
 Mon, 17 Jun 2024 11:15:38 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 01/10] migration/multifd: Avoid the final FLUSH in
 complete()
Date: Mon, 17 Jun 2024 14:15:25 -0400
Message-ID: <20240617181534.1425179-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

We always do the flush when finishing one round of scan, and during
complete() phase we should scan one more round making sure no dirty page
existed.  In that case we shouldn't need one explicit FLUSH at the end of
complete(), as when reaching there all pages should have been flushed.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Tested-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index ceea586b06..edec1a2d07 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3300,10 +3300,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
         }
     }
 
-    if (migrate_multifd() && !migrate_multifd_flush_after_each_section() &&
-        !migrate_mapped_ram()) {
-        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
-    }
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
     return qemu_fflush(f);
 }
-- 
2.45.0


