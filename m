Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D78CEC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 18:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJGtj-0000NO-Cc; Mon, 17 Jun 2024 14:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtb-0000E4-N8
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJGtY-0006Iw-Oh
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 14:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718648155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGE+LgWMbS91EIDfvnLwsxRRHX55rP0Vg3VR2s70yow=;
 b=jJRFBbF/OaDlLjuISOaw0DOqa1h2xd1QlK+xYdQ/OCZjT6ilnQytHfEA9VF1kmcuLH3w29
 88lXoIzsNZhw+7+toVXTrE7qJf+6yG2JY3YR788+gYZOCfw9W5QnlAwyrbqSwfzD9EhszF
 673JOnGQBTlvwYAEttpL105Q6qUhEA4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-Crk093aFOryObvx0_g-Ugg-1; Mon, 17 Jun 2024 14:15:53 -0400
X-MC-Unique: Crk093aFOryObvx0_g-Ugg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-794fa90409eso2870285a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 11:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718648152; x=1719252952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eGE+LgWMbS91EIDfvnLwsxRRHX55rP0Vg3VR2s70yow=;
 b=wQIJu3nae4eLlS+WDzZOm4bUB1YWDO7c6KVKo4n8q8/cftwfgcNm+9w/ng+n4X7O2c
 XW/dzxrKNkgOEfujCqlc/GO487X4ovOsJsppW8LwmAFsUMH27an2u8AgsmquZSbyRrq1
 pLCEYel9DlqVc5yTUlj+pDlF4Jnb4R8HbzDl98/dUNf+3mFGcQt0t21h8umk0f/8N3N5
 73xrRvp4veDd5bkJoixMlwJByeS0L73v0ZqhQ0GZD5OmKpFCxtMPFC0373gq6mWnA7D/
 bwL+3xBBgykhKJOJ3/AGzj625KPyV1b9rLbQsoseij3hCqEQ3zeNcWSX72EdJNOnNDoF
 /hYw==
X-Gm-Message-State: AOJu0YyDUC31dnTTPc1sDO8Cao7rx7zBgYHHTsqJlUUO/nPwEunYIp5V
 /ZuxCKGXcO8hbIStlCwCkFQVZqszVdam/xifXXDbSZo5eBS9Tk4mK7IQ5KojChPU6gzUlJf3iGr
 AbObou9jtPWLhaCJkdPIfw5V6mz9u/bTJGJacRXLvXE+1jROpUCQOa9gJtyD7zQDvV+BIn1q82p
 oDG+QMcoK8B/zPh5UK1tpptFGUdyw4hJoI6g==
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr1142520885a.4.1718648152261; 
 Mon, 17 Jun 2024 11:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO5xIs0uWkac8wmMuslSAq5i21szSRTWc65eVf0Kuqaq+1dlWGdGdzxvWiCqpDXZFGsj3wyg==
X-Received: by 2002:a05:620a:272a:b0:795:493f:9f3f with SMTP id
 af79cd13be357-798d269f370mr1142516585a.4.1718648151541; 
 Mon, 17 Jun 2024 11:15:51 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-798abc07501sm449643685a.89.2024.06.17.11.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 11:15:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 peterx@redhat.com, Jiri Denemark <jdenemar@redhat.com>,
 Bandan Das <bdas@redhat.com>
Subject: [PATCH v2 08/10] tests/migration-tests: Always enable migration events
Date: Mon, 17 Jun 2024 14:15:32 -0400
Message-ID: <20240617181534.1425179-9-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240617181534.1425179-1-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

Libvirt should always enable it, so it'll be nice qtest also cover that for
all tests.  Though this patch only enables it, no extra tests are done on
these events yet.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 13b59d4c10..9ae8892e26 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -841,6 +841,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         unlink(shmem_path);
     }
 
+    /*
+     * Always enable migration events.  Libvirt always uses it, let's try
+     * to mimic as closer as that.
+     */
+    migrate_set_capability(*from, "events", true);
+    migrate_set_capability(*to, "events", true);
+
     return 0;
 }
 
-- 
2.45.0


