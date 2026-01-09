Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46735D232C8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6RV-0006m3-BP; Fri, 09 Jan 2026 01:57:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PY-0003rk-Qc
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:54 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ve6PV-0002rB-F7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 01:55:51 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7f89d0b37f0so1286094b3a.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 22:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1767941748; x=1768546548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERlf7UDAtb2XiXyt3aq1BL+KIr1toImgIxxx/WHIU0Q=;
 b=iF69M0uzMeCZCJmCA+GE0C8l5v2+XkyWu2s6+MaquGkES8ncdJIxHNqz/r9FxUVtgk
 epeJeSSmaDf53tegs+9+Qv19YT7eMXjXVUahfLtvM0DWDWjcjlFn7RPP6UirFZz64V/F
 QLRkyhK1N3FTPo6Rx8hz8CqHV6Ks1XgQ+kFBkie9eSFPR4WZS0TxbkFll65xDTjMKrpT
 dhGW1b0MPDc49tkYUfSJUqR+dJsEgiByKEOX5rR2zQA8oQ8JAxOSAcVeNZujoqgkXKVL
 AebufBluT6ltbsQN3WwPjcVz/FL7KCm8tiD6Z+oUQCwLvXpfrmkvOyIfBGDziqBPzuz8
 O4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767941748; x=1768546548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERlf7UDAtb2XiXyt3aq1BL+KIr1toImgIxxx/WHIU0Q=;
 b=eMj4eSc7D/BiYGgWxEac3d45wC85WShWXrLcnbHgv90BmJE23bbErLxGRNXExXcwq4
 C01tkD0Tyn08YOfsQHbltUu4mUMA+sDtZU/8oHAOMvLp92BA0NPrWKNUUzT/Ch7A4j7Q
 OoV2/uBRbmFYNIdKIpOKW2FXid3ykW72sEjwOZIphJK5uOTXQbN8QgMjspkGz8QVv0pL
 D77dssNm+YZzD5hbrNW2uk7lFn5cXQQD2XHIjPNwH2B0ECmNLZi/CXA8WDqnkVbF37RG
 5wTfVOZjN2KMEYkuqMAwJOPCHhRkPlMj/+2vutRMvVYtWd6O6uYk5AfxsCNyTyhtkysO
 7K2w==
X-Gm-Message-State: AOJu0YzSNf0ptW8BrvMm42I4ROOcdX5xYhSrTPMnIhqOgcqoSPsXYYoX
 tDYI6A83765pgtUWKrGmM5RINZCfoxrRWdPFRKACa3iMvtW+/ghgiG1GkdMWUQ==
X-Gm-Gg: AY/fxX5NOiQQ/Wez2EZzkltfTQ0rbTVA3WgZ0CyfZ3aUVS+YnN2WBLThNW6lhZL8N1l
 QALjEwXXm+dwPuUkn4dvaFr/WhOMWUiJ2XzVgpqH4stlFn4CJu4IMNAKoNX9EJIeUITVPXt3/8j
 FqYFcOSCXJiIqPYSWCT2Akk9z+3umb1kzzQAwBkk3UeTjbIWupnIcAfWF0FUTO3oSOsd1sit/n0
 g+tmBmfaAv2DYif3oFHZ7a4kpcNlkQokpHmQrZQxNH5Iqe74SHGWMA4Uh3gKNIO8/HBE3k82c7S
 BJ0rZ9KDd0dvUTgMmmdqDWASR9La+PukItztfPXJbjx2xG/NPgPw/RKOTxxeHz/xOVQOZ3mMpc5
 J+lvEv/PQLxLwgMT6LR1khLIl0SZWNkCRRIlqTVHlulX/LhHXQrHZ4vEj8VioJEb1alg5bw/M2b
 KO+vRpuBidKlChUvCeSB503h1SX5ptY/0iIXg4Ka1cz9PFMQbI9JRmrgeVhiTaok42A2ex9+DqT
 GlZBmNBmWpzUZ2xcsg=
X-Google-Smtp-Source: AGHT+IG2lQB8TbHNnUpUi7j6tq94s4inCSp9uoAJzq2UmfYBuPJgQcChVmAw43uKcmOtRZPQLGUtkg==
X-Received: by 2002:a05:6a21:62ca:b0:37d:e26a:bff2 with SMTP id
 adf61e73a8af0-38982b1ffbbmr12199823637.20.1767941747659; 
 Thu, 08 Jan 2026 22:55:47 -0800 (PST)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc02ecfaasm9953644a12.14.2026.01.08.22.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 22:55:46 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/34] target/riscv: Bugfix make bit 62 read-only 0 for sireg*
 cfg CSR read
Date: Fri,  9 Jan 2026 16:54:37 +1000
Message-ID: <20260109065459.19987-13-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260109065459.19987-1-alistair.francis@wdc.com>
References: <20260109065459.19987-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anton Johansson <anjo@rev.ng>

According to version 20250508 of the privileged specification, a read of
cyclecfg or instretcfg through sireg* should make the MINH bit
read-only 0, currently bit 30 is zeroed.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20251027181831.27016-5-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20251103033713.904455-4-alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/csr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index a69b9a11ab..a34b14c4f0 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1544,7 +1544,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             wr_mask &= ~MCYCLECFG_BIT_MINH;
             env->mcyclecfg = (new_val & wr_mask) | (env->mcyclecfg & ~wr_mask);
         } else {
-            *val = env->mcyclecfg &= ~MHPMEVENTH_BIT_MINH;
+            *val = env->mcyclecfg &= ~MHPMEVENT_BIT_MINH;
         }
         break;
     case 2:             /* INSTRETCFG */
@@ -1553,7 +1553,7 @@ static int rmw_cd_ctr_cfg(CPURISCVState *env, int cfg_index, target_ulong *val,
             env->minstretcfg = (new_val & wr_mask) |
                                (env->minstretcfg & ~wr_mask);
         } else {
-            *val = env->minstretcfg &= ~MHPMEVENTH_BIT_MINH;
+            *val = env->minstretcfg &= ~MHPMEVENT_BIT_MINH;
         }
         break;
     default:
-- 
2.52.0


