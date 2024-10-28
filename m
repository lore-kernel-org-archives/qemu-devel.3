Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DAED339AE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5UMO-0000Y3-HV; Mon, 28 Oct 2024 14:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5UMB-0000Rz-PK
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:20:48 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5UM9-0003bE-Uk
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:20:47 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-20ca388d242so41053565ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730139644; x=1730744444; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=CJ6rHcf/1KoOYa/3BNifuPz7aV72D8TPQslFOO51rUk=;
 b=IhGtABbx0FJElT7u3xHxTS+mtrIya9e15PNL80bzltMqVOjHmvYNxFmNvYohYf1XS5
 dmD9p5nbaAbUTznHHZuo+YDL/eGfybv2KH7UWUqsIT0xVmzCoGwyYV37NI3elrnoQfPh
 MeBQSg2tqe7pOJ5lYbxeYBT9ncY4c6K56tG9zK9mVyrAxLh0DjOk58NY36VpNNwWP9/C
 964bftRnLRT9+E05GD7pEp1oEN1VRgRK9QtT9wsX+3qKB48LEmzkJ8/Gi5nUFPyyESGI
 4KuU8V6fHyB33yo06ZJbev4t9Cdf+tS9Wxr0N2RejSSkzBgcEHyMXz48ViYbc7mn2f5p
 gytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730139644; x=1730744444;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CJ6rHcf/1KoOYa/3BNifuPz7aV72D8TPQslFOO51rUk=;
 b=V7sEYMk7w8xLiSHJsgzC84sAL5dB2YSCi8OPf0BnPOu455cg7NCiDZsXjibhT6UnDW
 hKPuqvecs6a5F+rTclmTemwks9exlrrA/zhaepC1cgGe634kyD2pxbO60l0mWeqNDKza
 mFMPLh9B5/2g6Ro9k/5Jthi6U9/AIwNTN+KDZXh8UuiW+iW4RhL+5SQGRCJL1vBETrfv
 E/wUmGarkmG11xqNgUWVHBnw49EtqlCktGhw/sWMUMRC6nI0GIt4dr0HcEicYoxj8T01
 /Yih2sALCn3TPwBaSt4XaxFr/5LtgCwBXqVFf9UH+SBfHAG7hQEN53+LnPGXY6jKYzK2
 MKqg==
X-Gm-Message-State: AOJu0YzHB6bXLzGJbOZEdXRKvHiXtVY/wiK1CyoUWkwkyuMhUThWPVOV
 GkOv0r6pOqUyJ4nJPsJDhWQc3bWkPbqpqmXmNXfWWtibG8xUATzVoJJM232mXCSzUe28vpMtv3c
 n
X-Google-Smtp-Source: AGHT+IHnqW7yKVjSqPaRRcA8WO3WNiiuOj+xvoGqyfijjsqgR1C8P1emJnZ97LmqR04qCay8OgFWaA==
X-Received: by 2002:a17:902:db04:b0:20b:3f70:2e05 with SMTP id
 d9443c01a7336-210c6c3f16cmr121921565ad.41.1730139643807; 
 Mon, 28 Oct 2024 11:20:43 -0700 (PDT)
Received: from grind.dc1.ventanamicro.com ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf471fesm53637505ad.51.2024.10.28.11.20.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 11:20:43 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v2 0/2] target/riscv/kvm: riscv-aia fixes
Date: Mon, 28 Oct 2024 15:20:35 -0300
Message-ID: <20241028182037.290171-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x631.google.com
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

Hi,

In this second version we removed patches 3 and 4 from v1. The reasoning
behind is that the deprecation process is too harsh in comparison with
the user benefit from using bools instead of strings.

We'll expose the string property as bools when it's time to expose them
in QMP and users will keep using the existing str prop.

Patches based on alistair/riscv-to-apply.next.

Changes from v1:
- patches 3 and 4 from v1: dropped
- v1 link: https://lore.kernel.org/qemu-riscv/20240924124407.766495-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (2):
  target/riscv/kvm: set 'aia_mode' to default in error path
  target/riscv/kvm: clarify how 'riscv-aia' default works

 target/riscv/kvm/kvm-cpu.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

-- 
2.45.2


