Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDD2C47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNNM-0000hT-Dp; Fri, 26 Jan 2024 09:40:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNNL-0000h1-0s
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:40:11 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNNJ-0000tH-8x
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:40:10 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3392291b21bso642908f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706280007; x=1706884807; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ir0S9Et4kj+il7pbp79hBCdp3gwWEhzqT/Y05bF96aM=;
 b=PtdvSG8FiZfqWMlewfY/4YP3ee7UTFxBGGZBFh+Mc3IF5uzWTUtHkwRDP3LXrMdDa3
 qC2XSNNwx4SXs1hKyWtpzKgfWU10sttBrHT+BVBGCdf+0qPAnPdIL1qzePgzKT3Ub5MY
 Yudz1a0FogK5e9Hw+Bclix0Q9GTGHhZlueNmf3NQ5grwVGQJG4Ba6KOaXj8VssWPrCi2
 RdYrH3xLL38rOPb/WAgrKpR0zeaQAfX0yVimsjGLfSRCqO9OYKfwMSxV3okRgnmWvjPP
 nig2Et2JYILnW+xR+QqA/Wl+qvU8U0FpTINBvCq6ggF7F6LqVDgxja+uTqcft09gPa7Z
 e4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706280007; x=1706884807;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ir0S9Et4kj+il7pbp79hBCdp3gwWEhzqT/Y05bF96aM=;
 b=PzEfP5sShth6yIiip/1OfWVywD9YSUV6F18x7gnIEbrCxDaa54cfLHB8ePDuOXotql
 SwJFOl8wDtCGwJ0fXRSPHWh32BYnycP2DofqKZLyizbrTYeWPU2w0iik81snve9hqtbh
 ElVkhDwYMScBnmz7RVmASx8qlYtJMasusrCxD7RA46dtgcPsEESpAqRTpuOupUrLFnv4
 yHV+Xew64ic5Jtb3WJb2i5uUtP52JuEMQW7t/WkZyTHfLZxmJJA+ZG0r0wM93MHD8eEV
 OPlIJLp94GHUR9PHAyWIE2EkGRqijSdfwZFk9pivZ7VImHdeKr5yAjawAcXM0bXcIybr
 YbQg==
X-Gm-Message-State: AOJu0YxFPsRmEz/SZU9SuvbqZ8td9/RB6TfjjeAZQU0w01ThPqb8kCAY
 2rCcKgiv5TdhbQeDAWeFab1GfBUWxAghgzXVqSzLTtq6T4jRMlIfa4TwB0PksRc18FMfZH79/Vc
 ybFr1pVzaiK02LrHY0y73X8aVrKycpS3tonkwr2izw3wHjyjF
X-Google-Smtp-Source: AGHT+IF/6/c5YdiPmZOGPnCfbJ2KHsxhroTk4kstoiftRjO3570Hms9Wcn5f183oIUfOZuuaP7eJKfQAnOwpJAyxbRs=
X-Received: by 2002:a5d:6604:0:b0:336:73d6:4147 with SMTP id
 n4-20020a5d6604000000b0033673d64147mr945589wru.43.1706280007478; Fri, 26 Jan
 2024 06:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20240126041725.124562-1-peterx@redhat.com>
 <20240126041725.124562-7-peterx@redhat.com>
 <87le8c6u1d.fsf@suse.de>
In-Reply-To: <87le8c6u1d.fsf@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 14:39:56 +0000
Message-ID: <CAFEAcA-x4WqvPsN-KZOA3SPN0F=vvYi=NFZ2qom2iT7-CN0RSg@mail.gmail.com>
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
To: Fabiano Rosas <farosas@suse.de>
Cc: peterx@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, 26 Jan 2024 at 14:36, Fabiano Rosas <farosas@suse.de> wrote:
>
> peterx@redhat.com writes:
>
> > From: Fabiano Rosas <farosas@suse.de>
> >
> > The 'max' cpu is not expected to be stable in terms of features across
> > QEMU versions, so it should not be expected to migrate.
> >
> > While the tests currently all pass with -cpu max, that is only because
> > we're not testing across QEMU versions, which is the more common
> > use-case for migration.
> >
> > We've recently introduced compatibility tests that use two different
> > QEMU versions and the tests are now failing for aarch64. The next
> > patch adds those tests to CI, so we cannot use the 'max' cpu
> > anymore. Replace it with the 'neoverse-n1', which has a fixed set of
> > features.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > Link: https://lore.kernel.org/r/20240118164951.30350-2-farosas@suse.de
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  tests/qtest/migration-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> > index 7675519cfa..15713f3666 100644
> > --- a/tests/qtest/migration-test.c
> > +++ b/tests/qtest/migration-test.c
> > @@ -820,7 +820,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
> >          memory_size = "150M";
> >          machine_alias = "virt";
> >          machine_opts = "gic-version=max";
> > -        arch_opts = g_strdup_printf("-cpu max -kernel %s", bootpath);
> > +        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
> >          start_address = ARM_TEST_MEM_START;
> >          end_address = ARM_TEST_MEM_END;
> >      } else {
>
> This breaks the tests on an arm host with KVM support. We could drop
> this patch from the PR, it doesn't affect anything else.
>
> Or squash in:
>
> -->8--
> From b8aa5d8a2b33dcc28e4cd4ce2c4f4eacc3a3b845 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Fri, 26 Jan 2024 11:33:15 -0300
> Subject: [PATCH] fixup! tests/qtest/migration: Don't use -cpu max for aarch64
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 15713f3666..2ba9cab684 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -820,7 +820,9 @@ static int test_migrate_start(QTestState **from, QTestState **to,
>          memory_size = "150M";
>          machine_alias = "virt";
>          machine_opts = "gic-version=max";
> -        arch_opts = g_strdup_printf("-cpu neoverse-n1 -kernel %s", bootpath);
> +        arch_opts = g_strdup_printf("-cpu %s -kernel %s",
> +                                    qtest_has_accel("kvm") ?
> +                                    "host" : "neoverse-n1", bootpath);
>          start_address = ARM_TEST_MEM_START;
>          end_address = ARM_TEST_MEM_END;
>      } else {

If you want to do that then a comment explaining why would be
helpful for future readers, I think.

thanks
-- PMM

