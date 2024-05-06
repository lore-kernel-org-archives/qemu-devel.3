Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6EAC25B5C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:53:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9k-0007f1-I9; Mon, 06 May 2024 03:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9f-0007Sl-Mi
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9e-0001ll-6n
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981977;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vl6UmUSnCe1v+kvRt3ccMUbyvwhB5ANCb14lhy2pm2o=;
 b=HOhtj4iUd/FEO6jOTUZUVAyeFe81JfAg7S49PCBCgh1agbrXOhX5NHM/Ldd67uk00GIab7
 lzFa0p7WUS/mX8WF4aD+oS6A/Pe9N7KUx56G8XGBRXnBA4Y01XatGyPt9adDYxKpd/u4ZQ
 yxrhm0eDE8c5ovInfRhENtZMDwhETKY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-PpellDxoNs-HyR1rF8sl4Q-1; Mon, 06 May 2024 03:52:56 -0400
X-MC-Unique: PpellDxoNs-HyR1rF8sl4Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59aedbd9a9so109767166b.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981974; x=1715586774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vl6UmUSnCe1v+kvRt3ccMUbyvwhB5ANCb14lhy2pm2o=;
 b=RsloF3heaXIXX7tRFeL8Vt+aYw3sGKkWBt31bK2+bhwYePFLTsBc3W+PoHLHd8zh3N
 KMGrwbgsK9K3Nb7pH8tyMGgBI3x0j3inZI13gHD6f2xw72AAHhd0i1hNrBmzvnrvGSrq
 sSe5TaL0xQ3shIkQ2lDFXUBab9aPFXoik128SAnayW5KNAJGkVrUH4ASD+wzCcfvTkVQ
 6nhNiXmujhdbc2wZoqUpuQne0dzHLMfac8hbvmNGrGLLYUzwRQduMJ2OPs5wkmgXmo0b
 u8KYiU/TrNonqPp9E/cVGsXxso2k9my2XyLj5szVH3mT0+00Slw2A38L/b95rdVY1NyW
 Hn1w==
X-Gm-Message-State: AOJu0YwcnoqaurncC3ZhnmhC/4nuy+dXYO7uhRKj47H8/fJ6Q7VYJrX5
 ZZybNxv7DX6DUZy1/fPw9owjhrmkgJ3xE6rfBknzjbdnrOxfw/81FslFnKbxq2E6pOxjCDBTK4/
 I5eBiiKGw/38VEHAqZxi5sW3yV+GFHpZ32cUWakgeC7A0ynPuheQ68hYyx6uq5oB20WVUHyx0SQ
 KyST1UxfbacgTKegmCytMmUNMP4adU8IYt6FjX
X-Received: by 2002:a17:907:7f87:b0:a59:d458:835c with SMTP id
 qk7-20020a1709077f8700b00a59d458835cmr767692ejc.52.1714981974074; 
 Mon, 06 May 2024 00:52:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBdpbwVfUX3Z9jeiqpa0PRRNd795oWpQxK386urA0kWdMc82eMvZv7G5N45N+vTOlpnC4L5g==
X-Received: by 2002:a17:907:7f87:b0:a59:d458:835c with SMTP id
 qk7-20020a1709077f8700b00a59d458835cmr767681ejc.52.1714981973736; 
 Mon, 06 May 2024 00:52:53 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 qy29-20020a170907689d00b00a59adb12790sm2458320ejc.27.2024.05.06.00.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/46] qemu-option: remove QemuOpt from typedefs.h
Date: Mon,  6 May 2024 09:51:14 +0200
Message-ID: <20240506075125.8238-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

QemuOpt is basically an internal data structure.  It has no business
being defined except if you need functions from include/qemu/option.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/option.h   | 2 ++
 include/qemu/typedefs.h | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index b3498287823..01e673ae03f 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -54,6 +54,8 @@ enum QemuOptType {
     QEMU_OPT_SIZE,        /* size, accepts (K)ilo, (M)ega, (G)iga, (T)era postfix */
 };
 
+typedef struct QemuOpt QemuOpt;
+
 typedef struct QemuOptDesc {
     const char *name;
     enum QemuOptType type;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 520f421397b..4519f0cd613 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -108,7 +108,6 @@ typedef struct QEMUCursor QEMUCursor;
 typedef struct QEMUFile QEMUFile;
 typedef struct QemuLockable QemuLockable;
 typedef struct QemuMutex QemuMutex;
-typedef struct QemuOpt QemuOpt;
 typedef struct QemuOpts QemuOpts;
 typedef struct QemuOptsList QemuOptsList;
 typedef struct QEMUSGList QEMUSGList;
-- 
2.44.0


