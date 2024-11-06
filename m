Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 685DCD59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kIg-0006WO-7n; Wed, 06 Nov 2024 12:58:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kIf-0006WE-92
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:58:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kId-0003XJ-8C
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:58:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730915912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O67FXmxmYH+UCcWmps1ObhDEsB+dHhJvPy6m3Oo8GvA=;
 b=TOQldtbeK5bzGlEwq0cL2+WSiPMsk0rCN72Z3ZsrRzzjjVUxMqrkmO6caR0k4QFzgIYcRS
 WLdwWx4RKVfYDEmzd+s/f9Jd0DgE/RTimeV+KKqB7o+QfP6P+kd4ZTq2JbVKkZ4aIj7qtf
 xBLpPg20CVSvQB+/sDEB1ZShhDrgbBk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-TO5t2_CnOTShgRMlIwoaIA-1; Wed, 06 Nov 2024 12:58:31 -0500
X-MC-Unique: TO5t2_CnOTShgRMlIwoaIA-1
X-Mimecast-MFC-AGG-ID: TO5t2_CnOTShgRMlIwoaIA
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315a0f25afso437195e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:58:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730915909; x=1731520709;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O67FXmxmYH+UCcWmps1ObhDEsB+dHhJvPy6m3Oo8GvA=;
 b=F3yQEo/EUDLa4LfowkOsPICNcnhJggLjvZbF2a+6iiwq+pbb1nqNu8AHwEREgQFtT1
 5nkxfwupf4qQZvQUPwdYGRpAU8mNlWTFiBEA/E0bZImnSQ/ZBRYjHdDV1kMCVew2GABU
 3E4ry/oLdV+/ZNYjTr0LH5TprN7BjiN9Xg0lKO2OH0QoXPUd2j4UCzxS9STIJPVvnBSs
 wQ0+XDo+EfS5ETbp/Y8mPPvXZ3VHHHy0v1IwqzAXXlxrutuncsSVkLbBRjVX16n1pzDR
 cfY6jOVxsF7lB4Lv0BBS8rSg2FSI6hiwW9LCdEjSjllG8PnC1bxajUplTMOddtP7EFCA
 t5QQ==
X-Gm-Message-State: AOJu0Yy6PvnYU49dujmJB6AcSqLqf3ZNxoh6KmDT49AenxNDs+ECLoH9
 vCqeG4cJB0nI+w6BSGshESbJhAb4QixeFEc+fSLsQ7BjffLp6zYPtsR3jOGr+NUb7HKw6hx0jbJ
 dF3IB/VoG0oq/RZMwvEbd+9CpgIlTBkQb1KOKdd8BABo9UE1d5NhvFAb+lxqEq3aEsFzoCgl4Ji
 0mwIIBCGXea1FO7649BO6HRyziDhpSrJRrn8kpEVCx
X-Received: by 2002:adf:ff86:0:b0:37d:4818:f8b1 with SMTP id
 ffacd0b85a97d-380611e493bmr27425319f8f.39.1730915909180; 
 Wed, 06 Nov 2024 09:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFTx0drl99yuPDyS20oiP0UywQNudwq3js/omdcjnX27MdWBz8P08yPrI9gdiRGDeN8J4SoMprnpB1M2yTFm3A=
X-Received: by 2002:adf:ff86:0:b0:37d:4818:f8b1 with SMTP id
 ffacd0b85a97d-380611e493bmr27425305f8f.39.1730915908809; Wed, 06 Nov 2024
 09:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20241106174241.556373-1-pbonzini@redhat.com>
 <04fd0b86-4371-494e-a331-3d5d735f0d77@linaro.org>
 <CABgObfajkp+5vFnQuV+V6Mp+LuP_Yo-=JtZtGUcYB_GDDbWoJQ@mail.gmail.com>
 <b463bc8a-4625-43e6-a9da-4df526aa89a3@linaro.org>
In-Reply-To: <b463bc8a-4625-43e6-a9da-4df526aa89a3@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Nov 2024 18:58:16 +0100
Message-ID: <CABgObfZvO3txRMAwjMny73k3pyfNy_SZ=oeoAwM1hm6b9zot8Q@mail.gmail.com>
Subject: Re: [PATCH] eif: cope with huge section offsets
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, dorjoychy111@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 6, 2024 at 6:54=E2=80=AFPM Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> On 11/6/24 09:49, Paolo Bonzini wrote:
> > On Wed, Nov 6, 2024 at 6:47=E2=80=AFPM Pierrick Bouvier
> > <pierrick.bouvier@linaro.org> wrote:
> >
> >>>        for (int i =3D 0; i < MAX_SECTIONS; ++i) {
> >>>            header->section_offsets[i] =3D be64_to_cpu(header->section=
_offsets[i]);
> >>> +        if (header->section_offsets[i] > OFF_MAX) {
> >>
> >> Maybe we could add a comment that sections_offsets is unsigned, as it
> >> can be confusing to read value > INT_MAX without more context.
> >
> > It does sound like OFF_MAX is related to section_offsets[], but it's
> > actually related to off_t.  So the comparison is with the maximum
> > value of off_t, which is signed.
> >
> > The problem would happen even if section_offsets[] was signed (for
> > example off_t could be 32-bit).
>
> I'm a bit confused.
> It works because section_offsets[i] is unsigned. If it was signed, and
> sizeof(off_t) is 8, we can never satisfy "(int64) > INT64_MAX".

The fact that you cannot satisfy "int64 > INT64_MAX" just means that
on this system that erroneous condition is unreachable, but it could
be reachable on others. (Actually the fact that section_offsets[] is
unsigned does matter, because otherwise you'd nede a check against 0
as well. But it doesn't matter for the correctness of *this* check
against OFF_MAX).

Paolo


