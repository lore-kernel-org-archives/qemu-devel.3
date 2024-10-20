Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BEF9D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 21:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2dMC-0000rf-32; Sun, 20 Oct 2024 17:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2dMA-0000r1-Rb; Sun, 20 Oct 2024 17:20:58 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1t2dM8-0002Sq-Lk; Sun, 20 Oct 2024 17:20:58 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so2453405a12.2; 
 Sun, 20 Oct 2024 14:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729459254; x=1730064054; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
 :reply-to; bh=IAEcDPZ3CQ9oAuIMRzDL1U+GIthteurNbBFokihTWZE=;
 b=IERlEOoDck8SILRLRRHnMsvwOZtwWsv9stXiVcdk/5fUP4TRrVnoPeQ8Vv23q59uQ8
 pq5KwJXWioKlYkL5LPv2AymgB0QzipXaM6L8kPKJ17BpEJvqHjOKNTIs/wFScEXCPeaY
 YZQfc986yIE5n8NoLr0JLDRKcKkHEggQvOD0vc2irFiJH8R1Lqm/wawsyjN9jbiC31/F
 2NN3rL9S1qRJG+GiASLLYIzUSqGavr0hR3MihT5DlnjXgJcKqFqwx2rlqQIyo7OfG/oV
 YwE27XDPK/Nop2BUm44BqgKAopdMxJW+83d9gascyo+swVct1w7xy4LY7+12G7wVZaM2
 1LLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729459254; x=1730064054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IAEcDPZ3CQ9oAuIMRzDL1U+GIthteurNbBFokihTWZE=;
 b=T8zcnbG0jPDK+nzS0cbTR1Yyi6L0QB+PREynyKBOI4SnlMmgWp+Y6071YQljKjzYq8
 hbEcq3xCQZz2PblscMjmSKPkLyaexB25/K7ySaql009Jvlqh8epLUyJlfs12NTepvntm
 4xbsWBbW1U2AxXNImI78DmPPVets/pvHapxoAi5Fv0V0c3viknlxQclMF+5COxXLLs+u
 vOVxQKWsEsk+ALd7BA/r+j8WYKLINF3nmx9WDcZ9hPO5rW8OXRFqe6uzWgI7Ii4r4W9I
 rcUdZcDeQBQjztE2y+dIzEX/EFx50UbF3qdyVVf3QRtEPxiGDDRlMM3+vZTe+drVFcHx
 2PxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXMFTrBiGP8v0MK/a3svaJDzh47d37kVxeVATXslkTOHyX7suXOXyHI52PaxtvCDeixT3mljtbD/s/iA==@nongnu.org,
 AJvYcCWFEBXUUJQ3m+TPRrBjfSxR1AMYzYp3aMeP0DnHd4p8LAhnetMsWPwg4OvTEKxiwSj2F1SBqh58Hw==@nongnu.org,
 AJvYcCWz5nh7TLwnI5tr3FmoV9wyTmCZDpZttUMu8mIA+F5vchPHWX91Ba8Zl5qZr3Seo/5yuV2xZmATPbUSyA==@nongnu.org
X-Gm-Message-State: AOJu0Yy/5p4n6LgftiK7biC28jPLkw/ec1IDaZcg4AhNaLAK3Yyg77Cx
 LvXCnGeOAz710+m0BP3X3LU/t68jekV7nbVn25n/JWPMeQ3QwcGt
X-Google-Smtp-Source: AGHT+IH+w3v9jDLBViI7gIIB5D7zG7WOaOKHX5CqTARFtl34hSuitIMIwxt1ZUXgQda6iN1HXD0Lhg==
X-Received: by 2002:a17:90a:e392:b0:2e2:cd5e:7eef with SMTP id
 98e67ed59e1d1-2e5618d9edamr10877559a91.27.1729459253544; 
 Sun, 20 Oct 2024 14:20:53 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad4ed73fsm2000148a91.44.2024.10.20.14.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 14:20:52 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:20:50 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongu.org,
 qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: Re: [PATCH v3 06/12] target/ppc: Split out helper_dbczl for 970
Message-ID: <2ecab2a6-649b-4c24-a287-58b74c39b412@roeck-us.net>
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
 <20240719010707.1319675-7-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719010707.1319675-7-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=groeck7@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.17, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Fri, Jul 19, 2024 at 11:07:01AM +1000, Richard Henderson wrote:
> We can determine at translation time whether the insn is or
> is not dbczl.  We must retain a runtime check against the
> HID5 register, but we can move that to a separate function
> that never affects other ppc models.
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

I see an odd failure when trying to boot ppc64 images in qemu v9.1.0 and
v9.1.1.

Starting network: udhcpc: started, v1.36.1
malloc(): corrupted top size
Aborted
/usr/share/udhcpc/default.script: line 41: can't create : nonexistent directory

I bisected the problem to this patch; bisect log is attached.
I also found that the problem has been fixed in mainline qemu. Bisect
points to commit: f168808d7d10 ("accel/tcg: Add TCGCPUOps.tlb_fill_align")
as the fix. I attached this bisect log as well.

Reverting this patch isn't easy due to several follow-up commits. Applying
commit f168808d7d10 plus several preceding commits on top of v9.1.1 seems
to fix the problem. The commits I applied are

da335fe12a5d include/exec/memop: Move get_alignment_bits from tcg.h
c5809eee452b include/exec/memop: Rename get_alignment_bits
e5b063e81fd2 include/exec/memop: Introduce memop_atomicity_bits
f168808d7d10 accel/tcg: Add TCGCPUOps.tlb_fill_align

Obviously I have no idea if this is even remotely correct, so please take
this report as purely informational in case someone else observes a similar
problem.

