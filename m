Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8FBD24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ4a-0001Fq-T6; Fri, 11 Oct 2024 13:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4S-0000wP-24
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHdt-0007FC-Sy
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660805;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1CI3G168F3cDdpDRHRzVTftyK0R2VTAU16G+izB978=;
 b=NpQp3vJ9lexH3YMHGZFDwnuafLH8dr8xupe8uiMxPFevDVkFuwetX/OkcUHzOEib6V5hzw
 jng/q1vgnyS+cTJyTEPUpCG4GuNrRujVPJgiTk9CcAtfAlpk61TkulbifjTIjYNf/S85W3
 Hk+VsoZHlGjPRMKAUWSdlF86yj0799Q=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-7_4ZJp4dMryiteM0txn-xA-1; Fri, 11 Oct 2024 11:33:24 -0400
X-MC-Unique: 7_4ZJp4dMryiteM0txn-xA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a9953ddfa4fso171386566b.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660801; x=1729265601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I1CI3G168F3cDdpDRHRzVTftyK0R2VTAU16G+izB978=;
 b=W1UCRtbnu8Faadj3vQJN1Qj7h/OrNuXmsYtjVCPs73BdbA/hVxRQx9owOFUVW6lg+J
 m/UpMWhD3YfQkzAV4tpYbusJC3sfwprrezdvbXZhPwmkAWQ4jAQsDXrYbwZG9NQg3kqb
 FOBoCWlXk18j7IuqKGCbmiMSmUoMGt1YHUbPOyCyiTaLRi7lWhF6nCy1JwTtZsegMKgn
 /lRGpZWs20Nk+3j99j2y+N2XhNbEbhX8qbatyOv8fsallrq+ZA8auJ9n5gO1Eey9VLHZ
 vUjw713DweQEqjBRhCgJJ+QlsakeUhld8WOexOJqnDnrJN0BVhWc3MnCUVdWBq6SyOoD
 lGjw==
X-Gm-Message-State: AOJu0YxQfE2RAbLoz4HJy5irsmJjM09fhC5qRnyuOiEerds0DBAniHhU
 5eKto4MPbY6CyqLj7OZYj2oJKCdmPkgEExgRtWYNmqEt91Ym29w3W7K+IjX01GMPgg1OzOIro1D
 pyZqvvJCgM6pbipKL/KsbF8dSkCKT96MI/W7eA8N7FHzOY+0IsnA5i/xdciS8QXaRbPIf69qeYv
 wF5OHkQX9Nss72RnEL5ztK7DyJZS7BRF9TAZQm9R4=
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a99b930e9d1mr246662566b.13.1728660801108; 
 Fri, 11 Oct 2024 08:33:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkP1+4bvqxexjBw67VG4ebB/NujhnJL4e9wuXRZclQYpvUwZCvBEmIvnC73c863713ieHwfw==
X-Received: by 2002:a17:907:940c:b0:a8d:29b7:ecf3 with SMTP id
 a640c23a62f3a-a99b930e9d1mr246659966b.13.1728660800682; 
 Fri, 11 Oct 2024 08:33:20 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99c0c89bfasm57964666b.162.2024.10.11.08.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:33:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL v3 11/18] meson: fix machine option for x86_version
Date: Fri, 11 Oct 2024 17:32:19 +0200
Message-ID: <20241011153227.81770-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011153227.81770-1-pbonzini@redhat.com>
References: <20241011153227.81770-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

s/mbmi1/mbmi/

When configuring with -Dx86_version >= 3, meson step works, but
compilation fails because option -mbmi1 is unknown.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/r/20241004223715.1275428-1-pierrick.bouvier@linaro.org
Cc: qemu-stable@nongnu.org
Fixes: ef7d1adfa85 ("meson: allow configuring the x86-64 baseline", 2024-06-28)
Revieved-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index b91863736ea..76335bb2a51 100644
--- a/meson.build
+++ b/meson.build
@@ -375,7 +375,7 @@ if host_arch in ['i386', 'x86_64']
     qemu_common_flags = cc.get_supported_arguments('-mneeded') + qemu_common_flags
   endif
   if get_option('x86_version') >= '3'
-    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi1', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
+    qemu_common_flags = ['-mmovbe', '-mabm', '-mbmi', '-mbmi2', '-mfma', '-mf16c'] + qemu_common_flags
   endif
 
   # add required vector instruction set (each level implies those below)
-- 
2.46.2


