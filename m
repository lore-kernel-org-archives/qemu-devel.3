Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFC6606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 10:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=kTxN9q8C
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOugs-00056J-TK; Thu, 05 Nov 2026 05:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOugl-000519-WF
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:27:24 -0500
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xOugk-0004Hq-71
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 05:27:23 -0500
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-8b336de3d38so840907b3.2
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 02:27:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793874440; cv=none;
 d=google.com; s=arc-20260327;
 b=bup6B7aQIlzc0eCd60CRKUzTq0nDK+OknFtKRZv45UXBZ0mQH6HX6Y1tIep2QA0j8d
 Bpw8/mENrtzEsBCjWR/ULgB8zr3XdDyG1vSg0Y3EE7Q2FxrVEfSHTPx6NcL2v3Xiy/4E
 t+OzbwotkxtcrCdVcmNCC/UkcKI6c3L/y8RgvwvLW5Ca9id5xQG6QTVgp/2poisa74Ze
 OtpnNN7xVo8iCW/+HoP6Nedu9Dsiil3Kd+VzUiwHW4rQfW1CQCzI1M44+BUE8Vlef7GY
 aoUCsO3LsZXexpm2qnMCF0o5Rm0XYx3fbT0JkwlkyF6LtUAwizhpFHLs3bx3UhB3g06g
 T/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qY2fZ8SWzDctXGM9d3azla+lS020J+5D2zAlegDTz+Q=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=XfJmI8jrZjz47mEfUHR68ZsQyMNVZznV75nNCIGO8p7E8LMlI5/Y8UfSRkqUAyNrN0
 yz6/V8MBASipOpPFYoIlazlVoM9y+VenZ7B+Af1HAGLHWZYWDa37v3uiCr/OgZjtFoQY
 7+E5aoYanEgmr+nVjdAZPWyj9vMmvxMXU3kqr+/Ub33b6mDp84gvNsdzTCFs/PMStAfZ
 F3YBekPPo4/ZLeNRQXE4ky0xrptnEpMtVEb79IoNs+5Vp71Ing+IdKY3TKnOKVswn+vZ
 DT04zcr+ccW0KdtaN7WplyUyUhmCwAs5oklpstJwu2uLV4ySJWND35nRYBBLLcI6MkfR
 Aq9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793874440; x=1794479240; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qY2fZ8SWzDctXGM9d3azla+lS020J+5D2zAlegDTz+Q=;
 b=kTxN9q8CdZk9K4xjRVP/oYcGG0CSxs4TVEQHo0AD9iAldMF7zvD7pov0BLIl7Rjg+X
 vBsfxQYzocoLVPtEnVWMqVq82hboIdmI+/IljmAnd0gtrLOhJt7NNaleP+sTEQ5lzAUk
 RgZiFzKIu9cBaxy2NUAwjauZuDUI0+Nkvmag8EvRb/OvoSyxIE64XYH8zD1IRWcQhcsC
 whev8gQPNzarIYUnwcV52hLX4NE497hYfZ+TNbjL6C4+VHHzbUyu3+3bB/ARjidpAdeN
 G6vrR/MhNz4YgI4oIKR7HJZG/fQybxF3eY6wz5LePMP+gL7p83dqkU5n/Ja8AOwVJkAN
 kRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793874440; x=1794479240;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qY2fZ8SWzDctXGM9d3azla+lS020J+5D2zAlegDTz+Q=;
 b=KIsHI99p8W472pXUSJv6fLDMhltsob0KoxP/BvahcWCc7QqpfefW/honRzBriWW7E9
 3P5maqndSu1GVX/PgOjQM5U6iz89701gcyZiqhZDdDB0/n6BJFUMgT4GOjUxS0prLNes
 bj7sgVRuoql/Lm+iA6epntwndf1coobXBPkUQbHbOM+CAtVXhS6dhXNPBAXLVcvitjWD
 WYXi2wohUXKuUbIvQ6/xd32kUcff9LoPLnF2hlvJhEM/TrWN0BZm+zE26gM3XvH8EOzr
 bUnmZYUCe9510bjgnhwo6IyDZ3Lw6JfLCtr1GmBmtDG4en8kqCP65Z9m32Oqb3hZFUd+
 LnRA==
X-Gm-Message-State: APuU4Z/KiNqoIJHH8ooQJU7VGT19hFTX5r5CTYXiu00dT3fZHFolcLSk
 0K63D+WkVugIVrdy+H0baCJ/OldYm4iXye3fW5rpFR+RidfIE08J8phyHZfowNeAT04EOFKFH/V
 a+YofDhtnFz6OlaXmWCLpKxRQDFVvqxYp6N8vfCUsGw==
X-Gm-Gg: AYBFou2PykA6BOI8TzMRWx5kmy8P0OCD60rfCrKbMwGlKxXVrplffAtTMK6oyZT0RAO
 mxHCn9ofv4cMwD/3161/F1h2SCdngLRUTcJ1BSXYcsoYSnyVleiRlKDvwYSYVxCtO3RmrK20abJ
 donTZZZCaZP0+qI8CN+gXnBntKsLl2XWX2VOZBFCURqsI4Ppk5T0ghtZePH00xnVKoIoRWcilHq
 4vfPeSpTgKpWwlnSD3slRWFMeNqanV7Vx9Rdc4vh5wl2PnfNrXe2eRGFAdhRtGPiYfoxOeFkmYE
 Hk3oOptDZU9lULKogobjjF2g9DXnH5vsQYFWLgFCMDLd0YrurYRhJgw6YKasB3nO7/gQ75Dfabb
 EYE+hZOI9wsYMDoxLsYAymWo+NSVFRSEyZxjws6WUHy14YfpP9h2WKxV9ztohDtomVh8VaNpUO5
 NHFHwnJ3vsrhMwsgDVlixNyipBGazrjnmXjoCaT66OBA==
X-Received: by 2002:a05:690c:a404:20b0:8b3:3854:c28d with SMTP id
 00721157ae682-8b33854cc79mr561637b3.17.1793874440460; Thu, 05 Nov 2026
 02:27:20 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103133500.2295582-1-pbonzini@redhat.com>
In-Reply-To: <20261103133500.2295582-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Nov 2026 10:27:08 +0000
X-Gm-Features: AclHuK9X6XNHlsuM5LErPJgezX1WbQu_yORonxA9JcKd5ld9jIq1KMJZzC1oFO8
Message-ID: <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
Subject: Re: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8be4386:
>
>   Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215/qemu into staging (2026-11-02 20:19:27 -0800)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea58:
>
>   meson: rewrite scripts/qemu-version.sh directly in meson.build (2026-11-03 14:31:24 +0100)
>
> ----------------------------------------------------------------
> * target/i386/tcg: bugfixes and cleanups
> * AGENTS.md: add final instructions
> * meson: rewrite scripts/qemu-version.sh directly in meson.build
>
> ----------------------------------------------------------------

The qemu-version.h changes here seem to have broken incremental builds:

In file included from ../../monitor/qmp-cmds-control.c:28:
/home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
qemu-version.h: No such file or directory
   11 | #include "qemu-version.h"
      |          ^~~~~~~~~~~~~~~~
compilation terminated.

This happens even though the incremental rebuild decided it had
to re-run configure.

Blowing away the build tree and doing a complete rebuild avoids the
error, but it would be nice for incremental builds to work.

thanks
-- PMM

