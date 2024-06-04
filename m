Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73885C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEORR-0002z8-9g; Tue, 04 Jun 2024 03:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORP-0002yU-Kt
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sEORN-0005a5-Vh
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:18:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717485521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j2Q6D9JPUfjrmD+mXpvg9+z9gfSpPmY0my6bb3YqFcY=;
 b=Sli6RggGT5/VZCUYkaWfdnNKKHGyzRCjTzpGjmbPsOLtH6nzBQrwBqMoJMOWOQPRPz0u6+
 vWSqMGX9jqxvxekhhE5nWRA3Crfhgp1+EXRgyEPIeH7GJY62v8FkKlPeOL71Oo7eR2BkaP
 aNrA81tnkaRlar6pSJMuTVg3NljFC6c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-JLO43MkQMC2BrJBgO-MxmA-1; Tue, 04 Jun 2024 03:18:39 -0400
X-MC-Unique: JLO43MkQMC2BrJBgO-MxmA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a79421a14so456591a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717485517; x=1718090317;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2Q6D9JPUfjrmD+mXpvg9+z9gfSpPmY0my6bb3YqFcY=;
 b=JfH26MqVss3LCRJ2AmnqLWwTD2StVtUP18HpMqcTHJHR8zk6z65Uv6cRO+eDuer9CT
 gq5t+AoAmDUtsLwm9MaQtIW7+vNXNNf9+JFI7jbaKLy67lm7mqDTbtnCMam4ZqWi8qD+
 +/hfsZNxLFhgMpoOqdx3rYk03HmXmimrb2Tbw10tfPxi8LVRh6kBlg+xHKl46wtSX1lv
 n3ySsQzf5vDFE3TB/lZ9G+56E61Fl+B0X9gPxoR2iIU/GO9XsObvt/Q+983rirnp9fMv
 k1tLWcRv++WLItKV9O5Aqa9H4zvi+1dliKLj40WN7AOu1w4ePzykYjv3Spze2xMf15TT
 cJTw==
X-Gm-Message-State: AOJu0YwPwtMk4mzpn1fizXUg2fnn5vw287WDTVO2toXeKO5QnWpRp9Oj
 fJ+uCssk0A/Ok/E1UEz11rpCqcrqP+Jc+XCud2Mel2PlWNGl4EB7UBQUgxeFbXbtXupTUjICgo8
 dW2FpaLE9LwB/RzDVt0WMHEdOkP9e2fDeHZ7oKtjA8r38km5R0uq7vmwQBp3BTv+M0w1zk+1MQA
 tazZACsLSEu4fyQTPsS7DFmj3u1czr8GyHmAJQ
X-Received: by 2002:a17:906:3b47:b0:a69:68db:6f39 with SMTP id
 a640c23a62f3a-a6968db7112mr35914766b.32.1717485516869; 
 Tue, 04 Jun 2024 00:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHk7TcXXrAmQ33rfiXi2rlewgRa4HiDzoDzI+EswbhYPXj8N004cAdf4x7bBSQ+y/Du7KI38w==
X-Received: by 2002:a17:906:3b47:b0:a69:68db:6f39 with SMTP id
 a640c23a62f3a-a6968db7112mr35913566b.32.1717485516364; 
 Tue, 04 Jun 2024 00:18:36 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68aa120a6esm475865866b.95.2024.06.04.00.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 00:18:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 00/11] target/i386: fixes for INHIBIT_IRQ, TF and RF
Date: Tue,  4 Jun 2024 09:18:22 +0200
Message-ID: <20240604071833.962574-1-pbonzini@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

While Richard pointed out that there _are_ good reasons to use
DISAS_NORETURN in the TCG x86 frontend, most instructions that
use it (VMRUN, HLT, MWAIT, PAUSE) are broken because they do
not do the work that gen_eob() does on INHIBIT_IRQ, EFLAGS.TF
and EFLAGS.RF.

This series tackles this, plus it has a few more fixes for
failures in kvm-unit-tests debug.flat and svm.flat.  Note that
neither of the two completely pass, but the situation is
improved a lot.  Comments are added when things are more
complicated and probably deserve their own series.

Paolo

Paolo Bonzini (11):
  target/i386: fix pushed value of EFLAGS.RF
  target/i386: fix implementation of ICEBP
  target/i386: cleanup HLT helpers
  target/i386: cleanup PAUSE helpers
  target/i386: implement DR7.GD
  target/i386: disable/enable breakpoints on vmentry/vmexit
  target/i386: fix INHIBIT_IRQ/TF/RF handling for VMRUN
  target/i386: fix INHIBIT_IRQ/TF/RF handling for PAUSE
  target/i386: fix TF/RF handling for HLT
  target/i386: document incorrect semantics of watchpoint following
    MOV/POP SS
  target/i386: document use of DISAS_NORETURN

 include/hw/core/tcg-cpu-ops.h        | 15 +++++-
 target/i386/helper.h                 |  5 +-
 target/i386/tcg/helper-tcg.h         |  6 ++-
 accel/tcg/cpu-exec.c                 |  7 ++-
 target/i386/tcg/bpt_helper.c         |  6 +++
 target/i386/tcg/excp_helper.c        | 20 ++++++++
 target/i386/tcg/misc_helper.c        | 14 ++----
 target/i386/tcg/seg_helper.c         | 49 +++++++++++++++++--
 target/i386/tcg/sysemu/bpt_helper.c  | 18 +++++++
 target/i386/tcg/sysemu/misc_helper.c | 17 ++-----
 target/i386/tcg/sysemu/seg_helper.c  | 18 +++++--
 target/i386/tcg/sysemu/svm_helper.c  | 71 +++++++++++++++++++---------
 target/i386/tcg/translate.c          | 37 +++++++++++++++
 target/i386/tcg/decode-new.c.inc     | 19 ++++++--
 target/i386/tcg/emit.c.inc           | 29 ++++++------
 15 files changed, 252 insertions(+), 79 deletions(-)

-- 
2.45.1


