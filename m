Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997ACCD1288
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Mar 2024 10:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqVZM-0004YB-Ab; Sat, 30 Mar 2024 06:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rqVZK-0004Y3-Ft
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 06:04:10 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rqVZC-0006fu-J6
 for qemu-devel@nongnu.org; Sat, 30 Mar 2024 06:04:10 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5a4817189c8so1726214eaf.1
 for <qemu-devel@nongnu.org>; Sat, 30 Mar 2024 03:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711793039; x=1712397839; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=msN+nS8Xbp08sd4JdDYxTlPnDXzBxxJEGgXLDAmpA0A=;
 b=H9+aMmNazTJT+E6CA1yVmYobaCKINpbzbW6aZKVTFrFkk3FzzLpCRo9dVSx7VUI5ZH
 bg0t8IWkfSpFSSxL9J1FDgKsDQoEhrTgA900HeBUJumU2fp9lt51w7tX3NzRWHT0vMw5
 HSerRl109ARZRtxWuV2Lh7d14B3tZfaDVLeB9mVpa7Va9GCUais0KKxeScUx5C9mXyRm
 /vR3p65cPIE1QUmKLEE5Jor/rmAkQDqtKnDlDsLQyW1qa9pv358v7fFbtKtPE41s+HDp
 Gcw5/Y3U3k0Bqk+J2csG+nQLjtOEnGmIVfD1aOzpg4Do9KJJ1I9E1g6RV8tfzebr+mvB
 cvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711793039; x=1712397839;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msN+nS8Xbp08sd4JdDYxTlPnDXzBxxJEGgXLDAmpA0A=;
 b=KUTs6H1E7LyDKGa8B9zsr2hwlTTOxQj4LDfd0ZXfjj+DEXmr9iEPQwWAVI9w450UJO
 8mDZyHmHLVuysy5UQ9RK7igKG8uxJCEv97JLtAWly+Ns2lY++3nO3NsNyDiOx/jsoyNH
 +BRZOCRrVIuab3V0o4/7K9NX/TOsawpAo18sVvSE59YyTv2BgBFZXI9PnEoPhVBrZFdp
 WFAIjCfXLpOQhig8UTwtniW9uCM7aa+QnntrvREfzT8zXHDiVSpiAT0jsKjfcoUoMsH3
 n1lOOThe8xJduD4CFIIYTktZnYV0GwZgczPxirW6uqYotuxeZ1rxqEKJk+T8nMZLBzMO
 NaRA==
X-Gm-Message-State: AOJu0YxmfJrurdFAdF9b5AsYG3jxsold5v1xQZ/zWirjVWuQVHKdcRJO
 a01Bd+VPLRQ3Oe7U7nKSNNy1vvFmTn2Xg63Hm10K5hKHf+HWFXQ515kEFAkXYdwA9y4ajOrkbzE
 W9TfcnxENSa40K2hpTGIkNG/ILZE=
X-Google-Smtp-Source: AGHT+IFvsAZZ41HpHWpFaMzu/FiQJtmIXQV1Y4alAXpx4TO1KlbD6ZsKLV1Bq2t+84nzYBbEUjT5gnH8qxVtvsyMikA=
X-Received: by 2002:a05:6820:1991:b0:5a5:3b23:8494 with SMTP id
 bp17-20020a056820199100b005a53b238494mr5272549oob.9.1711793039088; Sat, 30
 Mar 2024 03:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
In-Reply-To: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 30 Mar 2024 06:03:46 -0400
Message-ID: <CAJSP0QVRjSkX-edmHKDxcpc8O0Jh2BifuahE1FAz9ODOv4=AJQ@mail.gmail.com>
Subject: Re: Backdoor in xz, should we switch compression format for tarballs?
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>, 
 "Maydell, Peter" <peter.maydell@linaro.org>, "P. Berrange,
 Daniel" <berrange@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc34.google.com
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

On Fri, 29 Mar 2024 at 14:00, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> For more info, see https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/ but, essentially, xz was backdoored and it seems like upstream was directly responsible for this.
>
> Based on this, should we switch our distribution from bz2+xz to bz2+zstd or bz2+lzip?

I think it's reasonable to drop xz as a precaution due to the
long-term control the attacker may have had over the code base. I
haven't researched the alternatives though.

I CCed Michael Tokarev because he looked at compression formats for
distributing QEMU recently and may have thoughts on which alternative
is suitable.

For the record, I confirmed that the following QEMU servers do not
have xz-utils 5.6.0 or 5.6.1 packages installed:
- shell1.qemu.org
- node1.qemu.org
- ci1 at OSUOSL
- qemu2.osuosl.org

Stefan

