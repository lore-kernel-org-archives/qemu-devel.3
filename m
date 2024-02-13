Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB44C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 15:51:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZv35-0002FL-FJ; Tue, 13 Feb 2024 10:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv34-0002Eu-0O
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rZv32-0005MN-E7
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 10:50:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707839415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hgb4cLUJ/WaPsJRX7f/BWrZRCu0wheuaLMQU8qBBwKA=;
 b=cZwDBD2rrBuXUrz747jvhgdUppxSrDKWXTPqV8kZJKCfBProNA//y9mQld83kqasCg6B/L
 rXbb3Ue+wfg4m9i9u66zGKTRzWxDd3ayhHzWZ19MxvHVk3AnSI+AQREY91jS96b/Mi7/yo
 XvMs+2/71p5M1mpe6OOCZ8X2XE5rtog=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-QvfWfmfyO-669e25RRxhKQ-1; Tue, 13 Feb 2024 10:50:14 -0500
X-MC-Unique: QvfWfmfyO-669e25RRxhKQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-21a708d3dcaso1862962fac.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 07:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707839411; x=1708444211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hgb4cLUJ/WaPsJRX7f/BWrZRCu0wheuaLMQU8qBBwKA=;
 b=V8ihEg6TT0SI60mXyhzoVamUtyacALa4FFHnAElhQafdACRIJx5RPwIFEcKyQFrQPf
 BKr7YmE4sl8j4MWdR1JClaYPWSLwP/vqwuKM54cIvceAVdR8brGtfZuCe3XSqPBOxU6S
 IAmDi6etKymhOTNvKRbra+jmoX14VUhzWXq+luwiVzXUGUVFOiOZBvRw++VBEIzOJN6c
 iSLoc+vnUDCTeCtoCyZONuTafG7FRtGH4Eo8s46D4yLBtesFpEQOsOdglPHXazZPdaBi
 p4N+pbPxMlUClQlAgB/xZP3nSRezHadpfJ08XcRZHLPvhSQcXuCzW9wERvAsJ107y8ln
 +P+Q==
X-Gm-Message-State: AOJu0YzhjNn78J8xiwbSQxleUfyUqi62p6j5jkY3dkZet6ycrEuRmVMo
 adyrDE/gkZSbc+bm8I0htNjVF6ZJfegXXsleTVMuJCjJL9i5cKJr9FUb+UlLXkuAJv4hetqR5/C
 qDsjpFtznkzaon/eA1tlD99VYiaIvwxniVEFNvSEyZxMhjkj/iIMd/J48A/cxJHVQNaYz02Rbf/
 UQjedkN5b2XYxMjPVxrCbaZ59Kv7VA/e8sBYHK
X-Received: by 2002:a05:6870:b513:b0:21a:e4e:8e76 with SMTP id
 v19-20020a056870b51300b0021a0e4e8e76mr9916372oap.7.1707839410739; 
 Tue, 13 Feb 2024 07:50:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAHMox7rl4xmNVsMX64dXPKXARy9KEvNJ5v6m+Kb9k11/cWqVFITaZbEMHY97IVoB2JlyvmQ==
X-Received: by 2002:a05:6870:b513:b0:21a:e4e:8e76 with SMTP id
 v19-20020a056870b51300b0021a0e4e8e76mr9916347oap.7.1707839410387; 
 Tue, 13 Feb 2024 07:50:10 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUfY2buevvxI7ULG1Bme9TKYY55uQYcrN4+u8UC7iG2S+0VN7erNP6DSMFHoxZjFkGdLsWPTQr0xZr7jbAg4dwODGo0GYjd81UnoBytuyJ7E3n9FPXL
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05620a080900b00785b0827ee6sm3043702qks.22.2024.02.13.07.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 07:50:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	shentey@gmail.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 0/9] mips: do not list individual devices from configs/
Date: Tue, 13 Feb 2024 16:49:55 +0100
Message-ID: <20240213155005.109954-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Back when Kconfig was introduced, the individual dependencies for MIPS
boards were never added to hw/mips/Kconfig.  Do it now.

To simplify the task, include a couple cleanups to the SuperIO chip
configuration symbols, as well as a change that makes USB device
creation available even when building without default devices.

Tested by comparing old and new kconfigs; and also by building each of
the boards one by one, with default devices disabled, and checking that
the board can be started.

Paolo

v2->v3:
- add a comment in mipssim.c
- reimplement "mips: allow compiling out CONFIG_MIPS_ITU"
- extract patch 8 ("mips/loongson3_virt: do not require CONFIG_USB")

Bernhard Beschow (1):
  hw/mips/Kconfig: Remove ISA dependencies from MIPSsim board

Paolo Bonzini (8):
  usb: inline device creation functions
  isa: clean up Kconfig selections for ISA_SUPERIO
  isa: fix ISA_SUPERIO dependencies
  isa: specify instance_size in isa_superio_type_info
  isa: extract FDC37M81X to a separate file
  mips: allow compiling out CONFIG_MIPS_ITU
  mips/loongson3_virt: do not require CONFIG_USB
  mips: do not list individual devices from configs/

 configs/devices/mips-softmmu/common.mak      | 28 +++--------------
 configs/devices/mips64el-softmmu/default.mak |  3 --
 include/hw/usb.h                             | 27 +++++++++++++++--
 target/mips/tcg/translate.h                  |  1 +
 target/mips/tcg/sysemu_helper.h.inc          | 19 ++++++++----
 hw/isa/fdc37m81x-superio.c                   | 32 ++++++++++++++++++++
 hw/isa/isa-superio.c                         | 18 -----------
 hw/isa/smc37c669-superio.c                   |  1 -
 hw/mips/loongson3_virt.c                     |  5 +--
 hw/mips/mipssim.c                            |  7 +++--
 hw/usb/bus.c                                 | 23 --------------
 target/mips/tcg/sysemu/cp0_helper.c          |  8 +++++
 target/mips/tcg/translate.c                  | 10 ++++++
 .gitlab-ci.d/buildtest.yml                   |  2 +-
 hw/display/Kconfig                           |  2 +-
 hw/isa/Kconfig                               | 20 ++++++------
 hw/isa/meson.build                           |  1 +
 hw/mips/Kconfig                              | 25 ++++++++++++---
 18 files changed, 134 insertions(+), 98 deletions(-)
 create mode 100644 hw/isa/fdc37m81x-superio.c

-- 
2.43.0


