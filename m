Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F70C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 11:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKo4-0001Vx-Ma; Tue, 20 May 2025 07:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKny-0001An-Ke
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKnw-0003JZ-Tv
 for qemu-devel@nongnu.org; Tue, 20 May 2025 07:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747739200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vI4DnVjNkhsHegIRh504HY8E3e3XL3fmDWImMxQ9guA=;
 b=h4cfOo0yvJ/FXqvj4XihpJcEqhYjFKVKYqoFKtlPGmsvx8YbJkU9Nd4i2AezuWjOe3U8Y8
 U0d4JOw6gGBbpcTLcMdnJOmKdPOyx+DTXPmnAr68XkQkcMpRm1ao5Gu/9AbUOzwdD7dpcZ
 nwcYZCV6RmDNZzRotR1XdJQbITx2F2k=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-DudTQ1HtMZufkiprzKPkzA-1; Tue, 20 May 2025 07:06:37 -0400
X-MC-Unique: DudTQ1HtMZufkiprzKPkzA-1
X-Mimecast-MFC-AGG-ID: DudTQ1HtMZufkiprzKPkzA_1747739197
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-601f918c628so1933236a12.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 04:06:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747739195; x=1748343995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vI4DnVjNkhsHegIRh504HY8E3e3XL3fmDWImMxQ9guA=;
 b=Dk02hkUChCqgqPfzTB2pMpC78RwORn3P/w84641iTvkf3I6r/78Iod4CQ6lqmQFB0u
 QG2t8VTsWzgNs+xZ/HQn3zNqZraQZxXjwRYc7RVKDnhhAWdnDknPH8Ryud93+mntHzlK
 gWhFWqmLm/IWZEX9CLwmTpGoFKwZtdjyOHzlHeq4xJv+KgYMAG6b3fW9W66ID3TMHwCc
 HJCK2cL6bzef5lA1BcFtuU2STFCVaUsLjfgtKEgeYFuwEgbmFD15YLxXC09ipCSPizKj
 7MhHss0l5+BlKSB/M8nVZ/cem0rQRad8nlkaSAZS3wRV+bqgssMJSY2NalQj3fliAf/A
 ERiw==
X-Gm-Message-State: AOJu0YzvqetDLmh9ViRTHkNEF0Jc8ORMal9f8tATRSmjnf+OToEj70Zp
 KzBNPzo5kFFHrhiF9Yc1jrdCAYuiHJvmv06llC4XDavJrGw1I5kNMBF6M7TOOH8+yAakz28CdMi
 3MUshcjw0peoJwN0WhwE+L4PusH5zZt8c+sJ6iZwrQJT1MNzJOAuCXD1DaFWw+fE4mhG3I7xlgU
 xQ69dwrXVnOV+ked5KZux0SQPJB/Hbn/+6u6mcHKYb
X-Gm-Gg: ASbGnctXtmP+te5EnG6R1zchbShyrvnGC+s5bU72PfHdZBT7rDtYnjHTovYa9UHt33K
 lAOkL0I9YwSLvw/3vcZftNjKP5WxzFohSH5Vfh5exTLjpMA4HjDLV+haOJjXo+9oG9NnV4Wvpxr
 8MtdNzSqvADAnJe+AVeKg5kccuL2jLT4J0l73t0RlncVX0wMHrGMq8YvTLTmescmj/3Y7ftQIZo
 wmSiYK4KwXtC2Z3unyrtg076HgJOJGJq2Wjzgspzo9B+FVzDffHG3BIb7MmYMpVmtB2ssG8m0B4
 8N26a2aGh/tV2w==
X-Received: by 2002:a05:6402:520f:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-60114088719mr12589620a12.12.1747739195450; 
 Tue, 20 May 2025 04:06:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGQaUpDWbzrYSsRJHvQHkHpTLD/3Qu8vlVNid6J0mL9p8Hk95pdkj3ugJi1ucDuzjtI0y7ag==
X-Received: by 2002:a05:6402:520f:b0:5fe:7b09:9e27 with SMTP id
 4fb4d7f45d1cf-60114088719mr12589594a12.12.1747739194968; 
 Tue, 20 May 2025 04:06:34 -0700 (PDT)
Received: from [192.168.122.1] ([151.95.46.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6005ae3940fsm6978321a12.74.2025.05.20.04.06.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 04:06:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 28/35] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Tue, 20 May 2025 13:05:23 +0200
Message-ID: <20250520110530.366202-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520110530.366202-1-pbonzini@redhat.com>
References: <20250520110530.366202-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..969a9fe3c80 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -29,7 +29,7 @@
 
 typedef struct {
     int csrno;
-    int (*insertion_test)(RISCVCPU *cpu);
+    bool (*insertion_test)(RISCVCPU *cpu);
     riscv_csr_operations csr_ops;
 } riscv_csr;
 
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.49.0


