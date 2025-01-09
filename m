Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17810C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 07:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnJ4-0002WP-9U; Thu, 09 Jan 2025 02:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnJ1-0002Us-GO
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1tVnIx-0003BT-Ky
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 02:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736409008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=UOOF0M8Pi68VrIyicW3CqgVUhMgJxuvja9rZ1ASp88A=;
 b=CjUJD6PG2aFQe8mwDIc+ONmGAZXU9Nc1bm4LJCnlOW7IB/SnZm6vwbx1iwSs1ciuujvjhH
 7rTO7Jzz7Pp7EYsPEKE/4ICWfcMdvkdD6qVpygW6YV7ytuteVuNJmVcKdwkHXH0MUa3FQF
 BuPMReSB6pKlBrUiz54Cj2cIlArs5cQ=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-77g2YlISPBm5B_CjIx7xUA-1; Thu, 09 Jan 2025 02:50:06 -0500
X-MC-Unique: 77g2YlISPBm5B_CjIx7xUA-1
X-Mimecast-MFC-AGG-ID: 77g2YlISPBm5B_CjIx7xUA
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ef114d8346so1196149a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 23:50:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736409005; x=1737013805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UOOF0M8Pi68VrIyicW3CqgVUhMgJxuvja9rZ1ASp88A=;
 b=qezvxYaJ13oOtkLHdlnHed7/8ajrvVgzd8Rg/Bj5u1F9swZq41MUFvNEIbMEZyyR5g
 xKsxklVNEHM2Y3p7FSMgqUX1B1ldnbetKOgL7AtywpX5GDwnt9MdkuSPMoejRNwN1FDu
 Yu/ACUlwxs5e2e+avDqJINDacau/3DUiY1DFQJZG+wVyepVSLruU7lknDLMn1qZlZiGg
 UqYQX0PF+cJ/RAyxVNwbKZSgeLK6gKE896pTW2u69JzejwLhagY8b4GsT9Yrk0o8RSs/
 hE7NSkhSQ7+zW0WjWHCCL1mgK+UwNImgGeNv64M7TUB9krY134VdI/9woJLbZyKMCvUX
 EUIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpKgxI4C2jLRuJkrS7CrWJmcpIFUPcgjLtxZK8HgxLQYmooxUXvPTCQxJQMi3/5tpuUdv9OCv6ywN4@nongnu.org
X-Gm-Message-State: AOJu0Ywen+6R9nqEqSCK1oafiXPneLiWgbyxTYMETR4McwTXU1Y62kD+
 /Ajoc0qaGOdEZE6sxZzIRuT5NmWsTXzrkUhxvVg5eQwEVqRARQx3uMAwx9bgXTfiGIKgusa8aqF
 ZQe6GWRwxeAI4x00YTVIZgBFAbN7S9URiZFZzYwDje2uMTGFmFtkx
X-Gm-Gg: ASbGncvBo5GUh8blM3dOwQKdI99knzsTcKmsMnhZmIj1TsOv5Ii+Uj1972AaUdH7gvh
 rF8PF7zcfOt0yJJRfDDfdvA93yfwWSyX0qpwnovrdvU+MIHRk+ecHWlBD7RHP87rWZwapli2zQu
 1cTIZ4Iok6JkQSRT3Y0+C77jlM3LgmxQZQ+Fipfx7vsriejS5YbnP6I/B1VvIwEYI5sNwIxzy7h
 FGWO5DkLFayQ5IPfIw67cXGxljy+HykxwJP3pt7javvVD+nailXyTweEyGGiioK19/gjHkZT5Zm
 430f
X-Received: by 2002:a05:6a00:1255:b0:71e:6c3f:2fb6 with SMTP id
 d2e1a72fcca58-72d21f4b05emr9529734b3a.8.1736409005561; 
 Wed, 08 Jan 2025 23:50:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHJE3X8Tobh+LZYoEC0vkEMgq44GL2x/H375IaCfNSkZlFiIIL44kjbF3QhTFAhVSxIAtJLg==
X-Received: by 2002:a05:6a00:1255:b0:71e:6c3f:2fb6 with SMTP id
 d2e1a72fcca58-72d21f4b05emr9529706b3a.8.1736409005217; 
 Wed, 08 Jan 2025 23:50:05 -0800 (PST)
Received: from localhost.localdomain ([115.96.158.174])
 by smtp.googlemail.com with ESMTPSA id
 d2e1a72fcca58-72aad8344desm36432128b3a.54.2025.01.08.23.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 23:50:04 -0800 (PST)
From: Ani Sinha <anisinha@redhat.com>
To: 
Cc: berrange@redhat.com, armbru@redhat.com, Ani Sinha <anisinha@redhat.com>,
 kraxel@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, philmd@linaro.org, qemu-devel@nongnu.org
Subject: [PATCH v4 0/2] tests/qtest/libqos: add DMA support for writing and
 reading fw_cfg files
Date: Thu,  9 Jan 2025 13:19:27 +0530
Message-ID: <20250109074929.252339-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset enables DMA interface support for writing fw-cfg files in
libqtest. The first patch is just a code refactoring so that fw-cfg
directory parsing can be part of a separate helper function.
The second patch is the actual patch that introduces two new apis for
writing and reading fw-cfg files using DMA interface. The apis are
tested by writing a qtest for vmfwupdate. Please see
tests/qtest/vmfwupdate-test.c changes in
https://gitlab.com/anisinha/qemu/-/commit/4d94a67d1cf29780f136a8bd2c21ff0e57c7b2db
To test the code, you can pull in this branch
https://gitlab.com/anisinha/qemu/-/commits/fuki-hyperface which has
vmfwupdate changes on top of the patches sent in this series.

cc: kraxel@redhat.com
cc: farosas@suse.de
cc: lvivier@redhat.com
cc: pbonzini@redhat.com
cc: armbru@redhat.com
cc: philmd@linaro.org
cc: berrange@redhat.com
cc: qemu-devel@nongnu.org

Ani Sinha (2):
  libqos/fw_cfg: refactor file directory iteraton to make it more
    reusable
  tests/qtest/libqos: add DMA support for writing and reading fw_cfg
    files

 tests/qtest/libqos/fw_cfg.c | 201 ++++++++++++++++++++++++++++++++----
 tests/qtest/libqos/fw_cfg.h |   6 +-
 2 files changed, 184 insertions(+), 23 deletions(-)

-- 
2.45.2


