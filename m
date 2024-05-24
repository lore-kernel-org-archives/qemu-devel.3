Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BB7C25B7D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 08:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAQ0W-0004yj-Ts; Fri, 24 May 2024 04:10:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0R-0004vO-Sk
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sAQ0Q-0000Ig-45
 for qemu-devel@nongnu.org; Fri, 24 May 2024 04:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716538224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MQUSBxahO4caXfw1rwXX3slwtk6+QvbPiXtSyFycwsY=;
 b=VijmKjYOvnevAus7PCzK+DDNx4I1fyViBB7fuMwPXPl31ldwc2RAdZgUJzRt6L6eRur+CA
 ZyNN8z4sIw2mOFqxdU8Q0eUbKfGTvjCgIMuMwVhffBi8zpQNuQAj6lfaGV2w+Z3Dl4/hhJ
 w7Cc3MkrNSMpnGUkG3kBgDJaEBg7mV8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-HOsvN1loMwSPXOY__FLYmw-1; Fri, 24 May 2024 04:10:23 -0400
X-MC-Unique: HOsvN1loMwSPXOY__FLYmw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5234e83c4a6so1684346e87.0
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 01:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716538221; x=1717143021;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MQUSBxahO4caXfw1rwXX3slwtk6+QvbPiXtSyFycwsY=;
 b=s0wEvPMxD5Qc0YS/YHGGieuz9ztnpr5Ba8x6aph6GGs3RZ31OoO6L4El/Uw6QBnfIS
 cnJZ8fdBvOQ8Bwv67L3jlujOqsw8MEB4pCKWSNCGCPnuykX06dCOCaB3HcdPSYbV8ZTw
 k8oE2Br0VD1B5X+IdbhtZTTsRkEfKjWw4MQUmASnQs/doJp5j/DF10xJhKn+Aa3oXEm8
 Mq+7Kl+7bekRPU7ZoF5NHvmkVAhxwXDz1nLG1O1gn+GLe9reCw2AeQjhOkr9jxm/SYpI
 lkFt8yTiDANReeYa1o/e9QrfiCf1bXuX3R5/B5zAx5PzGqowa2gupXsGLGe7rHHT3g9W
 7DgQ==
X-Gm-Message-State: AOJu0YwxIslQAtemeFaMZfEHvdGv3KhVNHPj2dWQoVwz6alPygJ1mOkQ
 lm9EQv1+aC8BRBC+lH8QSBgD425aDKO95Nr1BJHZlzgTr8vHb8NIO4QR5CKrsRTgh+O2o6UsZA2
 6xoKIM9Y0ywYUzx+soPDa9s3VcoaeFEUo0SbFNxaJU9b2w0ZsHSKyxW7vr7Z4HS1hy6qEEegImY
 EzsENrLd0J7IErYS7imk7gx4leVXp/JOk3BgGE
X-Received: by 2002:a05:6512:3096:b0:523:87b6:2ac2 with SMTP id
 2adb3069b0e04-52965199527mr1015220e87.40.1716538221069; 
 Fri, 24 May 2024 01:10:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmFUCuymTe/CHIpKyc7HmONf/yQLaN04q9wKMxxoE74K4Fzf+zmknU1SgWZMpXPs573+eqNw==
X-Received: by 2002:a05:6512:3096:b0:523:87b6:2ac2 with SMTP id
 2adb3069b0e04-52965199527mr1015194e87.40.1716538220502; 
 Fri, 24 May 2024 01:10:20 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57861b4ddefsm2738a12.60.2024.05.24.01.10.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 01:10:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/16] target/i386/tcg: translation cleanups
Date: Fri, 24 May 2024 10:10:03 +0200
Message-ID: <20240524081019.1141359-1-pbonzini@redhat.com>
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

Some cleanups in translate.c, which I could make now that the
it's smaller and it's easier to understand how the various
utility functions are used.

1-7: cleanups for gen_eob

8-14: inlining and removing macros

15-16: cleanups for cc_op vs. helpers

Paolo

Paolo Bonzini (16):
  target/i386: remove unnecessary gen_update_cc_op before gen_eob*
  target/i386: cleanup eob handling of RSM
  target/i386: document and group DISAS_* constants
  target/i386: avoid calling gen_eob_syscall before tb_stop
  target/i386: avoid calling gen_eob_inhibit_irq before tb_stop
  target/i386: assert that gen_update_eip_cur and gen_update_eip_next
    are the same in tb_stop
  target/i386: raze the gen_eob* jungle
  target/i386: reg in gen_ldst_modrm is always OR_TMP0
  target/i386: split gen_ldst_modrm for load and store
  target/i386: inline gen_add_A0_ds_seg
  target/i386: use mo_stacksize more
  target/i386: introduce gen_lea_ss_ofs
  target/i386: clean up repeated string operations
  target/i386: remove aflag argument of gen_lea_v_seg
  target/i386: cpu_load_eflags already sets cc_op
  target/i386: set CC_OP in helpers if they want CC_OP_EFLAGS

 target/i386/ops_sse.h        |   8 +
 target/i386/tcg/fpu_helper.c |   2 +
 target/i386/tcg/int_helper.c |  13 +-
 target/i386/tcg/seg_helper.c |  16 +-
 target/i386/tcg/translate.c  | 322 +++++++++++++++--------------------
 target/i386/tcg/emit.c.inc   |  58 +++----
 6 files changed, 194 insertions(+), 225 deletions(-)

-- 
2.45.1


