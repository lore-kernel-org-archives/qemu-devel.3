Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A83C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHtw-0003Y7-Du; Thu, 23 May 2024 19:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHtu-0003X0-Jc; Thu, 23 May 2024 19:31:10 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHts-0002OB-8g; Thu, 23 May 2024 19:31:10 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-6819b3c92bbso228396a12.2; 
 Thu, 23 May 2024 16:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716507066; x=1717111866; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DjbSu5rGzjSF47NyHjrNVidyNNfJUVIM0PP6ou/18N8=;
 b=AnFaHGrfRZDzyt8h3X9roF+LWF8e8qggANlCp8DNXGJtOUwuF4jvgw1RXmov5yzLh2
 17eZLhNowgMoZFf85PMZYDOdQGaKJJYwZrK1tZ/b3fNFgWetT2IL3KpwkdbPao0PXpPz
 4xagflnhWuJee2RI2TFa6Y2fYOJK8TT5mRTf/cuMlKRV/r0ouYDUWiBvI8ouBj/os4e1
 Exo2rVdn7IVknxHSAhB2Y3+caWWkXKqDlHsKuF7P17NLxNEGXsRlzMFM2CIdnwGBdxQs
 M75375/UcpAKRCi6/Imos8+EL499k25pnHWUPr51l5YjXaqPUiFrnarMFT9JbX9gPeWz
 4Eow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716507066; x=1717111866;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DjbSu5rGzjSF47NyHjrNVidyNNfJUVIM0PP6ou/18N8=;
 b=h9/ddO0PjqyotQtGhB7M9S59SE2EaJRVu4/LqVW2GxkZ/MewJ5OnEFCfv5j7bkqlAX
 5KMeWwd2fGhDwonslNv4sISsrZG+J7XiXjF58D9TD/sNfsC4V/PdX9Kjwvjq5OgSYL8D
 DDIHmr/aE4h6fJ+DWYlOWKm9piOrYQEnrxul/1nD+WlZlh5HIHGApNztKm6R9INUJMy6
 VnK3HTCbmk5OYiAkk40KehHbIsjd8l2m1yCkw7YMNqXHE+Y89UASTwvugKwOgRUvTkFr
 6ZTfGcaZfU92wkD6ZlWg+Gl65jYjRcBRGnIh7zWBY3NrUGK2nIbECA2ClxJaxfse+0mB
 ctJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkbjGvM7DDeK/vEEZ9Hr9OFfgnLTkp4179ApBXImaDAI2FyaUFNjhTNBeCpaPHrlTJxMG1RbFFXC6ZGUm0epqWZ8/+5aM=
X-Gm-Message-State: AOJu0Yx+uAwwBXSA4fs1h6yZnOGJwPGySgSHtbaNNXEVkgc/sMxBk7QC
 7ZyVaa6FmZfNNcaYWz56mjFkTizqHL8rzwUELT4d8ozVhN4wURRZ1b55Vg==
X-Google-Smtp-Source: AGHT+IFS3u8xAmOheusrZdTYLa2QhwhaBcMIBqyGXwA7E0kOM2Rbv0qBZ7/Qw/oeF6x5XFM5ILmNaA==
X-Received: by 2002:a17:903:230a:b0:1f3:1afd:b150 with SMTP id
 d9443c01a7336-1f4486ed41dmr10867665ad.19.1716507066451; 
 Thu, 23 May 2024 16:31:06 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7cea47sm1305925ad.113.2024.05.23.16.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 May 2024 16:31:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 May 2024 09:31:01 +1000
Message-Id: <D1HEYY14K1VR.2NNF50M4GU723@gmail.com>
Cc: <qemu-ppc@nongnu.org>
Subject: Re: [PULL 00/72] ppc-for-9.1-1 queue
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523230747.45703-1-npiggin@gmail.com>
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52f.google.com
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

On Fri May 24, 2024 at 9:06 AM AEST, Nicholas Piggin wrote:
> The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b=
83:
>
>   Merge tag 'pull-tcg-20240523' of https://gitlab.com/rth7680/qemu into s=
taging (2024-05-23 09:47:40 -0700)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.1-1-20240524

[snip]

> Glenn Miles (4):
>       This commit is preparatory to the addition of Branch History Rollin=
g Buffer (BHRB) functionality, which is being provided today starting with =
the P8 processor.
>       This commit continues adding support for the Branch History Rolling=
 Buffer (BHRB) as is provided starting with the P8 processor and continuing=
 with its successors.  This commit is limited to the recording and filterin=
g of taken branches.
>       Add support for the clrbhrb and mfbhrbe instructions.
>       Adds migration support for Branch History Rolling Buffer (BHRB) int=
ernal state.

The BHRB patch subject lines have gone haywire and I didn't notice
before now. Probably my fault. Hold off and I will fix and give a
new tag to pull.

Thanks,
Nick

