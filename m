Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4EDCE7AAE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 04:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smQCa-0000uL-Kr; Fri, 06 Sep 2024 00:04:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQCY-0000tB-Dt
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:04:02 -0400
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org>)
 id 1smQCW-0002vX-Kw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 00:04:02 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BB40EA4459E
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2024 04:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFA3C4CEC6
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2024 04:03:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
 dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com
 header.b="WFjPD6Dj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105; 
 t=1725595429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7S6xl6WpS9e+R/G7bC51AKYrgMo/fFNTxnvEZxvjH4c=;
 b=WFjPD6DjJMTQ4VwMOh2+Jgq1Cht5ken7/V93w1fkQ8dydfCqgv7RFoQb8RTTVIFamBjaz5
 +EKgvQIzvWM4Ld8OiGPv/7nPJzrc+85PM6JVWqTg8S+bE6SJ4qSvUSCTr9QgcfLkC6IkpV
 951rb7zRsMyzDYrhYjk4AUpG95wZO6U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0ac8c271
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO) for <qemu-devel@nongnu.org>;
 Fri, 6 Sep 2024 04:03:49 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-277ce4bd723so860008fac.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 21:03:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXNBS/UfRzaNHizDqS1EQTYY0MeN0Y/7qoUBJGTl+EbmPviC4Fr+/hcasUQAJXH/3pqqQKo7n4XdcNB@nongnu.org
X-Gm-Message-State: AOJu0YwSbORCym8jMUwmZAd4CgXxKn93B5WqiniVM61pc6qsMSxKa1oy
 dHEdfCAHWMOBHt7gBZ0E5biUUf5fWVntc+cM6XklzvF8X+tSWWyao3/gPnsu6v84k/1nITcLH1R
 BpmjAFGrK46OKh36dG/KOrIW6Ao0=
X-Google-Smtp-Source: AGHT+IGVcMzwpWRqyJvAIRE1eZAyEU/ONSBdFpumZz/X/+Reuv6YIlVxP4zYEBosoo+4xTNsKLTQulRECKj8qBjdEOc=
X-Received: by 2002:a05:6870:1687:b0:277:ec3d:cd21 with SMTP id
 586e51a60fabf-27b824dd2a1mr640804fac.13.1725595428483; Thu, 05 Sep 2024
 21:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240906021943.150494-1-maobibo@loongson.cn>
In-Reply-To: <20240906021943.150494-1-maobibo@loongson.cn>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Fri, 6 Sep 2024 06:03:37 +0200
X-Gmail-Original-Message-ID: <CAHmME9pktfj_OoLYcc5yM8byM73n-68u_B88vUZRXb7e-BHePQ@mail.gmail.com>
Message-ID: <CAHmME9pktfj_OoLYcc5yM8byM73n-68u_B88vUZRXb7e-BHePQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add FDT table support with acpi ged pm register
To: Bibo Mao <maobibo@loongson.cn>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Song Gao <gaosong@loongson.cn>, 
 Ani Sinha <anisinha@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:45d1:ec00::3;
 envelope-from=SRS0=v4Y+=QE=zx2c4.com=Jason@kernel.org;
 helo=nyc.source.kernel.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series appears to work in my testing.

Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>

