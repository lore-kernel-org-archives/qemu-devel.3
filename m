Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E90CC83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZEaL-0000lq-0e; Tue, 08 Jul 2025 16:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ZFBtaAkKCgUfspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com>)
 id 1uZDX6-0004zZ-Hw
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:59:18 -0400
Received: from mail-qv1-xf49.google.com ([2607:f8b0:4864:20::f49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ZFBtaAkKCgUfspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com>)
 id 1uZDWx-0001jA-Ai
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 14:59:11 -0400
Received: by mail-qv1-xf49.google.com with SMTP id
 6a1803df08f44-6ff810877aaso115730466d6.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 11:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1752001093; x=1752605893; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w2qEX1zf6G9ZPjVsXEBuhmYw703se86rNQBAuotHINA=;
 b=vZqZPrXF3FAvWojevKZTcB9WiPsRXZZnjv7pFJ7xcf0LJYDj7hvYn9yQBVbuhTGGDY
 AgFM2geUPyFxkmRBJDZVnH7kY4PwQPmDKCX1FmWcnXWwP5+yYE0bAuCBA7RE3be+0xP3
 kxNoz9xL2v7cnl6dB1pba8/E9UaAB6egXarlcyaa1nBhTdgnSOSXeHYVEfM2G7maA7VA
 lMP/T7r+atoIH6z2kr70yaT3ZYqcEo7BrIgrpPNj8NedmYe4gkIDxoCoseXVoaC08luF
 aoA+y2+MKJTu+KY7Dtj1+rz83tkkr+E7XKdq0+WRH9Y/VkoG60weKEqO3iGsbha09YZX
 rXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001093; x=1752605893;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w2qEX1zf6G9ZPjVsXEBuhmYw703se86rNQBAuotHINA=;
 b=rXiJgSb+c23PiVYfX3/GlQ+9/nLWUc5D899wis8uITGLBmGB7xefZTRFJ4qDsURJo9
 ziY9OYCmB/qthnuybJqzkVeimbB6+sI05dS9uo3lPf11DlyiT7AK4kS9SJq+AuNQNXHA
 5b4mupNMJo/yXUrRXhLbrsNxoDY9mCZNLYwDaOhzznsoPXNuDtqKfeLHFCZrnK+cPwaX
 j8lCJFDrGJHCxNWi/FnUTK3n3cABcGadG8+EjIQGhixq4nSWC1smIb07ISbuaCoVJjtZ
 w4p5t7ZOqb7JVqgrIEdpAkgfpwmFt4mihquVSExjXnr49m07HEjXxtmyWLBhpHH328WY
 J9pg==
X-Gm-Message-State: AOJu0Yy++5G+TBXdmxooK+mTu6UhQCGutmcDoIBYC6J3gbJE/5KZV4Cx
 srOL7QlZ+V4GUIUXKOVnR5uoHwQjJi4iLt8IU+SvyH2dTOF02hS7DKNaWcwHlHNIyhio7GAY69r
 Ww/AkNvhIQvZ3VcYs
X-Google-Smtp-Source: AGHT+IGZ77XMRQDNFBcCdYxUXNIuY+jnB5NzvJHiBCzV2lmyDXngV2oGod1hFX5ZMGeAb62OyNRwA6FCCw7TyR0=
X-Received: from vsbka1.prod.google.com ([2002:a05:6102:8001:b0:4e7:c796:d4f])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:8016:b0:4dd:b037:d239 with SMTP id
 ada2fe7eead31-4f2ee1ab47amr13117331137.14.1751994468622; 
 Tue, 08 Jul 2025 10:07:48 -0700 (PDT)
Date: Tue,  8 Jul 2025 17:07:44 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250708170745.141040-1-ankeesler@google.com>
Subject: [PATCH v5 0/1] Allow injection of virtio-gpu EDID name
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f49;
 envelope-from=3ZFBtaAkKCgUfspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com;
 helo=mail-qv1-xf49.google.com
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
              }
            ]}'

Changelog:
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


