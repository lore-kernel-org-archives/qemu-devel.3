Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACD20C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 16:08:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYSLo-0004HR-FZ; Thu, 16 Jan 2025 11:04:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSL7-0003Wq-O2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:30 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYSKz-0001HM-5Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 11:03:25 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43635796b48so7482045e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 08:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737043395; x=1737648195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=xm+GRH2d4c7ftd/+htyUwJu8eN8M0Bbcfq9uYgkc/1DpklIXoHePGn93sPQGdij0Kc
 VxjTWX81TWBWtjKv2fNh+Y7LW2v0NbxqfjCMF1HqF+pgJVCBXIPf47/7aU6Bh7zjGM47
 qb9LRwZlHvSyV6MEpnMLbhuHyFTEP/MQa2lWBt6gwe01J3UzWlDU8jVnHOUCUHPQUONf
 3dakuig684NwpRU0EfbrqBCHONWrXVbJE3xl7O6YAE43LKcbIkUKKhW2gqxOfI6QnPZQ
 bWY/bOK3bkMS2eC1Kt6g9XNnfE+l9byhD8zpqtlIkWbcReQvJYpgRm86E65mJinouMgP
 3Ndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737043395; x=1737648195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YoVYHxIQ6FzVx9Ejwb1qRhaSC8vYXzudlK+d3/Xo6Gs=;
 b=dkxll3ku9W3YYKf4HiL/s3oMru22y8ypWXpllcJKvebus7FWNDLWsg9FQEG/7IBE/y
 1R9eHx7jg86s2fuvWRszr7EcU8i+GyS7Cnb6f3WNqHtuxMEJVuh98WrvwEcqgWFexZUM
 vFgoEQHIBDg6YKWAqSYHCCBe1PCbBxTaP+Jb1GElqKzKxV8OjHpcaI9HWN6FHnqQ0qW3
 LgLfHjqak/hyL7tFSLwkzLwv1Za2PGn0zt42lYx0oxy3zZg22TsB6ZKj9O0/pwJrAXz5
 1Lvj0SINIE4QkgIOAwBy8eZ3KMIUtbfQPVzYcENw1uAJKt+kAwhnNMC1jvALWEFAwgbj
 jo7w==
X-Gm-Message-State: AOJu0YyekzJv0Ktxyt10NOucAYaQnf8c5MkVjJcNSbDYA6EQa43DcAXQ
 PhQXPdnd/enyVXNybW2JqJOG5XU7zFhPn6wg2Gza+42BpiGEitQN0WtsXNiosgM=
X-Gm-Gg: ASbGncuN6bXw3L5VkmEHHzLa9Ofi16bAZT+C+glKgTTtqztJpH5C7EFjtOjvzrF3XZ4
 uBBlU8mxUSmPRaEtCriFVwKUQv0Aj3Ugk/fad850s+loXpBGVq41tVXuK48OV0EtvoJlJd2pKx0
 idxwuvXsn+27QoSGHNnPWIjUk6BP0A2f6eE09WEhf4sW1HGJpBSgSQ3Xd+hUsAdPUDwvtlKTd7I
 48CMftmKq3fqV54ZLf2SFiylBpa9bWa7fQkTWcLAX9yuiwga2VcCFc=
X-Google-Smtp-Source: AGHT+IEcmuxw8vRdRvFasaw2np0PaDwUw6zrrwm21pYURq4/w/j3jQcjS7Saw/Kx9CgdkiNZFZPQCQ==
X-Received: by 2002:a05:600c:3509:b0:434:f9ad:7222 with SMTP id
 5b1f17b1804b1-437c6b02098mr70020395e9.7.1737043395356; 
 Thu, 16 Jan 2025 08:03:15 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322acdcsm221252f8f.55.2025.01.16.08.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 08:03:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7FE1260872;
 Thu, 16 Jan 2025 16:03:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefano Garzarella <sgarzare@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, David Hildenbrand <david@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 11/37] tests/tcg/plugins/insn: remove unused callback
 parameter
Date: Thu, 16 Jan 2025 16:02:40 +0000
Message-Id: <20250116160306.1709518-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116160306.1709518-1-alex.bennee@linaro.org>
References: <20250116160306.1709518-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/plugins/insn.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/tcg/plugins/insn.c b/tests/tcg/plugins/insn.c
index baf2d07205..0c723cb9ed 100644
--- a/tests/tcg/plugins/insn.c
+++ b/tests/tcg/plugins/insn.c
@@ -150,10 +150,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
             qemu_plugin_register_vcpu_insn_exec_inline_per_vcpu(
                 insn, QEMU_PLUGIN_INLINE_ADD_U64, insn_count, 1);
         } else {
-            uint64_t vaddr = qemu_plugin_insn_vaddr(insn);
             qemu_plugin_register_vcpu_insn_exec_cb(
-                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS,
-                GUINT_TO_POINTER(vaddr));
+                insn, vcpu_insn_exec_before, QEMU_PLUGIN_CB_NO_REGS, NULL);
         }
 
         if (do_size) {
-- 
2.39.5


