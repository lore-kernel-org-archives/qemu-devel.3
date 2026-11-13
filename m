Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BFA606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=VoX/bJXg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRnlx-00007o-5A; Fri, 13 Nov 2026 04:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRnlv-00007P-6C
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:40:39 -0500
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xRnlt-0001xe-HM
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 04:40:38 -0500
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-67c58f18765so524067d50.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 01:40:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562835; cv=none;
 d=google.com; s=arc-20260327;
 b=rK9cyhtIO8VyZ2p3bMrN4iazpeq06TzBW7EfkR6WCeNz9wKnTmrPKYRRJprlPMBFBu
 TOFcufXQESCZk2CdGbIDWua6dzeOHNOe6S+1rqH378mOUINJblZhMGFVSc84Og88MU/Z
 RbjgcHBQkP0H2uO8ljnIFvLFgt0bXJAY1qqMugWrrlAk8+sZUhQlqp5KBphOHQPQf/Ok
 k8jIb3ZEfaAnVisrlyjoDC2E96MCpePQVi9uwFhELaLjOiJsfja4MkvFT+izq0+MNRlZ
 VRrNqsts7nNsFt6SMOBi5pn5xNvF2d0AS376L83w+7jrGV3sssLXtTnwYOAVzC96WmJe
 +2kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HhICIjCHkGcnorSALnHdaEf03h2gWz7oeBcbU8Js534=;
 fh=ubl/Z9fkg7UYdStyyGO8ahOlXS6kbpNJlE1Y4oykBHM=;
 b=KvNn9RUyPTnAvT/5Vit68tS7QLDNXRpn9TQE44jLlEVIY6syEWiwC7NP+vo0coLD9s
 eXwcxWefWtriomCfw4olibedUk1oSo+DBSx3Foa+IzIe8RFCoH2XlPxg0ABlELHgYlQO
 MG+R1ML1Okde7EZ6MkAGt4nYSnNEh95LesonmFj20qZDCBHI+EZuowqzmi0W9HSEbS/9
 NJ/6VlLESjrT4Aj8FNN8JbZxl0D0QnPn+dFlZee+Ki68x2W6lSQuMfkrYGYPAyeArSCU
 yuDzmt6aUgXr1/dhUJGNcrnBCIHvCHMC/soKtfh2XR3aeDu7KfZqlC2YwBB+pQNtmlH6
 VFWQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794562835; x=1795167635; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HhICIjCHkGcnorSALnHdaEf03h2gWz7oeBcbU8Js534=;
 b=VoX/bJXgDVipqRAWdIhUsEz8wY7AHjunuM1RVQKyJjBSZQHJ7S4NrfiaTdpdHEJPyQ
 xKJM8+CwDGymbnYekSOhCxqZA9y+G6Kzkb6B1rKk21cwsDgbVtKLQK0z9Vdynv7WB3Lj
 4Xz+P+/ZSM0xyQ1mGl/FN2zFpqx8t0zvAPUKdklH9oEusAjKBC+8NGq05HX36dbTsHsu
 7+B/t5iEMUiATK0PgONZVeImL5xSzvP0Nq325KnurNzZ/nBMSg6hNkv9ziS3WLj72OdY
 dvN38VB/8lL09/SjNn5XVjg96I/IcE7IUS/O7l7OBxKzN493NTkZR8YP+9XgrCgUFrpU
 IJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794562835; x=1795167635;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HhICIjCHkGcnorSALnHdaEf03h2gWz7oeBcbU8Js534=;
 b=hxgyWhTHgLhBzRGyAYC6eD0rk+ccpqAqRJLT1PHlbMruO9v3ZqU63KXU1EwD6mScUx
 7JO1AuCv7DRmDtnAO0+gLCeWtw4R7f0EUqahviEHjd1FYy/7m+QSbiLMxsUSnAt1OBzs
 RZ0eip8X3vw3ooFoTnKCAMvkRlppCpnojloeMjS1qUrt9t5CtgLw/pc+W+EmM0We8IEl
 vhc+3WSRZmza1Cb3WnBaJP+5+91mM3G5aWb0NWPpOTD2vV/8rNU51MrsPND4Vt/APu3h
 Cp0WKEalcSY+O7fvwghap0q9HWvU4QtPqf8AZuGbI5M1BhhuXLif40waCHDssF9U2QXT
 fSDg==
