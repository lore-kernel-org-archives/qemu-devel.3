Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CEDC25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 08:53:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA4By-0001Ef-7T; Thu, 23 May 2024 04:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA4Bw-0001Ci-7c
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:52:52 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA4Bt-0007ou-9z
 for qemu-devel@nongnu.org; Thu, 23 May 2024 04:52:50 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57825ff689bso3102630a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 01:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716454367; x=1717059167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UkQqWqSIgmcFgMovpKXW8Pr50apYhqx5YIvuRdnyvv8=;
 b=En0VgDr5DdnJi18eX/I3V8W4zsJX64HXpEGYmGVRD8ifbHmWv8fKTkxI22l41hb+lr
 vL8JmMExiswQFdtQRvIw3S6iwKdzKFBekIVunOWfzRSuvODXJ0XagQUBNmPiU2ywqLE/
 ohQeTceccMDX0MLhjJIuLWeMG3dYbhq4KhD4nElGhmepjkFSaTsIGjQhQvc81zf0Jf5m
 8ft1qctk640qr+2datPgNDUyG1z+3D5ynDwOLJpy1QRdAop5vl8ceWD3hJuOsFxyLqht
 K35NvVUEisRxavz8LwK9zYy/8UNrq9rwLCh+zNnyzZHfufImt1wSLhK1r1HxiTJFJuQo
 b+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716454367; x=1717059167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UkQqWqSIgmcFgMovpKXW8Pr50apYhqx5YIvuRdnyvv8=;
 b=XSV9vv9f18sKPy3jC+mpdYM6p84ZTwS4BI76hY533h2tvvbdA+XRNtJaIKlmCOZwJG
 fpW8Lb5LvJ9S8dMJpwOKbScbkiwLTx6suLk9rLeQiGXfs0VTXxfe5KXbC2qh1561LH7f
 dqE6wV8wAgLqKQ0dnr1slFfIbiQ45qnbNNAJz9J+tbR7nYMlNL/n5OMKedsn57NZVJMl
 l8MHrdLlxCISPizwvsBYA7730YYU56XIGSEEMErxpGf4oblUHjwiMNYvqaFrJISyh8F6
 zRHiHZL2Nrefh6M6lixz0WReRjhCE+gHTd6M9c2tML4nWyRNu2pmQXCskINtEi1HkwP/
 hUOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvmbhV8+WaTfQxMb1vwW8NZnnUPe/KLdDM+8IBOV2m6k9ZWNDzYygHY1FlANS+jJ2lMnh5wYhl90J1CkEZmAr4WmlaspE=
X-Gm-Message-State: AOJu0YxlMO13s8OP5lE5cdD5JDvqPZB4wZ5OsmaeTvnnMuhomnRM2cX+
 w6yJszdR3Rq/AoxMhOSx/n6wJc34cwLDU+PnGmiCmuE8Wz657Wu1wZkfm2n7x3evKHyS9IU5aen
 ndFNU/yGZHxLop8tAjWdKWwGmoM0u5OOJvL09dg==
X-Google-Smtp-Source: AGHT+IFgD9+TYgbIIy8RMHWag7va/LxSoVSIpWxcidqOmnsSjCptXW9YzMsYwhCgzKZo8UFoxjW6nW934KnsyLExqUI=
X-Received: by 2002:a50:9349:0:b0:571:fc6b:966c with SMTP id
 4fb4d7f45d1cf-57832a2678dmr2530688a12.13.1716454367051; Thu, 23 May 2024
 01:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240522193016.136866-1-artyomkunakovsky@gmail.com>
 <Zk74F0a8ejAp_mP8@redhat.com>
In-Reply-To: <Zk74F0a8ejAp_mP8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 09:52:35 +0100
Message-ID: <CAFEAcA-jGojmCeE3o=FbghjrSwVWOnKtj-orOtahPaDDv=n2Sg@mail.gmail.com>
Subject: Re: [PATCH] meson.build: add -mcx16 flag
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Artyom Kunakovsky <artyomkunakovsky@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 23 May 2024 at 09:04, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, May 22, 2024 at 10:30:16PM +0300, Artyom Kunakovsky wrote:
> > fix linker error if the project was configured by the './configure --cp=
u=3Dunknown --target-list=3Driscv64-softmmu' command
>
> Isn't this simply user error, with the right answer being
> to pass a valid CPU target to --cpu, rather than "unknown"

I've felt for ages that we should probably drop the "unrecognized
host CPU, fall back to TCI" path and insist that we only run
on recognized CPU types. Then we could also sanity check that
the user passed a valid --cpu option.

thanks
-- PMM

