Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CA75C31D97
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 11:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKmn-0001pi-Gz; Thu, 04 Jul 2024 07:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPKmm-0001pT-RW; Thu, 04 Jul 2024 07:38:00 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPKmk-0002yY-5h; Thu, 04 Jul 2024 07:38:00 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so4126695ad.1; 
 Thu, 04 Jul 2024 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720093076; x=1720697876; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lpSKsr/VRZkJG1O185nSJv55/8TeBA/DP0MMhFW3gNU=;
 b=R7lWBgs5dCfXoc+wx9y+P4o/vGrUaIu4DWYwctN0pTeeCIEYQl7vrPi+QVSscclQyG
 MndHaeS+9loGWkxCzCtCp1GUSvou1ueAyUkGTMp7J6MKz/4slFJrJ+lSufKI7pHmcqd6
 36RuHva7oBnkj/psRH8yuTLM3jw/a03lgOWC222vZY2N/Sce/svLIuWILLAMnbGa9jMH
 0rupBkQwCDeAnjEY3HALH4XXQ4UvrRC4UUG0YX+sFJBhR2qeIxjO7/xt9KexQDlmniZF
 JEv8GwzOLSsvaECklZ82F1w9+9GTd5WK1moiGRvkUaXyb+sXOZrgspdka0R5vNw7egWf
 RXcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720093076; x=1720697876;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lpSKsr/VRZkJG1O185nSJv55/8TeBA/DP0MMhFW3gNU=;
 b=FnfPY1QvAE51sc3oyDqUUzTeYYcKYaUgQTyHaAX8o2/AXhey3iY11bHoHzWrDjNyCb
 kqJhuefqp5Iszdb97R4Ot38yDJlqpMjoK7SLXw1iMZ4BlX5O9eQthqbhChPhTuiSTRXw
 YOg669HD7Vrc8AL8UFMjF86nbVb+1n+SigM7ZuP1dmdbtgBw5GLXpPbRKaSOU6nSzukj
 gjop9KAAapH5LJshlLd3Vujo710cxfNF64/6RuV7gRFhy74dXn5eM8tbkDQAKil+HS0m
 LnFn1mPpsJ5PRWH3IMBZqwIO4nuJ6tA+8fz4Fy1LeP4LzGPv9dyABQR/iFZewC1ZU0Eo
 6lxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA5+lhsVh1Z6XLfZNn/Njn/NxCUsc71uGI7OaflWXNS1QU388lBWv6Csr3ARG+I54uYwKhX+RYYjjm9Qb2kbGtrJBFiVDJ2xlAgvsyaQEy5GaY+Wlx9eNwXft/yKF4E3UuEL6jILUVgjKwzJSif+WdBQ==
X-Gm-Message-State: AOJu0YzkkrYdF8Hqbq3Xnm8Yu4Pq4g6UBA5VBgGfil9DN7/NBmNG+Kgq
 TPbwN5a1xYVFhtNMWCWJg/ypN3xgJLBM4KOfbn9UHWOWeD6CoNom
X-Google-Smtp-Source: AGHT+IFLjvoZxA/WJDTPXFERbtBSIjozyKaHq3NUMvqCPuD04ECUeKDpGtPnTQeJKG9Y8mgLAnv3zQ==
X-Received: by 2002:a17:902:da91:b0:1f8:44f8:a357 with SMTP id
 d9443c01a7336-1fb37056478mr19756205ad.17.1720093075739; 
 Thu, 04 Jul 2024 04:37:55 -0700 (PDT)
