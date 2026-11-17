Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979CC606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sSegLMRn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTCoh-0000uS-Ov; Tue, 17 Nov 2026 01:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xTCog-0000uI-58
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:37:18 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kmehltretter@gmail.com>)
 id 1xTCoe-0004jn-Lk
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 01:37:17 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so27035035e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 22:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794897434; x=1795502234; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ndICgOEm94+VTKH0mf23noz/2OmgqVy/PIpVBcaw1Ls=;
 b=sSegLMRnBrk5nv208ojan0D2iEmHsF9cEGvULD/aVpM0QuTfp52U3KKX9JnSSgIrZR
 glmzoohCb8P3lrnSeFngwB2CqPeutsR7lKHTrPJp+ZUOLJusxF/nUbBGoMBuw/XOOg5O
 ykw1vBEHc+bkKrRNh1Fzdh3lm0GeWm1/1Hs4KtLLFEuawP9omchOZxrxagQK/wQNGiLS
 smKGqurPcBvvwMhK36K2UqibB0pPswN4UDkNw80EoG1KzScGmHCwnIAC3CY4fgt38Rgt
 eMrPDmWuNyxPU75FwdNVqvjcygRAChJB7tO9Atb1rwYfHwpE1+0R161mFvjaYdhYrbYa
 gjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794897434; x=1795502234;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ndICgOEm94+VTKH0mf23noz/2OmgqVy/PIpVBcaw1Ls=;
 b=VrxGVcs1sre+I53uVvFA8eW3/US1ivkohpRo/vj1wn76d9MNCikNvHQo+CEScmtqk/
 S9LjhUWw1qCX2/GpzStscV2hCqb4t1H6FBGXyls8elpxPXoS2Uxj8o+OaoZCi7XyiWt9
 8gtGYbOm2QjIOTYoqmevurx3LYZVeasOBCuCXdKaneZepuG2FyM2PMg4ildGHV80mFUy
 uZRVdjJXf7m1sBRvPohjFVVYirISKwNmTJOf/CwWI869uAYlus63WyMmTa0euVJkjHX8
 oEpiUrTyixFJFJ5qWAOYWig5Ja3IqtcKKjoX1JcavctCZl2c7ZoBA7k19/qVgDIILf9u
 CQJA==
X-Forwarded-Encrypted: i=1;
 AL+hErGqWOoRcJH0/9b7LkOJDv9YQOfdzR1Gnmt36J+Klpr7pM/dqS9S/VsMNUqDxtjzu4BmG7gxnca0/hJc@nongnu.org
X-Gm-Message-State: APuU4Z93IZrqdwE+y3AZJT/vG+VG8mZ/E7mb9sgqN4tHb9kukzUTq0Lh
 KqGDM7H7fs9Pkn5AjhBvK/af/zNahjgkTME2SkMkLyPtadqGTLdfv/Tj
X-Gm-Gg: AYBFou30EjMn0l0PQ4MSdlzTMY4u35t4gj80Cq6sObzyN7DgXDxZdjHjbov2NMKaL0t
 go8BZUWor8rig5z6i+7U3S3oSuSfLGfFf8jVpi5KwTSs7jtw9io7L0yKzDpXFASP7RvPj5l50KF
 ZtnCEkOULuEYj9hyBNH9p4OBRVoKNjScTb8GQAcTr4ookPvX162UFXqJ71uVqL6zFC4ffz9Yv3E
 E4TslrwFzLQ+EjR9XufdvVSH+1r2GPh+zjMnUdcpHBsS4sSKpg7gW7G4KFc+t6+ZMYU65XSVJX/
 /rbPKs4YltmbnSc/kkwF2Pv14a9BLG4RW1T3xSlj9R/RCKP3oijivJjZC62GiHtrCZE0GFnLVMk
 Avc5iXjmekVa8wLdHa033ix5kjAVDBlMu0NAYnDoznpOLjHyIzFPdG+yejxuLoWBaV68SrLzUsy
 8ypfwiDM6vghD1qCIU2Sdq1G/XY3sbITY2Np3evEzOkxaWhijGRogf6Akh74mT2PsznP1IhHwsk
 dHkBHr0UcpNFKip63ooLtGJlKn4vzoRVmtntnLFKMbyPJRvCvfQg9DxlnK341t7rFcsBSK+WMJZ
 kVuLf792JV34+4v8IzN4UCse7lx2b4PLuVQDmmmA+U33eT2W8+sdl9/iNBw37bJIU4ip8JQ7ZAD
 i3nu6Y8FjCd0IHE116Yxh/cvg8MjVOBcbdgBiKM7pANWoVKE7AaJe8R1EhWR5cZ6AbZ7yRJNoUN
 rd8xVgP5pTxuWAqS9y+8vWR6ak+YECwJSPV95KsI6mcKCBrDqEyJmeHnO8L3kDhSh3LY62u9cc
X-Received: by 2002:a05:600c:3509:b0:4a1:fc98:1cb1 with SMTP id
 5b1f17b1804b1-4bb55c5f579mr275969695e9.2.1794897434525; 
 Mon, 16 Nov 2026 22:37:14 -0800 (PST)
Received: from MacBook-Pro-von-Karl.localdomain
 (dynamic-2a02-3100-b014-0b01-69e0-6cd4-9e72-ec17.310.pool.telefonica.de.
 [2a02:3100:b014:b01:69e0:6cd4:9e72:ec17])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783c255asm40409805e9.13.2026.11.16.22.37.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Nov 2026 22:37:12 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, Song Gao <17746591750@163.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/2] target/loongarch: Fix vmstate_tlb migration issue
Date: Tue, 17 Nov 2026 07:37:04 +0100
Message-Id: <20261117063704.98777-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261117020458.2203333-1-maobibo@loongson.cn>
References: <20261117020458.2203333-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=kmehltretter@gmail.com; helo=mail-wm1-x335.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 17 Nov 2026 at 10:04, Bibo Mao <maobibo@loongson.cn> wrote:
> This reverts commit 9e771d547b72d1eecd962725fad7508af3b97183.
> The old commit breaks migration of a loongarch "virt-11.1" machine from
> QEMU 11.1 to current head-of-git.
>
> Also this patch discards field of vmstate_tlb during migration since TLB
> can reconstruct from scratch.

With this series applied on master (97c88c61d45d), migrating a paused
virt-11.1 machine under TCG from QEMU 11.1.3 to master and from master
back to 11.1.3 both exit 0.

Tested with patch 1/2 alone and with both patches applied on Debian 13 x86_64.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl

