Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29CE7CC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvN4-0004ML-9X; Wed, 14 Oct 2026 05:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvN2-0004Jk-52
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:34:00 -0400
Received: from mail-dl1-x122c.google.com ([2607:f8b0:4864:20::122c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvMz-0000YB-2l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:33:59 -0400
Received: by mail-dl1-x122c.google.com with SMTP id
 a92af1059eb24-15dd124bbe7so7348133c88.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970436; x=1792575236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yB3NWO2pJlVWPSGtlDu3f8MOoC7RbZF39joZfz1c1og=;
 b=mVYC+Ti1k+9o6cByT419DUh/KOz9tLGXc/2PSBVNdlImw4vaKMRdW9jqTWJOGEaMzv
 putafJy8sTueT+LRqjDT7CmBlZXnACeExk09iTxGS4vjEJx4gH4C0bTFw+wOyQ7lJjCF
 ZgV6PRRBRPPr2WCQzfvL2/i38sQsBtuzwlBEAufLnGpFOifxPh+QuME4Cdm/LBp6GiHP
 3MhC7qjhoipT5FytPQLF61Fjol1B8tIuEiArGegPncXX6BmabtP8lBHuTEU02rg9OcHP
 AdnCW8pyQ1SxUg0gWOjiIXLucCVw2Dqs6FBkBbi7HoCdV9gz/31hG7fb0CN7MAAgPw5c
 /SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970436; x=1792575236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yB3NWO2pJlVWPSGtlDu3f8MOoC7RbZF39joZfz1c1og=;
 b=Cv9Rf32PSRConOwdXB7GTM5tIket6ik1zXYxm55kEyMy9zmnw4uoX1n/83eArMCQAB
 hClyh3Md+7oVIQbFGigkzOP/zIen91SoLMUwt/qdLEyy1utiSx+PEIm/kbaI0jTRWpKm
 5ANdPrfzNi5YAKvzdQHj+N8FDdO9rbL10HYGC35IwfbBkitIP6fuOWV6FCY2CgsEYjuX
 bNERqkVcVPYhGCfyVcMsyc/JWGGrs9VNlu2iGfmVW3OmHeEQow11wxh4jPfpQhH9iw/S
 9KJOG8OMECovB83heTEejamkw85BJrQmyFsgrtSYsFNxnHQ0ySfcnksp110rxWTJZel4
 5sAA==
X-Gm-Message-State: AFq9FYJQSY28rO2cCJX++DqNcUjnpVmhg7gc7hxg2LJNrqI3xrc8Vc5L
 scAtRi1lvpRQcBexGaVHVVMHapxMpO0h51q8vAAjsf6asdhWhzYJf+xCaoAPdsQmoCw=
X-Gm-Gg: AYBFou3d20cVBOIcjzN9etSbN83PLAFnf6gBk84iTkS5Tz5PQkV5NmHGgnlG+/ZAcyJ
 ceacHay9JlryXAY9bbGbcIbz+VdNy1h9ZPILskekWPwkupzTiD9/ecfH25/u71RM7TZvqTJi5zz
 clxtqyVJk0MSSTKwZmuj/ErD/SJPJX5R77Ep1+Mb5kzXuK/E54Udc/kgq1sjyUkTu+ocmbyjLFd
 UOqBIRM3XL06lVB5s8Qaszh5x159V4zLZLjYfzdI1eCFcN7OXXY6iNiTVbdgmioXNJ2xiWbbGDA
 IA4uaugQTUT4XCT6R+F7Zv2sOcrL27WAEXXXc9F85QHDBrK9KEudl8KONG5Au3HikehyUwDahZA
 ZaaNj8Fyr3HPGOWU5Ju9icqI7CxPv73pYfn56UgSSzV6CaU8wC0tz71jJnnvhD1ixG8ecMx13/Z
 rE/MK4hGFofEkA9VHTIqalRsYxxyq6MN562Y0ckz3E/5L7h+f3Vy1e4NQbwIDA2uycTw29fkoMG
 dpKHMzHQg84zHDhvg==
X-Received: by 2002:a05:7022:1706:b0:144:c122:6cc6 with SMTP id
 a92af1059eb24-16a5ec48b8amr22398014c88.32.1791970435513; 
 Wed, 14 Oct 2026 02:33:55 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.33.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:33:54 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 11/34] module: Add module_allow_all_arch for allow all modules
 be loaded
Date: Wed, 14 Oct 2026 17:31:21 +0800
Message-ID: <20261014093152.834-12-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122c;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In multi-target qemu, we want all modules to be loaded without condition.
So add this function for latter usage.
Add this independent function for decouple only

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/qemu/module.h |  2 ++
 util/module.c         | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index fccf017bf9e..6268c3a8d75 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -100,6 +100,8 @@ int module_load(const char *prefix, const char *name, Error **errp);
 int module_load_qom(const char *type, Error **errp);
 void module_load_qom_all(void);
 void module_allow_arch(const char *arch);
+/* Allow every arch-tagged module without selecting an architecture. */
+void module_allow_all_arch(void);
 
 /**
  * DOC: module info annotation macros
diff --git a/util/module.c b/util/module.c
index 8f8e6994f11..b7253fbd065 100644
--- a/util/module.c
+++ b/util/module.c
@@ -119,6 +119,7 @@ static const QemuModinfo module_info_stub[] = { {
 } };
 static const QemuModinfo *module_info = module_info_stub;
 static const char *module_arch;
+static bool module_all_archs;
 
 void module_init_info(const QemuModinfo *info)
 {
@@ -128,11 +129,17 @@ void module_init_info(const QemuModinfo *info)
 void module_allow_arch(const char *arch)
 {
     module_arch = arch;
+    module_all_archs = false;
+}
+
+void module_allow_all_arch(void)
+{
+    module_all_archs = true;
 }
 
 static bool module_check_arch(const QemuModinfo *modinfo)
 {
-    if (modinfo->arch) {
+    if (modinfo->arch && !module_all_archs) {
         if (!module_arch) {
             /* no arch set -> ignore all */
             return false;
@@ -400,6 +407,7 @@ const QemuModinfo qemu_modinfo[] = {};
 
 void module_init_info(const QemuModinfo *info) {}
 void module_allow_arch(const char *arch) {}
+void module_allow_all_arch(void) {}
 void qemu_load_module_for_opts(const char *group) {}
 int module_load(const char *prefix, const char *name, Error **errp) { return 2; }
 int module_load_qom(const char *type, Error **errp) { return 2; }
-- 
2.55.0.windows.3


