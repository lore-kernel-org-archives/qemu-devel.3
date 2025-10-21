Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC00ACCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKSv-0003rV-Oa; Tue, 21 Oct 2025 18:04:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSt-0003qo-Mb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSs-0001LF-6T
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761084261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TiDECXXm/XmJQvxVQNSIb/eABk9ABvi3OJ7FJq/HmTo=;
 b=CImo6PJIEXEF9mRcXc2/uvd8Z0k9dUVNH2UVamzszmTb+CQ+kTnCHjJQYaooc6IB9HG4jv
 sNmoia983qFmW8YilNAKIb35p4P4ZPrJhO9CcjKWwUpXrpXOTzhDu8WJIXXqbUEWyxiSpY
 vZ57Il7G2wNDBNMI5JrfWPx7znXzXRg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-ON4RMu1eMgKRcI7PfCgkKw-1; Tue, 21 Oct 2025 18:04:19 -0400
X-MC-Unique: ON4RMu1eMgKRcI7PfCgkKw-1
X-Mimecast-MFC-AGG-ID: ON4RMu1eMgKRcI7PfCgkKw_1761084259
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-85dd8633b1bso100576085a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084258; x=1761689058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TiDECXXm/XmJQvxVQNSIb/eABk9ABvi3OJ7FJq/HmTo=;
 b=G/U1cJeIN1+j0L7Az9XGnHxOgii9Kuq8mznfPXu1sHjX1crTrAYZVNW5H+qL2cF1fC
 sRXXWKFmXvQKKzfWXQltu16u2+0cHgUv+2BEx6V1BU1+KiyXvhtbKkxvPexI3t/JKtup
 TG6th/GMMWXHkUTbfEl++cmZLMZnwSdslhsZQwsb72gxxDuWAhGQjuK+zek/YhezdtZm
 PZC5GVJ5wQYMp9xCIDTiSU4EeoHoVi0H+5C8t3Q8losVqzPrhRljYwagf8eaVixAzJzo
 vkq42c/G0R4LAJrpgQJrL9EpGDGGL+nqdqV4zchvXedZBKic0NhsszkZuD0Xig7kN0Vu
 9Gew==
X-Gm-Message-State: AOJu0YyUbJtEH10nkk5jDwFTsCdNo2L3DrMeNglVAbRyBU4qHPhz/c0c
 rHKZtCMYIsAexvdYnAXh8o3jBc42ZasG5MZHlq3sWA5V5+0FzA7FQ4apy4B/VYEksp/1ZwTqWzp
 rdMLh3X05R9igISiQZFhd3E8LwGy6ZKR+RQGd/OZVyXZl1vwnoX7mp1UDNEJwrz60E4CZk37YOi
 Kr6Q4TlN7r8dxlep6zBxRvMLVJBSf71bMqi+ucVA==
X-Gm-Gg: ASbGncvtxUKw4eOMnakz7/8zx5L0i3XK1fBz8WeC20A9oHMK+eelv8pWWxmrawXtyvO
 513C/+LyzYFmBDj0TYU7Khu+2s+YeY83iYS07gEdrFJo2WFePgfSYBCYSaep6hLzvn9eFlCWj9d
 JY3qVVD8INnLv4SGEZ9RKUCPXd35MzQ3qdZmlm+pCI5Ec6Nli6j12jmE9+l+P/QADp8FMgZwSdT
 YTwbQaOTo856GD2jhON25E9JRMowmz/y044Dd5ibBuXEW8hUevF7nE2fcechlxKrHKXFGWMMolz
 9JcYql9fUPzpVObuZiaQy1y5mIkzuINFFiVJ114a/f1BPD3bkksjDe82XeoYLzyM
X-Received: by 2002:a05:620a:44c5:b0:891:19be:32b2 with SMTP id
 af79cd13be357-899df630540mr207707985a.26.1761084258107; 
 Tue, 21 Oct 2025 15:04:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnknELRPq7TYfKXBGv8PoBCavS6rV4/frYKILwbQZH6X7Z1XOQweAM17GYdqwXPx5hnygw8Q==
X-Received: by 2002:a05:620a:44c5:b0:891:19be:32b2 with SMTP id
 af79cd13be357-899df630540mr207700785a.26.1761084257369; 
 Tue, 21 Oct 2025 15:04:17 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098edasm849197285a.19.2025.10.21.15.04.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 15:04:16 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 4/4] migration/cpr: Avoid crashing QEMU when cpr-exec runs
 with no args
Date: Tue, 21 Oct 2025 18:04:07 -0400
Message-ID: <20251021220407.2662288-5-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021220407.2662288-1-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

If an user invokes cpr-exec without setting the exec args first, currently
it'll crash QEMU.

Avoid it, instead fail the QMP migrate command.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index c8a5712993..4ed2a2e881 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2195,6 +2195,12 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
             error_setg(errp, "Cannot use %s with CPR", conflict);
             return false;
         }
+
+        if (s->parameters.mode == MIG_MODE_CPR_EXEC &&
+            !s->parameters.cpr_exec_command) {
+            error_setg(errp, "Parameter 'cpr-exec-command' required for cpr-exec");
+            return false;
+        }
     }
 
     if (migrate_init(s, errp)) {
-- 
2.50.1


