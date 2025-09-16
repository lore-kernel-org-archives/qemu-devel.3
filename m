Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F04CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZ4S-0003FX-Qh; Tue, 16 Sep 2025 13:02:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyZ45-0003Ae-P6
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:02:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uyZ42-00007r-Ft
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:02:01 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b0787fdb137so858476166b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 10:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758042117; x=1758646917; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CBdZ5dcwSr4f9iSI8wtAG7XmCGx/aKThA4DFkRPOZ/A=;
 b=Yadjn3Xj//RFhgo7SHH5wU9HF2jNbCaabZPEoEl0hm/v39LcJdnKBk/9U0Uzv/euB3
 4jnV5tqZGPyC69BR4BqFmGvcrVyaEoJ+i6WFxsvqr+GtYvy5d9R6JW2hR3Bow2bz4fRM
 LjxPtet4AZRR/3aQw5Op0tTdo+Gw5g53CBKKPmozvrabUrJkhSbSPMuXCHsnrrv+hmTn
 7d281BCElh46Rd8FDYenQxGsjtXkpXqmDRBTaHiMAAcHao4dt9750HDRd0HARSlcEnJl
 M1DS9Sun+RtvAvVjrtzp+3zN+e7v4pQgpo5E//0+fS8moec2eVrTe6JOxuPZ0FHcF1Am
 KlrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758042117; x=1758646917;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CBdZ5dcwSr4f9iSI8wtAG7XmCGx/aKThA4DFkRPOZ/A=;
 b=ujmx/cHVBn+/3uRE187XDv8f33KW2esI7ijoO/ProV5BHjk5aWbi6vjvcO3XCuEuqz
 5m3ljhc/PVM9DlxaPTpeE5p3IduluYb/82wyX6hA3j3Hp0hDEeG80zOBAHjshThsREF8
 c8sf4utqRSUWx4erbBF8mF30uKmRHrp6sS6ZHwIi0wgkAKW1dGD1e9Gm/Zzjsys0rbhh
 eZ0tDVr9+N7sRQd2FRnuUpo//b0ySHeIuQEpg6aHJLlRCQNlrd7gVKVkA2TbrpqPulxL
 f2IZa3QY1ewdnP5VoWGtYsS4W2yHnnGUJDplZPCF8SuR6iJdp2stnCH0GDaxHuKMmSXU
 U55g==
X-Gm-Message-State: AOJu0YwHPX7uPpfzi2FowpAS5NDxmYHO0jW4fnEg9e3uKnLuyPbbH8/n
 0iYF3f7nv7wrXiHqUuq01IyNkUdUupQ9Q9poDOcp3P0ixjT9nuvgHfhU
X-Gm-Gg: ASbGnctB3go778Hkmeal5oeuTU9n4weU57zdTAGkFAW0XvBF2Ni5s4G1JCYEyXNUbBk
 2MM5/jLXV/+lB3lT4DBdgHNtjQJwiJTK/cM0xbdn3Mmo32SodL4xOwA8rEWIP/BDS8Y4qhhRfXO
 qfXOpVZEMdEVEX+3ahy6iP/YkuuErNBLLHwl5COJsOZkkIeJK+j1AvH4F3BWS7VM70segDkACl6
 KyEVeY4+ZwuHTIda7LDNGeWqqoV14pBebgAqkwfkjMgqae9buSdohkVZl1XeNPedgsA8NL2TSFA
 glVNjapEKvpsfu54GwQ1VrCPoVjOOr7rKMRHIFz70cQZvNCDs92gT6KvwYwFZOP53uoJb8a5gwn
 CEwmOCcegL6cZ1TRYiPTnNBmGFnyvwHa6MxJbDsfRox/0jkK2lw==
X-Google-Smtp-Source: AGHT+IFFYITYlYgWedAgsGkK7hUGbCzt0lAVimiJq3U6kWX5cF4EX6rm73WJBl83vENC1vqQcYN2Aw==
X-Received: by 2002:a17:907:ca21:b0:b04:470b:64a5 with SMTP id
 a640c23a62f3a-b07c37e18e0mr1122241666b.36.1758042116367; 
 Tue, 16 Sep 2025 10:01:56 -0700 (PDT)
