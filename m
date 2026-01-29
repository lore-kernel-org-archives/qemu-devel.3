Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EA3D73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyY-0004x7-7Q; Thu, 29 Jan 2026 12:38:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyU-0004t9-Ty
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:34 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyT-0000ga-85
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:34 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-29efd139227so8032345ad.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708312; x=1770313112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9iHm/DUI7LqRSDNNFCJrzlVWDCQyVlRHzHTsKps5Fks=;
 b=NcGs+uR09uOKCEk/M0jGteg6GrZDqXf86RPvA/iMxFaWNveVJXzvtmJ24ZUR9oHeJg
 DlBRzCI8+HFhtXP1mDO63QI5iLoWqUoRf2OEqlh+KEFF4kPwcXqQOEmTCmbWpYdw+bf5
 lpTbi1rn8dB7nmuX3m8UDnRjtdKCWLkg5cevNkb0tDGjP/WblKiFOfTb6pp53EtqInt+
 7rEfv76fTahKoMZpZYiHpf4XuljolJIAsz+TviyaDaep+AvwYdSrBLKVXrmIqjDSWdqs
 UUAzZaA4QsSEYsXYY1p7/giE0WJDYKY+cC1jaceJQ4qlrAWP+RhbrCDkWby4C6hVP37n
 qLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708312; x=1770313112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9iHm/DUI7LqRSDNNFCJrzlVWDCQyVlRHzHTsKps5Fks=;
 b=MxEw7wayE3vZIQHxyNGbowOfK0XT5lS9nIn+lh/hJGHNnSAffzYUMnpZm4caWlMhnB
 9hBdKWhuKn3Qz2oCabsM8doV60Irojz9zN/hxxy8zpa3VjHlV8eSi4jF5A0tXBHiG4hS
 wruvLbwjR0pHGIjSM0iQxODfcV1tUlwcqi+3zOsIZ4eLPyA576gTiFBnH2aUq/ShLLRl
 haJHMPdMK/t0atfQFTH/epW8/pmwzZDXsMdzOGnrMqj1tlXz7Pdi5Nc2ioYE0fUEOCQ2
 xj+gN1E5Uz7wjmXksZ2ssZ1gXKxD39WbbsM+2z7u8hO8z3Ue0oZOzj/4OSpDxpxAA/cY
 ydog==
X-Gm-Message-State: AOJu0YzTrQvyuPz2rptp/xL6t9tLqNLJ+TKgCRJq0zN1KPgJE5jHMzs2
 k5I0gJydw2NlT4uVgkM+3T5Op/eLLBcJK2LEDJEYsnut2Xi5dT9DKQE1kCPvOTRzzdXwJjYI/7X
 t/1wW
X-Gm-Gg: AZuq6aIox3tORMJgfDqevq/8+HziuWm1LDuWejKtY3ODkrRb2yRk57NPOXee1Io7u+4
 Hx7slCx3f0XOh2xf65bZpCSkNwQPKhcqHFlcnOk5ysXi2B5OV5gENEaxfz+Fqh5Kl+cJ8Tmo3PP
 RJrT9I8s28pkFpAX+V7UbwV0oBGeo5W3NmYD7kxZQ6ViIVC9AWmIR3aXbXlqW0mYJtfUIXom5XT
 HCfYS5ypjqAbF64AJtrnd8hGNUUOHHsj5shw/MQMCKgYwao6iGT612N2kEsPd0QUlF7Cndb/vtO
 CRGfALa/VpbErJWwJrVi8JPiaWiDTN50N+jflBiPNoKlYA7TutngrHdXP1uvCCUtFomsAtbxrQQ
 ac/0uQVMpqrQnzLFX3jwE+mxoKk0Xy3XH1wmySpX/pkdj8ke6meu+t5mTYpxzdto7PF9/5t6InF
 JT3gcyC3pQZQCJPF6gwrSNF5dpP0DlStUm16XYxFAn5d6Wtn6x2ISPSc+8BJHIA9Fs
X-Received: by 2002:a17:902:f690:b0:2a0:e94e:5df6 with SMTP id
 d9443c01a7336-2a8d81818c8mr998345ad.50.1769708311793; 
 Thu, 29 Jan 2026 09:38:31 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:31 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 18/21] qga/vss-win32: fix clang warning with C++20
Date: Thu, 29 Jan 2026 09:38:04 -0800
Message-ID: <20260129173811.138036-19-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

C++20 deprecated such constructs.

../qga/vss-win32/requester.cpp:380:32: error: bitwise operation between different enumeration types ('_VSS_SNAPSHOT_CONTEXT' and '_VSS_VOLUME_SNAPSHOT_ATTRIBUTES') is deprecated [-Werror,-Wdeprecated-enum-enum-conversion]
  380 |     ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |

This is a false positive, since VSS_CTX_APP_ROLLBACK is not a value
defined in _VSS_VOLUME_SNAPSHOT_ATTRIBUTES enum.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-10-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qga/vss-win32/requester.cpp | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 5615955b6f3..74489fcd0ae 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -377,8 +377,10 @@ void requester_freeze(int *num_vols, void *mountpoints, ErrorSet *errset)
      * To prevent the final commit (which requires to write to snapshots),
      * ATTR_NO_AUTORECOVERY and ATTR_TRANSPORTABLE are specified here.
      */
-    ctx = VSS_CTX_APP_ROLLBACK | VSS_VOLSNAP_ATTR_TRANSPORTABLE |
-        VSS_VOLSNAP_ATTR_NO_AUTORECOVERY | VSS_VOLSNAP_ATTR_TXF_RECOVERY;
+    ctx = VSS_CTX_APP_ROLLBACK;
+    ctx |= VSS_VOLSNAP_ATTR_TRANSPORTABLE |
+           VSS_VOLSNAP_ATTR_NO_AUTORECOVERY |
+           VSS_VOLSNAP_ATTR_TXF_RECOVERY;
     hr = vss_ctx.pVssbc->SetContext(ctx);
     if (hr == (HRESULT)VSS_E_UNSUPPORTED_CONTEXT) {
         /* Non-server version of Windows doesn't support ATTR_TRANSPORTABLE */
-- 
2.47.3


