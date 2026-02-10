Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6783EEA8109
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 12:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpmtO-00072W-FB; Tue, 10 Feb 2026 07:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <39ySLaQkKCsAgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com>)
 id 1vpmtI-0006ye-Do
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:30:54 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <39ySLaQkKCsAgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com>)
 id 1vpmtG-0005eE-KM
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 07:30:52 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-7962a21167dso59134927b3.3
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 04:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1770726648; x=1771331448; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hIumlyzfX4+LJcZKOw9TYrZzl3mGridRfp8pElfztn0=;
 b=sqdZtqzYsZnFJmoxgma4CLtzCFT55INXmrH7fGX1qMlrxLbHjEnMs514X/XaJfp7LN
 9v87e8bSotf2n3y6gooQAbWFIQ3bgK9FHLfm2ewrDdk5rjvjxJZ6Rxl+iZNfzPbMQFpX
 t3tL1OqKEA8s8BL2kuIQuq52WIfhocaDSO1njpjNYXey9jvDLCIcQPEj/+r/Ywk3WXru
 MC4Nhrx+Anj1aRrdBFDzpuSdCQlUbtDuJubcLsLYKmHDF+cBhqh7XfmXkwg1FIuhqZ1P
 xh3XEWBpO/IaasODzQP6h0Jc1HlQC9ePqfjsfQ/vTTA0Cb9qjQY206G+3yI760HpPffw
 rfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770726648; x=1771331448;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hIumlyzfX4+LJcZKOw9TYrZzl3mGridRfp8pElfztn0=;
 b=cBB+FdI7bNiHwXpt9yoeUMKJx315GS5cADgDlLO10ZDY/wUCe8QzrVUa7i1Url0h/2
 z4hXwllqvpWGDh6NwsoFnO9bAgQU6F2XQg2PtV4EfyE3nbFwM4awuI8ZVrDKARcWpjPw
 e/10FYXaUr3e26ac3T6z1P+FkbYSkxpCmUXh8EhIlAiU9++a17e5rG3+CrTFrwtdOYCv
 aUEO8gATQWwT7cTDi9BjoJ8hHFjtsvHhmhCHN9d+IdF3MVAxdO2pcAYkJmxR9oRRW63K
 kf+BbytWt2WKkxpn8DMRpNg6c8HTyDahnjNKObwnMepPyrrt/5t1aHyEgZ1AnECohl62
 UfPA==
X-Gm-Message-State: AOJu0YwWY4bQp8eBdj45PBbUh30hCFH0AQCyWKXxpL6TYSZ4H2LoDlF7
 AUSxCm6D20g87lJb4EJ38xS2yWbasiBY8k4+7PmuITjihoFdAdTg6ecA64VmnX3NURgKtRszEWs
 Fgsb8bue6gIT2u8zx
X-Received: from ywbeu16.prod.google.com
 ([2002:a05:690c:2e90:b0:796:4c20:fb80])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c24c:b0:796:5b5e:f4ff with SMTP id
 00721157ae682-7965ef010d5mr13447687b3.23.1770726647811; 
 Tue, 10 Feb 2026 04:30:47 -0800 (PST)
Date: Tue, 10 Feb 2026 12:30:37 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260210123038.2332364-1-ankeesler@google.com>
Subject: [PATCH v5 0/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: alex.bennee@linaro.org, armbru@redhat.com
Cc: qemu-devel@nongnu.org, Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=39ySLaQkKCsAgtqkkyrkxmuumrk.iuswks0-jk1krtutmt0.uxm@flex--ankeesler.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Note - we use "xres" and "yres" (instead of, say, "width" and "height")
to match analogous virtio_gpu_base_conf.xres/yres.

Case: !(xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with default xres/yres

Case: (xres || yres) && !(outputs[i].has_xres && outputs[i].has_yres)
Behavior: current behavior - outputs[0] enabled with xres/yres

Case: outputs[i].has_xres && outputs[i].has_yres
Behavior: new behavior - outputs[i] enabled with outputs[i].xres/yres

Case: outputs[i].has_xres != outputs[i].has_yres
Behavior: error

Changelist:
* v5: changes after v4 review
  * since 10.2 -> since 11.0
  * setting only one of xres and yres is an error
* v4: changes after dropped from pull request
  * rebase against master (3b5fe75e2c)
  * use @NAME (@xres/@yres) in qapi/virtio.json docs
  * documented behavior when only one or none of @xres/@yres is set
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

 hw/display/virtio-gpu-base.c | 16 ++++++++++++++++
 qapi/virtio.json             | 13 +++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog


