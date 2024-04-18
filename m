Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F891C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 09:18:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxNtM-0002rf-3F; Thu, 18 Apr 2024 05:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxNtB-0002qk-Ba
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rxNt8-0003C9-Qr
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 05:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713431820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cD18UsUIow33eqJYZAW24in/f0iGSZfeTKN2Rye6MnU=;
 b=Qh7270Az6B99JbvLkzmumHC4LhuIOnNWa3mnfor6ImnBKsehvPzl4UKXegHELKrmXFrt0c
 YXd78xsSwHDbfdOZd7SJ9wtUh5Js1nsrHDupEnX/IDo/oVXE8S2bOz+/rOtmSKVh0VY28C
 RHMUwTaQ/J3pS3+s5LSIeIhzVtqzWr0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-QsN0VPGLNV6HwkeAOaKUpg-1; Thu, 18 Apr 2024 05:16:58 -0400
X-MC-Unique: QsN0VPGLNV6HwkeAOaKUpg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a5563ef10d4so34432066b.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 02:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713431816; x=1714036616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cD18UsUIow33eqJYZAW24in/f0iGSZfeTKN2Rye6MnU=;
 b=FO0V/AEiLB9ZLvq5hU/3BJhhMPowhKZUOTg+hP9+9QIzQ8Cv0ByEKvEGIIls5DxuUQ
 XgUCRc7yYT3KKzTSvkgfol5BmB1t+Y59LUcCfNana8dhkuGuOhpQAtaRmYHT116daKmI
 1ZmKWZK9Rvia3Z9ApaDY1jB8lyc1NwT06mxGutw5Z1SitF2G0+FbyCRf6ygiiJQizirO
 LCJl4WHgzz/PUC2LAU1pVJDUaCSQ/AZRyktKSa1fCzx3TlNb4Uiie6P7piAgnv6NiHZ5
 mO9KPdHb8ipVq1ZsJxPpJ0DAaPSK5D91IJ00WgJh4uCthHPMZSzh5mOp0FSgUZViZYqy
 FrVA==
X-Gm-Message-State: AOJu0Yzz8oGvMRI3Ao0kj3AJjlkLSzOS9ggPjwxl6Mb2YFP35G+mhIZl
 /ItkmBKj08mXRZG2Jnc+VM6BIvReNgGaAWAgBbK/WX1KFLpOiNT1xmQg3jY9vFK6A8zdVLejE6/
 pAwvDzxzr9ppc9DgFyvcS+tFOEK2ZSmXSuE6yn+5FBAimmVQbc7z/62s0ylchKh0eEfWYuisGK5
 Uutr0o85jf2f2wUB4zzwQj5dU3cLWm7JZzZZ6O
X-Received: by 2002:a17:906:3108:b0:a52:6a31:a9f2 with SMTP id
 8-20020a170906310800b00a526a31a9f2mr1099765ejx.70.1713431816202; 
 Thu, 18 Apr 2024 02:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp9OATuQf0bHzxcrNCHB6bjSyu0q7fLskqB2NCbgslFU1gAycPHRqykQFVnldsNYnTbIzCnA==
X-Received: by 2002:a17:906:3108:b0:a52:6a31:a9f2 with SMTP id
 8-20020a170906310800b00a526a31a9f2mr1099756ejx.70.1713431815854; 
 Thu, 18 Apr 2024 02:16:55 -0700 (PDT)
Received: from avogadro.local ([176.206.84.58])
 by smtp.gmail.com with ESMTPSA id
 lk19-20020a170906cb1300b00a526418d0ebsm630477ejb.74.2024.04.18.02.16.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 02:16:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
Subject: [PATCH] pythondeps.toml: warn about updates needed to
 docs/requirements.txt
Date: Thu, 18 Apr 2024 11:16:54 +0200
Message-ID: <20240418091654.16878-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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

docs/requirements.txt is expected by readthedocs and should be in sync
with pythondeps.toml.  Add a comment to both.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/requirements.txt | 3 +++
 pythondeps.toml       | 1 +
 2 files changed, 4 insertions(+)

diff --git a/docs/requirements.txt b/docs/requirements.txt
index 691e5218ec7..02583f209aa 100644
--- a/docs/requirements.txt
+++ b/docs/requirements.txt
@@ -1,2 +1,5 @@
+# Used by readthedocs.io
+# Should be in sync with the "installed" key of pythondeps.toml
+
 sphinx==5.3.0
 sphinx_rtd_theme==1.1.1
diff --git a/pythondeps.toml b/pythondeps.toml
index 0e884159993..9c16602d303 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -22,6 +22,7 @@
 meson = { accepted = ">=0.63.0", installed = "1.2.3", canary = "meson" }
 
 [docs]
+# Please keep the installed versions in sync with docs/requirements.txt
 sphinx = { accepted = ">=1.6", installed = "5.3.0", canary = "sphinx-build" }
 sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 
-- 
2.44.0


