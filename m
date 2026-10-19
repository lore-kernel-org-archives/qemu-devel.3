Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9295606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gIVvfbxC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqwW-0006pq-1Y; Mon, 19 Oct 2026 13:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1xIqwU-0006pX-1v
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:14:34 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tgamblin@baylibre.com>)
 id 1xIqwN-0007VN-Vs
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:14:33 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-53653e30353so16110261cf.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792430066; x=1793034866; darn=nongnu.org;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1FTjTiUDtfvCTwAgsNJ2ROpD28tFBzMa/gEOg8BJzjo=;
 b=gIVvfbxCPvuw2q9eOiIjiRVR1QytaXv+QzY242FJZsKnYXxbqMAuV+spjTuFu0fZVe
 c4/8M9o20zTEhMsx+vcjYp/NjjBSJRjTnnTCvJ96zytbQOtXRqjLZRisBYcWf2FbRXwp
 VFBYkVYbMykq5yoA0nkOfDlG/n7DjNVsRfGy0JtccvLY0HhxRHYeCCfVZTJYdvmG8GJM
 eSzQHNScCn0odik8d+DjaJcG+FQDPunhz8Z44GI52uVH9jcqYxnGkdaRhpo2YjycKx4A
 DXyntnAEnTU/IRANptt9ZHJMbySXsEEWo1XzmiTAfrfOIc3RflFJo5NYQBg2OnVafvBF
 mxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430066; x=1793034866;
 h=in-reply-to:references:subject:from:to:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1FTjTiUDtfvCTwAgsNJ2ROpD28tFBzMa/gEOg8BJzjo=;
 b=KLWDShKH1wGBwh7/GfaljqC+bHfTLM+yrdW9TBvZLhpk3tqSCkqiFcr3t1XdGNEb+/
 uAPho7Vju4Kfcc/6VfVdUvSOePLtk9AxfmXSpH1l5iqOco2HriE8UgsKmpaVVbgnNYT5
 Ivgubg/zWrOBP5fwFnNQ2XcxIp89IEh8tVFChxVNqWx1FGvJ84nVwM9ZgLSuGSOWwWaE
 y10aGfSm30KgbRXVOCDSBzjLK5JrK2R9DhLInxhF6NwP1o6/BkbYK/zh20SSfirdXKhH
 tDXAtPkc0+C9jc3Ve7bebbgT8QRDAjJ+F7cxcyUi0pQdAUcgP8OFvGV468yA3vsTUefu
 hf3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByUXGa9opE8Erid/Hl2qNCgEMH4ZWqH2Rwjl5xEcRAWJCojrOXF3T+kSG2iEREZbOGZKKmm3fpZNyPS@nongnu.org
X-Gm-Message-State: AFq9FYIHxLlYvIgfu09o6JaS+O0p0FLH4w1hQqYXLs++BtaJk7hGScPO
 QbuuZjkelBBdNiMq7mPU161TcBzsKIwvMQkNpUjgBJEcLhOvLLmv7onywOUAkezJ7h4=
X-Gm-Gg: AYBFou1TnyLS1n+fMykPfYz6AlHdvpLfsFsXvhjfjHxs1k9Px14lsIdjCOnLTIoQSgL
 TdGiYJiE5uFhHs4Vcwjx18UX/YmyVSnVXY574tk6FGDbORjBxuvO78IyTisbVosZTF8NApDrZMD
 9AG34AJGrocho2nuMaYE7sESj56GaUwl/+tVqvCmZCkMtgMTevhG59Zl4RSRPh0auHGwrt0BXew
 VjTcLhGzRbCTi5yKwACorHsgr9GHkP+AmVOREFT5lMnF218bWiI9AQ1o15PDj/9mu/339PgMDlu
 4wQlzW1JRl+cog5w2GNGCQw+afNwyEmHqEGv18SXnnz2kCV6nsJTZMzF0zjS8eDAU/lML/1bMYv
 jG+qfZ5MWsOtPJL6O1NSnRJg66zZKVrdT4zcDeExwnZ02oHqz/Cb8pUGSaBj4FZCfDGkTkH2UuE
 ZOIBNELaStx9WjtuFwRt7r4DheBk1cyorQUaEcUdg72/hEpRTsy9uArF4oiQ5fxe+tPepYLivbG
 vS43TzvFZ8tJKiIhDDE5AM1Vuy6uPJ6/Q==
X-Received: by 2002:a05:622a:e313:10b0:535:152d:9a52 with SMTP id
 d75a77b69052e-53646080e0cmr87541321cf.49.1792430065953; 
 Mon, 19 Oct 2026 10:14:25 -0700 (PDT)
Received: from localhost ([2001:1970:3847:e000:1977:be2f:4a71:2892])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5362a9c273esm105449611cf.20.2026.10.19.10.14.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 10:14:25 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 13:14:23 -0400
Message-Id: <DM8ZFFJKYUUD.1YC6LDKPIOGX5@baylibre.com>
Cc: <alistair.francis@wdc.com>, <chao.liu@processmission.com>,
 <liwei1518@gmail.com>, <palmer@dabbelt.com>, <qemu-devel@nongnu.org>,
 <qemu-riscv@nongnu.org>, <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Wang Yechao" <wang.yechao255@zte.com.cn>,
 <daniel.barboza@oss.qualcomm.com>, <richard.henderson@linaro.org>,
 <tgamblin@baylibre.com>
From: "Trevor Gamblin" <tgamblin@baylibre.com>
Subject: Re: [PATCH v2 0/2] target: riscv: support TLB page flush for
 sfence.vma
X-Mailer: aerc 0.22.0
References: <d4535ac9-449b-4829-a0d1-1eabcfc2c08e@oss.qualcomm.com>
 <20261008070029.20239-1-wang.yechao255@zte.com.cn>
In-Reply-To: <20261008070029.20239-1-wang.yechao255@zte.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=tgamblin@baylibre.com; helo=mail-qt1-x832.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Oct 8, 2026 at 3:00 AM EDT, Wang Yechao wrote:
> Hi all,
>
> Patch 1 decides whether to use tlb_flush_page based on whether rs1
> is 0. This is similar to a patch I submitted last year [1]. Under
> normal circumstances this works fine, but it can leave stale TLB
> entries when the guest kernel uses THP.
>
> The reason is that with THP, the guest's mapping is at the PMD level.
> When flushing the TLB, the guest executes sfence.vma only once for the
> whole huge page, rather than 512 times to flush each individual 4K page.
> Patch 1 does not account for this: it only flushes the single 4K page
> corresponding to the address in rs1, leaving the other 511 pages of the
> huge page with stale entries. As a result, guest memory access faults
> can occur after Patch 1 is merged, unless huge-page TLB support is added
> for the RISC-V TCG case.
>
> Please correct me if I've misunderstood anything.

Hi,

Thanks for letting me know about this. I'm working on a local test setup to=
 be
able to reproduce the problem, and I'll look into a more complete fix if so=
.
>
> [1] https://lore.kernel.org/qemu-devel/20250930174849833XG1Q1ETbNvg66WU2U=
VBTV@zte.com.cn/
>
> Yechao,
> Regards



