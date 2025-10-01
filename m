Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A6BCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rmg-0005rE-Sp; Wed, 01 Oct 2025 04:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rme-0005qa-QU
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rmH-0006Aj-0k
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLAzjRg81thfU2aBxeIBMEWinBk0XD4qCND6oGCuTHg=;
 b=bUoc/QYPgHSE0au++hk2DM+FITxBqpdkkOk51Je/RMDH6fvYcClOfktXVdPCOhczUl6KmL
 apJ75vg/as2zSt3jMc+nBrJhTvdFR8wqGamQEIHtttII+GaynK9zsRnFFbIlL9dlvqvLVb
 3i/dIT1zKi9Sdh9YmxfKjh7lSDh8mh4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-7n_3FAGKNUukRvx1YSdsAQ-1; Wed, 01 Oct 2025 04:01:26 -0400
X-MC-Unique: 7n_3FAGKNUukRvx1YSdsAQ-1
X-Mimecast-MFC-AGG-ID: 7n_3FAGKNUukRvx1YSdsAQ_1759305684
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-aff0df4c4abso720763066b.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305683; x=1759910483;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLAzjRg81thfU2aBxeIBMEWinBk0XD4qCND6oGCuTHg=;
 b=mOG9rcl/TixMXZxDOxgTkcjcLeYfjqzK0ci/nCsWfZmOLLZDa3Wa+tOWyILgOaGPpM
 gXKKUIk4bypHlz+y56nMcl5YS+JhG0mv35muI2KLkKW0DEY6KORflARhbteX5fQlJh0Y
 6kOn8rVMH4Wt7aS/zv+eo5FWr8GBap1HkzIWiSBG/cuuzhC5uWLx9z+ZXWc5Avj3Ggdt
 PQvYss2h/+XzaT0Pz3V8g3ksssh6x9XFy4vXNZ+lvyuazIbw7X2sYhKOJ2DZqx+IUAJL
 hH5gOxI02hvC1TK9teZyYWZZF4WoSNUTWpz7hWZIZ+5VkXp3HpJiizEOtBfgYP5qCdCx
 6leA==
X-Gm-Message-State: AOJu0YxEjKPPgPvK1ISkDJmajkA0KKAHO1VKcb3RIAhU7XYUE0rn47Nl
 RfFuMAqap80EqQWg1p4sef/bN11oujrwiwUpeapv/hAWJCMxnRUNqT/3HAZZmKGRGhbkijBZnZ0
 MtraYKfgJZtCfOfT4ikhsZWZLNRcsKnIw7EdfuagEXZRxIbqM4O9KkekrGfNfpKin0HG0TL4kos
 AHyFN6veesiB2Yj84W+X6P9s2ahcLJG31jwRWsjxWv
X-Gm-Gg: ASbGncvnt6JfiNIZLuilFBde/Wxv+AMT9r0ZdJaRmXCBDQizcK4+WYEJ+HLZ2OiBZhz
 gYR6ntukweDuGTPtnipM9vXwqQJ4bHGayYY3qrGusNhwq3NSMuHH1QBdgqizLm4P636hj6wCsdB
 zj0i1YuXvALLTlM3jhanac/XwH8NBeAqKV5nUu2PwuJ94u1dpk/dttd1gGiujz2TAzIXrJ78kVw
 TQoKup+Mo0gHycr2IM7wDi/PHbIAZ2qAtlXKzD/PHGv+RC1pT5JuQdLZvQPjLyCaQkrJ2JGpkW0
 Zklv9XyPI3xTz/bgfVOztZRWL5s2u76MfCx8GFjjOwE0FeEEeUUJt8LU+x8CBsQUlKWs1Z/47Nu
 fv4M19s9W+94Y+ZFS51g39wrUETO1uhg6m5ng0uZV3lty0n/W7F4=
X-Received: by 2002:a17:907:da5:b0:b41:8e8b:5511 with SMTP id
 a640c23a62f3a-b46e585d0cdmr314367566b.21.1759305682710; 
 Wed, 01 Oct 2025 01:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2p8hxBFSZvS+u8hwtc3bYA1wuLwOAQjRkgrNwDKcnE/ZqMAb64+QiThthVclVZXS651bgWw==
X-Received: by 2002:a17:907:da5:b0:b41:8e8b:5511 with SMTP id
 a640c23a62f3a-b46e585d0cdmr314362066b.21.1759305682147; 
 Wed, 01 Oct 2025 01:01:22 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f57c9c2e2sm556156266b.68.2025.10.01.01.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 01:01:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH 12/14] scripts/rustc_args: add --no-strict-cfg
Date: Wed,  1 Oct 2025 10:00:49 +0200
Message-ID: <20251001080051.1043944-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Allow to generate all --cfg flags, regardless of Cargo.toml content.
We can't easily list and include all the features used by QAPI types.
Access via #[cfg()] then requires #![allow(unexpected_cfgs)].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/rust/rustc_args.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 63b0748e0d3..c70b95b8bed 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -116,7 +116,7 @@ def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[s
         yield from lint.flags
 
 
-def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
+def generate_cfg_flags(header: str, cargo_toml: Optional[CargoTOML]) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
     with open(header, encoding="utf-8") as cfg:
@@ -125,8 +125,9 @@ def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     cfg_list = []
     for cfg in config:
         name = cfg[0]
-        if f'cfg({name})' not in cargo_toml.check_cfg:
-            continue
+        if cargo_toml:
+            if f'cfg({name})' not in cargo_toml.check_cfg:
+                continue
         if len(cfg) >= 2 and cfg[1] != "1":
             continue
         cfg_list.append("--cfg")
@@ -194,6 +195,13 @@ def main() -> None:
         help="apply stricter checks (for nightly Rust)",
         default=False,
     )
+    parser.add_argument(
+        "--no-strict-cfg",
+        help="only generate expected cfg",
+        action="store_false",
+        dest="strict_cfg",
+        default=True,
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
@@ -224,7 +232,7 @@ def main() -> None:
                     print(f'cfg(feature,values("{feature}"))')
 
     for header in args.config_headers:
-        for tok in generate_cfg_flags(header, cargo_toml):
+        for tok in generate_cfg_flags(header, cargo_toml if args.strict_cfg else None):
             print(tok)
 
 
-- 
2.51.0