Received: from [10.192.92.112] (cgnat129.sys-data.com. [79.98.72.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b32dd47bsm1201321866b.58.2025.09.16.10.01.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 10:01:55 -0700 (PDT)
Message-ID: <53a9b16a229930a3caa80af9541f16b4a8b6094c.camel@gmail.com>
Subject: Re: [PATCH v4 07/10] qmp: add chardev-resize command
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Eric Blake	 <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Szymon Lukasz <noh4hss@gmail.com>, Daniel
 =?ISO-8859-1?Q?P=2EBerrang=E9?=	 <berrange@redhat.com>,
 devel@lists.libvirt.org
Date: Tue, 16 Sep 2025 19:01:49 +0200
In-Reply-To: <87bjnao8ae.fsf@pond.sub.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
 <871pob7ot7.fsf@pond.sub.org>
 <64d6252959750b8da6f3bc4ac7c738b10463bf6d.camel@gmail.com>
 <87cy7s1auw.fsf@pond.sub.org>
 <ffa90309f0ce8c81836e5e7074d67ae76033b67f.camel@gmail.com>
 <87bjnao8ae.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x636.google.com
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

On Tue, 2025-09-16 at 15:07 +0200, Markus Armbruster wrote:
> Filip Hejsek <filip.hejsek@gmail.com> writes:
>=20
> > On Mon, 2025-09-15 at 08:35 +0200, Markus Armbruster wrote:
> > > Filip Hejsek <filip.hejsek@gmail.com> writes:
> > >=20
> > > > On Fri, 2025-09-12 at 16:01 +0200, Markus Armbruster wrote:
> > > > > Cc: libvirt
> > > > >=20
> > > > > Filip Hejsek <filip.hejsek@gmail.com> writes:
> > > > >=20
> > > > > > From: Szymon Lukasz <noh4hss@gmail.com>
> > > > > >=20
> > > > > > [...]
> > > > > > =20
> > > > > > +##
> > > > > > +# @chardev-resize:
> > > > >=20
> > > > > This name doesn't tell me what is being resized.  PATCH 04 uses
> > > > > "winsize", which is better.  The (losely) related SIGWINCH sugges=
ts
> > > > > "window change" or "window size change".  Below, you use "termina=
l
> > > > > size".
> > > >=20
> > > > How about chardev-console-resize? That would match the name of the
> > > > virtio event (VIRTIO_CONSOLE_RESIZE).
> > >=20
> > > Not bad.  It could become slightly bad if we make devices other than
> > > "consoles" make us of it.  Would that be possible?
> >=20
> > I don't think the size has any meaning for devices that are not
> > connected to a console, although the code does not care whether it
> > actually is a console and simply has a size for every chardev.
>=20
> Double-checking: the command works for any ChardevBackendKind, doesn't
> it?

Yes. For some (e.g. stdio) it will clash with builtin resize detection,
but it can still be used (last update wins).

Maybe using the command should be prohibited for some device types?

> > I guess I could also rename it to chardev-window-resize
> > or chardev-set-window-size. Let me know if you prefer one of these.
>=20
> I think I'd prefer "window" or "terminal".
>=20
> "resize" and "set size" suggest that the command initiates a size
> change.  Not true, it notifies of a size change.  Maybe
> "chardev-window-size-changed", "chardev-terminal-size-changed",
> "chardev-window-resized", or "chardev-terminal-resized".

OK, then I'll use "chardev-window-size-changed".

> > > > >=20
> > > >=20
> [...]
> Another question...  'vc' chardevs accept optional @rows, @cols (see
> ChardevVC).  Is this the same size or something else?

Well, yes and no. @cols + @rows control the actual size of the console
screen buffer, while the chardev size is only used to inform the guest
about the size. @cols and @rows can also be unset, in which case the
size will be determined automatically from display and font size.

This patch series does not yet implement size propagation for the 'vc'
device. I have WIP patches for that, but there is something I'm not
sure how to do, so I will likely send an RFC first.

> > > A clearly invalid size.  I guess it effectively means "unknown size".
> > > Should we document that?
> >=20
> > Probably. 0x0 is I think also the default size in the Linux kernel, but
> > I don't think the Linux kernel documents this.
>=20
> How does 0 x 0 behave compared to a valid size like 80 x 24?

In these patches it is not treated specially (apart from being the
default). I think the Linux kernel doesn't treat it specially either.
Terminal programs generally interpret it as unknown size and use other
methods to obtain the size like environment variables, the terminfo
database, or defaulting to 80x24. Example:

   $ python -c 'import termios; termios.tcsetwinsize(0, (0,0))'
   $ tput cols
   80

>=20
> [...]
> > > > > Do we need a way to query the size?
> > > >=20
> > > > I don't think it is necessary. What would be the usecase for that?
> > >=20
> > > I don't know, but it's my standard question when I see an interface t=
o
> > > set something without an interface to get it.  Its purpose is to make=
 us
> > > think, not to make us at the get blindly.
> >=20
> > I guess it might be useful for debugging. If the size is not propagated
> > correctly, one might query it to find out on which side the problem is.
>=20
> We have query-chardev.  It doesn't return much.

I'm not sure what you're implying. Shall I add the size there?
> > > > >=20

