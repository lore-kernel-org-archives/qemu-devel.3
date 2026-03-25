Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4F8103A9A0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5ED5-0003Eu-0G; Tue, 24 Mar 2026 22:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED3-0003DQ-9p
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:05 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5ED0-0002hB-Nm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 22:43:05 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-82c70e4654eso121463b3a.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 19:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774406579; x=1775011379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9hlpMtkDBxX5l/chmGTVybiK0SV2YTuFFSIEAzcHJnk=;
 b=hBkKNtjOuV0Xp0XqnroTu3vp9kToc+N2bBHbrm+CxVjSvu77i0amDX1ZUW5XodFXLx
 d1+es/a0OlcwaZBY00jxO1pioNcoH3e0c8pO+odCRlH8WmyVfewX83SGthe6Si06dgMh
 FZPB7TFaskAAF/hSndPxKRQYb2JYQdizy+gv+DBiVaFwvc3ddO4HRoCwykSPDF0aWWuz
 doOY5d/Wk6auVzigGyLDCpASO3uZb5hGzV09DkrK88tRDzv1WYWDK4eY7FJUsJ59lzRO
 7Y7gwiUg2VUmXINkWviGp18WJYH+KXhF2M9RnPyTbyHe6er5hwOa3vVy5gisoKnA6UuR
 0fWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406579; x=1775011379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9hlpMtkDBxX5l/chmGTVybiK0SV2YTuFFSIEAzcHJnk=;
 b=pr0kT2z2ibe3UxpCmSeWWX6vMFvkCGPVLEpsq0fJGLa0Rccfb87EMYJiw7BWYhHp1T
 EpiFeSaLiQ4bgXh17WyvZSuC/1pCHf/7+VssrI8WwItF7xjqhvTGDJitWKlxdmR5vnZq
 DVxM+ntzg+tyxnobuHjkVxn3G+DgleKkiV156HdDCXe6Qu8JBwVcWlKj3P7ETNv/RSjV
 E1hm67En7jNBnXZVQAHn9tT49WC0zG/S4NVL5BSQSdRu6F70wgDU426AGKQ8U9dft6nt
 frC1KryGLHlmDOxOYPIandGsIcSwSO1XavV7wLWWUtj+yWnbVsrA1je6B2Rs7JLejXJ6
 F8OA==
X-Gm-Message-State: AOJu0YxNjxQecgFV5TdvvyON0013i6+x8go0y9X+9ZLFD30ehhcc7KVS
 7wvjYxna59joLxOQH6aQFQiEZ6xycVL1yXqn120aRDl4kUTn+zuxvRBZIs9PxHSqJnedw1sZSOu
 g7sZNDWE=
X-Gm-Gg: ATEYQzxL2d373KLWmSSOhUfPg6m/3UqlUhvjl+A94n/d1sOi/TGGLAWrnbefpRpEYVL
 g2l8gAT9BDHI8uCLKklerbRXuXWd2Y8LGYy2xsvASeoMDnf9pwFSnMrqr96SBO5+SXlSovQGtIF
 gZiqbQ/EWhguovmEF8aE4NqZls9FkH4l02CIwkJ6yd4UegzJDzVvfvDkR13u8R9s4fJ+DhEkVEG
 EnMdTwZYH+ArvI6FPDdf/5dsZnemjqC3JsiZiGAB+2GdAtGE/UY+3NfZFyZGYczUfbICbwzUP+3
 Zv6S297B4fqP1p6MKGwXhxMsQaZ8QuLcl8TtKCKqpszpHcbbdleuY/4HSzQDsaJEWtzcdn2TASt
 +MpzACdfZ931wIB2RdziBDsf71FMa3483N+AwMlcE0DT8XlkG3SMAEuqCYfWXeEKOWdojok+qwt
 HslmDz1LNOy+WHDxgiQYW+JxNWyqMCAxK5+dVftp5atLjRECnbnb9FJYBvC535v/5WtL8Gc5eoP
 0mZ
X-Received: by 2002:a05:6a00:a226:b0:824:36f8:346f with SMTP id
 d2e1a72fcca58-82c6def062cmr1882826b3a.25.1774406578677; 
 Tue, 24 Mar 2026 19:42:58 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b04222f42sm16762716b3a.61.2026.03.24.19.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:42:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 0/3] plugins: fix endianness for qemu_plugin_mem_get_value()
Date: Tue, 24 Mar 2026 19:42:49 -0700
Message-ID: <20260325024252.3369186-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series fixes qemu_plugin_mem_get_value() endianness on non x64 hosts.
As well, it updates documentation to make clear that value returned is in
host-endian order. Finally, it fixes tests/tcg/plugins/mem.c.

Pierrick Bouvier (2):
  include/plugins/qemu-plugin.h: add note about endianness of value
    returned by qemu_plugin_mem_get_value
  tests/tcg/plugins/mem.c: fix endian swap in update_region_info

Richard Henderson (1):
  tcg: Pass host-endian values to plugin_gen_mem_callbacks_*

 include/plugins/qemu-plugin.h |  5 ++--
 tcg/tcg-op-ldst.c             | 52 ++++++++++++++++++-----------------
 tests/tcg/plugins/mem.c       | 12 ++++----
 3 files changed, 36 insertions(+), 33 deletions(-)

-- 
2.47.3


