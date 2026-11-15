Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18768606A327
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uw0saFSf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSOQR-00005t-T8; Sat, 14 Nov 2026 19:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQP-00005S-T1
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:53 -0500
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xSOQO-00018C-EJ
 for qemu-devel@nongnu.org; Sat, 14 Nov 2026 19:48:53 -0500
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-33bf40b0c8bso912655eec.0
 for <qemu-devel@nongnu.org>; Sat, 14 Nov 2026 16:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794703731; x=1795308531; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VTz7mTqV/9RRUs/Zm/ywSfZMtIOKlgcWSJimbOoThy0=;
 b=Uw0saFSfEoSafzvfItoJsnkBwM/iBIpRKLyuJApF9clO6vCqWv8tEcRVSKgt05fJYM
 ujWDpNBnivrawdIAvZAEKBvggFqIOo6ZOcW200rxt0TmJQrFf8Ralqe9rz5MHuI13a/R
 hwa0tlFH8EXfSMdvq4nXY0MqKy3WHr/j36i+ep2st/uXwbv9T+hPKzMFWZoroPdkEQw3
 fnj15Vnno6gNiBUycr7sPkeqbwql+sccImZX22LSfkFtoOxmBewFNrm/uL2OQnAWERpw
 UQHmCqrlWzc/VJLMJWdyNGIixtTdpiK4eviHkhVx0MU3z6bgBgwW+aATYlzbm1eSjGtJ
 43TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794703731; x=1795308531;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VTz7mTqV/9RRUs/Zm/ywSfZMtIOKlgcWSJimbOoThy0=;
 b=HBNcwTuiWQKL723tedO0lSQFowTVW9+YYYhOEdc+aIkEHnXdJTI5vkcq2Fm2Fnn/Lu
 j19pW/eLuaPm1Bf+m9Lc/mY+xoAzXg71bA4EDOklfuDMkrTDtiLtQR6lJREAlBjFTkt0
 ilxD91G6OiYgR+11EK7VtwkGkfMuQvMvPp/fGcX6hdjbFQQfYUT+7+iXevtdypIMjufB
 kNELa+47CQzOE0JKoiLHn1m6KDari7x4v6LJRlB42exKDHRwRkym5J6pilCMyIfX9fqJ
 bk+BPa4Jgi/YXx0VrUBnJOAe0fx8zGIKGExDMBs6XobAkIwIVspLSKJ4npN5YkxTEH2C
 2PjQ==
X-Gm-Message-State: APuU4Z8A7gN33/fW1jCVc1Y6P3owMi3rbesN0H+gL+obDztbF+zpekVE
 9Y5+tUTuk8f/Eer+j/n8NlHUSkcIy8osB+N3kux8xEwpwB3RmoU+DjqIXqkQyg==
X-Gm-Gg: AYBFou1fVj104i2w6SCZgxXQbzX8MMvOqykr3vFks8PAG1FYt917GyTFx+zNFu4Vj73
 DUjbllaAtOwKA/1RoBWXWouEccFAeMw9L+wwMTaMS/bDXy8qfK6p6lalSUn8mSeVcOtW/Uf3CQC
 0Hyv3VYNTsKVnQ4d/TNV9hZjgDFmQWQlOM+7qpwvwc88aGrZSERb0EJd/OrLeNIIxUnpHlnw6pu
 ow1p4esvts43w93iYhlMDZOBjR/igdKoU6Lou6I5BlrZUHlhqbDNRXxN70smOz7Se9Wy109XiXw
 kxty7xWMM6oMHZ3z8Tz5aewNFAMzW+oT72V95lsfy33lFv9cgDrfkeCnJ9mj7N9D5qmSa7pAtNa
 p4wdCeSIiNNiqrS+cAZj2KjRCZVR4vZ26Sy8zUxP0QqdoBr40HuDzbyeYaupP6wUl6MRYQUnULv
 VoQKjmtkL8VHO5EpGVcs9kstX8xBL1/aqjQIJASCX62W5YmyLx39wr9dPlIpXnx01gTWRzncohE
 ZIhciy1lKGo9os77ckb8pGz2eVnIFW8fofS8A4LTTuJb27p0ZFAe2CzTK48eDi4IWmxPonwIXc3
 0WStxcDUdfDa5oa42ulolgva8rl9LknKeuMQhgwZq7F3pjGe
X-Received: by 2002:a05:7300:8b:b0:377:5cb:a534 with SMTP id
 5a478bee46e88-37965da9681mr6960281eec.17.1794703731065; 
 Sat, 14 Nov 2026 16:48:51 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-379553316f2sm21102926eec.9.2026.11.14.16.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 16:48:50 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>, Nutty Liu <nutty.liu@hotmail.com>
Subject: [PULL 8/8] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Date: Sun, 15 Nov 2026 10:48:19 +1000
Message-ID: <20261115004819.2586336-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261115004819.2586336-1-alistair.francis@wdc.com>
References: <20261115004819.2586336-1-alistair.francis@wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=alistair23@gmail.com; helo=mail-dy1-x132f.google.com
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

We're leaving env->itrigger_enabled untouched during reset() while at
the same time resetting triggers to AD_MATCH (type 2).

So, in case we reset the CPU during an itrigger session, translation
code will enter itrigger_match helper every time (via ctx->itrigger),
and the helper will do nothing since there's no type 3 triggers set.
And we'll keep doing that until something else clears
env->itrigger_enabled.  This is a niche case that it's a bit hard to hit
but it will cost a bit of performance for no good reason.

Found while reviewing an itrigger related patch.

Fixes: 577f02869488 ("target/riscv: Add itrigger_enabled field to CPURISCVState").
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Chao Liu <chao.liu@processmission.com>
Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
Message-ID: <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07ab7..988bc815d79c 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1213,4 +1213,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->itrigger_enabled = false;
 }
-- 
2.55.0


