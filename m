Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73A5C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 12:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9OUT-0000n6-7M; Tue, 21 May 2024 08:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OUR-0000mP-Kt
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:21:11 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9OUN-0008AG-UV
 for qemu-devel@nongnu.org; Tue, 21 May 2024 08:21:11 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-574d1a1c36aso8546843a12.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 05:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716294066; x=1716898866; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7hDdgTP8rBIKY8P3kMZkGjeHLGY9HcRDs2wrz8JCDuU=;
 b=HrD90d/h3Qt1wbLopmEPzRuCAACxg+WYaUAz+LwftxjYjD6UygoIzqZjwoUv/5tsvq
 5b8TfC286fUlT4QjwmGj3u0b0RQj82FM6xemafkZvrlqrmyLMn21J+BGC7JfqG/Ku9gn
 W5cLbP0DiqIomiL09/r9FeqDB0N4foZbI7PvX69rWis3AUrhmxoDgDq/wZUOIHOs3BuV
 VXiRdfzDFMNCb4nMjhRzQUrOYabk4SQWkKnsk3oYDGIJl6s6Xw6gn44yydfbDS3+EFJo
 80/dgC0nXG8RrpjFwxVzWZTP89ikZPpgG5N0xNfBWLNMKaeC9wJeSYJhFhvZkE7WPf+z
 8rFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716294066; x=1716898866;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7hDdgTP8rBIKY8P3kMZkGjeHLGY9HcRDs2wrz8JCDuU=;
 b=LLwtupHJiHl0Bnm6Hb0+VobvJimfhQtP6LAbeNj5USYX3gIprE7Xl2I555ZQkFVBRx
 CP4zkWbbhezRelsrof9NrVRfo3PftS2S1nOoy3zwmmftbJLMl/M8VyyOsIW1ItX2qqZ8
 tyuZugHQ6KKynCYrVaFdnJ3RmzsV9E7yFWKkLUkpiMzIG4SGHZ33d1CkD1ltRUwsxzw5
 c/Uh9YFTlo9CPEfTdWJ3yauY/AJ8DYP7Og2qrsx5i+jwFsUYgrEOUJhu2YJqQuDeBbT7
 ilIMO0lo9RlRcwUhwohWaEgGRqPhIGBT1lWWNP6yJ2oNmgjmEs7JRItgtNfBu/BPK05U
 lZJg==
X-Gm-Message-State: AOJu0Yxql/AhLQD908nXa6cn86mMIhe3A2td1d2nNUpN2JYi8+l7E3JY
 mrSCyc3AzMwt9pey7A+UB3weUCqtX4W1FUDEUpXPZEnhwrLxfvWuJOPtya+7QbOhgqHzw0aiMTf
 2CRfZvail/vGWeP16VaB9dYU4hj4U+L3YX2OX2g==
X-Google-Smtp-Source: AGHT+IHFjpBKnVyRcsJA7j2a0BTfVwN5MlEoUge9aDxaa95Wnnpmep2jFZXpyShNA/rURbpKkmV+xUG1OBiOo4IMAcQ=
X-Received: by 2002:a50:8d4e:0:b0:571:bed1:3a27 with SMTP id
 4fb4d7f45d1cf-5734d6f2d33mr22926357a12.38.1716294066242; Tue, 21 May 2024
 05:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-4-richard.henderson@linaro.org>
In-Reply-To: <20240511115400.7587-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 13:20:54 +0100
Message-ID: <CAFEAcA9Ob-Z2MJsz-0pPL4RGhjDOYL8_Ci9rNDqqPJ+epB+24w@mail.gmail.com>
Subject: Re: [PATCH 03/17] Standardize reginfo_dump_mismatch printing
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sat, 11 May 2024 at 12:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Hoist the "master vs apprentice" label to apprentice(), since
> we will want different labels for dumping.  Remove all of the
> "mismatch" text from reginfo_dump_mismatch -- just print "vs".
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  risu.h                     |  4 ++--
>  risu.c                     |  1 +
>  risu_reginfo_aarch64.c     | 12 +++++-------
>  risu_reginfo_arm.c         | 18 +++++++++---------
>  risu_reginfo_i386.c        |  6 +-----
>  risu_reginfo_loongarch64.c | 11 ++++-------
>  risu_reginfo_m68k.c        | 23 +++++++----------------
>  risu_reginfo_ppc64.c       | 25 ++++++++++++-------------
>  risu_reginfo_s390x.c       | 18 +++++++-----------
>  9 files changed, 48 insertions(+), 70 deletions(-)
>
> diff --git a/risu.h b/risu.h
> index 2c43384..1b87af2 100644
> --- a/risu.h
> +++ b/risu.h
> @@ -123,8 +123,8 @@ int reginfo_is_eq(struct reginfo *r1, struct reginfo *r2);
>  /* print reginfo state to a stream, returns 1 on success, 0 on failure */
>  int reginfo_dump(struct reginfo *ri, FILE * f);
>
> -/* reginfo_dump_mismatch: print mismatch details to a stream, ret nonzero=ok */
> -int reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);
> +/* reginfo_dump_mismatch: print mismatch details to a stream */
> +void reginfo_dump_mismatch(struct reginfo *m, struct reginfo *a, FILE *f);

This commit is also changing the return type of the function,
which the commit message doesn't say anything about. Since this
is only risu, not QEMU proper, I don't think we strictly need
to disentangle this into two commits, but we should describe
both changes in the commit message.

(Since the only callsite doesn't check the return value and
in any case if it cared it could call ferror() itself,
switching to 'void' is fine.)

thanks
-- PMM

