Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5314BC7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 20:57:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWi2G-0007o3-Gb; Tue, 01 Jul 2025 16:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3l0tkaAkKCgokxuoo2vo1qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--ankeesler.bounces.google.com>)
 id 1uWi2D-0007nt-Sa
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 16:56:57 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3l0tkaAkKCgokxuoo2vo1qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--ankeesler.bounces.google.com>)
 id 1uWi2C-0006X8-Ga
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 16:56:57 -0400
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-4a6fb9bbbc9so208553331cf.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 13:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751403415; x=1752008215; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aVbrycOKtbSykzzWJZTPgqIimzepCiFkIJ34owzqQQY=;
 b=EUxDIlU7VJyc2PkmfkIP8I2fqCcC1PQWEXk2Rcv8xKd9kMyYnYpxjldCJRJ+VcH2bq
 kBdV6W8Do7SXpnvIfPMmC5SF0AFmXfGP7hGcMCLLHBU5GIB/p48m2cA75Dn9SYVYnm2D
 geafXYIExlD/1VEqeBc90rBFwRK0mDOoqKjXvvFn7ZBrviUt/z6UzycJ1QUWWsm4fJuy
 KvorPk0utpV8n6NMsYRpfvybHb5XmZaDiMw8IV1S4lr9CxkQ9Uf8HrURIt4kxGJz791f
 RNYBm/ZK/Q28MGxlEYYQSY9LC6O5ibfVNnB1p9CmpznjbK+omNLn6XJMV9zL7r0cn8nP
 lYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751403415; x=1752008215;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVbrycOKtbSykzzWJZTPgqIimzepCiFkIJ34owzqQQY=;
 b=hIEjeauGoYbOcBGGGDbRsxSUuc5DFkp/eyC14Lsgtdr7bM8jCX8+Vw1olmR0wQvcPm
 Tg5EBYxQUqb4xP7kXIBRJOToI/4p2jFE3Kui6pwUqBPwl0EgCum3hyfgU1GRaZx5pLf8
 ZvyL9QDN/3c/snf7qNkVrFM2Hqv1kSmI5X79yjW7jf3B9yjGubZzo+Sq1RGQzksMv/DR
 2airN+diDo8IX1RqEc5DAR+QzxeVWaaDnM9/+/Z+bHbUUnPwFcwYQDQbL/phbsjwLT6E
 IX/5pbL9+5Z9Z7LtqK4THnLZOzzoQ29jGa7e0sfF1G0X7jTNCFQywAp/57/9+71+QGHk
 l9IA==
X-Gm-Message-State: AOJu0Yygy1an8PQ3GBnOf634MHEBE2wyRHlYiY/HcxF5WlzlHOcyloB9
 P2J1KWg6Kwhd3jGrvTTtlU+Hhv+vBzdlQgZhuJrGElOdKh8qF2p39GwyhibxPre4I8IorN+LF78
 7YMeCFr1XTUp9cc9z
X-Google-Smtp-Source: AGHT+IHSGE36qnQ3fls4CIDW9l9/kNGSYzikXFV7KoViwsqRwCshyuBnKiSQT+G/08smJ81T9Bcx3HMEbgfXd04=
X-Received: from qtbcm21.prod.google.com
 ([2002:a05:622a:2515:b0:4a7:f6db:b0bf])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c43:0:b0:478:f4bd:8b8e with SMTP id
 d75a77b69052e-4a9769de2d5mr8452861cf.39.1751403415010; 
 Tue, 01 Jul 2025 13:56:55 -0700 (PDT)
Date: Tue,  1 Jul 2025 20:56:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250701205652.3536098-1-ankeesler@google.com>
Subject: [PATCH v4 0/1] Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3l0tkaAkKCgokxuoo2vo1qyyqvo.myw0ow4-no5ovxyxqx4.y1q@flex--ankeesler.bounces.google.com;
 helo=mail-qt1-x84a.google.com
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

Changelog:
* v4 - fixed copy-paste issue in virtio_gpu_base_generate_edid()
* v3 - report an error at realize time if request name is too long
* v2 - migrated configuration surface to virtio-gpu device

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


