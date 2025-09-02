Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AA4CA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 14:15:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utRlY-00037H-7H; Tue, 02 Sep 2025 10:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3gfu2aAkKCqAANKEESLERGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--ankeesler.bounces.google.com>)
 id 1utRlU-00034w-Sg
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:13:41 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3gfu2aAkKCqAANKEESLERGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--ankeesler.bounces.google.com>)
 id 1utRlH-0005Kt-EU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 10:13:40 -0400
Received: by mail-qk1-x749.google.com with SMTP id
 af79cd13be357-7fa717ff66bso1114709085a.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756822402; x=1757427202; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=UZNSCN5sYnNYWa8Hr4uwRVGbv6aMKp/piGaLp7BrsHs=;
 b=DBLyoAX/4kzwws1BxaWlo2dHk67z56hq4QzTxJe7u3vFvsruIXt/xRTSWUNyR04BPg
 Iptd2eBgg7tY+Hsjl4WlXyCVBSfj2wc3NKogqGC0jSjWlzXmxV2WgK2DufxzZXkPzglR
 6KlewAkaPH/pwWoUtoYmUrA1d1C+zDKksHXichBUcl4k0LLU+IjAZj9KcRWmSbGnVAS7
 uhSOegTjxzlbUMLV97tK6LOwj8vNLBlPPuHXpA5wrfyv7Eh120SWisnOvlOrXCrtjEI1
 buAaEzWIekznrVQy4Eu2R9/qiv0BVmj6QJWQBsmnbskpMlE9lCNDJnIEsOda7k1ACm2d
 CgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756822402; x=1757427202;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UZNSCN5sYnNYWa8Hr4uwRVGbv6aMKp/piGaLp7BrsHs=;
 b=lCx4TsjUgJZdKF7fzsz3RLQ5qDXUE16IC02WNTvIx9F5MX4kTikJI3RRdMW378qi5j
 XJdcq3jQPC09W4LT61UEb2lf8d55rgF08Np+CTnqKRncnLOnSwJx3Noeaypii5ioUr80
 6BsXXcrIZknNsbyrHohfTgOi3WCOluyj8L/2p6YIPTgDVaVTmeF3rXVUHPlsy+5VWdKn
 EzgKes/2zJ7hAI72cCbnmEk8PED8Mp4wTRrNXrZ4PF1Nkv4sHwo+P0JJpocD11L5bMBv
 RRGpnNIpleh4uF/c8uZkKBUCoLRCTdTDl/YitvP/QMGik9egG9cwntHPChbgQlzdQeP8
 9bZA==
X-Gm-Message-State: AOJu0YweXnigVuPvz5NXBsS1iSHoWxicNtYODEaQ0PTLi4KNsKPUSpKp
 cClnR8CefsNvUB4NoX+Jaqci2sTav1k31oca17kEOxRMrXxFX6lje1JQbT1+OkehZNzi/2s850S
 HUABM1kmqRpdskfkH
X-Google-Smtp-Source: AGHT+IG14FLglvlVh94qxRhWtrs/0kZICP6fsl3cnnx6X+6RdF+hMXJGf0U31e9EceikpmF/T0eX8FW6Qy0h60E=
X-Received: from qkbdl5.prod.google.com ([2002:a05:620a:1d05:b0:807:e3b6:b77f])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4451:b0:7e9:f81f:ce8d with SMTP id
 af79cd13be357-7ff2c145378mr1083271085a.79.1756822401622; 
 Tue, 02 Sep 2025 07:13:21 -0700 (PDT)
Date: Tue,  2 Sep 2025 14:13:11 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250902141312.750525-1-ankeesler@google.com>
Subject: [PATCH v3 0/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3gfu2aAkKCqAANKEESLERGOOGLE.COMQEMU-DEVELNONGNU.ORG@flex--ankeesler.bounces.google.com;
 helo=mail-qk1-x749.google.com
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

In 454f4b0f, we started down the path of supporting separate
configurations per display head (e.g., you have 2 heads - one with
EDID name "AAA" and the other with EDID name "BBB").

In this change, we add resolution to this configuration surface (e.g.,
you have 2 heads - one with resolution 111x222 and the other with
resolution 333x444).

  -display vnc=localhost:0,id=aaa,display=vga,head=0 \
  -display vnc=localhost:1,id=bbb,display=vga,head=1 \
  -device '{"driver":"virtio-vga",
            "max_outputs":2,
            "id":"vga",
            "outputs":[
              {
                 "name":"AAA",
                 "xres":111,
                 "yres":222
              },
              {
                 "name":"BBB",
                 "xres":333,
                 "yres":444
              }
            ]}'

Here is the behavior matrix of the current resolution configuration
surface (xres/yres) with the new resolution configuration surface
(outputs[i].xres/yres).

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: !(xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: (xres || yres) && (outputs[i].has_xres && outputs[i].has_yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Changelist:
* v3: changes after v2 review
  * fix new resolution configuration logic (&& instead of ||)
  * correct use of api machinery (has_*)
  * move documentation to QMP API
* v2: changes after v1 review + 10.2 rebase
  * updated code, commit message, and cover letter to match new res config logic
  * marked new VirtIOGPUOutput fields as optional and since 10.2
* v1: initial patch

Andrew Keesler (1):
  Support per-head resolutions with virtio-gpu

 hw/display/virtio-gpu-base.c | 10 ++++++++++
 qapi/virtio.json             | 10 ++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.51.0.338.gd7d06c2dae-goog


