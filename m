Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF91FCCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 16:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBEin-0000vR-Ao; Tue, 21 Oct 2025 11:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEid-0000pm-QA
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:17 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1vBEia-0007l7-9W
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 11:56:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-77f67ba775aso7486383b3a.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1761062170; x=1761666970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ItEDascWURdtiJBIFOxPqFxdsposkPVgAOSmqvZV7F4=;
 b=VZGkaLV7jqRVLYo7QXIMCTZ34wg0JdWFhmfdkcVggYH6gDbZXau1MDyIXdBNo3W9/S
 lf/vKTnunIWw5jkVsqgmaWGhJutaEEc6p9PGrpoCqZIItNKMklYbXVtGiAwoOYv12M4i
 N52tZLNAvg8Xby8zj8EUARr5Uf3WaYmCwJ+7lCp/b3+EGtn+syQCjo0KX/SDbZyJ2Vkh
 hc3X8ZMOq2/EzAVXF9oYDoc7Nlfs0PrVSaN9YCRa7AZn9YI6+Z7c9HeV4I9E92cfcyo+
 V1qpB/SESY9G10x7Z8VqCgVPNCIXn5rd6ALWaGzBHzFIw85vxqfpjvM/tN2nBF+iWhip
 WaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761062170; x=1761666970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItEDascWURdtiJBIFOxPqFxdsposkPVgAOSmqvZV7F4=;
 b=JyIBt9NFIcgaxYZ02Qg+xa2bwtLoNuBFwPAZeic9sdybk97yxyrShsPACEAV4LSGKB
 bz/tOFHmRw2lKOO1tYDJF5yWJ7ZWtggUTxpF0pR/7wGiRm+/Ei/R+IF1WP18AiO1p1Jm
 8mZZwnzPxrNQxPwGazu6IDTHDTjB2zjpiy4dpUkBenmJSq0Ir1j5UtbqyIfEimiD4w3U
 P9IptpjNvNxmDtICM9lDO2Bf95lGW2pW+FwhgTFFV+FrK2xceXG8sPxstW7XBqjRecbg
 A2E07pBFzdxVbabEfDVDI0PEeSQxmQ2hKglVJavVvBt/1pz2QeAT1a+9nzd1DLsEo1gK
 B9lQ==
X-Gm-Message-State: AOJu0YzxUwNj/zkNs9sehS8dINZLN+Gs8Id2frscQcKNnD5wVO3GnQLP
 48w2NmFte087rMPr34lcZ68qW2/0UshjifAeEXlijKA/0BVH/QA8sdlC4YMqVyyrtAYAGD19qt/
 okeCHldVZgxcIM8kd83JdAW9H3AoRaTefS9fukm/Gy4gB0SuIkRC5+O+tfvcaDY5wlXqiD72xam
 96WwjSNC/UZMiPQz0FphgRpjs5ZLR1sCdlfX+yhg==
X-Gm-Gg: ASbGncsFo6QlBcLIjzMUweLp8QkKyNSiaIT54PU2bZ2elXx4w63oq2hot8eGedIsGLl
 mn7qOpYrKLww9yNTBIllV7tkWrYjtggSDktq/nmtknGbdaK2YbqTrrvSL7TMg/hFE0P3/Wnj+BI
 v/V1G3l3XYCh0kSJYwa4Cvt4kFBcO+QDJXb/0rkp7HSAOkkT0Ab9dMSQPHrPnDpNLcz59hElQa0
 8P6dxcrzBIdQjpYOEjeQmp/H9fx5S3+kK2tr0lFmtCuqUFfIPvKwlbXYT2I9odDROpohadZpjlH
 k+UsGf61KIZ5zwif4/Ja4uT2vCxoZNhu0Ou0UP29KvJ9+aX3Ome9jetQXHqBVoiKdlWM5IIHeIC
 lFzDC84KtGQtGwrdrqJFBFB7ZaxdZhadlnWG1tz96pZfH2PUu+Mp0mnE6BdHzzsSzlTJLlCu/pk
 JKX6Qpe7yu7WFA9XSOHUJTjOCx/VsfA2k6
X-Google-Smtp-Source: AGHT+IEn0Qt6Oo+4e0ngsjIqW8GIuRuTZTtXWnxt3lGQr7smV5xgsnGddwfD17jHYxwNbaGUbIg5Ag==
X-Received: by 2002:a05:6a20:158a:b0:2e5:655c:7f93 with SMTP id
 adf61e73a8af0-334a8616c19mr24469072637.33.1761062169916; 
 Tue, 21 Oct 2025 08:56:09 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de11392sm11490177a91.7.2025.10.21.08.56.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 08:56:09 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Helge Deller <deller@gmx.de>,
 Song Gao <gaosong@loongson.cn>, Laurent Vivier <laurent@vivier.eu>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org (open list:PowerPC TCG CPUs),
 qemu-s390x@nongnu.org (open list:S390 TCG CPUs),
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH v3 02/18] system/physmem: Remove the assertion of page-aligned
 section number
Date: Tue, 21 Oct 2025 23:55:32 +0800
Message-ID: <20251021155548.584543-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021155548.584543-1-jim.shu@sifive.com>
References: <20251021155548.584543-1-jim.shu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=jim.shu@sifive.com; helo=mail-pf1-x435.google.com
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

The physical section number is no longer ORed into the IOTLB entries
together with a page-aligned pointer, so it no longer needs to be
page-aligned.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 system/physmem.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index c163d6b856..23d9b92954 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1305,12 +1305,6 @@ static subpage_t *subpage_init(FlatView *fv, hwaddr base);
 static uint16_t phys_section_add(PhysPageMap *map,
                                  MemoryRegionSection *section)
 {
-    /* The physical section number is ORed with a page-aligned
-     * pointer to produce the iotlb entries.  Thus it should
-     * never overflow into the page-aligned value.
-     */
-    assert(map->sections_nb < TARGET_PAGE_SIZE);
-
     if (map->sections_nb == map->sections_nb_alloc) {
         map->sections_nb_alloc = MAX(map->sections_nb_alloc * 2, 16);
         map->sections = g_renew(MemoryRegionSection, map->sections,
-- 
2.43.0


