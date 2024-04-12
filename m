Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C931C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 10:04:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvDlX-0005AK-DX; Fri, 12 Apr 2024 06:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDlT-00058a-0i
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvDlP-0001YI-03
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 06:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712916246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mA3b2aFkTIhdcZfVSWsZn6Bp7tzG7GqbDMcehh+jthA=;
 b=TT1nRaniUijEGCdl1bORodJqbvJ7zsfcuGVJC8Fq0p9i6P6Thc8nglVzIm+/Edvd0ziqdG
 P1XTBsa7aDs6uN539b6im15NrZ/tyHp+Ty9q+XUDR06YeGDcwCFZYUrNwTvbIn+6Mlabdk
 bB5ITF/uop88pRRSYQNR4G60qy7hmrw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-189T5Ht5NZ-xxAPTy2a85A-1; Fri, 12 Apr 2024 06:04:04 -0400
X-MC-Unique: 189T5Ht5NZ-xxAPTy2a85A-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a52052809caso56153366b.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 03:04:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712916243; x=1713521043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mA3b2aFkTIhdcZfVSWsZn6Bp7tzG7GqbDMcehh+jthA=;
 b=jtRp3BMVmO2LOlw4Y6rbZnCUXREFXL+d6PpsfquODOOMif+16XiYFPmg3tNh91ILyO
 dMVEE0eM2u21Q84FSQ43xCER8WRZR4fvtv4CfD5OW8I7mejJJlAxr+2QWfPEYCrMEBxj
 o8DEYuaybzpjMak8Cwwlc+10r+tpGH480scckrb3Bp/eqaJVH6bGTt1pwGxKWH2nNFWC
 doxCkUpINhKXmUQtd4pZOVQ0zZHjVFsgrnjj5cMWm6OXHao5061GO7tDIbwQFB+fEq5a
 Zy/Y7BAVSVn0LGJoSZXcrDo5TukJg0R4wKxyc+oO1cnE9EnxFtBcBXdUxyNSsR7lOOSv
 jq8w==
X-Gm-Message-State: AOJu0YzrW5nxaOTlve0NZCiJFMKH70UdSt2QCayhdqDiRYtjghDBl7s/
 of+jLQjyxn1xo/rF1L1MJlHFfQ83WhL3DewaRZWvXW1CtebtRdOYvQj4/v4SkH+rNOl5NNhGOj2
 1HNpu/oVK4UNF17E54lAItmfQdbaVF4f6w/J4lCLYinA17QyX0DvnkjGfXiosq4KgkV9aZaAvXI
 42jqJ5eKd/ji8Wh8TZX90pjxaZDdgXMJ2wLAbc
X-Received: by 2002:a17:907:2dac:b0:a52:3556:85db with SMTP id
 gt44-20020a1709072dac00b00a52355685dbmr1571013ejc.19.1712916243152; 
 Fri, 12 Apr 2024 03:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFw6u9s2lZcYppZ2UMWaaWJ5Na4jYhQASxyHLqd0YKzfCKJro226lbqt0VHmFngNF5+CKzvsg==
X-Received: by 2002:a17:907:2dac:b0:a52:3556:85db with SMTP id
 gt44-20020a1709072dac00b00a52355685dbmr1570994ejc.19.1712916242733; 
 Fri, 12 Apr 2024 03:04:02 -0700 (PDT)
Received: from avogadro.local ([176.206.87.39])
 by smtp.gmail.com with ESMTPSA id
 hz22-20020a1709072cf600b00a522f866cd3sm800644ejc.143.2024.04.12.03.04.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Apr 2024 03:04:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Final build system fixes for 9.0
Date: Fri, 12 Apr 2024 12:03:59 +0200
Message-ID: <20240412100401.20047-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
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

The following changes since commit 02e16ab9f4f19c4bdd17c51952d70e2ded74c6bf:

  Update version for v9.0.0-rc3 release (2024-04-10 18:05:18 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2d6d995709482cc8b6a76dbb5334a28001a14a9a:

  meson.build: Disable -fzero-call-used-regs on OpenBSD (2024-04-12 12:02:12 +0200)

----------------------------------------------------------------
build system fixes

----------------------------------------------------------------
Matheus Tavares Bernardino (1):
      Makefile: fix use of -j without an argument

Thomas Huth (1):
      meson.build: Disable -fzero-call-used-regs on OpenBSD

 Makefile    | 9 +++++++--
 meson.build | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)
-- 
2.44.0


