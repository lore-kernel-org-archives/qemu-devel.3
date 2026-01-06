Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62586CE9D70
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 15:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd9Ra-0003H3-Fl; Tue, 06 Jan 2026 10:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9RY-0003GT-Sm
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:00 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vd9RX-0006SY-ER
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 10:58:00 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-430f9ffd4e8so1425431f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767715077; x=1768319877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l9nEPWNTdGtqvPfMZPN8BV/RaQf4q3ChcIBd22+XhgA=;
 b=dts7J/pvQfA0A5VURc80EuQb/o+PqqAThWIkLZPw0eIc1EUmyJsM08OoGuC0AMPG6y
 23835yg5REp790uhKlB/fteNxg73lGKFVpcKW7ontN/kZ7bNcNTBS64gPi4AQL9BrGX1
 bN/VmHc0XCa82jS62M3UiQdqjMx3RPVVFLh8DVpMqTJpSHV/t/+E+LWGfO7liDLeuBXE
 +gXpiCAWmVWD9oXzKdDUW1EMcLwIxRJrIjGJnCdKx9+AGE1tBUB/WUGdhCEy6EG9627u
 eJrugTgFWCg6fq8MI+jlv+t6utgg9nErkT7aQrWgAiCFx72Fl2a8MPETWsVs2cj5HLYd
 M25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767715077; x=1768319877;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l9nEPWNTdGtqvPfMZPN8BV/RaQf4q3ChcIBd22+XhgA=;
 b=ILQ5tIYpHchknAFOT/c2GKK3QaWq9igMZxnbzdfru8wrOJzXJ+OC7ufBH6jdsYa9ZP
 LuqpeF/NvS/8alEmMGQBaend9QOf+pPMV6hZIJjslgiVhY+SDUfV7cYbxAYYYU0CrjMB
 MhsFTuVlyo500tJoLYV5W8838qXHkF2vifJrpeqVW7McROck4Z2HDzwQ4CZwFHm+pkWz
 2U6Xfh5sY1hHJqWXbSL41oJExqBkGec1+tyQxOj96WF6s1JUnvSrN4BZ+vzd+uU+kAp1
 s3PpG3pPUug8MUfCDPeCQo5eMB90Ho24iMZYkBz5TGzh2dL+vzG+YZ7jkj4WQbO4gUIp
 39JQ==
X-Gm-Message-State: AOJu0YxM9vSo+pRqVFjTtRXNJI7UNEUJopW6+WgIkqzmpeLt2nlUThlQ
 KqcMw7FDdFUUe87BzzCvkvQ/EKhoFSkSxGtnOn6wjpVg1B0VODI4eJX3chuOwvCG+In9l9w3HvQ
 4wAW5q7w=
X-Gm-Gg: AY/fxX4ClYgeGQIjPBzmwi3h+iWZUXFrjGiXkGxEYYyhsH0sgiI7vWCXFwRCeztXdZx
 Aky8aAVLbNKkA0mZMGImYchlqQWJVQfXOVafL/yDcYcd+vUx8bN++Ty9GC1lT6yV07XL+iI7vBQ
 kQFjvh9BS4r9DzygANAnzK/rOsVYT//LE+xg4l2UDDQT83Tb2xBH/MQLZufP5idLvYwSGzswGDG
 oecDY0Awo7Q5os7bmhaCfuRlE0DMBYhIcb9Q2/Xm2E6zQOob4+NdElV+feNahkjuX5Nb9VvAEzs
 wMGLxzpOdnM7VnBSzCK3MRIXASXcnPtUokq8PlJDT9Cf4xHHa5gcAEX2wMJ5x5uUqY/JimMA5kl
 awM+ShYB3kJiAXzzLlAMY5dV5L9dazhpo880Hp65NbpuN4lsm+XyE9QoW/GjhGBGalIhMiaDzP8
 UUFcpMFr2dh+5o7NzIDsH+rAr4/24Gu3svkEM1ZdSAAhwodbzqiDts19bGmOXb
X-Google-Smtp-Source: AGHT+IGqMwM0h/AonNfTDU1+nH3HVsWaN7kDKTzm9j0GWOChkXEW5eFJRTmwO2m/R0T54XYfMnd8iw==
X-Received: by 2002:a05:6000:191:b0:432:5a4e:c023 with SMTP id
 ffacd0b85a97d-432bcfb6ba9mr3194312f8f.13.1767715077092; 
 Tue, 06 Jan 2026 07:57:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16f4sm5279240f8f.11.2026.01.06.07.57.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 Jan 2026 07:57:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/8] target/alpha: Use explicit little-endian LD/ST API
Date: Tue,  6 Jan 2026 16:57:46 +0100
Message-ID: <20260106155755.53646-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Missing review: #5 & #6

Since v1: Add mo_endian() with comment

Alpha is little-endian. Use the explicit 'little'
endianness instead of the 'native' one.

Replace legacy ld/st_phys() calls. Forbid further
uses of legacy APIs.

Philippe Mathieu-Daudé (8):
  hw/alpha: Use explicit little-endian LD/ST API
  target/alpha: Use explicit little-endian LD/ST API
  target/alpha: Inline cpu_ldl_code() call in do_unaligned_access()
  target/alpha: Inline translator_ldl()
  target/alpha: Factor mo_endian() helper out
  target/alpha: Replace MO_TE -> MO_LE
  configs/targets: Forbid Alpha to use legacy native endianness APIs
  target/alpha: Replace legacy ld_phys() -> address_space_ld()

 configs/targets/alpha-linux-user.mak |  2 ++
 configs/targets/alpha-softmmu.mak    |  2 ++
 hw/alpha/dp264.c                     | 11 +++++------
 hw/alpha/typhoon.c                   |  4 ++--
 target/alpha/helper.c                | 28 +++++++++++++++++-----------
 target/alpha/mem_helper.c            |  4 +++-
 target/alpha/translate.c             | 13 +++++++++++--
 7 files changed, 42 insertions(+), 22 deletions(-)

-- 
2.52.0


