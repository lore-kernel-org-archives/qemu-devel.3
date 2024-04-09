Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA412C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 14:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruCL9-0003JO-PH; Tue, 09 Apr 2024 10:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCL3-0003FM-PS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:20:42 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruCKy-00080w-7o
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 10:20:40 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2d8a24f8a3cso13021091fa.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 07:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712672425; x=1713277225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bh0vcG6kJYrUoDXUNLp6n/+3ljFH5f0FoB6Tly7VsmQ=;
 b=n0Oj+QHUsKz1kVd3Mytea7yw02VdOEwQ6bHGq/wn9OFzm/t+XoPnzixWvk28M7lxz+
 Y8NOjLx4p6GPAiySCFFe9AHsjmgoLMX3fSb73U14vAFtfzrQ9vU0RQbdnhcjsnjV6QMg
 c0bashdzMKocyod0iC6acKUwwlLP3KJGBZXjngpby0lt+YVa9S/aKydz0RxwCvJbdw6f
 wWion9dVkyrA/pon4mdzDMizf503XJAB4lsNzdh1pvluM6ak5H6vsFwosGLEB9VsoFzb
 9z3UG8awwQAk6/7Mv7+uo7I25/mzX/BOzTuxs1zJFxMWkoN8D28s7DqLNXhkiKI+8kyI
 Xs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712672425; x=1713277225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bh0vcG6kJYrUoDXUNLp6n/+3ljFH5f0FoB6Tly7VsmQ=;
 b=wWd1SlnWXrJ8RLBmDUAnQ7Sr/Hd+UYPRt2PlYxueoEDljVUJdySAgZab/sbofAVHWI
 +EbNERMYCJnid4khnuEWy4l9drAIaivUghRK515X1cPbVkE6ZEJumZ1Tzk1CKrCCEVbd
 kQUNGmFPKgkLJ6b/a8P0dv5oXqoCDP5K9K/nbNl4pXXoDFw6ZfuMF4N8WM30kPytlJcn
 wPqYpNLtnxmAcZl2ESHmamgIitXiX20z11gfHUYEwK0vX1iqDL101PzxvlyPakVFxBCC
 KsB687hshnO+hMZzRdX+hESBBYvM44LhfMN4YmDbpl5PXJuLzrz8j6CZnznorW3BB/Do
 /K2w==
X-Gm-Message-State: AOJu0YwUB7f0OI/srbCTJtqqgX3NTHj5s7+MC8auuAZ0paTt29qKp2CV
 uC/WNGTzBo6M3y+LWTRa1x9HRTPct5B7mwpGw88tm8+t826bFrVpH4Go9EGAVwFkH/IREf/kQHU
 u3E8ck18X15yCBOIs3elQmAp44PoYfMV0aB1LJA==
X-Google-Smtp-Source: AGHT+IGBGT86BIEEMzmGsBEIe7jrzYc2FEBTrtcO71a2QUOEfGQ0S4/pp5a+Y3vmEMlMKEHvIn3UzEFSBLx8oGcOx38=
X-Received: by 2002:a2e:9b14:0:b0:2d8:ab48:da6e with SMTP id
 u20-20020a2e9b14000000b002d8ab48da6emr1008183lji.49.1712672424984; Tue, 09
 Apr 2024 07:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240327102448.61877-1-kraxel@redhat.com>
In-Reply-To: <20240327102448.61877-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 15:20:14 +0100
Message-ID: <CAFEAcA8=W+HGpN0tfW+CfOd5W94GHnY+=B0y5EjvE3WWC9kqUA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Wed, 27 Mar 2024 at 10:26, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> v2 changes:
>  - store version information in git
>
> Gerd Hoffmann (3):
>   edk2: get version + date from git submodule
>   edk2: commit version info
>   edk2/seabios: use common extra version
>
>  roms/Makefile     | 25 ++++++++++++++++++-------
>  roms/edk2-version |  2 ++
>  2 files changed, 20 insertions(+), 7 deletions(-)
>  create mode 100644 roms/edk2-version

Series
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

