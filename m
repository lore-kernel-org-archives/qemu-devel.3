Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5017F4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vux20-0002ow-JZ; Tue, 24 Feb 2026 13:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1e-0002UA-Kh
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:53 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vux1c-0004D4-Ta
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:20:50 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48375f10628so38035755e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957246; x=1772562046; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4E6NRiUP5Q7wbJC5Yig7GTESmJItbXM+gFEQ7QiSTaw=;
 b=Ukf+mrGV+mHyo/6CwKgPZ5CV6jQa5m7mwyji3DcEBDPTaT1bshvh7oTCAwD6NxjkLe
 IkBJZ0Jmc4rHCfw9FKnK82QCNdQARkCO+tWQHJWSB7qAJ9L2UopuVcZyWhUWtLkaldfy
 8eKaY5xfjGvSGvJUoS7YIZ/c6SQLhi+HdI1CG8fUfGWOqVi+Dmn7Hyaxb63jI84xdazD
 Qh4kl/IB6akgFjgVPCkrA9IagosvW18yQVQAtubUytn6TLgNX47nPriSubYbWo0MUowd
 Gh/tmrzZk1+ZXXW6m/kPcTwa2K7ufg0zkhUiUqGPPak5PRqNI6tH1s9yfTrYHzO9M+kb
 xqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957246; x=1772562046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4E6NRiUP5Q7wbJC5Yig7GTESmJItbXM+gFEQ7QiSTaw=;
 b=p0RfuL6FzWWItkPuESVsz+Xk5xphXX9ewuEGvnLcw90UpUkrueOxvoTZDm36VFsqD6
 Xbk/l6dyLa/RIGWwNFsRiyitbl+pq/7Fn+m4Nb6CWeh3ojVoUFXs/JF/3dIKVvgJuCpF
 qFaMm31oEyuhVfGGdPikPkjSZyo+muEAetrAZjcGmzP2wHyBIdX+0INSJYCP66MziuTl
 aqEr56dU9+hWROBhmJuhxspgQxdiIxBnQFa92ldkJv4B4lQFn0D50FfMvMVdnkRP156J
 2kILP3XEATnslGPcCPv7qvi1liskg93lHB9KHs85G0cClMWtvic0JlrgK0EafQNs8mvr
 s7Vg==
X-Gm-Message-State: AOJu0YzAC66NrQTD3xdmA3WS9APYIrd7baqsl+HLXG788Ay0AHs7r+Gu
 +23CSpg4uUalLO/0Q4LQGvvv/dBbE+aBXy1FwIs4obSgzBnyDY86mvaa6tE3LdkmLM34zfyqVYD
 tEpPzAw8=
X-Gm-Gg: AZuq6aJeeNLgxsZtstjnHwH523C1DjqSV6oCPZRNXlqQCQ8Sd0bcE5r9iR+0fItSfEU
 AnRpnr5nhDkEJcTODumDGcfdwBJ7FLVlDDirbR9/6TvPPcppKiXPxHCd/I+0wHDBR3Hq9CH394E
 hD3dJqWMBFPSmnQofp5sMAlsxKm4WAhXi+nlLJV6rK74ThCGjqoljpYKer7U6m7n6dt0+UhlDDw
 fix5GFLjrEzck5o9Ul1MBzu0isz67Lie0bQXq+qUXujNYiXgVEds5jdP3xXB9JMyX8Hbslt6vKJ
 7VAtQC1t22s/tT3LIx9viohkxJy7kPLK2OiqgAYoHQspeY2DO0WjgJ3cPkDSMzJn5Od2Z/+WxkN
 Oq3dVVnPF8tuCxBTA8wNIiWa5mwMlekj/pfdBsfjOb8o/0N6Mo568E30fA0ws6vvVS+zPQI0FVO
 4JhCc8oko6Zzu9bCPZxe0T137GbQ25l0KpS1+2oZHNtsRl9cwM0KsIbXxgWyXm5JhNG1a4Pbcg
X-Received: by 2002:a05:600d:644d:20b0:47e:e7e5:ff32 with SMTP id
 5b1f17b1804b1-483a9605b19mr153270915e9.34.1771957246381; 
 Tue, 24 Feb 2026 10:20:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm16524215e9.1.2026.02.24.10.20.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 10:20:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 04/10] hw/acpi: Always link QOM interfaces with system binaries
Date: Tue, 24 Feb 2026 19:20:10 +0100
Message-ID: <20260224182017.99865-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260224182017.99865-1-philmd@linaro.org>
References: <20260224182017.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Now that acpi_interface.c only contains QOM interfaces,
unconditionally link it with system binaries, regardless
of whether CONFIG_ACPI is set or not. It is now easier to
deselect hardware models depending on ACPI.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/acpi/meson.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 66c978aae83..e1e848327b9 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,6 +1,5 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
-  'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
   'core.c',
@@ -36,4 +35,4 @@ system_ss.add(when: 'CONFIG_ACPI_PCI_BRIDGE', if_false: files('pci-bridge-stub.c
 system_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 system_ss.add(when: 'CONFIG_GHES_CPER', if_true: files('ghes_cper.c'))
 system_ss.add(when: 'CONFIG_GHES_CPER', if_false: files('ghes_cper_stub.c'))
-system_ss.add(files('acpi-qmp-cmds.c'))
+system_ss.add(files('acpi-qmp-cmds.c', 'acpi_interface.c'))
-- 
2.52.0


