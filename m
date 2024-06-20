Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC145C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 15:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKJR0-0000so-Fd; Thu, 20 Jun 2024 11:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJQp-0000oR-VJ
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:10:38 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKJQo-0005se-Bl
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 11:10:35 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6f13dddf7eso123798366b.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718896231; x=1719501031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GgQkLGFJAR6iua8CeDRfrSn52bPRLoZC1No0uNPWlQE=;
 b=SFByfYyrjdSFX5OygQ72g+XUtLfN+YQ91fktnzw5iYbyWqZnTYPmAWwNzwGJ+Fiba4
 gDSRgawJEAe/8ECQOc5WUN6VQsucsogGMxI8egzANKLr4AkheaA5pRAkZwmBaVB1Z8Ca
 2D9Wsn5ZHuanRi6EWAIBcKCON/jdBKNGmEbWKu7gAR3W3bSFiz+dgh4LlkLJ3kF0oN+D
 xXKXXcekIxp3wz8fjtZ6pWrjI8atSWyqynauyJOEjH08Hb8nDAC4VeD93vtF1KugJq+Y
 NBm28a7rX7DIyZaqF9UAL8PM3dlj7R0Zfh6rdWDWw0WlxCUM8tG//Zq0wh1EZdaWRXK+
 KcZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718896231; x=1719501031;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgQkLGFJAR6iua8CeDRfrSn52bPRLoZC1No0uNPWlQE=;
 b=rE76njEZ0kjXpDDdniKQAbpDDavEGlClAo5ckTWj+mCK/TFsI3NEzq40QphiP4zlCN
 WvDcBJeujRgV1E6XzxljSAotmz5hJSgSYsric1wDxD2hv7vLORb1OvsBrD/fu/q+z5k5
 hn6pfpwZX+u6tSKZXL4UytG2WPJqIgmyQnMu+CaC4SGDN8aEdrjOqf41sewwzHJvWOYg
 accnq2QlEqy6vfOrDH93FX7WHnnr+Rnnlui4BFxqjXO5f1eMJrLdiadcOIE6ElURnaoR
 O2r9zs66Bl0lEei7Am6HqeIEphnqEwLH5KiNJAfBieit7YH8XKJF2DMHLwuk+36nwGbA
 8nWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlgSxBESzyWKFGBfEIfjYHfY54mHU3HwO2jbCG9GhtIFNYzygKNZeOCqkV5ux7fF36Ce5yS69lN4lP+i0k8xKyEdX6g7U=
X-Gm-Message-State: AOJu0YxDFDc88dl6qf96xBTzafUN1WUGXGdKgRfuDSAVblFVTkAcThGq
 ESLgRMdvyBc5ZGONfemE9/TapXQX8HWPGko/pObUeYjEDEuArVw53WbYNTyqptE=
X-Google-Smtp-Source: AGHT+IFKpVjYsxTSvOEePgXeaDGdKN6Dn22Hj2+GiZGxz9tfEI6ew+tJvY4faqJtN5a22mLz3Wy6Kg==
X-Received: by 2002:a17:906:3cb:b0:a6f:61c7:deaa with SMTP id
 a640c23a62f3a-a6fab615bcdmr348972966b.17.1718896230852; 
 Thu, 20 Jun 2024 08:10:30 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd2daasm779348366b.97.2024.06.20.08.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 08:10:27 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AD8255F7B1;
 Thu, 20 Jun 2024 16:10:26 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Roman Kiryanov
 <rkir@google.com>,  qemu-devel@nongnu.org,  jansene@google.com,
 mett@google.com,  jpcottin@google.com
Subject: Re: [PATCH 3/3] exec: use char* for pointer arithmetic
In-Reply-To: <ZnKRLj3usYxmAIOE@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 19 Jun 2024 09:05:02 +0100")
References: <20240618224604.879275-1-rkir@google.com>
 <495d3ddc-ce73-4ef5-badd-16ed61f9a5aa@linaro.org>
 <ZnKRLj3usYxmAIOE@redhat.com>
Date: Thu, 20 Jun 2024 16:10:26 +0100
Message-ID: <87le2zbqfx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x634.google.com
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

> On Tue, Jun 18, 2024 at 04:05:36PM -0700, Richard Henderson wrote:
>> On 6/18/24 15:46, Roman Kiryanov wrote:
>> > @@ -2839,7 +2839,7 @@ static inline uint8_t address_space_ldub_cached(=
MemoryRegionCache *cache,
>> >   {
>> >       assert(addr < cache->len);
>> >       if (likely(cache->ptr)) {
>> > -        return ldub_p(cache->ptr + addr);
>> > +        return ldub_p((char*)cache->ptr + addr);
>>=20
>> We require "char *" with a space.
>>=20
>> With all of those fixed,
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>=20
>> PS: I'm annoyed that standards never adopted arithmetic on void *.
>
> NB, QEMU is explicitly *NOT* targetting the C standard, we are
> targetting the C dialect supported by GCC and CLang only. IOW,
> if they have well defined behaviour for arithmetic on void *,
> then we are free to use it.

It looks like GNU C does support it:

  https://gcc.gnu.org/onlinedocs/gcc/Pointer-Arith.html

>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

