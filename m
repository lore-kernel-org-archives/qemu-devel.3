Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824A6CA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 03:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC7i8-0001pG-Mt; Wed, 30 Sep 2026 23:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6S2-00063E-QT
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:14 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dingtaodtdt@gmail.com>)
 id 1xC6S0-0002Py-3V
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 22:23:14 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d90ba1d807so47025305ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 19:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790821391; x=1791426191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BhUe709SE/yREJSv4luWIhgYYagp305FisiQ5h0HuUs=;
 b=SmMQShdo9V23ihXKv08wvg8u6X7gY6UYaOUJUTYNZpfnffiNOb31gf44fpvO8tn7gW
 K1xMid2Dc71tr0K3MIK9IhQAvK0cwkghgo0fSCgnNLYGd1Bdb1zwjGHgtxQaUcviKys3
 1bvu7wPjZtqGWtId2u8LChURxsPDRYhrdee6D/5YgXGBckatVZkw7w1tCAD48CxhOjPd
 IniCuZ3txltWlGAb7uSRpAPj9YEtMVeC+qK8wdPgq1VsQkZxdPIs2lICVce6DrRiZHyN
 7jL8bPYzoUfqvkLdh2VO3f1pOl4dBrkMkSXAD0n9YI2iOA+EKGJY5dEH0NLAeYrR+24q
 jKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790821391; x=1791426191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BhUe709SE/yREJSv4luWIhgYYagp305FisiQ5h0HuUs=;
 b=CixdWJRO/cJVmPZ97J1eE7O4RlN3OOF+5cdsn/cuAW5ZLHeGhD7Uz+Ju8jgoXmkmtQ
 keXRdu0Fgb5U3OuagifzJitQBt1hU4KS6scbxpZopksaQZxrufjFzPKSnKO9GWMkswNV
 Iuvckgq/ZfEnCX7xc55h/aqY6J3lnI1ijboSxVOjjsadjzPcRBvz65gRaglmd7Cf9caP
 3yjUcvGiqfe7UImw4NedfHRFcnj/AWP+MdzkK0Xl6nSPbq9+u0SojvQGSieuadsK1lFX
 SKjGBfeE8TY5QpNLlheyW/0d9Okpdw0TR4of/VlOBu/VeQkd7D6T2r/jwhXCqmAnZWdE
 NhRQ==
X-Gm-Message-State: AFq9FYLcbcLVt0MF5A/s2LycTIqGstjpfMX3mHJh94yE8AlUelb64y6g
 nV/BKLmHbVwfiuB4NCs9+F0yTfU41+rqVh8YzS1Y81NfqlqFGL613tr0oODhd5nKjuI=
X-Gm-Gg: AYBFou2e2i9NGvEnJAl3MmCvMBeou4rHmfEi7zsAJ5wV/Z5cGqkqg9mBOXznqf2GJKC
 XS7ko2Rg0QUlelcpAIfRd1DwRhp+m5jz6ma6tCvFK6hgX7f2muFXz/jzDbN9swyDXRksh3Y9VmQ
 oPG4z82Glema02gifWqmqx6W5Cr/YC6TsEw5hkfVQsYcvmzcBup7xLDelhyka8P+uLAzI/yM8oW
 ABQzr+K6Uo2fNznZ2iFKsNfdnWx+l1Bgcg6q43jkm2hW+LoK2YET/Q7q7p8MCTzjA7NzHG8lb+b
 Z6jjrwYN0HWCbUDKLa26EeI+966FvWz9GzcHp28QXD+EPHLtW3CfeVIdWSTmUxa/e5AsZ2uZJng
 EOSmhTU67OC5XGH8wpCal15HSBMb3kRc/JrDtFWND5IolClB9uzQjJt3kcBndkZiBIoSNi5twmu
 7IgQmqWLeaD1LM1tS3raEvogiQc6IhDAXHjcAPHgTqrFlCr4XkFj8cLQ4K1pX/IV0LsZQIKZecr
 XG/3JHupfjcm+EqOA+kpUvoDQ4=
X-Received: by 2002:a17:903:2283:b0:2dd:c100:a5de with SMTP id
 d9443c01a7336-2e2e4b9ea03mr26256215ad.50.1790821390656; 
 Wed, 30 Sep 2026 19:23:10 -0700 (PDT)
Received: from dt-VM.localdomain ([175.152.37.254])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e300b8fd4csm3943635ad.80.2026.09.30.19.23.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 19:23:10 -0700 (PDT)
From: Tao Ding <dingtaodtdt@gmail.com>
X-Google-Original-From: Tao Ding <dingtao0430@163.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, chao.liu@processmission.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, Tao Ding <dingtao0430@163.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH 1/3] hw/misc: fix k230_decomp_gzip integer handling issues
Date: Thu,  1 Oct 2026 10:22:21 +0800
Message-ID: <20261001022223.8633-2-dingtao0430@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001022223.8633-1-dingtao0430@163.com>
References: <20261001022223.8633-1-dingtao0430@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=dingtaodtdt@gmail.com; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 30 Sep 2026 23:43:53 -0400
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

Use hwaddr for address calculations to avoid 32-bit overflow and
address truncation.

Resolves: Coverity CID 1685515, 1685517

Reported-by: Alistair Francis <Alistair.Francis@wdc.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
---
 hw/misc/k230_decomp_gzip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/k230_decomp_gzip.c b/hw/misc/k230_decomp_gzip.c
index 0d8a3b2d2e..54303c0e7f 100644
--- a/hw/misc/k230_decomp_gzip.c
+++ b/hw/misc/k230_decomp_gzip.c
@@ -53,13 +53,13 @@ static bool k230_decomp_gzip_write_mem(K230DecompGzipState *s, hwaddr addr,
 static hwaddr k230_decomp_gzip_output_addr(K230DecompGzipState *s)
 {
     return K230_DECOMP_GZIP_SRAM_OUT_BASE +
-           s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+           (hwaddr) s->output.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            s->output.current_offset;
 }
 
 static hwaddr k230_decomp_gzip_input_addr(K230DecompGzipState *s)
 {
-    return s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
+    return (hwaddr) s->input.slot * K230_DECOMP_GZIP_BLOCK_SIZE +
            K230_DECOMP_GZIP_SRAM_IN_BASE;
 }
 
@@ -102,7 +102,7 @@ static void k230_decomp_gzip_finish(K230DecompGzipState *s, bool crc_ok)
 }
 
 static bool k230_decomp_gzip_load_input(K230DecompGzipState *s,
-                                        uint32_t addr, uint32_t size)
+                                        hwaddr addr, uint32_t size)
 {
     s->input.current_offset = 0;
 
-- 
2.43.0


