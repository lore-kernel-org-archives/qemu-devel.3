Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B5FC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdxS-0002BQ-2t; Tue, 04 Mar 2025 20:54:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxP-000257-7a
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:59 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpdxN-0008Qb-5A
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:53:58 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-223785beedfso79513575ad.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741139635; x=1741744435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/mnKCkxUHseq2DEPIBKL6BK8gURWClF8u9vsAqWZ2g=;
 b=atMlgwbR45VECPJAyRV/THbHJSJCnwX7MB36ji1MDUp3H5lzrKZDcplO++Zx+v1FbZ
 XkaHV4jJ4Pe6EDwjRTnsxaISTA/Z70+i8GQVSp0F6nhrBE8xT1CNi+sW+ITJn7ezWkAT
 bvWNhI2DY9aqL9/yjeGWDexOa74WLX+qk+GC/G7tWFzdYqrQxs1tR6CfPWDlm0CJ94jM
 iL8fMpzILYkOPZ0DTIHFi408ZwPKU2oZwDy0NsnGcaj/4UBIzW7A6uQ9yg+BkInqZoCr
 TGbo1JOx/oU4sNj/aTsKZLkRABhIY2f9ZAAhnekELZqFD/8Ow/h8K5QwHeHfvPDlY1TO
 mk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741139635; x=1741744435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/mnKCkxUHseq2DEPIBKL6BK8gURWClF8u9vsAqWZ2g=;
 b=sksQLi9p24UGdZxjOsIn2AitZtaWdltEV9ykxQ0HROFfD/8YQOvFm7gy3CiPQ+Z2tJ
 pBuhD0FR1lCveZTktWFcf5H88KGqmYAYd5KdgTVTbpZ9QWJSINSjS5ZTdH1N8FfW0g5q
 bPGVGqOKZD+snB2mgo11cQCjrDnh3gU9reN30HIpjQ9pVZ5cleqFl9FXHjR185zOnLbg
 N0IL2fDNs2dizL7OkJ+/ikuJF1pmuk/HONX85y4kqGMw/1VXV2fEIJRrO7WZ+cUIItQF
 Dr/e/Rwi5HF90mwrrnYvKrWGZbzF9JYc4UuF3++LW3/G9FTrhXpW7+f/Hd3Jw0tCpVTg
 Dl/w==
X-Gm-Message-State: AOJu0Yy1A9a9UzELOjOj6xI6y8n0AxHf3SN3AzbCXFCfFeJSIT0PrUCs
 1igDLQum5irzPN3/9CHwbor3jE+FzvjuPnvqz0pfdlg1YP5a5VUqps7jmU0ehpw=
X-Gm-Gg: ASbGncvPZMDW06l4Krm1UvbAMMdMRwW4+n4HTaSq29evakWFR5hEUBUhFQMlfZyRzpM
 JyT7KHAgY8j18QGK1WwsrF23y/gT7TRUac631ZibsRFySfjXW9lmXKE16Fd08mi3SLL9KPf6etT
 vq9DIdEQY66wX7pOr5rLCC4MM6zoOqMZYu+/RGNy/GWDH0OlSt30z7eESsXpyWWuLWX34pJ9hE1
 gxfAcDsCaGkusHOJduTw9BJM0xQsum0R0vgJYLPB9cN9y8KxnlKOJaazw3Ua4nzFy0vw3U6jKo6
 lH7vt+W5cva6725j0tGzvseHRCyj0kdrIULC6rlnIp7vAeyprt5Q2q9GFk5IesEYOyaRdKInfVs
 w1KIJwYbEdBuOjd4OwTjohioGFObG/ya+ma8/srAG7mJ/50SxzmY=
X-Google-Smtp-Source: AGHT+IHMqcDDYqF0qavMhjnPjFR/1qb447IJq47ruL7HOCET4aoxCMe84LNKkNEIINHS8E/P+u2zqA==
X-Received: by 2002:a17:903:244d:b0:223:67e1:401f with SMTP id
 d9443c01a7336-223f1d34f8amr22624085ad.48.1741139635378; 
 Tue, 04 Mar 2025 17:53:55 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e04sm102583695ad.87.2025.03.04.17.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 17:53:54 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 14/59] target/riscv: change priv_ver check in validate_profile()
Date: Wed,  5 Mar 2025 11:52:22 +1000
Message-ID: <20250305015307.1463560-15-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305015307.1463560-1-alistair.francis@wdc.com>
References: <20250305015307.1463560-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x632.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

The S profiles do a priv_ver check during validation to see if the
running priv_ver is compatible with it. This check is done by comparing
if the running priv_ver is equal to the priv_ver the profile specifies.

There is an universe where we added RVA23S64 support based on both
RVA23U64 and RVA22S64 and this error is being thrown:

qemu-system-riscv64: warning: Profile rva22s64 requires
    priv spec v1.12.0, but priv ver v1.13.0 was set

We're enabling RVA22S64 (priv_ver 1.12) as a dependency of RVA23S64
(priv_ver 1.13) and complaining to users about what we did ourselves.

There's no drawback in allowing a profile to run in an env that has a
priv_ver newer than it's required by it. So, like Hiro Nakamura saves
the future by changing the past, change the priv_ver check now to allow
profiles to run in a newer priv_ver. This universe will have one less
warning to deal with.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250115184316.2344583-5-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 2b21942ef2..cb9b504012 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -746,7 +746,7 @@ static void riscv_cpu_validate_profile(RISCVCPU *cpu,
 #endif
 
     if (profile->priv_spec != RISCV_PROFILE_ATTR_UNUSED &&
-        profile->priv_spec != env->priv_ver) {
+        profile->priv_spec > env->priv_ver) {
         profile_impl = false;
 
         if (send_warn) {
-- 
2.48.1


