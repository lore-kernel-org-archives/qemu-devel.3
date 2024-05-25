Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7140BC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApff-0003OF-9b; Sat, 25 May 2024 07:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfe-0003Lf-9u
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApfb-0004Ag-PR
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLcj+G3nZNoagmtde0jJ4iaxwOIbWk0F9rsJ0Ab16Xo=;
 b=EKn46F2X3klPRLp5frTAzoRAkYAbAXEBSYFRjCHuECViknJNh5ZnrH4jXSA/XjeBu8ILxO
 oxusTal3Lf5gm6srLszAnDnILvbJd3eMkF6/8WsBXz9phV4lp6I8g60LxrVsIGaXV8QsJD
 RGT4yQfNj95TuYcFbPMLVNzw3Uxmq1U=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-ibeF3mAQOqiFxmcU6Xfdcw-1; Sat, 25 May 2024 07:34:35 -0400
X-MC-Unique: ibeF3mAQOqiFxmcU6Xfdcw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a626ac4d29aso82040066b.3
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636874; x=1717241674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLcj+G3nZNoagmtde0jJ4iaxwOIbWk0F9rsJ0Ab16Xo=;
 b=W1hs+aFSaziST1fxS8nAicbqBPP37p/nV/oFEs/S0p5xuKOenV4QHWl5eNdV2GG4c8
 dtqK5+pLTtL4ku+j8rRcyKMW4dGZppcvI8hQ5guFF6si2+THCM5g31t836+rQfUkqmNX
 wh8OlNc+YV5pKbduphh3HKNvrHe4VC/w4vtTwIf0U5AUK73r6amxkyqb1tCWGeYyAbuR
 AUOCQ0oD3v9tyLIDSXKo97P6N6HnrOsmT0IbJUaOcpMx6v7ltafwmeOATU6hQgx8oFPd
 95Y0XDfanP5ak2tTE+8Bn0Ec8sOuOs41JeO74k8DatpKUg/iYLTXxWKvaWsvXaboihTs
 rIFA==
X-Gm-Message-State: AOJu0YyyNysXP6wFgnRVq74HUw/ih01I0y7z5SfDg+kNRpl4MBFtnOoH
 iFZdRYmzrcknxg4GM3luXd37TFC/WhpvD92ndVQ32y6yd4OemOTxPC5LbseWfsej6Zk44q6iL2T
 0D9gMdcTKO4B3ccauifB2YSR2XdTwSHJP5KvnAtAim/jHnfZh96nUN5rRajtQq3E2XLKDrzx2Oh
 ca6pQpH9u1tcRQTwNy95DPtjxDpQxtLyrnCLIP
X-Received: by 2002:a17:906:79c1:b0:a5d:3889:da9a with SMTP id
 a640c23a62f3a-a626514edf1mr308089166b.50.1716636874135; 
 Sat, 25 May 2024 04:34:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9J03ih6REXIYrr6dF6rSng6RSS7fcA9xOlQlep43VTbksaD3u6G/YXSKZELvwGfQCECELPQ==
X-Received: by 2002:a17:906:79c1:b0:a5d:3889:da9a with SMTP id
 a640c23a62f3a-a626514edf1mr308088066b.50.1716636873773; 
 Sat, 25 May 2024 04:34:33 -0700 (PDT)
Received: from [192.168.10.116] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817b0asm245957466b.3.2024.05.25.04.34.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:34:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/24] meson: remove unnecessary reference to libm
Date: Sat, 25 May 2024 13:33:28 +0200
Message-ID: <20240525113332.1404158-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240525113332.1404158-1-pbonzini@redhat.com>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
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

libm is linked into all targets via libqemuutil, no need to specify it
explicitly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/meson.build b/block/meson.build
index e1f03fd773e..8993055c75e 100644
--- a/block/meson.build
+++ b/block/meson.build
@@ -110,7 +110,7 @@ foreach m : [
   [blkio, 'blkio', files('blkio.c')],
   [curl, 'curl', files('curl.c')],
   [glusterfs, 'gluster', files('gluster.c')],
-  [libiscsi, 'iscsi', [files('iscsi.c'), libm]],
+  [libiscsi, 'iscsi', files('iscsi.c')],
   [libnfs, 'nfs', files('nfs.c')],
   [libssh, 'ssh', files('ssh.c')],
   [rbd, 'rbd', files('rbd.c')],
-- 
2.45.1


