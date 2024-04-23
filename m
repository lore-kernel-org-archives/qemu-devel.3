Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A74BC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:19:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0m-0005Aj-5S; Tue, 23 Apr 2024 09:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0j-00059b-MH
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0i-0001uk-1p
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PXHtC2xl9RAtbS0F3QVWIE+OZhVyfPtZyB0bS1TkXQ8=;
 b=eA3SO1L60/+3gcNlVoDAPoWMg/wPaPzM8R8zQ21l19jJO7llWeZ8c2daviUGxKfYGpMqRm
 GNrweDaNDRxGoGVNHOfp0hSchdsEoY6Q9ZhxN6rzdWN91/zgeDzAO/qqeIBuQG9Z0DL2J6
 jeWFAAbzfuoujFZD4rf5aLCVEAO1mZM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-Tqe2qq8nP4aCaxmvJxoVFw-1; Tue, 23 Apr 2024 09:16:34 -0400
X-MC-Unique: Tqe2qq8nP4aCaxmvJxoVFw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-571fee4bbcbso1590771a12.3
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878192; x=1714482992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PXHtC2xl9RAtbS0F3QVWIE+OZhVyfPtZyB0bS1TkXQ8=;
 b=vFf4Z0P0wo+6Phk6xQ2Lw6hxRS9w0Xnc3ezRfP4n9JY9IZWK5+53GFAF7m4PjsMa5/
 TEaB1wouIrlzKarZmRL4lTN1F548jePsQdFeRMQojLUHGyYQIa5uJuZh5Wi/Ja3dneF0
 luWC5PvfdtfisRiWdB2ZCLnN4cupIYVAGFIcO1t7hGOSScFfFg69sOgPLAmNqMKzsAV7
 /5o6dC7qZMJOY6qlMaZl0LGa1nMg1Dl28vSGZXFbL6XwwxizMxFkw9WXYXkFwSdTFtbx
 /4sXEpHOvYfVTRpq44nF0M/abIX5JIVCOBUEeKXxV077mazZ50tdaLP91VFj/WCNBiCs
 82dw==
X-Gm-Message-State: AOJu0YwUgcfEnUQ1PHf7GdsZlD7VHcx30QPYUAsqp8LDsxRL70sddSNG
 MqBSlomh7/f5F5q2vDssfc/XZ3I/VZOJzIZM+212d1sSj5v1wBsVCguQHFe6Wh8a9ejKqyeEIaP
 a9Vvo3axueshQneYSNzaZ3Fg9g21Y+xmqqVHPkK0pUsCGxDmL9ulLCxwpHjhmgqghyzyKiModIJ
 z7/KdHTnbImBMx6SZ+2bpBGu4hOFJ3Wd5+H+Bk
X-Received: by 2002:a50:d6d7:0:b0:56f:e7b9:e67d with SMTP id
 l23-20020a50d6d7000000b0056fe7b9e67dmr11782620edj.12.1713878191037; 
 Tue, 23 Apr 2024 06:16:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9BxWqTy6qR7BOgsV0G2DB2GDNVk7mQu1QvH+VkCm7r+RUts5oHxDbnR60xkQAWd+4JIvJDA==
X-Received: by 2002:a50:d6d7:0:b0:56f:e7b9:e67d with SMTP id
 l23-20020a50d6d7000000b0056fe7b9e67dmr11782607edj.12.1713878190737; 
 Tue, 23 Apr 2024 06:16:30 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 be12-20020a0564021a2c00b0056bf7f92346sm6649475edb.50.2024.04.23.06.16.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 06/22] hppa: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:56 +0200
Message-ID: <20240423131612.28362-7-pbonzini@redhat.com>
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
Continue with PARISC.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/hppa-softmmu/default.mak | 5 ++---
 hw/hppa/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configs/devices/hppa-softmmu/default.mak b/configs/devices/hppa-softmmu/default.mak
index b0364bb88f2..059510cdbb7 100644
--- a/configs/devices/hppa-softmmu/default.mak
+++ b/configs/devices/hppa-softmmu/default.mak
@@ -4,6 +4,5 @@
 #
 #CONFIG_PCI_DEVICES=n
 
-# Boards:
-#
-CONFIG_HPPA_B160L=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_HPPA_B160L=n
diff --git a/hw/hppa/Kconfig b/hw/hppa/Kconfig
index ee7ffd2bfb5..d4d457f4ab4 100644
--- a/hw/hppa/Kconfig
+++ b/hw/hppa/Kconfig
@@ -1,5 +1,7 @@
 config HPPA_B160L
     bool
+    default y
+    depends on HPPA
     imply PCI_DEVICES
     imply E1000_PCI
     imply USB_OHCI_PCI
-- 
2.44.0


