Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39BE7CAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywxa-0003eW-0a; Wed, 17 Sep 2025 14:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uywxV-0003e5-UV
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:32:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uywxU-0005Fx-5C
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:32:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-45e03730f83so598235e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758133966; x=1758738766; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Yw+mmMB6ZrExRu2J5HZfRRbKiLbQMpnKeY/38FAYmXA=;
 b=feVnGRk1Hr9gvU/epD21I4Zn4y7zkC9dmawwou4+gGENtdXNszYXl/KbhxOAWK4W7u
 taTNqjPAw/uCbhjyUiwT2uD2wOmtbVofzodeeg7fLxHRdXwdprw4Qb3Wdx1+yGI+O/Ou
 UEp0GQyb8St3tpizNdUqlUY1ceSOdfVTSzhImVby6zNWklMzd4vAst6frUqZDqrzjaH4
 6AA4Mt7kOES6zbQcbdF/fj8ecuKm5N/yLbmxBQ+GSTAHhu2nN1q2hS80nzxy5lipqKOQ
 GdPPmOhV2YDKzS0FPmH1i6+ObylUWkfSz9oTuqqwxgUsuHOhBiZkEDK84zuyk8hOKpg8
 C5Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758133966; x=1758738766;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yw+mmMB6ZrExRu2J5HZfRRbKiLbQMpnKeY/38FAYmXA=;
 b=qqPF2cJx6W06inS9RIwUWAsijIYZa6czMW+/olWnZWVFUe2NT6omiT0WVoHkLiVnSh
 9cmNLJFcLsutbYvk7QifPJaKrR2Lq7NkZzMtzQCEhO20lWPsxrLeEXaj2jsgoZ0XFTcx
 rDG1fdQa5pdu64MuGznC+8SoMU8+XDEFzUqe8JKA0MpD1e8TJ+pIOzfS6FbZP6MluTVe
 RfXUiJkC3FT0769md/R/o+5jdsaI3LE2WpzxnUHjPZO3e4D1X5Ww1pNGw3KEEpOsuIrY
 iiWiRsk48zktQHWPyrSAii4YtBCeArjvHVFJiksABYd+rYYzMN3lJmVwYkroOugRIUQO
 Nlfw==
X-Gm-Message-State: AOJu0YyafGXXV8sqedS0T/UzlrSgREXyea7eCdectFhsdHIXpzVcYlOp
 2WfBb5RWMLvNvjQxiIpXWm9mIyfYJyogj2jfcVHD56OWKbL59p/mzp8x
X-Gm-Gg: ASbGnctbxKQvs60vU9hj+NqXLSkzSgewJ67JhfZqBm96jsNbqjZariHxdHiuezrouNZ
 v9za9npexz8CRUBLP8imeUW3FS4nPNW+A2YYFxVsdg+ZSOoeppFRcivDgW2G92NUHXcNf0fXpcy
 4fc1kzZI+NTGrT1BL3YyZbSQEnLc0doGuiGR7k8607W2cnTNp/TY+VIkf/9l5vXuTMMBa8ehCD9
 foDwg+fy9aEeI79BNSu8jk7wEbCOe9zU0EVDyt9KSSNGQ7FJL+4aqTxexHiRPdGLKCKUeHpHKMG
 Rhp3KjugJM/XUH7XNla6JKJJuokp4VLZpubLGMWZTsPxpFMr+toVR+penLbWsXIQSj3P0r99Aa8
 xJg7/wb6tOHwualcEj6mC8Xc6/dlIv+/6kfzhWku450zOsxnLslRJ3s36tw==
X-Google-Smtp-Source: AGHT+IHTph1MPJUVyTXS5o2GxlOmHul8orekAX+q/SlKNJrBAeBHVvRAixwbhdDzeJbpsB/r/lgjxg==
X-Received: by 2002:a05:600c:1e87:b0:45b:7e68:c6a3 with SMTP id
 5b1f17b1804b1-462031b1e59mr38297285e9.16.1758133966011; 
 Wed, 17 Sep 2025 11:32:46 -0700 (PDT)
Received: from [192.168.232.93] (37-48-56-34.nat.epc.tmcz.cz. [37.48.56.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-461391232e7sm46431765e9.6.2025.09.17.11.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 11:32:44 -0700 (PDT)
Message-ID: <68ea175aba137ac0e4336bfacf09453925e6b47d.camel@gmail.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, Szymon Lukasz
 <noh4hss@gmail.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>
Date: Wed, 17 Sep 2025 20:32:40 +0200
In-Reply-To: <20250915190638-mutt-send-email-mst@kernel.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <ecb9a5310ec1b846124a6342232dd421778df064.camel@gmail.com>
 <20250915190638-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x333.google.com
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

On Mon, 2025-09-15 at 19:08 -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 16, 2025 at 01:02:02AM +0200, Filip Hejsek wrote:
> > While thinking about the patches, a few questions about the virtio spec
> > have popped into my head.
> >=20
> > 1. Should the config space size also be updated (for port 0) when
> > multiport is used? Based on my reading of the spec, I think yes.
> >=20
> > 2. Can VIRTIO_CONSOLE_RESIZE be sent if VIRTIO_CONSOLE_F_SIZE is not
> > negotiated? The spec does not say, which I think means it can.
>=20
> But the guest can't do anything useful here.

It can if the reason VIRTIO_CONSOLE_F_SIZE was not negotiated is that
the host only supports sending size for multiport devices (e.g. because
port 0 does not have size).

> > 3. The spec says that reading from config space fields that are
> > conditional on features should be allowed even if the driver has not
> > (yet) accepted the feature. Does it mean that we have to update the
> > size even if the feature is not accepted (yet), or is it OK if the
> > reads return 0?
>=20
> This is talking about the window before FEATURES_OK (and so DRIVER_OK)
> is set.  It is best to update the size. There's no interrupt to send
> though.
>=20
>=20
> > Thanks for any answers or opinions,
> > Filip Hejsek

