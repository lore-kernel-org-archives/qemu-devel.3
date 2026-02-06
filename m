Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3061DEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTh1-0001Mf-23; Fri, 06 Feb 2026 16:48:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTf1-0006GG-4w
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:45 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTez-0002hx-F1
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:46:42 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47ee0291921so11035205e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414398; x=1771019198; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dbCC5S3y2ipAxuI+4fXxE5kgwfJX+ivhV9v/oiXvz6k=;
 b=Gr4ZyxnuUVjoez0wx30l0WteetNxVHB9br5DHUcJFELKsJoi1lIpUKvICyh/GhKo2a
 NRA5cCtNtRlW8YsRnHBgKd8q3c9gfLm4BFyJzCUn5+yq/O99XTTsfzVx3L2PEOApznJG
 N9WlWhiJmGJoNnI2FbeV2SZPjlv+90y5ypPyCJx6MCfqbAITkNT2+Ckc5DGIaaxYbObs
 xi/GnE3TR6GwR9p5zMAkA6H8ADzNm6iU2Y51+uYBJFGTRc8QTR+tEH/E/XPchMAtyTKa
 a5IMMVlCaPZyIFOc4PZp65ZvLoz18h/iGohkyoh+66Cp5wGTays7UfBrAhWQHk8gfwKu
 6RkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414398; x=1771019198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dbCC5S3y2ipAxuI+4fXxE5kgwfJX+ivhV9v/oiXvz6k=;
 b=YiTmhglwwmACgFg7h1BrzLMHLv82PShCrC35Kzxx+N7zRR46drmThIzboCHn1X5DY+
 7RiBLgh4CTtn5WvpYadTJEYWn7W26PTdbjmgb5LNEI9z0g0gfOFG/tmktlpAphRcI5Ok
 rBHR7bz+LkUEitFxIO8xgqXmpRknkVicYO5O9eDRMY7K4s3smTpjH+gx5vT9JTvHnsVP
 SvQxZhWZldj9lFmUuikJi88ndvrr/vKJh2HswM6U4oNM8yhGvJSlZVW3LX/RW5brBIMr
 lcNQ3oSWD4Ubv6qpNacINCypYxBX88udXvr9MbxacnMMzs2tBVAhjfFhFhjlXAGGh+4p
 PK1w==
X-Gm-Message-State: AOJu0YxKQSh2mewE83iyShOheVAbel79dhjsEhr7cOcDxRrXFh/PkIdT
 erkIu3mrGILxU2UAlwqA3qnXrznTisVkeSPlJj5C3OjRDnw5UVaeebHjWeaY3ExJmS+/fVPhNf/
 sdxA4uG0=
X-Gm-Gg: AZuq6aK9w9fOFBvNcuwSXUB5nEU0jVNFUZkFspm72ryDmYEx4qqdt7b8fD2GSGXsYpM
 WkavKsq6pJ/Qm5uOoCyzBYrpr9MOJ4p2AH97SKiAs4h+VZ7htPixN96z6U1VR6/4uOfaOMvlHQa
 mhXmD/Tty6y9Txi/a1tM0W8OO3wQU+3al4D50tDJbI9bThzMVKA493SHP3cU/kaJnZ4snp7xvVf
 +6XYu08dTwhoRoJ6TL6bnZ2bSlKf0+XkSaZUFcjGT81gh3hQC4fRLrng10bXjLiiA5cdsOLu4zx
 KcpJsZID+HEROtHCC9GRriiz5oo3gA4WuvgCujkUsoQxGKTBTwm1L1avvuY1kTayCp1UELBuNTM
 vicxsdi9kPDcTu8yFbci8D6PBdPTbstWiS9cIEKOJ6emQQDI1Jg3Ai8r4kXftybgBfvkWpAvI5Q
 hycssrOsE1ZPoqgTEVrMVeDBAxTSnJ7AAD4QKnugV9nEGysAwr6PXKfvYutwon
X-Received: by 2002:a05:600c:8b45:b0:480:68ed:1e73 with SMTP id
 5b1f17b1804b1-483202277d5mr56592575e9.36.1770414397610; 
 Fri, 06 Feb 2026 13:46:37 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206d87c7sm70424305e9.7.2026.02.06.13.46.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Feb 2026 13:46:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org
Subject: [PULL 16/30] target/sparc: Replace legacy st_phys() ->
 address_space_st()
Date: Fri,  6 Feb 2026 22:44:34 +0100
Message-ID: <20260206214448.22008-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260206214448.22008-1-philmd@linaro.org>
References: <20260206214448.22008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Prefer the address_space_ld/st API over the legacy ld_phys()
because it allow checking for bus access fault.

get_physical_address() already accessed the PTE stored at
%pde_ptr and is going to update it. Assume the address space
is also writeable there. The SPARC v8 manual only mentions
faults (with error condition bits updated) in the READ path
but not on the WRITE (update) one.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260204215304.52757-2-philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 5a58239d65e..a6f76a1ab76 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -190,7 +190,9 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_be_phys(cs->as, pde_ptr, pde);
+        address_space_stl_be(cs->as, pde_ptr, pde,
+                             MEMTXATTRS_UNSPECIFIED, &result);
+        assert(result == MEMTX_OK);
     }
 
     /* the page can be put in the TLB */
-- 
2.52.0


