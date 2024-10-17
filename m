Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD51D3C533
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 21:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1YQq-0003VV-H1; Thu, 17 Oct 2024 17:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3RYcRZwYKCtgLIKO8BAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--roqueh.bounces.google.com>)
 id 1t1YQm-0003VB-5X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:16 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3RYcRZwYKCtgLIKO8BAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--roqueh.bounces.google.com>)
 id 1t1YQk-0006nX-EK
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 17:53:15 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e2971589916so2822091276.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 14:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1729201990; x=1729806790; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uLbCCcl8YaKlQ/t5PlJD7D1ldd6NVtm8Ut/+QIRNnP0=;
 b=WQ8TmmkDBxQ7g3wCmnq0SVFudwsvTPLEWWvK73a7Ep7buejk8b7++PdcfkO7lWWr7Q
 3wkqAK8g/8dwGIAhEMAZCpMX2EDPJAXuEjctPrfjBlJ0XtSNlOehLAmFIA+jm/RsXg8F
 l0sffOkKcsthvGBMCfjpfinaTtSvCnAPsrv1JkkPidCgbbO8PFkHss24PF7qO6N2Ib8H
 kLUxiaD5ZIK1TMEiMvduQn/18BwHcPU85ebcKoaZYhSwPModlfcmlqhy/vv/Ws7thq1c
 k9vzx/bnLY3JgnVSoMuax4YCoG4kjJWAJoWzVTUx4d5lfpxgwhUHawIk/VHmVKFZmyKK
 Lfog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729201990; x=1729806790;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uLbCCcl8YaKlQ/t5PlJD7D1ldd6NVtm8Ut/+QIRNnP0=;
 b=eNVvMtSHOUiHYsiOE+aGqoEs3noYbS0+ooB8DVQ3MRnape6P8SIF+FH7BCrGW0/4IG
 DRK2DaSod+WsmVU6YyDfYhnXvb5fvBR+eHW4bcAT4Um/SpMKNb96Nli4DRUGfgs55tX9
 31O03gXZgwyywjjEKOB8Hiu/7Yv5tAGZ8csYAWxtX24sa/+y9p7UxiIo49jq7qTzEVDc
 tt73jGTr3qOTGbsEys07fjv4CjLX3S4eglw254FkPqoblGufDfHr0ZPPkV7J5iDuuFa1
 Po21ltT0Uqv8sou8Y1FxdYPjip51G85L4czbNeI0zSjQKlhMXp4Y34QA7Zi66TED8o6D
 Dcpg==
X-Gm-Message-State: AOJu0YyEQ5bnPvcDXUKTGptmyKulfaDvLf7ffLU60NEHQp6Q1R7QyzT7
 mhfhrKwC9HcobFH3sJ7iQ89zCM+tn/UmhA2Iaz+FBMngpcvaBULK2CZFJfvdoHGllbgbrbhwu1s
 psQ==
X-Google-Smtp-Source: AGHT+IHO2ScHZIonU9YnuD0HrNDO0QqEyQVcffcHceg5Z/Ap395XPAmhU3wSEWtHx8veke0lUzopI82dC9A=
X-Received: from roqueh.c.googlers.com ([fda3:e722:ac3:cc00:4e:3bc9:ac1c:1ab])
 (user=roqueh job=sendgmr) by 2002:a25:7a07:0:b0:e20:25f5:a889 with
 SMTP id
 3f1490d57ef6-e2bb130ee4cmr195276.5.1729201989816; Thu, 17 Oct 2024 14:53:09
 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:53:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241017215304.3916866-1-roqueh@google.com>
Subject: [PATCH 0/2] Allow injection of virtio-gpu EDID name
From: Roque Arcudia Hernandez <roqueh@google.com>
To: ankeesler@google.com, mst@redhat.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, venture@google.com, 
 Roque Arcudia Hernandez <roqueh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3RYcRZwYKCtgLIKO8BAIIAF8.6IGK8GO-78P8FHIHAHO.ILA@flex--roqueh.bounces.google.com;
 helo=mail-yb1-xb49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Thanks to 72d277a7, 1ed2cb32, and others, EDID (Extended Display
Identification Data) is propagated by QEMU such that a virtual
display presents legitimate metadata (e.g., name, serial number,
preferred resolutions, etc.) to its connected guest.

This change adds the ability to specify the EDID name for a
particular virtio-vga display. Previously, every virtual display
would have the same name: "QEMU Monitor". Now, we can inject names of
displays in order to test guest behavior that is specific to display
names. We provide the ability to inject the display name from the
display configuration as that most closely resembles how real
displays work (hardware displays contain static EDID information that
is provided to every connected host).

This new behavior must be enabled by setting the edid_name boolean
property on the display device (it is disabled by default).

It should be noted that EDID names longer than 12 bytes will be
truncated per spec (I think?).

Testing: verified that when I specified 2 outputs for a virtio-gpu
with edid_name set, the names matched those that I configured with my
vnc display.

  -display vnc=localhost:0,id=aaa,display=vga,head=0,name=AAA \
  -display vnc=localhost:1,id=bbb,display=vga,head=1,name=BBB \
  -device virtio-vga,max_outputs=2,id=vga,edid_name=true

Andrew Keesler (2):
  ui: Allow injection of vnc display name
  hw/display: Allow injection of virtio-gpu EDID name

 hw/display/virtio-gpu-base.c   |  4 ++++
 include/hw/virtio/virtio-gpu.h |  5 +++++
 include/ui/console.h           |  2 ++
 ui/console-priv.h              |  1 +
 ui/console.c                   | 16 ++++++++++++++++
 ui/vnc.c                       |  8 +++++++-
 6 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.47.0.rc1.288.g06298d1525-goog


