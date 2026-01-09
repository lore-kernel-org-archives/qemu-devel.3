Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA64AD26D94
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 20:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veJ5Z-0002jV-LO; Fri, 09 Jan 2026 15:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3yWRhaQkKCmoIVSMMaTMZOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ankeesler.bounces.google.com>)
 id 1veJ5T-0002Yz-4J
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:28:01 -0500
Received: from mail-qk1-x749.google.com ([2607:f8b0:4864:20::749])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3yWRhaQkKCmoIVSMMaTMZOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ankeesler.bounces.google.com>)
 id 1veJ5R-00031X-Jx
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 15:27:58 -0500
Received: by mail-qk1-x749.google.com with SMTP id
 af79cd13be357-8bb0ae16a63so542698185a.3
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1767990474; x=1768595274; darn=nongnu.org;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jQrE6wFQTNZ66sp36of1F0rAvYiLt/OaxdB81a8ihJ0=;
 b=tDcJ+GkrCwPBNGJlqb+Xlzwwr5LRIzKRT7OlGGNNNJaA96ZaeHJxk8esaU4aF0QG8I
 MMOBVuq7wcWxwcEpfs+QCOTG4gHHROLuewYmt7wMg0aZm4kSb7Sre1A69/o546om6vM7
 l6NYj0ijY90/CbLN7k50ERXH78qr5mqZ/qidKlaKayDAmP9B0Nx5W+nILenJkAdMqV7d
 /zfHCYY9zIXBB8klEwi1K9c8gEpqwJn8CqDvrkafrShM56J5Zthr+rZAyCqusiQFQuyV
 nn3eVBSqpWqGLu/3f8hXS5eIVvamyPy9JDOpX7owyK6KC0jU2otbulpVI/lfjbUQk7aT
 A42w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767990474; x=1768595274;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jQrE6wFQTNZ66sp36of1F0rAvYiLt/OaxdB81a8ihJ0=;
 b=NShpueXGmhFrL+r7jMkrxGGMUKNXXjPIiykPwYmBeYdV/RxHAZRpDkN8mtgOGrYJ2P
 UDlk+JFcSRPg1ygdPUo3SaUVpmyARYi7IAIc2HEX2zrb9rXIotsot7ca7OQOMHmqTXVg
 pLfKoiBAwvTMWsVwkUgQw58WFxcQMGfwx2nDVJhPNlSgIXQtghMv+zRVEXmZPS7cR25E
 vL27FgndNSkCutUIWQSPjqlw9hXYN0Sgb52JuRQeYy6r+O1z49llCVrgIJ34mEbyFvGF
 z8KNtFS5G5JmKoYFwauSGIg38Ip8zt7MdwXySf5d8PovYuijYuc2icZFLY1/XVaxuD2Z
 19QQ==
X-Gm-Message-State: AOJu0YwykAUYjHWfD6SAzjzZrRAL/A7T37pSW65S1jXL+x5vToQqVt2Y
 0j8vwRGLuQehK2Q/PpA1ClFDiHkgoYUk19zUqJZjHtbBn3Nl8H5s1wT6N5tonWot/KjgcmsJng4
 8VmWrgaRvYRmeE7TL
X-Google-Smtp-Source: AGHT+IFaxSqZsvghvy8Df3GvxxK1tzi0SZJBrmrDM2pAo7k3jv7r2HVc98AwiJoTVd94EmeW983zHvH4dRcBI9I=
X-Received: from qkao20.prod.google.com ([2002:a05:620a:a814:b0:8b2:e8b8:3d8a])
 (user=ankeesler job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:290d:b0:8b2:edc8:13cc with SMTP id
 af79cd13be357-8c38938b5d4mr1528588585a.40.1767990473866; 
 Fri, 09 Jan 2026 12:27:53 -0800 (PST)
Date: Fri,  9 Jan 2026 20:27:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260109202740.362506-1-ankeesler@google.com>
Subject: [PATCH v4 0/1] Support per-head resolutions with virtio-gpu
From: Andrew Keesler <ankeesler@google.com>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, 
 Andrew Keesler <ankeesler@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::749;
 envelope-from=3yWRhaQkKCmoIVSMMaTMZOWWOTM.KWUYMUc-LMdMTVWVOVc.WZO@flex--ankeesler.bounces.google.com;
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

 hw/display/virtio-gpu-base.c | 10 ++++++++++
 qapi/virtio.json             | 13 +++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

-- 
2.52.0.457.g6b5491de43-goog


