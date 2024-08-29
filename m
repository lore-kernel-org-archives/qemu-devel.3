Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81277C83F2D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 15:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjhQ9-0006TX-W8; Thu, 29 Aug 2024 11:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjhQ5-0006Rn-Bc
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:50:46 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjhQ3-0002OL-Kw
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 11:50:45 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a866d3ae692so50443366b.0
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724946640; x=1725551440; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sDzdYnFnLpA5ZwUifCBHYZokw3Cn95gQWDGm5vrk9vk=;
 b=TB9mk4cSY1JDZ/3ta1GIL4Jx6+ZrssTEhF3O2Qnz4z4/Q+iyn87NbFsVF2kiGm61cj
 0MxAG72edSzIJoaJiF2iLo8CshGGFJLpC4hXKhTHd9OfCwsAtWdnPzWuWSdXMynUC1hW
 RRDHn7xJxwMLC82dG1vXueqGbBiiixt+8GzFwtYYTLlV6I6YbxfhFpJyXDrenwzyuJ+4
 nm9wflhbutE0HccGCwdDE3hWHh4BlVGvdB6Nz63Mf3ZtScbJlHwiPXNJpspdRwIh00xb
 gkgiZAHmE3nViu7mNQ+87s+gpxhBaL5YYWWvfwHLPHPkHexnIv+93bRlObZbsDJKJ1ni
 eMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724946640; x=1725551440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sDzdYnFnLpA5ZwUifCBHYZokw3Cn95gQWDGm5vrk9vk=;
 b=gfhIGgcMv3Q202oqI6WsHN2qSHAFRTxGio5OBYKT3MbwNjjUCy+TbGm/jLjbO2IzrX
 b+PZWKeBYfq13YygKZM9LmfekyZuxpLBpxGiElGDYZOtIn4ADAvbvp8SUhi+jFAJCAEr
 0S6X6KZljuHEvJS7SN+Ge6qWSLahyVvkFGqK98D6xJyBO8vVQEZeFTWE4XmK82HmsaEz
 099LE+g4zw+9Zsxw78rg65vTCu//XhRw1xaS7v5b3usnaHL3IZ47bodhlkLPbefbnYRg
 fDC2AYqESBxrGRLz7Anp+P73U1LdzmtBsgWDvQVUr0Yw1NGBmoFyZd5E0DC8heSM9WZw
 zj5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLoB//X3IYGGM1NflL3wZ6lfHvdre5AZccGF9gqcXwsgw2Fz8Dx6tF65XQmpDUuttmsQ/fy3RPtSha@nongnu.org
X-Gm-Message-State: AOJu0YwQaVv9KrAcHTGy9qj3wZmmwq//jF3IoOFQlKfOS4TSNnpeHmLm
 Kc+vvJTchsLi8TI3w2b12s94ZEbhvMLyWesVDC+n4+fIHUa+Sn1vppj/PIJB2zGlZfqlzDDn9DU
 h+NCwn/GR6pNXfUlhS17TpToeKYgGOfjpU87IiQ==
X-Google-Smtp-Source: AGHT+IEpgiCdMuYtCNR81ph47XSGNak7jXRVQU/Rm9vT0wcQDh8UCTrodbS9lMQTOgskN/1gtX6mV1a0rdROZEadVow=
X-Received: by 2002:a05:6402:2554:b0:5c0:ad36:284e with SMTP id
 4fb4d7f45d1cf-5c21ed3e9admr4006267a12.12.1724946640253; Thu, 29 Aug 2024
 08:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240813153922.311788-1-jmarcin@redhat.com>
 <20240813153922.311788-3-jmarcin@redhat.com>
 <CAFEAcA9BWOkSmNh_b7HcNgfD429L1iLrjYTHWBJKDP2dJYCjCA@mail.gmail.com>
 <CAC2qdxAfvKubvO7fs4KF8dy_+Ad5kbAaxyn2P0FCDL-zkhEiMw@mail.gmail.com>
 <6ab58af7-3584-40b5-b56c-45544a06c7af@redhat.com>
 <CAFEAcA-NogX_8Phq_7YZuL1eGKeHbnowPzQoTo3P+8Sur=Xbsw@mail.gmail.com>
 <CAC2qdxCJ3=OzAsnM-paMUmvGAMau2Mc_OxNjxpP3T-F=69Boaw@mail.gmail.com>
 <fe5dbb5b-d744-476b-a574-65c5860faf28@redhat.com>
In-Reply-To: <fe5dbb5b-d744-476b-a574-65c5860faf28@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 16:50:28 +0100
Message-ID: <CAFEAcA-uaOttk5wVPYDy-EKo2X4kxjHsq8D-Hm43nSt5jtFDGA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] reset: Add RESET_TYPE_WAKEUP
To: David Hildenbrand <david@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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

On Thu, 29 Aug 2024 at 16:48, David Hildenbrand <david@redhat.com> wrote:
>
> > I have rewritten the documentation section to make it more explicit
> > that the reset might not happen. I would appreciate feedback if some
> > part still needs some care or if it is clear now.
> >
> >    If the machine supports waking up from a suspended state and needs to
> >    reset its devices during wake-up (from ``MachineClass::wakeup()``
> >    method), this reset type should be used for such a request. Devices
> >    can utilize this reset type to differentiate the reset requested
> >    during machine wake-up from other reset requests. For example, a
> >    virtio-mem device must not unplug its memory blocks during wake-up as
> >    the contents of the guest RAM would get lost. However, this reset type
> >    should not be used for wake-up detection, as not every machine type
> >    issues a device reset request during wake-up.
>
> Sounds good to me.
>
> I'd probably generalize the virtio-mem bit to:
>
> "For example, RAM content must not be lost during wake-up, and memory
> devices like virtio-mem that provide additional RAM must not reset such
> state during wake-ups, but might do so during cold resets."
>
>
> @Peter, WDYT?

Yep, seems good to me: I think it's clear about when this
reset type happens and what you can/can't expect from it.

Minor grammar nit: should be
"from the ``MachineClass::wakeup()`` method".

-- PMM

