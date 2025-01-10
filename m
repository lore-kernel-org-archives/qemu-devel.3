Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32016E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 18:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWK2W-0000NJ-Ot; Fri, 10 Jan 2025 13:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1l-0000BD-Lo
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tWK1f-00014l-Nz
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 13:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736534790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bvl+J5OWotTQVBe9dRZtuqKB1fUaMLXq6FgWP0i2SqQ=;
 b=AVOwjwfctDqborLU+NQHemSECpbDguGEZ5Jwug8g+4JYVsuL+CzzbkcbTlytcrfELxI/P2
 vYnv+0BlDbl/LlptF+03N6NQ+nPGmLhL7okJHr5LIXZaubtLM0Mu+Ydwp+pNOWGheoldQW
 V7LgyXGpx2cqH9YFgeGi2oSAD2ApNxs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-aJMt2ZhWPM6K5hMeXB7FMQ-1; Fri, 10 Jan 2025 13:46:28 -0500
X-MC-Unique: aJMt2ZhWPM6K5hMeXB7FMQ-1
X-Mimecast-MFC-AGG-ID: aJMt2ZhWPM6K5hMeXB7FMQ
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aaf8f016bb1so201318366b.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 10:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736534787; x=1737139587;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bvl+J5OWotTQVBe9dRZtuqKB1fUaMLXq6FgWP0i2SqQ=;
 b=bC9VS2r+kzx0A0P5+b/457a1bxXbD/qOiwhKXfbIf61/8yuVqMKoKYcNE175w/z675
 DCzZ0edMV7hDDvS/igSrBx1Se5Z8YnEeC4x820EKot58I/bh4qK0n/U5cCuM0qwePdyk
 qdzRGQA5powzHHoa9oiuEkY30pe+AYV0XB7rVnKqvzq1QVDkuo822xAZCV4CorOJoc+k
 SZv/bESk2YQJ6RCNPw1uf88pXtiUEI4DFu6/ibV4frsr/RxWm335XrYuv3YRvVdQlLS7
 Wt2K1Tyvj7D9ATUKlqy6JIbbIy5jcevHek6QgWtv7Zv/ArBA5ER/sq8rzZshNdpdJ+ZN
 ZUwg==
X-Gm-Message-State: AOJu0YyZuRocyfJotzGsCLGqqS1urpBEPvCdAcwrrM2zHk6O1wZvhdVe
 c59AO23jWyd36r/xSnxtOVUFJRqrMTKSFMkDxJUM1zFlY/+fdsnKD3da/jsLGQLuXqq1uM528DZ
 +j/c0/dbbBFlYLcqWmBFz6l3iJ9ZaSvK0hrtXpDWkXFTiGvPtKW4p2AJPslwwnLRsUmq8DgMmZ5
 8uI4wLLwFrp/v2jGrkr7VSnU6eQc+GozueOOZjB9A=
X-Gm-Gg: ASbGnctLpn3nNF+0QV7n0sxknmky9IzhcTDO+5SuLIp00CusedcITeARo1cGH9pILcq
 jlBxshdx7/vLQcTokVynArqvxx1E+DM9utaBq5wx+KKJMfcLzTotNGaz61Rfb7b0dG0l1vBI0oF
 TEIoLYwHN92V4pfc+EtRBftUv90EQ8xR1/GgJU2dY2PZ7mANESAgkwVsW5T6U3aG/H4+tqgNvd8
 tha0kdFswLhBCq9SRGwCqrDxlrj4s9L8xICCgF4a2hKBJTRhGY7JjV2Zk4=
X-Received: by 2002:a17:907:3f09:b0:aae:fb7c:50df with SMTP id
 a640c23a62f3a-ab2ab748e82mr991966266b.36.1736534787122; 
 Fri, 10 Jan 2025 10:46:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IETwfDyaxMZrGSGbeuDJn19ywgfYAs+GwWmw7sKA6LISg7Ak3qlCOW94eLTAfAMu3D8MFiSzg==
X-Received: by 2002:a17:907:3f09:b0:aae:fb7c:50df with SMTP id
 a640c23a62f3a-ab2ab748e82mr991964366b.36.1736534786652; 
 Fri, 10 Jan 2025 10:46:26 -0800 (PST)
Received: from [192.168.10.3] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c905f04fsm193136266b.27.2025.01.10.10.46.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 10:46:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/38] rust: add --check-cfg test to rustc arguments
Date: Fri, 10 Jan 2025 19:45:43 +0100
Message-ID: <20250110184620.408302-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110184620.408302-1-pbonzini@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

rustc will check that every reachable #[cfg] matches a list of
the expected config names and values.  Recent versions of rustc are
also complaining about #[cfg(test)], even if it is basically a standard
part of the language.  So, always allow it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/rust/rustc_args.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 5525b3886fa..d79dc6d81f1 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -215,6 +215,8 @@ def main() -> None:
 
     if rustc_version >= (1, 80):
         if args.lints:
+            print("--check-cfg")
+            print("test")
             for cfg in sorted(cargo_toml.check_cfg):
                 print("--check-cfg")
                 print(cfg)
-- 
2.47.1


