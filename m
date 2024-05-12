Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17A0C10F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 10:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s66mV-0003Dm-Vo; Sun, 12 May 2024 06:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mR-0003Be-G0
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s66mP-0005la-V3
 for qemu-devel@nongnu.org; Sun, 12 May 2024 06:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715511009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U2fiowOrMJl+aWIwJB0KTwv9oVXdfrjHf/yTatgQmpY=;
 b=Sbr+sD0n+4aJ1+5oez2Dj1o9Qq+aNL/ok0cSjAt6zNlOEdpoMA1yK4P+39aoP1dGLftXjJ
 fm4rwMydwmbzOUxRC3ujLTrge5AVF0v8vr3SxraFSdZlqxy8ICZNi0517GdvRjDIGxubFI
 jZa+tC1L0PSabwZiiqJBqa7R6Ojiywc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-uhxL6gBdMAGfKzxEbK4_OQ-1; Sun, 12 May 2024 06:50:07 -0400
X-MC-Unique: uhxL6gBdMAGfKzxEbK4_OQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a5a180153aeso225299866b.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 03:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715511005; x=1716115805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2fiowOrMJl+aWIwJB0KTwv9oVXdfrjHf/yTatgQmpY=;
 b=Py3WWIyZuKn7VrGXzaw2mIAuHREjpobj5suvvhaYvws8fRKjLVYoPolZIWRumJBRWo
 UhHG1jffxriuoozL4zxhu4LBj69p++kBo+wle9fKJL4UDH+mm/hHHAHSI1Vd+oDbDgTF
 ocTirlzjmQ1Spe5oymJxZpRuRtj+J2vWr8SEtK566/uOVKM+q7xqTGobgAnkKwQFZ9wW
 7DNPNaXlpRM/Hpk3/o6hjQ2usMVJaXQkus6Z9lun9DxFUjHs/rDkG3AWQdPXYrNcpepY
 mATcUmKbg8o/Mo4s5xWkQ+pQF6UmbHelPT6mI1746VLFMzwqm5/gGh5SwOZ2e2VbWVo3
 GB0g==
X-Gm-Message-State: AOJu0YwL9+zzo/lt8ll7SRCrWxCkHdQjapMemK1gAmDDVXjwkfAmJruG
 E2MduxXJoKDmsEqZiRNuaDirkwOORhCstfqhg4knLX77OvW4+097+SNHg/ghilLiKB1U0AN88ff
 0NXaTzwvSaNo2iKufvTU9kQBqtvDAmMUUxJng6cpKA0c5wysfJTt/1p3NYWHa2aDMLztfFc4iGQ
 6Y2ZhKebQDvDaLnW33uQi/YHf9jSsXOZbkEwaY
X-Received: by 2002:a17:906:4a42:b0:a51:a288:5af9 with SMTP id
 a640c23a62f3a-a5a2d641836mr465376466b.51.1715511005003; 
 Sun, 12 May 2024 03:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEC2afxrkFrpA7HhG28VBRb/m+jKUf3frH+xqy+uBvewVAh3STdCQf+odWeYxVnkxkgpaC+8A==
X-Received: by 2002:a17:906:4a42:b0:a51:a288:5af9 with SMTP id
 a640c23a62f3a-a5a2d641836mr465375566b.51.1715511004642; 
 Sun, 12 May 2024 03:50:04 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7d92sm447881566b.98.2024.05.12.03.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 03:50:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 06/27] tests/tcg: cover lzcnt/tzcnt/popcnt
Date: Sun, 12 May 2024 12:49:24 +0200
Message-ID: <20240512104945.130198-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240512104945.130198-1-pbonzini@redhat.com>
References: <20240512104945.130198-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.587,
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

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-i386.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tests/tcg/i386/test-i386.c b/tests/tcg/i386/test-i386.c
index 864c4e620d5..ce3bf74b5a8 100644
--- a/tests/tcg/i386/test-i386.c
+++ b/tests/tcg/i386/test-i386.c
@@ -715,6 +715,30 @@ void test_mul(void)
     printf("%-10s A=" FMTLX " R=" FMTLX " %ld\n", #op, val, res, resz);\
 }
 
+void test_xcnt(void)
+{
+    TEST_BSX(tzcntw, "w", 0);
+    TEST_BSX(tzcntw, "w", 0x12340128);
+    TEST_BSX(lzcntw, "w", 0);
+    TEST_BSX(lzcntw, "w", 0x12340128);
+    TEST_BSX(popcntw, "w", 0);
+    TEST_BSX(popcntw, "w", 0x12340128);
+    TEST_BSX(tzcntl, "k", 0);
+    TEST_BSX(tzcntl, "k", 0x00340128);
+    TEST_BSX(lzcntl, "k", 0);
+    TEST_BSX(lzcntl, "k", 0x00340128);
+    TEST_BSX(popcntl, "k", 0);
+    TEST_BSX(popcntl, "k", 0x00340128);
+#if defined(__x86_64__)
+    TEST_BSX(tzcntq, "", 0);
+    TEST_BSX(tzcntq, "", 0x003401281234);
+    TEST_BSX(lzcntq, "", 0);
+    TEST_BSX(lzcntq, "", 0x003401281234);
+    TEST_BSX(popcntq, "", 0);
+    TEST_BSX(popcntq, "", 0x003401281234);
+#endif
+}
+
 void test_bsx(void)
 {
     TEST_BSX(bsrw, "w", 0);
@@ -2162,6 +2186,7 @@ int main(int argc, char **argv)
         func();
     }
     test_bsx();
+    test_xcnt();
     test_mul();
     test_jcc();
     test_loop();
-- 
2.45.0