Received: from localhost (118-211-5-80.tpgi.com.au. [118.211.5.80])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fb1b0b3638sm29881465ad.193.2024.07.04.04.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:37:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 21:37:45 +1000
Message-Id: <D2GQ3PC878MB.MHAWCNPT1WBJ@gmail.com>
Cc: "Akihiko Odaki" <akihiko.odaki@daynix.com>, "Eduardo Habkost"
 <eduardo@habkost.net>, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Yanan Wang"
 <wangyanan55@huawei.com>, "John Snow" <jsnow@redhat.com>, "Jiaxun Yang"
 <jiaxun.yang@flygoat.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Alexey Kardashevskiy"
 <aik@ozlabs.ru>, =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Peter Xu" <peterx@redhat.com>, "Fabiano Rosas" <farosas@suse.de>, "Paolo
 Bonzini" <pbonzini@redhat.com>, "David Hildenbrand" <david@redhat.com>,
 "Laurent Vivier" <lvivier@redhat.com>, <qemu-devel@nongnu.org>,
 <qemu-block@nongnu.org>, <qemu-ppc@nongnu.org>
Subject: Re: [PATCH v2 00/15] Fix check-qtest-ppc64 sanitizer errors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Thomas Huth" <thuth@redhat.com>, "BALATON Zoltan" <balaton@eik.bme.hu>,
 "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240627-san-v2-0-750bb0946dbd@daynix.com>
 <20240701161033-mutt-send-email-mst@kernel.org>
 <c7ee820a-20e6-2891-1059-643e68053647@eik.bme.hu>
 <fcf6d258-ae78-4e47-bcf5-edfa68428874@redhat.com>
In-Reply-To: <fcf6d258-ae78-4e47-bcf5-edfa68428874@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62a.google.com
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

On Tue Jul 2, 2024 at 4:23 PM AEST, Thomas Huth wrote:
> On 02/07/2024 00.23, BALATON Zoltan wrote:
> > On Mon, 1 Jul 2024, Michael S. Tsirkin wrote:
> >> On Thu, Jun 27, 2024 at 10:37:43PM +0900, Akihiko Odaki wrote:
> >>> Based-on:=20
> >>> <3ad18bc590ef28e1526e8053568086b453e7ffde.1718211878.git.quic_mathber=
n@quicinc.com>
> >>> ("[PATCH] cpu: fix memleak of 'halt_cond' and 'thread'")
> >>>
> >>> I saw various sanitizer errors when running check-qtest-ppc64. While
> >>> I could just turn off sanitizers, I decided to tackle them this time.
> >>>
> >>> Unfortunately, GLib does not free test data in some cases so some
> >>> sanitizer errors remain. All sanitizer errors will be gone with this
> >>> patch series combined with the following change for GLib:
> >>> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
> >>>
> >>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >>
> >>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> who's merging all this?
> >=20
> > Maybe needs to be split. Mark had an alternative for macio which was pi=
cked=20
> > up by Philippe if I'm not mistaken. I've sent an alternative for vt82c6=
86=20
> > which is still discussed but could belong to Philippe as well. PPC part=
s=20
> > could be taken by the PPC maintainers if there were any active at the m=
oment=20
> > and I don't know who maintains tests normally or other misc areas.
>
> I can take the qtest patches through my tree.
>       cpu: Free cpu_ases
>       migration: Free removed SaveStateEntry
>       memory: Do not create circular reference with subregion
>       hw/virtio: Free vqs after vhost_dev_cleanup()

These are all core code, maybe Philippe, Peter, or Richard,
Fabiano for migration perhaps?

>       hw/ide: Convert macio ide_irq into GPIO line
>       hw/ide: Remove internal DMA qemu_irq
>       hw/isa/vt82c686: Define a GPIO line between vt82c686 and i8259

I guess I'll let you wrangle these and go through Philippe then?

>       spapr: Free stdout path
>       ppc/vof: Fix unaligned FDT property access

These ppc ones I can take, they seem okay. Sorry for my recent
inactivity.

Thanks,
Nick

>       tests/qtest: Use qtest_add_data_func_full()
>       tests/qtest: Free unused QMP response
>       tests/qtest: Free old machine variable name
>       tests/qtest: Delete previous boot file
>       tests/qtest: Free paths
>       tests/qtest: Free GThread

