Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EEAC30653
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 20:15:42 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMCPm-0007Sz-Ex; Tue, 25 Jun 2024 16:05:34 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sMCOZ-0007L0-AK
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:04:11 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1sMCNx-0008OU-11
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 16:03:51 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ce01403f6so3232795e87.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719345733; x=1719950533;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pfa98Hhz/3a1N0c51sLjNCU13nfIteWFcsfvMzWwTAs=;
 b=JSRo74w0IUMIoOdPYvyehoIBCbv2jFeiJD0bdU7GsBDuvkkzOkPe6OLJ/fjdZh/8GH
 ECKYtwtFRoi7YskwwJ2R+C/a/+W4BMGoMRshHCFq04q0oPmoO2kF4ii3rzAjsgsExZST
 HP7nkNr2ZXlbYqAkjfNgAdb2To8M0wn7czmf1w5v9ddu631V1N3/i2g8cXfNp3RBhECi
 baeUjsj0gAmnLefYKsalxzxdTjGBKdrUvujNGyLiIOdKXdn9fJdL6p2N8RDH1ZamKMZX
 1vGXH+2PWiDwbHS3w/H2ZIoAGJYSFGy2lvQcp8eVVKFiH88XV4vrHU3NNu5YDQ+1k2HI
 uCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719345733; x=1719950533;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pfa98Hhz/3a1N0c51sLjNCU13nfIteWFcsfvMzWwTAs=;
 b=Zxj+2nHn49HGrpDalPnko1NVec6jq++vYpbddI0aTdDgFUbESmQAZwHVwF3r7wB9xJ
 tBRXk8wRECH8S+L/fRT3SCS6rOcdpV0ElvlvbHzsti/llsLsIeuLG4CMNXgg3pU/bz8n
 KFPYQkdVQF/v+GCirGQwEPQJZU0VShFSJDOS0PnP06VkStb9e43KvjmE1wFZHdNfrlFZ
 MslkU+0GtcAop2HXQFPiugn3/3XXmK1k6ERvvjtBxhU2cAW4We+ngD8eI37BHIIRo7aF
 dx7pFs8zRoF7eGbKJ2X/egozDQe+Pj9wBYHD/GXTa1jWYrK+G3y7RI9hLb337e9DmjY4
 0r5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXebxCjPmETvNl7TKmMqgmhfy3XWtJl7E6uhFxlUXYnjBxOGuqV1XIOKhRBrJWpke5wL7YDt2Bhbap97igSD5TuyQdxFxY=
X-Gm-Message-State: AOJu0YyvnqGu8HE6yT9t6WkrJGRw5nVemupvhqx+9vhJhGxN/r2/wHkB
 VVhtKdIOE5yBcKZFkc9mk4XZbWirW+n7V6bczZELRaNmfmlMAUc9WmHKPnDjFm3EhQNNieIIIwi
 WhCV/6SekLvmkKDREu0Q62WC70duU3BE3Xz59eiCH98J0975A9SlR
X-Google-Smtp-Source: AGHT+IHksRExRFpSVNc+FAU1wAgUppMXLoVrUBPwA9iObRsLtPKT6HOKxfAyw1lejlazqTUPLetXdU1V4I0AVqnTFCI=
X-Received: by 2002:a2e:3009:0:b0:2ec:5ff1:227a with SMTP id
 38308e7fff4ca-2ec5ff12384mr44011751fa.17.1719341879605; Tue, 25 Jun 2024
 11:57:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240608202045.2815-1-phil@philjordan.eu>
 <20240608202045.2815-4-phil@philjordan.eu>
 <dd047370-f0ed-4b8c-a251-037e82f64986@daynix.com>
 <CAAibmn2-JApae_MFX+Wy8MuzkCLuE7DbgmgVOko3f7WzZGoozQ@mail.gmail.com>
 <f8020f9b-45de-4dca-a35d-b26fe91f8962@daynix.com>
In-Reply-To: <f8020f9b-45de-4dca-a35d-b26fe91f8962@daynix.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Tue, 25 Jun 2024 20:57:48 +0200
Message-ID: <CAGCz3vvg9An5DVt=DKbkoBM=qb_wJRnJuw+svvi+rq4G=JShZQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ui/cocoa: Adds support for mouse cursors
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, philmd@linaro.org, marcandre.lureau@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: neutral client-ip=2a00:1450:4864:20::12b;
 envelope-from=lists@philjordan.eu; helo=mail-lf1-x12b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 11 Jun 2024 at 09:36, Akihiko Odaki <akihiko.odaki@daynix.com> wrot=
e:
> > [=E2=80=A6] I also
> > definitely think host cursor integration is useful and valuable, at
> > least in absolute pointing mode - for example, when the host system is
> > itself being remote controlled, and also to avoid the cursor being
> > cropped near the edges of the guest viewport.
>
> Can you elaborate more about the remote control scenario? I don't think
> having extra code just to fix cropped cursor is not worthwhile (I even
> feel a bit awkward to make the cursor overflow.)

If you're remote-controlling the host Mac, many VNC/RDP/whatever
clients will use a local cursor and simply request cursor image
updates from the server and apply them to the local native cursor.
That way, there's no lag when moving the cursor even on slower
connections, which you'd otherwise get if you had to wait for the
regular screen image update, and which can make precise positioning
difficult.

At any rate, most other Qemu UI frontends likewise implement guest
cursors by setting the guest-supplied cursor image on the host's
native windowing system's cursor, e.g. gdk_window_set_cursor(). I
don't really see a good reason why macOS should be different? Qemu
would also hardly be the first VMM on the Mac to pass guest pointers
through as NSPointers - Parallels Desktop appears to do the same, for
example.

> You can add Based-on: to the cover letter to clarify the dependency, and
> add "RFC" to the subject if the code is not ready to pull. Please look
> at docs/devel/submitting-a-patch.rst for more info.

I've done that now, thanks.
https://patchew.org/QEMU/20240625134931.92279-1-phil@philjordan.eu/

Phil

