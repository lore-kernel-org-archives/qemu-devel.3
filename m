Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B8FC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 16:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuwBd-0001ey-BZ; Wed, 19 Mar 2025 12:22:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuwBJ-0001ZG-Dt
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:19 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tuwBH-0007hM-6m
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 12:22:12 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5dc299deb4so6877677276.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 09:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742401326; x=1743006126; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mQmzSQTko+/MdeDbKzHhj3JdmzQ+Ck3u+RVZmexLXVI=;
 b=lIlq5b1xNBPwkipoC4xJfBFak4Nn1GOXQ1WByN8LzGQE22tlhGR4qHXFNKqJ1n1zOY
 +bXyqCemanSvlk7aWnpsX4aVUh6qzQDpvThBkVEAFgxnlGR4qUKpmbfdwdWm1zQ9YvfY
 jcJppm4CZChG2xHWgzxe70AKMc/ImMEtOSZnfRO3K7JjNH8Z+PY07gSDBXi3So45UdYE
 jsldpBd3iT0cw2KcDQkRQGel3mwc9aLzemE2jpKEoF66fUvtDcuu+6bG5ZaJyoxfteIv
 Nkh7sTyLHGvKX3upVqMGTHyMOnx63AyxzrDd9brux1e0JbN4RoR57NKdwUQmT+IdG4RZ
 FJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401326; x=1743006126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQmzSQTko+/MdeDbKzHhj3JdmzQ+Ck3u+RVZmexLXVI=;
 b=EtmdJ8prI19w/CR+prfz3/8wbj7inoNwvunKwLiL8+LTftmyCsg5tz45zXsde5TPiy
 xv0HpuAwZhWBHRm1JSOvSMtmtMWW7x0lJQCBjb90KeRV3Pe/FHZkM3oiN34fAfpvPIqH
 ZPuXYpIz5WSVOLOMXf+We1Ybw9eWohe/NchwgbRVQOQcvaKDbrmDEUA8/R06y0Ijiwr0
 2VjRAmpr7XzK7qCudsv4K3sKozw2/EmtUDmZdTYbQdXeh23mWNuF9sLrn5Bu2DRixo4D
 Wa4g5OSLEOVkSH+O2P6YQSi+S7ekWKJOKA85R59mDsyzVltUenPz9GbMeJQBC8AWKwzh
 jcfA==
X-Gm-Message-State: AOJu0YxroG4ovGxPDQ3sqQst2lVDCsEEuQ4T0jP3mm8gdsJ2ZdcXs4sH
 mOPYcOorlU7zd5gF5GNBZx0Q90ME5FJMMFhqJ6koxLYKUng88B4rBaeBEk95h1EqyYE2oO0Wy5s
 sVmaWxzpw1br1EGyzMWrdYgRjkTxCS7KcHf5ErDD/CqBuS5vL
X-Gm-Gg: ASbGnctosA6p9SpHKxBKdDwkCFp1q/45yiYNInjyIEFvRMLQMlU0zg5dsco8fCADvln
 g7pDXbiCZjgLhSeSOEryU2mmGYvlRMVT70LWv+M1bjXi7WhSlOV1Peg1wFsOWUJjzLBY937mW/3
 bbler/RDS7XQtnXiysfyDDJHKhpu9U9gVVjYm0Aw==
X-Google-Smtp-Source: AGHT+IFEmsMAPVcrmngKqiMdg3hf9+hscRS9puj3SQLLIEamQ/naGMConzCekbdzDx1ilwoUVGDsKadq0BnxFrgwCvI=
X-Received: by 2002:a05:6902:4683:b0:e57:2ff6:945a with SMTP id
 3f1490d57ef6-e667b26dcdemr4041074276.0.1742401325867; Wed, 19 Mar 2025
 09:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250319152126.3472290-1-armbru@redhat.com>
In-Reply-To: <20250319152126.3472290-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Mar 2025 16:21:54 +0000
X-Gm-Features: AQ5f1JrKSFWUV3UPyQCmoD5jS5w34pFiaVeIk1TElkSr5NN3mm-9WD2E-X-xiEQ
Message-ID: <CAFEAcA9zQ-T2bbJcxFM23TFkNb8-fROx0_bkCWHjZ50_ybS79w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanups around returns
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Wed, 19 Mar 2025 at 15:23, Markus Armbruster <armbru@redhat.com> wrote:
>
> Markus Armbruster (3):
>   cleanup: Re-run return_directly.cocci
>   cleanup: Drop pointless return at end of function
>   cleanup: Drop pointless label at end of function
>

>  .../user/ase/msa/bit-count/test_msa_nloc_b.c  |  9 +++----
>  .../user/ase/msa/bit-count/test_msa_nloc_d.c  |  9 +++----
>  .../user/ase/msa/bit-count/test_msa_nloc_h.c  |  9 +++----

I notice that most of the files modified here are these
ones in the MIPS TCG test suite.

Are the files under tests/tcg/mips/user/{ase,isa} ours
to make style cleanups on, or are they imports of
third-party code which we should leave as is in the
expectation that we might be doing further imports
in future and don't want to drift away from whatever
the "upstream" for those files is ?

thanks
-- PMM

