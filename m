Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04534C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 20:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uICGU-0007oG-It; Thu, 22 May 2025 16:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uICGS-0007mB-Vv
 for qemu-devel@nongnu.org; Thu, 22 May 2025 16:11:41 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rowanbhart@gmail.com>)
 id 1uICGR-0001RS-En
 for qemu-devel@nongnu.org; Thu, 22 May 2025 16:11:40 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30e57a37294so7955342a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 13:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747944698; x=1748549498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=L/YGkXS8XTM4cPqrRDL70ok+YAsJd6sV/SJH1fTiKDM=;
 b=SzMzen207Yfmj07ZQz2kpF++DdMTpiBD3swX4Ai7q+xlOUJk03i35Pt5wJxCaLYu21
 F5yYDL2y0J37kunb3+7DcfajPwmkI8a5Sdf/UrkCyUyhZsBu6PZK3L3UCwgiFH1nvx7J
 X3IM3fHsb5Rx2/AHYM/edoIlMWlltr9AFmIL4AalcRyjNBTKOSCnMudpvCMUd55O3wWd
 QDrf4ud52I/VbHwYbv1QI+1TxwArVQ81aMI6ibFx0ardoKRB9eXjIReX+QA6uqDPJqis
 XqBweBIfaDKE8J4CQNu72ilVviVWrzfDHS5eJS+hDEsOUMEThy5b/CjTnzE1MZRFeGNU
 72cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747944698; x=1748549498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L/YGkXS8XTM4cPqrRDL70ok+YAsJd6sV/SJH1fTiKDM=;
 b=Q/xX/SZ7qwwi5cZaaQpcnDHCN5MoxNTpx8RpXXLsMToUzdVSNZviK8rZeFoP2owaJ6
 msqKPvWi97MhPHhQY+V6q/CO87TqVbpdjYf5S8JsVRLIx69kZmmLGxX92cFizNdj1tJv
 n34QBJD3JqlIB/3Yu66/4Dcz1w1d5fd+/+KhRNMe4FMMAy37ryLU17iqyIpaHxhFPisi
 iD6NCacdzbqi+J4TxBVuAn17qXTc+rdeSN/M5tAfcxGi7opKZa77UFDcru5Dy6t2ewJj
 lWbPHBpF1abJX1USc7zGrqMQiKL7k2ahheVNMaKWQ1y4/YL+d1pMuDCHeNb+mzLGtyty
 xC1A==
X-Gm-Message-State: AOJu0Yxms21Bo66pfNI9hY4CGb527RfIOi/Km5dYng5L78LSGXB1tNid
 gmOWYVyVqFiGOcMGvO4d0dZVRJM79AoTh9UCjdI60t1gAXLiUBz+uew6VqYM0RbOYPiNsWRz/Fv
 y9g5VCm17QF8ZefYfJBEPZNwKjINYE1o=
X-Gm-Gg: ASbGncvsy42lwVaTfohywilXibJ2QOhxYRzUJ/IKxApbM5AmAVcC5gefSXzHvQm90rX
 Y7ZCeBdk841cPSFsGlYtRs5Uog/Qatpjn7zOhYzM68kyNOIOCZDFpO5kz5D+hjoaU9f2ULmb9BP
 PoZGObKNayJyzaY2BP8MLiAjQQ1L2iSQ4=
X-Google-Smtp-Source: AGHT+IGsfoSfEhdJ/Gerp3lrKWq0LBpAZ5SHB9xADXklUBzBuWGDJoKPLQ7ELhKj34lI6rft6Yge1kDEIRgqUbA9fcY=
X-Received: by 2002:a17:90b:57e8:b0:30a:255c:9d10 with SMTP id
 98e67ed59e1d1-30e830e87f6mr37926849a91.8.1747944697890; Thu, 22 May 2025
 13:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250521094333.4075796-1-rowanbhart@gmail.com>
 <20250521094333.4075796-3-rowanbhart@gmail.com>
 <874ixcwt69.fsf@draig.linaro.org>
In-Reply-To: <874ixcwt69.fsf@draig.linaro.org>
From: Rowan Hart <rowanbhart@gmail.com>
Date: Thu, 22 May 2025 13:11:27 -0700
X-Gm-Features: AX0GCFuA_6GwZnconTj_HFs36_8UpHxnhITANZRmvNcVkIv2kRVbIO0VCEQwZWw
Message-ID: <CAE5MsNbZOwr6OYrUir2mXo21ejiVN_b9YYHiF-QRijFs5J+fWQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] Add register write API
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000ce0c4d0635bf16df"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=rowanbhart@gmail.com; helo=mail-pj1-x1032.google.com
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

--000000000000ce0c4d0635bf16df
Content-Type: text/plain; charset="UTF-8"

>  a) handle the QEMU_PLUGIN_CB_RW_REGS

I missed that this was not already handled. I'll fix that.

> b) try and enforce we are only being called from such callbacks

Sure, beyond documentation I suppose we can add and check a flag to ensure
this. I think it's a good idea to reduce foot guns from just calling it
from any old place.

-Rowan

--000000000000ce0c4d0635bf16df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><p dir=3D"ltr">&gt;=C2=A0 a) handle the QEMU_PLUGIN_CB_RW=
_REGS</p>
<p dir=3D"ltr">I missed that this was not already handled. I&#39;ll fix tha=
t. </p>
<p dir=3D"ltr">&gt; b) try and enforce we are only being called from such c=
allbacks</p>
<p dir=3D"ltr">Sure, beyond documentation I suppose we can add and check a =
flag to ensure this. I think it&#39;s a good idea to reduce foot guns from =
just calling it from any old place.</p>
<p dir=3D"ltr">-Rowan</p></div>

--000000000000ce0c4d0635bf16df--

