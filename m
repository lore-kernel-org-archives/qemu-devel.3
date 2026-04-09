Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598A4F364A6
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAt9E-0008SC-Jc; Thu, 09 Apr 2026 13:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArhf-0000NV-LU
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:53:59 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bruno.vilaca.sa@gmail.com>)
 id 1wArhe-0001YU-Az
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:53:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48374014a77so14540545e9.3
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775750036; x=1776354836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=822dEdz04h6GaoKvoWInEu4oJQ4FAD6k+xKvPX2Z1d8=;
 b=IAyeihGCNBF0Xt4omX0OM+qJQKxy6xSslDQKuI7Fv27RVtFw0D0B2GEuXdX2s7Zd24
 qISUPn6Y2zPc4nH7jgq7f/+S14WVse6t8wfvlVzjKqYG/Di1MDAhd0G48oKfR4/OfKxU
 YRnj4lDkbBmGvGds8xAjlSTKCo3gSCENVFPufLtHJDMfW97YbIeoaw+1CsZSllSs5UuV
 xi9+GsjbOAig8GzduE8j8dwsXF8mclIQPn3ydpjpyr/2KT5Z3F0WXPdU44qDk55XSCT/
 fOm2/Ug13J0MA61ajevdnpNlaS+B45emygxD90WG8Aqmw/fUBIBpfi7MoYDKgSPUa44z
 RGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775750036; x=1776354836;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=822dEdz04h6GaoKvoWInEu4oJQ4FAD6k+xKvPX2Z1d8=;
 b=Hbv5Pof8cNmSaCaSbVoVKkUod6H+E8YoIu9RgAiMafacdyu+z14sx5R+9aQpKFrCGn
 Wg2PychiwtOUEyoZ2V8u34Q5Drho4Mc1gYTjeQpKWSuzrLKRA0ttOt1mtLKsAslg05sQ
 XzyNfauO4r1rKb50tsKM7ohEBMEtMtzaU3OA9NhkEhFdyY5cSFRD3Rh57rDSUpRHrk57
 8RSvhwMg346UL5d4PSmNmxjzA90Cz2j6CO9U5Xgp7j56UJSl3I+9haziMphtvMLgZ2If
 9nl2P9bDqJwqwiIk4EsFhNihDoHn+/ZaxJLGBw2lS7m1sSiAwvlPQQjS9GfgADcPQp9W
 kPCA==
X-Gm-Message-State: AOJu0YxxLQ1QGrarRE52mEbbxSJlx+NP4c977JvnBboawcDI234xOhY5
 ZQ9mOEn2tp3/XwkDQzBj/LaS80GbO1IUCIAMFsIid2VwFgMdWrMYOxW15FG8JWJNf2v7zA==
X-Gm-Gg: AeBDietTzzSILV3OaUyF2UiGcctAg5yod8WgSWtKsAOGL0NXwafdu28/jv2CHAsAPSZ
 t4oxI/xCx1Q2c24554oHTku9EiXvbrXrk35WP/Jg8tvHuMnhlub4LTX/xsdoCDlBOZprA7m8TM8
 9hxjloT/ikOoB/PiEVEdihCW2P90dGn8mWtL6kXNk+x3dTWosrtCaG8ZBHqyygKDcRLwg7I2U0G
 9w42wiGeVT0nP1OdfMd9SdJUaGn2UuZN6qMSf0ukwZOEXyyiA7meNHBsWpQd2ldYO8LPPFceK3g
 4otqnHCf91zLybFMhpCFdocZMQ7zoYQc6pJFFmDnkGQIx1zS0C1LJm2nQkD9kl9Lbq+/4r2EBIW
 IcpkMdgHcPO1z4L+uScIGUawPjFXYH+nr9rCZEDG5McLTPWe+pOpwXwxx6kM6W+r7Tv39a7/bxn
 HtRfBfGtaRjtP6zJLO5eC5GGEjslC4FBlriMgkqcMsKLmDdMhg+rG65/4XqBA7DMYe+ehZ
X-Received: by 2002:a05:600c:8595:b0:488:bfc3:ef3 with SMTP id
 5b1f17b1804b1-488bfc314e5mr117918045e9.0.1775750035984; 
 Thu, 09 Apr 2026 08:53:55 -0700 (PDT)
Received: from ninolomata-AERO-15-KC.. (89-181-36-85.net.novis.pt.
 [89.181.36.85]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e2c5468sm67259292f8f.13.2026.04.09.08.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 08:53:55 -0700 (PDT)
From: Bruno Sa <bruno.vilaca.sa@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Bruno Sa <bruno.vilaca.sa@gmail.com>
Subject: [PATCH 0/2] target/riscv: fix RV32 henvcfg/stateen CSR handling
Date: Thu,  9 Apr 2026 16:53:41 +0100
Message-ID: <20260409155344.2849233-1-bruno.vilaca.sa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=bruno.vilaca.sa@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 13:26:29 -0400
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

This series fixes two RV32-specific CSR handling issues in target/riscv.

The first patch fixes write_henvcfg() so that an RV32 write to henvcfg
does not clear the upper-half bits implemented in henvcfgh.

The second patch fixes the RV32 split handling of the stateen CSRs by
rejecting the xH CSRs on RV64, placing the upper-half mask bits in the
*stateen0h write paths on RV32, and dropping the unsupported writable
bits from sstateen0.

Bruno Sa (2):
  target/riscv: preserve RV32 henvcfgh on henvcfg writes
  target/riscv: fix RV32 stateen CSR handling

 target/riscv/csr.c | 122 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 86 insertions(+), 36 deletions(-)

-- 
2.43.0

