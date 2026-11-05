Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D24606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 19:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LlCwEuDI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP2l5-0004rM-OS; Thu, 05 Nov 2026 14:04:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2km-0004qW-1v
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:04 -0500
Received: from mail-dl1-x122f.google.com ([2607:f8b0:4864:20::122f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP2kh-0003kb-QF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 14:04:03 -0500
Received: by mail-dl1-x122f.google.com with SMTP id
 a92af1059eb24-1ae18eb9b69so2347856c88.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 11:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793905438; x=1794510238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=am9rKxkmJI56O/AW/S6W/T2yFW6Ysjk6dcvPsZuNnUg=;
 b=LlCwEuDIjLBgEPFe2EA+SVwgTtVN1rwto/sa/KbYBOxS3yccZCVpD+Difp7HXnBl93
 wjeF0n5WKVZssmfmY8Vou+GPk6EPfDwHZyFBBD67RQiQlVzr3TnrsC2j7c3LH8zQPQCt
 KU2agXnJ9UdKS0ic/38Z7hay5diuddgXyQhOwQoC7WEzKgo111VmFfyn8LEyyFu0W2Qf
 wQ/WyptqiJdSf6hXwxOjpADNFxVaYsocW9/uPXEjgHIqiDOXn57h6781c9DznXXyNMa6
 4QxL0jpbQ8aC89cmhMVxxVbezAY+HizamFAR+wUyN67NXsjNv/2tWaOQU65OZY9RpYwx
 oTJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793905438; x=1794510238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=am9rKxkmJI56O/AW/S6W/T2yFW6Ysjk6dcvPsZuNnUg=;
 b=vFwGOpx7AaW0WYP1plsTtHb1s62yZ5S9mF7h+dyP3rSahfpFx+3JkkJ/zU30p3UT+h
 DZ5JcPo04E9VJUoci1wVT7BmHaz3hJdl8GusFvOZ6C4Rn9wLuaqxG8yDID6r8J6+gL5b
 FRkqNIvfCjK2pe1+Bi+gU/3051uMcJoQmUnKpvI03oez1Guti/YGWMSygqcMHvTxcuyu
 ZW1YsmPY04eIbCtYfrsqmOGjXwZ9UK6nCv2RV64BeXY+jZXlFz9qowjZYMU10+mN6Bac
 bTn4GxaENQE2ug3nydFnmi6D+cI8XtzQ2dKW4UzrrWg5eLhbpuwFB/48yklKpFH1dSgb
 baNg==
X-Gm-Message-State: APuU4Z9SAwuDVExOks/hsetV/0cYBwkkAg0gciJGaV5iBjCTakirMeHa
 zyt6n0rrxbrfX/3yCXWChfMbxuudGRoNFXjfnfF6r1iKCM2qc7n3NrU2n79WtNmiXZY=
X-Gm-Gg: AYBFou0PVf5fpyRJYC+rv10Nl1IKlJruqvvNbyQqUEESO6gzZiLlA0p3OyU/0FugaPw
 FhFxrXUnjVxAN5xonCpKkuPvXyUKOhOjGZF0QU3SQ0GqDy/acjLpTBhSnGBxAFa+QbaiyLDg6Y6
 ZXwRRJxchF6iYvyfmwYIVCAmdhCo9j2LYrG5DjaOveWz7Z+Teb7Kp59HhujMHMOOyg133rMYGKB
 yK0O2nPkItwES7GWdYEdWW0A5CyuGr0xKleBRWuqTxEIdcDIxBcWYnV8E+Bi5qxw8CzRf0tTNzS
 GvGZwsUrLh7Sd5MDie89leO0TmvCZfjb99F5S9oaE3RmQ9EZobD/QQip+gOdXOJu1ggOxKfsEAl
 fPo1ohobU3TIIGCO0oTfARVEV+PBSHEH/5wKHZ3wAjO0TeKwVdV7fLEDmUMy+yP+/Dl360s3usZ
 YpUAHHh0CYEfAcxwe65v2c4lpmXsqeYgUXG+z+I6+HsarLYs+N7Ah92fmeSa3dQlzs8E24eco45
 OMViNo/+Vd32BVZgwQc/tDGOAeYVHF2n/Hrsgh0uqZgwX80d9qSENcbcC6Ck0zIvmRtlPkqQICg
 GbccrAOmFPOQJbYdTjBQKt8fjbt1TO05TRaLyw3OD7hCVcmf
X-Received: by 2002:a05:701b:4283:10b0:166:f097:6f12 with SMTP id
 a92af1059eb24-1ac5cb1a303mr30062890c88.15.1793905437781; 
 Thu, 05 Nov 2026 11:03:57 -0800 (PST)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1b245c4706bsm22924284c88.15.2026.11.05.11.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 11:03:56 -0800 (PST)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>
Subject: [PATCH 1/5] qom: store registration targets on TypeImpl
Date: Fri,  6 Nov 2026 03:03:42 +0800
Message-ID: <20261105190346.1539-2-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261105190346.1539-1-luoyonggang@gmail.com>
References: <20261105190346.1539-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122f;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

type_new() and type_register_internal() take a QEMU_ARCH_* mask and
save it on the new TypeImpl. type_register_static() and the built-in
object and interface types pass QEMU_ARCH_ALL. An interface type
copies the mask from the concrete type that implements it.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 qom/object.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index cd0590c3fd..b7e1924e81 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -71,6 +71,8 @@ struct TypeImpl
     bool abstract;
     bool secure;
 
+    uint64_t targets;
+
     const char *parent;
     TypeImpl *parent_type;
 
@@ -97,7 +99,7 @@ static TypeImpl *type_table_lookup(const char *name)
     return g_hash_table_lookup(type_table, name);
 }
 
-static TypeImpl *type_new(const TypeInfo *info)
+static TypeImpl *type_new(const TypeInfo *info, uint64_t targets)
 {
     TypeImpl *ti = g_malloc0(sizeof(*ti));
     int i;
@@ -126,6 +128,7 @@ static TypeImpl *type_new(const TypeInfo *info)
 
     ti->abstract = info->abstract;
     ti->secure = info->secure;
+    ti->targets = targets;
 
     for (i = 0; info->interfaces && info->interfaces[i].type; i++) {
         ti->interfaces[i].typename = g_strdup(info->interfaces[i].type);
@@ -158,7 +161,7 @@ static bool type_name_is_valid(const char *name)
     return plen == slen;
 }
 
-static TypeImpl *type_register_internal(const TypeInfo *info)
+static TypeImpl *type_register_internal(const TypeInfo *info, uint64_t targets)
 {
     TypeImpl *ti;
 
@@ -171,7 +174,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
         return NULL;
     }
 
-    ti = type_new(info);
+    ti = type_new(info, targets);
 
     type_table_add(ti);
     return ti;
@@ -180,7 +183,7 @@ static TypeImpl *type_register_internal(const TypeInfo *info)
 TypeImpl *type_register_static(const TypeInfo *info)
 {
     assert(info->parent);
-    return type_register_internal(info);
+    return type_register_internal(info, QEMU_ARCH_ALL);
 }
 
 void type_register_static_array(const TypeInfo *infos, int nr_infos)
@@ -310,7 +313,7 @@ static void type_initialize_interface(TypeImpl *ti, TypeImpl *interface_type,
     info.name = g_strdup_printf("%s::%s", ti->name, interface_type->name);
     info.abstract = true;
 
-    iface_impl = type_new(&info);
+    iface_impl = type_new(&info, ti->targets);
     iface_impl->parent_type = parent_type;
     type_initialize(iface_impl);
     g_free((char *)info.name);
@@ -3239,6 +3242,6 @@ static void __attribute__((constructor)) register_types(void)
     };
 
     type_table = g_hash_table_new(g_str_hash, g_str_equal);
-    type_interface = type_register_internal(&interface_info);
-    type_register_internal(&object_info);
+    type_interface = type_register_internal(&interface_info, QEMU_ARCH_ALL);
+    type_register_internal(&object_info, QEMU_ARCH_ALL);
 }
-- 
2.55.0.windows.3


