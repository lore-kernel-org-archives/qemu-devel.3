Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B084CC02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 18:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY8Mj-00087O-ET; Wed, 15 Jan 2025 13:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mh-00086O-5c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:43 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tY8Mf-000395-Fh
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 13:43:42 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-71e35be77b5so26877a34.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 10:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736966620; x=1737571420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AwZYeq4K+W1NQDBMX/lyZ5hy5MmdrAMvZUdnjdWaIb8=;
 b=hLXCjySec1Hu7oSmSvQ9bIfHCVMkV3tt188KAcNpmHo8BdxLrTrll0vQLeTLdLr3vr
 ZlGw9cXT5J3aVCydBTn8JFAgD4j/larMRwNugMn0Xai/Am6cnBLrpur37E3TYth0tEoQ
 WLyyT9FyguRAUjMuizFXx+Ra/7Y98RXzQL2Q6+p9Qse/NZGfjdJLGyPKHppnTfphm1Nl
 tp9zIoQ9Ge2I+nzpX28qLy/7erGilANtNx0ER+aGnYuwtIpOjdBGH+fdi6vq9AChBDuQ
 OwnVRSNmthBggq3xfUU5Aqr83T6GP4hy1KFlfQytm1FiYFb0boZwUNVQWbS+fdV7dpvX
 5cBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736966620; x=1737571420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AwZYeq4K+W1NQDBMX/lyZ5hy5MmdrAMvZUdnjdWaIb8=;
 b=b3qv8PujLmYLA9nxc939A5Jkucv8pDHAUTVE+M4VPU/XjTJLtejDTCgNiV6evZHVwE
 sJmVgIExoqm621j/+WGVj2KaUvnDQMwLrESwB3Zy3+uvhGHUGQmjg/PG53YlWsadjThw
 FtX+Oi5XLrQab48RT6lISZmL2Nyv0Uo2xkWzPxCM7tHj6P1cUxcXGmWbHk/q2hwwutYu
 PVDF20VtScVEX2GAm0X1I/6TtQmpyvuRH6u/yJd/L7x7gZfxsXwYNsB0ggB96dyFcGhO
 eiVfFtRtwICuwjhAIWNE/xQe727I/mpt+sSw6R7NVIqATPJ8HOsiCIwDa01RC3aQU0EY
 MtBg==
X-Gm-Message-State: AOJu0YwdBFt/L4nt4XgIIb9rBqCEs4EMW2cwrG/Qh8D6nGF5tsF78S+J
 Gq0tI0lXyHihXyJ2X0kQ/yCS4l5XQUTStFszMzbduN/+JKu3yjLIZOR6N6BGbQIHratpOllV3Lz
 hBs8=
X-Gm-Gg: ASbGncvjswNmL7WhP/X/929p+/dDbXshDELWk/7wfYHOhacElvuYIJEUEaqX1hMJOJD
 gqOQrm3JDVXiOwMzMdJsU7GzSMX4gixp+6ZymT747BNsaSXQra2/xfoFVIVCcPJV5FVCaMG4M9g
 C10omySmIMQVyx11ek1Z3aIrbkpMO1jFZ/f7Y12BsBAdOM80NUl2Zs/bcYvguYj6zou1TWUfjFT
 cktmRs/9nAqqlJ2jNIgCmp6K1/WoHyFBtMnrlTB6TSh5dfmj3xzwR7jpJU=
X-Google-Smtp-Source: AGHT+IGrcAC02vTQPlcacYUTbvLQs7XYAEzeWoxv2L/xxj+FH6ETaV+NC4PqRcJl3UltbyTxJZKdpA==
X-Received: by 2002:a05:6871:5297:b0:29d:c870:74 with SMTP id
 586e51a60fabf-2aa06922f71mr18633110fac.27.1736966620062; 
 Wed, 15 Jan 2025 10:43:40 -0800 (PST)
Received: from grind.. ([191.202.238.10]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad80a5cb64sm6539196fac.47.2025.01.15.10.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 10:43:39 -0800 (PST)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 4/6] target/riscv: change priv_ver check in
 validate_profile()
Date: Wed, 15 Jan 2025 15:43:14 -0300
Message-ID: <20250115184316.2344583-5-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
References: <20250115184316.2344583-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x329.google.com
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
---
 target/riscv/tcg/tcg-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index c060b65fbc..de2a8c3f35 100644
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
2.47.1