Thanks,
Guenter

---
Bug introduced:

# bad: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
# good: [c25df57ae8f9fe1c72eee2dab37d76d904ac382e] Update version for 9.0.0 release
git bisect start 'v9.1.0' 'v9.0.0'
# good: [2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219] hw/acpi/ich9: Remove dead code related to 'acpi_memory_hotplug'
git bisect good 2529ea2d561ea9fe359fb19ebdcfeb8b6cddd219
# good: [76e375fc3c538bd6e4232314f693b56536a50b73] docs/qapidoc: add QMP highlighting to annotated qmp-example blocks
git bisect good 76e375fc3c538bd6e4232314f693b56536a50b73
# bad: [60d30cff8472c0bf05a40b0f55221fb4efb768e2] target/ppc: Move SPR indirect registers into PnvCore
git bisect bad 60d30cff8472c0bf05a40b0f55221fb4efb768e2
# bad: [6c635326425091e164b563a7ce96408ef74ff2ec] vfio/{iommufd,container}: Remove caps::aw_bits
git bisect bad 6c635326425091e164b563a7ce96408ef74ff2ec
# good: [23fa74974d8c96bc95cbecc0d4e2d90f984939f6] Merge tag 'pull-target-arm-20240718' of https://git.linaro.org/people/pmaydell/qemu-arm into staging
git bisect good 23fa74974d8c96bc95cbecc0d4e2d90f984939f6
# good: [c135d5eaafe7aa2533da663d8e5a34a424b71eb9] tests/tcg/aarch64: Fix test-mte.py
git bisect good c135d5eaafe7aa2533da663d8e5a34a424b71eb9
# good: [6af69d02706c821797802cfd56acdac13a7c9422] Merge tag 'nvme-next-pull-request' of https://gitlab.com/birkelund/qemu into staging
git bisect good 6af69d02706c821797802cfd56acdac13a7c9422
# bad: [71bce0e1fb1a866dde4a4b6016fc18b09f317338] Merge tag 'pull-tcg-20240723' of https://gitlab.com/rth7680/qemu into staging
git bisect bad 71bce0e1fb1a866dde4a4b6016fc18b09f317338
# bad: [62fe57c6d23fe8136d281f0e37ec8a9fab08b60a] target/ppc: Split out helper_dbczl for 970
git bisect bad 62fe57c6d23fe8136d281f0e37ec8a9fab08b60a
# good: [3b9991e35c08be7fd6b84090b2114ff1bfd44d3f] target/arm: Use set/clear_helper_retaddr in SVE and SME helpers
git bisect good 3b9991e35c08be7fd6b84090b2114ff1bfd44d3f
# good: [521a80d895ec8ef0200dcac9b9b19e60b0cc1d1a] target/ppc: Hoist dcbz_size out of dcbz_common
git bisect good 521a80d895ec8ef0200dcac9b9b19e60b0cc1d1a
# first bad commit: [62fe57c6d23fe8136d281f0e37ec8a9fab08b60a] target/ppc: Split out helper_dbczl for 970

---
Bug fixed:

# pass: [72b0b80714066a435502b67cdb55a7868ba0487d] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
# fail: [fd1952d814da738ed107e05583b3e02ac11e88ff] Update version for v9.1.0 release
git bisect start '--term-bad=pass' '--term-good=fail' 'HEAD' 'v9.1.0'
# fail: [4ae7d11b70a840eec7aa27269093b15d04ebc84e] Merge tag 'pull-tcg-20240922' of https://gitlab.com/rth7680/qemu into staging
git bisect fail 4ae7d11b70a840eec7aa27269093b15d04ebc84e
# fail: [b5ab62b3c0050612c7f9b0b4baeb44ebab42775a] Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging
git bisect fail b5ab62b3c0050612c7f9b0b4baeb44ebab42775a
# pass: [1bfb726112ea4fda07c988f08df32d1eebb9abec] ui/pixman: generalize shared_image_destroy
git bisect pass 1bfb726112ea4fda07c988f08df32d1eebb9abec
# fail: [7e3b6d8063f245d27eecce5aabe624b5785f2a77] Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging
git bisect fail 7e3b6d8063f245d27eecce5aabe624b5785f2a77
# pass: [e530581ee06573fcf48c7f7a6c3f8ec6e5809243] target/arm: Fix alignment fault priority in get_phys_addr_lpae
git bisect pass e530581ee06573fcf48c7f7a6c3f8ec6e5809243
# pass: [795592fef7d5d66a67b95a7f45cc1a84883db6a8] accel/tcg: Use the alignment test in tlb_fill_align
git bisect pass 795592fef7d5d66a67b95a7f45cc1a84883db6a8
# fail: [9d08a70ddc08e9b6ecf870fd232531c78fe0b208] tests/tcg: Run test-proc-mappings.py on i386
git bisect fail 9d08a70ddc08e9b6ecf870fd232531c78fe0b208
# fail: [da335fe12a5da71a33d7afc2075a341f26213f53] include/exec/memop: Move get_alignment_bits from tcg.h
git bisect fail da335fe12a5da71a33d7afc2075a341f26213f53
# fail: [e5b063e81fd2b30aad1e9128238871c71b62a666] include/exec/memop: Introduce memop_atomicity_bits
git bisect fail e5b063e81fd2b30aad1e9128238871c71b62a666
# pass: [f168808d7d100ed96c52c4438c4ddb557bd086bf] accel/tcg: Add TCGCPUOps.tlb_fill_align
git bisect pass f168808d7d100ed96c52c4438c4ddb557bd086bf
# first pass commit: [f168808d7d100ed96c52c4438c4ddb557bd086bf] accel/tcg: Add TCGCPUOps.tlb_fill_align

