Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FA1C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 14:48:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE8yf-0006cD-8L; Mon, 03 Jun 2024 10:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sE8yd-0006Vb-T1
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:47:59 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sE8yc-0008I5-AF
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 10:47:59 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421140314d5so39654805e9.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 07:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717426076; x=1718030876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hC5oS8qcfqX2YzELOY2dv0gb1qSTe8ALZytLVFrOhlY=;
 b=Iy2D8oIWX9hpoJl++mShr/BN6w3kmtK4/2BakKbUtMp1xXt7UqTdrkrjak6gpRWxNU
 jXJerbZfNp5kd+xbdekVq+GjqNBc3Du48tozrsNlaHDrnoYjX0LTm8eOHcXitOZAWw8P
 fA8AE5lFTR+luE+1seimRzKud7w2YbSOQONNgsbAPGvq4c35VV8grX5AAxaNHW7wwAdV
 /PosNhpR/zHBNw0SSa5e7RP417XbIOgQraWESc8pnL4pOJoVCCBt+qr+7wpDc71ufs05
 VKa4Z1SiBwFjFpDDfjJYhgRpxj4XR7FFPKah//xOw/kt9YBFfSCrmT1gxKpNJcyyovt7
 NEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717426076; x=1718030876;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC5oS8qcfqX2YzELOY2dv0gb1qSTe8ALZytLVFrOhlY=;
 b=eE3niEfLQlTprakyvMwBAXkqOoykfpD5DM7VbO8lN55RIdymeBKtXfgXqqkwLaVvNY
 GEGLRkYhJ2msAX6u3GUa/CN+/gY0GSA+9V34BNS7CrdJzbavPDq5jXZsq7YUpBeoxuYn
 H8RPc0EMLDUr1y+3FsPw99vas948ydCVyrnQY3LG5ZLv6HDHGTVHyallOKhz5q77XN+6
 2Yd+xPQGNxIawDYW8XAHzAkffIYEIlYX3l4XsxjFnNz28gOVhdCjpn0wVCJpd2sLwgmL
 8eMOvw6TQ5bRv39hBpyEphGk7+tS+zKrwFMBnCOstE/OuVLfeSkb0WYjxr8dXNT6r3yN
 MkoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX9G42qqkpL2MsFbN7htvdvcxjJJvzTGPJ1GOKH5N8xoi9uQGZMZLTXkue0Ah5+zaQpQ2u57XbsdJBitRsckQsZwrUSRM=
X-Gm-Message-State: AOJu0YxFUYRkX4OAtJLvxmx3FFaXjIEnYXgWpy3kKZoYYArqzj4SpgdY
 5UZ8+W742XnV3vxTKB2+oitr5829RZnhrkfblrMkxiYCTOC2zV0X3QECpBnwB2gLUPAUQnVGOFe
 j
X-Google-Smtp-Source: AGHT+IGi8Lje8wEL2iXz4QSEGSyT6isQkzbcBsBial3E0kaSBwH/VQLgri57gJ+uKrdQNPLwg7XxuQ==
X-Received: by 2002:a05:600c:1ca6:b0:41c:7bd:5a84 with SMTP id
 5b1f17b1804b1-4212e07548amr84126155e9.17.1717426076248; 
 Mon, 03 Jun 2024 07:47:56 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4213c264714sm45251025e9.12.2024.06.03.07.47.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 07:47:55 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6C2025F860;
 Mon,  3 Jun 2024 15:47:55 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] io/channel-socket: Fix -fsanitize=undefined problem
 with latest Clang
In-Reply-To: <20240529133106.1224866-1-thuth@redhat.com> (Thomas Huth's
 message of "Wed, 29 May 2024 15:31:06 +0200")
References: <20240529133106.1224866-1-thuth@redhat.com>
Date: Mon, 03 Jun 2024 15:47:55 +0100
Message-ID: <877cf6gk10.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> Casting function pointers from one type to another causes undefined
> behavior errors when compiling with -fsanitize=3Dundefined with Clang
> v18:

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

