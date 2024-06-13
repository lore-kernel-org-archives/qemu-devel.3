Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9E8C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHllb-0000m4-O1; Thu, 13 Jun 2024 10:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHllZ-0000lP-O6
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:49:29 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sHllX-00010M-PF
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:49:29 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso1464695a12.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2024 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718290165; x=1718894965; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sqDd/ylhWJ1mZhn0aFbjD7il1pa/CyXKld45K8xjOk0=;
 b=toTlpi2Nim8PffvIG3jS17h1Tx3VqZ8+u0fWdKVDYGYLkV31uCgiSCKgUs87+nWRfC
 21xvDYuWqHixAfbR5bGahMTJH1eFseLex7fThNM8kxXVWd+IDnCd4iwnimWL9Zq8EnhE
 ep44yLTUKfH5+xWPnPnxRKIlVRkpm+H+aoe2IlIzodJ8u2bf5n65VRXtTA/cd8YdlkBI
 lr99xYPtSb4IRMBXxdIp1YQMB9nb275O1mI/ypWC8ncEdCN0nfepKPBta6sFC/5mHTln
 KTM3IR87CJe3mA4rKcmOpYKb5Y+jubKkZ+Af/fGX8x6xtYhsxazanF+Jf1ecK7tDWQvF
 GOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718290165; x=1718894965;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqDd/ylhWJ1mZhn0aFbjD7il1pa/CyXKld45K8xjOk0=;
 b=XpUKz/EqEwZBUvIqgznek6yDpDZ0MQjuicRbeS9B5xd4ktnW+ddU3WNSAm5/f59rl4
 1Em0PfckgSpo5MOzA14EWex4EOesOClb7KnFMuxKYtm3op4Ra2ZTWk2TFv9Bv0OuYpy6
 YrZuYS4yQ3fLsJGCz5Fk8AhGjD/TNdtOHgDKH48GBHoPMddyHe3n2H4m/yeRq7SFchIl
 bK2UQL53jpS+VNn7++Pj76UYun8jkVw+mUW0/IcLMAygGaHzCi7b6O4DGVJqcx0dgZR8
 SIVAR5N5fx11tLOHAQ7wDcYYS7voHFrureIiPn+B7CgRlCXWbdiZrNY7NdoLU1uWxlCA
 VAtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlUnYO938tFa2vRzO3kzuA4b97emZq/yvMRXxep1m5AJ+XiLJpF2tVdQOwTnQZCStrcXIFqrRQYIx2Zda5K8QSdf40My8=
X-Gm-Message-State: AOJu0YzgcAmqVO0MRxCgJUKYPUOLw9MdWU2k3NraALG45bmat8Ufvu+k
 Bxz6cAkYdGNC0DMi5Z7gjkXyPWJ5ZQ/tqw5SO18XIqBbvA8tUnoqAwWjgRYBXUM=
X-Google-Smtp-Source: AGHT+IEUceb5BuKD6SZA+yXGRwhHldu4GK41E2fWu0yd+ej0pWKB9NKhJuz9iWXlQ5JkN7iGYabYPw==
X-Received: by 2002:a17:906:1446:b0:a6f:1111:bd8 with SMTP id
 a640c23a62f3a-a6f47fb0cb9mr334074866b.46.1718290164656; 
 Thu, 13 Jun 2024 07:49:24 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56db62e5sm79514166b.84.2024.06.13.07.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 07:49:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CAF1E5F7A1;
 Thu, 13 Jun 2024 15:49:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  qemu-devel@nongnu.org,  Paolo Bonzini
 <pbonzini@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v3 2/4] usb/hub: mark as deprecated
In-Reply-To: <ZmrOgxutj7ETndGM@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 13 Jun 2024 11:48:35 +0100")
References: <20240606143010.1318226-1-kraxel@redhat.com>
 <20240606143010.1318226-3-kraxel@redhat.com>
 <ZmHKotWS7ywfIvOj@redhat.com> <87r0d2w431.fsf@draig.linaro.org>
 <87o785b5vn.fsf@pond.sub.org> <ZmqvJIekaW9jWP6F@redhat.com>
 <87y1799lg8.fsf@pond.sub.org> <ZmrOgxutj7ETndGM@redhat.com>
Date: Thu, 13 Jun 2024 15:49:23 +0100
Message-ID: <8734pgx5ho.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Jun 13, 2024 at 12:38:31PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > On Thu, Jun 13, 2024 at 10:31:56AM +0200, Markus Armbruster wrote:
>> >> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>> >>=20
>> >> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>> >> >
>> >> >> On Thu, Jun 06, 2024 at 04:30:08PM +0200, Gerd Hoffmann wrote:
>> >> >>> The hub supports only USB 1.1.  When running out of usb ports it =
is in
>> >> >>> almost all cases the much better choice to add another usb host a=
dapter
>> >> >>> (or increase the number of root ports when using xhci) instead of=
 using
>> >> >>> the usb hub.
>> >> >>
>> >> >> Is that actually a strong enough reason to delete this device thou=
gh ?
>> >> >> This reads like its merely something we don't expect to be commonly
>> >> >> used, rather than something we would actively want to delete.
>> >> >
>> >> > This does seem quite aggressive because there may be cases when use=
rs
>> >> > explicitly want to use old devices. Maybe there is need for a third
>> >> > state (better_alternatives?) so we can steer users away from old co=
mmand
>> >> > lines they may have picked up from the web to the modern alternativ=
e?
>> >>=20
>> >> What exactly do we mean when we call something deprecated?
>> >>=20
>> >> For me, it means "you should not normally use this".
>> >>=20
>> >> Important special case: "because we intend to remove it."
>> >
>> > That's not the special case, it is the regular case - the documented
>> > meaning of 'deprecated' in QEMU. When we deprecate something, it is
>> > a warning that we intend to delete it in 2 releases time.
>>=20
>> It's the regular case in QEMU today because we made it so there, by
>> electing to limit deprecation to "because we intend to remove it."
>
> Fair point, but assigning additional meanings to the existing 'deprecatio=
n'
> concept will undermine the value QEMU & its consumers obtain from current
> usage.
>
> Consumers know if they see the "deprecated" marker, it has started a clock
> ticking and they must immediately plan work to stop using the feature.
>
> QEMU maintainers know if they see the 'deprecated' marker and it has been
> 2 releases, then we can delete it.
>
> I don't want to loose that clear & easily understood meaning, by overload=
ing
> "deprecated" for scenarios like "it is sometimes better to use a different
> device instead of this one, depending on factors X, Y & Z".

I agree we shouldn't overload the meaning if deprecated.

So to this case in point. Is there anything you can do with usb/hub that
you can't do with the newer xhci based one? Is it backward compatible
enough that an old kernel would work? Or are we talking really old
kernels at this point?

Is there non-PC hardware that utilises these hubs?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

