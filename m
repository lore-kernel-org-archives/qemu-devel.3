Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C0D1C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 18:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsoGP-0003Hp-R1; Fri, 05 Apr 2024 14:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rsoGM-0003HR-K6
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:26:06 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rsoGK-0004Wt-WF
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 14:26:06 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516cbf3fd3dso2788492e87.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 11:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712341563; x=1712946363; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xNXRTUb49JePcTF5xfn23c+b4dVbcg7OMFFQ7DsnMvk=;
 b=xSUH1BQFkRrhF3+W1C3tXN36u+K1qSFj0pY+17oDGZJa5JONEuQ9OUqFa/rTbs1mIo
 Qnz7zHB7xvWQvIu6oVSNDGhWvgeK+PWAPfj9k7RUjf5sRdTXVj++/OOPLIzrvuxbrVKs
 Pup+SDzE97WU1mhPTYmMK/wyOqwi5wGtQsyxC7vmDqT4hn/Fk0FgzBYb8D3owmHTnMUd
 vD9RZ7wDhfSWn2HtR7+YAaO/+NwRkT20jeUNnuVLKDgcnxSCKVQXCtM27NT/kUuHx3AK
 sTWTUwAvgSdqvqRgW9bz986YSEAwj2x1DU7QuEG7uWJdfzDaWPpUriRhA+8YLJY53cbc
 pZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712341563; x=1712946363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xNXRTUb49JePcTF5xfn23c+b4dVbcg7OMFFQ7DsnMvk=;
 b=IL6xgGYmjY4+5MvLYu/yZnMy3gK6JCUTNG+lP22dSl2YUnfn8MOfKPffPuswHojqls
 Lw5kEfd7Iq5ZRNMf2cbPWPJemhLXJJ3bmxR/A1dYkiX0+uEIVfFK79Gc/4Aqgxx63wZT
 cAvbQz4M5ddyoUppfA145H574MpYqxslDMhIFZ57r8W+CpD6WfzjTpCqVe/oqfE+111Y
 wBxh7ed139ANQCHeDXvP06bIMBGZLm7nmspzMFpyQxg6UajAvU6MUzyAFchlqdnWS1J5
 GRtlGdtJ388spqv+qzoBZ5FMQGCNhcJB7qt8iaSK5Xzal7WKLYCY6PRnZ3/cL3LxaFNr
 jbbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHzONkmMkF0oKur75GQNo87r3qtAzza65zDnI1+AKQ7saca1Bij/mbv0zFoMbP5iSint1UnEwUPFgPBnnyKT3cePH4M4w=
X-Gm-Message-State: AOJu0YxZ5qaEPrizA2gi70EbCje1YjNPCl7xxbq6rcenKT/WZ1rZGoaQ
 QYVAZcmMcQ11zMFuE6GEoww9H+L/VA21SDS+82mg6QGGbCOoaCMaZfeoO5LaZgAgf+7VqdlyLyJ
 XepS1IL3MReqeQCC4oYbVw6iZ82GJhPpc+mEfgg==
X-Google-Smtp-Source: AGHT+IE0jPM2XVkRVeQ4gZYjhUkIUHrEGqfrC1Kc4jZWODaUoDMsUM8XRrxl+9Mg1NfTwMQK5iVT2KL3hZOADZfBdJY=
X-Received: by 2002:ac2:5b1b:0:b0:516:d4c2:5413 with SMTP id
 v27-20020ac25b1b000000b00516d4c25413mr1663202lfn.68.1712341562795; Fri, 05
 Apr 2024 11:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
 <bgucz.0f0amac25xfr@linaro.org>
 <20240405070632-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240405070632-mutt-send-email-mst@kernel.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 5 Apr 2024 21:25:46 +0300
Message-ID: <CAAjaMXY5Hh3S8-1xBQsUSgAwP54a2-prfVu1bT0=uWkVZxof5A@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] virtio-snd: fix invalid tx/rx message handling
 logic
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org, 
 Gerd Hoffmann <kraxel@redhat.com>, Zheyu Ma <zheyuma97@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 5 Apr 2024 at 14:07, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Apr 05, 2024 at 01:54:46PM +0300, Manos Pitsidianakis wrote:
> > ping
>
> confused at this point.
> Do you mind sending a patchset with everything in the correct order?
> Tag it PATCH repost so people know nothing changed.
> Thanks!


Might not have access to my desktop for a while, so until then let me
know if a resend is still necessary.

The patches are two, in this order:

1. <20240322110827.568412-1-zheyuma97@gmail.com>
2. <virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>

Thanks,

-- 
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

