Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC1BFF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:51:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsl1-0003nq-7H; Mon, 04 May 2026 08:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJskz-0003nd-Fx
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:41 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsku-0005Dv-SW
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:50:40 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso46233685e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777899034; x=1778503834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fY920kdhfZ+BZ9v92ysED16RYhweeBYB4IHbg1q45og=;
 b=hpcLtme6+OuPCLHmb6WZSwKLTn0JOwtDVchBPmDqTl6QMm+51eJMsdG8maCVLcJj32
 LTDMN9CiIA2ikQLf9VD4/y4hJAWOs/cOmhToB2dVPfJXBJAGtzhQDkWMmMO5CgezHOT9
 GYOji9dVa1HTB++NT6AWB26N9ALXdm9jhq5vUtPBlQ80OiRQGdbIdzbQsPVbudkkVVHE
 Wk1S0C4wlXnuLjQt/ousyOqCdS11pzqsU/A/gw3Xt1tPpBpasdDl4h7+/RBgoEyuwwHr
 7YOz3ZfhWLpsiABvcr6o378baEcFE2h26XEBqrbqm/2Vr5DaWCVlU6D0x4WZuVtxDEw/
 T7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777899034; x=1778503834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fY920kdhfZ+BZ9v92ysED16RYhweeBYB4IHbg1q45og=;
 b=AAEfqkw99V9tbvYWchn9LR2dJIIVDtARFoXgatKpkGt0NIiNjwXf/SEF5jXSkLkzwS
 zcTJqzOuyhipFGNmGzWquW3wQsTB6o1ayNY/XU4Qq9YOkuASC3asgMHOZcLFzCFgUZjY
 4TQdZ+r7TBOmAOM0p1t7MYtvm1kPnZ83lG+qoUID/gXWIA0gutlLIvgcALMIdWJex9hb
 YIHZtHiDbr43yEdplndYfscdtgheM39JzXpPndAccUNvImMtLzPtspBWhNgKTjRkGXJb
 vZ7n9zxMTFdjAfLfQFgOjPSK+r47ODlyIY36JUV3qTWcUjdQB8s6WzHh7IUT58NFy14K
 8mlQ==
X-Gm-Message-State: AOJu0YxLMqvgS7/kQpBiZB0DWtvpw+J35PFkmpkktPRQryPljQsSnZHx
 wDbJxkBk4fho/Y0WPlFaS2UoAbJjFnPvFNcZLmmoljeFyXQ3OAUv0IVJ+yY7Xl4ToD2ZkOQwnUw
 WysApFog=
X-Gm-Gg: AeBDietYzjzq0q7ddoM4VxosRzov4LHBD18EG1T35C2MVn/bW6xakm9/m87n/QMXjUF
 oLXYiIUrOtOQEq1SaWu3TLCsoXR8HYqjc6IW87ayJ0ML395/8bRN8lPoEZ1b/NB94/9JEWMQsGJ
 rxPYN5YngXWvb9Ze8iETmdUSKjiBdbyNIAED7fvgLdEgmxh/pPnk48Sxsya/dwWlX3fPV1MM5OA
 iN1vOys7l6Iy9m46jiKLI53exxSZ0KQQO13c0N7Wk8wwqT2J3rSjDR+cB6dt7/fG3yAD1hWoqK2
 YCGbl/ZCRs/DsttH0crlLTtvFZicDfQDB2DLxpfB+t8QX+1g2Pgh1Wre/10tiQEBEAcQc/TiCOh
 SBoalv5mdfOYC4qYO/Q508KgQas1dIva03fNj2wiShYgkk7mRR98k9sc0ut67w9/0sPQOaj3H3d
 sAH6U1NyugYPgOQMC6L39js/21mD86qIj9N3Q/ahULvPGspZUWyI7NHeOFtBexOp+urRH7/OF4e
 CFwtEZEgd4=
X-Received: by 2002:a05:600c:a410:b0:48a:761:5816 with SMTP id
 5b1f17b1804b1-48a970c1bc1mr120918855e9.8.1777899033941; 
 Mon, 04 May 2026 05:50:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eb3427fsm448097925e9.0.2026.05.04.05.50.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 May 2026 05:50:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/3] docs/devel/tcg-ops: Minor documentation updates
Date: Mon,  4 May 2026 14:50:28 +0200
Message-ID: <20260504125032.35465-1-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
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

Update TCG opcode list.

Philippe Mathieu-Daudé (3):
  docs/devel/tcg-ops: Stop listing dup2_vec()
  docs/devel/tcg-ops: List more vector opcodes
  docs/devel/tcg-ops: Slightly expand on discard() opcode

 docs/devel/tcg-ops.rst | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

-- 
2.53.0


