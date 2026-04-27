Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A583AFF8864
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 23:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHVJ0-0000zM-Q4; Mon, 27 Apr 2026 19:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHVIu-0000xU-2V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 19:23:52 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1wHVIs-0004sx-1y
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 19:23:51 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-2d9916deb14so19059567eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777332228; x=1777937028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TGl0BbXkGtFoRsQ7y9Jn4eXyp2q/oJa3u0gZmZMsmiA=;
 b=kT34BOMfChisBDkBfJ1F954yfrSEVXggkCz2IZqAEhaREbNsjJ0aqnoIFm59ijKp/G
 TD1dCncLrl+6TUcZWyCUldgm2qIJ0FusfFrL86M7p2jme/PgKykh7c4/ubTEiakoOZ24
 dkZYhZY56ngQ/yWu5EJ+ONzfx6+b/QxBy9psDuOBbBKUS/oPbP9pyhzl9p3PjJu7vnds
 ifhpVwWA1Fdl1n2ij6eG9/14wr2E/wjusUBTM/s0b/1hiXZs0nFzvzuDlStutaTzD2KI
 V8FoiWT3HHOxVpZ7CSCK2o2nrOOzYL9Ai7GRVI9BgqmSBzPgENqiZBjhapKBgSJgvR98
 I1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777332228; x=1777937028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TGl0BbXkGtFoRsQ7y9Jn4eXyp2q/oJa3u0gZmZMsmiA=;
 b=pxQ1K1N2raZW8yuzrooofOxH5PELgFByy/pQmxQKJ2ukWA98dlCtqMiNSufaMm1Igm
 HB4KEQfn6tELHVdiJonfl9M+5EIY7iYrBxiXsHPC4w7OAKVOiuQd4XLE1zfDsGFf8ahz
 UlrvhiklQtotjsqk5NU7MTpA/5UizQzLtoa4t59NLH0D8+98v5MGHfY7uTb6VGUBPbyh
 VqmdHrsP8UPqH4qp6uHyXZyvSVkjM+lM78UovwTvHXMf1VILadEkZlcL/7luKQ/7XJ7W
 0RkOItcTgOZt9U1TDSHaaRPfmKZsjZ2pOqqXU+jVZW4JfW4KTN/ttpNhO7G6tQF/ZJ/c
 /dfg==
X-Gm-Message-State: AOJu0YxCj+zDYt8ukiJE0ihnUG7RfW+tYDlJtY7iF0/B6vgBZvAf8Dsa
 zW9LA1UZr/6pgI0uSQH35oWNhoHkAuRkKLa4OyBZP5V/flBVCoQ+ndYYinRgifGvgVY=
X-Gm-Gg: AeBDievEsQY0aB75aF4Y09YZccrPmq0n+xg0LdKOLIyMHRYf2Vx8lFhFOTu2vc3VfXu
 p2MDoywYIlHggCRwIMtA9dw4BUqvPZbzcS2dNqVxNorBbYamIL0LO+inWGx1caSQEzY8WHmCKwb
 K8dpwOxfgg6td+zSFYhAx1yQT+DLUdvQ3a6sg1VqsveJri6iZ4U2c0z5OY872nvSYDdk7i56nsy
 rbpgwoo+KHtkdnVF0UU5ZZinqcZlN3ngByTMacAceOd6AHdWD1C4QQfWMGRjW3WOgg0ullCtIRA
 qAYuYSfRXfCcF47CFEixAfCiJBm9RROwf2JSKRbtPbYxeEzzmuH0iKfFxZTAhWwY78ayRaXrZA+
 rhmrYu0h35H0dqLaT+Wgf61uKV2UJWTmviZiQNf5GPGAPsvmq+WBIS3SpR0RX8KaPG2tCvV0UHV
 jYfW0SB8pJ624+y2VqAM7RW/gPnQYf1AllL0ZegiihHof7QL8ujYeuF+bdBVszuWeY497XQUcXY
 kCXPOe151EpelKXmofJ1zE454XeIWOPyLLJEw==
X-Received: by 2002:a05:7301:30b:b0:2ed:e17:d510 with SMTP id
 5a478bee46e88-2ed0e17d6fbmr18710eec.35.1777332227823; 
 Mon, 27 Apr 2026 16:23:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:f4a5:bd04:3ca7:5727])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed0a0ce710sm849973eec.19.2026.04.27.16.23.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 16:23:47 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [PATCH 2/2] target/arm/hvf: Stop pre-allocating cpreg_vmstate arrays
Date: Mon, 27 Apr 2026 16:21:16 -0700
Message-ID: <20260427232116.50586-3-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260427232116.50586-1-scottjgo@gmail.com>
References: <20260427232116.50586-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

Commit ab2ddc7b66 ("target/arm/machine: Use VMSTATE_VARRAY_INT32_ALLOC
for cpreg arrays") moved cpreg_vmstate_indexes / cpreg_vmstate_values
to be allocated by VMSTATE_VARRAY_INT32_ALLOC and added an assertion
in cpu_pre_load() that they are NULL on entry. The same commit dropped
the redundant g_renew()/array_len assignments from the kvm, whpx and
helper.c cpu init paths, but the hvf cpu init path still pre-allocates
them.

The result is that loading a snapshot or migration stream into an HVF
guest immediately aborts:

    ERROR:target/arm/machine.c:1043:cpu_pre_load:
        assertion failed: (!cpu->cpreg_vmstate_indexes)

Drop the leftover cpreg_vmstate_indexes / cpreg_vmstate_values
allocations and the cpreg_vmstate_array_len assignment from
hvf_arch_init_vcpu(), matching what was already done for the other
arm accelerators.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 target/arm/hvf/hvf.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index a36c634423..fe7dc9448d 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1284,12 +1284,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                                      sregs_match_len);
     arm_cpu->cpreg_values = g_renew(uint64_t, arm_cpu->cpreg_values,
                                     sregs_match_len);
-    arm_cpu->cpreg_vmstate_indexes = g_renew(uint64_t,
-                                             arm_cpu->cpreg_vmstate_indexes,
-                                             sregs_match_len);
-    arm_cpu->cpreg_vmstate_values = g_renew(uint64_t,
-                                            arm_cpu->cpreg_vmstate_values,
-                                            sregs_match_len);
 
     memset(arm_cpu->cpreg_values, 0, sregs_match_len * sizeof(uint64_t));
 
@@ -1326,7 +1320,6 @@ int hvf_arch_init_vcpu(CPUState *cpu)
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-    arm_cpu->cpreg_vmstate_array_len = sregs_cnt;
 
     /* cpreg tuples must be in strictly ascending order */
     qsort(arm_cpu->cpreg_indexes, sregs_cnt, sizeof(uint64_t), compare_u64);
-- 
2.50.1 (Apple Git-155)


