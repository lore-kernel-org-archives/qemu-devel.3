Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1582CCFA00
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 16:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEsKZ-0007K2-L4; Fri, 31 Oct 2025 12:50:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEsKU-0007Iv-Iv
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:50:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vEsKJ-0007B0-DY
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 12:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761929404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=beyCY99b/Vjqke+r22UnEMDrIprbFl76fhiUtHqNLrk=;
 b=RIqC+xQAQ3dPBNwt51KcZcEF2ydsYnU+rZk/iS+lHBG+s/BgPbJACYe3x1JQVABZP9Hx1/
 1yUMt04mVOsunHD2603I6uojfaY8BlvQJcOhhQ5r/aJKWghB6GjxX17Jd5b885PAZ+cZWL
 OTDdbF5eQHYR2aXLlJoNbN4AIgElwk0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-TVC6V2k5OQyRTJ5A1Vy35A-1; Fri, 31 Oct 2025 12:50:00 -0400
X-MC-Unique: TVC6V2k5OQyRTJ5A1Vy35A-1
X-Mimecast-MFC-AGG-ID: TVC6V2k5OQyRTJ5A1Vy35A_1761929400
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-880441e0f93so5463206d6.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 09:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761929400; x=1762534200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=beyCY99b/Vjqke+r22UnEMDrIprbFl76fhiUtHqNLrk=;
 b=g3xAAlt/pJdrkL8A0x9cKOUXVyBIhqPfXueGiR3oXIS53z+gSeKFcR2q+tqmvMFawU
 rfdktbkQlGQVgjgCU7qct6ppu0z//EUkskUimRvGOBuctWI6TzDRMhkkO/kUWgEQEHbD
 8CTtNxLwDR+3zLdSnMJtOqBlRx2fUvemiDxOGt3kYEeuwW1GtCE4gfgZddgMevU4SM4m
 JcjaKAbY1mHmVpCC/CGRT3uB/83wo6o14ZJKK/ARrgiT8QIay7t94QlIUHpaq6DwHODX
 yvMYcPVcdCX1sAp+syjtjAWtECQ9anhRpRvBb5RX/rnae04S4mwJj9ZMlIgIo7m34zEO
 Q3gQ==
X-Gm-Message-State: AOJu0YxYyg+2ojNFFg/cd4FhS5d2cYDmoIaDXesY+JHsCeKDm0A5KCm9
 izn9Th8lCxt/ss6A6mDmlwWO3e1Ig2cOLg6OUUhDrcfKkWMBlfdYxu/SCsLN/6mLO/mLHnZi6Wc
 nXpD2BTJajJHQnGT2uc504AD2wjovNhw+wdecnMhbtZSogiKeesjMyFtaJKfbNX3H987uR8NhUr
 pRU5T4akELzRznXXqGLmLqKuB+8jAZYOvH5D7DWQ==
X-Gm-Gg: ASbGncsvwDT152rM0vcLu/7Owmf0xPfrdx0fgFRF2NLoF881XwYx0hmSvQPxs3kRdrc
 Bec3Vbw+gZzU1UONcfvPd51HrV5CoB1d8i1HwYYsrbDhk74Dkm0s8I40gfrY+tbeGB9bX85gwyE
 4bd9OshyQRb9Up7RT1Ejg75gpcGzeO0HNaX+8SdQSDinKsoAxmrT2hfTavkvrP5z1aLrddSoOn0
 qKw+wRYRZOsqZuI2bdZp5DWEm0CToBPbKtYEtQLgGxwPgZdvi0S0iuPqxxAAJsfR7Bl+DaaaUhf
 6cZBVfcDWFs9XQZQWcBfR/qjJk6tblwKZ5YSmEvutqmk69yHQ/XjvIN9xVv2gOok
X-Received: by 2002:a05:6214:19c6:b0:87d:ca33:2599 with SMTP id
 6a1803df08f44-8801ac24967mr103352196d6.13.1761929399992; 
 Fri, 31 Oct 2025 09:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHte/aL07P5KYNmw+jry83Svj9dF7SvAsBT83K0BHId46ZwrUqZlVuKDtXUYAFhhgdz22OjGA==
X-Received: by 2002:a05:6214:19c6:b0:87d:ca33:2599 with SMTP id
 6a1803df08f44-8801ac24967mr103351626d6.13.1761929399420; 
 Fri, 31 Oct 2025 09:49:59 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88036317113sm14165106d6.42.2025.10.31.09.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 09:49:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH] tests/migration-test: Check error-desc after pre-switch
 cancel tests
Date: Fri, 31 Oct 2025 12:49:56 -0400
Message-ID: <20251031164956.3409661-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

error-desc should present on dest QEMU after migration failed on dest when
exit-on-error is set to FALSE.  Check the error message.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration/precopy-tests.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
index 57ca623de5..5f02e35324 100644
--- a/tests/qtest/migration/precopy-tests.c
+++ b/tests/qtest/migration/precopy-tests.c
@@ -759,6 +759,14 @@ static void test_cancel_src_after_none(QTestState *from, QTestState *to,
     wait_for_migration_complete(to);
 }
 
+static void assert_migration_error(QTestState *vm)
+{
+    QDict *rep = migrate_query(vm);
+
+    g_assert(qdict_get_str(rep, "error-desc"));
+    qobject_unref(rep);
+}
+
 static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
                                            const char *uri, const char *phase)
 {
@@ -784,6 +792,7 @@ static void test_cancel_src_pre_switchover(QTestState *from, QTestState *to,
 
     wait_for_migration_status(to, "failed",
                               (const char * []) { "completed", NULL });
+    assert_migration_error(to);
 }
 
 static void test_cancel_src_after_status(void *opaque)
-- 
2.50.1


