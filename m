Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B48C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmpo-00058u-7j; Mon, 27 May 2024 22:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpl-0004wX-FS; Mon, 27 May 2024 22:45:05 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmpj-0003pH-N2; Mon, 27 May 2024 22:45:05 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f449f09476so20389285ad.1; 
 Mon, 27 May 2024 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864301; x=1717469101; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJgBJ0EmldlUzQtT/aivgrSis6Y1lAdujHeTStRACnA=;
 b=gwyg9vjLrV21ag4JK7GHCRYS+SUAIxGzrDpXOCqEH1q3kW+snvA+VHi4Ltd140b4CK
 xtjaoMi6y0Ruhp4pUvrvvHj9SOxYeTDzhtmS1m1OUmT4EpQb20fnKQfmknBILlXDzewr
 KRawTQgTcWTglf7U5bU8BfoIC9+1PPsN9TVlwpIFLBbegrkodhVPEHqDVBJM/aQ8auAv
 9+xcN1qjo24CRJElgUWLooNbRPzOfs/SImvSqUbZKf6ULx+Iey00x+N1iQ+DB/6dpoIW
 cZJvyVvsc7/iHLKOm7csqimS8SLdl8c+Abe8cME+GPrhq/a+rY8mFR1LU57jSqp+M1H2
 x/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864301; x=1717469101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJgBJ0EmldlUzQtT/aivgrSis6Y1lAdujHeTStRACnA=;
 b=crXiwPcjrsRzZ90vT5F5AIOjCInD47znjWopTgwXwDfIPSl8ch90uE6hbyUtikORHd
 HzWXppMeko353KSZODIVujALHIyJ3EeGzW4F46A6KLyNZQQXTd+P0LpKtC0vR9L6PZGJ
 h1hmSxQT1S8crXLwI2ogLogN9Njbssgv5UNZU5LxLEV7gdP1/L2RAcIdeDeBhLb8xfDJ
 tLHVdrXyWJEtzGdtaDyfAxBpr+U+WO5C8Asi9derIFzXftqvXvAS7ffsaeRSPvQ0U3vP
 MUm3kRPqm6ZbHIxLCSbTHLbJ5VZS+KCKpkfzDQNecCrOwbqDOFQi+GvaH4WM3SpgbDx2
 QA/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLTlgpWcid9JR6itPEGqTTuoGa1M2qxPY87PKWc2FmHTYKvRyMs01MHBGw5AX4h7vXRHBgxEvKw37I/jlWjLJjeY+7CpLp
X-Gm-Message-State: AOJu0YwLHqPLAB/2CLlpokGFtOkLxL5WovnEaTHfZ+vHEXhnbjmc6QMy
 LFDETcF/sx+EBA37LJHggu4ruDj4AqVelcEYkl3rtFZ/r+/iLY6tbkDJXg==
X-Google-Smtp-Source: AGHT+IHn60gsBnT6ZIzzdaop9U7RdNHhltTiCjMjytUlyRyn1NxFBRotBfWuzYR3/fp7ZVjGf7ZI4Q==
X-Received: by 2002:a17:903:2445:b0:1eb:5222:7b8e with SMTP id
 d9443c01a7336-1f448160c7amr159536825ad.17.1716864301376; 
 Mon, 27 May 2024 19:45:01 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:00 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Max Chou <max.chou@sifive.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/28] target/riscv: rvv: Check single width operator for
 vfncvt.rod.f.f.w
Date: Tue, 28 May 2024 12:43:19 +1000
Message-ID: <20240528024328.246965-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528024328.246965-1-alistair.francis@wdc.com>
References: <20240528024328.246965-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Max Chou <max.chou@sifive.com>

The opfv_narrow_check needs to check the single width float operator by
require_rvf.

Signed-off-by: Max Chou <max.chou@sifive.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240322092600.1198921-4-max.chou@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index a7217aed4e..c3af38af80 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -2817,6 +2817,7 @@ static bool opffv_narrow_check(DisasContext *s, arg_rmr *a)
 static bool opffv_rod_narrow_check(DisasContext *s, arg_rmr *a)
 {
     return opfv_narrow_check(s, a) &&
+           require_rvf(s) &&
            require_scale_rvf(s) &&
            (s->sew != MO_8);
 }
-- 
2.45.1


