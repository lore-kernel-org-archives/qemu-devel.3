Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD14D64070
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 17:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9SwU-0003j7-5f; Fri, 08 Nov 2024 12:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwR-0003er-Pt
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9SwP-0007Zj-VR
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 12:38:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731087517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=feHirvi/ZngWxKhCaO9WNrlm3HvMMVj7FfnuxqJ1OpE=;
 b=LDE0sBJ5DbOt4iim6sPytu1aIgp796gY3i49g2Qic1OdbB6K5Y3NsT79aDwUYl+bkTq0mv
 RG1BAvIkA12dd0QTOVepVzE48vbUMOIEEK+wgYfyMzs4GH5ILONZUmq3LWqqc8i0UeaiGq
 v5jTRwYKNZF8R54vatJ3+wU0HZ25IYk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-fzHdzTf8M26FD7SmpeFjQw-1; Fri, 08 Nov 2024 12:38:36 -0500
X-MC-Unique: fzHdzTf8M26FD7SmpeFjQw-1
X-Mimecast-MFC-AGG-ID: fzHdzTf8M26FD7SmpeFjQw
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4af408dcso1129847f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 09:38:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731087514; x=1731692314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=feHirvi/ZngWxKhCaO9WNrlm3HvMMVj7FfnuxqJ1OpE=;
 b=HX20l4FODhULxXu5z3Jl+pmZ1ZA4KQoth5qcaCSqnxmKJmVV5y17Rn0wtGui7a+T0V
 2eWhii4VjBAY2DfISTj98Yn6s/wcnjLSKmzRf+rWbJt1yYvKUl63UCjQABIzWhIKP4r6
 0ilmaGuBjTBY6I4/4G+0g/KRDqYNb+WZgWsbN6y9ZpgGiecwkauomAe0Vv8QKAQ/cekW
 QUhD3amfolMOWGSupQPdy7UWi4cNKM7zZs4S9ELhCFXBLk1+IhpsQ0+qhATMK45IYe9J
 3WzwvDcFshXcf7dSqiXsntIEzAZopubqNChqMgTMva0EMdum/DWGIm5NigHeHcs9GeI8
 ouQA==
X-Gm-Message-State: AOJu0YzuoaqzNylmj2QNugsWV3FLnON0ZjjLz+gKeE3OFLVu/3lTQlIh
 5mdU/thPlyI0HaAJk8InXrZP7K9bRJuD3SBAl4WA1NaNiFiVl/sHFGb+YyRwzLVjSbwUVLhmQlg
 RgUrOaTllxIPE52j5NqR7OfbKAB9pvcldxRf65vcgQ7M1rdu7HQjKT1/dpv6Z5vzJtY/GnJTpUi
 PhKfkm7sdZE2ViUDV/K49TAqCzoupRwLVJJ1TSju0=
X-Received: by 2002:a5d:6d01:0:b0:37d:4e56:9a2a with SMTP id
 ffacd0b85a97d-381f1885822mr2628855f8f.40.1731087513990; 
 Fri, 08 Nov 2024 09:38:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmeRBpqT1rcWuh97dGyElUAPkb99SZlyaZCPhI0THco0Ob8pnWKBvVOkx6l3FyQCIvPPpRkA==
X-Received: by 2002:a5d:6d01:0:b0:37d:4e56:9a2a with SMTP id
 ffacd0b85a97d-381f1885822mr2628844f8f.40.1731087513464; 
 Fri, 08 Nov 2024 09:38:33 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b053ff08sm79185335e9.10.2024.11.08.09.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 09:38:32 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/13] target/i386/hvf: fix clang compilation warning
Date: Fri,  8 Nov 2024 18:38:17 +0100
Message-ID: <20241108173828.111454-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108173828.111454-1-pbonzini@redhat.com>
References: <20241108173828.111454-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

../target/i386/hvf/x86_cpuid.c:35:28: error: a function declaration without a prototype is deprecated in all versions of C

Fixes: 7cac7aa7040a823c585f1578a38f28e83c8bf3e1
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/r/20241104222102.1522688-1-pierrick.bouvier@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf/x86_cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/hvf/x86_cpuid.c b/target/i386/hvf/x86_cpuid.c
index 3a116548a3d..492e8bfc809 100644
--- a/target/i386/hvf/x86_cpuid.c
+++ b/target/i386/hvf/x86_cpuid.c
@@ -32,7 +32,7 @@
 static bool cached_xcr0;
 static uint64_t supported_xcr0;
 
-static void cache_host_xcr0()
+static void cache_host_xcr0(void)
 {
     if (cached_xcr0) {
         return;
-- 
2.47.0


