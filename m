Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36E17E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 15:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVBuK-0007Vp-3R; Tue, 07 Jan 2025 10:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVBuI-0007Vf-Ac
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:54:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tVBuG-0007QB-Ph
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 10:54:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736265252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bvl+J5OWotTQVBe9dRZtuqKB1fUaMLXq6FgWP0i2SqQ=;
 b=Zqzg4aZuS9qqa3adx8W8FxRmh3RIqpWQeW64Bo/47ljFhv4P2uE2LXKutcjmt2VPeJF+77
 oxhSthhbCU8QWuSiCmgFaM90E5j5NIA+jMhaYfJx76qgjzZaAQviBrIVrzYVXIfb917/8G
 XDadWFgysfNxjU7uJQ0v+gbjwZqjVkg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-dEM1HUjIOlS3SbwYjBYbOg-1; Tue, 07 Jan 2025 10:54:10 -0500
X-MC-Unique: dEM1HUjIOlS3SbwYjBYbOg-1
X-Mimecast-MFC-AGG-ID: dEM1HUjIOlS3SbwYjBYbOg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361f371908so106697695e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 07:54:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736265248; x=1736870048;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bvl+J5OWotTQVBe9dRZtuqKB1fUaMLXq6FgWP0i2SqQ=;
 b=L5NNcqDJrQ7NI81gfb97aNK9m8ZxPgDYHxDZFJFalbTaNG+l0LmmNyI15oANtfTnSF
 M8La7muVzKRFM7zC0wD8k+LOkvQD6d/gJLLjvx0lfAYxOCWZ9GnY6XYXF8L1ZjWmX4Sr
 /pO0qL60fYFqFI4WpygoTq4412O61krPtWkpiBk8KJLh9lnZo53eHix+0Wh5SXFrRY3Y
 J9EV4Jv7+BVg/c6BIQ3nysK3BMDTXgUB5n0+JUDQfji1TZjnbe1OLmTvM0/fTM75lZzG
 eObtg7ZDS33kkoRmNgZcOg/TvbOOiblvdqemXy185AapZNwFh13x2wBJpfz8SMnYnnfm
 fXSw==
X-Gm-Message-State: AOJu0YyRPaP2ApIl7ImfzC66QgOLlnhlayPPgvwi7qp2/wW/I5wL7Z/R
 zosbO1XaN+QImMQKNvZl27wlfHpd18JN7jfeCVAXV/2YKED+gSDWUEPBR+HhVWkKI9AL41PG/Xf
 oWjWPfdAenRGEF9ugsYPy6Q0NAyeeSxhjW7SmFR72ELE4FaRhjiiK3w7dWX2yfKa8SF3oF2rjkK
 5Qga/RLzfLz5jjpspGjzFlj17j1CppHgat3m0uZx8=
X-Gm-Gg: ASbGncupDH0IybiH35Y7DS+lesSsSS92aPjHfAeQ4MSAYsvol3Bczr0hGQYajHf2HzV
 PwDOCHCjO9BjuE2syK0Umrqi02CFczrHCtWx62+upzSsMZa5wOpVj5SgFjFhbgm5fJj5/5bsHzz
 sAFK8xKqEBxRdmNixuGCRIhpPWVSemZJjgSu2CsHSKlwTluUMGdDXApKi+JnAW0ZSI3Fs38D1bD
 FusakG8vIwhhFtOF+mmEdhD3lheMyPLpaKHaDaWYmiVt3Evd45+8YEUseCE
X-Received: by 2002:a05:600c:a0a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-43668b93ca2mr554436805e9.30.1736265248228; 
 Tue, 07 Jan 2025 07:54:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLJ4Y7tLNPVISi4P8w9i7JKDl0nvNMiG/NJDqJEGeB3A5HqlVpmI5t3urRG97tjgLDsuh5tQ==
X-Received: by 2002:a05:600c:a0a:b0:434:a781:f5d5 with SMTP id
 5b1f17b1804b1-43668b93ca2mr554436645e9.30.1736265247851; 
 Tue, 07 Jan 2025 07:54:07 -0800 (PST)
Received: from [192.168.10.47] ([151.62.105.73])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8288b8sm50296515f8f.11.2025.01.07.07.54.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 07:54:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] rust: add --check-cfg test to rustc arguments
Date: Tue,  7 Jan 2025 16:54:05 +0100
Message-ID: <20250107155406.53161-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.437,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


