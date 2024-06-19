Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB079C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 11:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJtll-0005gN-8h; Wed, 19 Jun 2024 07:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJtlj-0005fd-AY
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 07:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sJtlh-0005IJ-Kn
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 07:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718797582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FqtEplP0Cuv4L8JK9qcPGicwqN5W/0k60QOrI2bNeQM=;
 b=KHQKjaI8tJYqDG7tZfdE+HXR/wR1ImxnGTS74lYAK/qWhhbJV5a4GcJGPkCY66zevlx263
 +0PFHuneeSP6G97qB2j+euiJA88p1ZTS4ayxRMNxYSAEwD3bDWpIXjkpaTG4OIlaC9UUrs
 u1A2pie2W3ywbTpzUeJelqPZ/gvCRsw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-T0aEa0u0PqmBGdYe1PVNPg-1; Wed, 19 Jun 2024 07:46:21 -0400
X-MC-Unique: T0aEa0u0PqmBGdYe1PVNPg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3643d0e3831so13112f8f.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 04:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718797579; x=1719402379;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FqtEplP0Cuv4L8JK9qcPGicwqN5W/0k60QOrI2bNeQM=;
 b=JWtLLqXnUZIPg+eeeOivPPBc6CrRVm4PVoYQztpyb6058CxWBYWz/GjdIFeGCn7O52
 3l7JT6HcgHzi7Vy2Z5hAYnWbis3UVn58Wkh95ok7bmBpaCcRsL8cHm2Hg8oqz9n/2bIL
 QpIrTxoyXubmcD9XVKTpPeLdFbY91BEakUs/aXgJfDfz/FclRldi9LixLwqyA/r+A2k3
 uyOWHBYqhcJ9usP4DIFX4QKo2vTb9ZnpzzWXkLSqWYlzay4Dfewp4nUUFH1JMyRSgpQp
 3lzgxs6xAggpespQ9KF9zVWHGeCtdGK+6Y36cB6M20oWxwV7FL3YCynu7d3sDmyHQHoy
 EZ6Q==
X-Gm-Message-State: AOJu0YyZob9uOLrj9RXrp7lqLqBTx4VmKrb3EDWGZrHCwSntTkQ30bz1
 XAoELxECLNSueiY1jznPxkGdDTwG2IzY546qF9FvGrKsA8X31IF5yt+qzLV5KT462DJ3lHqxSJZ
 Qn/2tzuwmgmjh7rb82ImLQpyBDuUa9cOIiUvhEOGazUg8Lf4SGNfgjTK95pd3KByTthz+XPb9Z8
 s8ZKFhLAWPiHSIjT+lyY9QVmA4clAQ4PkHmz3p
X-Received: by 2002:a5d:660c:0:b0:360:6fba:40fd with SMTP id
 ffacd0b85a97d-363195b1f1amr1773771f8f.51.1718797579696; 
 Wed, 19 Jun 2024 04:46:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWGja6lHSz4vPN7XIj8L5+cIWggBeRoEIoHOeyUuiFrUxrwCsIh21zyHXhemOwetIPOeyasg==
X-Received: by 2002:a5d:660c:0:b0:360:6fba:40fd with SMTP id
 ffacd0b85a97d-363195b1f1amr1773753f8f.51.1718797579219; 
 Wed, 19 Jun 2024 04:46:19 -0700 (PDT)
Received: from avogadro.local ([151.62.196.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3640afbd532sm571465f8f.22.2024.06.19.04.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 04:46:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH] configure: detect --cpu=mipsisa64r6
Date: Wed, 19 Jun 2024 13:46:16 +0200
Message-ID: <20240619114616.251610-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Treat it as a MIPS64 machine.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index d0703ea279d..3669eec86e5 100755
--- a/configure
+++ b/configure
@@ -452,7 +452,7 @@ case "$cpu" in
     linux_arch=loongarch
     ;;
 
-  mips64*)
+  mips64*|mipsisa64*)
     cpu=mips64
     host_arch=mips
     linux_arch=mips
-- 
2.45.2


