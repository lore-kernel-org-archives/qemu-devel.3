Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E773BC25B78
	for <qemu-devel@archiver.kernel.org>; Sat, 25 May 2024 11:34:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sApel-0002FU-PS; Sat, 25 May 2024 07:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApej-0002EZ-Bt
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sApeg-0003wz-AP
 for qemu-devel@nongnu.org; Sat, 25 May 2024 07:33:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716636821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W7TRiVXtsRZ1XaZAi2VljzeffOb0HCD81TVOdmaBTlE=;
 b=BnAS+jhx4jttQA8E2apR7w+XkjZeRQaH8p/SqVw19jmwLGayAdHFDcSGFmLEYlDsb+N2aj
 R2eQOfk6injqo7rKASTr/UjXTMIoF/xkW8Z8j8Rvn4t2LEfhGne1hN7nOLPNFYSftewWL8
 njJqwyl+nLA8otEFbqnNHpfeTcN4M0g=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-160-vy7I2zrfOFqSNGw_58h20w-1; Sat, 25 May 2024 07:33:39 -0400
X-MC-Unique: vy7I2zrfOFqSNGw_58h20w-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a6266ffe72eso80912366b.1
 for <qemu-devel@nongnu.org>; Sat, 25 May 2024 04:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716636817; x=1717241617;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7TRiVXtsRZ1XaZAi2VljzeffOb0HCD81TVOdmaBTlE=;
 b=QykJMtOqfoOFiIbMhi7dpAzZ7OT7/ktoCwWLFClfgVOPG5iZxTf4LJVjrT06EIFQEj
 M1LWQEmL2ywN6Z3g5ZKJYCk4kli28IFpmRRUTxSAIyil2O44Eiwltm+MaXD+Df8Es4wg
 TiuJrhixlDAFFaGJopOWSiv79nrHlpakf73Kd4XL/fF+N1jxGZ8GMaFguvJGSF3uHc5Z
 iQlxm0z/rGjtc0zvw2Ug/CPAWdc1+p9REuSvkdI78wI3I/TSKbtlI6rF8BqX1pMqix3T
 2mXx2pTjMCd02VbvP2azdfLPtxSGSrTFxip2PdnFuNJlnsuKS6/5LYrADIr+oGCKHCmH
 ehww==
X-Gm-Message-State: AOJu0YzChUV4DkGXgAkmfAOUSZ1BFGDjZc/01yOOyL2qOqscZ7awyn1T
 tBcPBcaTFUW/9zuafq5Vn+JjbSMaNRWy+oDVO22NNgYoKuzG03M6uNEx2R3v1Wz7iytlkyTd41e
 ayQVCug8gcByaH6TEOGl+vfxwnPzZCZUWqN3eJmkOdVLB/4+jihNdeWl43vqMVydb6u7kXkjdZO
 qihGIi8wkzbqXNGlDemfhqJL1DWiqTHZa/N8ra
X-Received: by 2002:a17:906:79cd:b0:a5c:db60:903e with SMTP id
 a640c23a62f3a-a62642dccf3mr338679566b.37.1716636817206; 
 Sat, 25 May 2024 04:33:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS8l2EbjfXbt+zoV3HOTl67pEA8yTUrWVTyBw4FHVwrXANaiiln17meCwFVmXxdDUYOJ/SzQ==
X-Received: by 2002:a17:906:79cd:b0:a5c:db60:903e with SMTP id
 a640c23a62f3a-a62642dccf3mr338678466b.37.1716636816647; 
 Sat, 25 May 2024 04:33:36 -0700 (PDT)
Received: from [192.168.10.117] ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626cc8dcb2sm248185266b.173.2024.05.25.04.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 May 2024 04:33:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] Build system and target/i386/translate.c cleanups for
 2025-05-25
Date: Sat, 25 May 2024 13:33:08 +0200
Message-ID: <20240525113332.1404158-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:

  Merge tag 'pull-tcg-20240523' of https://gitlab.com/rth7680/qemu into staging (2024-05-23 09:47:40 -0700)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 70eb5fde05bdd051c087669ffcf2aee39e0c8170:

  migration: remove unnecessary zlib dependency (2024-05-25 13:28:02 +0200)

----------------------------------------------------------------
Build system and target/i386/translate.c cleanups

----------------------------------------------------------------
Artyom Kunakovsky (1):
      configure: move -mcx16 flag out of CPU_CFLAGS

Paolo Bonzini (23):
      target/i386: disable jmp_opt if EFLAGS.RF is 1
      target/i386: no single-step exception after MOV or POP SS
      target/i386: cleanup eob handling of RSM
      target/i386: remove unnecessary gen_update_cc_op before gen_eob*
      target/i386: cpu_load_eflags already sets cc_op
      target/i386: set CC_OP in helpers if they want CC_OP_EFLAGS
      target/i386: document and group DISAS_* constants
      target/i386: avoid calling gen_eob_syscall before tb_stop
      target/i386: avoid calling gen_eob_inhibit_irq before tb_stop
      target/i386: assert that gen_update_eip_cur and gen_update_eip_next are the same in tb_stop
      target/i386: raze the gen_eob* jungle
      target/i386: reg in gen_ldst_modrm is always OR_TMP0
      target/i386: split gen_ldst_modrm for load and store
      target/i386: inline gen_add_A0_ds_seg
      target/i386: use mo_stacksize more
      target/i386: introduce gen_lea_ss_ofs
      target/i386: clean up repeated string operations
      target/i386: remove aflag argument of gen_lea_v_seg
      meson: remove unnecessary reference to libm
      meson: remove unnecessary dependency
      tcg: include dependencies in static_library()
      meson: do not query modules before they are processed
      migration: remove unnecessary zlib dependency

 configure                    |   7 +-
 meson.build                  |   9 +-
 target/i386/ops_sse.h        |   8 ++
 migration/dirtyrate.c        |   1 -
 migration/qemu-file.c        |   1 -
 target/i386/tcg/fpu_helper.c |   2 +
 target/i386/tcg/int_helper.c |  13 +-
 target/i386/tcg/seg_helper.c |  16 +--
 target/i386/tcg/translate.c  | 326 +++++++++++++++++++------------------------
 target/i386/tcg/emit.c.inc   |  58 ++++----
 audio/meson.build            |   4 +-
 block/meson.build            |   4 +-
 migration/meson.build        |   2 +-
 tcg/meson.build              |   8 +-
 tests/qtest/meson.build      |   2 +-
 ui/meson.build               |   5 +-
 16 files changed, 218 insertions(+), 248 deletions(-)
-- 
2.45.1


