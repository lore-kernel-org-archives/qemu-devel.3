Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E9ECFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxlXs-0002Ej-GQ; Mon, 07 Oct 2024 07:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXa-0002BE-NM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxlXZ-0006bi-2s
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 07:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728299076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBdsPxBj1O3hBIQ/IJN4alb0E5Eb0MDt74Zp0EoisJ4=;
 b=OvH+8onk6pkcjzuM/+TVKtF0dYqmNqsBvBH/iodS/5gQfy+6sF8pduLOZDodLXVM4MSVP+
 XgKulxMR9CukaVMBCwPigEY+v2+EBYFOzPYsMwm3gIHv0BCkEw0fSI8zFqfv9s6SkDKCOC
 6MFWXqIDL1p8XXG0rWHmO49kCo5nAYw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-yOFitQhZOBS4DQ6_CaSjMQ-1; Mon, 07 Oct 2024 07:04:33 -0400
X-MC-Unique: yOFitQhZOBS4DQ6_CaSjMQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37cd32f9c59so1598777f8f.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 04:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728299071; x=1728903871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aBdsPxBj1O3hBIQ/IJN4alb0E5Eb0MDt74Zp0EoisJ4=;
 b=gdvWWPk6LocIsc1NYZgD68u0MdilPqbCdKrVZFsaIdpf28axxSHR17jlQ2BSWEYVKZ
 0MtI/p+eomvQuB0LUdh6OudpHLmVnAV1wjpIwLJtuIrWiBR0sFPsm0wGWHOuv62a6VhV
 PqOM5ywkHJJ5+FxGJ8DI3FGpiVv+WB7Uc5UlAqePVD5sWVS83LqdqYaOAWdNH6toGjop
 ORWKzl0XCLOnrSTVisac4QRnm/LhiTyQNviB0/engiWDJihcuC6Zbw0pSCgQUXXFTn1Q
 FiGMxyduGYOfjGYH3/PlK9Vxc3LkP8Gq8gjEbXIcnp5VlXm66UnuYzWhNywl1ZkmE27b
 cjQw==
X-Gm-Message-State: AOJu0Ywb/XilCGuJwqzMAGQkY/jpE9mlYqI6V40yejJz2WaIyaYtSLcr
 je1jg10dDAeF/NX2/bG3joCgvo2TA2xJ8MZwSp3w10Bc36YUWx/8Qh3e7iTmJJglsddlWYxCVt7
 CHZeTtNjARpLBAl++Uz+msh1FpMhXDmeULfppiEpQeu0H0G9k3XfwEhDDRGDggajbRYzhKouDIZ
 D7WjvgQhVBSC5OCRJu9WeLs0e1EwMpFMvZnFFvWk4=
X-Received: by 2002:adf:f1c4:0:b0:374:bdc4:cfd3 with SMTP id
 ffacd0b85a97d-37d0eaf9afbmr6274382f8f.37.1728299071450; 
 Mon, 07 Oct 2024 04:04:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEixX7wEXCnUz86uDjhVE27FQlvrhIav9dSqrb94HQcZ1uwdhgvrRMvrZYR+YUZdnNXct+tSA==
X-Received: by 2002:adf:f1c4:0:b0:374:bdc4:cfd3 with SMTP id
 ffacd0b85a97d-37d0eaf9afbmr6274359f8f.37.1728299071075; 
 Mon, 07 Oct 2024 04:04:31 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d169202efsm5451463f8f.49.2024.10.07.04.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 04:04:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, zhao1.liu@intel.com, junjie.mao@intel.com,
 pierrick.bouvier@linaro.org, alex.bennee@linaro.org,
 qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 10/12] meson: fix machine option for x86_version
Date: Mon,  7 Oct 2024 13:03:38 +0200
Message-ID: <20241007110342.1298598-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007110342.1298598-1-pbonzini@redhat.com>
References: <20241007110342.1298598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.46.1


