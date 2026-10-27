Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07CC606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sU/OzP3g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLf6u-0002tz-Qj; Tue, 27 Oct 2026 07:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6m-0002oV-TF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:50 -0400
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xLf6l-0002qW-BO
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 07:12:48 -0400
Received: by mail-dl1-x1231.google.com with SMTP id
 a92af1059eb24-170135e43c7so58943c88.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 04:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793099566; x=1793704366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8GlWAstPrLVj5RTiYsgPhO+NoWxl7rFc0krsJmLhq/o=;
 b=sU/OzP3gHaHaJmf6mDn6xNphvGr7Yd1F18VkeqLADMicKHErGH7rjJUJ0nAwaYBAcx
 axOc39dDw8oI9DwTllodrZl290Xot7wEBXymztoDCm11Lf2BRMhJ3TqHI82nJwSY6416
 zgzBQk+ftoWH/480KH3sUcIbf4rsRZ2Dhu7/bDlw/JJri9pHR04oSXsAJK5lLWS17jeF
 c7lfzF7GDNyaLvRC/71f6fNNs19nzuO7xIkwkqD5Hr9eTTties9kk4B++gd7/VUQ1HwS
 udS/6+sLy+w/q4h7MUiU8YTTFDi8PSVz6kN0uU6FyOgVib7oqqog3Zl1gnXiuIIEuINz
 lvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793099566; x=1793704366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8GlWAstPrLVj5RTiYsgPhO+NoWxl7rFc0krsJmLhq/o=;
 b=JMJ4k8ZB/KYaSqrwhhZ9cOma5LvRv06P/XzKwAcDWLquY/bHtsjYnNssyx/kziKIGg
 Hsh17AB0UGjV2cA3EEqtRWBT3zFytNi3rAgjCz+oe17TwqanWWe3gNjPQM0J6VQNkSCi
 WXltFhR5MSS7lRiZdfbmO3ZEPjkdsbypcuw6R9+6t+RzAppNBFEKRWThgASVKsDK5xGN
 scN5sWbA5zD5N3eX5rFALeiOVIvHb+74ncQlBxdME6vjVtSur2/DpMToe/O2RoxWw+zU
 Pc7RtAcwulsnhIZTuI+OmTUy+htrbtExvV/oQFZ3ifZITkDxU7I8A3nhTuedoZhcmAiI
 Kk/g==
X-Gm-Message-State: AFq9FYLLShkl1+GkKSBb2Izeg/CM97N8859swSCl5Q1Fjxutrp0S2PAp
 lKrmnvgiR0sjCgX9FECi2d7uKFTi2XCk8Fdmt2r+A1ykcDzfOz/C7SSkvpDG5f4u
X-Gm-Gg: AYBFou0tnyrVhTXXfOQkpZWwdAsJgZRMezf923Kyyw3ubSuxmNDD+EV2rJjvKeluxTQ
 WEuDpjt4yqhgveG0iru32VL77Gw6NimoLCiw52Sow7Pul5V6u3GmNJ6dhc0A+PWY+B3tnpBI9cb
 tY2E/krIOBN4FpzcC6FEcT4+Jt2t/tKIxQp1MZKzVBMUgPNQ0DKBzOgky/2SCflB8X523H1rAr1
 51PhHAzdsSEvLonZgKKYOGuZK30k9qVJMrvH5UcjwUexEF26ZlUu4pyVxfsBgD1qqAuaB+Krej6
 Ehi02GS+spVz2GCmM5xTp79axw7hBnaEErrv7QNzDIYXTfKYJON0ZOmO46/SfdrwotrVu76RHST
 WoRbYNWmNTH3trnrddidVXnjAFeFgdQMGWHGGCD8LYz5x8K5gfDukWdZXiX3MwmhrFMG2o6X1A0
 qMXAkhH1c+5aemPbStWJYkTMm1SN/jjhbAJiTr5T+aJQ7qarPM1M01h2z+9ElaVUxal+M9uquoQ
 QA0D72Rdg8/TkKFhLv9ZAjGIzfQLM5KvNvlUfy6R6MnSyHDLb7iZKkU6XQb/mQpH98QHlIeBUxx
 qW8jmHjPfL5XGOM46zmw+q/Wmn15GefLneA5C5ki98gnrx1o6kSCnGNtv2rzlDI=
X-Received: by 2002:a05:7022:f90e:b0:165:aced:1fde with SMTP id
 a92af1059eb24-1991b421e8dmr11740197c88.0.1793099565769; 
 Tue, 27 Oct 2026 04:12:45 -0700 (PDT)
Received: from WIN-BH9M8FJACR9 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-198a0f83cedsm40453042c88.13.2026.10.27.04.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:12:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Song Gao <17746591750@163.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Philippe Mathieu-Daude <philmd@mailo.com>,
 Chao Liu <chao.liu@processmission.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stafford Horne <shorne@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Eric Blake <eblake@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v4 03/17] hw/or1k/virt: move virt TypeInfo into its type_init
Date: Tue, 27 Oct 2026 19:12:01 +0800
Message-ID: <20261027111216.392-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20261027111216.392-1-luoyonggang@gmail.com>
References: <20261027111216.392-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1231;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1231.google.com
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

or1ksim_machine_typeinfo is a file-scope constant, so .name
has to be a constant expression. Move it into
or1ksim_machine_init_register_types() so a later commit can
compute the name: "virt" for a single-target binary, and
"<target_base_name>-virt" for a multi-target binary.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/or1k/virt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/or1k/virt.c b/hw/or1k/virt.c
index a3ff903839b..90916234dfd 100644
--- a/hw/or1k/virt.c
+++ b/hw/or1k/virt.c
@@ -554,16 +554,15 @@ static void openrisc_virt_machine_init(ObjectClass *oc, const void *data)
     mc->default_cpu_type = OPENRISC_CPU_TYPE_NAME("or1200");
 }
 
-static const TypeInfo or1ksim_machine_typeinfo = {
-    .name       = TYPE_VIRT_MACHINE,
-    .parent     = TYPE_MACHINE,
-    .class_init = openrisc_virt_machine_init,
-    .instance_size = sizeof(OR1KVirtState),
-    .is_available = target_or1k,
-};
-
 static void or1ksim_machine_init_register_types(void)
 {
+    const TypeInfo or1ksim_machine_typeinfo = {
+        .name       = TYPE_VIRT_MACHINE,
+        .parent     = TYPE_MACHINE,
+        .class_init = openrisc_virt_machine_init,
+        .instance_size = sizeof(OR1KVirtState),
+        .is_available = target_or1k,
+    };
     type_register_static(&or1ksim_machine_typeinfo);
 }
 
-- 
2.52.0.windows.1


