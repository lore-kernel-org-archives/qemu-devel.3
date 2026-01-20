Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C368D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi6j3-0003PY-QB; Tue, 20 Jan 2026 03:04:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi6j2-0003Mw-5S
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:04:32 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi6j0-0007Wy-ET
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 03:04:31 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b87dba51442so278981466b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 00:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768896268; x=1769501068; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7Cr4864TJeA4DxA/v05JXmCXQA4LcL+Hru6DQNeSr/A=;
 b=N9Em1wdELZwxQIomFEfXDgft1fes1qbDRNEzv59IxzBoDfV1URie1Pxeqd74QQeboU
 90J+N0I4PUcqs0Rg/5Bj5D1Qnx/EfAG5WbvyPEEV2L6bcI0Q2W/cvPpLsXXcPSEXQUoJ
 zlc9DlCYqv4fp2cFKwA1OLBxQ/EuEvpCYCqW/qRHk/VU5UfyZGqSE/hyp8qhRVhCxguo
 K6W8f6/x401jJG9DaneTOj2Wi8w+VfZXAPeQmgbU3zBuIpCPQvql5iW1q9BIKDBW9+Q+
 B9zPOPvHXdQ8htSZVEWn7fDTOQoLwEJX1kekOJf7wdz9JNKeGY8OlgcYfANxpJ3nY2hu
 t9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768896268; x=1769501068;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7Cr4864TJeA4DxA/v05JXmCXQA4LcL+Hru6DQNeSr/A=;
 b=VfVsf/q154todLT/MBf9ikmcD0iNs4F40aijuagTG3pYr7jow/PSkmGV+tvNDsqp5x
 hY+PZe5H/U0fK3GOk88BT2kzyQqgICA9hRW0ZdKO6nYB7Eb3nFl+bbmKxQg+T29ALCpt
 HL66sM1jsTrD3pJ27yLF3pzvs4T3fzweSswqpEc/vquNcnmhAvPxCPqBYHS3DF7rIQaH
 PhjYVYiz73LY5gCUsxL6n/pWACjg3deQd0C3S2I1Eb5zTrM6+ozwPP5YZqfAcCW4dNxQ
 drTLjySEfa8mhJsBcpzFxulhpeF0qppgCKTu+fxIvitalp5QXg9SUxm9aYjIN38jm/1p
 EeWg==
X-Gm-Message-State: AOJu0YzB2Y7PiwIWsrYjnwNGe0rCTc0iMLnKEa9MIyDA5L/l9z6yd72w
 ss+6+/fGBzPZS1rdvl0LVJFEmKHLrf4CHsHmZLExJTR+074ntmuVsJiI
X-Gm-Gg: AY/fxX6AeJuHyeGL89jgcCj/J2FB2raXkFihaw9yAFJLMQxuIgTDdDYFYhrp76syLZf
 q9NGdn0LYfIeYOvtWAw58/ubOLlhI4LUkmWGQWvqOILYTr2Nj320w9Pn+BHgo0iQxIIVzHDOZDi
 vTRitmr4Kvj2pfKCes6DtyGWYPRjajHlOmhaglL9RU/d7H6DlN/6xgrUgCUwSFQZdPKJNUHWRSQ
 IFhA8KlrTpw4MhIlkLth7UZLyfG7LNn2R4iOEv9D3Pm9Ug3m9K773Gxs0u2aD3PnjBrAjIoCtUf
 /61TjUnAESJqS7NC975B+hMNU1/U0TREJL/QLvR0XIJEBMux6jOaDw1MeTqsShEFHOxoH8FUirW
 HIL7FmJK8XZR+/exxBw+V3s7GKsXCBTBx3Qbpg1JCT+ZZGC2t4bARdgnBDOSSktUeOZFZTFw1zS
 gAXHZgArc0g5i06HFxebpynPg3xLwA+eym3Q+NagoaoiRDYA==
X-Received: by 2002:a17:907:782:b0:b7f:f862:df26 with SMTP id
 a640c23a62f3a-b8792d6d49amr1094522366b.14.1768896267724; 
 Tue, 20 Jan 2026 00:04:27 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb973sm1297722266b.53.2026.01.20.00.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 00:04:26 -0800 (PST)
Message-ID: <924c52d6089b3c0cfd3a235887579ae0322cffba.camel@gmail.com>
Subject: Re: [PATCH v6 07/12] qmp: add chardev-window-size-changed command
From: Filip Hejsek <filip.hejsek@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Amit Shah <amit@kernel.org>, Eric Blake	 <eblake@redhat.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum	
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, Daniel =?ISO-8859-1?Q?P=2EBerrang=E9?=	
 <berrange@redhat.com>, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 20 Jan 2026 09:04:23 +0100
In-Reply-To: <87jyxep08i.fsf@pond.sub.org>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-7-33a7b0330a7a@gmail.com>
 <87jyxep08i.fsf@pond.sub.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x630.google.com
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

On Mon, 2026-01-19 at 07:47 +0100, Markus Armbruster wrote:
> Filip Hejsek <filip.hejsek@gmail.com> writes:
>=20
> > From: Szymon Lukasz <noh4hss@gmail.com>
> >=20
> > The managment software can use this command to notify QEMU about the
> > size of the terminal connected to a chardev, QEMU can then forward this
> > information to the guest if the chardev is connected to a virtio consol=
e
> > device.
> >=20
> > Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > [Filip: rename command, change documentation]
> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com>
> > Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
>=20
> [...]
>=20
> > diff --git a/qapi/char.json b/qapi/char.json
> > index 140614f82c..bc08f0161a 100644
> > --- a/qapi/char.json
> > +++ b/qapi/char.json
> > @@ -861,6 +861,37 @@
> >  { 'command': 'chardev-send-break',
> >    'data': { 'id': 'str' } }
> > =20
> > +##
> > +# @chardev-window-size-changed:
> > +#
> > +# Notifies a chardev about the current size of the terminal connected
> > +# to this chardev.  The information will be forwarded to the guest if
> > +# the chardev is connected to a virtio console device.
> > +#
> > +# The initial size is 0x0, which should be interpreted as an unknown
> > +# size.
> > +#
> > +# Some backends detect the terminal size automatically, in which case
> > +# the size may unpredictably revert to the detected one at any time.
> > +#
> > +# @id: the chardev's ID, must exist
>=20
> Please drop ", must exist" for consistency with ID descriptions
> elsewhere.
>=20

On Mon, 2025-09-22 at 11:38 +0200, Markus Armbruster wrote:
> [...]
> >> Let's drop ", must exist" for consistency with ID descriptions
> >> elsewhere.
> >
> > All chardev @id parameters in qapi/char.json have ", must exist"
> > (although you're right that nothing else has it).
>=20
> Right.  Feel free to stay locally consistent then.

I'll drop it in next version, but all the other instances should be
dropped too.

> > +#
> > +# @cols: the number of columns
> > +#
> > +# @rows: the number of rows
> > +#
> > +# Since: 11.0
> > +#
> > +# .. qmp-example::
> > +#
> > +#     -> { "execute": "chardev-window-size-changed", "arguments": { "i=
d": "foo", "cols": 80, "rows": 24 } }
> > +#     <- { "return": {} }
> > +##
> > +{ 'command': 'chardev-window-size-changed',
> > +  'data': { 'id': 'str',
> > +            'cols': 'uint16',
> > +            'rows': 'uint16' } }
> > +
> >  ##
> >  # @VSERPORT_CHANGE:
> >  #

