Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7934C5DF7E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwINb-0001HF-Sj; Tue, 18 Aug 2026 07:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwINa-0001GV-64
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:53:18 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <colazcyg@gmail.com>)
 id 1wwINY-0004qA-Re
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:53:17 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-6ae542c486eso2122622eaf.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787053995; x=1787658795; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jWjcQ2AZ2KVojV3bnRB9n/hDeX7dh6xcsMreL3lpgl4=;
 b=qzZEKtQIgiVqunCnrCMLdsoDBIsIHT0wkA7NEiUs3tLRWvocIOSMXdRP6xs30VuHEH
 PF7YMukyDcNT4QZzAAfDqipDE0fjWgncv2t1vLKfjzn56PeVZF0e/V8r+2EmwUZZ8FdF
 o7LMJwNRj5Td3DI4seXhLz0wcIXRcktv+603rSAfDgk0d6cyKODhGcRN0rwaQgJHb4/Y
 5GU5HNLMM/C6sMSP+QWVtff6fV4bBmxOv0Du/9rHzTLMSrYsD1ipVpQSzX18JRwfkB0d
 VtYY5azspUZK0i5QtAGqBujidsauzefY13l3u4HFYpry9T9nxuMOz7a98ngTj5hBX61Q
 0SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787053995; x=1787658795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jWjcQ2AZ2KVojV3bnRB9n/hDeX7dh6xcsMreL3lpgl4=;
 b=iQDH5AoP/gcJwbAsG+Xh0YGLhUJQQPtHzuR8XIop/ewKSohkXuF17R1j3M2dVBXpmx
 SA0+JmRsk5NgDuUJvKCrARB6PNkVBr2c291Nv5++VUD/B4bY8KdgfWTlvok03rxp2eJv
 4YlHzwnduBa4ZHlM0lkAbE+J8EsZwWCHJvMF0FY7lO4MQk10ijxlm/XAOUfNJWcZa4j4
 sQQv74q7PSXQWngbnYtktN5Cwt/Wev9VToaK+VJDbsGwBZd0xEo+3hd2m57+SoIOHc4F
 v3ncOToBojXtCdTzLDMRu4ERm8GGrsQL4DwYRCLrZxk71Rbc8iOCgBhzo20SRhfVQ+CN
 kVHg==
X-Gm-Message-State: AOJu0Yy3vf7V1zd77cfcBflyTtsIkqwSOo+WLZ44bYWMwiTlLP/jQoMG
 RXKqPtjCGDtQw1Qh+WIlSenN1CFI/8/XCscF1Znyfdk/V+TthpA38uMybilgDscAARs=
X-Gm-Gg: AR+sD13q+p2+DQ6Z0kOGRYixhYuuftRdBpCRiBUB0N8+GsyWcU0+svOi6emPGC8lniA
 SFJ2W5/XLMdO3uOmm/m23L1uvUGQB70pwTFjbAzcfKeKX8REDwXWYiRQcm7vxI3E7IfhW9WmYzl
 mgn2/+s5+7YBszMiMEWo7b+LS2irFn4rM1hewKE2N54nlT4q6TSuyBi9EE7A+qhZjOmbOm6Ef9m
 AF3irPyNJ/1GyRQTVx1bi0qFhkBH831HItB1IPIgN2ynNWMONSbpH0jZKP/MYnGyo3x+s2jX6Zj
 PWRWs6JHmp3jZ1GbleghbQKp7kYrqP7dKMNhFLeSAOuVPka4UiNxrReS4URxSPI3uQO+VOOJ1yU
 Kp7VVuYO/Xt4oQFeNdnea7Vn0ZVJkkmcfXvpIqgxgqFeqGMsuXdDHrHEfaNKHmW3Qzgq5ZEOGmS
 XZsFVod/GPBqM9CTnR6uPVHJQigb6JR0tZjrA0NHPFmC0l5TrJXpiCX96SjWbSe3Cd
X-Received: by 2002:a05:6820:1990:b0:6b0:40d9:8ac6 with SMTP id
 006d021491bc7-6b0d60169eamr26006627eaf.9.1787053994808; 
 Tue, 18 Aug 2026 04:53:14 -0700 (PDT)
Received: from colazcyASUSlaptop ([104.28.213.39])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-45f226904b6sm3039002fac.0.2026.08.18.04.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 04:53:14 -0700 (PDT)
From: Chengyang Zhu <colazcyg@gmail.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	Chengyang Zhu <colazcyg@gmail.com>
Subject: [PATCH RFC v2 0/1] the org.qemu.Display1.UIInfo interface design
Date: Tue, 18 Aug 2026 19:52:57 +0800
Message-ID: <20260818115258.429605-1-colazcyg@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=colazcyg@gmail.com; helo=mail-oo1-xc2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, the `SetUIInfo` method cannot set a refresh rate.
Simply adding a refresh_rate argument would break the method signature.

This RFC adds the `UIInfo` interface containing
  * properties as staged display settings.
  * the method Apply applying staged settings.
  * the method Reload reloading settings from the console.

This patch needs further discussion on:
  * public API
  * necessary test suite

Changes since v1:
  * redesigned public API

Test results:
  * qemu:qtest-x86_64/dbus-display-test passed
  * qemu:qtest-x86_64/dbus-vmstate-test passed
  * qemu:qtest-x86_64/dbus-vnc-test SKIP
  * manually created a virtual machine
    and successfully set its refresh rate and resolution via `UIInfo`

Chengyang Zhu (1):
  ui/dbus: add org.qemu.Display1.UIInfo interface

 ui/dbus-console.c    | 86 ++++++++++++++++++++++++++++++++++++++++++++
 ui/dbus-display1.xml | 32 +++++++++++++++++
 2 files changed, 118 insertions(+)

-- 
2.55.0


