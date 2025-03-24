Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB7CBC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewh-0002s9-Mg; Mon, 24 Mar 2025 06:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewL-0002jk-Jo
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:54 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewF-0006zB-SZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:51 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5e61d91a087so6256941a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811706; x=1743416506; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EfOS5oo5Tg/ms5IkUOiNXbF4FjmC2l84J0aAY/Jvw9E=;
 b=cIh60no7tiXIdx9hLb9xy6zdmhor1lJAvCgNuTj5zLnwxzMC4Hd4KeQZsMYglGAAUx
 qu/C1zi2rqe/QvxvNbk0PF+vaij8z9whf8SuoadJyWJ3xMYZwRfE3cXtruujcIanC5Bu
 0Id63CsMB3H45zNXGlcevUgF+D7fqlfsi1F6GC7phH0WtDWFsxvlrRM4j0bG2iP2W0jN
 wBvgtL+JdifXeD3iENT2MeaKOg3FMzWBXfBC86SvMrkh3jNuzKkR9SxmLTUE9UY4SyVH
 1Q2no66JfDIsYQ8KhXnnHSvb18mCwfd9vYCXKY5NNktrpsvKBCoQW8JipsiXgrcJAIIo
 aohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811706; x=1743416506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EfOS5oo5Tg/ms5IkUOiNXbF4FjmC2l84J0aAY/Jvw9E=;
 b=Q9hREJpos0D9UbMgaWpmcKdzKqLL9ycP2xqTgbAtPhIBhB0gGUgMd/D7mIJK35/DK4
 YsY78kdSN7KXt/nbQ7WQSddz+cdxxUInfy1Zlh4Pfu10N7DppJs4GC5kRaH7yyGzeQzs
 1hz5uvPv+ae4HnItygNA9LHcXrmmvQNYG58icfCBiHZEYiGLOzRh0TVfZD4537ysqeIS
 HGd4n7EBZaVqFKND2KCbWrlRPR4IsDQXV1HmTDZgQyluapHe8mTFfIi8M51DYCyD2tyY
 0c4Y5v5w4gVdfPMWsw7sHwJ/bWGz+7JezJDoLX1qFPlUyPZ1RPOWTUcYJL3gpZuLmHtA
 ngGw==
X-Gm-Message-State: AOJu0YyJiFf4OgPB8LTaygMwmmGvNKpJZf5CoXb0DspAl6hzeoamsp/k
 z9PZ7Ksyy5oA6PeLFJ6Hqcj0UW5IaTFKJlQy6T29+VL2CnIGAPH1dZpx2/y8D/4=
X-Gm-Gg: ASbGnctL4u4rXScokpsJcVt6jwxfsWEEQQVUG+XNI7U2KQ1kAaQn9k5YKSVc9aGUtnL
 dWqMOnXFRj5yDZdAcLRlQm+VkniXg+I3Vs8Qgp6d1fQLLddPdkVCaYSIO002ImFcXQOTpwmp4Vm
 JBuhphzs0gdJ8PyLeLvXnCwH2I827VbImJ5S+3Tfdp/bQGjDtmFH1t97fJCdVjvqmggtfqV18V+
 gSwC3i9aDguVKbnENi/r8I115r89Jgu0c7/lD6Kzyk9+tAyVUy0ReuoFaEQNSeXuFBsHaawZ4Pd
 J8uadz6lnWX3z86edEaxr1Tgsf5Hu1ddaaHwaiDzZHNG1Ik=
X-Google-Smtp-Source: AGHT+IGL7guV/PyliaWYbxhpnWFl2b0Xg41mVXECfIj3DQgLRrOEQGwKtSGDKLmrxObXKy1VGk0pFg==
X-Received: by 2002:a17:907:7fa5:b0:abf:5fa3:cf94 with SMTP id
 a640c23a62f3a-ac3f24d78cbmr1164505966b.22.1742811705823; 
 Mon, 24 Mar 2025 03:21:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8d3cbcsm644126666b.49.2025.03.24.03.21.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D9E2F5FABD;
 Mon, 24 Mar 2025 10:21:42 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 03/11] gdbstub: assert earlier in handle_read_all_regs
Date: Mon, 24 Mar 2025 10:21:34 +0000
Message-Id: <20250324102142.67022-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When things go wrong we want to assert on the register that failed to
be able to figure out what went wrong.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 282e13e163..b6d5e11e03 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1328,8 +1328,8 @@ static void handle_read_all_regs(GArray *params, void *user_ctx)
         len += gdb_read_register(gdbserver_state.g_cpu,
                                  gdbserver_state.mem_buf,
                                  reg_id);
+        g_assert(len == gdbserver_state.mem_buf->len);
     }
-    g_assert(len == gdbserver_state.mem_buf->len);
 
     gdb_memtohex(gdbserver_state.str_buf, gdbserver_state.mem_buf->data, len);
     gdb_put_strbuf();
-- 
2.39.5


