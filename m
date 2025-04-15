Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939CBC369B8
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 08:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bRA-0002qu-47; Tue, 15 Apr 2025 04:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQH-0008QJ-D6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:38 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1u4bQE-00020s-R7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 04:13:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227c7e57da2so45835445ad.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1744704813; x=1745309613; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Vz+7rJLKk52J8xcxBS8V6jPxUUQa+S+ay0i6P14+Mmc=;
 b=CsOnYW+9E+MbAkaWV9CNizlXk0fPPvr7lbF/H2Kn7VAHG5cCoFCHp/lX2feVI3X7ih
 JSzkHZEjoU44UEW2eMyGpASyDwO89qopZTUajKyccVsmfN/qGexIhpCsntCkZP/0stiG
 XNGI9R4oejGlPw15KdObrhEg4zSK0vGSSXtJx2Gku7ETVaob1+BRa+iDs7Vf1nBKaxkb
 ua8GcxWCmhTf7IPPbTRhhcbaGwqfnRrF6V1oOvgVIHTHj0uq6ic7JaDUgb+vjwZ+QRsW
 r8pW/o5Q73DqhOEQaqmnahtz5Y4Ajes1AqmA2Z0nG9uAzhrud84rq3vFC9TeVf4Xm8Zy
 +AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744704813; x=1745309613;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vz+7rJLKk52J8xcxBS8V6jPxUUQa+S+ay0i6P14+Mmc=;
 b=GWeF1E/BOOgxS7Nxt1Py6jsGtxjtLpFgXyailmX86xalTXwGL8X4BOiWM6lzpPFVZk
 uJuZGavKkoX5yzUO38uoB1QrYph1+rV1BjeJQJeVqwl2ZTGqhaUiw86iQfOwnuhkke2F
 oknyZpJq0m9ZQByaGE7ZPvNsOZ67QROMmyksOp+xbeUEWa0/u2TjWkAgNOy3DPRUV18q
 BEIP3cgi8JJrWHeEC/TbiCOqHvRa/LekDfi8lQzZby9wxusRFd3GbIK6rWW954zPLWEr
 kMv1OlHXFCSWvyRJmnnkhGywk0FYYH5WPXl6pkWoY5qrKuwD8lSMlaE3J34W6iqLZlas
 Q5Zg==
X-Gm-Message-State: AOJu0Yyrn6x2FF+pAfsT1TrjvVjzxSRDM7pAxQh0ONUS6RH0rb4qXSOh
 QGRs/HrTPt1g4DDWNjqFsK3R7UwpH8NYVwwkIm+orAwkOcyDQj9MVr8NjHGcCiIznUPQYRLyd5P
 3RL5nYjoKRWI2uyF6A67ZBZXBzRAGf6eEQq62IVHUe5Bem2NZWB/nyidjauDK3/42XVpvL0B3il
 sVEZzyP4w3nzikEXRYltiFyHmqGG0nabWilyNC
X-Gm-Gg: ASbGnctQenl/tnm1Lscq86ZjDMGFnk3fDJQBqT7gA4dioxK0ksNs0deA1z+7tpIBMDU
 EdemrCHENntnIz0+q3rpxU6MPSvdeKBsFRqkuW29KsFSRkalu6O+ak/3tZB/vhzUZvas7H093Nv
 Xsgxf/VhIadwMmwPj5S9jN3ZnX9zsXPQHslKrQACTmDtOJx6Nve67PUiU6kaZsp/U2QIDYcaUY4
 FEABDcWheClC9kIJNhQaFX6VPEwFD051b2adwglMT8yltOVbu/fBXyk05fNgjTvT7upEPH580x6
 Ibi3Ywzb1UQatePIitmbtCxJX1UcuUJvAZr5mgoqkrFcCaA0G9f4usjcMC3pLgA=
X-Google-Smtp-Source: AGHT+IHHoPm4QQ9v0tOplwzjlpJQqhF8CoNoqXf2+aqmcGjlUFn1SmyfmdIGlkgop9tgFk3wJfZdHg==
X-Received: by 2002:a17:902:f707:b0:224:2175:b0cd with SMTP id
 d9443c01a7336-22bea4c3baamr220686105ad.26.1744704812581; 
 Tue, 15 Apr 2025 01:13:32 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c95cd1sm111082335ad.150.2025.04.15.01.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:13:32 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 08/17] target/riscv: Allow global WG config to set WG CPU
 callbacks
Date: Tue, 15 Apr 2025 16:12:22 +0800
Message-Id: <20250415081231.21186-9-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250415081231.21186-1-jim.shu@sifive.com>
References: <20250415081231.21186-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some WG CPU functions depend on global WG config (like num-of-world), so
we let the global WG config device to set callbacks of a RISC-V HART.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 target/riscv/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index ac50928b57..6dfc260a07 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -500,6 +500,10 @@ struct CPUArchState {
     target_ulong rnmip;
     uint64_t rnmi_irqvec;
     uint64_t rnmi_excpvec;
+
+    /* machine specific WorldGuard callback */
+    void (*wg_reset)(CPURISCVState *env);
+    void (*wid_to_mem_attrs)(MemTxAttrs *attrs, uint32_t wid);
 };
 
 /*
-- 
2.17.1


