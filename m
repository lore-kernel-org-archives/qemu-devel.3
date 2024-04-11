Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F814CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 12:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rut5e-000835-AU; Thu, 11 Apr 2024 07:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rut5c-00081w-KF
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:59:36 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rut5a-0002cq-6t
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:59:36 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-56e1baf0380so8974327a12.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 04:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712836772; x=1713441572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/d6rzWM3RKzS8a1pTpO5jIX42wetHh6wJ1iYR9ZIqe8=;
 b=ANpSno27vPzS4KGbFq7ocX4xkBopmfzZhtRiZ2gWg3WEHD6/E/7ie+imS84agLcdei
 HStwe9IcyzFiu6R2kTF5adgyOncq3tunflAYcF6ycCiocJKJcdLKjhsYloZUpMT1/1um
 XgC45pyjuJ/zYCR9RXzGg0Kg6C58XfwnQ9C7yQEZiengW9l9yxqvB67eS3gwelVvJJt+
 I91J+8N1rF3y7FL0nfBy8hGKLinkvoSUIjRJfjKr84GXf2XJv1yO34/FanWkfSXkATg7
 q7OWMk3flJSp+vPYAcyqxBZmEPUZQ4PqJTTz5/CE5CupaPhgLHdW0b5FmlotAxrOzhF+
 xt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712836772; x=1713441572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/d6rzWM3RKzS8a1pTpO5jIX42wetHh6wJ1iYR9ZIqe8=;
 b=noPXohssFCBo7XhBV2EBT9Ei+suL5KbIe2Rlh5cuIFINN5aVZpwUmKXLQtXmEjVXVa
 ogDLD7McmQ0MppeDL9Xamx02xz8ru848x02CcnWc51WyRWkeKxl9ZaBzkEUw76vFMdTY
 ZX8FnjxmXNqLIwnHL+IATM1mUbeILrxT9gwyDqb4d1diohmSeetj4O6rOpCR+dNF8pZN
 gv6gRhNSJHxjWkcXHdMLU/MP6n9dn6AlxoP3ljhwZEdN83owJgdOZGnlvLp833p4WDeZ
 oljM3zjk/VSgL7rUiGpY4pliNNZaz7W3b/UID1Ue/7R6bNXL8tNWz4g6Mdaia0TCxYzw
 RzMA==
X-Gm-Message-State: AOJu0YyRH8J2GAhd3SRQQO0Z23R1CgRdsp7ZRbnMz3qdYrM9vfhpA2Ae
 ovS9EiRQrDrQpcILqMJ3EMDbkwwhLWR54AVJoYoSRI0VkTL54XWhZX2mHb+h0IyVPdTdS2ETsf1
 K+jMjugcV6Q4z8TnLQRYP4gkgu70rDKYPUcCamA==
X-Google-Smtp-Source: AGHT+IEZBE9CL57fOOXD8ugzG94aVuACdJqyvRZTMYuJSwpOa7Bv87fyLUCo3wLcrD4iUaiGj7OvJ3yAGelTW7TO9iQ=
X-Received: by 2002:a50:a45b:0:b0:56f:daae:7cc1 with SMTP id
 v27-20020a50a45b000000b0056fdaae7cc1mr2385706edb.23.1712836772124; Thu, 11
 Apr 2024 04:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-10-philmd@linaro.org>
In-Reply-To: <20240411104340.6617-10-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 12:59:20 +0100
Message-ID: <CAFEAcA_XHVWAiMZ8iw3xVVjnHs+aoxQB=uUjBQy7EGmSj14U+Q@mail.gmail.com>
Subject: Re: [PATCH 9/9] target/i386: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 11 Apr 2024 at 11:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/i386/kvm/kvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index e68cbe9293..a46d1426bf 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5335,7 +5335,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_r=
un *run)
>      case KVM_EXIT_NOTIFY:
>          ctx_invalid =3D !!(run->notify.flags & KVM_NOTIFY_CONTEXT_INVALI=
D);
>          state =3D KVM_STATE(current_accel());
> -        sprintf(str, "Encounter a notify exit with %svalid context in"
> +        snprintf(str, sizeof(str),
> +                     "Encounter a notify exit with %svalid context in"
>                       " guest. There can be possible misbehaves in guest.=
"
>                       " Please have a look.", ctx_invalid ? "in" : "");
>          if (ctx_invalid ||
> --

This is a case where I think we would be better off with
g_strdup_printf():

 * the buffer declaration is a long way away from its use
 * the string is long and it's not trivial to confirm that
   it will fit in the buffer
 * it's quite plausible somebody will come along later to
   clean up the wording of the error message and not notice
   they need to enlarge the buffer
 * it's only for printing a warning, so it's not going to
   be in a hot codepath

thanks
-- PMM

