Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C80DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 05:28:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFnbN-0006Er-Pn; Fri, 16 May 2025 01:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbM-0006Bu-95
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:20 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFnbK-0001MS-Iq
 for qemu-devel@nongnu.org; Fri, 16 May 2025 01:27:19 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so1494954a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 22:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747373237; x=1747978037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=svLwGXDeWk3zFJeYjPP+l2YWYJd6pNP0E1Epsagupsg=;
 b=Szyqb0VylrubyK+3rtudKhpjyZQbvRkUAT/9yWi4sWmsON4tOajXy/sRtqLqNGycp/
 /O+ZJvDQUawZNbovw6avlqvSXtJ1UC885dt24GSViDDv4tngncw56RYxJLELtE9DEKy/
 T//hhdMEWLgz7/DqkbIPCDYBhanyHIpqX+YU+n4mQZY98bfAlvl4L6U5ICkrNWGoduFI
 tvOFrSwX2XlAHWC/5/k1KlOg4XtwYCINtltSlf4kkY6rlXimEAiD+d54jLhqdEl/W9qm
 01XfOu2CORj6N+iA2x16yoLJyJh9yMlBuLd6IeU4W2Pp93Vlbn8ZWm+A/eVWVaFqjc+u
 Iq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747373237; x=1747978037;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=svLwGXDeWk3zFJeYjPP+l2YWYJd6pNP0E1Epsagupsg=;
 b=thVeAPYLIt8dGSWoM874sPUt4K04TgxSw+4b2lDn7uElix+vfvabfuaeKMQOMcm/If
 e6udLJVNMxSRRv+DqfcBn97o23sUvjzk/G8iEht/beSDNP8OJ38gG0j05+qi5Os3kHGR
 Uua/uRzsKnc3qEhlIN95EriQ7Ta9OJwgBpSDXXMRBmwqeaCEf+7HJEUlEgTc6f89XTsZ
 qLI7kGPDMX65y29wFi9TWoQQ4I0jRsYxyhiJhZm8PsI2q7vNoClz4CYJpdY+xNSKsG4h
 1kImSTri4/9IFB2CkVH4ZynmCuuCRq9Kee2CpuZzPL1VDJUmHkaLjx9i7fKbY7rJz3HP
 wBRA==
X-Gm-Message-State: AOJu0YzgnIxLAzDM08oUfPAYi2Bxc4jSQKATL3tZFsw/wp4dyxK6LclK
 kHpaW2o+J/VpryuPbIGThwpGWVmJWxUZUB1KKENmJJ88SiPUnPMtstwYLOR2uUhxm0BgTYj8TWG
 xyZQZ
X-Gm-Gg: ASbGncu7mnAXyDaPDLGRFueLgi7si8erQlluHKnp+trxmj7k+OeDm3qzVqcqvGcx7qj
 KXSO9+DSjlWbKJouOerWXzfN/bGghgZDv81l0YltUV64mkg149TMPLjTtEC7sD8kRpEFXsM7Ago
 hDG/UneSOh8WG2BV/FeTO2knU5Ob0sMJrDKb88/5abJz0kvIVTYFkEnp9ZNii5dGE2xqTSrwp0n
 koZiGI8L2JPW4Ox4NbN5nHDu15wEat57/nrOR+Jbj19179u+66/ol6jN8XyqI+uSvhc2kl99bpt
 FuEwUqJLSjsudbumajXIBteZjlrkSjblTs0BSXgkVv7/668zVds=
X-Google-Smtp-Source: AGHT+IFHxE46OApULY0tAHBzx4C6xYEISWLpfXR4Y0TpAur1EgxSEqPDvEK52tTTHN4poZypQFUDjw==
X-Received: by 2002:a17:903:11c3:b0:223:47b4:aaf8 with SMTP id
 d9443c01a7336-231d45eeeb0mr24243345ad.52.1747373236821; 
 Thu, 15 May 2025 22:27:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4ebabfesm6539135ad.174.2025.05.15.22.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 22:27:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 thuth@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/6] single-binary: build target common libraries with
 dependencies
Date: Thu, 15 May 2025 22:27:02 -0700
Message-ID: <20250516052708.930928-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Recently, common libraries per target base architecture were introduced in order
to compile those files only once. However, it was missing common dependencies
(which include external libraries), so it failed to build on some hosts.

This series fixes this, inspired by Thomas fix [1], and applied to other
libraries introduced very recently with [2].

As well, we do further cleanup by removing lib{system, user} source sets that
were recently introduced, by merging them in system/user libraries, thus
simplifying the work on single-binary.

This series was built on {linux, macos, windows} x {x86_64, aarch64} and
freebsd on x86_64. Fully tested on linux x {x86_64, aarch64}.
In addition to that, it was checked that compilation units compiled per binary
stayed the same, and that their size was identical.

[1] https://lore.kernel.org/qemu-devel/20250513115637.184940-1-thuth@redhat.com/
[2] https://gitlab.com/qemu-project/qemu/-/commit/b2bb3f3576e5dc99218607dde09e25ac0e55693c

Pierrick Bouvier (6):
  meson: build target libraries with common dependencies
  hw/arm: remove explicit dependencies listed
  target/arm: remove explicit dependencies listed
  meson: apply target config for picking files from lib{system, user}
  meson: merge lib{system, user}_ss with {system, user}_ss.
  meson: remove lib{system, user}_ss aliases

 meson.build            | 65 +++++++++++++++++++++++++++---------------
 accel/tcg/meson.build  |  8 +++---
 gdbstub/meson.build    |  4 +--
 hw/arm/meson.build     |  4 +--
 hw/core/meson.build    |  4 +--
 plugins/meson.build    |  4 +--
 system/meson.build     |  2 +-
 target/arm/meson.build |  2 +-
 tcg/meson.build        |  4 +--
 9 files changed, 58 insertions(+), 39 deletions(-)

-- 
2.47.2


