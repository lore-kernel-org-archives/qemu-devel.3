Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0723C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 19:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueILx-0004TP-8Q; Tue, 22 Jul 2025 15:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3sOF_aAkKCr0dqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com>)
 id 1ueILv-0004RS-0a
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 15:08:39 -0400
Received: from mail-qt1-x849.google.com ([2607:f8b0:4864:20::849])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3sOF_aAkKCr0dqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com>)
 id 1ueILr-0000RC-Iv
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 15:08:38 -0400
Received: by mail-qt1-x849.google.com with SMTP id
 d75a77b69052e-478f78ff9beso137486531cf.1
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 12:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753211312; x=1753816112; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=u2SHEytjikriKp7NwjwceYFzSbHr/pSUqe2/N6XAMfA=;
 b=wTH++uhIpdPQSEXmD8Lr4WgcIbEqnKlFVes2eLaQbX3kKrJOCP3l7NA2bUMQw1mGBv
 V4PLnKJ4Q+Co10S1CaDlMoIfVvRnBuYJO71HvwpgUE3SuAsxw1hw8XAAofQhNyg5KCTx
 aKO/CUdrVZvXFfK3wE/Y2RMFN/+g2L5+s0dRlzvT96+c4sT24/Na+4VSS3BYS2bNufQR
 MqtNLOiuwvIR+MH7oct33+LuUn52QYlLLaOIEDUyNXMJa+QG/zWkZyyDa3g6AkV3cBvv
 n8DcHcKL/d2Bih/dHlenkI+lUkVdqXLUIY9+IQnck+r45BSJXnO//T9yjx1epqSSj+q+
 On7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753211312; x=1753816112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u2SHEytjikriKp7NwjwceYFzSbHr/pSUqe2/N6XAMfA=;
 b=Oj+QQm+ARpYKdE3nu4vo05hlhZg5L0nNznTrZOqv6RqehdqzsOIyQ/GG4iK+Yh2jhG
 fXDLccNj1JDf+PwxZUCrqPtSV4OofQ7Ou8bI8cwKFqp/WFac1Y4fY76V1bE6q0MbwfRD
 pl3bEBmyMZ8AOjCQtW1cbSpZUtTNmX0H7WKsb7mkUYCTkG+BD2y4am+bJIKUkZ2L8z/M
 +yswOgOPzi47+WEvRSfucBbph8b8ygEMhPT+UV/YFhfUyl3j/0luxem3vlNG4mwqH7lO
 oeTcQ4m3vm1BOTL3bLCKu49kxE3kvOKXW2YSHWe56VepB6+O4X12yL7eEqbz9NRY5Y78
 KbcQ==
X-Gm-Message-State: AOJu0YxOtcJ/yCTdgy7ryTJ2ThV6Sex+gajZagiSMdc83djPbbfCIVU8
 YduZkI4jqKgsic+ZW3lVIKgojTKAYJf+VA8ufLkXw8VmEoAG6Rm3Z5s9+jDmppCOPIXyPShgeT5
 Q5M7SgxI53LgL2phh
X-Google-Smtp-Source: AGHT+IGxi0BAUXeY3uITzzL1JexAA5szBfkwsGzHUEw9AvQPLFFp6VDXhieSOg6jvj9k87uzX1CrZFg1lfpP0hc=
X-Received: from qto21.prod.google.com ([2002:a05:622a:a6d5:b0:4ab:6375:3dda])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:2611:b0:4ab:5ce8:b2d9 with SMTP id
 d75a77b69052e-4ae6dff25femr2695921cf.47.1753211312307; 
 Tue, 22 Jul 2025 12:08:32 -0700 (PDT)
Date: Tue, 22 Jul 2025 19:08:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722190824.3419413-1-ankeesler@google.com>
Subject: [PATCH 0/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::849;
 envelope-from=3sOF_aAkKCr0dqnhhvohujrrjoh.frpthpx-ghyhoqrqjqx.ruj@flex--ankeesler.bounces.google.com;
 helo=mail-qt1-x849.google.com
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

If no virtio_gpu_base_conf.outputs are provided, then
virtio_gpu_base_conf.xres/virtio_gpu_base_conf.yres will still be
respected, preserving backwards compatibility.

Otherwise, if any virtio_gpu_base_conf.outputs are provided, then
virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
will take precedence. In this case,
virtio_gpu_base_conf.outputs.xres/virtio_gpu_base_conf.outputs.yres
must be non-zero.

Andrew Keesler (1):
  hw/display: Support per-head resolutions with virtio-gpu

 hw/display/virtio-gpu-base.c | 12 ++++++++++++
 qapi/virtio.json             |  6 +++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.50.0.727.gbf7dc18ff4-goog


