Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708DCE8E6D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x43-000470-FA; Thu, 24 Oct 2024 08:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3r-00045H-0I
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3x3l-0000GU-7v
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 08:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729773319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Qrs8Z+T7lnmSFV66Ia/l4J4QjdzFqwu0IF9bNk5p3w=;
 b=IFbRXRFGwdYtTQ3MprL3WK5Ld+AkLzeLPmrinz+l+pYQN80Bjctv9//JqGwaHU5U3aF41W
 ZQIpm3j1zIcVKqiPMOFxctdFhSE/Y+OR6AdUX30XKrOE1bG2/sAP3P+lYPak4IQ/MY4nGr
 F1TTJg/K/bn0vyquMuBeKXI2WcZrT2I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-XVJsezn0NnaGBQzt4le4Vg-1; Thu, 24 Oct 2024 08:35:13 -0400
X-MC-Unique: XVJsezn0NnaGBQzt4le4Vg-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43157cff1d1so6925855e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 05:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729773311; x=1730378111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Qrs8Z+T7lnmSFV66Ia/l4J4QjdzFqwu0IF9bNk5p3w=;
 b=koP2cw/Fq1gp+jeP0fc2R+0i0CCCN06Oe9IXsYLYdWfrRyHPRNZmeeFcykRCElSOgO
 seJAocizp9+KK3xrhPV15H7Hi/p5uVop8wQ/aiM4YZV9Or/LwZjTL/dJzG33LB39XwMV
 I/HtO+zuQpV/LIpcO2w/RRp4CZns7G3yZ57HP8TNMB2nf/N4Lo8UvsqNQWanpkU1eHuX
 PDkCkBR72WrgNd5ESnG/7EEt8gM4QgjhExCeGQQ2I13eExShbbzfYR+yvxUk7NKcIQ21
 0edBbvhYvHV2OPlsWT3fIyLDlSiDJErgI90IKMydnHhOm/UMI4FhhCUpf2R0zo5E+wVO
 dztg==
X-Gm-Message-State: AOJu0YzSExFE0MADh38D4CaslfermV+wHvQ6gJHSVm0Oo4R2l23arFRP
 2u7rKcKwoxxit8kVUnyKkg6m4d/F+OhD9VEOJc9fnysleygwpeWYWxx9kP71arw5O2I5MeyTqr1
 cUNi38XyzTbYhmjCaBFyemE29jfZjvY5JEvOlSRVDAPE8fvHolWd2ZtpqOZssFl06RHAwUAuZL4
 cnUPbmjwRFgiOVEa4GiG5GpOqOgZw/lo6x9r0n3D4=
X-Received: by 2002:a05:600c:1c95:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-43184133fc4mr48108585e9.2.1729773311399; 
 Thu, 24 Oct 2024 05:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+i07+Ypi3X20MCrGPUC/yBmgbJ+lEUn6OJqJFOV1plPmFrZ+iIuCoHwnkn/69jUBqm+lEhg==
X-Received: by 2002:a05:600c:1c95:b0:42c:de34:34c1 with SMTP id
 5b1f17b1804b1-43184133fc4mr48108315e9.2.1729773310891; 
 Thu, 24 Oct 2024 05:35:10 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.99.171])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b57b051sm16403615e9.42.2024.10.24.05.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 05:35:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>
Subject: [PULL 5/8] configure: Replace literally printed '\n' with newline
Date: Thu, 24 Oct 2024 14:34:56 +0200
Message-ID: <20241024123459.59350-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241024123459.59350-1-pbonzini@redhat.com>
References: <20241024123459.59350-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

From: Kevin Wolf <kwolf@redhat.com>

The idea here was to leave an empty line before the message, but by
default, echo prints '\n' literally instead of interpreting it. Use a
separate echo without parameter instead like in other places in the
script.

Fixes: 6fdc5bc173188f5e4942616b16d589500b874a15
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Link: https://lore.kernel.org/r/20241018120557.43586-1-kwolf@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 72d1a942250..0918147156b 100755
--- a/configure
+++ b/configure
@@ -2062,7 +2062,8 @@ chmod +x config.status
 rm -r "$TMPDIR1"
 
 if test "$rust" != disabled; then
-  echo '\nINFO: Rust bindings generation with `bindgen` might fail in some cases where'
+  echo
+  echo 'INFO: Rust bindings generation with `bindgen` might fail in some cases where'
   echo 'the detected `libclang` does not match the expected `clang` version/target. In'
   echo 'this case you must pass the path to `clang` and `libclang` to your build'
   echo 'command invocation using the environment variables CLANG_PATH and LIBCLANG_PATH'
-- 
2.47.0


