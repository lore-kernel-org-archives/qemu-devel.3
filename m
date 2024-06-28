Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 493C0C3065C
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPz-0005mm-F2; Fri, 28 Jun 2024 13:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPy-0005jg-Mn
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPx-0002Fw-9G
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KXi+CTiEtHiD7S+XumvmPGujXhxrwa+TTB3rvpazHw=;
 b=LLSGEZsu4LYSuhkORrFRfUgW0VJiA9GNDMOJ9D75uvzVCbREKsJIElW39bU8EbsXN3Akx9
 HgjmdVAdgqRnnts07xZwR+hHnz2ESUlIBYMmj6Q2EdCwMsbpDU1TPt9Ko4g9vvKWQdGam2
 u8GinOt1XV5OhGF8rNm5avWFTbmPUhM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-oVjDujxxPX2t0fffcQbDWw-1; Fri, 28 Jun 2024 13:29:46 -0400
X-MC-Unique: oVjDujxxPX2t0fffcQbDWw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57c6979daf7so702569a12.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595784; x=1720200584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KXi+CTiEtHiD7S+XumvmPGujXhxrwa+TTB3rvpazHw=;
 b=jU0qAV9vY/3b4stxYQrLq3AUNisAMXB9KRzrbxP78jMsAZHB88w529i/u/hDymI1zP
 iHshBd9YS0KX6EOTXkrIB65JSSmkN2LcgXr3fizHjE8BSb1LEzAoTvI6Q4kg3LqI9SN3
 rtEsH5fxq+400Crd08/1PscKn432aDwpg3WgtOm50IT/tO6Cpa6E32moloCaf6Inhnda
 XuweyQ/cWnB/kqq3uJ8h/Le3yrtKMtX/iwpy/f8jEFD4T9hwx/TxueY1ZlGHWyxJBQbn
 RJBjcMbmbF0Tw5vAqWMmY1TfQftVGj5lwIzUMBDXnLwY3olI4vL6DeToYy9y3S+tQtt5
 dqeA==
X-Gm-Message-State: AOJu0YwrhDbnKvvdU9x8Y7mV5xkTSMJYk9VJn1M+Myy95D0BLy1FPjxf
 jBEZuic42LQjjfOZ6k86m/1OybdcpxPWxKmJ/ClfsMiKsbbCScYGsB6dCW5LdPQiwz43+//Hdh1
 e/i2kSj7+YP5TCTqDOavs4LBKOWXqKmEfuxOd1wvAW12Z7K4plcgOxK4lEub1UE68zQhMuPZuak
 kpP4pK/zI9kYCCKgoq9rSyfb7Q3d8j8vT4hRe4
X-Received: by 2002:a17:906:68d4:b0:a72:428f:cd66 with SMTP id
 a640c23a62f3a-a7245b73276mr1057008466b.39.1719595784390; 
 Fri, 28 Jun 2024 10:29:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFXUnixwUXXZWq/MOtYGjhoRBFwY53HwWAS9TemVQBC59bYcfZdOmVlDv9kbAjQlSr94Y3Yw==
X-Received: by 2002:a17:906:68d4:b0:a72:428f:cd66 with SMTP id
 a640c23a62f3a-a7245b73276mr1057007066b.39.1719595783977; 
 Fri, 28 Jun 2024 10:29:43 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf63dfbsm96658766b.84.2024.06.28.10.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 20/23] target/i386: SEV: rename sev_snp_guest->id_auth
Date: Fri, 28 Jun 2024 19:28:52 +0200
Message-ID: <20240628172855.1147598-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240628172855.1147598-1-pbonzini@redhat.com>
References: <20240628172855.1147598-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

Free the "id_auth" name for the binary version of the data.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 2d4cfd41e83..a6b063b762c 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -154,7 +154,7 @@ struct SevSnpGuestState {
     char *guest_visible_workarounds;
     char *id_block_base64;
     uint8_t *id_block;
-    char *id_auth;
+    char *id_auth_base64;
     char *host_data;
 
     struct kvm_sev_snp_launch_start kvm_start_conf;
@@ -1297,7 +1297,7 @@ sev_snp_launch_finish(SevCommonState *sev_common)
         }
     }
 
-    trace_kvm_sev_snp_launch_finish(sev_snp->id_block_base64, sev_snp->id_auth,
+    trace_kvm_sev_snp_launch_finish(sev_snp->id_block_base64, sev_snp->id_auth_base64,
                                     sev_snp->host_data);
     ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_SNP_LAUNCH_FINISH,
                     finish, &error);
@@ -2198,7 +2198,7 @@ sev_snp_guest_get_id_auth(Object *obj, Error **errp)
 {
     SevSnpGuestState *sev_snp_guest = SEV_SNP_GUEST(obj);
 
-    return g_strdup(sev_snp_guest->id_auth);
+    return g_strdup(sev_snp_guest->id_auth_base64);
 }
 
 static void
@@ -2208,14 +2208,14 @@ sev_snp_guest_set_id_auth(Object *obj, const char *value, Error **errp)
     struct kvm_sev_snp_launch_finish *finish = &sev_snp_guest->kvm_finish_conf;
     gsize len;
 
-    g_free(sev_snp_guest->id_auth);
+    g_free(sev_snp_guest->id_auth_base64);
     g_free((guchar *)finish->id_auth_uaddr);
 
     /* store the base64 str so we don't need to re-encode in getter */
-    sev_snp_guest->id_auth = g_strdup(value);
+    sev_snp_guest->id_auth_base64 = g_strdup(value);
 
     finish->id_auth_uaddr =
-        (uint64_t)qbase64_decode(sev_snp_guest->id_auth, -1, &len, errp);
+        (uint64_t)qbase64_decode(sev_snp_guest->id_auth_base64, -1, &len, errp);
 
     if (!finish->id_auth_uaddr) {
         return;
-- 
2.45.2


