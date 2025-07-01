Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 010FEC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:27:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWekP-000088-NW; Tue, 01 Jul 2025 13:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3MhpkaAkKCkEdqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com>)
 id 1uWekM-00007s-P7
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:26:18 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3MhpkaAkKCkEdqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com>)
 id 1uWekJ-0005Gt-Cg
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:26:17 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id
 6a1803df08f44-6fb3487d422so67594266d6.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751390771; x=1751995571; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iGPB7ZqBotRgaydy9bbpJQ2Cezu0G7oQpy4VydQr26U=;
 b=HUyCCRamYBqJS1QD5rfTJB2p4Bk0LVap8bCdEZarkr/p90Wj+D1FGeNQluMhVkQNqz
 4DSFC5cfZj0cnJCeguT+lgW5yJOS3lSKdkw/seIPQ4pSbZYZMTl14qExdZohm4s8v3qk
 nibVxwFnmEBXrzbx6utfZVvwHdkhxciOFk2BHVWMgT2jZ+GT+Bxnf6wNWdc1WE+0tJwi
 RRKGyO9Q5s7cBc1vSUghTSK3tP8BtyrmAHwmJU2C0L3V13dWKRaxLytAhPblZcpTiDbe
 W4QduBwhW9LXqHb4YX2sT+y/+NWOV32xVbGBHWOu8UekRq7WbxNrPgc9YQYaCJiyAFIX
 wkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751390771; x=1751995571;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iGPB7ZqBotRgaydy9bbpJQ2Cezu0G7oQpy4VydQr26U=;
 b=psnx8J24wSYEBC1q/uXs4ouUV4SGD5nVPOir2AkO1tRXpFbIGV/5iZuv3wgNfmWTSu
 ZTiKOUR+qgbbXnxChSi3kYoK8VYfGtwDNshvXphUuWs4oVEPe/wx2UdrgitbqM/jsIBr
 GHXtnDlRafwHW89ewSbie1B3NC9MeI4yeDFFWpPgW+NpXns15Xy9Po8jRcZ+BrXKS+au
 qt3IrOPZFU76pfM0fbchYJNO2315xU3x2HMEq96IRwVgdqZ33OFVQdv5sJbFgJ8C7hNb
 +mrlZ2NRFRdZbD//866C95Kwr3SWO8OpgXSABsZ5hgmdL3fYjfQD+fIG5iL3j3TVEEf9
 gACQ==
X-Gm-Message-State: AOJu0YxyBuvaHjEkpTdOiX6wR0XBXaoE/HjC9kmvlbVqjUGeUm5RiKma
 Aj/kJ2+cnnM4J9mPil8HrXEbMsNLAo9suOvaVVJmbzURlyifhqhtqlUnSkmanVAQurqNJXJkMIp
 U4K3m/wR4swL5yqmq
X-Google-Smtp-Source: AGHT+IFrKuarxGcLml68zLZUThGfj7BggdD0Y/BGxhJ2Z4asbre0Q71h243TUjwMw8owzF6y3z41AnmPcgG5xNc=
X-Received: from qvbqw10.prod.google.com
 ([2002:a05:6214:5c8a:b0:6fb:35c9:cebc])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:f6a:b0:6f5:106a:270e with SMTP id
 6a1803df08f44-70002ee6ec5mr261618886d6.44.1751390770677; 
 Tue, 01 Jul 2025 10:26:10 -0700 (PDT)
Date: Tue,  1 Jul 2025 17:25:55 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701172556.3349106-1-ankeesler@google.com>
Subject: [PATCH v3 0/1] Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3MhpkaAkKCkEdqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com;
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
 hw/display/virtio-gpu-base.c        | 26 +++++++++++++++++
 include/hw/display/edid.h           |  2 ++
 include/hw/qdev-properties-system.h |  5 ++++
 include/hw/virtio/virtio-gpu.h      |  3 ++
 qapi/virtio.json                    | 18 ++++++++++--
 6 files changed, 96 insertions(+), 2 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


