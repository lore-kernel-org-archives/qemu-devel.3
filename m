Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20103C54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 14:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ribKc-00044x-P3; Fri, 08 Mar 2024 09:36:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1ribKb-00044o-7k
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:36:17 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <justinien.bouron@gmail.com>)
 id 1ribKZ-0008Ha-IQ
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 09:36:16 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc09556599so18717215ad.1
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 06:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709908573; x=1710513373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N14gErMDbvaBw7KJ9MdC2yIJBpsQ+Qy6Rp3hEVKaQ3I=;
 b=OZb+HNTYpav/U2sc6Vz1I6m2dNpgD08oaKYGk4aMyZ55FHFySWv6fF9e7AEcps8Y9e
 83rPyJrF6PzBZQdVA3QZY8b9T7cUfCqz89G7f9w5nrUvo8n9L82qBhEGvj6uxdyifayq
 qoAv3VufCzAHCb6YTRYdEuaLGY9iCKThh4jWPbDJW4EvjAzf8MKbwzD1GTLmU0G9itCt
 EU2XIpYpyaRAL+xl5HckjmPTi3MArzTksW5SL/kCDdKslLbEm+IiCG0gmoQDfTnmkPUU
 MRfMLRNfrFxRJDaZIqxIWIrp0hfX/k1dBkf/0EKLDECcv04VU0eqRNxaS40n9mjtvM1e
 y2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709908573; x=1710513373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N14gErMDbvaBw7KJ9MdC2yIJBpsQ+Qy6Rp3hEVKaQ3I=;
 b=daJiPgUT6aMacFOiPy7zfhg1ZS0gkVEyAZZMjAYZOoHd6ijrHWKU6+gsVuzJQYDZ9M
 ob4gjAJggJV4hjjrg9FA5l9jIu7nIU3OnTU2yWQiHtxtZFP9ZoZNO70KfJ82sqHdqLdP
 pWKDO3uJqL72g0J6DGG326+14d8nzszVo3CTTly48alfwHzcGzM4I5tiZExrqMC7H2x9
 qpBn29dhhUh3GNxQLhOodOtsEpcuSFVsKkPB+2WFWQiOU+PTRcbbaECOtNpp/4o7ldo+
 MsNjmlGvBZzQ/XeR2l03QsrdWQEQ3S4B8nfTdP+yGXwXanzIDwDzf5c07Llo1zEXUhFO
 ax7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5yjSwS4Mx1c8kP5ng+5Z17/X9cF2C5haL5PV5mtsZyv+bPe2t/jKdlt0qrN4JJe/PU4lqEbBiWOFNfR6kxcsu/w3otNw=
X-Gm-Message-State: AOJu0YwWSZnoc5+BSQE10V0UvB+pZvZPJt2tJz5piLnQ9xpq/PpQIbrt
 IAg+4DWZbugf9ciFzxoV9AfYvO15jKlQtg5us+Mvwbn7XPUpehpM
X-Google-Smtp-Source: AGHT+IF0xvCl3QvxG1tuwzo11p5kb6ftnjqi+5s4WKeTkxu+CUyKIzO/6nX51QvPECtGLbfG6tL3og==
X-Received: by 2002:a17:903:24c:b0:1da:eed:f25b with SMTP id
 j12-20020a170903024c00b001da0eedf25bmr13417581plh.46.1709908573256; 
 Fri, 08 Mar 2024 06:36:13 -0800 (PST)
Received: from localhost.localdomain (c-24-7-119-110.hsd1.ca.comcast.net.
 [24.7.119.110]) by smtp.gmail.com with ESMTPSA id
 l1-20020a170903244100b001dc10796951sm16392091pls.19.2024.03.08.06.36.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Mar 2024 06:36:12 -0800 (PST)
From: Justinien Bouron <justinien.bouron@gmail.com>
To: berrange@redhat.com
Cc: armbru@redhat.com, eblake@redhat.com, eduardo@habkost.net,
 justinien.bouron@gmail.com, kraxel@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH] input-linux: Add option to not grab a device upon guest
 startup
Date: Fri,  8 Mar 2024 06:34:59 -0800
Message-ID: <20240308143459.2970899-1-justinien.bouron@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZerPYH7KkLpmgTEV@redhat.com>
References: <ZerPYH7KkLpmgTEV@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=justinien.bouron@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

> > > This last two lines doesn't make sense to me. Isn't the grab
> > > toggling entirely in control of the QEMU process, regardless
> > > of what state the guest is at ?
> >
> > Actually, you're right, they do not make sense. This issue of having the guest
> > taking a while to start and the toggle keys not working, only seem to appear
> > when running the VM under libvirt. I was not able to reproduce this issue when
> > running qemu directly from the command line. So either this is a libvirt issue
> > or something related to my setup (VFIO with GPU passthrough, so a lot can go
> > wrong).
> >
> > Should I send a new version of the patch with an updated commit message that
> > does not mention this issue?
> 
> If that probem does not exist, what is the compelling reason to
> add this patch ?

I still think this patch is useful. Having the guest "steal" the kb/mouse from
the host immediately upon starting is frankly annoying and most of the time
unnecessary as at this point the guest is barely booting anyway. Most of the
time I don't need/want to redirect the kb/mouse until the guest is fully booted
and instead want to do something on the host while the guest is starting in the
background. So I end up having to press the toggle keys every time after
starting the guest just so I can keep control of my inputs. This might seem like
a minor annoyance but it is still that, an annoyance.

This can get particularly annoying if the guest is started from a script. In
this situation the guest may not necessarily be started immediately upon running
the script depending on what the script is doing prior to the `virsh start`
command. So you can't tell exactly when your kb/mouse are going to be grabbed
from you. If you do something else on your host in the meantime, while the
script is running in the background, you end up having your inputs grabbed from
you without notice.

There are a few posts[1][2] on the internet asking how to prevent evdev grabbing
upon boot, so it seems that I am not the only one that would like to see such an
option.

[1] https://www.reddit.com/r/VFIO/comments/14xuksq/evedv_passthough_dont_grab_on_start/
[2] https://www.reddit.com/r/VFIO/comments/frbk0q/disabling_auto_keyboard_grab_evdev/