X-Forwarded-Encrypted: i=1;
 AL+hErHxQU2misTUU53i4a0R7Jx9YLx1cqD4xlTCw/F7wyg9W0f8RglRMFMJxGEH8NODDc01pJdWBJNZab+U@nongnu.org
X-Gm-Message-State: APuU4Z81/uEpNZIXjIKNME+X5XTgabxih8Ncxg/jv8VFDqD+vKoasO7S
 AFRGSnYB/8ErhtYdY+JYrLaUohZQA7siupGfPcs3jnizyMW0Z9lh4fg1ZGOPq5qrUNC6n0Qd1Nk
 4cczOmJGG0L9kG9ReNTaj8bGL7aK5Tthlo3xBBmgIqCWjCSqH/h0jAi4=
X-Gm-Gg: AYBFou3wIBMOq0W4fU9R1iPu1Zcq0OQOiBR98B8bpr9FSdCiHKh/7fcT2zjJI0GNgF8
 ahSrozdsJhNReWCHKPbHSxZ7Row0u5UWdRagNUEwyppijBxQ11hpURf9zbcRGQGF671MO5ktAfq
 w1FuROuDU0duxhUjBWN39ByksIqnbgN4gx6tT+YKTwlEdDzEgpzMLpas0PGR3MsITFNX5B0ed5l
 +VVozEdCb+mwRZ4gfGtFwjhNPS7Z7Pas3cB6s7d77GZS6regH/lY1ZFiHXNmUxoYpGY3fYqhT0j
 LRPgtaQ2z97gswEYhwE5i3owvUmx/+8Ptzg9/cuNe0n2z1yFlKR317C69e5yGlGEXslnzip7zfo
 wXVUwHAUbKLQFsAER7DnUNC+V+gciMfSDw7YRoFPXELeVkI55uvPmlui2DQURM0eYwgoMWuza3d
 HDe8F1wy0I34lNWsH6XiOoAFf5Se8kibtOQ6IcjkvBrw==
X-Received: by 2002:a05:690e:47a0:10b0:67c:271e:c29b with SMTP id
 956f58d0204a3-67d895e45a5mr780720d50.25.1794562835043; Fri, 13 Nov 2026
 01:40:35 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103215430.703404-1-sw@weilnetz.de>
In-Reply-To: <20261103215430.703404-1-sw@weilnetz.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Nov 2026 09:40:22 +0000
X-Gm-Features: AclHuK-WsuanTuxk65-HHlsKkSjIhZErFvHPcO-FhO8-DlucywGKzzzOuortHsQ
Message-ID: <CAFEAcA8o2FOSk25hZFTYjVa9VJW7niLpqy4_2oEwOoii84VLcA@mail.gmail.com>
Subject: Re: [PATCH v2] hw/net/eepro100: fix use-after-free on reset after
 hot-unplug
To: Stefan Weil <sw@weilnetz.de>
Cc: Jason Wang <jasowangio@gmail.com>, qemu-devel@nongnu.org, 
 Hui Peng <benquike@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 3 Nov 2026 at 21:54, Stefan Weil <sw@weilnetz.de> wrote:
>
> e100_nic_realize() registers a system reset handler via
> qemu_register_reset(nic_reset, s), but pci_nic_uninit() never
> unregisters it. After the device is hot-unplugged, the LegacyReset
> object stored in the root reset container still holds the raw pointer
> to the freed EEPRO100State, so the next system reset invokes
> nic_reset() on freed memory.
>
> Instead, define a reset phase on the device itself: assign
> phases.hold in eepro100_class_init() to a wrapper around nic_reset().
> The device is already part of the resettable tree via its parent bus
> (TYPE_DEVICE implements the Resettable interface), so no explicit
> registration is needed, and the reset state is automatically dropped
> when the device is unplugged. This follows the approach used by the
> e1000, e1000e and igb emulations.
>
> Reported-by: Hui Peng <benquike@gmail.com>
> Reported-by: MyeonghunPak <https://gitlab.com/mhun512>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4058
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4510
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

I'll pick this up via target-arm.next, since nobody else
has taken it.

thanks
-- PMM

