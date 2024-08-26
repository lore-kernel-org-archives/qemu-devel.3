Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81A0C5472D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 17:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sidFt-0006Ew-Rb; Mon, 26 Aug 2024 13:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sidFp-0005yK-Gv
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:11:45 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sidFn-0007VD-TF
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 13:11:45 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2f3f163e379so71917581fa.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724692302; x=1725297102; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15zHlHD1ZE8F8Zfhv0oMnWYoyq4SSsREyBJUdY8vJ1M=;
 b=GeaJckRkX0AdcCss/C9v2IG70Ko+TRncPSxzMLbzCYkFoqBh5mf1ddzJBpZsGnvP5N
 rCOGyMeyrQs6HCHXaCFo8nDdHwzflxIQTtfK22bDTOtF9gPLwUiUz/TgtLEwks8Zl16J
 25SNCoBqr/aB7ykAJS9hYVLW2bgdLpwi8JfiUYQa5vKN/y5EV+pNMs3jz92ydO+lxWnm
 wV9nwWTTwEvfD04hwkW//ql5E+Z6VaYsCDdciO7g0cFWRwtygYNGztlV9LkrCCvvqFC2
 RJTwVqIRdP/6HDYA36jNkV2atEvVu02oqjcp4FqKi2WIIqq2RKbMWBYSDF2C/47uYJ/J
 6iEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724692302; x=1725297102;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15zHlHD1ZE8F8Zfhv0oMnWYoyq4SSsREyBJUdY8vJ1M=;
 b=XhLUBR7JSmCfsOQnPOFtTSBKLb8XOat4zpUttjFFZ3lejB4aBvEqwK/JerY66+lGYk
 CS85My1ihFn1a1uEqD7ZrmSlhdP76L5J3LNErgmU6NyIm7iFmFx7EPDViBQcfff3G8uR
 28M1bVR4o5HYG+vwSlfwD6pocp5od49GdaLoV/Q6+T4p6+A4jxPTZyRVRRRn3+Ut3D5+
 GD+yfvonkXYELW0P3IA3zgvHGwa4oDTnjD4w88+iFE6FXaLNgiVLudbhGwhSOn7lD3h8
 oG+PDqt08zkJ8ZQxp9znQVJ1iksW3AFcZDk8BfhLCx1QvAALI08Wi2Yr/OEddVHR33kF
 dNPw==
X-Gm-Message-State: AOJu0YxpAgdHmq5fPzQK0ZlY1ODdoa1lMxHNCSSgFvoXFJVlHk8J9fCq
 bMyGu4O0BQGTyg/Wonaks+w1nATXkk6CoFfoYe3nd0oo6EGKFSVzesc9axjxF1mU9ceoI1de+nb
 8jV/Y+W9EQ1cMxNc8SotjvVFxqGEji3rcPXKYxg==
X-Google-Smtp-Source: AGHT+IHTDZG4ArusZ5ja31Ry8eEUMOmAuCVlCpjnwSeDdHGtLfM74iOFhhaCe09/xw94O3W4g0Lk0l6wmaiTNHPBHxM=
X-Received: by 2002:a05:651c:211b:b0:2f3:cb70:d447 with SMTP id
 38308e7fff4ca-2f4f579e82dmr97842821fa.40.1724692301812; Mon, 26 Aug 2024
 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240813165250.2717650-1-peter.maydell@linaro.org>
 <20240813165250.2717650-2-peter.maydell@linaro.org>
 <155a9629-634a-4b69-a332-873b7af8b9fb@linaro.org>
In-Reply-To: <155a9629-634a-4b69-a332-873b7af8b9fb@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Aug 2024 18:11:30 +0100
Message-ID: <CAFEAcA-GwPjR9pQNcZgJCMaa0GeNG0Wc6AyqJtpERvRqOJ2iRw@mail.gmail.com>
Subject: Re: [PATCH for-9.2 01/10] hw/s390/virtio-ccw: Convert to three-phase
 reset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Mon, 26 Aug 2024 at 17:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Peter,
>
> On 13/8/24 18:52, Peter Maydell wrote:
> > Convert the virtio-ccw code to three-phase reset.  This allows us to
> > remove a call to device_class_set_parent_reset(), replacing it with
> > the three-phase equivalent resettable_class_set_parent_phases().
> > Removing all the device_class_set_parent_reset() uses will allow us
> > to remove some of the glue code that interworks between three-phase
> > and legacy reset.
> >
> > This is a simple conversion, with no behavioural changes.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> > It looks a little odd that we do the this-class reset first
> > and then chain up to the parent's reset, but that's what the
> > existing code does, so I left it alone.
>
> Do you plan to post a follow up patch inverting the
> call order? Otherwise, could you add a comment in the
> code so we don't forget about this odd case?

I didn't plan to do either because I don't know whether
the s390 code relies on this or not and I don't want
to investigate either... If somebody on the s390 side
is interested in tracking that down they're welcome to :-)

-- PMM

