Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD8CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 15:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxVC-0006fX-EO; Wed, 20 Mar 2024 11:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxV9-0006ad-71
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:11 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rmxV7-0006XJ-DZ
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 11:05:10 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56ba6c83805so1726350a12.0
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 08:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710947106; x=1711551906; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5TwREnoFguuc4bHCWYG9YC9AfNOvRRdOdH1BCOSOsUA=;
 b=bJvBBHu88WSA3jmo+OVsHuc1qzNJotCW6pJ/r6lNKzkHM+734i/m45v4PPhBhOec3o
 t7QkhmcyWqPsCQQ1rhNgEzz0INmfUcyttjIwdowVtREZOpk9ZUYKdpFkvwbozdiwNxKG
 KuzM+iTU/6UpahuIaytLdxy3V2w8gZ1kcWts8CeOEYWWLTIhlUaMY2hRWHJegcn4F7Lz
 bKJjQ64iAKAIj9H/8QODtTWsW0/lj0pScvLkGq2p10eMe9cEtFhY0MMzQucB9f5FC9CO
 awmYoo18ux6uwC4WpnSuyzsIHfC3BaEv7Z1gCqyBl1J4eD+RKVQuWQ2d4NBN9Nc/A00d
 VBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710947106; x=1711551906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5TwREnoFguuc4bHCWYG9YC9AfNOvRRdOdH1BCOSOsUA=;
 b=R+W0RvdR9TfbMof5yHtqBIpWiHiLdzQkM0T29VTO2rUhXHEXZ2wcbW56fDLFzHkRnb
 +bq1ISvpPp6rAMuRZFDl65nROsD5PddeY41V9W6n5JRO8VG/me4vg1qQFdu0dkNgWOIo
 AeXjqZFI2ZTw3bzTHnM9AmqtLPeB4pJ4vmiUi4CLsSN5/VvCi7ti7H8Gk0XmfjQnwsce
 JOEpMRyl2T8q2hrD2QRosaG4eZf6tQ2syCaqm1slNCua4SDnpg0TYIQY9EcPaMyyaa6w
 sNB0RlxCZK1V2F9PT83e/o4eat8ClYhZOzMtmbNYiyDgQn+AytT6XAYhTpr824D3bOhq
 441g==
X-Gm-Message-State: AOJu0YwjK41xiwHwvhPtqtI5JCA8+ElWvtytdEDKyuc+CJUAy9DI77YZ
 nq9nJgEJ54yvdtorBCSduTJtfe2UIQgZsjc5EhtYrtG7JCiMVAoZRoJ9wMiHCN9/4lVqjM7VqI7
 iBT6uQywK66apmIASVlMq1sMd1T/Ef4/I2nzy8w==
X-Google-Smtp-Source: AGHT+IEddrE1rvL9rWaqtplkXrJo2J91vi1dOLfPI7HKtxiVBdKXbeWlkaoB1s3fA1GoPdwQqLjqUoIBTWYHeAH6kJ4=
X-Received: by 2002:a05:6402:4290:b0:565:980d:5ba9 with SMTP id
 g16-20020a056402429000b00565980d5ba9mr11018886edc.32.1710947106469; Wed, 20
 Mar 2024 08:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240319202121.233130-1-berrange@redhat.com>
In-Reply-To: <20240319202121.233130-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Mar 2024 15:04:55 +0000
Message-ID: <CAFEAcA-o65bd7JZVu5XjkAz9_05cPhooW7DeL-T_ARP6yGHVZg@mail.gmail.com>
Subject: Re: [PULL 0/8] Misc fixes patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 19 Mar 2024 at 20:22, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit c62d54d0a8067ffb3d5b909276f7296d7df33f=
a7:
>
>   Update version for v9.0.0-rc0 release (2024-03-19 19:13:52 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
>
> for you to fetch changes up to c3b1aa1c1ae66e0174704072b1fb7d10d6e4a4b7:
>
>   crypto: report which ciphers are being skipped during tests (2024-03-19=
 20:17:12 +0000)
>
> ----------------------------------------------------------------
>  * Use EPERM for seccomp filter instead of killing QEMU when
>    an attempt to spawn child process is made
>  * Reduce priority of POLLHUP handling for socket chardevs
>    to increase likelihood of pending data being processed
>  * Fix chardev I/O main loop integration when TLS is enabled
>  * Fix broken crypto test suite when distro disables
>    SM4 algorithm
>  * Improve diagnosis of failed crypto tests
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

