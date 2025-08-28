Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39767C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgoK-0003ei-Uo; Thu, 28 Aug 2025 13:53:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fZewaAkKCrofspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com>)
 id 1urgoJ-0003e6-8M
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 13:53:19 -0400
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fZewaAkKCrofspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com>)
 id 1urgo8-00081H-PY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 13:53:19 -0400
Received: by mail-qk1-x749.google.com with SMTP id
 af79cd13be357-7fae3dffdd5so152607385a.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 10:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1756403581; x=1757008381; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=whTczSDksAO6iMUFNflZdYuTDTgvCI77a+sohtLoDI0=;
 b=MQ4qFiIEdLrSOrK1Kw8Dx7avW+tKVLybFrdKMaF/ZJORmN1XpSLaw3hpi73UggPYsf
 H3fy3taahm0FjciFCaRXfn5BYYDzc8blFFdqBBqygptg0dyxG63vsWl3uWUaa9BGb01f
 G+pvzzKVtEdoh96h38DnmEpWW1GzKsx7YUltSWFae2JHr0y8AOgXcWOsWDGmjCRZvQ7B
 xqjG+BF0u9mxuntXG/0tj6Bisn+gezCcubeZPKoyOe5c2DY5EsBfa52iLCLt0r1n3Eiu
 mJZw9ZkuMVI/K/NhZzV9aAXj8DF3Q8C9hGS7/Vq+48EHaFXjIOb24Ba2JbN5hmRfKeq6
 Q6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756403581; x=1757008381;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=whTczSDksAO6iMUFNflZdYuTDTgvCI77a+sohtLoDI0=;
 b=xQI9PCtLEWHzEmzb+sSiHCBR7wpDWBW3ehoaoOJ9sYnaQE1M1DsG/xtCNEWKLizi1c
 KZt9+ERA6V4CI8BMsqNDA/0xO8++j8+cxYHlfotHY/XsaSo0E13JYmzkCLf5DMrnf17T
 iE0X7+u178z8dg+lH6vCyjhzj0DWFx9Kev1P0XV4gXI15YBAIi8FL/LcdPNPJrjQ3S6j
 grqPvBRNbJiPaHYTMBM+OwJwlv9QXBGCGFTG283+DZbkbU4GUF69/G9d71otoAKUuyTr
 Q3laJ/IL4ap9MVgBWL6GzeDySX/R+8WbfWcig2J198S8Yde+dQgDiIk2XBNDdXqXx7K5
 KMkg==
X-Gm-Message-State: AOJu0YyY/9ud3ytxc+Ov2E5jPVmKJePd/llC2n2unDiLu3PIu6a+zVIO
 9XWo+6N+hPTgDJ3oKsSDOOQB7b0gG7ES6tHATQrFLcF8MkpelwsP/u970b9z/5zabfFIgCtzzsk
 KupHMnHzGaKV5OI/B
X-Google-Smtp-Source: AGHT+IFK6OQhtErdEwBHTocfcbH7kkn1AdQ8yVm7mLvnnMX4jBVii3HA7iwXMOEMztxY07RaZdNaQ97QJomKfkI=
X-Received: from qkbdp10.prod.google.com
 ([2002:a05:620a:2b4a:b0:7e8:69b7:38c9])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1aa2:b0:7e6:992c:645f with SMTP id
 af79cd13be357-7ea110692b2mr3041086385a.50.1756403581031; 
 Thu, 28 Aug 2025 10:53:01 -0700 (PDT)
Date: Thu, 28 Aug 2025 17:52:58 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250828175259.3831672-1-ankeesler@google.com>
Subject: [PATCH v2 0/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: berrange@redhat.com, marcandre.lureau@gmail.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3fZewaAkKCrofspjjxqjwlttlqj.htrvjrz-ij0jqstslsz.twl@flex--ankeesler.bounces.google.com;
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

Case: !(xres || yres) && !(outputs[i].xres || outputs[i].yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].xres || outputs[i].yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: !(xres || yres) && (outputs[i].xres || outputs[i].yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: (xres || yres) && (outputs[i].xres || outputs[i].yres)
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Changelist:
* v2: changes after v1 review + 10.2 rebase
  * updated code, commit message, and cover letter to match new res config logic
  * marked new VirtIOGPUOutput fields as optional and since 10.2
* v1: initial patch

Andrew Keesler (1):
  Support per-head resolutions with virtio-gpu

 hw/display/virtio-gpu-base.c   | 10 ++++++++++
 include/hw/virtio/virtio-gpu.h |  2 ++
 qapi/virtio.json               |  6 +++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

-- 
2.51.0.338.gd7d06c2dae-goog


