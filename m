Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC829CAC58F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Sep 2025 08:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxLM6-0008FP-HF; Sat, 13 Sep 2025 04:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLu-0006zh-T1
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uxLLq-00055A-8G
 for qemu-devel@nongnu.org; Sat, 13 Sep 2025 04:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757751076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ABafy0vcY+MsNIbM2LnwMwiYEaVEtYekkYweL02toaQ=;
 b=BWog1mqK+ZWJ9prFlwnOWIMfMdEX9PjrXLPJ+uMIez7CHMqLdZA+4aW+Ga2Yj/7NgZcwz+
 BBp8q0Cp6N/vKsdZwCDxEHA4uw79plDQ2xcY26koW5QcPKFXNeWQgjBOKO5mRDoTAYCtfQ
 I1l9O0fHn63jx6D31M+8CKLoH1OrttQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-fyhBv58sMaOOTjNoFZ8G2Q-1; Sat, 13 Sep 2025 04:11:15 -0400
X-MC-Unique: fyhBv58sMaOOTjNoFZ8G2Q-1
X-Mimecast-MFC-AGG-ID: fyhBv58sMaOOTjNoFZ8G2Q_1757751074
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3e8c4aa37bbso114732f8f.3
 for <qemu-devel@nongnu.org>; Sat, 13 Sep 2025 01:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757751074; x=1758355874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABafy0vcY+MsNIbM2LnwMwiYEaVEtYekkYweL02toaQ=;
 b=MPYo6i+1QxyXbJ1wesZ+XCVgBV0xsZjE0wcPzNFl70ZttOKgPj1g0aoNlOye06s5tK
 Ze/b1Vjwp73OLgUkTOaJp30Vs+vkGJcQZEWlnidpovMj9WNh+HY0SN4soPn+DRzEkNWw
 jNYufhTUMxfnpSfkPaoqoiaUIylsXysO9/sdTjiIwWyfO+PmH6VhCtNKVkret72rSsOo
 6wHt6z+8NixinsljVV33zUbDKfhSFnJbi1SD2mVgNaEuYXfg0DSHS/r2ic7n9cZAvEPX
 RjVNqG8272qN0XYUEwwGBmVx1Q9JSEoikQQlfT1Gm7oI7d0Jwz1MXcz2AUtEbYATUs6y
 dO0Q==
X-Gm-Message-State: AOJu0YyPbI28LENIMZkao8qGCo+WZN0nqVad5DqpsIUUvlk/AU6nbh5a
 ar7V41GGB8Z5iirkyeGiQID96tE06MVVGj4pjxN7XWEUIBJQ97l5ZbSIDjGIfAK6tHztRcLjykx
 3hNFII1Fogn+P/vyR9Qb14lIfTin1Fl5G9jzgpBB2Y3C/3vn7NSQYpRpqr8+kzSWFsWeS8V6HrX
 g5dhe888QnU+kJn1hZFuMTAe3PudbZeGgR9IcZ1vKH
X-Gm-Gg: ASbGncuOG9yIIv6TWOztxG++j/9gbnm2UjmmYhpXTotr9hpasetZm0B8s0LWmocjzzl
 cF27KtoZ6gWlPDz/kCD1J7EyEnyHkhkHO2akXfiuaHioOMuc5QSZDFtDlAd6FjBFmwoizaHVkWz
 FAS/7fUtoNb2o5hCN4lE7GXn5s7qAsnHP4GbY47YDxoy6Yu6C/3/477A2aUrFt1Z2Wi0XCflULA
 Vt354YF4f9PyvF+SsbGvLwqxZs7na6qnUII6VAmC5qOwYzZYTlXidG0ZKMMp77eSYwrm0dbwAHp
 x5peh6mmM/GywBjzGLWAyPaL2g4MbK8eginNdV/TOXu5yB9TdsGGIl3yGSNlIEsrRJkkB8qr1kr
 z0Nw89jWkf/+A+VOwDBTzeh4YdbzC2G9CFnr2ZbmS+kk=
X-Received: by 2002:a05:6000:268a:b0:3dc:2f0e:5e2d with SMTP id
 ffacd0b85a97d-3e765541a08mr4721451f8f.0.1757751074049; 
 Sat, 13 Sep 2025 01:11:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL/reFYrfMgxcIPa/Kz0pokjli7R2KDTihRNIGDg0X4iNWf3JBrjvxqLlnzlqb08M5ZI7k5w==
X-Received: by 2002:a05:6000:268a:b0:3dc:2f0e:5e2d with SMTP id
 ffacd0b85a97d-3e765541a08mr4721426f8f.0.1757751073624; 
 Sat, 13 Sep 2025 01:11:13 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e037c3ee8sm94424185e9.18.2025.09.13.01.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Sep 2025 01:11:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 31/61] rust: add workspace authors
Date: Sat, 13 Sep 2025 10:09:12 +0200
Message-ID: <20250913080943.11710-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250913080943.11710-1-pbonzini@redhat.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-4-marcandre.lureau@redhat.com
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index d98d2b77026..cd4bf8ef8e1 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -15,6 +15,7 @@ license = "GPL-2.0-or-later"
 repository = "https://gitlab.com/qemu-project/qemu/"
 # don't forget to update docs/devel/rust.rst msrv
 rust-version = "1.83.0"
+authors = ["The QEMU Project Developers <qemu-devel@nongnu.org>"]
 
 [workspace.dependencies]
 anyhow = "~1.0"
-- 
2.51.0


