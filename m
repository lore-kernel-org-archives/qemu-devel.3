Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82203C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 22:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYu4-0007xF-7K; Fri, 09 Feb 2024 16:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rYYu2-0007x7-Jx
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:59:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rYYu1-0005v3-7o
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707515959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=orF/B8kCpZl/r7yBFvkYvnBiF94OA2GnBZJaqOTj6E8=;
 b=jNXVNB560w+1kM1Cf/AffbQZaDhQOkivpMR95KqJ7xFkW+W3Ep1imwj3yGeSp3QVBuLaCg
 Qbpk8H+fzovxdhLDO2ccZtUHijW8TMYl3TA6bGv0vQZe2f/0jyPmlJA5CD7IfqSj+dVGUq
 5ZJWo07hA1fYDurYbU8J7RXqJVEUrSc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-xjZKzaN0PRu4YTGzivJ9kQ-1; Fri, 09 Feb 2024 16:59:18 -0500
X-MC-Unique: xjZKzaN0PRu4YTGzivJ9kQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a388c223625so72739266b.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 13:59:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707515956; x=1708120756;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=orF/B8kCpZl/r7yBFvkYvnBiF94OA2GnBZJaqOTj6E8=;
 b=ItDnIvVeVwxGgTLeDKnJNOAvhKy5Y/P6FX6gOy/oIPfxg2U33cragANt+XZ5KZIloK
 ITL+6O8fYrLoNE55Kj6Hrn7azSkdk2h56/DwhAdq+PDtSefH8eQO+P8JjzSC9FBfQfc2
 decW6gdiZaKCb44UD350cEgCMND4XvLdl9spcct84LovEEfN7ayDwKnPFErxybxf9Hs/
 In0+Za4yaZ/4UDW8hdlYeHyoX9iAbj2kwiaAK2FRAKVmO2FIZZEwCz/qm3tjncvhkNEE
 wSOyLbqOItDh9kByz4ePAMBPha1uIhsY2hraBCXmbHGEhLIMZb5yGicI+o4qQCgsaRmD
 K07g==
X-Gm-Message-State: AOJu0Ywckh+WYZhqAK322DZYEaUbbwWJCYr3DGyY1COJ/CtXrvd3lMFg
 2rBfqdUq0s57EifqqwuSM2FI9qvS+3f8YYv2EuezUBIx+InoKVYNsfJUvs2ug60Y6I5Q79Tl46n
 MTXr8BpUAj0PsBQ6aQkKuOvo2tQQaYriKi6Qaez/oAEKl23gkc1PhX04elWSXPoF6u9FmBSsXz7
 ECTk5PtidO2tJ9qhtr6AeZlX5A0NEMH3uCFBS7
X-Received: by 2002:a17:906:796:b0:a3c:319:a2f8 with SMTP id
 l22-20020a170906079600b00a3c0319a2f8mr213828ejc.40.1707515956724; 
 Fri, 09 Feb 2024 13:59:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFmRhz0JvajujgGv4JiDvnhMOQyDAUcyC7Ig9DLJQVoCiah8mtfK/srPxV7tEZc76nK13Y6/A==
X-Received: by 2002:a17:906:796:b0:a3c:319:a2f8 with SMTP id
 l22-20020a170906079600b00a3c0319a2f8mr213820ejc.40.1707515956277; 
 Fri, 09 Feb 2024 13:59:16 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 gs36-20020a1709072d2400b00a3729ce6321sm1129543ejc.166.2024.02.09.13.59.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 13:59:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386: xen: fix compilation --without-default-devices
Date: Fri,  9 Feb 2024 22:59:14 +0100
Message-ID: <20240209215914.131345-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The xenpv machine type requires XEN_BUS, so select it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/Kconfig b/accel/Kconfig
index a30cf2eb483..794e0d18d21 100644
--- a/accel/Kconfig
+++ b/accel/Kconfig
@@ -16,3 +16,4 @@ config KVM
 config XEN
     bool
     select FSDEV_9P if VIRTFS
+    select XEN_BUS
-- 
2.43.0


