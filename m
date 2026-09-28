Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49784C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:12:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBACH-0002TZ-Nu; Mon, 28 Sep 2026 08:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W7-0005Le-98
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:12 -0400
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan260699@gmail.com>)
 id 1xB4W4-0004OV-6A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:07:10 -0400
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7bcb94d3so18966815e9.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 23:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790575625; x=1791180425;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qS8ezzWFVOvpfx9rGdzUHxPwUSgmD7kLfiptrKQ5c4k=;
 b=YkbBFtD1UJE4/gOnfv8HcF4twYNxsBwPaUxo31RYj0pG8WAETYm6RIMgeEb+oHf7mS
 QzYsQALfZXaZ400r4QNez0wDDoIzXFssDvJv5oxInc5yQftU1Kf+pTm7yhzbGx8ROIwX
 Lf8JEwFmQlhis5iwi5A8pSk1JE3EPNaNc1nS8K/syfopGwk0FmVDu9NwK6l6QcNKwXWz
 y5oDV6A+p2r0EebQiFKTx/4c2vGOokNqmABgT8DNmGKAvRdaGqxHdfLEgHIOLYSzsCbi
 iytfnNiyAvrWq5uK7hLJKPaGLHzIOZtB9uPq0t14EeSXsNK+l5QoGflZQTSF1V6qr1Gk
 0ysw==
X-Gm-Message-State: AFuF++nMYU9SuteZ5hBNIfCHkStome2r8dEPTqaUq8S/33p9QSzvrYjS
 5kNsgqxgl+368sagoMttopX5Ez8fcKEvQF+iIbbtCDjQTCMiX/9M1xM8
X-Gm-Gg: AYBFou2boLDsw+Idp+3hrJQ1N1iDX+RoMHBoAjsCB53DCVujuSXZBzupWXSjanFIQN8
 i15k1AtmA4RUsD1eym1RTGS9UIBvPm5nSJq5K53DmCcvsVNADcGEz0vDxSii5mcosHh5DxCf7Gy
 QBGHhginJEHNTc+N1PnpR6RSxRfBjOSNLJWfiOoGQxTj8Fwz5tO4Qar6cXa0Qxaptqwp55db9mA
 vNosNzchKfLTupFdXe8uylWckLuaQdYE9eP5pfi7xSGsw557uCtsICU40OZrB++JVD2ce7dDsba
 e0ZrCeOOci9Dqtd87DOsglzLcDB0DQT+iB2FGDZa2z7zvmOgP+DVu19i8b4GMjosa12wAoYrjzZ
 3TrRFe8oA0hGbD/DORaVd8ux7n1cegP0hmqT0dQu0oBjSzrB/idaioAyzMMxnFdsuVCrsylmAyz
 gy5XloRgGLykeRRoWm5c+viFOa7rLkvpgNiN3sHGKcCLWP3w502oOTFNcz3bsGf26EEz4uNtmgY
 esiYFP3+O7nGhAdWA==
X-Received: by 2002:a05:600c:4e53:b0:49f:d58f:1f8b with SMTP id
 5b1f17b1804b1-49fe66d807bmr200474825e9.18.1790575624542; 
 Sun, 27 Sep 2026 23:07:04 -0700 (PDT)
Received: from mac.fritz.box ([2a05:fa40:300:1a00:d105:6a41:99ee:cbff])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a008f7f1c2sm1325775e9.1.2026.09.27.23.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 23:07:04 -0700 (PDT)
Subject: [PATCH 0/4] Support KVM on real RISC-V HW
Date: Mon, 28 Sep 2026 08:06:35 +0200
Message-Id: <20260928-spacemit-k3-v1-0-8c57d0596b87@butz.st>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ5AMBBA4avIrDVhGoKriAU1GOInnRKJuLti+
 S3eu0DIMgkUwQWWDhZeF484DMAM9dKT4tYbMMI0yjFTstWGZnZq0krHGrHNkyxBBF9sljo+v1t
 Z/Za9Gcm4dwH3/QAvOd4ObwAAAA==
