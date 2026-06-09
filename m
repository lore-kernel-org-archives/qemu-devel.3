Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87997CD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 12:11:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWvIA-0004xE-LI; Tue, 09 Jun 2026 08:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWvI6-0004wo-K3
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:10:46 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wWvI5-0001LV-0g
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 08:10:46 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-69170548d0eso4118061a12.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781007043; x=1781611843; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QsrDGAQcXKwJFvGhV5jpqNZxEJ548zZjnjQx1oMH78c=;
 b=VJnTRL0ickMGPv6L/ix+kbihurgAK+ezX3ychlIEN6/+4NP1WWFO8OIKPNQDp1NhTx
 nlVVE0T3BqHX6HaDVw6jgj7KGy/rNfUwFUy/a/tmBmsH2+Nm6fslnHB0Neb43bYVUbqq
 usDZXzS6k1paAI71l+MVs9Z5MUnWVxeMT6i2JDp60Rr1kfZYF4dIKzz/KfP1pJX0ipMy
 MeWRPKDC6grrzR4A6/EBLkt0dJU6RYb+pZ/JfpEKOlRyjPrB57tmNKiibTliZhpQe22q
 Q5eOlcHg6iG98qT6w4ryLEWATqLfKFQX5XoO1vAWuW1Tu4V6eUTCMOjUu/afdAReXXfv
 rw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781007043; x=1781611843;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsrDGAQcXKwJFvGhV5jpqNZxEJ548zZjnjQx1oMH78c=;
 b=QCK5Fvno76CHZVySuPxUSVsuMlAqJd7K7AyVSo4Xc2dvlMLN+5B8oYajm/ybiCqOBY
 6HI6qeLUti44Dba1OJA3kfgjFQp/0N51k4J3wRvLvKxkjIcAfe4MtxcLK9+aNNdocA99
 buFEBuxpxWjGiblY9AioOdnFVW76Y5FUa/AKQ0cZ6FvaWXz4x9y+KW+ZIx9myP6hTvci
 66E8wv4R2AWHk85HLAcwOranxAFYofClN/5DRJEH+FhQ3I9DcfzwpnP4kcoo9E56rFBM
 0OLQmlpPG2dt+V09bXHsCT6zfzCQX2kWZw4MTmdcpmFTn4DJLwHAm37xwI/o+aSbK9TQ
 PQ/A==
X-Gm-Message-State: AOJu0YxWc7U8BKyOdTxfZOAlMmjCiWP0tpNxO+DUKItMsqR/AC6PBauD
 WvR4Ik78jAez1yHYt6aL6QDC3cxnUCn0iSg7s+8mg5vYMTyyetnMgvqs
X-Gm-Gg: Acq92OFjd/oahs3nMCR0NoOVUrGPltxEeWTOmXuPa8FNjCY4Rc6vTaO1lKYiBzVRx8/
 dq0cI4KFZ9EZ62YGBgsYNGHSxyjujh5ySgcKBBhNRa9MQabVfjhvtxGM5jfVSospav7YltgT95Y
 qXQb6WpGznNAPEV33Xs1FVtaOnsMdRS78WQnOdCO3d6lD4FNojqObQDMMIHwwNY80kWa3c8KXFz
 24anlLeiCgL+zOloSdSG0phxqCKkYlF/ub4QaWHhp8JWK9o//Kvoeyd4z3dNEK7RNyL53l7WoBC
 DyyCVfJnYT6q5enlIkfr8HkuaItlby6JBUnefQoyWS4iHKsKYjoSJp67S+e7xJ0GgrySr2fP7PE
 r7ggkdn+yEvt0YoAqEQa4M04WBvs2zSqXyYUD9JGUOR6mcLh+HaiS0AHDtMxugbQtMvuIH8YFjW
 d1LXg4d3X+HOTbsgayME7dnMdTY16+aIII/dwhWvH4D1IuZb0Qi0T95RBdGoeueQuKWg2D
X-Received: by 2002:a05:6402:358e:b0:692:4a58:a93 with SMTP id
 4fb4d7f45d1cf-6924a580c7cmr828892a12.21.1781007043363; 
 Tue, 09 Jun 2026 05:10:43 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2d2fasm8641476a12.3.2026.06.09.05.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:10:42 -0700 (PDT)
Message-ID: <aeb26901ad15ac26749b33e5e407f4ed421c43bc.camel@gmail.com>
Subject: Re: [PATCH v6 00/12] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, "Michael S.
 Tsirkin"	 <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, "Daniel P."
 =?ISO-8859-1?Q?Berrang=E9?=	 <berrange@redhat.com>, Szymon Lukasz
 <noh4hss@gmail.com>
Date: Tue, 09 Jun 2026 14:10:41 +0200
In-Reply-To: <5ad91cd4c7ba500a56d8356100becffcfb3062a3.camel@linux.ibm.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <cc0b8cce5bf5763ace058270e9d80fb84873dbd7.camel@linux.ibm.com>
 <20260609040710-mutt-send-email-mst@kernel.org>
 <147cee86401993714fa94bd6cc79c4dbbdcaca52.camel@linux.ibm.com>
 <ba34daea09f83601c88be90006ca28e3700910d9.camel@gmail.com>
 <5ad91cd4c7ba500a56d8356100becffcfb3062a3.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2026-06-09 at 13:38 +0200, Maximilian Immanuel Brandtner wrote:
> On Tue, 2026-06-09 at 13:13 +0200, Filip Hejsek wrote:
> > [...]
> >=20
> > Hi all,
> >=20
> > Sorry, I did indeed forget about the series.
> >=20
> > From what I remember, I was trying to address an issue with the size
> > not being updated after a migration, and it turned out fixing this
> > required adding the current size to the migration stream (in order to
> > avoid sending unnecessary resize events when the size doesn't change,
> > which MST pointed out would add guest performance overhead).
> >=20
> > However, since virtio console serialization still uses save/load
> > methods rather than VMState macros, I couldn't simply add a
> > subsection,
> > so I wasn't quite sure how to proceed. It seemed like the right thing
> > to do was to migrate virtio-console to VMState, but that would have
> > taken more effort than I was willing to put in at that moment. And
> > then
> > some other stuff happened in my life and now here we are.
> >=20
> > So anyway, in order to make progress on this, I see two approaches:
> >=20
> > 1. Just bump the migration stream version. Makes the loading code
> > more
> > convoluted due to version checks and increases tech dept for future
> > VMState migration, but shouldn't be that hard to do.
> >=20
> > 2. Do the VMState migration now. This is complicated by the fact the
> > on
> > load,=C2=A0some of the state shouldn't be restored back into the field
> > that
> > was saved, but instead should be compared and the guest notified if
> > it
> > is different. I'm also not quite sure how hard it will be to preserve
> > migration stream compatibility.
> >=20
> > Which one would be preferable to do?
> >=20
> > Kind regards,
> > Filip Hejsek
>=20
> I have another patch in the pipeline to add resize support for another
> chardev backend. Would the migration issue affect any chardev backend
> that wants to support resizing or is it specific to virtio? I don't
> have a strong opinion either way regarding virtio-console, but I'd be
> quite interested to see the generic chardev resizing code rebased
> against the latest upstream QEMU sooner rather than later.
>=20
> Kind regards,
> Max Brandtner

The migration issue only affects the virtio backend. I'll try to rebase
the series and post a v7 ideally later today.

