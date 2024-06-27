Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F09DC3064D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 14:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMqVm-0007sr-Fi; Thu, 27 Jun 2024 10:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVl-0007sT-AA
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sMqVj-0007HZ-QZ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 10:54:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719500047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u8TcXNw1quRhJfIms88BIFe4UYU2p+cTpYnRuEZRfYo=;
 b=E9wELK4iSOdGLdkOaquW6cWqmKCpu+aUbNsjJih4dNI1Jigx4VGaFlPSmh+ik8gC0+EWBL
 GogUeubqCbxr3D+ADTkHQ4oNokes2WxCMEjWjhFKNQLVtrR154q7Gp74kNkwiHJHeKxE68
 AqS4KxlEs0M2yU2mjYfnE2ueU0IcrxA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-57peZZOeNkC6o9IMe3jrjw-1; Thu, 27 Jun 2024 10:54:04 -0400
X-MC-Unique: 57peZZOeNkC6o9IMe3jrjw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57d241a4d0eso459374a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 07:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719500043; x=1720104843;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8TcXNw1quRhJfIms88BIFe4UYU2p+cTpYnRuEZRfYo=;
 b=HDeiBJ0EipUC4/fpzJITGo5Jpnh554VBJrSd6zHm7MTqxyoAm9SDHzJDezljSXza3W
 TJcLCuzYqCrEDGMCWNfUVHzEX6QPNv7Z9xQY/NJwrV2gKZygYqpC1H4c9wmSwzbvhc5O
 Cw5C5WsxaVuWfmZnU4il8vCwnsgAya6S2ua1++IlzyFCTSkpHQsddsYJDi3IkxyQiMIZ
 rOGKrvYEAd19k0TVOtGjkMt4pDJJ0JWNEeY3aZOfBvDYWvRht/eIoOWjXRtrTlbyfL6S
 VfRMiAX3KrRCRz/6N0fTTQKv1QBGogcenJNHsFabv8zWuhnOvP02Yye3wVvMWI8GIjEY
 sr6A==
X-Gm-Message-State: AOJu0YzVgsLIcODKJLSosCbBOBNvOHyNPZ52B9bQ0H+G/ryV0E5c9HRB
 Zd4BWQGB4tx6VG3R1Ueeod884hvZF2kIGfArRiJDXtMpdQ4QJhDpSnrFpS1czdN3Sbg1CH6UtHA
 2j+mAqn/Ea6wmQjMbhVYAsswv3qqu92L1LmSIXDTA08RKFpvFxnOulz/dG/EKlEiKFaDvk3YNI5
 /BpWsoinyaPLlJaR732OJvD8DheiNYABiQ3fzl
X-Received: by 2002:a50:aade:0:b0:57d:50c:e28d with SMTP id
 4fb4d7f45d1cf-57d4bd72312mr11786663a12.10.1719500042968; 
 Thu, 27 Jun 2024 07:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWLxRT5D69zKsWzGjv0ZSTiWZY4cL5E745ScOAzWRC5Ix6bOrAEvP0SWE02pvYd4KH3yw6cA==
X-Received: by 2002:a50:aade:0:b0:57d:50c:e28d with SMTP id
 4fb4d7f45d1cf-57d4bd72312mr11786644a12.10.1719500042497; 
 Thu, 27 Jun 2024 07:54:02 -0700 (PDT)
Received: from avogadro.local ([151.48.235.205])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-584d1280e93sm974664a12.33.2024.06.27.07.54.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 07:54:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH 1/5] target/i386: SEV: rename sev_snp_guest->id_block
Date: Thu, 27 Jun 2024 16:53:53 +0200
Message-ID: <20240627145357.1038664-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240627145357.1038664-1-pbonzini@redhat.com>
References: <20240627145357.1038664-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Free the "id_block" name for the binary version of the data.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 30b83f1d77d..6daa8c264cd 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -152,7 +152,7 @@ struct SevSnpGuestState {
 
     /* configuration parameters */
     char *guest_visible_workarounds;
-    char *id_block;
+    char *id_block_base64;
     char *id_auth;
     char *host_data;
 
@@ -1296,7 +1296,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
         }
     }
 
-    trace_kvm_sev_snp_launch_finish(sev_snp->id_block, sev_snp->id_auth,
+    trace_kvm_sev_snp_launch_finish(sev_snp->id_block_base64, sev_snp->id_auth,
                                     sev_snp->host_data);
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_FINISH,
                     finish, &error);
@@ -2159,7 +2159,7 @@ sev_snp_guest_get_id_block(Object *obj, Error **errp)
 {
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
-    return g_strdup(sev_snp_guest->id_block);
+    return g_strdup(sev_snp_guest->id_block_base64);
 }
 
 static void
@@ -2170,14 +2170,14 @@ sev_snp_guest_set_id_block(Object *obj, const char *value, Error **errp)
     gsize len;
 
     finish->id_block_en = 0;
-    g_free(sev_snp_guest->id_block);
+    g_free(sev_snp_guest->id_block_base64);
     g_free((guchar *)finish->id_block_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
-    sev_snp_guest->id_block = g_strdup(value);
+    sev_snp_guest->id_block_base64 = g_strdup(value);
 
     finish->id_block_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_block, -1, &len, errp);
+        (uint64_t)qbase64_decode(sev_snp_guest->id_block_base64, -1, &len, errp);
 
     if (!finish->id_block_uaddr) {
         return;
-- 
2.45.2


