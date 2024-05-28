Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CBEC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 02:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBmr3-0007dy-4B; Mon, 27 May 2024 22:46:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmq5-0005qo-Er; Mon, 27 May 2024 22:45:28 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBmq3-00042x-Oj; Mon, 27 May 2024 22:45:25 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1f48bd643a0so2797845ad.3; 
 Mon, 27 May 2024 19:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716864322; x=1717469122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=okL/u9Yr4I1gdpYP+OUmz0dGlxU1P8AIMDXGmwEB0cY=;
 b=VV4PA+A1kGIf0qvLu82f0he8KlTL+MtyggCi4Voztj7CFQAymbYBP1JZVbd1XG0j+G
 loamb9dHfb6LLQeS0+hEbpGBUX0PUwDBXegsuZU84C6AZLQWroJO3vbXrgJCyOTXjDsx
 2rkUigr0K1nzdjaor6btO15f8J15ZwHVvqnsQkeO+M62yKlVb4VrrfWn1cm2Szo5nls6
 jkUk4/iLhf4SUJT/9A/8dcvvjMVu7kKtYKt/nzOEV6AOnEYqlJka1lhxzJ44hklP954z
 rp2OONjz5IH1KefodLlkKHn+ntUjYPiUdPfbecKlTkHGRXddEv6521YWrbzPmr48tKYP
 mseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716864322; x=1717469122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=okL/u9Yr4I1gdpYP+OUmz0dGlxU1P8AIMDXGmwEB0cY=;
 b=Hdjfo+v/9bBQCniDIKddFYWSoI+FqlLxF9cZe9Qn8MK1HjNPs7KGbu9spbDtXuMwCn
 MyfRzg8hG/pERaOiXO/DmnvDrFydEnbkbIuJum0uA84co8a67mw6mhZpPvUBrZtUlQkM
 v8FFm4T5DDXclTgMLod2SyzfbZPxDxc52pYQNYQdQWFYIELmmPvHxTOkBJDWGSS2l6VV
 cOnqG8i2PcVdw8lAP+7kpQSHfd+2swUWoEtlaM0rnB94rfkUbPvl4qwitfpV8AufrpG6
 AhMAWrtpOyuKOANE5UziQzG66fzwsyrvYHWlPwpAbO66NH8xbBrzkcVtOhEIxItQY9Ut
 Ocqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw5IXu/8Iwwzt1J4mW71M9fq+00waG04pv7qmNvdeKgT1iaXGK+LcOhPH9RJzTlvjCjtBD0PDLpxHZSFYNQB6KmGu0Sdsj
X-Gm-Message-State: AOJu0Ywp6H7iygOKhnAME9rx5IPAHbL7g9k3Ch+klIVlzUyceCLgvaX3
 Vm03fT6LjdQsCfCEUPKQzSIkrcyuC4Gcbu46VRdjHrxgoEAZCVDp0RhTsw==
X-Google-Smtp-Source: AGHT+IGk18WLY6sPTaDfBrZsmGrDkLA+eHUSZI9mH1XG/bLQa+ZavDBolfSnVhKoh5pr0aNuDe7b2A==
X-Received: by 2002:a17:902:7847:b0:1f4:9e85:9d4f with SMTP id
 d9443c01a7336-1f49e85a120mr38295485ad.11.1716864321680; 
 Mon, 27 May 2024 19:45:21 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c970ca0sm70733225ad.142.2024.05.27.19.45.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 May 2024 19:45:20 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Yong-Xuan Wang <yongxuan.wang@sifive.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 qemu-stable <qemu-stable@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 25/28] target/riscv/kvm.c: Fix the hart bit setting of AIA
Date: Tue, 28 May 2024 12:43:25 +1000
Message-ID: <20240528024328.246965-26-alistair.francis@wdc.com>
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

From: Yong-Xuan Wang <yongxuan.wang@sifive.com>

In AIA spec, each hart (or each hart within a group) has a unique hart
number to locate the memory pages of interrupt files in the address
space. The number of bits required to represent any hart number is equal
to ceil(log2(hmax + 1)), where hmax is the largest hart number among
groups.

However, if the largest hart number among groups is a power of 2, QEMU
will pass an inaccurate hart-index-bit setting to Linux. For example, when
the guest OS has 4 harts, only ceil(log2(3 + 1)) = 2 bits are sufficient
to represent 4 harts, but we passes 3 to Linux. The code needs to be
updated to ensure accurate hart-index-bit settings.

Additionally, a Linux patch[1] is necessary to correctly recover the hart
index when the guest OS has only 1 hart, where the hart-index-bit is 0.

[1] https://lore.kernel.org/lkml/20240415064905.25184-1-yongxuan.wang@sifive.com/t/

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Message-ID: <20240515091129.28116-1-yongxuan.wang@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/kvm/kvm-cpu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 473416649f..235e2cdaca 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1777,7 +1777,14 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
         }
     }
 
-    hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+
+    if (max_hart_per_socket > 1) {
+        max_hart_per_socket--;
+        hart_bits = find_last_bit(&max_hart_per_socket, BITS_PER_LONG) + 1;
+    } else {
+        hart_bits = 0;
+    }
+
     ret = kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
                             KVM_DEV_RISCV_AIA_CONFIG_HART_BITS,
                             &hart_bits, true, NULL);
-- 
2.45.1


