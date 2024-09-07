Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E84E6FE55
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 11:02:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smtBs-0003Kl-Kn; Sat, 07 Sep 2024 07:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smtBq-0003He-Hw
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 07:01:14 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smtBo-0005Q8-Ic
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 07:01:14 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5becfd14353so2753039a12.1
 for <qemu-devel@nongnu.org>; Sat, 07 Sep 2024 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725706871; x=1726311671; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+A/mzqRtw+C1SBNAwF92ovawb7dXjIfen4Dta0fCigQ=;
 b=E8QgfdG06aC0zbChylfoWb0u0aPL6P5deU0HzY7yopianPA5/xQxbQNeoJcnAbZwKg
 HZdNba8dokIznV+iEtrD+yRTaqa+V3/e47G70sR/YTpXP/uGp09xkKZVJIbdtWK1/58L
 663RsMxU/6L3c+7T/TOTdOw+ChlLpsSeEgmI59OZWDh0s5eqfqmWDrS/EEi+K287L6je
 d6jDB6pcNFlKQkm10RvlnChUVkP59ACy8vItc/7VbbyKSW1IgxeYESsQnXIjXMXUdpB0
 4zZWrOnXrEDNC0Qup7YEhLcq2crQuxaQhsuwXODzJjaB3BF0NzzuQSs4p0Sli8N72mCe
 FYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725706871; x=1726311671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+A/mzqRtw+C1SBNAwF92ovawb7dXjIfen4Dta0fCigQ=;
 b=ZBRJuAgDxGQG6UDhogWP4LD+zDUpJMseUArVVhjtyVKro8lN01HNHukfdJIzBxaYvA
 xTUcA0P+x+noN5ATTqpVH68XdDRbzXgzYEOU2KEHNjj2wXIWr7iNcQ+NfIjYNVdVrHBw
 PXJEQ1VbzCtJylU9YM4xaZwqvEKGXChvn4wqeRd6kjhOF2fdt4lmpjs5OmnciBIG37wC
 xZNf/yyJNet1RsPn7UI5R71Qe+9K7/N3caYgdOOEcTiTqXkVNF63dob15HIFN4WynaMB
 9g+jsojrQjEBE+4kEo1Gdtuk3VxA+tjj4Vc2JTIKlgvygw29c2SZj4sUNKfINFXyCgs3
 Sl8Q==
X-Gm-Message-State: AOJu0YyDnoQdlWKQWkV/RlmgoVlw0+qWGkHvS28CKv2UyoFS/bX/y4NV
 mRRXtYjrYO0XKtuAqYleCA7yr1I6wNUv9bJDYbgY8v6oGBLEjjq/Vkjlq3eThuYvuwE/2xYH8wD
 FXkpi3hHc6KukdMlBxMH2fqYoI2SyfJxzXH9Pbg==
X-Google-Smtp-Source: AGHT+IHDdYPAtbNCIgyuR83dP08HGnmE2ntrtoogKlIHNmB98AC+wzQrPU8GFE9Suy0h4ZTcgrS9xioKnsk/M+P5UGc=
X-Received: by 2002:a05:6402:2345:b0:5c3:cd1a:144c with SMTP id
 4fb4d7f45d1cf-5c3eac276a8mr1031245a12.32.1725706870742; Sat, 07 Sep 2024
 04:01:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725619134.git.jeuk20.kim@samsung.com>
In-Reply-To: <cover.1725619134.git.jeuk20.kim@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Sep 2024 12:00:59 +0100
Message-ID: <CAFEAcA-HwrgaLZas6gSKQY=Qw7_VLMj1NKbX1U659Rfi2qbPiQ@mail.gmail.com>
Subject: Re: [PULL 0/5] ufs queue
To: Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, fam@euphon.net, pbonzini@redhat.com, 
 qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com, 
 jeongyuchan0629@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Fri, 6 Sept 2024 at 11:58, Jeuk Kim <jeuk20.kim@gmail.com> wrote:
>
> From: Jeuk Kim <jeuk20.kim@samsung.com>
>
> The following changes since commit 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4:
>
>   Merge tag 'edgar/xen-queue-2024-09-04.for-upstream' of https://gitlab.com/edgar.iglesias/qemu into staging (2024-09-05 13:02:26 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240906
>
> for you to fetch changes up to 9fe8e2c68ad99e503a11390b868a7dad846e7a0d:
>
>   hw/ufs: ufs descriptor read test implemented (2024-09-06 18:04:16 +0900)
>
> ----------------------------------------------------------------
> ufs queue
>
> - Add basic info of query response upiu
> - Add more qtests for the ufs query request
>
> ----------------------------------------------------------------
> Kyoungrul Kim (1):
>       hw/ufs: add basic info of query response upiu
>
> Yoochan Jeong (4):
>       hw/ufs: minor bug fixes related to ufs-test
>       hw/ufs: ufs flag read/write test implemented
>       hw/ufs: ufs attribute read/write test implemented
>       hw/ufs: ufs descriptor read test implemented


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

