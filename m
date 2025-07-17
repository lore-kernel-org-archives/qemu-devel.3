Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A04C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 15:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucQ5D-0002lh-RD; Thu, 17 Jul 2025 10:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucOQA-0001pA-B2
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1ucOQ5-0002d0-Hx
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 09:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752757982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/D6rBSL1mXGr0eR7+8mIYvSixxDNJg3R2iiIi+Q6pHw=;
 b=dWk8U7z5EfJfNjTnzl0y/5wvKSK29ozoX0lJOHFMsKQ4s1rfKijZRSyVaAb59B8LsNa6I5
 UOPdUbVoN9V1nG+wHaRcFB+p3ntnQrXoUg3pCrSPEABK3XwM/u6TfhQEIO6p65vNS1q29k
 7mRxmadm43/gLLpZYomq1MgrwzA5L5E=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-i8rjJx_ZP-6AOOUvDdsJWA-1; Thu, 17 Jul 2025 09:13:01 -0400
X-MC-Unique: i8rjJx_ZP-6AOOUvDdsJWA-1
X-Mimecast-MFC-AGG-ID: i8rjJx_ZP-6AOOUvDdsJWA_1752757980
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ae0c11adcd2so68424366b.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 06:13:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752757979; x=1753362779;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/D6rBSL1mXGr0eR7+8mIYvSixxDNJg3R2iiIi+Q6pHw=;
 b=TakteDQEer8+qxpIZQHCRU4T/F6nKIJtWXxJnTPGUFM/o8Kkqa+JlzDoWCYUn5jA3N
 pat6WNC6MkkvhwUVq/gJ3/uG0FVA0HCeiqP1TjJCD3rtjgqW/BH+j6zHZV+NYBUJwGqR
 xILnF/a+r6H2xB4Iwhsm3L6RBfI191nrWYo76VTYjdRZYY03m9S23Ueg9c2XeHBLdGGy
 YBOa1mA9bsgKJOSpjS4FHtwK9h/6GX3aZW5cbizz6EYFvvgyakIGo4eUR5iYHqamizvl
 YqhYlue0wqxIQoeVAKZ5EvSW8ABFnOHJ0cR5KBfYcX8lMh/F2CWvxkOyMxdiWaKOapnj
 zQow==
X-Gm-Message-State: AOJu0Yy+GQdKVfI0A8RzQoKf3A7BMS563uVtqdK5fSEGjypJfCRn5EA+
 amaSRhymrIz8vYCZBg/Nnvr/1kyQIltT7whZCvRArPNwbeEvRH8IGZ6W5uLbev4/27f8qyafxoI
 Bwlo7eQ7XZRUfOfvoBA0V1mQmwYzVLujmV+BETxbozDemUTiKqi5mCGgRyy3v25T1ahEU2Gi70R
 whPxw4Rulx61se1RHlNAkV7O+Hmgupiby6zT53Vwl5
X-Gm-Gg: ASbGncvvyWGXpXvPM+VRJuJVUcZJLfHbumuWjAZ+wjqTl0saWLnKM2FHVvn7d5OI9aV
 SuHraL6E3EXigWYQunNJz22vFvaIVp7f3kfn1JjbhIYy9pbvb+oMtzvXg7Rdjt/EwnHGDklfLMz
 CbZCvh2hBDpQweLpB6ciXX5IU2rAyH5aW+yJNHwcCOWpex7QfAT4s3US5w5q9pOH9JgR9rU/AqN
 0ZK//s6KGirRciiFDdEW2i/00SN+vttb/AijhWCyyDgPXGaENRnIoDqlXQJ+uipygRXP1onKZR9
 4OIG2KMF8RBoeRot2jhnaJyBPUxSu8rpdEEhudGVkiXfBgjztHHRqfTdBNIkV8vD38QUGRFqVqh
 2yg==
X-Received: by 2002:a17:907:a647:b0:ad8:a935:b8ff with SMTP id
 a640c23a62f3a-ae9ce094585mr695876066b.31.1752757979309; 
 Thu, 17 Jul 2025 06:12:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPYqBuSBQWvbKrV5RLZ90sOFDScV1iry075eypPackOR9mDuFkkf62O1J22f7IUVRQyYQr1Q==
X-Received: by 2002:a17:907:a647:b0:ad8:a935:b8ff with SMTP id
 a640c23a62f3a-ae9ce094585mr695870566b.31.1752757978475; 
 Thu, 17 Jul 2025 06:12:58 -0700 (PDT)
Received: from stex1 (host-79-45-205-118.retail.telecomitalia.it.
 [79.45.205.118]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ae6e7ee8d9fsm1341911766b.46.2025.07.17.06.12.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 06:12:57 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, roy.hopkins@randomman.co.uk
Subject: [PATCH] meson: re-generate scripts/meson-buildoptions.sh to fix IGVM
 entry
Date: Thu, 17 Jul 2025 15:12:56 +0200
Message-ID: <20250717131256.157383-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 84fe49d94a ("meson: Add optional dependency on IGVM library")
was inconsistent with the contents of meson_options.txt and the one
generated in scripts/meson-buildoptions.sh

Let's regenerate the file in this way to keep them consistent and prevent
future changes from including the spurious diff:

    touch meson_options.txt
    make update-buildoptions

Fixes: 84fe49d94a ("meson: Add optional dependency on IGVM library")
Cc: roy.hopkins@randomman.co.uk
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 scripts/meson-buildoptions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index e8504689e8..0ebe6bc52a 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -130,7 +130,7 @@ meson_options_help() {
   printf "%s\n" '  hv-balloon      hv-balloon driver (requires Glib 2.68+ GTree API)'
   printf "%s\n" '  hvf             HVF acceleration support'
   printf "%s\n" '  iconv           Font glyph conversion support'
-  printf "%s\n" '  igvm            IGVM file support'
+  printf "%s\n" '  igvm            Independent Guest Virtual Machine (IGVM) file support'
   printf "%s\n" '  jack            JACK sound support'
   printf "%s\n" '  keyring         Linux keyring support'
   printf "%s\n" '  kvm             KVM acceleration support'
-- 
2.50.1