X-Change-ID: 20260928-spacemit-k3-31322d958522
To: qemu-devel@nongnu.org
Cc: Sunil V L <sunilvl@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org, 
 Stefan Butz <mail@butz.st>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openssh-sha256; t=1790575623; l=1250;
 i=mail@butz.st; h=from:subject:message-id;
 bh=moyUaNoT4PA8AUiDYhio+FEJb2hIfugcIHLlwA93DIo=;
 b=U1NIU0lHAAAAAQAAAZcAAAAHc3NoLXJzYQAAAAMBAAEAAAGBAOJW8yHG2FdKcC8jiWoQyd2Z6
 SNHh+aJB0RLkH7BFF7Yy7MymfE5UJE2mmoucIa3HiNQdlVZjgqLY7wph/VSM4kniDO57IG9Q9jN
 x96oOAzzWWJEVrh8vlxRGXatNy8ywcO9WExvzLop5s2ddP08f0Wrzn/55mpqoLJyoKaIbk10kxz
 JW1GONHT8nsNvBpVB2lnzA2jhv7DC79UlHzA98+sp8eX6kmUips+9LpTJLDeVna8f/vwkU708PI
 Qxt/5nhmFXKj/su/CMFivCLHckdmMOem/4UNoTyRcAbcoFQ9WWyYHvAD/bRuYZVEA2hfoBEQVu2
 FGHdG/OimvbT/GseVmWjiw7WV9HUOJJawVmfoTEJynX9BbV+VNMKZVpW5YaAaps6/KOC7V2bM7P
 hvORUmj3b8eUr418GYC3M4rLJtrj6Vu2cUyTV9Q5dvq9Lg2TIj/jpbEWpOqn2FSGkQcLvcDksNk
 jOSGmdG4h+OJ3vbGrva5UCJF/KIyuV4ozlSU7awAAAAZwYXRhdHQAAAAAAAAABnNoYTUxMgAAAZ
 QAAAAMcnNhLXNoYTItNTEyAAABgJrI3Iu3wbR68WbEbuVAwZ6unthAkEYtErzzv1o6sN+NjCrdm
 r4H6v/Is+ZL7r1a1vqkpUvC3pLVl7npKYb+HAdN3i2KEGelxTsnTzwnPCv7UHUnVXx+rx54hmLd
 aEGhLCyeJTvaKjsYbxhmXVcXWC0cPaD8kUHaJuixWrQW1t0/4vHJaCT8RyXes+nPgHny20A844y
 Id4bbTJjSV9t9KwQwZeIJzKfXOh/4Aae9jmLdk8du0qj8RZV2nz4I8S4TnJDUqPt3hpJpeNiFDF
 GjuurziK589mvN4A1zq7gxNXBIDwoo6m3NNkE6VZvGKRwxeEwb0dXHVCm96KijtynMKKvgCA2V2
 rxvfe+GvEQQNDqhDRb6mQM2O3gUnmv4628gshrGDS+OtNNKZ/155cC8At0v54IVkYo+/9vyHVZU
 1gceTWi/WTXM/WNJ+hqHhORtFUGl9uG746QYvyHm8rYnjPKUOlpXOx2xiyhz+br8dy+DG9umXTC
 AlYs56CxEZeBVXw==
X-Developer-Key: i=mail@butz.st; a=openssh;
 fpr=SHA256:jcZFBs39daoQJIontO/rJaVachWp/oqTbhNpQk8+REQ
Received-SPF: pass client-ip=74.125.225.141;
 envelope-from=stefan260699@gmail.com; helo=mail-wm2-f13.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Sep 2026 08:10:56 -0400
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
Reply-to:  Stefan Butz <mail@butz.st>
From:  Stefan Butz via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Spacemit K3 and Tenstorrent Atlantis support only 64 guest interrupt
identities. QEMU virt machine always requests 255.
This patchset queries the hw limits from the KVM AIA device to avoid
requesting more interrupt identities than supported.
Without this patchet QEMU KVM crashes on those platforms.

Bug Ticket: https://gitlab.com/qemu-project/qemu/-/work_items/4599

Signed-off-by: Stefan Butz <mail@butz.st>
---
Stefan Butz (4):
      hw/riscv/virt: Provide number of interrupt identities
      hw/riscv/virt: Move platform bus interrupts below 64
      target/riscv/kvm: Create KVM AIA device before configuring it
      hw/riscv/virt: Limit interrupt identities to what KVM AIA supports

 hw/riscv/virt-acpi-build.c   |  4 ++--
 hw/riscv/virt.c              | 29 ++++++++++++++++++++++-------
 include/hw/riscv/virt.h      |  5 +++--
 target/riscv/kvm/kvm-cpu.c   | 43 ++++++++++++++++++++++++++++++++-----------
 target/riscv/kvm/kvm-stub.c  | 18 ++++++++++++++----
 target/riscv/kvm/kvm_riscv.h | 10 ++++++----
 6 files changed, 79 insertions(+), 30 deletions(-)
---
base-commit: efa3b9d5ac8024078225e1ab434411fdfe53b457
change-id: 20260928-spacemit-k3-31322d958522

Best regards,
--  
Stefan Butz <mail@butz.st>


