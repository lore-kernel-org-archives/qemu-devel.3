Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D194C48295
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 13:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWyZx-0000qb-GS; Mon, 05 Feb 2024 08:00:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWyZs-0000pW-EZ
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 08:00:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rWyZp-0002J8-3m
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 07:59:59 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56025fcaebaso1918883a12.0
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 04:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707137995; x=1707742795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iex+BBAk3kVURGAKu7t3HWTcn09rhb0ZZ/rH1MAl3ao=;
 b=D2sigX2a0ovqujilA9JeyBeVfS9p1KHztxSoslnGCGy1esax1LCiDfpkgZuZV26iUE
 eZMtaj/ffjFXUmLpV0G68vfeQHkaBqRW3QqTga/hcuEtNig4+n3TuFz9WCMJWp0e9dK1
 a0Wm6fj+ua46bo3r56/XKsK19ob14qNjHVe3FVJpznfZht7rYaNWqbUfIEf2pHkgvuri
 OfbBCm24iz51Bcjy+FH5n2l5CjUXFDxx6eD6+GtDddP9iTgx30MZMLBREeChYzR4NP7z
 ZDJlSYa5WMbS+Fa+Rw+mwOR/9eNYDyF0yzavf1eSFL8r7q4iBhwalqmEibPmXCTn+q8g
 2j8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707137995; x=1707742795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iex+BBAk3kVURGAKu7t3HWTcn09rhb0ZZ/rH1MAl3ao=;
 b=pqQHZfia0gNIRFBwIATBQ1IP87RM21+gVlqnetUA806cit+r2Qc65Q3O2DyjhPI3gU
 4CfyLvHefRxSUTXdoQ9ZiRwqq0AytrdMJeLNkXwxVUdVIkM825tmAF6On/4yxn1NXmpt
 xZVhPx01FuT3gY+BF2h9U53glE+GmvTyYrmJWF+5/CozjoopgzDwQAO+SIpVxTrNhLPz
 PDPfyJwf8YsA1oFn3E3pADZpaEH8ihXMOd1YfezD5W2IVJlla9e4oXrBSrXMisHiLNoX
 MsZUkPoHoKFh1adLMrpaL6ChsQ8YbPNU4h5fsp/lwBRZC/feYnlnn7s/BXqcOaTwLVES
 rY1Q==
X-Gm-Message-State: AOJu0Ywu3F1ZOy50wFCN5H7y6nEvDLl46DUh5WQ9VpDvAqkcszmZW/RW
 95esMpMZpdnI7uznG8zHmLCTkrcMAA/F0PjFJfvfjFm+Yy7zzgBt3hRmRo5DihgaIX/ggDuUGmQ
 77cmsDS/dVZ79VePymZwQbP628ePC3793lrJL2w==
X-Google-Smtp-Source: AGHT+IFXUiDz8+eSXH63/uYVDA2DRv39Zamg/BVxXIrvNXrhJhJ2KFepBSukZaM27Mvo1A0LUrN2bTVRZhe5HfbwDVw=
X-Received: by 2002:aa7:d6cc:0:b0:55f:f7bb:4100 with SMTP id
 x12-20020aa7d6cc000000b0055ff7bb4100mr4947716edr.8.1707137995598; Mon, 05 Feb
 2024 04:59:55 -0800 (PST)
MIME-Version: 1.0
References: <20240204214052.5639-1-richard.henderson@linaro.org>
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Feb 2024 12:59:44 +0000
Message-ID: <CAFEAcA_QbizqPtjsbo57nVoJM6zh=iy2dOoJtZ1im97i0iB88A@mail.gmail.com>
Subject: Re: [PULL 00/39] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 4 Feb 2024 at 21:41, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20240205
>
> for you to fetch changes up to 867db6870a6f5d4e0915822d6a84e665bec1f22e:
>
>   tcg/tci: Support TCG_COND_TST{EQ,NE} (2024-02-03 23:53:49 +0000)
>
> ----------------------------------------------------------------
> tcg: Introduce TCG_COND_TST{EQ,NE}
> target/alpha: Use TCG_COND_TST{EQ,NE}
> target/m68k: Use TCG_COND_TST{EQ,NE} in gen_fcc_cond
> target/sparc: Use TCG_COND_TSTEQ in gen_op_mulscc
> target/s390x: Use TCG_COND_TSTNE for CC_OP_{TM,ICM}
> target/s390x: Improve general case of disas_jcc
>
> ----------------------------------------------------------------

The s390 linux-user guest on s390 host dumped core on the
sha1 test binary:

TEST sha1 on s390x
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
timeout: the monitored command dumped core
Segmentation fault
make[1]: *** [Makefile:178: run-sha1] Error 139

https://gitlab.com/qemu-project/qemu/-/jobs/6095771567

thanks
-- PMM

