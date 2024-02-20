Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD03C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 08:08:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcLBH-0000Dg-MT; Tue, 20 Feb 2024 03:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAy-0008SJ-EQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rcLAt-0000dq-GF
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 03:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708416502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=orF/B8kCpZl/r7yBFvkYvnBiF94OA2GnBZJaqOTj6E8=;
 b=MtilRi0jhyNpR8RCL9sH1iNIYG5Dxr1uWJFL994fTfdrvVVQTwWnA7TXAZmFhVyF+7VwYk
 2Av70N884m3+bi8Qjdt2MEOtHGHUltdZPTaDClqr7CjfbzDADLzHFyAFlhIrnnRtqEm0gx
 pMN2HjUDo3b4bbKU6qA8Ivi9ouLyl9k=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-PIaZKEX-N3aDC_p1rSFY6w-1; Tue, 20 Feb 2024 03:08:20 -0500
X-MC-Unique: PIaZKEX-N3aDC_p1rSFY6w-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-563a2279f1bso5845316a12.0
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 00:08:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708416499; x=1709021299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=orF/B8kCpZl/r7yBFvkYvnBiF94OA2GnBZJaqOTj6E8=;
 b=udCwquqI4roGirriaq6wyszdpfmDWYZagYi553GLgl8fBzz5XYBzKKweXA719Xa3sQ
 l5l4Dqqu6nwSRTRWtNiFTyerm/uxi4N6aELFWmsD8jyCX4SP96zxHh4ZnktvWx3wQFdU
 1wu3J+8fFK99CZdeObYLg3v6DU3xIvGSSpwp7gBYDqX3cEL/JtAY6qLyRlFfj7IjM9oE
 tNttpe97IeVGYC7y6jjHHrWcl7CxRqHU2k5/+0u5sH0A9X7osQOSk3XEGNk4vLqiBiVN
 MoOyJUxcRHH3ZL0KF64gY2d6vN7tE6qy9R6nEZ0LcaynzmzOg8+s9r/kOO4jTJ3zAFic
 drvw==
X-Gm-Message-State: AOJu0YwDcUq38vYTFuzXuJK0UDLSVpP2orlMDRFG+NlwtzXGRcIhE1Dk
 Ka3bPv0Hocs7FJ3oCX8DTp6ByEIkd/zZv+H7bBOFdIQt4WrMR5JyqQPCy+uXGfgm4rpkA+S10Td
 kQy7wZlF5FK4PlYFydCgaflfTsC7zTcLUsuJA6uwps8ufNg23f02ZSCyjJU//ym4sUAVJttori2
 ShJzK6ucUa1a22U5GC1DQKSx7/LPqEEjrZXuD4
X-Received: by 2002:a05:6402:5414:b0:564:2d0c:b46c with SMTP id
 ev20-20020a056402541400b005642d0cb46cmr7584181edb.0.1708416498939; 
 Tue, 20 Feb 2024 00:08:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJmcmfSx1hUKvd7D1zpV7UOvDIWN94jriFmHkaviM438Sa+yFWU2UmdlLX6s+tMWpr7660xg==
X-Received: by 2002:a05:6402:5414:b0:564:2d0c:b46c with SMTP id
 ev20-20020a056402541400b005642d0cb46cmr7584166edb.0.1708416498589; 
 Tue, 20 Feb 2024 00:08:18 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 fk2-20020a056402398200b0056418c5b6b2sm3263041edb.89.2024.02.20.00.08.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 00:08:18 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] i386: xen: fix compilation --without-default-devices
Date: Tue, 20 Feb 2024 09:05:55 +0100
Message-ID: <20240220080558.365903-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220080558.365903-1-pbonzini@redhat.com>
References: <20240220080558.365903-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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


