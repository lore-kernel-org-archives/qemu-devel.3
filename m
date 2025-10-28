Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11D8CCF9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 17:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDnbt-0006Wc-CM; Tue, 28 Oct 2025 13:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbY-0006PH-0f
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vDnbS-0004iL-0o
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 13:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761672924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vckpxkN+2zf9nWzTVhWzyRLceLbltJfnKA80OjaV7BM=;
 b=R8+sbI3M7Q42Fjhak2tzFQ9CDfLXtKud5wsb2YsOl5haQDG2cdElXwMG5RGW75ruGp15XO
 kS1Y0+ItBQLilD4IyCKyH6gBZwoca8s96OPUDxdiCSynEAKVnIlzXaSvEiRVdMW+Nj+DBj
 Adl0TveaTY4GyAhkPRxtENgHYyYp+XY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-4uFWKARoNTe802k6FG2ikQ-1; Tue, 28 Oct 2025 13:35:23 -0400
X-MC-Unique: 4uFWKARoNTe802k6FG2ikQ-1
X-Mimecast-MFC-AGG-ID: 4uFWKARoNTe802k6FG2ikQ_1761672922
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-40fd1b17d2bso4002105f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 10:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761672921; x=1762277721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vckpxkN+2zf9nWzTVhWzyRLceLbltJfnKA80OjaV7BM=;
 b=sAHWvj7NVy5dVMSsTlGs8vJlQ9Cnrxj5fzws3gDkQfIkGlunqhzA3yMtnMLznhOXsc
 QrtuamqZcH1vmMKC5IwZVcVfhrGOrecucCjPa0UoTXb1m1UVtOdcrjWOxSYqqZo1cm7i
 DoxulxGM1nKKLE2kapcMYvOu0+JVksrpJ9MTAWuy6Iqj4xWsNUcACEmNqdALGFzByTTs
 pOosC1pspLgWCN2+rl44LEO5sgD1dk4ldo1dzgBEn0ZHiMYxqgVxXwSzPRAkVlv9gAWl
 Zzdvn87EiWjUsdDlHNewJMkAyku0PIwSanBRM1G09wrUFuez4Yl9sAMsXLXCfDi18QQ4
 BWdw==
X-Gm-Message-State: AOJu0YxVPLfgodFZD9z3Nmp1b1WEjIKx6OY6xNS+QthYjtcwFbPCV6a5
 /SK6O46xDfMPkwwunwpzpcVztD6SHTIasdfrF5P4fm+u5RPGiaW9IoBXqGN1k3ooWsEv0ZY5png
 dC+MaRjGT+tP9C+N4zx0KYRY5sLrWAig9tiZYf5m9mfZfG5Lpz6g4YoszJGcQUmAlkOYWD2Y/u5
 y6aJMSmYoScYLZpftuW9kYAChNZM9TJftYQZ3X1YLS
X-Gm-Gg: ASbGnctcFD5r+w8RNznhjwtigEY1YbKsVplZ2Z82b91fRncDAcK1G0HEu7TVgnKc7qw
 GcSlP1Z1EnwpQQ6Rgmt3a7KouSUGtsHHxILWCd+yODu9MpHuuVsAMC4Qms5Zhq/3ETMMFDFQtMU
 l8GO1HYzjdl6haixwjBlfK/HZRwkTbEiC3C/2KBqcW79nOsFeIYgozDKHEC0VTpQa/TFB7/4CTI
 NHFOTiiOq/65k3wo/rE8RY3vjbF2qXuoZNKZbe8gPxCAFJPkytEN5+H3MC7+eDgRV8owzNEwuuY
 RNhch0pZ2yjThg+19dm8fONCKGa/9Snur9zvtA1HyZhCCyHyX9sjuwHfaXSii5XSCbaJ6CdgDEH
 xUXfRmUrN2TWs/8myoNphATe0b3Q8hL6eVWtYVOa1wRTNjpvMeEo77l2HK9x4wk0qQdN7yod/Qs
 diL3k=
X-Received: by 2002:a05:6000:40d9:b0:427:665:e37f with SMTP id
 ffacd0b85a97d-429a7e36fe9mr3264917f8f.4.1761672921248; 
 Tue, 28 Oct 2025 10:35:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuJV/fNDosLI+4kYLXYP/ZE26uMxFED1RZQ5mPP8w5izpO32yraFWNs2YnuN089f4CjQU2+w==
X-Received: by 2002:a05:6000:40d9:b0:427:665:e37f with SMTP id
 ffacd0b85a97d-429a7e36fe9mr3264897f8f.4.1761672920804; 
 Tue, 28 Oct 2025 10:35:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db80fsm21063326f8f.31.2025.10.28.10.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 10:35:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 16/18] docs/about/deprecated.rst: document isapc deprecation
 for modern x86 CPU models
Date: Tue, 28 Oct 2025 18:34:28 +0100
Message-ID: <20251028173430.2180057-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251028173430.2180057-1-pbonzini@redhat.com>
References: <20251028173430.2180057-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Add a new paragraph in the "Backwards compatibility" section documenting that
using modern x86 CPU models with the isapc machine is deprecated, and will be
rejected in a future release.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20251023142926.964718-3-mark.caveayland@nutanix.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/about/deprecated.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index dacf2882e44..020610132ff 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -544,6 +544,20 @@ available firmwares that are using the current (wrong) name.  The
 property is kept as is in 9.1, together with "riscv,delegation", to
 give more time for firmware developers to change their code.
 
+x86 "isapc" board use of modern x86 CPUs (since 10.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The "isapc" board represents a historical x86 ISA PC and is intended for
+older 32-bit x86 CPU models, defaulting to a 486 CPU model.  Previously it
+was possible (but non-sensical) to specify a more modern x86 CPU, including
+``-cpu host`` or ``-cpu max`` even if the features were incompatible with many
+of the intended guest OSs.
+
+If the user requests a modern x86 CPU model (i.e. not one of ``486``,
+``athlon``, ``kvm32``, ``pentium``, ``pentium2``, ``pentium3``or ``qemu32``)
+a warning will be displayed until a future QEMU version when such CPUs will
+be rejected.
+
 Migration
 ---------
 
-- 
2.51.1


