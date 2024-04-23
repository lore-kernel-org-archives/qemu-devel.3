Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0237EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 12:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzF8g-0007Hn-E2; Tue, 23 Apr 2024 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzF8a-0007HA-68
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:20:41 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzF8W-0000Lz-RF
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 08:20:38 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56e6a1edecfso8391579a12.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 05:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713874831; x=1714479631; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gYMz7MjvN68OhLwjzExPLgLFmIo+u86IPAUUmgeTNj8=;
 b=NJHt1vDdCUo7uCQJYM+U39arqpiRFkyVdTzcdxGBIfklmZsSUMh0q1wBs6yUActUdX
 QCG8mJcb03f2N1NucPUN+8zs8WpVG47KjkZNoAKbLN/CFQWjzGiP6QPxRKIf7YHqp+1y
 XsO0qnzu8KM70PokkmL415raqjqoLB56tgZWxTnCwLH/24O8WINKZ7uTC1SByT9xOxl2
 5uY8/XoGzu3RE1eXyGRFizJ6sX6qZUgolNA/2jFuTPWVo99l8fHhrb4yTvedKsjVIZm3
 BWRiJyauaJQWSx/mGDme0XhjsjBapwsQEbohPMEHUHgroiuy4VOZPRrX3ebvUUPvtRg9
 dCbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713874831; x=1714479631;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gYMz7MjvN68OhLwjzExPLgLFmIo+u86IPAUUmgeTNj8=;
 b=RZe6lzKIGl7VYQkkXSAwuBOsPZikdu4Y60Nj798o9kG0vJIQWDjRAKevk7abmHBChd
 Jut55EpQoU2l9ASJX9KnZonNvk7Xwqew1v0UcoPB7vWTC53Xt6cA17zNNjWpe0snGO4N
 vcVfDQJlmFKcscBy07cfardD7+T+hS/o/ErdnRG/1R0RWyy2s7SWftkC2Hu/MmpSChFN
 GueMpLlhA08jMQ755tXSPhcPk8P6g5bDtaXbS5CWCzqrTC+0b0aCQJhMsCC5tD5Qy0Y0
 4d1yw+bceGhRvxFQeKSmAnNplPN4JTJpAHaWPc0JljxK/sL745ch9YMmbbWU/F4nSmrz
 JkTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVcGxsCpQKi4EHA1TWEYoMhpJvbapgOzsyhBmDCYxlw42i31EzS3TwWSeMHqTJrVl+QqPuQKMzlySEcPM70e1iLuQ7cyc=
X-Gm-Message-State: AOJu0YxNosuz11MLHqBHqk7q0xzeKE8ZhnfU6B7PLBPXqHAY4u4Ku5e3
 UvScpXFwttkueOUGCYFO+fA/zRJ+Soilz4DuC4ScaG1DR+7Oo/ukXbrVL9i3esc91G495Ka1501
 u3BhE9FI8bDrqJxOh+75CkbCVDBiIZ4PEGPbAGw==
X-Google-Smtp-Source: AGHT+IEufC5CQcooFDS8qycrr/9+VHGzEu1NCuH8j9PxeX4emguu3mhQ1mjOuslnsJT6RT+XKfHg4eyQ4b1pVbigUjg=
X-Received: by 2002:a50:9fc1:0:b0:56b:d139:490 with SMTP id
 c59-20020a509fc1000000b0056bd1390490mr9622407edf.6.1713874831482; Tue, 23 Apr
 2024 05:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240419155709.318866-2-jean-philippe@linaro.org>
 <20240419155709.318866-16-jean-philippe@linaro.org>
In-Reply-To: <20240419155709.318866-16-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Apr 2024 13:20:20 +0100
Message-ID: <CAFEAcA_0wi_Ujt5vjbcUFacNqxktmbF7Kma8uEw+pOUp==W0oA@mail.gmail.com>
Subject: Re: [PATCH v2 14/22] target/arm/kvm-rme: Add Realm Personalization
 Value parameter
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, philmd@linaro.org, pbonzini@redhat.com, 
 alex.bennee@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 19 Apr 2024 at 16:59, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> The Realm Personalization Value (RPV) is provided by the user to
> distinguish Realms that have the same initial measurement.
>
> The user provides up to 64 hexadecimal bytes. They are stored into the
> RPV in the same order, zero-padded on the right.
>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Eduardo Habkost <eduardo@habkost.net>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> v1->v2: Move parsing early, store as-is rather than reverted
> ---
>  qapi/qom.json        |  15 +++++-
>  target/arm/kvm-rme.c | 111 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 125 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 623ec8071f..91654aa267 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -931,6 +931,18 @@
>    'data': { '*cpu-affinity': ['uint16'],
>              '*node-affinity': ['uint16'] } }
>
> +##
> +# @RmeGuestProperties:
> +#
> +# Properties for rme-guest objects.
> +#
> +# @personalization-value: Realm personalization value, as a 64-byte hex =
string
> +#     (default: 0)
> +#
> +# Since: FIXME
> +##
> +{ 'struct': 'RmeGuestProperties',
> +  'data': { '*personalization-value': 'str' } }
>
>  ##
>  # @ObjectType:
> @@ -1066,7 +1078,8 @@
>        'tls-creds-x509':             'TlsCredsX509Properties',
>        'tls-cipher-suites':          'TlsCredsProperties',
>        'x-remote-object':            'RemoteObjectProperties',
> -      'x-vfio-user-server':         'VfioUserServerProperties'
> +      'x-vfio-user-server':         'VfioUserServerProperties',
> +      'rme-guest':                  'RmeGuestProperties'
>    } }

This list is in alphabetical order. Are we obliged to add new
items to the end for some compatibility reason, or should this new
item be filed in its correct place with the other 'r's ?

thanks
-- PMM

