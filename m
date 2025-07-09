Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42A5C83F09
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 12:14:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZTgB-0006FW-AU; Wed, 09 Jul 2025 08:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3cVxuaAkKCi4KXUOOcVObQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--ankeesler.bounces.google.com>)
 id 1uZTeD-0005IV-Qc
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:11:40 -0400
Received: from mail-qt1-x84a.google.com ([2607:f8b0:4864:20::84a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3cVxuaAkKCi4KXUOOcVObQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--ankeesler.bounces.google.com>)
 id 1uZTe9-0001Kr-4Z
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 08:11:36 -0400
Received: by mail-qt1-x84a.google.com with SMTP id
 d75a77b69052e-4a43ae0dcf7so109128241cf.1
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752063089; x=1752667889; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=IiqLG4bcsbl7W6tN85r5R5G9BpsYHjAGl5Rh2wyyPBs=;
 b=Byx6qSkp+7qUxgAXLfMHQfDakV9BCF23W3pKGyOTAMgdaARkXUcSzDW8MGRoAX3lrZ
 Kyxjbdgh9gi3ELwGvcufuwgAYST7Kx1N6X8CvHFiCMGtOG/hxARoEdyf5yVEXUujKR5f
 Dp0HhDjWqAhErb1wtbwhAM6fKjLeiyw5VA0vW3T/ZZ1NFJtz7kniWuWDECgPunbAA341
 QwSfpLi844qc31ntwSjEl+T/TGDZFFdt4NkHq1cqQstFtUtn2kdmq0htaHbZ08o8EJ/S
 dNXRkAVGaBsdzfIgBFMCPPNIpJSxtDnOYl/e+3MemLIprFfd0vzNx4f//swJSuSBvX9H
 /55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752063089; x=1752667889;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IiqLG4bcsbl7W6tN85r5R5G9BpsYHjAGl5Rh2wyyPBs=;
 b=I2ilM4UAqpKZl0450NDYg7ybc8wdXfhmQKgaX1xwM2a2OEtIUAb7Viz8DbDxGd7lPJ
 UEZxIf42aXKeYjtUTTZKVGoJPT9pJlzaiu9tQHMURni/nl5NMMdDrkG+j3iMUuds8BKx
 RyxsTj3cO/GzIauCmDDs3cQLguEGLERiMdX40nvSeLE8Ub/AQnv/XxZTB5qfFESmVzEu
 i4IZpX2I4enSpV69dnqF9t0sPRJDAIJfkUddCWWxDgnSs0bMdkrx8inPh0Fiiwv9y4N+
 /XAwOIADFau3Xhum1XvZKdTN3+btHvFO9zgi2LP8Zhby1QyWbKAOggG04loIvgUy9xrO
 r+Hw==
X-Gm-Message-State: AOJu0YwyC3oA69tJSTBINf7nBvt/o1iCpQ9rn7ha61MeBZqFcaFNS5B/
 N19ZBOQXMegDGwdver/OFA8xxwR/elkEaWRrzHDmwxkTB/gQRZrPyhlScvtcTmhAlx7ryuWBphk
 hiQqTAh/LysWqwEm+
X-Google-Smtp-Source: AGHT+IEKFZv8J5lsrCdo7KXiHRAfjp5cMjm4nFcjxS0J8bjlXRsKsMuEXlkq7KJfdvbj+8yN70jwbAW07owkzcw=
X-Received: from qtbfk13.prod.google.com
 ([2002:a05:622a:558d:b0:491:3113:bb68])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:15c9:b0:4a6:ea91:7e9 with SMTP id
 d75a77b69052e-4a9ded1d2aemr28983251cf.25.1752063089185; 
 Wed, 09 Jul 2025 05:11:29 -0700 (PDT)
Date: Wed,  9 Jul 2025 12:11:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250709121126.2946088-1-ankeesler@google.com>
Subject: [PATCH v6 0/1] Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::84a;
 envelope-from=3cVxuaAkKCi4KXUOOcVObQYYQVO.MYWaOWe-NOfOVXYXQXe.YbQ@flex--ankeesler.bounces.google.com;
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
                 "name":"AAA"
              },
              {
                 "name":"BBB"
              }
            ]}'

Changelog:
* v6 - minor code cleanup: really fix JSON syntax
* v5 - minor code cleanup: JSON syntax, QAPI "Since", control flow
* v4 - fixed copy-paste issue in virtio_gpu_base_generate_edid()
* v3 - report an error at realize time if request name is too long
* v2 - migrated configuration surface to virtio-gpu device

Andrew Keesler (1):
  hw/display: Allow injection of virtio-gpu EDID name

 hw/core/qdev-properties-system.c    | 44 +++++++++++++++++++++++++++++
 hw/display/virtio-gpu-base.c        | 27 ++++++++++++++++++
 include/hw/display/edid.h           |  2 ++
 include/hw/qdev-properties-system.h |  5 ++++
 include/hw/virtio/virtio-gpu.h      |  3 ++
 qapi/virtio.json                    | 18 ++++++++++--
 6 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


