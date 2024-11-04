Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F02D1BDD0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80s9-0005IX-62; Mon, 04 Nov 2024 12:28:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s7-0005Hk-8A
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80s5-0000Jy-QO
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:28:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U6hzpadmFMiM+zfoWH0oKGs9+Uf4D6zyZQRtFbQa8FU=;
 b=SMf69HN86uzSrAQO/eH32oGKpojRs3tODpNviA1fQyoGH7Wg+Q+cyq1GuKcChdNcLt0HKA
 NijUNQcsjaIdQg9OM0Mzcxx7bvUz4UNaLOEfj8VWqq9Q87Zou6TJ5/cWblpRcgtOni/+5Q
 SP+XvJwBGgQk0XOLJQzwl8nHgZCoxy8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-6Ql_pNm4Mtidrl-Hvgm-DQ-1; Mon, 04 Nov 2024 12:28:07 -0500
X-MC-Unique: 6Ql_pNm4Mtidrl-Hvgm-DQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso30791875e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741285; x=1731346085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U6hzpadmFMiM+zfoWH0oKGs9+Uf4D6zyZQRtFbQa8FU=;
 b=rzEX8NSqDRHQ7BcOf3C89UfnWYJQQJalz9nRQFpLGECZztQHIr5fJIWRIYgLwNs6Dj
 RoCCAb6VRFMZF67XGeMQqefb31RjoANjeg0GVZvlqr8hyknU/gYysr1V058zh8hfHjOr
 nxMc4haPjhsWvnK8fM1Lvfc3veLMqPERTVWXEFYvcKKDlUsvcMySsBbKGoxGXryR77DV
 5QsHJjMb4+XUniX/85YOjJNsUze1chfT3ty3lnlnzuxlHHsW0vGb05raOSsgqg8kN08x
 Zl/4beai9MmmdRT/WfUuudxFxGUu72vgKAPY9LWkM38fyunzsEvN8vk/lk6vNEvveDrA
 dLEg==
X-Gm-Message-State: AOJu0YwJ8QcI5dvpQhWcpOqloML5ao6FZDDrEyv81UNAfizg8SA4C55P
 vYGungwSDE76JOf99S7fp7J5mkLeTZ7SUngTI1aYfk/fqlkatEWkJGFy0DQopCIGovYbGQMItk4
 Z79WuRu2Gjr6WF73z1IiOrDusWO5RQk3azpBnsMKPIPMJBuvhr3rhpFsYU2nAA2FEjD0fgKKi7O
 IR22AdKKm9Z/GCuePdxlYI9QPsZqpo9qpppPCTx80=
X-Received: by 2002:a05:600c:3514:b0:431:4880:3120 with SMTP id
 5b1f17b1804b1-4319aca55a6mr272666855e9.11.1730741284991; 
 Mon, 04 Nov 2024 09:28:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvZwBC0mxCI/3SmtB+bC3sFEpSyQUqL5OLpoP5sa7CsP6olNc438zsZAokKVj7tK8gIjUyTQ==
X-Received: by 2002:a05:600c:3514:b0:431:4880:3120 with SMTP id
 5b1f17b1804b1-4319aca55a6mr272666545e9.11.1730741284556; 
 Mon, 04 Nov 2024 09:28:04 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6852efsm159511445e9.30.2024.11.04.09.28.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:28:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 19/40] rust/pl011: fix default value for migrate-clock
Date: Mon,  4 Nov 2024 18:26:58 +0100
Message-ID: <20241104172721.180255-20-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241104172721.180255-1-pbonzini@redhat.com>
References: <20241104172721.180255-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device_class.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/hw/char/pl011/src/device_class.rs b/rust/hw/char/pl011/src/device_class.rs
index 08c846aa482..9282dc4d151 100644
--- a/rust/hw/char/pl011/src/device_class.rs
+++ b/rust/hw/char/pl011/src/device_class.rs
@@ -29,7 +29,8 @@
         PL011State,
         migrate_clock,
         unsafe { &qdev_prop_bool },
-        bool
+        bool,
+        default = true
     ),
 }
 
-- 
2.47.0


