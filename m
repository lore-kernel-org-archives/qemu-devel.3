Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CD1606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 11:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xleLrJDv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWAlL-00030Q-Rs; Wed, 25 Nov 2026 06:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlK-0002zQ-5w
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:06 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWAlH-0004zc-VQ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 06:02:05 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4b79502c27aso55305755e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 03:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795604522; x=1796209322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=awpTOuvTcHM2oe2SlrsIR9xZND3+Cw4Ef3tTNl9UxuU=;
 b=xleLrJDvThVaF5X9xe0XVWx9yMbQuj375NTY6Ag890mZUy4tdbKz+X4pfU1ouViR/B
 0lUcbtPaQOvHIrW615ixjSnCnQG1PXebt3Nmqhi82xQ7TgvliDqqjhk4RzqhMmu3iWrS
 qY8gkTMksUsFWZaK8++L2nLtqDonmDyYxYgHVGKpB1oGbcV7QJqesrKDBpZYGhXC+fqb
 8J3FKm3xymRUjwPnA7JGDRuuvaTAvSggUfgOU8eKFB9bYxDwaatSjasO8dY8EoRF72/H
 RNB6KX5nB/DZ9rriF2PqqI8N0enXYD+Qn8H9eXB2RNq9Hesi3AjcldPhKnfLwpYsQjGi
 VxmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795604522; x=1796209322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=awpTOuvTcHM2oe2SlrsIR9xZND3+Cw4Ef3tTNl9UxuU=;
 b=OvVHaGqvgPds9D2qFs5t1egzUM6kcU1MM+weXiatPlkIvmRUOW3fTsGOnci91yfCWV
 sKed8J5K6ddwN8iZgu2aGfvEPfj6Zr0uRU6M/pLRY4R0yoYFgUjQbpz+725WZEfzqf5b
 Zkl+R3oZXbSwYnboViBILcJEztS6I412sd/AeAFlpXJlJ6QHgX/BRJEnprzAqKbr6Qv9
 Vx3/TN9IBLEMNpoC5DUBLXdCfCfYgwIWz6z8olmTQGdl/9HPakTsNEzOUO2f4sGJENn6
 8Vc2x/sonZOXSk7h8NhFRrVXqUwuB5JsrrAyhx8juYbBfv5zZq2RrZ598IbDWnRvKaez
 DK1g==
X-Forwarded-Encrypted: i=1;
 AL+hErGCaBYpJjXY6ZISG3IfYPnyidI2zWWhyeL35Nk05q/L+9L8R7dEucdGA79k0XKwWa6jTkTta7yE4fvU@nongnu.org
X-Gm-Message-State: APuU4Z/aqpOnNwFFfHi5oYQVjcOyfcNzhbMlwzawlrxNX4sHwM3n1q7A
 is9pDbbqsW0Gdbhb39g7l3qZf5DfucirdmZMKzUPgNG6lLIbmAEi/4/y
X-Gm-Gg: AZFdTZffXr0aT3ZDp0GsgDhV7ess1qx86/+WpJj9Q/+Y8VSlu7NKdFY6iffI5h4IsET
 Dx+N3tQxRxHNQi6yxqyFUNQBatdL/JSKngQQm8kMCvLnEAWQBjp6GP7Vo7/CZ3qjqoFy7kp1Scv
 cqU/YTHmrjDMJezTd81MNhxw3F38peZbbyA7W+GlGnWU9ns09rGGB1VUkh6tV/CWYuPKYW0YKRJ
 r/uOf2Qi0tEfFUTCs3RSDEScm2stvt9FTCRa+300+0qUUHMVkzkBfpxEBsOuqSWdWvL3z7WKsEd
 oKDUx7JcmkrM1hheFnBHJaOC2+FaUZpeoZxaOX9ARLNNLSYg4Gb5POxqly5bIhYRrDnBNNS9A6s
 NshZef5k2ApSM7LBkZ9mr6VvZqYMyGkd/EalaBzUp7GGy1Vu2oDmZ+v9jmAEzlsSdjyw/ywlUL3
 oH0YG7wQ01srlzqWZ4QEonqVFNj4h+OIB+X38xhTH74RSkgAmNlajKtU17ZwGwWQZWMPq8k9MFh
 kpNaVxlmMj7MV6QJVABwZsNoNuQluaf9CzXnaHD4tI4blrC8dM4QIMNoBHMfR87SDILuLLaH0iI
 QTtXiM8Zpey0T4UVpS3Y1GzSLRJc8a9A3z8HkHlq+71LZQKZSTIM+brlYtJ3OXXsmZb2QCpXqF1
 2bWDB74Fkv/q1edU4iIgMK9C3
X-Received: by 2002:a05:600c:530f:b0:4ba:6d8:dfad with SMTP id
 5b1f17b1804b1-4bb88811eecmr338353145e9.14.1795604522119; 
 Wed, 25 Nov 2026 03:02:02 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849247asm517061165e9.7.2026.11.25.03.01.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 03:02:01 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Haseeb Ashraf <haseebashraf091@gmail.com>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Vikram Garhwal <vgarhw@gmail.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Haseeb Ashraf <haseeb.ashraf@siemens.com>
Subject: Re: [PATCH 1/2] hw/net/can/sja1000: fix receive FIFO corruption
Date: Wed, 25 Nov 2026 16:01:56 +0500
Message-ID: <20261125110156.471118-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <62bebba4-38d4-49d2-8082-8eb95659949e@oss.qualcomm.com>
References: <62bebba4-38d4-49d2-8082-8eb95659949e@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Phil,

Good catch. The same issue applies to BasicCAN: an RTR carries a DLC
but has no payload, while the release operation still used the DLC to
consume FIFO bytes.

I updated patch 1 to:

- avoid storing payload bytes for BasicCAN RTR frames;
- consume only the two-byte header when releasing a BasicCAN RTR;
- preserve the CAN identifier when decoding a BasicCAN RTR frame.

I also extended the separate qtest patch with a BasicCAN RTR followed
by a data frame and unmap both PCI BARs before the system reset. The
complete Kvaser qtest now passes all four cases:

- PeliCAN RTR FIFO
- BasicCAN RTR FIFO
- hardware reset recovery
- software reset recovery

Thanks for the review,
Haseeb

