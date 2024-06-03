Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46415C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEA4z-0001tZ-Hp; Mon, 03 Jun 2024 11:58:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEA4x-0001tC-7l
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:58:36 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sEA4v-00066F-GC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:58:34 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a4ea806a5so1116777a12.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717430312; x=1718035112; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IkXRBjCiVwBNove+mdDr2vPl3be9oKjqSGBYIbA6FPg=;
 b=SP7zlKFN6qY3yXpscfQuegl6LiZLA21tC0mr6lsJ9jdWF4wVtc4jzZsqviQiqJqy0E
 sA2/rNZMDfnZ/T5mNqVuvSNZB3D9qG1VE+z7E34nsCjfEXUiNX8/wTWrUAysHxd4XPgB
 eIjpRBosg+QOz/KTiooaWXIU6zc7zb0W/+/pOwkWUUni5yo9GcRhvPORNp9DF6O2vtsg
 fyt7SptRL863pmUcx62WUKJLv2PH4MZ6PDsnWueo22wm0I7FEMIek1EnrYlaf6BeNjd2
 c7w6KcJ/nBvfIdwMA+/2PWdmUsLT+CI3pdpEDJa7iw/3ljKHnSe45yB0t9J4v97jegNW
 T0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717430312; x=1718035112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IkXRBjCiVwBNove+mdDr2vPl3be9oKjqSGBYIbA6FPg=;
 b=DGxSZoigaCg+PJSUydIADrBh5vUgjsCqXejrw6I3v5pLuyb+VDn3k73AIV2U+e3tAk
 gY3b0+eTGorGDPV5VZzjJAssuD2hq7yn0unKmeBJrFC4bqdHNTd0zWvSvQwbFDIU3eRR
 RLhhJZESPIIlLy4+5aVOOSKfNdF/+yXymMFP7HKY+S2w2PXisOLGu3yFsWJvn0YFkI+C
 zqvrE0EFtcbaPp9ECDqJJnihFLEEhpZo42SxGg4MXN+WgFkltLpOt+44lD+AoZ5h0S9a
 r6V6XoLrjClwU1HvVK1UC0x68nGOo+Nlmp7O04UuQp7UHgyYd6pkdMyjHF9Vv29lCCK/
 MW8A==
X-Gm-Message-State: AOJu0Yy7gNQe/gGQWOAt6IbpXqHzz8kECMZBAtzmJ9lAG6rSfVtTkXeg
 e89XLyLLMbmCNCtwWcZ2bB3Ku8xtN1pw5+5Z1O4s8hyWSC5As5DFesqYSwXxQaVxxg3c2qq0ILl
 k24g8eePMtn8ARkoSFE7j+dcfQw8CETWeiSAoO44SCDiAA8oZ
X-Google-Smtp-Source: AGHT+IH49fHT4T9opNCEvfUOtOF2UPYMkgdmUHgcy3Ln4fnpE/wwJwjEgNdiJo6825yatzI3QJFhFBNDF2EV4jUb8U8=
X-Received: by 2002:a50:9548:0:b0:578:63c3:dfd0 with SMTP id
 4fb4d7f45d1cf-57a363a3456mr7923576a12.24.1717430311652; Mon, 03 Jun 2024
 08:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240530125744.1985487-1-gaosong@loongson.cn>
In-Reply-To: <20240530125744.1985487-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jun 2024 16:58:20 +0100
Message-ID: <CAFEAcA_L=WKSRTF7EhW8DEO1=c+KF=NTx4tHVMh2HwNgLnvJ_g@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: Update LoongArch bios file
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, clg@redhat.com, 
 maobibo@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 30 May 2024 at 13:59, Song Gao <gaosong@loongson.cn> wrote:
>
> The VM uses old bios to boot up only 1 cpu, causing the test case to fail.
> Update the bios to solve this problem.
>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>  tests/avocado/machine_loongarch.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/avocado/machine_loongarch.py b/tests/avocado/machine_loongarch.py
> index 7d8a3c1fa5..12cc5ed814 100644
> --- a/tests/avocado/machine_loongarch.py
> +++ b/tests/avocado/machine_loongarch.py
> @@ -38,7 +38,7 @@ def test_loongarch64_devices(self):
>
>          bios_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
>                      'releases/download/binary-files/QEMU_EFI.fd')
> -        bios_hash = ('dfc1bfba4853cd763b9d392d0031827e8addbca8')
> +        bios_hash = ('f4d0966b5117d4cd82327c050dd668741046be69')

This doesn't look right -- the file has the same URL but a different
hash. This causes problems because the test suite on older
versions of QEMU (eg our stable branches) will still be using
this same URL but the old hash. So instead of running the test with
the old BIOS version as they should, they'll skip the test if Avocado
doesn't have the old file in its content cache.

Is it possible for this test to use a file which doesn't change
its contents arbitrarily? e.g. some fixed released version with
a version number. Then if we need to use a newer BIOS version
we can update both the bios_url and the bios_hash, and the
old stable branches will continue to use the old URL and hash
to download the old version they expect.

(I just got kind of confused by this because my local system
has a copy of the old asset in its avocado cache, so the
test case fails for me locally, but it didn't get caught by
the gitlab CI because the gitlab CI happened not to have cached
the asset.)

thanks
-- PMM

