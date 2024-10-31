Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 606B2D767F2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 17:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6ZLS-00074V-HT; Thu, 31 Oct 2024 13:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLP-00073z-Sj
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t6ZLO-00079x-94
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 13:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730397145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLiFAGc03L9VlsBrqIPUlTjf8Uu0ODAtffzXEXaCymk=;
 b=TxhzsBvNLTOXzVtaHW5J+lodlOUZEqn+XkihkoUkPCy8Ora0zgZe7cj20/BdMThK48s50f
 4pClZJqzPlEvS+kcQDP9dTS9yD04qj4yW1O9SA+Ek6yYuskFrh/dVPrAhtZIMGaq14YrpY
 mPzkdpJK/Bf69k5UYt18Qcb+sfxfcgQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-5dNwjqzBOjeHQfk_bRWAiQ-1; Thu, 31 Oct 2024 13:52:24 -0400
X-MC-Unique: 5dNwjqzBOjeHQfk_bRWAiQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315cefda02so8788835e9.0
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 10:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730397141; x=1731001941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xLiFAGc03L9VlsBrqIPUlTjf8Uu0ODAtffzXEXaCymk=;
 b=QLwRgSNx+QWlqA2RYP1UobscPmuyB+eNSmhZt4sqBdAiNdlMGi6KQyw5ejOSJJo1fa
 kNJ0V00SZ4Zki+FwhAIFc71AKxy5joM+FCM82u6UycH8Vv5ZcwQBuTgr//dnJP7LbBg0
 WtQY937sqtxqncRDonBT490yBF3I5dtQAIxMO0auoLi9x94S1fWIP3aZYO73tUCy8WRS
 VLnN/XAZ6Fv9weNFSbttsFqGLP2/sw4i7T1KJg28q8te2TNGoRCONTs8uxu79lvEfZ56
 pIuTYwuN2u/kdBimLpriWeRoYDa4FSkQRuxei/zKJGhrcWXU0sZ+QqQxfRwDnyBWRVEP
 jyvg==
X-Gm-Message-State: AOJu0YzkyLe1KuUB5TFcBXzT+7nGCsawerZPmxF1CJ9kT0+u8fNeB5dm
 3Go/20PtFqpVGaE/Im3gcBjWeId7JHBKUyOwAaBDtNXmk8A9BB8MAXUwu4VtlFLCY9wViHpefs5
 4Ba3zZHvKzQTcJVHSCEbQfEUvuGdMtXZ0Ee7X/pzjdvQK9ro2HIbEu53txY66tazMkYJKgnRagt
 vemmkgj1v05xCXzQGp5pjx+eAMhXvl8A+yqSyphYA=
X-Received: by 2002:a05:600c:a09:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4327b6fda39mr33862795e9.10.1730397141224; 
 Thu, 31 Oct 2024 10:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Fz+17nOiOt7Kx1V+WMas0zqU2/QfJC7rkxfYqcJCPJ3RDQ5Uh//PTnS9S64+gzadN1WvAQ==
X-Received: by 2002:a05:600c:a09:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4327b6fda39mr33862655e9.10.1730397140864; 
 Thu, 31 Oct 2024 10:52:20 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d6984f0sm35201595e9.46.2024.10.31.10.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 10:52:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 03/49] ci: enable rust in the Fedora system build job
Date: Thu, 31 Oct 2024 18:51:27 +0100
Message-ID: <20241031175214.214455-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241031175214.214455-1-pbonzini@redhat.com>
References: <20241031175214.214455-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

We previously added a new job running Fedora with nightly rust
toolchain.

The standard rust toolchain distributed by Fedora is new enough,
however, to let us enable a CI build with that too.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Link: https://lore.kernel.org/r/20241015133925.311587-3-berrange@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index f0cbdf19924..19ba5b9c818 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -115,7 +115,7 @@ build-system-fedora:
     job: amd64-fedora-container
   variables:
     IMAGE: fedora
-    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --enable-docs --enable-crypto-afalg --enable-rust
     TARGETS: microblaze-softmmu mips-softmmu
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
-- 
2.47.0


