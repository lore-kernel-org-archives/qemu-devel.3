Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB86A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 05:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PJCy9f2V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTByu-0000Jf-1R; Tue, 17 Nov 2026 00:43:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xTByr-0000Iw-4T
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 00:43:45 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xTByp-0006NP-B8
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 00:43:44 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4b467581b98so37401205e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794894221; x=1795499021; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=92vnorFbr3vOHfrN1G11rwU37DCe/opDQJz3fRlDtrE=;
 b=PJCy9f2VCtOHpr+ZliF2yQ0E1V8+1sdI6KivYtl7TcGjw6npkBY5dYF7MPrGU8qwm9
 TdjhRe0ug7kw9s7mzd1/n90l8jDzWNJ+F/KIP1xdBYVuv7LPTV420Uz6fTeOzhjkzlAc
 /3cqPwzZnbvJ41qTx6d+NVnagQZZR+J/AR4wOs0Ra/4RQEY1dg/qik5i3tBpOgdvyV9i
 JC3wzBrUSTIgtqv4XMPkJ6h1rGVtDSAd+nxmvb4YJJNSAeQtvTWRyqJnlTUhg7IJYe1c
 Zjtu+4UbDLN9durvTS7RyegmzeMKn29xZMIfy19KpPL8JcoyVNedcmKiUrJjS9s5m6M1
 T3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794894221; x=1795499021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=92vnorFbr3vOHfrN1G11rwU37DCe/opDQJz3fRlDtrE=;
 b=MnosV0B2YaDJ+FA6isRwclMEt5A64jvYEBaLmD9RYVJ9fTiL0IqGlxRWsBZuB28FnG
 TeVdJ6NAHPU3S/pcuLRE0skW5mvPzGZBe5hCOCzwGsgl1GwYv64NzWBf1jS1eApfpQCM
 aG6hSN3U5QiGhxo8UffQOVIyW+5d9c92PdeuuXv0VXITRwcqwaUOnQ+WkIfG34ylxrNE
 F1H90qqiHYdTbe9FSCrUoGDgIZAEdl1TrvBhZPsSoLJ1eTsqUgHTKhZpuuYPgug5xYth
 REQoYlOjvE3jUqFFTuoaRoRynXrOVddrSKVA6AXDrJKi9OggQ5JfWsTa3uT10S0eD7T9
 ZOeg==
X-Forwarded-Encrypted: i=1;
 AL+hErGaSRGBcwUrvOhyjBHZlH33WyN7YEjR7oHzL9iFBCW62arhEqic34R+vGjoKp7bTqkqI9hE1M4ZdbYs@nongnu.org
X-Gm-Message-State: APuU4Z8Kc5Xz1r7nk/jnUIYfMt4RDaAYcTEifcWURliZ6ARQTaEao4+u
 Kmz6rR65dztW5Qsz6+juUs1vSlBk+ArIBKWE+71LgzHiYt/u7KXLDj2f
X-Gm-Gg: AYBFou1hWcxJJ0+x4LBWDmteICcj44LG7Py5PlvRYrJjhpJSWxuEZu5iOuu6BtXSgS1
 /qgEK6aPkCTuTpxjnBeHvXKoU4BUfSzv/8tq6goMWhiS5GW3sBXAjG3zjFYNT18aVI7LNHZcZW4
 0pijuHr4I3KXp0eTV4IH/JPHyJJ+FxKD7TiNrxViy2CHtwXTG6lQAIVVZFvsPt8bNPhhtgZ36PW
 hkEGYO3iJx5WpBkLZjuDFNLsIbnSRhQzQ+VCWXYvCBiWEqRCD1C27oJpKFR710oJTpPchPdaaof
 rXdgWvKNO+Eiaa5VQfbC+7sYaozovMfeHSVcHDSdYBncEB2GLNMT/D5HTdNYOKVaU3W9BtGyCj0
 ojsaag8aINkoOCIca9kwcEaPnBTpeaNbBYM0nQz1WAr4Ex5hEItSkozafgDq/xcRGn61dvGotp8
 GXU/MEgFiPWhRJU1nYtEx4dFryFVqfo0jNSMlH4rlvfin0MP0jwBNQaJ4G3AO7hXpK83PwbDsdN
 GTIh4uonbbiSxrbX5FXIKmQvJkFTOlbbc4Zk59wu05wKzZkpM0gKCkfHMwAmXCn8FBEL1NLwmOZ
 srHs8gePYfTvKa/Gs5YePS0TndbpmnyQ1ev6ClxY0zERzSdlM63UODFJc+/ZKcZOoMIahMs6i9v
 vUdiSyvkJSj5w7StP9oPDx0E646InD9tMCOUzsVZwsz6ZRBY1yfrkEb835UIMtsGW22YGMSrnlh
 TnuwJH4iTpWIPD1G5lTKOfTm55G+E6rc5jeKFpTpiyFG+SIsM=
X-Received: by 2002:a05:600c:3113:b0:4a1:d537:1c8d with SMTP id
 5b1f17b1804b1-4bb55aabda0mr268344195e9.19.1794894221262; 
 Mon, 16 Nov 2026 21:43:41 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-b014-0b01-69e0-6cd4-9e72-ec17.310.pool.telefonica.de.
 [2a02:3100:b014:b01:69e0:6cd4:9e72:ec17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb68c00b10sm125424745e9.0.2026.11.16.21.43.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 21:43:40 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Abhigyan Kumar <314abh@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: Re: [PATCH] target/riscv: make Zicfiss CBO checks independent of TLB
 state
Date: Tue, 17 Nov 2026 06:43:30 +0100
Message-Id: <20261117054330.85494-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261114215908.260568-1-314abh@gmail.com>
References: <20261114215908.260568-1-314abh@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=kmehltretter@gmail.com; helo=mail-wm1-x32a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 15 Nov 2026 at 03:29, Abhigyan Kumar <314abh@gmail.com> wrote:
> This commit introduces CPUTLBEntryFull.extra.riscv.sstack as
> a marker for shadow stack pages inside TLB entries. When riscv.sstack is
> set, check_zicbom_access falls through it to probe_write.
>
> With this commit, the now-redundant special case in get_physical_address
> for probe is removed. is_probe in a call to get_physical_address is
> replaced with is_sstack_page. As a side effect non-fault probes of
> shadow stack pages no longer see them as unreadable, matching what a
> usual load does.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4789
> Fixes: 669b4867495c ("target/riscv: mmu changes for zicfiss shadow stack protection")
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>


With this patch on master (97c88c61d45d), the reproducer from #4789 passes and
exits 0.

Tested on Debian 13 x86_64 (riscv64-softmmu and riscv64-linux-user build).

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl

