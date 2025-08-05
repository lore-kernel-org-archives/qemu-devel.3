Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B108CC87FD2
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Aug 2025 12:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujGSr-0001hT-CO; Tue, 05 Aug 2025 08:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujGSV-0001bZ-Cv
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:08:01 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1ujGSS-0007E0-RO
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 08:07:58 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b3bcb168fd5so3227373a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754395675; x=1755000475; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0wniIyzgJ27cu7M7D7esFChbKDVye9YIhpG3W3bOmno=;
 b=LE+S79OUB2IemgM5bxF8T9l86JKYqI7wRb6gOIjsB5i9tGbmnaN286ysvSiK0RDGia
 hgewyVaJqk0/tWf54ayKfMqYtY1u0wNVFsqnXV1immOrMguX/z2mNUibgwDFSdscuJKz
 2wxuWd5quiTqw1lZ2dKegcZHR9jf6Ev4EJ1HRAziWF/JIUj1CUpdga9euYHc6rW3/Xzr
 PtWCXnDn+EHhnfjCvGhaUCRqGrQcLUXX6QBQAEYMS+68kT6epIAvkGeZu9Qxqe8ipwTY
 iKMC1es9oenzHnmi/WlaNAo9PUr4jOHsVTYctqrLiZP0pURsAnxmjuHpPaG5Thaq1Gbg
 7IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754395675; x=1755000475;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0wniIyzgJ27cu7M7D7esFChbKDVye9YIhpG3W3bOmno=;
 b=McF/PIIrLWnWfFqsfaRbuFqc9RGBXXdcrZsnbcFFZbFYXYf1r8z95Y5xpIUxd/0L7t
 r681AXHLPTrT9GKynHyqRKSFGe7HF59sl4bEIO+ynqBG4gycs895qbuszhWo+qd5QL3j
 w5atsfv3mMQUxBsX/R1k1i9iyvnjGtLIbzMPQhRz9XAM1g6fFUD0+IP0Rlrr8k96q7h2
 +lgmrhup3pxHa9iYN0ILzN4hwSaI+cJKVI1rZC6aUFKF/aq+LRYznmrjx5eQ623au4DY
 eiL2pxOhhVXjHKWfe4hD4JFRiXOl3unTfR9d+6dMMXwubJRrk36Ftid0b7AIIgVZEidn
 +CZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvBzVxZE1Na+0Q6efv5xlwxuipdDOSIvR+Wy3xa3AWgCILvqO0zvuu83MfjE52uS++Dzc2E3CgRGSs@nongnu.org
X-Gm-Message-State: AOJu0YxkfBd6iljyjgcNF6NHnC/QE0yx9NcXO21SdeSWq7gB2ZZ6YzdO
 kHm7Ieu1jwtXl4GJSNr2YUA9qgteKqjeJDYRtomq10YbV9I/kYqR0lsZVbNFVACMfo3qcUq3iyp
 EG6ZPT5+0CvezZrgg9Bkwnzo1H6j1JJY=
X-Gm-Gg: ASbGnctjqXI6ljgSY1NL13sPYs+yuvXAiJ+IRblhdgJroOb8xsFn9g/1Tkw0AxiYZOg
 LUjqpstnLy9RtScNVkAc9Qmr+wRZisWG89KqnauaioiVUKaN4TGBV/cFAWcFAwbrDYbAGuTjq57
 OwaRxO8iWcxwLjAGFZ96TVXETQ/6Sm+dkOsDPsIbELAs0mbsuPzLW2ZM1cCiydgaFilNWc/N7FB
 4MI41YfdsX2B46veYzkiECGtoSyDZIFI7zhrTxTgjf4Q4QO
X-Google-Smtp-Source: AGHT+IG0NQEXU7whWbSQEFu+oWH1KAWBUkdEpiX1tKvGUnKsd8b/BZwpPmB7dkXUsX9Ax4H5mKzKGeHnngeYVSNEbLs=
X-Received: by 2002:a17:90b:3ec2:b0:311:ff02:3fcc with SMTP id
 98e67ed59e1d1-32116210418mr19762176a91.14.1754395674878; Tue, 05 Aug 2025
 05:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1754310749.git.ktokunaga.mail@gmail.com>
 <9e9d4d6e10a2eaaca2d741184ba292d699ddff7b.1754310749.git.ktokunaga.mail@gmail.com>
 <f8218125-7848-48ce-a822-7f64594695dd@linaro.org>
In-Reply-To: <f8218125-7848-48ce-a822-7f64594695dd@linaro.org>
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
Date: Tue, 5 Aug 2025 21:07:43 +0900
X-Gm-Features: Ac12FXyEJ55x3U4LkqWl9-JiaW-DSSZ7C6u9zKGcuolmbqmftJUgzAHNaiAOysU
Message-ID: <CAEDrbUY8EKGaWzs=94GoHfMG-2h8FGTBo2E1hSAnzrSrA2CGnw@mail.gmail.com>
Subject: Re: [PATCH 2/4] configure: Enable to propagate -sMEMORY64 flag to
 Emscripten
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ff290b063b9d1216"
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000ff290b063b9d1216
Content-Type: text/plain; charset="UTF-8"

Hi Pierrick, thanks for the feedback.

> It could be worth adding the link to documentation in commit description
> directly in configure also.
> As well, the --wasm64-memory64 option help could explain that in a few
> words.

I'll add the explanation in the configure script in the next version of this
patch series.

Regards,
Kohei

--000000000000ff290b063b9d1216
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Pierrick, thanks for the feedback.<br>=
<br>&gt; It could be worth adding the link to documentation in commit descr=
iption<br>&gt; directly in configure also.<br>&gt; As well, the --wasm64-me=
mory64 option help could explain that in a few<br>&gt; words.<br><br>I&#39;=
ll add the explanation in the configure script in the next version of this<=
br>patch series.<br><br>Regards,<br>Kohei</div></div>

--000000000000ff290b063b9d1216--

