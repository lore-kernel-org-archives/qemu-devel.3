Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954EBC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:56:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3tAp-0001yJ-Ot; Mon, 06 May 2024 03:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA7-00005O-P3
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3tA6-0001qz-FF
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714982005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ONGYpDHvGaq+Ar3j95zhW7jx60qaSUiuPIrd8f0yOgM=;
 b=FogXxM3bCac9B7Z30niJsJZv69n2ScmWsx31UA+Gjhuf/8GtEL2U2wEyFzsiy4dDGq4QmZ
 JLzT984P7EF2Q3uj+zgQpHYn8CS0VFeHj9Qc1Q1QNwzvgeoHkAclsrODuyuylv3gGT/n0v
 Y8SYuN7GQIuiHIaptgyA0f2sBAdlN2s=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-c5mxMUpIMu-YVfSl5zIeAA-1; Mon, 06 May 2024 03:53:23 -0400
X-MC-Unique: c5mxMUpIMu-YVfSl5zIeAA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a59a5b06802so97543366b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714982001; x=1715586801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ONGYpDHvGaq+Ar3j95zhW7jx60qaSUiuPIrd8f0yOgM=;
 b=ER+MwVOcdZHWFK+Hr1yP+VFl7mLmGUTNfMs9IguGTviaN59NSJ8lvGJGFp8Phk4N7A
 I9Gopaq52AwWBv03EhquGdlUME/r8opFI2bD3ceZVWvUbVQBMgN8vIJAU6p1UUMdglw+
 r0DkdOgoCrlcP9ThuF67zLX3fcsjXt8aKEKBRZpF5uiZ7gpg06759XtD0XfkGmtBCfiw
 bmgBprWkAHcow1jTyl4Kh7oINER+ZcE2c6uwM2jbKKUjynZ6SeS3mUA8BxxcPI1N8Slq
 zgnKYe5CBui03QpfiuW4kExQ6pqIOnK7WGZmCmDhwh5FltspuYVhFFawma+z0ttkC80P
 xXYA==
X-Gm-Message-State: AOJu0Yyxdnh/oDgAbmV+OON+0U+EBbXxFDgEWVekEu7kW0D4Ii6u5D88
 QFUwvPYRPiKZdkvv0Nel9XQzaML9pCKsY0trF4cTSBa+KDBpGerJsFJO+SekvDAB0Xcisatvnjp
 LY8xceqyIh2AVXz3DvTwIaLGoMZlCrUs5ZduZMpyuM469ytn9tLerWjzCaTpuLjkQAhzUKsGcRJ
 qlnheosdw+3DVWwyrUlmfcB589YKQSt8wyxR9U
X-Received: by 2002:a17:907:9403:b0:a59:c9b1:cb64 with SMTP id
 dk3-20020a170907940300b00a59c9b1cb64mr2229874ejc.62.1714982001526; 
 Mon, 06 May 2024 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdu3x4hNriukUV28WW3HXDqb0oYNkOrr4Codvco4YouL1Xcond+9yu4MfMuiyqKXSIVAXung==
X-Received: by 2002:a17:907:9403:b0:a59:c9b1:cb64 with SMTP id
 dk3-20020a170907940300b00a59c9b1cb64mr2229867ejc.62.1714982001204; 
 Mon, 06 May 2024 00:53:21 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 ze16-20020a170906ef9000b00a59b9b1abdfsm1984932ejb.185.2024.05.06.00.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:53:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 46/46] qga/commands-posix: fix typo in
 qmp_guest_set_user_password
Date: Mon,  6 May 2024 09:51:25 +0200
Message-ID: <20240506075125.8238-47-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

qga/commands-posix.c does not compile on FreeBSD due to a confusion
between "chpasswdata" (wrong) and "chpasswddata" (used in the #else
branch).

Fixes: 0e5b75a390 ("qga/commands-posix: qmp_guest_set_user_password: use ga_run_command helper")
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/commands-posix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 7a065c4085c..7f05996495a 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2173,7 +2173,7 @@ void qmp_guest_set_user_password(const char *username,
     }
 
 #ifdef __FreeBSD__
-    g_autofree char *chpasswdata = g_strdup(rawpasswddata);
+    g_autofree char *chpasswddata = g_strdup(rawpasswddata);
     const char *crypt_flag = crypted ? "-H" : "-h";
     const char *argv[] = {"pw", "usermod", "-n", username,
                           crypt_flag, "0", NULL};
-- 
2.44.0


