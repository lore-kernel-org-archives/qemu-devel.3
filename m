Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5F29C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1semfq-0007LY-EA; Thu, 15 Aug 2024 22:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1semfo-0007I6-Bd; Thu, 15 Aug 2024 22:26:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1semfm-0005O0-ND; Thu, 15 Aug 2024 22:26:40 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1fc60c3ead4so14632005ad.0; 
 Thu, 15 Aug 2024 19:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723775196; x=1724379996; darn=nongnu.org;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XiJ95sFlW8mgrdmS+FGQG1YkX3zQYhm3/ChV9srynF0=;
 b=ac1Umut91DNJge8EsBSHt2m1HDPEsdEpm8bf6inM6wvhWaJp4uwB/TrRYmnCnRCXQu
 zVpGelbiYca7iEfbMU7ne49GXRk3hlJA0hy2UzDP7GKdlkjxL3hADbFFCWz8CWPR8c+p
 ehRMcik9wbe0YDeHMzKxulNnmII9uQGOeZcqpL9yiDBPSEfJRgaTMorLDXQBrALhhFxW
 vHbdBpElt+ph6ce/sv8ZA/rG79ldKjSv1s0BxI9EAPx+zmatRrc+okpTYj5wxhyvfRLW
 YbHifGICZUG8PBsxnn7GMA46Wo3gJfcX2Q2gUPXigfOh9mksSQHadEjbvS6AAfX27L1/
 Zjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723775196; x=1724379996;
 h=in-reply-to:references:from:subject:cc:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XiJ95sFlW8mgrdmS+FGQG1YkX3zQYhm3/ChV9srynF0=;
 b=oiIzORVx/sl7E904RnnfZf9ff1BP8l/X8TeV9Run820+/t+dUjtAjvQ6HN+2RkiQJi
 xBCmrX/ix4Tzw5Tfl7IXL7zpNhb+REOnUQ6f0gy6mpRS1pSXtYKrn6O/5EvUSV2T1k5m
 XSKLxeeA2zg0gwYZZlh0MAu7i0Fvnj4lD7DrGAC8UvI2HguwftWyy1JeZsA6lXFUiYuX
 NSm3ZJQelqGhEE1Sm3LxuByHk9R2M2WgHjvT0dVFJBHNXhO3M8841opwO5SPnR9wfF3/
 9VA3xPfyvfLKs6gFRrO0Plvzcal+y2KnxhjBshgZ2KU3gx/IbAnOtze70sxK5mGgUFrh
 0RFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPlrd8qH5oHMSzGcaIYHNu6QEBSUW/VGEUsmDXF3ebeiWPGTkPD6f0iIFAaCNQzmbYVYYvRqBBLjZ6aobjH0EKvClNfi/D/+RRQzMcSutFe8TMh4qXT4dTAlJhpbEc4M0X1UnIQGPhOr4oGUOFqaZYTpi0Fxfz1k/KATtS4Id0xF9yCCEbKFV
X-Gm-Message-State: AOJu0Yw7zSzf+PEurfzb2/geg9ciwLhMKxhO43ZiX8EoxBzP3w719w7t
 PXldUK5xKBwuxP8T+6UI8Qnm5Eh+EbDlR44yaIQXvkgErLwMBMKK
X-Google-Smtp-Source: AGHT+IE5W/byoNs9Ba1LE24xkIbzXaBp1C2IGuE0Ma0+CTpXzATv1ZUn5JGzVmJ5HIIEGa+An/R42g==
X-Received: by 2002:a17:903:247:b0:201:ed48:f11c with SMTP id
 d9443c01a7336-20203c08902mr20493245ad.0.1723775195953; 
 Thu, 15 Aug 2024 19:26:35 -0700 (PDT)
Received: from localhost ([1.145.119.203]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f039e09csm16366065ad.244.2024.08.15.19.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 19:26:35 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Aug 2024 12:26:18 +1000
Message-Id: <D3GZAWNK3B01.36WGYVZO23DPO@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 <qemu-devel@nongnu.org>, "Alistair Francis" <alistair.francis@wdc.com>,
 "Michael Roth" <michael.roth@amd.com>, "Palmer Dabbelt"
 <palmer@dabbelt.com>, "Mahmoud Mandour" <ma.mandourr@gmail.com>, "Pavel
 Dovgalyuk" <pavel.dovgaluk@ispras.ru>, "Yoshinori Sato"
 <ysato@users.sourceforge.jp>, "Weiwei Li" <liwei1518@gmail.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?utf-8?q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, "Markus Armbruster" <armbru@redhat.com>,
 "David Hildenbrand" <david@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, "Eric Auger"
 <eric.auger@redhat.com>, "Song Gao" <gaosong@loongson.cn>,
 <qemu-arm@nongnu.org>, "Peter Xu" <peterx@redhat.com>, "Jiri Pirko"
 <jiri@resnulli.us>, "Eric Blake" <eblake@redhat.com>, "Fabiano Rosas"
 <farosas@suse.de>, <qemu-s390x@nongnu.org>, "Peter Maydell"
 <peter.maydell@linaro.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "John Snow" <jsnow@redhat.com>, "Alexandre
 Iooss" <erdnaxe@crans.org>, "Konstantin Kostiuk" <kkostiuk@redhat.com>,
 "Pierrick Bouvier" <pierrick.bouvier@linaro.org>, "Cleber Rosa"
 <crosa@redhat.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 <qemu-riscv@nongnu.org>, "Thomas Huth" <thuth@redhat.com>, "Paolo Bonzini"
 <pbonzini@redhat.com>, "Richard Henderson" <richard.henderson@linaro.org>,
 "Jason Wang" <jasowang@redhat.com>, "Bin Meng" <bmeng.cn@gmail.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Pavel Dovgalyuk"
 <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
From: "Nicholas Piggin" <npiggin@gmail.com>
X-Mailer: aerc 0.18.2
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
 <87y14z81ak.fsf@draig.linaro.org> <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
 <20240815102754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240815102754-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

On Fri Aug 16, 2024 at 12:28 AM AEST, Michael S. Tsirkin wrote:
> On Thu, Aug 15, 2024 at 05:12:32PM +1000, Nicholas Piggin wrote:
> > Could be a good idea. Although I'm not sure what to do with
> > all types, maybe we can restrict what is supported.
> >=20
> > > Is this wider re-factoring something that can wait for the next
> > > developer cycle?
> >=20
> > I would say so. It's not quite trivial to do nicely since
> > things are a bit tangled between util/async and replay.
> >=20
> > > >> I had started on a conversion once but not completed it.
> > > >> I could resurrect if there is agreement on the API?
> > >
> > > I would certainly welcome it being cleaned up. The supported replay
> > > devices are very piecemeal at the moment.
> >=20
> > I'll tidy up and post an RFC for how the new API might look.
> >=20
> > Thanks,
> > Nick
>
> Fundamentally it's virtio net, up to Jason. I don't like messy
> APIs and people tend to get distracted and not fix them up
> if one does not make this a blocker.

Happy for objections, but FYI Michael did find the proposed API
tweak nicer, so shall we get these minimal fixes in for 9.1 then
switch them for next release?

Thanks,
Nick

