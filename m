Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33675C27C55
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 08:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFrXN-0000bO-FW; Sat, 08 Jun 2024 04:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXM-0000aO-11
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sFrXJ-0008Jd-U2
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717835692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hmcO4ui07BBe0FjQAMjYfYJsiVn0613DcSvAYmLll7I=;
 b=CK8iOx6O8oyA696JRJBB4TSnCtWyYTb5TFunvx+FVw0CZ88Srs4MWGC6g00h2q91wa9A98
 +AZyjHsGNd8kwRko3eFauSNwv78n4+ImIsxzM22bc7fAI+kMErDe5+gkgR3gs0wR1X9sQJ
 BHghOMNGHKuwqDeXVLHFaPG7gX0Ig9I=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-74qkEVO2Oua9ezYZX6Ndsw-1; Sat, 08 Jun 2024 04:34:50 -0400
X-MC-Unique: 74qkEVO2Oua9ezYZX6Ndsw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a68ce1ac733so157346766b.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 01:34:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717835688; x=1718440488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hmcO4ui07BBe0FjQAMjYfYJsiVn0613DcSvAYmLll7I=;
 b=rD1tt3CYk/sI12CPdEfQRbAB8O+wqigLg/UmUoCSOv/dFj6MW/An3z7eWEEv1QRkN4
 WcVVxTGhcEx00OUzesvfQfT87nv1wgg/DfqzqV/bzOj8C80I5wHw389xYgWwE5TemmEI
 sGiSSDegMritwbHesbdmDVHVtxVLZrSTDn84CwEVo/LljJ2v8dxSOiFK594SSB0h18GO
 8fEAhu4P+SgEFPC9asJEIB7yGrAlV2HziXvmozVafOQ3qN8wVo68+QRyWed5tztop5Nb
 PS+QDWdFPJ9LIW0bNzOxfRTPPwpRkvoPj4vw/Qhyly/carO4nvdWAvEPL2BAAa0+FnGV
 Fa7g==
X-Gm-Message-State: AOJu0YxF+zTn9HkkTinlooH5caA5xX6AUsLyF5r+RPKnyG34i2Av4Fm+
 /nG+zLj2yUsP+VPeTuF9iQb534FisQy/lNLQJQ66mHu4tHesfGYnUuO5OEgPvhi1eFbd47I7FgC
 2uvwtPCA0Z1JW+YPKjfPZ8XPBtMW8GpyHwnnNqBcbHsEfU5Jlwx5GuhSgkg82VSMjvUaq5q+g5f
 /gRlqsl3GtFCFBgzsS+f6QTWd+pqDENVaRrUQ7
X-Received: by 2002:a17:906:f742:b0:a68:b49e:4745 with SMTP id
 a640c23a62f3a-a6cdbef6d8dmr273109766b.70.1717835688144; 
 Sat, 08 Jun 2024 01:34:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEPa7RYijpa/WocvgDhfniJp16vtj4hguk1LHXTYK8SoJhfAAZM4tO64oiPc4oEjPXpANAYg==
X-Received: by 2002:a17:906:f742:b0:a68:b49e:4745 with SMTP id
 a640c23a62f3a-a6cdbef6d8dmr273108366b.70.1717835687719; 
 Sat, 08 Jun 2024 01:34:47 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cb0easm354917566b.62.2024.06.08.01.34.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 01:34:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 11/42] target/i386: document use of DISAS_NORETURN
Date: Sat,  8 Jun 2024 10:33:44 +0200
Message-ID: <20240608083415.2769160-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608083415.2769160-1-pbonzini@redhat.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
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

DISAS_NORETURN suppresses the work normally done by gen_eob(), and therefore
must be used in special cases only.  Document them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a9c6424c7df..2b6f67be40b 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -4761,6 +4761,17 @@ static void i386_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
 
     switch (dc->base.is_jmp) {
     case DISAS_NORETURN:
+        /*
+         * Most instructions should not use DISAS_NORETURN, as that suppresses
+         * the handling of hflags normally done by gen_eob().  We can
+         * get here:
+         * - for exception and interrupts
+         * - for jump optimization (which is disabled by INHIBIT_IRQ/RF/TF)
+         * - for VMRUN because RF/TF handling for the host is done after vmexit,
+         *   and INHIBIT_IRQ is loaded from the VMCB
+         * - for HLT/PAUSE/MWAIT to exit the main loop with specific EXCP_* values;
+         *   the helpers handle themselves the tasks normally done by gen_eob().
+         */
         break;
     case DISAS_TOO_MANY:
         gen_update_cc_op(dc);
-- 
2.45.1


