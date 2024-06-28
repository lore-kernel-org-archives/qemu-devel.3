Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C79FC3065B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 17:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFPt-0005ih-RZ; Fri, 28 Jun 2024 13:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPr-0005i6-Ph
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sNFPq-0002FT-En
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 13:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719595781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m5NP/UiuFcCb7LOBTRdivsHTgeUYCYVStbvRvpRoDSo=;
 b=DDNcKjSLLwSG6wusQTJs2rxcls49y/0a71iTFecDiQig+WdKmTiUVbgEa0zG5PrQggux4l
 POS/LzjDNhPAScNLC3T0+UYimnjAT1PyUSQpROBnGSPnpZxHb5XcDtd+KKh4BXjiUcrqV2
 0Emk2Uw7VnavjfcHNnlwRj2BmtJWZ1I=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-nElhRcUfMF26zttz-PH9Pw-1; Fri, 28 Jun 2024 13:29:40 -0400
X-MC-Unique: nElhRcUfMF26zttz-PH9Pw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57cad6e94e5so655698a12.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 10:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719595778; x=1720200578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5NP/UiuFcCb7LOBTRdivsHTgeUYCYVStbvRvpRoDSo=;
 b=oAA/iu1oxuIB3/Pfj2YliqKVX9g7Y3HGOM6xm3YEdmhqM4AQqvJfQgWm6RGBmoMUvn
 HPGPK+tpFSpZH67TDL1PwQ532e0jY1M/ohrz86iw4/0hFWB2xcrZ4NJ34O8I9/3YZyvs
 g6VG5baozDll8uVvhdJgQeqrZ0SfkTLtAX7f7bxsk/0IgyqGYSMDKg9Kwp2ncc5VgxBP
 /Q8NXvwSdjY4BoUf1cOo4mqtEVZ1dov2muvJjd18BjLwqsEK2lRYqCXjo4YQI8QZ8CvJ
 icpkbvfnChJiPEsMYR024Izn/UGwO19TXp5WytPzLDDIXrguKJHcLM4YrnY6ICW/MvbV
 HToQ==
X-Gm-Message-State: AOJu0YwVqT0PcTmhuQsj5HIhdlva10+1HxHtDpSskxWXh6ezm+jvA2iY
 WqEeh3SE48KdlHBp6igUbQfeRCW2Y5Q0X8CVvFuDJhWfMWMuZkp6MEo/j1qgXt2fcft2RJPQx/j
 3dDh8kGQ8SuL6dUZpHI2Dj33oowdkmqycIhFvPhblGfh6dKunIG8O31wp8xIzntcwng177F9LUp
 uqXnQb6bb49Osy5rgnO/28KMciNTDmxbssSrW8
X-Received: by 2002:a50:8e5c:0:b0:57d:3691:baf9 with SMTP id
 4fb4d7f45d1cf-57d4bd8151bmr11412028a12.22.1719595778486; 
 Fri, 28 Jun 2024 10:29:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXSWciSE8H6fOJOz1cggR+H11LqbRfftYMYeU5YxbGXexWoMk4OZdXzSIJY2eo52X7+YWQVg==
X-Received: by 2002:a50:8e5c:0:b0:57d:3691:baf9 with SMTP id
 4fb4d7f45d1cf-57d4bd8151bmr11412017a12.22.1719595778131; 
 Fri, 28 Jun 2024 10:29:38 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-58614f3d74dsm1267067a12.90.2024.06.28.10.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 10:29:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 18/23] target/i386: SEV: rename sev_snp_guest->id_block
Date: Fri, 28 Jun 2024 19:28:50 +0200
Message-ID: <20240628172855.1147598-19-pbonzini@redhat.com>
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

Free the "id_block" name for the binary version of the data.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


