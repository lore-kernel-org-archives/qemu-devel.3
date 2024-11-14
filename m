Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6FB5D6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBf9F-0000t1-Vk; Thu, 14 Nov 2024 14:04:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tBf9B-0000rr-0H
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:53 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tBf98-0004u8-Ct
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:04:52 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9a850270e2so187150766b.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731611088; x=1732215888; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eAlkY0SrG6nNoaQnHneJ7uNwf4ukxrQw4UBooV46V7E=;
 b=Ne5FnXezeefNR10HlB3rh2qXWbqn6uLGbkg9npOU7L0GKNL9cPVbjzDYE5mpJFv0uK
 PqOxthcHGjm/b2T/qz1BKRStyj85oX8YnRsOnRfqRnoNInr8J5AjDbD89IaaaFR8f6Uc
 xgxmNk1XOtIlBzXIbGsT+7ctTBBV2/s3KQEi7b0YNrCIhgcIWZ4z8V/TynuT7EIhgJLf
 QAhiq2OOillj0KG2e/mXgkwN50T/3gDhI4d7rl4N83Tq20m6LcpRGE+7oOV8Wy3jPK52
 aACEw7vNbOx5HIcMskHuVeuRtcGD2ifMYUvM7CyAls7dJTSWGgTW2wwntFVnoXIhDWfj
 nljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731611088; x=1732215888;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eAlkY0SrG6nNoaQnHneJ7uNwf4ukxrQw4UBooV46V7E=;
 b=tOeghgQBdV0XzZ8nveBYXufVmQC9PxR6HbrJKgxPHjY1n1+m4IVTx07QA4uFmbzBwc
 +EiEXWVtSq3gcLjkNJwLeUrzmYkeAgOTPomibRxL2VJecDVOzM6Jc1DyecNLHMumTXjk
 izZ3Y7v6QYIB02n+pJqhDtZFnn/o5tKDYApXiwlA33bvgANCXCF9JKs6fxYuFQkbyOdr
 d5NBy3wmGIZG8S/rwLJSR+zW2Q/hgJCKjK1PlRbSi5+e2i+/t8RQNXVXGBoCYbIBXUBU
 HoePBhA0aVk/4eKlr/zYbdD67CeSTZ8UyZtnumpE9nICUzerKkcB1oWgocvPdtNb1j8B
 tUrw==
X-Gm-Message-State: AOJu0YzmlhtGzwdPgSPGPLIMenlwSARkizUILJAj8BmO8m9n9sqAr3yk
 0fdVOpSUlnXyZPJWOe348lEv2Tk1a4gh/1E/vTf3cfkVNfMUON+IE/twN9eZGJzIAtsQFCZ+rh5
 9g572vwqNHOtflO/yi5bFfgHoZQE=
X-Google-Smtp-Source: AGHT+IEkT1+1BrriMJdreH4qtR42GbHvIvPjHznYYkZSg3k0ZjdM7kXqWH3BZ403GwhzUKAys3zOK/R43EFvkKYWqi0=
X-Received: by 2002:a17:907:d86:b0:a99:4136:5b07 with SMTP id
 a640c23a62f3a-aa20cdf58acmr315662166b.60.1731611088212; Thu, 14 Nov 2024
 11:04:48 -0800 (PST)
MIME-Version: 1.0
References: <ZzXV-KyYLa-7yNdV@redhat.com>
In-Reply-To: <ZzXV-KyYLa-7yNdV@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 14 Nov 2024 14:04:35 -0500
Message-ID: <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
Subject: Re: QEMU wiki theme table of contents changes
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x629.google.com
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

On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> Looking at
>
>   https://wiki.qemu.org/ChangeLog/9.2
>
> I'm thinking that I'm sure there used to be a table of contents present
> at the top of pages, but none is to be seen..... until I eventually
> discover that there's a bare noticable, fully collapsed ToC in the left
> hand nav panel below all the general wiki nav links, partially off the
> bottom of the page :-(
>
> If going to https://wiki.qemu.org/Special:Preferences, "Appearance" and
> selecting "Vector legacy (2010)" as the "Skin" instad of "Vector (2022)"
> then the full ToC re-appears at the top of page in the main body content.
>
> I'm presuming this style change was triggered by a software upgrade that
> was done on the wiki at some point.
>
> IMHO this is quite a significant visual/usability regression.
>
> On wikipedia, they do have the same theme, with ToC in the left hand
> panel, but their ToC is expanded by default, and there's no other general
> navigation in the left hand panel that's displacing the ToC off the botto=
m
> of the page. That is fairly effective as a layout.
>
> We can do something to the QEMU skin to improve this ? Swapping order
> of the ToC & general nav blocks in the left hand panel would be a
> improvement, as well making it expand at least 1 further level by
> default.
>
> If we're going to have background colour set for the general nav block,
> we should also probably do similar for the ToC nav block to make it
> visually stand out to the same degree.

Yes, that sounds good. The quickest would be for you to:
1. Run https://hub.docker.com/_/mediawiki/ in a container on your machine.
2. Adjust the theme CSS until you are happy.
3. Send me the tweaks and I will apply them to wiki.qemu.org.

If you don't have time, I'll add this to my todo list but no
guarantees when I'm able to do it.

Thanks,
Stefan

