Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF18CCD18A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 15:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7EmZ-0000hG-3g; Fri, 10 Oct 2025 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7EmX-0000g6-S7
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v7Ell-0004Cg-Ep
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 11:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760109053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLAzjRg81thfU2aBxeIBMEWinBk0XD4qCND6oGCuTHg=;
 b=FBKKWJARpYzarLA7ixMWQoqafmis43RUqd1FCdhutJyndXXQ7+GAssfTZfGk5Rk2GbsZy+
 5iWvkv7ct1V21XkNWOHjcblawx3WNK+Oq3vVegrChDCY67ksjxb8fm8FVj/JiRWBXT9cwp
 azm++0cR/pelsrIyz8LHfuIuuvf4MUU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-DzONFOBAOj6rcHdnEwOWVg-1; Fri, 10 Oct 2025 11:10:52 -0400
X-MC-Unique: DzONFOBAOj6rcHdnEwOWVg-1
X-Mimecast-MFC-AGG-ID: DzONFOBAOj6rcHdnEwOWVg_1760109051
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b4af88aba57so205999066b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 08:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760109051; x=1760713851;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qLAzjRg81thfU2aBxeIBMEWinBk0XD4qCND6oGCuTHg=;
 b=V/dsYAL2dxmsTYELjBofOuIfHrGblHiNvuiUd9wyrmCMduVsLzVDYB786SKQiumPaB
 cFsgv7g4zDw36BBtXgVKBzE9I66CE/hEqyKTiSleSBbSq8SYrS8T4eI6FYT/ezYLa4i7
 NE5mAFKaEIO0FPik1GiOrMd61n7GDdy4h0eZ57l1AiutAOc+mgt2YjMh83USunWImGy8
 UboP9NM99v6ELsFMu6ccDlZWIbyvruygfCLmyUi7rh4ecO10KcMImiLUkxjD2xmr+DI1
 efa34tVpAW6UNtkLmJ3pNS8KexU/7/pT1LayZMaQuQVzCAtkrWUkatVSEg+mfrMvX608
 fDbA==
X-Gm-Message-State: AOJu0YxJCI8qvhbpV9ecGRtQEhoT19dml6GXMVpdaDR4m9oLfGRNpWJO
 k0jPHyP8wFQUskqZCH1kyTEhSBEqD3vYeXrdZ6dtz41CzM14IBrW97dlDGn4wxB1Mu3ElbIXnXp
 cJL4Y81tzlpg5y6FrG/p4mrf+QQ9j+QwU29VE1/kM09xdrbf9jxydjZ1THTIWPciOyMb28itAEO
 S6ibDtfrIMh6/XgWzfSCdA1QcXSDBP9wWYrXxgOvqY
X-Gm-Gg: ASbGnctsbH9BwyJWMYthkOaJqFH5AloQHjN0LVr1RaQAhUC6RN0PxCiTdP76CDTC0Zq
 d3P5i4MACilcK06XUeet2wUSeGBpVvroTpHUSKsNGTZV1CqbuAjXhH8uSRiQcqrtSPTXvPUVel0
 YppNld+OYcgKY8Ek0TmyFBKCA02EUVBhMINPNZgrHfB4tvjwIB33lIXqdc2z4A0sumADBJ2FonS
 MbS9vqJkapWKLPcGmBeIxFusJa6NBrKpeB498Yan1nWkz2iAAzqoNGZHnEkbNrrVdURAPMVn/fv
 8F+AsySacd48eUD8HmBvuKmuH+NO1VFrK8yHfQO5meyJI6D8tNchg+hXySNI9Iow9l6ZjD3B4/l
 dLsxDJLntgG/UWsECwQXkDWSLvtK48LUHUmFqMjWS4s16
X-Received: by 2002:a17:906:c144:b0:b49:b3ca:52b4 with SMTP id
 a640c23a62f3a-b50aab9d64amr1227764766b.23.1760109050848; 
 Fri, 10 Oct 2025 08:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5BpqB1n7IwGrSa3hxTlnzREuidDabK7inECo3W37egXG6QpbbHe8MINppXAIxIGHcsa7Kpg==
X-Received: by 2002:a17:906:c144:b0:b49:b3ca:52b4 with SMTP id
 a640c23a62f3a-b50aab9d64amr1227761266b.23.1760109050433; 
 Fri, 10 Oct 2025 08:10:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.231.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b55d8c12978sm253961966b.44.2025.10.10.08.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 08:10:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
	marcandre.lureau@redhat.com,
	qemu-rust@nongnu.org
Subject: [PATCH 17/19] scripts/rustc_args: add --no-strict-cfg
Date: Fri, 10 Oct 2025 17:10:02 +0200
Message-ID: <20251010151006.791038-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010151006.791038-1-pbonzini@redhat.com>
References: <20251010151006.791038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


