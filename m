Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A815C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:00:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOIUq-0003YY-Gv; Mon, 01 Jul 2024 10:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUo-0003TH-H0
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sOIUm-00057H-RU
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 10:59:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719845947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AQLjBJD+DdaeIr+SrmTNPomxj+lI0aBHtLoGiVChLk=;
 b=XmYYOcxzqJTEtmQH++Cj0utjV7XtktjbzilLmyCR0Xi0+RHC71hl0FsVH2cJaUIv6kChtl
 Ur9s+mPa33YLGwnL1HCW6xfeGGp2sUPqgSC4y+oRR/Vh9pi9AUVCMU2KoP03O+CawL3RIg
 qUo+gQU5f4Ta2QW/Rza2YKAjypSmwEI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-mePTAs07PyO14i9bB1Qomg-1; Mon, 01 Jul 2024 10:59:05 -0400
X-MC-Unique: mePTAs07PyO14i9bB1Qomg-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52ce324c204so3707239e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 07:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719845943; x=1720450743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/AQLjBJD+DdaeIr+SrmTNPomxj+lI0aBHtLoGiVChLk=;
 b=XZBArWiTxdH+5OGYZJOMReg4oOyf5t4BOqMcilpJGS9ZIDK3PK6ANjAwli0EIdpwF+
 I1EX2orwl5jc9KjgdipszV7slF3MHDfasE9azBMQOU1IY3BuUaGiqw3z/jrGhBF3zX1D
 MwEMSTVNPzBwt7XLdD76iBzz5+C/pT1Jub/e3YP/V6LZeNwIyDz/zHYPw2a+gZIwmU/x
 mp48E85jdQ5RLpwG675eXzKDW7KCtf/016U7gYlbW6r3qUfntlhj4V6IOr+h1PhRJKph
 Ww0lOtHk0jWNKnUr3JoD0TdUcgUdGyPVU3WMI38O8n6O5PCFi1kbgaYPFdAVX951wk+3
 xwbA==
X-Gm-Message-State: AOJu0YwnW3dxuYsMy8CK7ZZxfnH5QtApyJdnJ9cvPN37KBHi8urj02zL
 Am3jX4KpWZzur+1XieiYlwYS4/EKsE6R38Xl4AOGxCLiEtmFlipCDrN9szlZMhSXzUr3WO4e4R9
 Z2+B27nlKlo13nb4xlag1ibpmyorbf1pOJn0fGJ8zJjdzfagvca3U/E/zwiuFax5nkVIr4bHD81
 +wA7z34/QNus1YO0BlTpJ66Aj2bqZWDIzIeisJ
X-Received: by 2002:a19:7503:0:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-52e826664d2mr3250984e87.22.1719845943668; 
 Mon, 01 Jul 2024 07:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5p8ijT5qhqXZTDOkO+cIGKrbcGDOCq0CVzpKFgEeQ98pu11elnT9puovdOVNkAzN99/lZ4g==
X-Received: by 2002:a19:7503:0:b0:52c:e07d:229c with SMTP id
 2adb3069b0e04-52e826664d2mr3250970e87.22.1719845943319; 
 Mon, 01 Jul 2024 07:59:03 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257a4d4cd1sm94550475e9.28.2024.07.01.07.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jul 2024 07:59:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 02/14] set expectations
Date: Mon,  1 Jul 2024 16:58:34 +0200
Message-ID: <20240701145853.1394967-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240701145853.1394967-1-pbonzini@redhat.com>
References: <20240701145853.1394967-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 README.md | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 README.md

diff --git a/README.md b/README.md
new file mode 100644
index 0000000..5ef6f0d
--- /dev/null
+++ b/README.md
@@ -0,0 +1 @@
+This is very experimental and barely compiles
-- 
2.45.2


