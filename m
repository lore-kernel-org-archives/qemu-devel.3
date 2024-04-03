Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF4FFCD128A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 10:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrxVm-0007FY-Ds; Wed, 03 Apr 2024 06:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrxVi-0007FM-MQ
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:06:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrxVf-0001If-W1
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 06:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712138781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0jkAk9G8NDnIDWWyPdfdSzx1H+BSp6OwkxTdxfYtaTI=;
 b=fv8kMYa0EfH8K1mlygUPXrLuNhoGugbSv6I/jL7mFNytymS1WBZVv6/tTDflJSnN57zn82
 0kD6nV+QW4Sxevr5PEIZra6NyZUYs9ZAIZP4esRz+4na7SZJKF440VQGixj0juI4YOZ2iG
 EJ/E8yHE23Xkc/HUEMVtKjDZdDsCWD8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-jynomvQ1PtieW3M8xaN2zQ-1; Wed, 03 Apr 2024 06:06:20 -0400
X-MC-Unique: jynomvQ1PtieW3M8xaN2zQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-516be090f87so583136e87.1
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 03:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712138778; x=1712743578;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jkAk9G8NDnIDWWyPdfdSzx1H+BSp6OwkxTdxfYtaTI=;
 b=oSlrNsMjuCn96rp/xC96cmIjUiKkUij5pvXIdBF0wBkKT8mbc7Rd3ffToP3Hs65qJr
 FCs06uEWKFzGkuZwTy/7Om0RbLsIJeV5EEQQ0S5QgJy0kvaOgz1JyMcYsAz9HQodBJOA
 kVNBZDkAlgPENQ6UGQzsUVeJz4+x9BHt5Kwr4OFYI0Jr5lvN1MA0LgweUGP9mbWcSxIn
 bLnfYJ2sgT8AP99wN6WUKRb2t6+nXrMxGDRjtwVSIT1xQoDDJwmvKR5JUg+JdDyhI85+
 TCqTcRvn86pJa0S4+kiHCCVsWpZSTnehqPWfp/dkytDwrDPVIESKinUx6JsvpLNly8dj
 fhyw==
X-Gm-Message-State: AOJu0Ywsi/r4HJ44R37mt4tCE4lAAAbnweIozoU2RrOSQs3rc82x3Jl3
 uEuE5j7r9pxYBCpgFzpJwhJnT/rPE1CjOzXXHQ5sNopEXQ+bwf+4lg0brWEYyQ1PzcvEIIQdP3F
 C87cDNBuNbmNxAB+tpSo7bWTPo5FUk94e0Y/n7lTzS2ZfYb+/MtQMMAWcxelAZ4XL3s7jcDuMoq
 ZtXTrprusx3LBROyJTRFMOyA87Be43VOmTUemy
X-Received: by 2002:a05:6512:3092:b0:516:b8ff:91fd with SMTP id
 z18-20020a056512309200b00516b8ff91fdmr2729124lfd.15.1712138778046; 
 Wed, 03 Apr 2024 03:06:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeHsh/HMQc4nzlCJfrFbt7Kfp4SrliWTRCdOmnGO82Z+uQc7+BMCApNkRYuCubuePTOGKZMw==
X-Received: by 2002:a05:6512:3092:b0:516:b8ff:91fd with SMTP id
 z18-20020a056512309200b00516b8ff91fdmr2729096lfd.15.1712138777502; 
 Wed, 03 Apr 2024 03:06:17 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 b13-20020a19644d000000b00516c077a312sm79690lfj.308.2024.04.03.03.06.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 03:06:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/6] lsi, vga fixes for 2024-04-02
Date: Wed,  3 Apr 2024 12:06:14 +0200
Message-ID: <20240403100614.74983-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 7fcf7575f3d201fc84ae168017ffdfd6c86257a6:

  Merge tag 'pull-target-arm-20240402' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-04-02 11:34:49 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 8fc4bdc537d901c200e43122e32bcb40dc8fed37:

  pc_q35: remove unnecessary m->alias assignment (2024-04-02 18:08:59 +0200)

----------------------------------------------------------------
* lsi53c895a: fix assertion failure with invalid Block Move
* vga: fix assertion failure with 4- and 16-color modes
* remove unnecessary assignment

----------------------------------------------------------------
v1->v2: dropped patch to reject invalid Block Move

Paolo Bonzini (6):
      vga: merge conditionals on shift control register
      vga: move computation of dirty memory region later
      vga: adjust dirty memory region if pel panning is active
      vga: do not treat horiz pel panning value of 8 as "enabled"
      lsi53c895a: avoid out of bounds access to s->msg[]
      pc_q35: remove unnecessary m->alias assignment

 hw/display/vga.c     | 146 +++++++++++++++++++++++++--------------------------
 hw/i386/pc_q35.c     |   1 -
 hw/scsi/lsi53c895a.c |  19 ++++---
 3 files changed, 85 insertions(+), 81 deletions(-)
-- 
2.44.0


