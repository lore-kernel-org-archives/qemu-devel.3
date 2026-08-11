Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CBAFC5CFCF
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:16:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtib9-000164-UI; Tue, 11 Aug 2026 05:16:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wtib8-00015f-5I
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:16:38 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <caojunze424@gmail.com>)
 id 1wtib6-0004SC-Hz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 05:16:37 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38f0f3c8da5so561745a91.3
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 02:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786439795; x=1787044595; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ZfnsgyLH4PQ/qK2TwhvO60jxZORJRM1+PUVK8kwg46U=;
 b=pSA9ewKvEkiTvHaxGpvMIPbZMEmT/HNOm9gWX2LUc7h/41jMzxaTKnVQBb6RLsThqJ
 AQ3oyEQJ3UdCFB7qZ5plrPRvEeLGs6gYiESLV3lCiZQF5kU0CV6B/kiknDTTrxq2HDFc
 J+/Qg6gVKzUzh7oPKJGgNNWArVLNCkP8Ihg/pgHEceLfLZi3EdioLPtsSDpHdtCt22HS
 AEaBOG+HOf/dNIFRl+XUBBJBQVGqxeuFZPCZQ5XhZnwPQPE1s8xHW+ieRiXTXK1V5rCF
 9YakrVeSGHUKdmDWXqV9wWojj2ZSAZdVNQdUdrUuzeyWSW9hjwgb+qPAl6RIII16elDW
 qpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786439795; x=1787044595;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZfnsgyLH4PQ/qK2TwhvO60jxZORJRM1+PUVK8kwg46U=;
 b=kAVbtEW3yf8MHxb4RyluDcpqI4RYIhRselbDBzg69S3YAK8TmNGCS6L2acDukMKSVt
 XjOcBZxjlWzr23ub3L61zYz9NLJax1SEEl3I+XP6uR/IlSPLBIS6xKUHeMCHo/t1630O
 DLZ66OOQPbu4A66PtlVTdv6E6r/g1j1jRCpfxd1U86aoOOTq6dI9wolRPRZullURbh42
 EDqmozmVweHf/sc4P9azzNpvq19Qo9VNls5zB5RcUFFESZ7OwYibgJzoI+cEWodhlSVU
 oKaY6eHIM3OjIlacBPj29657yveHxUYfBnsJv8YQ0BRySbY8pDQr15i6ESDTENRRnr/C
 5cew==
X-Gm-Message-State: AOJu0YwaQ7ODqqnEUirUMOrGmthiIgzukh/frFmj5oNe1LadaHF1+XLy
 //UmODmaGf5smZQmUP6OeUGmwOsrGDBv0MjJwGToh647Bos2i+SyES1sY/n8FQ==
X-Gm-Gg: AR+sD11SLL1qOmKHY2h+DLio+YVTwsvjLGvwikRWedz+DyhWbbnSIbzD8R9bH9qsTe3
 0N/CSa9YwZAGZi6Nsl0J2OXSwgS5FsSuZC/T8kBaWXpm0pUQtv5IdeOHDEcODQM9YLpSS8GqugP
 /ZhRc3gQ6lM/5AFN93wE4pH7+4TtQD/tXnWuxui/+Ok2Ak82hRtJEpKFSKuwtefkS2qqyD45AfP
 Wsx72XwioXLpr/DkOBqzC7NHHP26rMdXEcRjrVQ55h+lo3SPD/4YJBbY7Ky/j/euMpiUOjzejuw
 lQ846ycjwVZaQCy41SoDE1jho54mKu05uBQKXvyOLo4IJtEpAFYlvhnz/QgvGoO4ZPewgJPUmZJ
 P1PK2DiX95wAkTFstQ40ncsIK+J1m7IbomnQeKN4etZ6CMRgQ06oDX1fHWqXr/oM3c/Y4k3f5Zc
 THAzfE4uB9hMxhzCNqTSKhHspuqTfCEJ7n33Z1WH471w3cM0wFCbmJbvZV7Oqc80KhNhnxDJVnu
 8EmBp2A
X-Received: by 2002:a17:90a:ec87:b0:381:2788:a437 with SMTP id
 98e67ed59e1d1-392ec4d2710mr1343223a91.1.1786439794667; 
 Tue, 11 Aug 2026 02:16:34 -0700 (PDT)
Received: from [127.0.0.1] ([38.34.7.236]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412042d1dfsm3214257c88.9.2026.08.11.02.16.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 02:16:33 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/7] K230: add gsdma and decomp_gzip
From: Junze Cao <caojunze424@gmail.com>
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu@processmission.com, farosas@suse.de, lvivier@redhat.com, 
 pierrick.bouvier@oss.qualcomm.com, caojunze424@gmail.com
In-Reply-To: <20260808062227.66961-1-dingtao0430@163.com>
References: <20260808062227.66961-1-dingtao0430@163.com>
Date: Tue, 11 Aug 2026 17:16:25 +0800
Message-Id: <178643978570.1229420.7326743782506484256.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=caojunze424@gmail.com; helo=mail-pj1-x102f.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, 08 Aug 2026 14:22:20 +0800, Tao Ding <dingtao0430@163.com> wrote:
> [...]
>  create mode 100644 tests/qtest/k230-decomp-gzip-test.c
>  create mode 100644 tests/qtest/k230-gsdma-test.c
> 
> base-commit: 300438ffbb8d9430cac2fcc15cba6f482b2c0587
> --
> 2.43.0

Thank you very much for your contribution.

I think there's nothing wrong with the code.

Reviewed-by: Junze Cao <caojunze424@gmail.com>

-- 
Junze Cao <caojunze424@gmail.com>

