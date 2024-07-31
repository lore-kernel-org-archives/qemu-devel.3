Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E820C52D70
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 11:19:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ7LX-0004pD-A7; Wed, 31 Jul 2024 07:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LV-0004oY-KI
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sZ7LU-0006l2-55
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 07:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722424695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cJcXNK/y8GUg9fYFr/3hXtvxWP19H58fRdjkvKirAyQ=;
 b=ZQSWovgG7UiDPSRjy0++QbTdXLRVvbmUdqqiOPAjNQv2cz4mEW+3c9jcvXga69M7YydS14
 AODTBgsmtkjX2eMxwSfARZRC5K1Wu89m7EEcRs2UnNJg09KihCcnP6QphPHAaFQtX7L8rf
 NdKMvIY147dq4lFPNel2MlSIJqKERKk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-2UQTITpJP4-rNxeh31SVVw-1; Wed, 31 Jul 2024 07:18:13 -0400
X-MC-Unique: 2UQTITpJP4-rNxeh31SVVw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5a113d5cd1eso3589893a12.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 04:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722424692; x=1723029492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cJcXNK/y8GUg9fYFr/3hXtvxWP19H58fRdjkvKirAyQ=;
 b=oz9CeKZsy6DMGGd9agCM9jXopFlcDSjodK5JtiF9rllsTHvNTEybxky/Mxn//wnO0/
 h++BQSo2/IGcirvLqzQJdKGz2Vmak4otGkIENkAMlcCdbC1gUmheOlR9QZiGL2EmmSht
 3mWH3I50XrIlZnk0zrosEu8AfM0CUTNTBjexyDPSLT3938OjeL0ngh5d9BIr+1VLWvM3
 rCKiSNlkQ0bCUqj9bdu0SEQXaZU20xUTFrmjuCSl98QGYJbMO0dh/DGW6S9AmpwH3pgv
 3KNz5ZnuWhHYLMVrErkAASQ6kmL5B9NaCRYWvk5xyHl+TU6n2ALuaFyeb4S5E1QeEhNo
 L3JQ==
X-Gm-Message-State: AOJu0YwpoQM+1FTqrI+4Tuh2QEcapcK04ByOSWfctyuRLPzBQ5FIHgx5
 ix10RZuTUbJYEEvjZ3sKuEb3LzhArj/c/Xns5WNPW5AFkhY/bV/4AjIByqw8Ce86D9hmTdyBR41
 rYCkOuzoiZEc3yYG8ppVYYdvA4X1r9rFlHlKqwZCpvQhNW3TWR28QX2oyN3IjoicYZ/SUxlrQ1Q
 s7d67kmGgfy9LLy0CYP4s7PFMAa+KxrPZfW3Am
X-Received: by 2002:a05:6402:1e93:b0:5a2:97d7:c728 with SMTP id
 4fb4d7f45d1cf-5b01d84be21mr14234840a12.0.1722424692124; 
 Wed, 31 Jul 2024 04:18:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvSQ9s2SmCECaS66Hpze2CS/qV9pFevKhYb8Djj58QrRlhZfgEP7EiphYbvEL0xx+WJjMStg==
X-Received: by 2002:a05:6402:1e93:b0:5a2:97d7:c728 with SMTP id
 4fb4d7f45d1cf-5b01d84be21mr14234814a12.0.1722424691455; 
 Wed, 31 Jul 2024 04:18:11 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5afb9422c41sm6936753a12.82.2024.07.31.04.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 04:18:11 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 01/10] tests/vm/openbsd: Install tomli
Date: Wed, 31 Jul 2024 13:17:57 +0200
Message-ID: <20240731111806.167225-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111806.167225-1-pbonzini@redhat.com>
References: <20240731111806.167225-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

OpenBSD still defaults to python 3.10, therefore tomli is now required by configure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20240729051244.436851-1-richard.henderson@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/openbsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e646f7c51e..49cab087825 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -32,6 +32,7 @@ class OpenBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2", "xz",
         "ninja",
+        "py3-tomli",
 
         # gnu tools
         "bash",
-- 
2.45.2


