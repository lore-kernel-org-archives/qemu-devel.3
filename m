Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31DE8C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 10:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwgGW-0007Sx-62; Tue, 16 Apr 2024 06:42:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwgGV-0007S0-4c
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:42:15 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwgGS-0006L1-9Q
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 06:42:14 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e136cbcecso5038370a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 03:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713264130; x=1713868930; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jts7RJljcAJzJ5tlB8psJCSHWyQSowHeuECRHNUCBhE=;
 b=vfUVCAeMX80geXVE7A6oOoXmQkPr0eMaTpVDBEczxWyE760ljsALQ1iJqddFkkK3S3
 Px6v0pyVoXkFlrnlWxsEAr5Yg+rIbZLZO6qf8o+Z3Iipt7UnUPKXTnikL57Qa+cqtgbG
 AbjTwmctL3aLt0qbSVdCJtljiLzxKtEkY+ItJk6p2zODwlzbm74klJ0skoppCAV74Ooq
 +idg4POBvXnm2i1RVIJFe9yYTlFb4WJ8+1CzDf/AyBp4B7goO0BeGfbz08qZUmI5v/Ql
 nLzKnbzV91iV1ywrv7lBzBSp8YFVMc5ZJBo9tjbHKLMUC+s8betllCGqEmBRTESDeuWN
 yfkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713264130; x=1713868930;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jts7RJljcAJzJ5tlB8psJCSHWyQSowHeuECRHNUCBhE=;
 b=o+eoP+cwH9KZEwfCBgcz/ZdPU5rKFgKJLgWPu2JNZ9z5qZmtIShIAj8GrOvc71ouy1
 rUrEhHBQl6SYbosymn+KYRGUVI1LOxjOotvTyhsAE1clGwvfWOnU+Ya/IGYnNA9Ob9KT
 B8Xj9ieo6l12n5uRq9NVfn+MuRqa2E4qryJolz/7TAOQ9aztF+aNBFT2+mRRDV1wMVDy
 ZiMuM2feIONdw6h512JNsqBzbn4Yb7O0UxMTEvzNy2TAgHBfK04U/6nJPKHQgXuj+qVQ
 LfkDp9/NErZlv/1aFgTDbwRL4b48jMbXIjvPB7py/xXpRaimdal85WJcQgTCnClxfRMX
 y6/Q==
X-Gm-Message-State: AOJu0YyrdAo2KfGdERYFi97/mIKCr7JpuOPWGZB9/ELYcKc72mvURK+3
 OQtxj33DJZFnyfQBfboKDsTT1IZN4gTAGsTFkDLyVEcBoO24PJ9V7KiR0UkMsH++8slJOHdu6fy
 fd0BKfhW9hQMi8Hbl5LEanf+YtrcxpBQiw+Eefw==
X-Google-Smtp-Source: AGHT+IFH+B3Ws6cOPFohIq1888aEPa05L9z19q1iNAwvTwgV+i18vSpxMK2xHkhYZuzebL3tvRx1SbMnrR8xCPZzuDs=
X-Received: by 2002:a50:d642:0:b0:56d:fdb3:bcc5 with SMTP id
 c2-20020a50d642000000b0056dfdb3bcc5mr8068575edj.12.1713264130537; Tue, 16 Apr
 2024 03:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240415145506.48179-1-philmd@linaro.org>
In-Reply-To: <20240415145506.48179-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Apr 2024 11:41:59 +0100
Message-ID: <CAFEAcA-9BAK1NLgZyCd8DHUV4_nOw6-fB=knxfaDa==UA5Gm=A@mail.gmail.com>
Subject: Re: [PULL 0/2] Misc HW patches for 2024-04-15
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 15 Apr 2024 at 15:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The following changes since commit 824ebb92c39920a65b34a93d1bd462baf0d2d1=
74:
>
>   Merge tag 'pull-sp-20240412' of https://gitlab.com/rth7680/qemu into st=
aging (2024-04-13 09:43:46 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/hw-misc-20240415
>
> for you to fetch changes up to 6e4aceba2079e3df42edc89d44f4ee02343bb09e:
>
>   hw/pci-host/ppc440_pcix: Do not expose a bridge device on PCI bus (2024=
-04-15 13:07:15 +0200)
>
> ----------------------------------------------------------------
> Misc HW patch queue
>
> Fixes for hardware used by machines running AmigaOS.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

