Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0421DC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 08:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCwdr-0001SL-Lv; Thu, 08 May 2025 04:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwdd-0001M4-JS
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uCwdb-0008Cc-Pj
 for qemu-devel@nongnu.org; Thu, 08 May 2025 04:29:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746692988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KM1SQb3E2Vsp14fCIyp5AKJJoRWd570avF7cZiuylIE=;
 b=Pw69/azWXPipRFwrsVRbSnqKq+Cov3a+o1fb0/mCoOvpxtJdL42DZzIGNpbHGVgc+iQgz4
 dSN1roya064N7+YIKovgqNps+21gH/82HElJy/qOXVxnj12TlVf10epH00vB9X0ROk7s38
 x4ZkeQfSONtkxlPzIp+numGhkPuZhuA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-kuir-7qJMwi2_A1plpAm5A-1; Thu, 08 May 2025 04:29:47 -0400
X-MC-Unique: kuir-7qJMwi2_A1plpAm5A-1
X-Mimecast-MFC-AGG-ID: kuir-7qJMwi2_A1plpAm5A_1746692986
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so4769925e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 01:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746692985; x=1747297785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KM1SQb3E2Vsp14fCIyp5AKJJoRWd570avF7cZiuylIE=;
 b=Oxc9mWtaOL4k4bYG0UYCAQKQiT/NdYsH34OuIMYizuQD+7Or4Opf1j1zDIveLSRAKJ
 EU7uspWcNl4npcQV/gNbIXM3kISyOhLgO8724/j97a78UD33yxnPz5t/X/JrS5JxsSvL
 MlHIzAbGPQoeXO2Kc0uLuqT8tCoIC2Mpx/L+vmtvJRoGaeWm5U4H48bd0CMgVhsc9Cun
 qDvKDEIAOUHGRtiauYkk2zBGpnqwBOKTf2+ESx8aAdimD0b3DZTORhK0P+N1xnW/AiLF
 27X+9J8wSIZM/dPioEZPKTV3fIbSHScjLev6XuXQUj5bKVSW9XvOxQgGzCz6m8X991yT
 tslA==
X-Gm-Message-State: AOJu0YyNRaJcnlR6C2limjpXWrF5WvCuUtESPn8YLiYRIUNu0pdaocO9
 EDBoKnaHUqIZHjfupgdXod/3K9oCdqdQ88KPO4HZPEVIozaxX15F5juiBposZ7Gz3Hb2iNpPQSu
 6QVRxa3lEIs7xC1jnn+nLNMAM1uB9XIMsvQsmeliN5QulMOtMAwLNcgcifC2jfFTxzFrsrI4FtZ
 crk6ixMEZRqcLR2VgBXu/kt0hvA+swIK37C1N8
X-Gm-Gg: ASbGncuQB8Mq+5EuMY9oeG9m1bmAC1GdxDFZTu73NSArNJalrcjFJOutG4Bl9TTfmpM
 Z7fVLQfndOyPdE6YCnNP8C2rMs6I2s4W840zZKOvTwbxlhik/BM+p3rHrS7XMllSKaXOW7FQnDu
 Z3iPmiMSrbAw2ukAvnve2B9pjZqSomzaXRMJvRde4O/o6LXn62V/va4umwAuasxGpblFyYfFIRK
 evlgYY8dkbjvKRI9wufr4227C+3TWsqf9hT9hy9tDnWdHfe/qR/Pze+/fANXvXXVkroyActlAGe
 slv1bZW5RjXKLkc=
X-Received: by 2002:a05:600c:4688:b0:43d:fa59:be38 with SMTP id
 5b1f17b1804b1-441d44e58b2mr49827885e9.32.1746692985013; 
 Thu, 08 May 2025 01:29:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1V7x0XCOwlJ1KWQ5SVitAW0DJD6hkdnamlLcSdXdp1dpU0BjEYxl8hQTxqajmbwU43UBMw==
X-Received: by 2002:a05:600c:4688:b0:43d:fa59:be38 with SMTP id
 5b1f17b1804b1-441d44e58b2mr49827645e9.32.1746692984601; 
 Thu, 08 May 2025 01:29:44 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.54.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd351315sm28692405e9.19.2025.05.08.01.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 01:29:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/2] rust: pl011: really use RX FIFO depth
Date: Thu,  8 May 2025 10:29:41 +0200
Message-ID: <20250508082943.446512-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Forward port a couple more commits from the C version.

Paolo

Paolo Bonzini (2):
  rust: pl011: Rename RX FIFO methods
  rust: pl011: Really use RX FIFO depth

 docs/devel/rust.rst              |  2 +-
 rust/hw/char/pl011/src/device.rs | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.49.0


