Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC38DC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 12:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZrV5-0005ad-PW; Tue, 13 Feb 2024 07:03:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrUC-0005No-9l
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:13 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZrU7-00015z-Em
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 07:02:03 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411ca9dfffdso2038565e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 04:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707825716; x=1708430516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gHL9nosvLBVU3E0iohtGPQO+kYcTEquxkRGU1DqD6Xg=;
 b=RKjq14j3HzYDGZJlY3Q6HQu6bQ1jCJu3l4TfeD5jZ+Tc6sQNX/5LuEHEj1hBTDshh5
 YQXIzb+LZO6aqhStw0jOyyPyUNBVDjapIMJ5l0BRcLZj4EnCENrfzBwYWhMOPgk9N+AH
 rWD5z/R4NQ9MHGUiFxGDmz44F+Gw6ApJ8MZ/DuzBHHnhdeUE/fL8ONtRiWzaNJ3tIa5J
 JaxMQ+/9qdbJhbSLKlNgNZ3x0THz9h2uosGYb+vzP6DcCfRDze9J+MvSb9fZj3T9yQ7P
 TD/0Rxa5HKBFTSoonmxKRHHtebfNlQwAJ4v9JqNROv1Y7wJXnzP80/LRw/h2NnguQlMt
 4YbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707825716; x=1708430516;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gHL9nosvLBVU3E0iohtGPQO+kYcTEquxkRGU1DqD6Xg=;
 b=fsBPsB/pXydhw0qBPkfXDgN9r+ORU3q9HppgdWl2Uybg5rsY6KjD0KvQWIm+atTd9C
 kCQFevf5RyVKnOl/fJikP4KNolIC5fnoCLLYnAre/11tZUaiwoImKzZEBnOcnA0vL0yD
 Fb9P8rbMsagWSNRmuSPuV2C/XU1JD1g9gYnMxcPrl0b/BkDro9YpgACkHGgvQn6Eujme
 sscqeQKh+ZWWINGBhVC5yHRWyOiUOotrPydYeQhvmKVKZkdTY3ukVXJvNCfVp2DWZXyE
 MXlnENkFOfvqUjz0u3D3vknbXkbbEDoAuh/Z0SDJoIggCp+GkhHX8fOqC8xt6hm7xIsa
 xp/A==
X-Gm-Message-State: AOJu0YylduYoktDgheGBlmpq4kVsN0EiERlMAkePpqTeJzH239c3yJy4
 8VelxTICx9GwOvXciLEnATwY1HxBW4Wybogp1Ekr1wqf3XXPGRe2jmnZH0ZpndcOygTk/QPIPA3
 G
X-Google-Smtp-Source: AGHT+IGqUGKNbCfRcFtJsBpqvudD7CYvDnc3wvFtkLXz+JRHDpiugI2vU5HxmBzYYhtPS5CHSgKCWA==
X-Received: by 2002:adf:e883:0:b0:33b:649a:1aa7 with SMTP id
 d3-20020adfe883000000b0033b649a1aa7mr8130137wrm.49.1707825716072; 
 Tue, 13 Feb 2024 04:01:56 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWNSHV65KMWpsY0D9m/MVkK03U/Wuw8q9jdJvAMMwNzpZ9iDgBQ3V2YnhLCHJj4bYgowGCxpU0eeEZMxRNZKIrmj+5jQHYVNKbEcx65XJB3AaSZwyx3bhjXbnfinTftb1HtaGgzLFLd6V0obPilvhfYzeHT0SPMS7IzDprwlVkbZlnaqC1mQX3yzNatRQ+5GNKToU3ARzgkCH6RropBkkUQubllGhh4m6Xqct5ebi3reCFQ9aiahWqr2Xdjzk3oAEFRZTsPjR7UBiqSnDmLt+iIiCjKcSt3myxG5kYRzd75lgQ79Xpuc3aEE+U08hfNyAWnhRehZ3c=
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 v5-20020a5d59c5000000b0033b74a3dcf9sm8328903wry.27.2024.02.13.04.01.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 04:01:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/7] hw/i386: Cleanups around 'hw/i386/pc.h'
Date: Tue, 13 Feb 2024 13:01:45 +0100
Message-ID: <20240213120153.90930-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Trivial patches removing uses of "hw/i386/pc.h".

Philippe Mathieu-Daudé (7):
  target/i386/monitor: Remove unused 'hw/i386/pc.h' header
  hw/timer: Move HPET_INTCAP definition to "hpet.h"
  hw/isa/lpc_ich9: Remove unused 'hw/i386/pc.h'
  hw/i386/acpi: Declare pc_madt_cpu_entry() in 'acpi-common.h'
  hw/i386/port92: Add missing 'hw/isa/isa.h' header
  hw/acpi/cpu_hotplug: Include 'pci_device.h' instead of 'pci.h'
  hw/acpi/cpu_hotplug: Include 'x86.h' instead of 'pc.h'

 hw/i386/acpi-common.h   | 3 +++
 include/hw/i386/pc.h    | 6 ------
 include/hw/timer/hpet.h | 2 ++
 hw/acpi/cpu_hotplug.c   | 4 ++--
 hw/i386/acpi-common.c   | 1 -
 hw/i386/port92.c        | 1 +
 hw/isa/lpc_ich9.c       | 1 -
 hw/timer/hpet.c         | 1 -
 target/i386/monitor.c   | 1 -
 9 files changed, 8 insertions(+), 12 deletions(-)

-- 
2.41.0


