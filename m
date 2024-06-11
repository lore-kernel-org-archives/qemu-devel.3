Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE3DC41513
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwuQ-0000a1-1i; Tue, 11 Jun 2024 04:31:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGwuI-0000VJ-31
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:31:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sGwuG-0004ho-Fg
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:31:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57c778b5742so2809802a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718094662; x=1718699462; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBM1lmxk9SqQfQU0caWRbtEyiyYWjt1uLUTr1AlIS4U=;
 b=Tx+JoeVZTB10b2pyBKlBlw1xkDqoXBu/geVPzez22mUIT9z85wxzqSA75Gbh3xlTca
 Vrm0s1QFeZg3NqYoYali4he86hilYgAsxAlT9MUcrO6CftfXKVgyUy2H3sEIcT8FSem4
 Fo24AwOO111lCaOaJ+SvLGwEeoE6XOaR2DdtD4KTUHRnEeyxE6s2570n1FEQLfK8tQbc
 bkB075ZAgT5P9K3Es3X6sOChqrFH21/cbiwSiEO7wfCHSDhXPxcXhjkEvDMoIvTjcfA3
 H6OxYhxxhcQMnAfVIhwI4kbGa73TAmQgi89cwp5brxcpgzzPFwIrCVqRJa7IotPbUvkL
 vhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718094662; x=1718699462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LBM1lmxk9SqQfQU0caWRbtEyiyYWjt1uLUTr1AlIS4U=;
 b=eM77VSaJAMxeyVz3ia8cqWh/ph7OpaA8N++zDe/K+/AtD0oxmkxeWAH7pPXGa/XGEB
 DUnvE3mKsbeJSxjcsIeDRfuzVOMotnQCdfRJlUTrnFKSAyFLeUCsDl7Ev/TX/eEVEn4L
 WqlqkL7PPTciksDtRzZDyvClr7EG248vtsph/pIJj6YAXaMS4bBd3Ic40xBwHsrOJtGJ
 U3IP6rwMvKMY4ZoUiwGf+CCgLUmlNkS4/oYGqIV11JNKxZBM7luRPcNTiNX6DHBOg5pa
 XGrt0yZXUoQEmvxnlLnMeBFqGh+dZllum22KCBEZkpAPcDOpJHDUbvpJGqL9MVbjH8e8
 oshw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDQa38pHMrb0EP5lOw0b4Q8SZs/jjHWJIblsEadopAqmRUNw9sQ/Gv9j7KyjqelPVdNd/qB5751ApNP0XFxWfr8iDa83w=
X-Gm-Message-State: AOJu0YxcxIgAssikFNfOdS/uo2O9JT3uAOg1C3GOcixVN4Cs4XChnEtf
 zkSp3549JkrcScPdySkffhccL+Y1CH6iuNCoVCOVTTY77A/gi5pE4MuebqsbBsqTIKGGMOIWHh7
 7i+AQgEvV63z7C5doE8b+AOS5p2rhcWb8XDj0kg==
X-Google-Smtp-Source: AGHT+IEf/ig5kmx7kzEpKb7oObj/iPolvTgzKoM+xdAXnVYPnATiNMKpJsvsOywMaE3klg8XAnNj3hbOPgxgblGC4YI=
X-Received: by 2002:a50:d5da:0:b0:57c:61ca:eb8c with SMTP id
 4fb4d7f45d1cf-57c61caec8fmr5635508a12.42.1718094662527; Tue, 11 Jun 2024
 01:31:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240610150758.2827-1-philmd@linaro.org>
 <87h6e0uizr.fsf@pond.sub.org>
In-Reply-To: <87h6e0uizr.fsf@pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jun 2024 09:30:47 +0100
Message-ID: <CAFEAcA8F9fTVuTwNosLi7qcZ7ki-kARKJsnrp3-er41LbkpZiA@mail.gmail.com>
Subject: Re: Examining device state via monitor for debugging (was: [PATCH
 0/2] hw/misc/mos6522: Do not open-code hmp_info_human_readable_text())
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 11 Jun 2024 at 06:50, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>
> > Officialise the QMP command, use the existing
> > hmp_info_human_readable_text() helper.
>
> I'm not sure "officialise" is a word :)
>
> Taking a step back...  "info via" and its new QMP counterpart
> x-query-mos6522-devices dump device state.  I understand why examining
> device state via monitor can be useful for debugging.  However, we have
> more than 2000 devices in the tree.  Clearly, we don't want 2000 device
> state queries.  Not even 100.  Could we have more generic means instead?
>
> We could use QOM (read-only) properties to expose device state.
>
> If we use one QOM property per "thing", examining device state becomes
> quite tedious.  Also, you'd have to stop the guest to get a consistent
> view, and adding lots of QOM properties bloats the code.
>
> If we use a single, object-valued property for the entire state, we get
> to define the objects in QAPI.  Differently tedious, and bloats the
> generated code.

We already have a machine readable mandatory-for-every-device
representation of its entire state -- it's the vmstate struct.
Admittedly this is sometimes a bit different from the guest-facing
view of a device and we don't machine-record the field names...

-- PMM

