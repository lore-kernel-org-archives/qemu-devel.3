Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 737BBCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 21:07:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxAyH-0008SN-0x; Fri, 12 Sep 2025 17:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1ux7oi-0003hX-FX
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:44:12 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lixiaoyan@google.com>)
 id 1ux7og-0008Dd-5s
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 13:44:12 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-621c6ae39b5so1352a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 10:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1757699046; x=1758303846; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TP6Xkd1ZYogxUzlDoK8soGJmRtUx1u6oSWZyFYXhlcQ=;
 b=X60efN8hPkSaTa7znNTdwG0wI/7G3l1NetjU/jN0+WemTTAjIXtMm9Y96XoeEz7C5a
 hgqbiFchO2b+7AAd+6lT6msbeVXOwWYQWk2hyZZay3pJuCA6bPG3izk/JnVmCc/FdIAd
 ajG97v26zi53tsdCmFXITGylBLn5oyzlzEJs+tGn37j7wE+CVElZ8otRoNx5cyuIax3C
 B/molGou0cpE+sZKoggAtcHBnjLg2WoueWu+PS3QETc4GSwjrGAehcfETRjmPJdNPS/Q
 dCDzkX6fDWJC6hRLUmzOxfZd6cDMV3H3klZNfSpFkmWt8sNRzFRRtmdFh0nYJ69NMgFW
 g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757699046; x=1758303846;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TP6Xkd1ZYogxUzlDoK8soGJmRtUx1u6oSWZyFYXhlcQ=;
 b=FGdkBB/MOiCDP46o9Gnjr0mwCcTxZapFXFcZr22yBcG5qb9EIp5cq+lryCC6qxz43F
 UtQf9pXre+w2tEuaBbZnbCCQ3seIKHCFep1Wu2keL4CB/C7V0RHpo02xBJpAYlI2ybJX
 PDAWJjBn4CG0m6wZgnCTYYqrUaQjhJ4tRi9ZTPwEA93bSeuG+uboEWJeDZ9WuoDNtlKx
 +meYaHw+vNKJHM29oUsAu7ls4Ll0R14zcA/BkrI3bb2cDYynHs4sc3BlSmoSIfA8Jqxo
 W3CAwLBxxqauWrDGg+nEJx0NN1voFOTT6JCB8qk6ybPPgaUbYhwXCOkojO8c0yFaSHSm
 X0Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpAk451u2HTAwmEP0LjV+F0FM+B1xp1LQxqVdcRC3gA+ypYtGAVNm7KYnVZe1V5PsyTBP1drVdtX35@nongnu.org
X-Gm-Message-State: AOJu0YxcqHh1sUB/j8TAHlVAjFM/4X9WoyXoYLzgJrD7ssT4R7l8Xx9z
 r6gJ8LafUXYb1UNhm3DVMbcT1IZ7ugDPDuQ2uY08BW/ykH1gBkWlBU+AKS8MJUfzIGRNAQHa+wx
 HKedJP24jiTpdQ/a4Suu3KU6ZLBRNGXjRlETcAD4x
X-Gm-Gg: ASbGncuEM45IAG8rh271ZeJjk96M3yGwoSjbAsKBqcryv6jl/rDyJFqGi0fbJEb0myr
 J+1ivDHUp+A8zbAxQjlUeQUFJca8+Sx0huu+9+oi/3TJDR0k3eRsi3c6vpxgCdFL7sqPU9Uacr5
 NI+yZk1kcNtu10r01y/03AU8Wycy/5yZbbT7xTodeEHxO++5xowAdT8OchRqOXUBaIKsyOBuVGm
 KHVMbSYTokTUn/E7pHKeX3HLRP/4QN7+5bbY5m9gSE3S9T+SDDBhiNVHw==
X-Google-Smtp-Source: AGHT+IHsyXrGrakgdtLZwlQLBD1M2C5+48aI/x71/auXiYYs4JyM7SJNNkpYMxuTaANPYDbDHEf4WxnzeL1iqtvrdaM=
X-Received: by 2002:a05:6402:d4b:b0:62e:de92:704f with SMTP id
 4fb4d7f45d1cf-62ede927182mr94943a12.1.1757699045538; Fri, 12 Sep 2025
 10:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250903213809.3779860-1-lixiaoyan@google.com>
 <20250903213809.3779860-2-lixiaoyan@google.com>
 <e0e733ff458cf253ddaf2b5570183b86c7c13102.camel@codeconstruct.com.au>
