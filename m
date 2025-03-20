Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F30BCC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 14:02:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvGTj-00049J-7V; Thu, 20 Mar 2025 10:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvGSd-0003tG-Du
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:01:32 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvGSX-000149-0z
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 10:01:26 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e6405e4ab4dso1714199276.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742479268; x=1743084068; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PqEQQXxT580kj2WUkb/+tYfZkvr7JNYHOVUUIno+wsw=;
 b=eFvKJiTvFtB2rbsAe3dXUyX6c1HJTXKJg04IfKhFpOLsX31SraqsIm0pw1jSwD3oPt
 OTXSaSXHjZ8AznOVhIV9OBSXtQNk6HZbk/7UXureaHjINL/xeOsuFyoB2Qr0p4eZsQdB
 EdlZ3fjXVinwwCPym+AF5/Clt+k+bKXAXN3q6N8RzjZlYhPHXJDgWtHTMpKvg+P2E3UI
 +Ua0s44wib6KrGwO+gkG1J+dcTMli74U9XMJYTs7sofof8h/ddVaS2OceSogZNoDwseU
 c8MPK8fvEpANiPatzIQoOAAgbU35oD3s7rGu05Xb82IjrRbqJzk2iXePVQeeyvHgOf39
 jEEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742479268; x=1743084068;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqEQQXxT580kj2WUkb/+tYfZkvr7JNYHOVUUIno+wsw=;
 b=cbzjqFAkP2kcsuSot2Z3HDDHdM+9aNnPwU3aNAU5DNxo0BiAEnnQa71TPFBDhkvkH4
 opEzZJ3utNS5TD0hZxj+MUM6tABoUyRoTJ/mQVl02lg9weITtZjNEZbPdh/J9D/Ts5LS
 OOf0yRYqtmqp4hOZEAxB21/3TYVXH+if1kpgfPXtdFkoXOu6AK8VWZqs/PgjxyIHpy7r
 p1UOOj4zaPMTR4dh5wi5uWWwPttkY9iJevD5KK9FQ5XMOTQAyFd+IKElvrkG3gbrDig+
 0uKikeRHbSADhUf3KNV5BxQNzr+gQX1BxJetiGv4zTdPvKLkLlRdslBMLgRqW+ZIV8ET
 d2CA==
X-Gm-Message-State: AOJu0YyepnGlB0hiZU4Qa0556n0dvPm4a27CJllEaTtsr/o1FbyefT8T
 6OL8//g7NyuO2IwEV0ipDyaLAAOAF5XP6otUkAPl784Ro9hNXWwefzw7Z+UJnaDHsFKF7YBXqke
 HmC+L8ayXpny95H9MEGWJw8JDpPNqhFWa31m/qw==
X-Gm-Gg: ASbGncuq5mzx+E+gvnOIImMgrn4/5+3crjD1HKcjRmkebRMvHrbr5x1BuImW1c44vQ2
 z9JiOQ/9d9o6BjnthTJev7lMQ0tI/Ux4mm9EJMyRJ7G2FI9pvmjI3YxOCB+9OQQ+G1qGEf4wVoh
 Bxp7/0brFMg6s+IA/d1QpONIvweYU=
X-Google-Smtp-Source: AGHT+IExCFlw5PVhmWwCCWa75RC0LwfXJc8NYE2rQotzG7qe4sg6zwBRhA2p+/3PmJBdS6fDTDdgCpKtLf1JGVOCiM4=
X-Received: by 2002:a05:6902:cc7:b0:e5b:43dd:cf18 with SMTP id
 3f1490d57ef6-e6690eef5bbmr4622244276.22.1742479268174; Thu, 20 Mar 2025
 07:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250320115521.808019-1-pbonzini@redhat.com>
In-Reply-To: <20250320115521.808019-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Mar 2025 14:00:56 +0000
X-Gm-Features: AQ5f1JoE-7ObwXBph0MkWLLssCCKEPyP9fyW95YAmd1OGLTC3dI0rR8ncsuxf_w
Message-ID: <CAFEAcA-M6nbwbxc-Kp+jfRQ2-83zbb-G6sPwazhEzQsWSB+crQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: assertions: add static_assert
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2d.google.com
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

On Thu, 20 Mar 2025 at 11:55, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Add a new assertion that is similar to "const { assert!(...) }" but can be used
> outside functions and with older versions of Rust.  A similar macro is found in
> Linux, whereas the "static_assertions" crate has a const_assert macro that
> produces worse error messages.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Supersedes: <20250320113356.799412-1-pbonzini@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/assertions.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

Macro magic in Rust is somewhat beyond my current competency,
but it works for my use case, and it looks like it's doing the
same thing Linux uses, so on that basis

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

(I put this patch into the series I just sent out that fixes the
PL011 size issue.)

thanks
-- PMM

