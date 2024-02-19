Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18696C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 08:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbz3v-0002dH-LL; Mon, 19 Feb 2024 03:31:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3u-0002ZU-7L; Mon, 19 Feb 2024 03:31:42 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rbz3s-0002PJ-EB; Mon, 19 Feb 2024 03:31:41 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dbb47852cdso14302865ad.1; 
 Mon, 19 Feb 2024 00:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708331498; x=1708936298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zHwhu9dJxHLhSujxZEC6wtH94N4t8n8wFK7D5wdRkDo=;
 b=j7nJM7BbRSXL0ZLGXbxKHNsZMYuxQ+ng+uk8Qy+RFrruWThfp0SDQPxrr2aurY/U3T
 DTYYafEkRqrCKF6JbB7MStQ9Z433mijnU/DF/AwAtuPeOGCnXXFxN5JcWdMyChOEyRhN
 PY7DTixOmhB5rCvplUQwZeTvclZxgiR+ZuGmWynY9naApYGO+v85uUAU81H7PVBNGf5K
 fAyrb7xNx7riNHYqaXjKy8bffzUNxtgkh+9o3x9Q0EjTU6ypIAeYePNVlxk1QRveDFsq
 VKa/aJ6IcjbcGx8IvgKORvvlx0G+G1Zy6Bg+hSxA7CnAWtrv4wNpg/54O5odPcIM4N2W
 F2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708331498; x=1708936298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zHwhu9dJxHLhSujxZEC6wtH94N4t8n8wFK7D5wdRkDo=;
 b=EioLAjwVWX9+o9AwVtsdCcha66YD/R5ab5w18ZSnW/40cYzw4lQ6xUetIvc+wdoaR1
 xHawmmkV750ItGntuKNBU+s42dr+2OhHWqrwhPhuz6xUTOgLP+chgaHdQVE9Uqb41QEJ
 jfyG8WSV062jDeTjpb7PRGSsDI1WGRLll7/DngViTGnbKdS9MmKtwJfdTWCE0MqZyzdu
 bdOD0S8R3ZMvnThtokxX/9L+AX+uO+NZM5EJJmaJfb5v7Hdgy3uVv96FAkdzwiiqXniU
 DyeKHc/tF0v7k09Achn+Fiib5SBeFwJEnNHMg9YYKOlsP0WFIXVcTtHjvI2aUGiAVJBL
 2aLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk97IiUvwsul+Gvm9XRwFYRcAUnpwqPhoTwjJgvcZVpf/z8rV0IAz51KEBWyJlj+oxgYRELwsUfXMUHs7e8T7+ePBg
X-Gm-Message-State: AOJu0YzNHwbWNUSOfJKVH+U7WYIBVMGT1aDOywlDC0fwHE8tnb5MrdCS
 o9B3D5um+SF0T6YPuM7qBxqgOLtQbm3UdjFeuwoQDDXByjyEFIsTULn513Hs
X-Google-Smtp-Source: AGHT+IHoQO07VvYJtNhLX41aKUzjCXfdWfbwHdSnIkVsLoIX1v7/mEbesjMWU/hj4e945zR51pU37A==
X-Received: by 2002:a17:902:a3ce:b0:1db:a94f:903d with SMTP id
 q14-20020a170902a3ce00b001dba94f903dmr6850219plb.36.1708331498668; 
 Mon, 19 Feb 2024 00:31:38 -0800 (PST)
Received: from wheely.local0.net ([1.146.38.93])
 by smtp.gmail.com with ESMTPSA id
 mo7-20020a1709030a8700b001db5ecd115bsm3838348plb.276.2024.02.19.00.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 00:31:38 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/49] hw/pci-host/raven.c: Mark raven_io_ops as implementing
 unaligned accesses
Date: Mon, 19 Feb 2024 18:29:11 +1000
Message-ID: <20240219082938.238302-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240219082938.238302-1-npiggin@gmail.com>
References: <20240219082938.238302-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

The raven_io_ops MemoryRegionOps is the only one in the source tree
which sets .valid.unaligned to indicate that it should support
unaligned accesses and which does not also set .impl.unaligned to
indicate that its read and write functions can do the unaligned
handling themselves.  This is a problem, because at the moment the
core memory system does not implement the support for handling
unaligned accesses by doing a series of aligned accesses and
combining them (system/memory.c:access_with_adjusted_size() has a
TODO comment noting this).

Fortunately raven_io_read() and raven_io_write() will correctly deal
with the case of being passed an unaligned address, so we can fix the
missing unaligned access support by setting .impl.unaligned in the
MemoryRegionOps struct.

Fixes: 9a1839164c9c8f06 ("raven: Implement non-contiguous I/O region")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
-- 
2.42.0