In-Reply-To: <e0e733ff458cf253ddaf2b5570183b86c7c13102.camel@codeconstruct.com.au>
From: Coco Li <lixiaoyan@google.com>
Date: Fri, 12 Sep 2025 10:43:53 -0700
X-Gm-Features: Ac12FXxnuV3NoMwYMKUqwyFl2bgbQRtXILEQhkalURrnZuqfJhl0_N2aCxRvN9c
Message-ID: <CADjXwjjjSQGwOfquXmLfENRAAmHv5KXaGvjkiK7KFzGuehPsow@mail.gmail.com>
Subject: Re: [PATCH 1/5] hw/gpio: Add property for ASPEED GPIO in 32 bits basis
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: peter.maydell@linaro.org, clg@kaod.org, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, Felix Wu <flwu@google.com>
Content-Type: multipart/alternative; boundary="0000000000003bd89c063e9e33bc"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=lixiaoyan@google.com; helo=mail-ed1-x534.google.com
X-Spam_score_int: -165
X-Spam_score: -16.6
X-Spam_bar: ----------------
X-Spam_report: (-16.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 12 Sep 2025 17:06:15 -0400
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

--0000000000003bd89c063e9e33bc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andrew,

I discussed with the original author of the patch and the Nuvoton
functionality mentioned above has not been upstreamed since then,
unfortunately.
Aside from the comment above, we believe this patch series allows gpios to
be accessed more dynamically/flexibly in complicated simulation, and also
helps with accessing advanced gpio features, see the sgpio implementation
later in this patch series.

Best,
Coco

On Tue, Sep 9, 2025 at 8:52=E2=80=AFPM Andrew Jeffery <andrew@codeconstruct=
.com.au>
wrote:

> On Wed, 2025-09-03 at 21:38 +0000, Coco Li wrote:
> > From: Felix Wu <flwu@google.com>
> >
> > Added 32 bits property for ASPEED GPIO. Previously it can only be acces=
s
> in bitwise manner.
> >
> > This change gives ASPEED similar behavior as Nuvoton.
>
> Can you point me to the Nuvoton functionality? I had a quick look and
> couldn't immediately see an equivalent implementation.
>
> Regardless, I'd like to see more motivation in the commit message than
> "make it behave like Nuvoton". Can you provide a concrete use-case as
> an example?
>
> Andrew
>

--0000000000003bd89c063e9e33bc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Andrew,<div><br></div><div>I discussed with the orig=
inal author of the patch and the Nuvoton functionality mentioned above has =
not been upstreamed since then, unfortunately.</div><div>Aside from the com=
ment above, we believe this patch series allows gpios to be accessed more d=
ynamically/flexibly in complicated simulation, and also helps with accessin=
g advanced gpio features, see the sgpio implementation later in this patch =
series.</div><div><br></div><div>Best,</div><div>Coco</div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 9, 2=
025 at 8:52=E2=80=AFPM Andrew Jeffery &lt;<a href=3D"mailto:andrew@codecons=
truct.com.au" target=3D"_blank">andrew@codeconstruct.com.au</a>&gt; wrote:<=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Wed, 2025-09-=
03 at 21:38 +0000, Coco Li wrote:<br>
&gt; From: Felix Wu &lt;<a href=3D"mailto:flwu@google.com" target=3D"_blank=
">flwu@google.com</a>&gt;<br>
&gt; <br>
&gt; Added 32 bits property for ASPEED GPIO. Previously it can only be acce=
ss in bitwise manner.<br>
&gt; <br>
&gt; This change gives ASPEED similar behavior as Nuvoton.<br>
<br>
Can you point me to the Nuvoton functionality? I had a quick look and<br>
couldn&#39;t immediately see an equivalent implementation.<br>
<br>
Regardless, I&#39;d like to see more motivation in the commit message than<=
br>
&quot;make it behave like Nuvoton&quot;. Can you provide a concrete use-cas=
e as<br>
an example?<br>
<br>
Andrew<br>
</blockquote></div>

--0000000000003bd89c063e9e33bc--

