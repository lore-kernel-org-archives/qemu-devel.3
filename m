Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 332DBC5518F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:31:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqo4W-0007y4-Vx; Mon, 03 Aug 2026 04:30:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4U-0007wc-Ut
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqo4T-0005sb-4n
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:30:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso21254145e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785745851; x=1786350651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CID5Hpm0v73NwXBM9LbFqUvU3gkL1k8VrFg/apDGjLs=;
 b=OP3AYjx2IskEJcGEYGflOR2Ys9m4YmTDKC3qKDyX9d8S1Th9WQqIZSupcO/F7h/q2L
 pZFMdnBdZqvOz59YY8qXF6nq6ktue9mhHYHM3aH/WozkBBbQhXLCphkNy5u4CteRmedQ
 gRsLU8KW46NOvzzttT1VZcPjx2M4u8JNVm97o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785745851; x=1786350651;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CID5Hpm0v73NwXBM9LbFqUvU3gkL1k8VrFg/apDGjLs=;
 b=rRx4+CN3gNTmgWXKKDGBw3YyKJKaYM8JEu035Ynblrv80YOvqyqApgG9rXncF6Aa/E
 rLzNnZBXOoDJLrpmEyTCtlbDAQZHjm2MnV/fR+gZyODpLZfHXQYn6YueiAOKnEvQHtbr
 NPs+1EWzkbjcGJf/YSaVxIobTWTze4MilNK4TWfZ5WEXErxLl6vRYHIdHNCleV/esp0X
 s0EiL1rXShpeSUkyD7klCQK3gBWrhdfbRvtbDAULmiTsDJkpqf6vNh5iaFgwiRztzSm5
 807PxG7fyadUnW/fX2Q+mAiHMBhDfj0NUe6xiWXGLO7+RHZpf29HEPZd7wbMyNDgUoGF
 RtKA==
X-Gm-Message-State: AOJu0Yy8DXZgkEN4UIagvfUy0a8PTtVfKhm1gdDmcFcDbwLDE2zKYguq
 oR/9sjYwdW10j/+gAKOQtzrSqgcTtexY640zogf7CyICDFJnmHi7HeYiL4Q4hz53AUujeQvbvOm
 X95wM
X-Gm-Gg: AR+sD12Jt7Z2zVIem9xF816gEYPeqUAyBFl9sJfvMxYLILA6PX3CO4gEyNueRKsI9Zk
 aiwQ4hpLyMkm1+J9DnnHrxhxlJoYH+YXF3jM5NqQQdk5PehgGYMUU4Vck5bNdQSmPDI6MTpvQBU
 jRn/zXntk+5RkLShatvZ5mo2OnBNAqtQ9hSWv4rxhNdYEGNJTStwgaFpzodMu8Gc3rxAstvQc58
 +BtU66KqQDRllvvIJEV4L6dLF7xzlHILbeh2gOsB1mBZVy2F2aMhZRIBVLWN9D6oERsmFMnc0r9
 btsxcZDYjeCN1SLCp/W+cgP6zCBFHOPoYiRx2mG8fl7TzDzUnihwx2ULcpbO923vybLM5G0Ilo0
 5j3gtUwsGcqbXUyDKuF99+H2efLaxnQmJzV/mlNEnuGv7SePQITh1MshtSYfSTi9PSMXz44Fshj
 SrmR8aYAZzOfG/oy0abrwkJvpCgwwMi4MffjWlMGVfbYSiy3OkVeMUU50+osRQ3ubTapycdWiem
 dO7dY+SvrINL2YiIcgWzLhqLVGZqLeKDZLZSWNpB/7R/CS47UgL82DydLcx
X-Received: by 2002:a05:600c:3509:b0:493:cefc:d113 with SMTP id
 5b1f17b1804b1-4980c66c7e4mr201511795e9.5.1785745848446; 
 Mon, 03 Aug 2026 01:30:48 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807bb45ebsm152286045e9.4.2026.08.03.01.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:30:47 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org, Jesper Devantier <foss@defmacro.it>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 0/2] hw/nvme: support online resize
Date: Mon,  3 Aug 2026 10:30:44 +0200
Message-ID: <20260803083046.110121-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset is aimed to support online resize for NVMe emulated
device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
callback and ensure that AER notification is fired to all controllers using
a namespace that is being resized.

Testing.

I manually validated this with Debian 13 VM (a resized disk was a root disk) and
Windows Server 2022 (a resized disk was a secondary one).

Git tree:
https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize

Changelog for version 3:
- rebased

Changelog for version 2:
- checkpatch fixes
- rebased
- CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)

Kind regards,
Alex

Alexander Mikhalitsyn (2):
  hw/nvme: initialize ns->subsys for n->namespace
  hw/nvme: support online resize

 hw/nvme/ctrl.c | 10 ++++++++
 hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.47.3


