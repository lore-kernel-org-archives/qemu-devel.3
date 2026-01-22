Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D89D625FD
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTj-0002li-D9; Thu, 22 Jan 2026 03:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTi-0002fh-3o
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTg-0006IV-66
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso6926805e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072142; x=1769676942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bs1mcONeiLTXcC9NFaJnqYFDkgsdBFopUmqMHml2a5g=;
 b=QQpd5pIXP8l8w+7ay8Xr3IwFGtJ6T6g4h3geesknAQkqXcI4fEHR71xenO/a0Z/yje
 jwesKLVe+Nz2/bgLXKzRYFsVxqliRdktejCIY68NgUG7EkppZy7elUGG1CN6L3VCxKwA
 MuiYxwv3JhP4DCdS+dgR4TwHa30vuMkc38jeN3JNGtoukzCzTEL3rxdcDDLgOp0BC/+D
 ADireYskGTpfWC7uNlpbQFDKeOZP2kduAMLposbooEPoc4d4s5K+yg22qGnabn4Q46iF
 WUs3+Ej17a8yy1zN0qr2YyvFLsfrU+4VLdFZ2a9JjSBS7q03RVEgQJ8BP8S50LkIGMnZ
 iheQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072142; x=1769676942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bs1mcONeiLTXcC9NFaJnqYFDkgsdBFopUmqMHml2a5g=;
 b=E4mS5BQW7Vy1iGwLsjwodgwzGIflsp6kWRoke6fVhPyy3/mvMCe/TIQ6Fmk0+N+jDO
 hhc0blL7v2MEV1pLujn8YJy7mZaYknwbCViGllMe+2CVUJjxoTEnMKHylCCDYKwUHBSV
 5OvESkJy262RmiLlwDLCOxPb6m1KU8Vux6fVD5nlgMwTfu8KS6mR3ciwQ6IY+iU6Wguj
 XvyLXYcruOc9adtw3cS/fYTkAVFlNKhEQXgJiTk/7OGIoZrMx+kLgwbP2plzpHMnJOxH
 N1Sje0NtTQlSrgYZEIQkAHiCDHgsi9QkECWay13BaPbZVmtzT1hlHvgYcdJu7n6eZ6PC
 AIUw==
X-Gm-Message-State: AOJu0Yxm6HvHys3PPavNRXPk4dHZFKxr6ThNuF4ymbMinGHCayptLEyQ
 hv2m62Q3zjKATbVV8yvLNCTB7x86BMSRKxvtC1rn9gbahNUr8waCnMlSimRI5EVlRPDGkIA/iP3
 WhoQ5M8Y=
X-Gm-Gg: AZuq6aLZgmaDDH9jFRMpuk0yGWLwN3C+HfHZzIvjTsA+nfg2TWYa+12Pn8bjDVVoPIt
 y1cwibkuX2BYQ3KasOVbCu/bNrSQpjj8249y2rA4XZnYb6Ib51mTF8lMqqwHFM98l5nxkkOmb6q
 sVn4gedGfUABDqHA6EjgRgxjZ9/9YLB5pU0uPlZO1Qi9wqKBOjcYLegvAsXBV+9Pu8+ijc0YSRq
 zr+43FcNJ9+y+3Ina2AGViDP+WAfae8O34U28Hc+8H9d1ubgknrRQwJziI+m0JK9nY7YwMluc4E
 LqbVKelUIItFzbKhqxbI5k0SNxuOvGIdyvdlMjn168gVYbK7z03Jt11lbMJQtj2ZyXLvXW1mrYg
 M9rvfKMi4Zg5cz94EBkVyDhPkes6EGmWA3F3bwsTKTpsBkMN7t5u1A+PQKZPwheBhoa3qobi8Hq
 bvDh4Ur8PJrHgOESIA3AbCPfnblcaJ7tcyelHU2FXebHJFGmHoT2ZL+QYJO/ZV
X-Received: by 2002:a05:600c:458d:b0:47f:f952:d207 with SMTP id
 5b1f17b1804b1-4801e341e2emr242656545e9.19.1769072142358; 
 Thu, 22 Jan 2026 00:55:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804706f14fsm52452845e9.13.2026.01.22.00.55.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/31] configs/targets: Forbid s390x to use legacy native
 endianness APIs
Date: Thu, 22 Jan 2026 09:52:48 +0100
Message-ID: <20260122085255.95035-26-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

All s390x-related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . f0853c25862 target/s390x: Inline translator_lduw() and translator_ldl()
 . ee4dae6a332 target/s390x: Use big-endian variant of cpu_ld/st_data*()
 . 381a1fda5bf target/s390x: Inline cpu_ld{uw, l}_code() calls in EX opcode helper
 . 69da23130f2 target/s390x: Replace MO_TE -> MO_BE
 . 0fb6ad781cc target/s390x: Replace gdb_get_regl() -> gdb_get_reg64()
 . 409cbb1a619 target/s390x: Use explicit big-endian LD/ST API
 . 6d9dad71265 target/s390x: Replace HOST_BIG_ENDIAN #ifdef with if() check

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224162036.90404-9-philmd@linaro.org>
---
 configs/targets/s390x-linux-user.mak | 1 +
 configs/targets/s390x-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/s390x-linux-user.mak b/configs/targets/s390x-linux-user.mak
index 68c2f288724..e3723f5dc54 100644
--- a/configs/targets/s390x-linux-user.mak
+++ b/configs/targets/s390x-linux-user.mak
@@ -4,3 +4,4 @@ TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/s390x-softmmu.mak b/configs/targets/s390x-softmmu.mak
index 76dd5de6584..544657cfe2d 100644
--- a/configs/targets/s390x-softmmu.mak
+++ b/configs/targets/s390x-softmmu.mak
@@ -3,3 +3,4 @@ TARGET_BIG_ENDIAN=y
 TARGET_KVM_HAVE_GUEST_DEBUG=y
 TARGET_XML_FILES= gdb-xml/s390x-core64.xml gdb-xml/s390-acr.xml gdb-xml/s390-fpr.xml gdb-xml/s390-vx.xml gdb-xml/s390-cr.xml gdb-xml/s390-virt.xml gdb-xml/s390-virt-kvm.xml gdb-xml/s390-gs.xml
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


