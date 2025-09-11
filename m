Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D853CCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 14:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwhyw-0004b1-D9; Thu, 11 Sep 2025 10:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwhyu-0004al-85
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:09:00 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwhyq-0007Dd-O4
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 10:08:59 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso7829575e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 07:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757599734; x=1758204534; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aTBYpeWpRcpn3QYpU/qHAIgWkHls+eOmyBWAA+K3WSI=;
 b=YGHiWWRPcMBYMO0p0ZpDRumRPb5T6DckRDaTSepC46y7RxsK+UJ0kN2KruDuqshxw+
 +ORBtwmyneNFp0Ozryj9M7LTOL23ifMmVC0akq706Hg4PPvvqfqKurHZHa6FKrSHO94H
 9aK7WaztG816K9pFavDc4QzEHrgEJymalfbS2FlILEHYCErKhdCa79/Sexne9hPPkTXR
 e7iEMfhoL1MpK4iijY3SQL/L+TVqTTkwCia2Ncfw3NbIgXRgJR6EkJ/XmtPTigAO679v
 wsUoaeapRX8MGhPA2YoEYaJgp2fsN+y1ggrU0Yu15hCxKAuIGYxJ7+8ScrJb+C4SUPvq
 wjRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757599734; x=1758204534;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aTBYpeWpRcpn3QYpU/qHAIgWkHls+eOmyBWAA+K3WSI=;
 b=O3WHh13WKw2gGMGWZVhQn62amRIJQfMk37SWz2puyMf/Q8vZ4hbC8AxCpDWZrpEKx7
 au9PCaSs9eGqGbkdOPaPGiZL3AJQv0b5S3RvE/666ihN5PXLg0clrwN+a7hQ7cd7ELny
 n0l80q5DydTJiGy6EBoeCuqpC/VQA2UyRae32GCO2LuQOQ+AqoqRvzrpyMnshh/if53g
 EEbf06syBo34Lf/VXzEE9qa499ILToE9nNi8Vf5e8t3IJEUUBhqM41vWntU4KF2/VWzN
 DQZlbSzcS1HHu5zPgUZeNSfw8m4MyR8POnqQ4KwBlnPMkKqTgDKTkNxqcCJb3WU9hQDn
 z1sA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMO7xz+1vg83zkqttkB3tv7ift8wxRJrUYFQZzWWBPLHMTvwF35WVOFQVNXgsSwxrd/XsgUlJzMFDX@nongnu.org
X-Gm-Message-State: AOJu0YzJuEo57WrvWM3Lf+54JuYeHlZN4iP3uOE2NopQRBoCRX1diaKj
 p42PVdWryhDrVcmw0LJZWhj8K4B+SX1fJnGkGzeg+lB3WfuEHQ8fts8T
X-Gm-Gg: ASbGnctk6MT7u7Yo6qdJ7FMt0VDnOEeicWI/tbrOPTLXBd/sFjI0sUIn61xDQs4qRL2
 Y9uGfewgW1LJqDRCouCHLXRNU15xZHsjWV7WonIANsxhJNwquE9KLWMPkHJH414ZofDK0i0t0Sl
 8qxw3ig5Rj04SNeTh+4btjMOtBGyjo5oV+EPXa6OZv2Wifis0aO9ebdcIiGiH0LMvNmSXi9Vy5k
 vA7KqFUEwuP7UfAaN4jqB9N9hvrCQRwek8+2+hNmOZfi5PB96Ob41BT2uHrcC+4gBrR2vMrKMel
 y+pRzPGIArk+WicvViZMEPIqsb+evssPzrt+lbH/xptLnySeQzngAu4OXmJEiRnH7Xc472+Mrpp
 fJ4Wd6E+d4JViutbr+lOFUFvLOmRGwL9PgMCuzUm4GigG3UdcjFjMYWhutQ==
X-Google-Smtp-Source: AGHT+IHXLue9sHehHgx9M/Rbxu9ocgaN4x24wHUdN7DD02RpNrTWTlfyOpULrR9BHZAWBTmAFrHnWg==
X-Received: by 2002:a05:600c:3485:b0:45d:f7dc:f71 with SMTP id
 5b1f17b1804b1-45df7dc1e46mr68200305e9.25.1757599733313; 
 Thu, 11 Sep 2025 07:08:53 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e0372ae57sm24355605e9.8.2025.09.11.07.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 07:08:52 -0700 (PDT)
Message-ID: <7eadc2c7030c79923303a5b1b3f2bce0f27ded44.camel@gmail.com>
Subject: Re: [PATCH v3 0/9] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Szymon Lukasz <noh4hss@gmail.com>, qemu-devel@nongnu.org, 
 lvivier@redhat.com, berrange@redhat.com, amit@kernel.org, mst@redhat.com, 
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Date: Thu, 11 Sep 2025 16:08:49 +0200
In-Reply-To: <aMAwL8q0i6pqcAOn@codewreck.org>
References: <20200629164041.472528-1-noh4hss@gmail.com>
 <3913e8227c343a5d9bfcc2ac1f01d9bd8eceac7a.camel@gmail.com>
 <aMAwL8q0i6pqcAOn@codewreck.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x335.google.com
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

On Tue, 2025-09-09 at 22:48 +0900, Dominique Martinet wrote:
> Filip Hejsek wrote on Mon, Oct 23, 2023 at 05:12:14AM +0200:
> > I have found this 3 year old patch adding virtio console resize
> > support, which seems to have been forgotten at that time. I would like
> > to see this feature merged.
>=20
> It's been a couple more years... :)
>=20
> Have you had a look at this, or did you find another way of handling
> terminal resizes cleanly enough?

I had indeed=C2=A0looked into this back in 2023 and even did some work on
it, but unfortunately I had abandoned it before getting to the finish
line.

From what I remember, I found that the patches didn't merge cleanly, so
I attempted to reconcile them with the changes made in QEMU master
since the original patches were submitted. As part of that work, I felt
that I needed to take responsibility for the patches, the same way I
would for a patch I wrote on my own.

Due to my yak shaving tendencies, I got distracted by several things. I
ended up investigating a test failure caused by a bug in unrelated code
(which I reported as issue #1969). I wrote terminal size detection code
for Windows. And I remember there being something in the patches that I
wasn't really happy about and intended to rewrite, but I never got
around to doing that. After a while, I lost my enthusiasm, and because
I had other things to worry about, this work ended up just sitting
there on my SSD for almost two years.

So anyway, for now I have now uploaded my version of the patches here:
https://gitlab.com/filip-hejsek/qemu/-/commits/console-resize-old

I will try to merge it with the current master again, which should be
ready in a short time. I can't promise much more than that, though. :)

Best regards,
Filip Hejsek

