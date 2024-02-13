Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CD7C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 14:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZttN-0001wB-5Q; Tue, 13 Feb 2024 09:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZttL-0001vC-9Q; Tue, 13 Feb 2024 09:36:11 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <groeck7@gmail.com>)
 id 1rZttG-0007gg-3N; Tue, 13 Feb 2024 09:36:11 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6de3141f041so779398b3a.0; 
 Tue, 13 Feb 2024 06:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707834963; x=1708439763; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7t1dihOXIwRG3FeUSJ2Hdd72z/vSowiOa+3IV49xtMo=;
 b=LNQ4BI8GKpBMpDxXFRq1vDli/gQcdgtBoJJjJMuYmXcbm9gZmR/ItTtJtNFFKUjKxH
 rRlvjs5TGKC5dTtDKxMZQGK+MuRYaEEy19L9aFgwIsqvJ/PtksVWe97NaVaweO3ddUg1
 nY52RUXLB3zBxBx7+Rft8oPydBzwo1Go8Wd/n4EVPnAo4IsjhrEv5VnlXbkdWiVi1pEp
 U7wReVf0R9IbhW+t6+45nV8VYCzwfG0FOU7/YBwerG03upTIxo7MU3ZK+hs22kxRdQwv
 5h7YkmS/l7fk8FPkWNI2++BUQD8E992mIjp74Jt5lbE3TApD/cnkf5PHMV/jGAS3KGVF
 fbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707834963; x=1708439763;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:sender
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7t1dihOXIwRG3FeUSJ2Hdd72z/vSowiOa+3IV49xtMo=;
 b=bYhr1aMVaZhkFPR8rV8apItdb6f7fsDY0glTL6aKwJQTNZGk0zCcvUyAGBnU6ySQ+g
 SadvZqQsVAa6HO8MfPQaFUfogyCZwz1QL3XDVRNmOy6oPR6lqsWXw6b8O1WMbX1XNVvI
 /pBnuPRhsaI2JPs1jf2dmZK03ljb935W610MQr5yVxZy73qvxLt/nU6E3+rPnKYYTylV
 Ihw0/6FDnn/fV9slZxtdqeuxZldbM8A1y9cZcJG5vrHnHW0O62XAiNDacq3ZL3qsSSTT
 OPm2i97Ypgye0Lsvc/ygfI95+Iv3EKIcP5q5gzowl2XU5Qmvu0RvTUoxvIwKoSJY7ua8
 Kxrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7cEPHNr0YSb2LJIQB+gcT9nWABIreiymnX6oqgVpg0KbE9L7RVJghWpssySFyjhi8doiujnHFdrttXIHtsTGP8rzX1Fo8Hz/uIYR3phASvkQOa2vlI+7YhbI=
X-Gm-Message-State: AOJu0Yxw3oszCoxqueL8xx+zuBtQl92I8Di0s1+y7gTtsQ1OwJ8D81gJ
 Mq7JwC0V/Mwx/SEOTEzkYMjAfG4nAkZdSij7Dk5Pyn2+jtoPq2cw
X-Google-Smtp-Source: AGHT+IGy9hDoYViel8THQI939w4c1rW19XvjAt9mieFFKgDZ6ZznQtt2TMohY7/obWaguvrFEFS8zQ==
X-Received: by 2002:a05:6a00:26c9:b0:6e0:f287:d744 with SMTP id
 p9-20020a056a0026c900b006e0f287d744mr2943885pfw.19.1707834962560; 
 Tue, 13 Feb 2024 06:36:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWc0rz2wdReiV0TFaVcz3NbZQxtlYw6HN53RcDrD0Z9HmyWZ5zy5KH1aasgdEfObHbkPJUWyMtnpwaQEfC9wTl0x98m+2YM6kBzZ9CJpIoYO+qIAK5uGYcvOB0=
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 g1-20020aa79dc1000000b006e09aa8c50csm7223066pfq.53.2024.02.13.06.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 06:36:01 -0800 (PST)
Date: Tue, 13 Feb 2024 06:36:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Subject: Re: possible deprecation and removal of some old QEMU Arm machine
 types (pxa2xx, omap, sa1110)
Message-ID: <ce858803-84f8-4fc1-96ac-75914da98905@roeck-us.net>
References: <CAFEAcA88UGhjh8-iBvhxx6GdWg74dinYouiguTcz=qEe51L7Ag@mail.gmail.com>
 <fe5476c7-82e0-4353-a943-7f39b14e1b5b@roeck-us.net>
 <ede43fd1-9005-4f02-9494-73cfd898e3a0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ede43fd1-9005-4f02-9494-73cfd898e3a0@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=groeck7@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi,

On Tue, Feb 13, 2024 at 02:42:29PM +0100, Marcin Juszkiewicz wrote:
> 
> > > The one SA1110 machine:
> > > 
> > > collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> > > 
> > I do test collie.
> 
> Can you share kernel/initrd/config? I wanted to boot something at 20th
> anniversary of buying one but was unable to build anything bootable on
> either QEMU/collie or physical one.
> 

You'll find it at
	https://github.com/groeck/linux-build-test/tree/master/rootfs/arm

Essentially it is collie_defconfig plus some additional configuration
options (BLK_DEV_INITRD and EABI are essential), and the rootfs is
rootfs-sa110.cpio.gz. It boots from initrd. I never managed to get it
booting from flash.

Guenter

