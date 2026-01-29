Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A913D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyK-0004R8-VA; Thu, 29 Jan 2026 12:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyJ-0004La-2S
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:23 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyH-0000dG-9V
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:22 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-82311f4070cso888285b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708300; x=1770313100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFfpq1J2RUXikSVjEKqIoQu5VVhghr8XYjp2Owizq7o=;
 b=CHC71q+RShKtSU2T18/N7Jpg460GbbdYtCXpdaVna5tmcQ4+MvNVpP+SbSMiYrHWIO
 0RTSZ4+iUP4CQ17UzN9/mypBLLugPEo1x+/kq/ywvs5BZZhiyhKLtchTQMTLh35b2YTJ
 v6qcmmefhBx9Ak2hXivNs6xpsEQwExybiEBiPOin+aCYWVxfuS6oe3N+0HqxPOkn9ZP6
 VjtSzQ6dhRLJgAOVtCn4GS2PxQiw1kCMlJgEUmKdlucErwdAVM1g6myLyyYG4f+RZdYL
 CByUvFVfwu+ZknmpOIjxpta0jIsn4IAsd5K+eHOoNss5gj6fHxzDYPRFdFuf0K2vK/MQ
 uGeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708300; x=1770313100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFfpq1J2RUXikSVjEKqIoQu5VVhghr8XYjp2Owizq7o=;
 b=HbXEJhAy3wKUKtwJezSbJa6P8ogoPvfprSzu0ixsm5kVvxAasVDStpgony6diHD0i1
 DWkpTEELc0DY8mwAxzrPqYeHDVKTAKw21/YN1U1NzevB6CCOINBmdbQtVOlomKtp4Crc
 8V7pJf27K+/VxnxdEsWXAvhWLSUHPlfsdbn10hS6/5EIJ/S++5p3z7miscw5+fjrb77a
 lNT3FC6RvsBr7ux/bPImkUz6svLY4OnQsKOgWjueI4YQo/uN5yjRnflZo+D2nmdxw702
 RmrrKUgee3Q/VTWv0RuxoMB/WkrbneuPk9ZOI8luEsn2+SgQlyIr4Ib1Z9t4CJqzINmt
 nwcw==
X-Gm-Message-State: AOJu0YyoJo1kirw7meqWUlNkVm/jvGKm97hZxEc/gXvxuSLTf0TC4AX/
 Eg1fm94SZRiQyzk2srBA8WRtj5ZQqoYoEMZvWn+ObQ1vOlCqWKLxBJXiKR89zAzDudW0Cu0uATz
 8TKhs
X-Gm-Gg: AZuq6aJFo0eJ6zJTIH4uPU9/0DNCUIZb/d2FKCRAV0mKmCGHhf45b9NpLxENhbF+Biv
 MvUvfuG3k585AZPCgAbo0sw8w9pB1qi99uw76uN6x+fvrEJeyu+8+AQjjd97YMWjbFJEXbF0Cnq
 9EJ+65LYfzEPGm8WX1wVxAImxkKzLFZn9kYHyBUUZPJtwLbt/C/RqJNVa31XDzgyPIIWTjQlxtX
 Oeuw6au4jHXFwurMQq/tjW5EH8smCbuNI2IubWOBQzF3KYM+X0MlfStJos1moGZMezzdn6rSlMc
 HmRb0KYyxPKLlDFeXAO7PU53Z04K+5LACQnZaeagH5PGHfo0qzMb0QTYUCCTmMRUimfUuMeiRFV
 C0O3XTb3QQ3KwsJCEllnMrMWpf99HlXjVGD4UiaGL3o6L4iA7fab72jyiNAkgeesWgMYLGNiONh
 pVI2HDvBQVXeWkaEI8ivA4yfx+n6nEvcjXv/KPg/H1sHeBPdpCI/mcd6LAVsJGG9Qy
X-Received: by 2002:a05:6a00:a209:b0:81e:4a9e:f809 with SMTP id
 d2e1a72fcca58-8239201d9d9mr2944656b3a.2.1769708299571; 
 Thu, 29 Jan 2026 09:38:19 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 03/21] contrib/plugins/hotblocks: Print uint64_t with PRIu64
 rather than PRId64
Date: Thu, 29 Jan 2026 09:37:49 -0800
Message-ID: <20260129173811.138036-4-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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

From: Alex Bradbury <asb@igalia.com>

qemu_plugin_u64_sum returns a uint64_t, so PRIu64 is the correct format
specifier.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/5d26c9d99ee87ac4a4034ff64e3d8881253eedf3.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 contrib/plugins/hotblocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index cf4d6b8c363..40d8dae1cd3 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -87,7 +87,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
         for (i = 0, it = sorted_counts; i < limit && it; i++, it = it->next) {
             ExecCount *rec = (ExecCount *) it->data;
             g_string_append_printf(
-                report, "0x%016"PRIx64", %d, %ld, %"PRId64"\n",
+                report, "0x%016"PRIx64", %d, %ld, %"PRIu64"\n",
                 rec->start_addr, rec->trans_count,
                 rec->insns,
                 qemu_plugin_u64_sum(
-- 
2.47.3


