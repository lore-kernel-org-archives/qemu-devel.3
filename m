Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C606C48292
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 16:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX2FO-0003p3-Gh; Mon, 05 Feb 2024 11:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FM-0003oP-5d
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:04 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rX2FI-0000Vb-3k
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 11:55:02 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5114b2b3b73so1716749e87.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 08:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707152098; x=1707756898;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ObC4GQhzvkCDDT9YI/kGoXO5UObtpyBnHo12Ka1aGv8=;
 b=fTbxw5N4FR7r/ON3lo5NoHweJKDo3OwEg/7zfWds3h1IJmzy6PsbOWr73S7mDmSStM
 ZpYH66DVnG0sb2ssTU3BL3Brinf8V+iH67zxzkNNapnfaJ3z7WQl/x/LF6gl2/nK3o0h
 eJ6/xzrzfiXJarojTFpzRS1dge/PN6dfrGb83FYhXcGyM3EjQ+GDZgcS+P4C+W4xfYrD
 SSKzbnx8lODrkgGmNl/2TCitboJ3mYrZ6p5ci0U37G/tqAfxpucfgMCmvOwXN7aCv1e5
 gDRX8E5yho368D/7XR38v4FS8e+gYV27cJIaBtn/YDftTI0+A2BFefKd27cnUZBaLIHB
 X4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707152098; x=1707756898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ObC4GQhzvkCDDT9YI/kGoXO5UObtpyBnHo12Ka1aGv8=;
 b=k9nm/v95mML9SFRbmpvY9fy++7vk40vxVU/JQAP3ZN+dJ2BGXzONuouomzzuZlLKnY
 55oYrpFbrnd+JV9emT0yno8TpYjbITKgHM1xOhqrX/P9lg4gwMYY3jlwg9VpqjxBvCCt
 LkdQTzL7nWyWKdz9EGUzfJo0gxeSKSn4ErYm5x3FMWE2xmAmHq2aZ7TOSzE6Xxc8K8h2
 EqJ1QIIA7QFFSZsmq58nZHOMf79fWkDJEAwCqiRlse/szVv37wqnzSCuXAYMFEhXDEMM
 bPh5id3Qb2dRbmhaLKmdSFotE1jkQCL6CmGJDQ7f8yULRW3JXhOjxzHHzoewWnIaqNyF
 /aPQ==
X-Gm-Message-State: AOJu0Yyd9RvLh68CqY8ccGwU+gtuw9LcQrIlDkVs9YW5BfOE5MiszbcR
 M8tBG++h7d0yYdSH0aTISWhKzMhkQexCIhajiDxZFdqdoVGT4WaZGhvTFUoRXXyux4U/GTl+Dpa
 k
X-Google-Smtp-Source: AGHT+IEue6+iNSGIPd6sVpbfihbeLRwoX4Rn20lF4uIyJDKtR3Cjklzh9blxhFFJRk8Db67BlQQ0Og==
X-Received: by 2002:a19:ad45:0:b0:511:5353:2ace with SMTP id
 s5-20020a19ad45000000b0051153532acemr147429lfd.22.1707152098171; 
 Mon, 05 Feb 2024 08:54:58 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUtIxZtyrLu7GK7WjakJn1ZVGsdwKQ7bwLgDldjwIi1+2ZtDrf5p4IGhtbLGJVkxCIY+jHMh48m1PPkd68TTDB77oZB0FZcxWbRN3UuV9I4vgYFbAaB7qD7uk0IHOxnjzbyvOVcQdhMdaKjLq5YPp9R5XOjcyzKZB4Psk9RaiHajocZA1Pr2VjohBwq5noyd46V79u7lYgl0q3PMf6hFJggtOvgvtV89scZF1D5E+cT6jJ1hAXBfME/1V0=
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a170906074e00b00a370a76d3a0sm20580ejb.123.2024.02.05.08.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Feb 2024 08:54:57 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v9 0/5] eBPF RSS through QMP support.
Date: Mon,  5 Feb 2024 18:54:30 +0200
Message-ID: <20240205165437.1965981-1-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::130;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x130.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series of patches provides the ability to retrieve eBPF program
through qmp, so management application may load bpf blob with proper capabilities.
Now, virtio-net devices can accept eBPF programs and maps through properties
as external file descriptors. Access to the eBPF map is direct through mmap()
call, so it should not require additional capabilities to bpf* calls.
eBPF file descriptors can be passed to QEMU from parent process or by unix
socket with sendfd() qmp command.

Changes since v8:
 * rebased and refactored QMP interface
 * license SPDX id only for new files

Changes since v7:
 * rebased and refactored
 * used SPDX license identifier
 * used DEFINE_PROP_ARRAY() for virtio-net "ebpf-rss-fds" property

Changes since v6:
 * added comments to ebpf.json
 * added libbpf version requirements to meson script with BPF_F_MMAPABLE check

Changes since v5:
 * refactored ebpf.json

Changes since v4:
 * refactored commit hunks
 * added explicit BPF_F_MMAPABLE declaration

Changes since v3:
 * fixed issue with the build if bpf disabled
 * rebased to the last master
 * refactored according to review

Changes since v2:
 * moved/refactored QMP command
 * refactored virtio-net

Changes since v1:
 * refactored virtio-net
 * moved hunks for ebpf mmap()
 * added qmp enum for eBPF id.

Andrew Melnychenko (5):
  ebpf: Added eBPF map update through mmap.
  ebpf: Added eBPF initialization by fds.
  virtio-net: Added property to load eBPF RSS with fds.
  qmp: Added new command to retrieve eBPF blob.
  ebpf: Updated eBPF program and skeleton.

 ebpf/ebpf.c                    |   69 ++
 ebpf/ebpf.h                    |   29 +
 ebpf/ebpf_rss-stub.c           |    6 +
 ebpf/ebpf_rss.c                |  150 +++-
 ebpf/ebpf_rss.h                |   10 +
 ebpf/meson.build               |    2 +-
 ebpf/rss.bpf.skeleton.h        | 1343 ++++++++++++++++----------------
 hw/net/virtio-net.c            |   54 +-
 include/hw/virtio/virtio-net.h |    2 +
 meson.build                    |   10 +-
 qapi/ebpf.json                 |   66 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    7 +-
 14 files changed, 1047 insertions(+), 703 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.43.0


