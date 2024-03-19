Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466ABC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdLa-0007j9-Sj; Tue, 19 Mar 2024 13:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdLW-0007hD-VE
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:33:55 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmdLG-0001qs-PL
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:33:54 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56b93b45779so1403632a12.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 10:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710869617; x=1711474417; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xb2kN7tNLKMZqybzrWSJqalMpAWmlnTYrYR+QQJgOTA=;
 b=mUBftqEyrhPmKkvrGXQMdbbk7eoBAFwRxxMjn7UIEIrIZW1FB5dNAwa+G/C7IDrL7J
 BdB9KnUJxD+AUquwo0B3a5Ps8bGXEHPL1eVrysoMUI3NpJheFVzyXRX3autVQiBQlNkP
 warnxmwhoR1qMShgDaGDJMtD1V/qFtZgEodOm9FghT2rA9MKzOCyJMLOLqDCA73Fhixd
 5pzRcPe4mmAc/CnrDgpgzKG8zEJdwsLWdHGNjt6KrsnIUW/OS254PEQ/J4vWlJBaCQHM
 yY0w2cIwoa4+7/47SV1gHLtUArZs5hTMcfdYPwNUgS8n/u/ctieKFZwV3M8dxAaguN/R
 r97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710869617; x=1711474417;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xb2kN7tNLKMZqybzrWSJqalMpAWmlnTYrYR+QQJgOTA=;
 b=dSx1pyGVGuQUZ11SRjzYGjzi6fdfmWHHIxrEmnmejG/UYd5LMAo0ATX0jP43bWufIU
 X+S3q3Wtfv4U9KdDNEEWOzKgSwaGBiKQABWJ9ragEZXd+fJkxjjvfO6+egUPFRzCfXoZ
 1tXWPNW/yLfJITiW5zPPPLivV42lbQz7v8oKrwh4Rvs0wKcAgUJC3szOhimTgu9tead3
 kkSbLJatvGThhAaw25dkr+hK9dROHuRaACq3dE1cLw0tyvYKvb/liY7DHTf362Fcqz0V
 9kAUDY9aYXleSbebbThknrr3RboF3DYnMeneZbaNk/4a1cfM8q+XV8cVj8jmCaH2TJk+
 kFhQ==
X-Gm-Message-State: AOJu0YwRyXs4w+NgWF/+/95Jhd8uuYKi4RDEgZmPci2knEF+F7RL9uGK
 tHsRpYwwAwInPlQ7b1upwRF5zSfmf/QcXLi2b1Ce/z3JI8SB6A0L+WVuMiMEGyul6zBVF78zI0E
 xu1Cz3uwWAO7cRVQWQahshNInGxi6+okslQZYLQ==
X-Google-Smtp-Source: AGHT+IFr1NCaKnLF2UfX+CT2rbVQw2mBl9W6qTgBtzrXPDaMGDD+o9DPhw23yJSLYAZHgmkJNLoxBEf2Ujwpp4cv9Ys=
X-Received: by 2002:a05:6402:1512:b0:56a:2c28:dd86 with SMTP id
 f18-20020a056402151200b0056a2c28dd86mr3997768edw.23.1710869617104; Tue, 19
 Mar 2024 10:33:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240319140516.392542-1-clg@redhat.com>
In-Reply-To: <20240319140516.392542-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Mar 2024 17:33:26 +0000
Message-ID: <CAFEAcA9YTne-VJ9htBU9zvy+_fXjEWM_LZRQuxJ2y9am-c1gWw@mail.gmail.com>
Subject: Re: [PULL 0/3] for-9.0 queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 19 Mar 2024 at 14:06, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 4511400fb78e72d4d9916ed60e04f4e99e594f=
65:
>
>   Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging =
(2024-03-18 17:16:08 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-for-9.0-20240319
>
> for you to fetch changes up to a7538ca0791880b6aeb2cc4cc8c00305e2d975f8:
>
>   aspeed/smc: Only wire flash devices at reset (2024-03-19 11:58:15 +0100=
)
>
> ----------------------------------------------------------------
> aspeed, pnv, vfio queue:
>
> * user device fixes for Aspeed and PowerNV machines
> * coverity fix for iommufd
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

