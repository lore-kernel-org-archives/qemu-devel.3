Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813B3CCD19F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v95ki-0007bg-Ot; Wed, 15 Oct 2025 13:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kh-0007bX-2K
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:31 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v95kc-0005Rk-Jq
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 13:57:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-471076f819bso6398365e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 10:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760551040; x=1761155840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+M9WOvmKYPQ4WsmxkpnmdsqwetzUwBl1PuF1HO+xpBc=;
 b=yCnfvJsFxpoRya4Tk1C6coFa5e0l/P/xv73qVs6zgflGBadtkBma4D42sdyloNQ3kp
 mxa+fx4uhTWum7Ho0wa4+CzKY0/4vgSzheL3nSBshNXuQi4h71e10/l/IQg4A6svk8ZB
 JUZyD+gvKVSMo+wlGhDdE1L2d2ueYBM9N9UEfxHOXAsRstESRU9n/JenJfoflJnMZy+u
 oCXCh/KveFivRkQByl3gyBrQ16vPwxjBvGtSoFmXQQdgZfLSPaMP7VgD8Ccwy4DO/Vc1
 Ee+WgWptFcwbHiXGV9k2bzkXKG3fyk9tWa12+E/Dc3Bc+YaLOXTNpHqkxRY0dhL8jArF
 lqJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760551040; x=1761155840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+M9WOvmKYPQ4WsmxkpnmdsqwetzUwBl1PuF1HO+xpBc=;
 b=J0VBaJazW5XBt5SXpvYmx0WwTcNQYQtzoCks2rymZAT+HxLcRy4Kf6+2v7La9nFY8k
 YYQaUWXz6X28mxi3q8K/qmxRaj1MRFhZyOLN8Q5jkndvJUL+O47TowlKA9y4z7wXlEK2
 QzErZGXXBxoLfYgwQLCaEqFCXNiNVPM6iOXER9Vq5QtbGPC2jdbWMLmTxij4MKl8lmxs
 1uCC9SizTjavR6x0WDAomwL16k9u2hvYJzx4sHKVaxjVnaMDL0x+ujTC72jdfoPlXQ97
 TA+/lD7k9j8EPr8lq2Ns+TKUBnLr6SIPV9/FgFXDo3nv+iJoZ84GUANPYZ2gvGopWidm
 V7SQ==
X-Gm-Message-State: AOJu0YxNeyNTwXFeBAViLYrxmyPtwIRTg8E3cAE9/MaVrb/BDiYpZ7BV
 R0hFs44jhw1xFLxY4FY8bsoHMohvGVLVnUAzFRWtcVNdQZzpTgSPmEOImedm1v0cv72dHx4uXnW
 hwv/LTPy8dg==
X-Gm-Gg: ASbGncu78J/XY59bb47pN+bDQknMq9NfGZIMeFIyOSKgNHdmL2ZkoSCjnqmguatlwC7
 QTxlvlGHrJWIW1UaNJVo1A3E1avO8m+Bkqn6gqoCIsuHA3KsdxV+/Y/N/C9ARRb54edclEcATg4
 Tt5kn7mEHxs+jstdpKcs9u4WMIYMGaX4/d7vlkwCFn2vKNTdXUU2lzCd56IASmxTwTM5LOgvXwN
 faUuF9splDQScjo2ahHKvVJ4Q0JBHfYRS7Jhsck2UrPboNkYSTu09LM6bC2mdjfaUeE+joU2CsW
 MjKg3idzBOxWVj/loKudGnoGnC0zmcmD/2YVFiNirN0926EeDRFdwJkLImA4rSQIiJ92UXzmcbO
 FAu2opd0seP3NWVvuajmf4QEcxRHfI1eIxcfWaS5zoRKZA6nz4Mo+eXtVqpxCvjShP1BZ4OUSDV
 Xvlaogc2mho2glvYpJJys=
X-Google-Smtp-Source: AGHT+IGB34u0FDSqz3fhxxVb8ltei5hQ+++R25QF58rg4CSF3immh4mXDeY9tHtacJKjuB+Jz9Gqlg==
X-Received: by 2002:a05:600c:4ed4:b0:45d:d505:a1c3 with SMTP id
 5b1f17b1804b1-46fa9b13b04mr206951205e9.37.1760551040542; 
 Wed, 15 Oct 2025 10:57:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3703adsm180518755e9.0.2025.10.15.10.57.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 10:57:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/7] target/microblaze: Remove all uses of target_ulong type
Date: Wed, 15 Oct 2025 19:57:10 +0200
Message-ID: <20251015175717.93945-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Missing review: 5 and 6

Since v1:
- More uses of TCG_i32 (Anton)

Remove the left over target_ulong uses in MicroBlaze frontend.

Philippe Mathieu-Daudé (7):
  target/microblaze: Remove target_ulong use in cpu_handle_mmu_fault()
  target/microblaze: Remove target_ulong uses in
    get_phys_page_attrs_debug
  target/microblaze: Remove target_ulong use in gen_goto_tb()
  target/microblaze: Remove target_ulong use in helper_stackprot()
  target/microblaze: Have compute_ldst_addr_type[ab] return TCG_i32
  target/microblaze: Have do_load/store() take a TCG_i32 address
    argument
  target/microblaze: Convert CPUMBState::res_addr field to uint32_t type

 target/microblaze/cpu.h       |  2 +-
 target/microblaze/helper.h    |  2 +-
 target/microblaze/mmu.h       |  2 +-
 target/microblaze/helper.c    |  3 +-
 target/microblaze/machine.c   |  6 +--
 target/microblaze/mmu.c       |  4 +-
 target/microblaze/op_helper.c |  4 +-
 target/microblaze/translate.c | 80 +++++++++++++++++------------------
 8 files changed, 52 insertions(+), 51 deletions(-)

-- 
2.51.0


