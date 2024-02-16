Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76199C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tT-0005Du-89; Fri, 16 Feb 2024 17:41:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tR-0005Bh-Aa
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:17 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tP-0007Kq-S9
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:17 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7d5c25267deso1110262241.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123275; x=1708728075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PsYydAOoJWHHnnEKgrZhgm6MgPanWUyFgyt4kohdSeI=;
 b=kTFONq3bwhvjHSUD6H3GHAy8Z4BOVew8VTkAVbr/18MMVv9MQsiXpas12WbjLaSpwh
 u6nQvuPds0KJbFnIQaNjPCuC4d6Xc5q9hlS6mCSNZZenkltk4tXGJlkE4CNCJIzNfHOL
 GupzOHQvRhPr/hz4/+EGcsqfTixoRuCY9SXG/r6Xe+k2TkelWDON+Nh5AZP6Lu2woag9
 sKwOiTDehWd3HbpZX5SRhg5/6ado0dOvv+e6KGg0vnOVgG2wnXpnWXtyLmMWE+uqy6w5
 T5GF6PTQxEAS6xghBmDXl9GqPKOs7m92MJL3u73LuNhyCRuyvch63R5MBUtcQSIvgDI0
 F3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123275; x=1708728075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PsYydAOoJWHHnnEKgrZhgm6MgPanWUyFgyt4kohdSeI=;
 b=jTi2CliFt6KF/UusBK5f9rU7olZuHRGrcwZjhhyJMRREvK1yZ4s8bPpWfVk1FvJZat
 2UAnLtEZ76/myQt8/neX0ZO6NLMmVZZqwm88anUJTW/hdbf5hWd8pGDQ/vtentP3IjVb
 Xm40PtHL8r+MFhSMhZTYT4qHdt0BstwJF7sw7h3CNk5e/EzNlx4G+qV51ipn0vJx/GAy
 WE6bcaUprX9xHYrlFWxn78DTlZ5uFhgOf4ezbq/YF3NqdDQG8sWbDl/gRS68i9MjIJtq
 k8eawoRY0TMxP3Ps6VGpZCHe4s0ZpiQz+K/wsRpP7LFPWlh62dNh+rfIH2NOgGJZZZh+
 6BKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPw/p9qP1/D/IpJAfq8nQqoKA6xyKEuRdq+7tMLGMwkwYJzZe1DEFlX93tyh7CNrMc0kG8Fq9vtccw9Fmudw4/cJk0/pw=
X-Gm-Message-State: AOJu0YyKGKqfKXxeHbn4REVOQ+akfOOJ581NtM+fGC6c2VqlCXexmIyP
 tyKQWNIuzysUQJGJarc3aDej62KD+Qfv4VnmIqJx8YikMAJpr678osn0fIateos=
X-Google-Smtp-Source: AGHT+IFgQ4dxzpTeD9lxmwHvMchPMHL0MhqGhTVtdiUJSghu6+bQTyXTvylsMCb5cxdCcvaULTyKxA==
X-Received: by 2002:a1f:ec83:0:b0:4c0:2cff:9d7a with SMTP id
 k125-20020a1fec83000000b004c02cff9d7amr6631435vkh.5.1708123274843; 
 Fri, 16 Feb 2024 14:41:14 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:14 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 7/7] Update maintainer contact for migration multifd zero
 page checking acceleration.
Date: Fri, 16 Feb 2024 22:40:02 +0000
Message-Id: <20240216224002.1476890-8-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Add myself to maintain multifd zero page checking acceleration function.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..3ca407cb58 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3403,6 +3403,11 @@ F: tests/migration/
 F: util/userfaultfd.c
 X: migration/rdma*
 
+Migration multifd zero page checking acceleration
+M: Hao Xiang <hao.xiang@bytedance.com>
+S: Maintained
+F: migration/multifd-zero-page.c
+
 RDMA Migration
 R: Li Zhijian <lizhijian@fujitsu.com>
 R: Peter Xu <peterx@redhat.com>
-- 
2.30.2


