Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90995C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdW-0001Qj-Hn; Fri, 17 Jan 2025 08:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcx-00010f-Vj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:12 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcu-0002DZ-8u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:11 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5d3ecae02beso2971924a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121383; x=1737726183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rb1csLfisilYlMMpbSH0eapexTVsqPhs+4Rx9cZ9jUA=;
 b=dnMYejfMVR0ckOSJZ1rNCRwJvRiJL0ojjUEt561/Sj1I6tAg1+JgX93ydWy5Z0Oy7+
 NJjAD9XA20duIP3goV0ykr6C5aKksj85jP1LXh9msseboAJXDo3cugohFYwJDUPfRlmI
 ncA03WZh3n2ACTk+/x2lFSV5xbXYJJP5X7dVZoc2r6l6PoJqS2OMEBPMDnY5dxX+m1tG
 JMzGZ3vM3JtBcbolvYvsnSPwSNBp4OsRn8VCIGakCp+a5qdO1aDjKIrBn33xVsMUPud5
 rWAYtUpy6aHfTn5X1VUSmsAYhzKiYnLyTqa3w3RklykgmWOhJOr4kQqFQOWtI2vGq6Gb
 ISeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121383; x=1737726183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rb1csLfisilYlMMpbSH0eapexTVsqPhs+4Rx9cZ9jUA=;
 b=AZCr5G/kNzW8xJS+HEIOf/una13V3KWn1nz4vlxiujFGQZHUErNtkhVc3RtRh0v6rA
 RpyFbgzri00Uy7eKPdZdtazfOsYuvHU2utlguEXzoi1T0iulLkscw+BHJ9Lk4JZhsRnS
 I1l3Vb+G4wgCYJ8ksoJgqKktKa7dgKPRZAggARzaUA8NRtB2VBWtRZoxre3cl4kptdwO
 8oKMHil61Xusf0V/WzqGc/N6Rx2WZikFbQj4/c7nbE3ZCdbSeQ3S5Xo4h8rtR5UsvzmI
 DmuSYPEf1GAH8iya93pyhW/s0mypZFfPFP+EI6vZxTAsFIwGWBoTApu03qS8DeN9km96
 uigQ==
X-Gm-Message-State: AOJu0Yw7fU8IVMK6nOFZ88uKOLt+5S0XYUCv0hhgJs04ArFh3igVFmsl
 chRiMWuQfe7rIsP2zOdJMk5jqVhZcOSptFEbQtFmFrwsQnYDapJDlnfZq0YYc40=
X-Gm-Gg: ASbGncuIdFuPWG2Hap3MPfRgv46gZ11VZhGN4RAQx9+ZJfmTQ+fbi4DwHZNuYCNMpfQ
 0zu5OwA7ozDn9476EiMGfzLYN6fn5eZNZDqkt2E1bw7Fxzuj7MZ56IQWbwpZ+n9iXlWruClOFtM
 D/ARoPOdwBpmSFTjxcpQzL/MC9/bnrvfMRRIlY29+nOMIdoeRza+HDfRnIhvWKaqfhX759FUBV6
 mRE+lf2lgq9Tz83QedkqFivLbSg6WTDVI08J9uUm38LoS20lR/+nKg=
X-Google-Smtp-Source: AGHT+IFjic2K6eX6QM7Igrt+uv26WVQ8JvFG4qZLZpvUGAuUMGx5HeFfn9DM9OtfR/IEtLS1WO8Vvw==
X-Received: by 2002:a05:6402:50d0:b0:5d0:cfad:f6b with SMTP id
 4fb4d7f45d1cf-5db7d2f80c8mr2590100a12.11.1737121383613; 
 Fri, 17 Jan 2025 05:43:03 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5db73edc85fsm1517141a12.74.2025.01.17.05.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:02 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3F179608A9;
 Fri, 17 Jan 2025 13:42:58 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 14/37] tests/tcg/plugins/mem: fix 32-bit build
Date: Fri, 17 Jan 2025 13:42:33 +0000
Message-Id: <20250117134256.2079356-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241217224306.2900490-5-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-15-alex.bennee@linaro.org>

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index b0fa8a9f27..d87d6628e0 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -135,14 +135,14 @@ static void update_region_info(uint64_t region, uint64_t offset,
     g_assert(offset + size <= region_size);
 
     g_mutex_lock(&lock);
-    ri = (RegionInfo *) g_hash_table_lookup(regions, GUINT_TO_POINTER(region));
+    ri = (RegionInfo *) g_hash_table_lookup(regions, &region);
 
     if (!ri) {
         ri = g_new0(RegionInfo, 1);
         ri->region_address = region;
         ri->data = g_malloc0(region_size);
         ri->seen_all = true;
-        g_hash_table_insert(regions, GUINT_TO_POINTER(region), (gpointer) ri);
+        g_hash_table_insert(regions, &ri->region_address, ri);
     }
 
     if (is_store) {
@@ -392,7 +392,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
 
     if (do_region_summary) {
         region_mask = (region_size - 1);
-        regions = g_hash_table_new(NULL, g_direct_equal);
+        regions = g_hash_table_new(g_int64_hash, g_int64_equal);
     }
 
     counts = qemu_plugin_scoreboard_new(sizeof(CPUCount));
-- 
2.39.5


