Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E40C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzG0l-0005A5-Ab; Tue, 23 Apr 2024 09:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0i-000591-Hx
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzG0g-0001ty-9V
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713878192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Bg47VEYX8xjzqwqoIaAS5G/3VYVtHF2eJSxk2eS5UY=;
 b=DGrysbbfnzCjFcS6kMd5vmHrQYs/ZDnKkBHqi1bmXcxCEjKv/FRA2EusqqPVbmfWRuoRYF
 FQAEAYc+3DQkPnf8y/z5Xau+GtCEX85iVTghG8gllTH9B+ZHrW4WjBi3vwxgZQUnLx0GmV
 hCCZcoE2H1oApydKdEwnie6fJJXfOaU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-RlOzMKvSPoiKAy0NoE8wjw-1; Tue, 23 Apr 2024 09:16:30 -0400
X-MC-Unique: RlOzMKvSPoiKAy0NoE8wjw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a587d2a9b5eso50711266b.2
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878188; x=1714482988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Bg47VEYX8xjzqwqoIaAS5G/3VYVtHF2eJSxk2eS5UY=;
 b=FAT/fK8KM1CkWvUeOzSMivs0nAn4u4IapeV26a4NoLP12XSSu+lp0EW+bjE0pUWTKe
 5QUEBUdk+KH8oLYC18fkEgNQhDpPU368xf0dI4VOdZlSLRnNlH7JChoeW1wMxi4LZ36i
 MrhF91/d3CMFOh7/cjRPRcrSBNG3GNDfVEwTQj09MWzOu/3circnq2xcWrJ8afVBH4iz
 dewJ0qswPPAk/WeYSdQjibh+D4oIRr4LD4KtFEasxdje5WRWb4wN91pxFCst1lypOH+I
 n9YkTCFa8d2yPstz5d8+CVjmnW9SRpBk5jrK6TnLBDcvz/DlqBksgzLjbBhI4NARsa+T
 AtLQ==
X-Gm-Message-State: AOJu0YythVlRdMWosAoy4qJx19l1RgLGrmmWskwomkTd0mP8eahGckZk
 zFAT3k2POQpahzvsRhacC1SpUtZ11DzOmIxrKGsslAZYqFKikxn4sOS6WOmxMo8ecNtksk/I9kW
 oVO5Ro0HQxcbKOb3/RbSyvKo2U4D7471W4yj73S3Ce/T3HnMzO8xHnjiH+feGWoFdGYoGWL55jP
 qeM4YwVsQyXDKPqnxhEc9dhWbcy5AQAO8Qxq6Y
X-Received: by 2002:a50:d645:0:b0:56e:743:d4d9 with SMTP id
 c5-20020a50d645000000b0056e0743d4d9mr7944452edj.42.1713878188462; 
 Tue, 23 Apr 2024 06:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUlrnMhsN0v8wgLMvDn2RAkTG8TqdnsfUz2pVkmaXSm9HVio//dQ6FDsO6+MJyo+R+WLOccA==
X-Received: by 2002:a50:d645:0:b0:56e:743:d4d9 with SMTP id
 c5-20020a50d645000000b0056e0743d4d9mr7944441edj.42.1713878188048; 
 Tue, 23 Apr 2024 06:16:28 -0700 (PDT)
Received: from avogadro.local ([151.81.119.75])
 by smtp.gmail.com with ESMTPSA id
 ig1-20020a056402458100b005722514c67esm347989edb.14.2024.04.23.06.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Apr 2024 06:16:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	farosas@suse.de
Subject: [PATCH 05/22] cris: switch boards to "default y"
Date: Tue, 23 Apr 2024 15:15:55 +0200
Message-ID: <20240423131612.28362-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423131612.28362-1-pbonzini@redhat.com>
References: <20240423131612.28362-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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
Continue with CRIS.

No changes to generated config-devices.mak file.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configs/devices/cris-softmmu/default.mak | 5 ++---
 hw/cris/Kconfig                          | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configs/devices/cris-softmmu/default.mak b/configs/devices/cris-softmmu/default.mak
index 5932cf4d06f..ff73cd40847 100644
--- a/configs/devices/cris-softmmu/default.mak
+++ b/configs/devices/cris-softmmu/default.mak
@@ -1,5 +1,4 @@
 # Default configuration for cris-softmmu
 
-# Boards:
-#
-CONFIG_AXIS=y
+# Boards are selected by default, uncomment to keep out of the build.
+# CONFIG_AXIS=n
diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
index 884ad2cbc0d..26c7eef7437 100644
--- a/hw/cris/Kconfig
+++ b/hw/cris/Kconfig
@@ -1,5 +1,7 @@
 config AXIS
     bool
+    default y
+    depends on CRIS
     select ETRAXFS
     select PFLASH_CFI02
     select NAND
-- 
2.44.0


