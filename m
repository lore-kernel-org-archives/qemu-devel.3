Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287FFCCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 11:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8cxZ-00081C-77; Tue, 14 Oct 2025 07:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxO-0007uq-Mv
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:42 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v8cxM-00081o-3P
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 07:12:42 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-62fc0b7bf62so7731395a12.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760440357; x=1761045157; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lx/g6Brw0vnITlYo9+9jagFBHEALpmQn7onYoxBlbPw=;
 b=z4gscisi0owWUHTNARNgXQq/cnKMp3njsYec0YjggNwMionENVdaZXwbLc2uLJ75Zz
 pZOo+dNQBCPYfi7KsXMOubnPbhvWgeIRADSU7108Suaxj1hZSmo4dxJJLOaT/3USIYr5
 C+sTQ9hVqtQo/ZLsDVPye55a5TAzvD2FGGk4qY9ikw14RCVvrz1GKyNCD0dQ5iyGZgdG
 1YOJVvIiUZ/fByRXP7unWfZPJMYBj/m7I1wSpj0LaH+SrmY/XJogmZRiKw8U0IzvVRP6
 U9PO6UHeu7FIII7Myqz62tRT2hRDBt6NzNSvVxu9h1Wb0t7kQdge7rdjrOyQITdu+xIq
 4sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760440357; x=1761045157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lx/g6Brw0vnITlYo9+9jagFBHEALpmQn7onYoxBlbPw=;
 b=YgP/bI7kS4uO5D5cDf8Qay9fD/XXCL45mF0L2d9XkY0WcXHvjDANpzXczw6TbmvyMd
 Ss+sX2Tl10bTLBrJMvKy6QFaxIfTy2RwGvl0LR4F9CYADgNOkqu8y3zq8rH58M92/T8K
 ztpANVnlVEcMbKVgyAZV0wwA+FJeybeY3qJpi6PyG3Z+K0i0XF6iKBPP0GGy5qyBF5eO
 Qamv6M0TLB98iD+F8KWWoplYxoPomml+jTHwCSqNhHyAkHIonxHXlBRTyRd//mIxNb+Z
 CVUmMIr2nnSdPvBxG7wCYTAb/HPDY7GDFwHgV5C/MJDNh8z6DFcS86mhxmvv55i/BXSA
 yeUQ==
X-Gm-Message-State: AOJu0YwH5+T2Malt9V86eakfxocOSK2RBK04FdLBGAL3dUT+cRn4NS3u
 KQY8k9cN5UO22NL4jY7/bTxvZVjIs7mYNvs3bSJvZfBzoI7oMD2Nd6w212608yhEJHc=
X-Gm-Gg: ASbGncsmRjmQXTTmShpjlagRSgOV/MnytQXtOZP8kFwBGm/f0F+BDGDMXulENhBkOWx
 i9SXZ4nXlmz9zzKiTGtDS2qFESabq6Z2KW4QQJ24DQ9RYS+5TVkPXCX0NNZ0FuGhgvK+ob/45/m
 XQX6EytR2K/+l/7ZhnL1ZrxKUSnZWmWtA3Th8iy9nApSB4eqeevdmgjLrGt+MoC1wycHw+umgiC
 TW7IIdakTMCPIgEP6ibJZt2yl0REjV07gABNgoiVH6GCJ10CJJT8XTBg98RnKr2nr/OglmeXHcl
 tZy0gPau9uRJGM93e6kP09W+p1HaQFVL6MUdmxzPeHBTrDR6ddaSHI7Vdc5EfRq6xvFokYnAwcb
 BrUh81box0oy0qzFNmgT0iGU75IzVrOUuFUj4Yx7zflPtzLeR/cU2UWh5
X-Google-Smtp-Source: AGHT+IEiv+LJHJ1Yn/obZ6afL5QOdUhoCNGsyqdIWtfNYp4gWu566tH7NL+iDzsR3h9d5Rs2w9Zo4g==
X-Received: by 2002:a17:907:9612:b0:b41:b0c4:e74c with SMTP id
 a640c23a62f3a-b50ac0cc075mr2662316466b.33.1760440357185; 
 Tue, 14 Oct 2025 04:12:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d952a273sm1156506666b.83.2025.10.14.04.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 04:12:35 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 40AB85F82E;
 Tue, 14 Oct 2025 12:12:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 2/8] system/memory: add memory_region_finalize tracepoint
Date: Tue, 14 Oct 2025 12:12:28 +0100
Message-ID: <20251014111234.3190346-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251014111234.3190346-1-alex.bennee@linaro.org>
References: <20251014111234.3190346-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
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

This only traces named memory regions as it is otherwise quite noisy
every time the address map changes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 system/memory.c     | 5 +++++
 system/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/system/memory.c b/system/memory.c
index 8b84661ae36..fd7c3192ed4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1821,6 +1821,11 @@ static void memory_region_finalize(Object *obj)
      * memory_region_set_enabled instead could trigger a transaction and
      * cause an infinite loop.
      */
+
+    if (mr->name) {
+        trace_memory_region_finalize(mr, mr->name);
+    }
+
     mr->enabled = false;
     memory_region_transaction_begin();
     if (mr->container) {
diff --git a/system/trace-events b/system/trace-events
index 82856e44f2e..a8ef2326e14 100644
--- a/system/trace-events
+++ b/system/trace-events
@@ -23,6 +23,7 @@ memory_region_subpage_write(int cpu_index, void *mr, uint64_t offset, uint64_t v
 memory_region_ram_device_read(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_ram_device_write(int cpu_index, void *mr, uint64_t addr, uint64_t value, unsigned size) "cpu %d mr %p addr 0x%"PRIx64" value 0x%"PRIx64" size %u"
 memory_region_sync_dirty(const char *mr, const char *listener, int global) "mr '%s' listener '%s' synced (global=%d)"
+memory_region_finalize(void *mr, const char *name) "mr %p, %s"
 flatview_new(void *view, void *root) "%p (root %p)"
 flatview_destroy(void *view, void *root) "%p (root %p)"
 flatview_destroy_rcu(void *view, void *root) "%p (root %p)"
-- 
2.47.3


