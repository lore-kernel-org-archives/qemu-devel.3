Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 084D3C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 19:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQAqx-0002Bo-H2; Sat, 06 Jul 2024 15:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqw-0002BN-DM
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:46 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sQAqu-00044N-T7
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 15:13:46 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-754d2b05db5so1480277a12.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720293223; x=1720898023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h1iFjXkNAAiUT1/HXJR1NSUSkejcZSCzgqp885X9UqQ=;
 b=vReNQLmVq05RDzOmAYNbScNBZjQ2SC1zVeoCxOtBLQMqqAvYp5iIjjyOU0k94yXqOp
 rkvhRcVPtoQYW7RiXWSD6GvSrqMG6nHHdGd7VTQ4Z5yDbYIiwPE/oShD4ZwNp/5SQDTT
 Av3lqEje+DqydsmtKZJpvRIsPzunbQ+7u4ydBmb6YShQy+s/gZIFtND9aHVp7TM/h4T/
 b/B2Qnm68Tk/FNE+xCzBeukyNDo5PxY1tmqqeJtsoXEQxE3ZrYSE42Zp/TUZkOnwp8DD
 duEjPyDk7UzXR8PntLThSiC1MieAk9EQWONLPcfampwv1pS3ob/hwfiPE6rilyUqj75Y
 11Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720293223; x=1720898023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h1iFjXkNAAiUT1/HXJR1NSUSkejcZSCzgqp885X9UqQ=;
 b=FVNJ5hobAlC2MXHME31FlAUPJtew87Sru4hFtWnH0Miriwn+dEuOqGWXhLcGxt1rdq
 wS5iKvb3o26my/v+/MlPiwmKT+Qk8qqO5Ke9upPlh2AdHeBD0FYFR4GGIt6Bb/DsrNC8
 1aOLD+urQLvU1QKtix6whZCSs/DfyH8jyIMNO+wbi2U12O1rgQeJrLv2KX/8pPzQHpb2
 FIIBtGwk13oqSSjXC4YKrTTpQSc0eT+tMCyqSDG9WWfJDVdoPWdYen8DXAHVVI+6cSM5
 A3ic65T4Tt3eCR7hqPp+v8/+fv0rbGbtNodD/4a5qNMNxMqEZdbMFwRQoVQ5/bXCD5Lw
 E2oQ==
X-Gm-Message-State: AOJu0YzOFIwVMTqEj0VhNDH52e4emztja0xGJFiJ1YopH3glWg2bsJu1
 Tbuy/eJoKY9Ug7Q3I2HPopuFM39KEDxXDl+Pvwo01vguKvEiraghuPMOxRJx5hX1KkOdG4p0cq9
 SYB4=
X-Google-Smtp-Source: AGHT+IEgLJWYW+fzNN8E7DoG6OVN7B+tHtpB7exat3ASMs2gO74W4a5QFwNejxg1LPZO0LO/bDu65w==
X-Received: by 2002:a17:902:db02:b0:1fb:6a96:fc72 with SMTP id
 d9443c01a7336-1fb6a970334mr12396215ad.68.1720293223034; 
 Sat, 06 Jul 2024 12:13:43 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb6153cb3bsm17304305ad.129.2024.07.06.12.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jul 2024 12:13:42 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Xingtao Yao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v6 1/7] plugins: fix mem callback array size
Date: Sat,  6 Jul 2024 12:13:29 -0700
Message-Id: <20240706191335.878142-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
References: <20240706191335.878142-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

data was correctly copied, but size of array was not set
(g_array_sized_new only reserves memory, but does not set size).

As a result, callbacks were not called for code path relying on
plugin_register_vcpu_mem_cb().

Found when trying to trigger mem access callbacks for atomic
instructions.

Reviewed-by: Xingtao Yao <yaoxt.fnst@fujitsu.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index b6bae32b997..ec89a085b43 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -85,8 +85,7 @@ static void gen_enable_mem_helper(struct qemu_plugin_tb *ptb,
     len = insn->mem_cbs->len;
     arr = g_array_sized_new(false, false,
                             sizeof(struct qemu_plugin_dyn_cb), len);
-    memcpy(arr->data, insn->mem_cbs->data,
-           len * sizeof(struct qemu_plugin_dyn_cb));
+    g_array_append_vals(arr, insn->mem_cbs->data, len);
     qemu_plugin_add_dyn_cb_arr(arr);
 
     tcg_gen_st_ptr(tcg_constant_ptr((intptr_t)arr), tcg_env,
-- 
2.39.2


