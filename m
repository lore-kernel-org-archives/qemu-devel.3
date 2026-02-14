Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D508EF48C4
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrFWt-0005Wc-GI; Sat, 14 Feb 2026 08:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWX-0005UC-CX
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:26 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vrFWV-0007y4-Th
 for qemu-devel@nongnu.org; Sat, 14 Feb 2026 08:17:25 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-435f177a8f7so1907353f8f.1
 for <qemu-devel@nongnu.org>; Sat, 14 Feb 2026 05:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771075042; x=1771679842; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uz2Q2r2Kx3bjbyNSueRh5MEBau+EbL1eCrXfzJbXPkc=;
 b=Smchuys8tzugLYRJJvtFvGNYbjGYPkFgPjAGxDfEHh7QiBGbLGJ0Rcktm8iEcZhmbm
 lAnwP8va8J0jRcyXMkT/XM50BNcHn0PQQ/SzWS3kzTyUMyPK7cbjoXgRdfO9ALM42khU
 6cw5QmD92r/CgC0QbUs87jAi3bOaeOZZYegxSXE4We2JZmBMDJYo9PJx6EsDtbccDohQ
 PN55BlT7J7TlKadDeUmSs9NN0zj+1czZimK1wClx3qdxX0krHbd3prCT4G9SbmU8sTPm
 OoFBjkw5gZtPTE3G+446Fr3xaFNSJ/6rAHEgODvli0FvikpsVqAgcEGWy5ib/W3HHzly
 n/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771075042; x=1771679842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uz2Q2r2Kx3bjbyNSueRh5MEBau+EbL1eCrXfzJbXPkc=;
 b=qITWwQlhcKPZMkS5jzpUA/Bxhtg2Ik0ces4RrXBFInpe0BuSHR8pOt5BxUWrID4By7
 8l7mfajNOrghP68eGZnTHPfAEriqw4E9ebqNIT82f1UmMzu3LxwKtxHa3WBVH+oTfGWa
 aY7XbVZotAMyarl1N6k+BlCcrhF4P3ty1rUA/k7rRE9dGpaD3YP/QhT5QM/3ktuHQcDF
 jRFpWNNLYAd2beJpvQOwQriwmED4aTJN5qyRQeF6apEv6/V77JRie+R1KvMjO4zOioeP
 gluypZUXaaaDivRzfUs3XiLC5XbJ2MLSGTCC72/V/ZCQug8W3xu3vF39W+aXR04pQ6Ql
 AWeg==
X-Gm-Message-State: AOJu0YxJw3uLS/o9vWGbpiX5ifcaDxpUb4VfgTObkP8oclI0tQx6mQ8t
 YCK89X7PI4ACaHmfVuQ4GK5qfUUl5BoQadqAEsbE3AtAkFrIEU9riPv0hhAskgOb
X-Gm-Gg: AZuq6aJeM3/0r983ipxdXhyAsVY1YQ4N1Fx2/UpCLkV2OnBtwaUEgHG6t5laIPuLsin
 raFJjHBSHqmL9Q4YTB8BWuypvrnOTclCBrn0C0/ekmh4sr7i9jk+jjl/Gz/qNfMfqSCqtmP512g
 wWa1WAtvA4wc5vYzvj76CHC7VP0pSpqluG6smfBRIAbhX1bGw+40VvhuImQdDt9+woa2ZC/pcLp
 OgJ3G4Lb81P2Ouv4kCWkOUwNWrj/CLgKEmpdiUG3PvE1xmXtDGtI9ESehzkNpDhbH19uQRKSvT4
 5WFMfgDt83plcosb62EuK1PeH6Nk2w6YD5aWac1+YpV0d3zHpSucqa6HnYA7e8WtbHOHEcGZCFo
 DhNEGpNABuVdE+aMWXhIZqiwY6YZoh+TjFJKfziTFwkF6LL17XKozZ5Fx+memuu9Ap44mG+l+Xt
 Xi6Y1ehkFM4Qrd4nqb+1Nw7SlxsiPdpqW8IzEKIEHMBNY248rPJUKGvIipHUZo6kWaVAFvP93OQ
 Dv0t17PqXj9LnVM
X-Received: by 2002:a05:6000:2387:b0:435:9a50:bbb4 with SMTP id
 ffacd0b85a97d-4379dbae64dmr3963260f8f.59.1771075041860; 
 Sat, 14 Feb 2026 05:17:21 -0800 (PST)
Received: from archlinux (dynamic-092-224-176-164.92.224.pool.telefonica.de.
 [92.224.176.164]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac800esm13340471f8f.27.2026.02.14.05.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Feb 2026 05:17:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/3] target/i386/emulate/x86_decode: Actually use stream in
 decode_instruction_stream()
Date: Sat, 14 Feb 2026 14:16:59 +0100
Message-ID: <20260214131659.31378-4-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260214131659.31378-1-shentey@gmail.com>
References: <20260214131659.31378-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Compared to decode_instruction(), decode_instruction_stream() has an additional
stream parameter which avoids some guest memory accesses during instruction
decoding. Both functions defer the actual work to decode_opcode() which would
set the stream pointer to zero such that decode_instruction_stream() essentially
behaved like decode_instruction(). Given that all callers of
decode_instruction_stream() properly zero-initialize the decode parameter, the
memset() call can be moved into decode_instruction() which is the only other
user of decode_opcode(). This preserves the non-zero stream pointer which
avoids extra guest memory accesses.

Fixes: 1e25327b244a ("target/i386/emulate: Allow instruction decoding from stream")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 target/i386/emulate/x86_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 6ad03b71b0..7bbcd2a9a2 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -2088,8 +2088,6 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
 
 static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
-    memset(decode, 0, sizeof(*decode));
-
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2101,6 +2099,8 @@ static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
 {
+    memset(decode, 0, sizeof(*decode));
+
     return decode_opcode(env, decode);
 }
 
-- 
2.53.0


