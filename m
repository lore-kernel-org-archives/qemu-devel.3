Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B10C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:19:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGHE-000565-U0; Mon, 30 Jun 2025 11:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wqpiaAkKCusNaXRRfYReTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--ankeesler.bounces.google.com>)
 id 1uWGHD-00055p-5G
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:18:35 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wqpiaAkKCusNaXRRfYReTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--ankeesler.bounces.google.com>)
 id 1uWGHA-00074c-5S
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:18:33 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id
 6a1803df08f44-6fb2910dd04so83154486d6.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751296707; x=1751901507; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nqu9bi+YSugCVUW3IGj0xL0NJ/2WtJNV3h3xBg+HnX4=;
 b=dZMwgtxRthi/qAdtlkjJcX5wW0iYaDkp+bjAgIweGyMTvPPgDZPZo8UsjFzaa8zHh2
 GKvUcqYRg5Xp28v1prD+jjACU+R8iP0sp8wAwdYU+LYwmnX5oMNDU3QNn829EMMl5MTb
 otgPqjl5iSTKF/j8m7i5jB6fn19VVNsh+9h1qO9b3wBg3mblGFVhhjfugypQtQSG1WV1
 Ml9OgNwfDgsQRHBRWo55cZhTsEUHxZ520o7GriEV4aJzVMfv6JDURC5kPOyXNGNDF8YB
 euYi7ntRpXBJS+9uNlhv/vvwMwCdcOmHs2Ap1+156ClYrnFeNGalVORov1XDZEPWjuoU
 O5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751296707; x=1751901507;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nqu9bi+YSugCVUW3IGj0xL0NJ/2WtJNV3h3xBg+HnX4=;
 b=dQyQ3UdO2+dFdJi4tH04rUa6yEa72En60GoVJjVSZ7nTU1aFXOm8RuWMyh5kNNnpns
 6dZiI4q6Wf8e/9uU/UB5rCd9M5xQD7oRU/RK5RRAocAhiQnIXO3xyRhkR0C3ZMVsSBeZ
 VcUuNH2vcG/fKY1brs+AMcdrQ+1HWAgvdrxJ2C4InF19DNx+vt8z6kIYwUF92mJsp3/T
 uLgOb87lc5hZaWFNdZbylJSqWbXdXFt1NLxDMdTkmS7Ghl7UCL+SjCZr/Hgan/7LqjZk
 LOlJ2eKeiZ4g21RXtxJ+9cXXAK+azy7pE/d3G2Y5TlcdgI6sn59PyT05SnpJNgE07AC3
 ujWg==
X-Gm-Message-State: AOJu0YytMXISm+ru5pxumCxSJjLckDImuH1Km7zNIH8m9wvCHeCUOJ5r
 iyO8XadwvwCNf2M37lhaZXJHUczJJ9JrGWXkXjSH5zj/IjijZnQba4eRAqkdymBdW01AxwL4n5n
 wV5qWpyWn9HoY4Skq
X-Google-Smtp-Source: AGHT+IFMhKwGxuf7Bg8yGsRn6NRiFYy0dPGHZfR2yzKAsELknAyN0pDPX7246GkS/EhxEJRwgUnZaHcZwJ9BsZo=
X-Received: from qvbri22.prod.google.com
 ([2002:a05:6214:3316:b0:6fa:baaf:148b])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:260b:b0:6f5:4214:774a with SMTP id
 6a1803df08f44-70003c91593mr180291476d6.41.1751296706719; 
 Mon, 30 Jun 2025 08:18:26 -0700 (PDT)
Date: Mon, 30 Jun 2025 15:17:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630151757.2553891-1-ankeesler@google.com>
Subject: [PATCH v2 0/1] Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3wqpiaAkKCusNaXRRfYReTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--ankeesler.bounces.google.com;
 helo=mail-qv1-xf4a.google.com
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
Identification Data) is propagated by QEMU such that a virtual display
presents legitimate metadata (e.g., name, serial number, preferred
resolutions, etc.) to its connected guest.

This change adds the ability to specify the EDID name for a particular
virtio-vga display. Previously, every virtual display would have the same
name: "QEMU Monitor". Now, we can inject names of displays in order to test
guest behavior that is specific to display names. We provide the ability to
inject the display name from the frontend since this is guest visible
data. Furthermore, this makes it clear where N potential display outputs
would get their name from (which will be added in a future change).

Note that we have elected to use a struct here for output data for
extensibility - we intend to add per-output fields like resolution in a
future change.

It should be noted that EDID names longer than 12 bytes will be truncated
per spec (I think?).

Testing: verified that when I specified 2 outputs for a virtio-gpu with
edid_name set, the names matched those that I configured with my vnc
display.

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
              },
              {
                 "name":"BBB",
              },
            ]}'

Andrew Keesler (1):
  hw/display: Allow injection of virtio-gpu EDID name

 hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c        | 20 +++++++++++++
 include/hw/qdev-properties-system.h |  5 ++++
 include/hw/virtio/virtio-gpu.h      |  3 ++
 qapi/virtio.json                    | 18 ++++++++++--
 5 files changed, 88 insertions(+), 2 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


