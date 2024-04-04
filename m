Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A8CCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 17:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsQrG-0008Mp-AD; Thu, 04 Apr 2024 13:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQrB-0008MF-HC
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:34 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsQr8-0005Qu-GM
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 13:26:33 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56bdf81706aso1753318a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 10:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712251589; x=1712856389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/zTVCWSDF1ZJjhhGP3cfwnbVqmsvzLf8Gj97efW4Qlw=;
 b=cnNEuPrY0gG3XnHCJP993SdYVq0mzck2J8CP11aygAsPt53VJgogthO/Y/Ub5GSv1k
 kZOj6mzZMjNeeT/4IwRHiSEL83+z4y8qUWXVmCG+ij3zvH7pneuZ6fBxe10it1VNIfqk
 gUWnXG8rff/i6rAtHl92gVubg5JUNLtZfjSlq1eIERMBaO9RxuSwgU3ht7IdAuxgBEPj
 h4dSdHqWZCXKIpkmPauxbOIrMM0NppvIaps8uCVNg9hlu/dsV4RJtX/vFIT8ozQ5v68+
 eHSP13zsHpcrQfJKbUggxPyJtJSyRfsRqkT2F+Ygk/j0bPm4if4W0Qc1tMSHJu9EJHve
 z7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712251589; x=1712856389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/zTVCWSDF1ZJjhhGP3cfwnbVqmsvzLf8Gj97efW4Qlw=;
 b=jbC8O5q9j/FovBE9Tpih0+Y8Qt4f3Ad4Aw9u1/s6haqW01Yh0XCQ2BDdQKPVVx1oT5
 ACs7RK6w/pY+CeQUAKTGmeKiQaj/jr1oeAlkrUEAv/iD/FBduE9kwnByHsO2F8nZFAKh
 OQnoez7LrfSOs80QQwcp4VfXe+fvruvciHRhUbM6muwNoeLjUNuQwq3MRsR634vZ45CW
 s1hKbD9w+/9EKDzCPGqEdnR9sl7ELFJ3qwZya5hso/CHSHKAE0FZajuOaO2Kd7iQsfyA
 5wunWltj/TBzb+rfwfuiWcst+IGXVA/oO1f6CIDG6KvZr0upLd/DlHzLig1wshLXLY2z
 M7yw==
X-Gm-Message-State: AOJu0Yxb2SgDhs7CqzSu5Fc3aFEIT7e2dp1XEvx8QHrC2VJObbXEhCMP
 j61Ha0ylljBN0cSJvZLl1xtaZYYLVHDUl7n4jYyJfJkRQvJVbxC0wXJY8NCfLk0NP+wTmrmIkwd
 QYVazx7JSWIOIH+wM/9K7sqRXoWPHIYj+DCD2ww==
X-Google-Smtp-Source: AGHT+IHz+pu3lWZemCNfpJK5TwUfWxJXiYlPD2wWOCXOtoTPuePLLI0P7uhJGIkProqwTrZmvcxElN7McdVL69UjGfA=
X-Received: by 2002:a50:9fc6:0:b0:56c:2f3a:13a7 with SMTP id
 c64-20020a509fc6000000b0056c2f3a13a7mr2174811edf.25.1712251588750; Thu, 04
 Apr 2024 10:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240404135823.2654261-1-stefanha@redhat.com>
In-Reply-To: <20240404135823.2654261-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 18:26:16 +0100
Message-ID: <CAFEAcA8=q3E5v+UUysV6tw9E18Ctmn3_oBD8iezdPK=a7sv7aQ@mail.gmail.com>
Subject: Re: [PULL for-9.0 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 4 Apr 2024 at 14:58, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 786fd793b81410fb2a28914315e2f05d2ff6733b:
>
>   Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-04-03 12:52:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to bbdf9023665f409113cb07b463732861af63fb47:
>
>   block/virtio-blk: Fix memory leak from virtio_blk_zone_report (2024-04-04 09:29:42 -0400)
>
> ----------------------------------------------------------------
> Pull request
>
> Fix a memory leak in virtio-blk zone report emulation code when the request is
> invalid.
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

