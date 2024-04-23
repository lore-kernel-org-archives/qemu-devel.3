Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08100C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0q-0005BY-68; Tue, 23 Apr 2024 09:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0o-0005BA-0T
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0m-0001vK-DZ
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878199;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g0PAnrr4ct5Hs7lBGT5lWUo0Jjpb/hEa5kBgK9HEkWI=;
 b=X0Ff4mnDbZ9OimjYlpyGDyK+qmNQ4qft7Bl2Pp2OSbPReKASKPd0wv2wfehlNXZ+14SDOm
 QmPmtoUfQZHRtcQSdsrn1dQAJMOZRAOie2kGpir9qXS6aUo3drPxGVcPMOPgCnQpQw7y+9
 w4jN+NN/Wl+8EJmwbEDAxZiowZt1cyA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-pGqRnV39OoiL7fIzp-6vlA-1; Tue, 23 Apr 2024 09:16:38 -0400
X-MC-Unique: pGqRnV39OoiL7fIzp-6vlA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a51fdbd06c8so393394166b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878196; x=1714482996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g0PAnrr4ct5Hs7lBGT5lWUo0Jjpb/hEa5kBgK9HEkWI=;
 b=sw2GbwlgIwHgeDZIHRFbrzIc6OIHEG3fKaSI3nly6iv6d6mqWSGObdqwuB/ygvZKmz
 4uawMpHAgvT18SxsAXCOrot54iSHhe5Fvpa8GijEvdrcosAV7fDSkXeEjx5xMjS7kCnc
 X5So7hC5kvP3syfUFYvnipaN81VlJdI6uALPwE/sVe5KfhGIO/8xA6nIyIFJAy8Gl6DB
 fxHtGvk/tOmHT2au2TqPOGDp8Czo5Q8GQG8YSD78H+YgtefA5+Mjj4AVwCnMbVp3Dq6u
 wZXdM6JsUfASMTObZgbjzZEqAjFoth1xRBW3xPhRMGjIVv79KwuAZnl8GsYzA2OdiU8H
 fQ+w==
X-Gm-Message-State: AOJu0Yw1CcBrApZpHg4238iOMSSUrnFbmtzEhnar6zmiiqrlVe6DkDFU
 /QS++sAzErbI2hW/0rkbPHhIn2zp1TdJumvz3zQhv0UMNaqvuHz2YQxnItr/FxDyV1kdcl8/9am
 yT85YBPiSvvw3AKQplqvlSFxQRLkp1VnuNR3hj7zlZVa4V8mCcHiEsncuEDEwASIPOv/01wDowt
 8+G70Mg/BoDdlp+rqAvqgEHI1GEm8/xwNU2K2a
X-Received: by 2002:a50:8ad1:0:b0:56e:428d:77c1 with SMTP id
 k17-20020a508ad1000000b0056e428d77c1mr8562423edk.36.1713878196468; 
 Tue, 23 Apr 2024 06:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5G5dP5qhgp2ZCZIbbww1LTtTwcy48eitEGBU2ufgqYEi+Hp0NKisk4mbHJqvj4hDMXWGJhA==
X-Received: by 2002:a50:8ad1:0:b0:56e:428d:77c1 with SMTP id
 k17-20020a508ad1000000b0056e428d77c1mr8562409edk.36.1713878196203; 
 Tue, 23 Apr 2024 06:16:36 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 cn18-20020a0564020cb200b00571bfc97b79sm6350281edb.55.2024.04.23.06.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 08/22] loongarch: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:58 +0200
Message-ID: <20240423131612.28362-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
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

Some targets use "default y" for boards to filter out those that require
TCG.  For consistency we are switching all other targets to do the same.
Continue with Loongarch.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/loongarch64-softmmu/default.mak | 3 ++-
 hw/loongarch/Kconfig                            | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/configs/devices/loongarch64-softmmu/default.mak b/configs/devices/loongarch64-softmmu/default.mak
index 0893112b81d..ffe705836fd 100644
--- a/configs/devices/loongarch64-softmmu/default.mak
+++ b/configs/devices/loongarch64-softmmu/default.mak
@@ -3,4 +3,5 @@
 # Uncomment the following lines to disable these optional devices:
 # CONFIG_PCI_DEVICES=n
 
-CONFIG_LOONGARCH_VIRT=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_LOONGARCH_VIRT=n
diff --git a/hw/loongarch/Kconfig b/hw/loongarch/Kconfig
index 5727efed6d8..78640505630 100644
--- a/hw/loongarch/Kconfig
+++ b/hw/loongarch/Kconfig
@@ -1,5 +1,7 @@
 config LOONGARCH_VIRT
     bool
+    default y
+    depends on LOONGARCH64
     select PCI
     select PCI_EXPRESS_GENERIC_BRIDGE
     imply VIRTIO_VGA
-- 
2.44.0


