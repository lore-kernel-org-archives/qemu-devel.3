Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B117DD2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 09:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi8NH-0003Tk-L8; Tue, 20 Jan 2026 04:50:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8NG-0003T7-Cu
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:50:10 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vi8NE-0000EA-NQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 04:50:10 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b87693c981fso866580366b.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 01:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768902607; x=1769507407; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ubWRJCezOQ6m+E/RQNuchgLjAWViEyryW29xM4HhZMU=;
 b=MJ5z68HgBkVvirzrB9G7ZEhyCaVtfp1wNgLugX0sK0McNLAlyxtuojOJ1azxrPW0eC
 Io0+2dLQ8oFHU4vvIQMIZZu9hJ3j0fG5aJaX1UBtZf2KM42MWL8AvZJhElK5U2V1+Oiq
 Gu9i9kyQRQ0bBq1Mxuf5tG16/ghIPz0Jfy/co392ps+OF3Inq3hb1kYzXtpWwaaysPIE
 maLgsOaLVQJgdW+weyHz7WlPDA5VOcDZrNz+k3yodil90zVd0KB/rGEF0o5nPT3v1/GH
 KxuBlW1J4zWt47U6t+T419qxIUCqv7RjRxurihqPHGASENDeeSRe9FfjpjYXNrd0nSS1
 d2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768902607; x=1769507407;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubWRJCezOQ6m+E/RQNuchgLjAWViEyryW29xM4HhZMU=;
 b=EEybg9V8Bp0VhyawHVgWstmjK7Vf1wfFxh4S7wGJ0xl/nX+/c5b4SmLbM5XlgwkYzg
 6sbWlEEJQDFcOnM9X+kPdk8waulZadU5/qXhInyI35bzSst0k5KY3UyVj+8RJQ6UH2Md
 lC/6hGvn2Rd8+686eC0fDZr197CK4CL9rHm9cL0kYlBVN9Ezm5s1bjQK7l1EwU4qE0se
 6+QlniCnGPAWXTDKlha6/gL3xLFtIEjLQKcbhFwLxm6Bu1hC/X1o/Udyo8CNcIDQf3PY
 aRGmF5krEt5OpUm4aop03sK1Ss0RM9PAeJzJOzl/AnuWxryncjnSDF354KhV+wKdR5HH
 JuLw==
X-Gm-Message-State: AOJu0YxqVeAf4tw2Lc/dPJrhXUwZV8PgNbDAz8WNwTk1IHy/LjbdUgQw
 hX6pP32pQD5KzPp4Y27R57y+E9VT/omG6rjg5WdiCKwsGT/cCZ7TzyqnwlzRnw==
X-Gm-Gg: AZuq6aLA44XSKKdlFlpQeTup3674pt2IlsRUNDrRXkbODLVCsvKJpKndaO6nrOcto1m
 slfODFoKNIb/hvWW4vlR3eXxILiWEHEqj2QObjIK51rYiZWvzFHlguGoXJxihnd+Nh1VZGnU6Vd
 4iemuZQU/iNwQrDtbPz9/ggG38Pb9enRrJn3nL8M3Yf1XR4iAOMmo+BLFHQWPtK+vSRh05Sf1L8
 of8jlSy/rQFL/iq8JnrOC1pvW7eyJ5xpQhYpSOs/b73B98Iu32OUylRh95dF36DaU33hCgvJnIE
 qygKLaV9MSGa9kbOVT9O/Bx6nSZ8tvCmvBxfJp6vw4elriKmi0WW+dXadizBfqS2dZ9iGNGK1Ce
 vMPjC1rnD1mcYiioA2cTjn7y/CTUiA5Jl76eKDschhP0N3QB9O9b5LrFJHgw7tvWFLTQl6vNP5K
 mm5hCZnC5FTi71Ly/23KQsg6Gd6aij5vIb2sxPCmX7Fkvhfw==
X-Received: by 2002:a17:907:1b08:b0:b87:2b69:89ce with SMTP id
 a640c23a62f3a-b8793024235mr1171258266b.63.1768902606411; 
 Tue, 20 Jan 2026 01:50:06 -0800 (PST)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8795168b2esm1379273166b.17.2026.01.20.01.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 01:50:05 -0800 (PST)
Message-ID: <6910accb5917c60e89801af1c3528187e732166f.camel@gmail.com>
Subject: Re: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
From: Filip Hejsek <filip.hejsek@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,  Amit Shah <amit@kernel.org>, Markus
 Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu	
 <zhao1.liu@intel.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Date: Tue, 20 Jan 2026 10:50:04 +0100
In-Reply-To: <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
 <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
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

On Mon, 2026-01-19 at 04:27 +0100, Filip Hejsek wrote:
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
>=20
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
>=20
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that old versions of the Linux kernel
> used an incorrect order for the fields (rows then cols instead of cols
> then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26=
c7056ddd.
>=20
> As a result, when using a Linux kernel older than 6.15, the number of row=
s
> and columns will be swapped.
>=20
> Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
> but partially rewritten to fix various corner cases.
>=20
> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>  hw/char/trace-events              |  1 +
>  hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++=
++++--
>  hw/core/machine.c                 |  4 ++-
>  include/hw/virtio/virtio-serial.h |  5 +++
>  4 files changed, 83 insertions(+), 3 deletions(-)
>=20
> [...]
>=20
> diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio=
-serial.h
> index 60641860bf..bda6d5312a 100644
> --- a/include/hw/virtio/virtio-serial.h
> +++ b/include/hw/virtio/virtio-serial.h
> @@ -145,6 +145,9 @@ struct VirtIOSerialPort {
>      bool host_connected;
>      /* Do apps not want to receive data? */
>      bool throttled;
> +
> +    /* Terminal size reported to the guest.  Only used for consoles. */
> +    uint16_t cols, rows;
>  };

I found a bug: after a migration, the guest is not informed about the
new console size. I see two ways to fix this: either add the cols and
rows fields to the migration stream, or always send the console size to
the guest after migration, even if it might not have changed. Which do
you prefer? Modifying the migration stream is somewhat annoying,
because both versions will have to be supported, and also the device
still uses legacy save/load functions rather than VMState.

