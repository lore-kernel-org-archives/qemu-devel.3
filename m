Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E6EC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 13:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfgLM-00020T-RW; Thu, 29 Feb 2024 08:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nturtayeva@ucsb.edu>)
 id 1rfY1E-0002x9-7S
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:27:40 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nturtayeva@ucsb.edu>)
 id 1rfY1B-0001Tn-NA
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 23:27:39 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d2305589a2so5233931fa.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 20:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ucsb.edu; s=google; t=1709180854; x=1709785654; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DJED82AGPpq31NouZvhbNCwp58Nct+FGorae3DF4pDs=;
 b=FkpYhuGGOiJ1SObiIHesEyas4jKyQEi66JKR+b4TRSjqiXJajtWUuTRouRypB5aiOo
 NUfSs6MPyRsUQX10OrmTTCqxBK9LpstQXsfDRDWXcuTHSguYATdG+ONMJHiH4h8nyQf0
 Vqelkm4pOd2Wwkc1i2pBUby+ec+iFAJE7dmUe/FQwd0BrAnpS6QE7xSw+f6a1cDxp8Qw
 K0e+cOJDyyCP7PaqOCNH4qQZAf185OygMazwm0rILFVshnGQnzVhPsAmmbrBUFb9nSPN
 P15ILjhubi/S0Da+hRCiReLCXKIS/xj08hZF77gapnhohoywcDSJjG2jfLia0SSP2kvP
 XIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709180854; x=1709785654;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJED82AGPpq31NouZvhbNCwp58Nct+FGorae3DF4pDs=;
 b=OVdjpdkvbSgGMh7TEnl05zw+6paGuAiyeWmZDhAg8SRsu92B7P4bkKcYBMCsFrQGoa
 NcMuFW+rWYooq2AnmuIaBdDSxw7fw6FLdMlzB6FcijKORkMbGEX8owctBB63EI9tmMaE
 XjAwxsiSqcFjHNpyF2Y661ltmTohMPxGdQ6Rok0t7Y6DVKLvg/6dyk+sgy89Q/Wl23I8
 v7CV5peTcvzb8MRs6fSVvYZ4fLxz18lv/0/jf3OJMmnD1xhAGC7NjR/93pI7y3DsGWtI
 TfZenEQ5WxbyT51L0uTpXmR4B6B9BBe5KgzohR+DBE4xFU1fnEAZrUz8hYcyRx3isfef
 kSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtX03zajWAWGWOZN0MgCC57YlLJmkYptONTlC04gqsHLPBpxTrgtE0S9+3opRMUU0l9Q8k9veiBoqgq4wY/OyWMXTJfA8=
X-Gm-Message-State: AOJu0YyWH2UweEWiRrrw2KeFNYIW47nP6TqcpcbUe0j1C0zPaYwREAHK
 BmAOnqRfaCwJ/Jx/s2r/9j7ho7+Apj0P+b7QevLeK00HmxHCV/n54NMNw4kNHySEmtAE2V+yK45
 jR5m8yLR7N8HljpI4WhVwBL3N5oJqhRiaAgINE1QMiBhepi3k
X-Google-Smtp-Source: AGHT+IGu8ZzXXDaOuwGcRpiL5tSf7cnOrIGsarERKgLknFbM8cNoWI13qv4JfXdE6Z+3n8CMFdUM6USW2hXvMmizbdQ=
X-Received: by 2002:a2e:97d5:0:b0:2d3:7bd:da4e with SMTP id
 m21-20020a2e97d5000000b002d307bdda4emr76603ljj.33.1709180854403; Wed, 28 Feb
 2024 20:27:34 -0800 (PST)
MIME-Version: 1.0
From: Nazerke Turtayeva <nturtayeva@ucsb.edu>
Date: Wed, 28 Feb 2024 20:27:23 -0800
Message-ID: <CAHY78Bq6AdcZPuFRbdShDPvgmgcoB+PKLWqPuOoX3vdJ-NsZ+A@mail.gmail.com>
Subject: What riscv tracing tools do you recommend and how are they accurate
 for measurements?
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000af561406127dad7d"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=nturtayeva@ucsb.edu; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Feb 2024 08:20:55 -0500
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

--000000000000af561406127dad7d
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Recently, I was planning to measure the performance of my application of
interest for potential RISC-V hardware. Hence, I started my simulations
from Spike to analyze dynamic instruction traces and instruction count,
nevertheless given it does not support multithreading, I started using Qemu
to test my app too. However, it seems like I cannot rely on timing results
of Qemu for comparing different implementations. Accordingly, given I am
brand new to the Qemu ecosystem, I was wondering whether I am missing some
important mainstream instrumentation and tracing tools that I can use for
performance evaluation of my target app in other ways. Particularly, I want
to understand implications of adding custom ISA instructions to the
performance of my application.

In this regard, do you have any recommendations on where I can look?

Thanks,
Best wishes

-- 
Nazerke Turtayeva
Graduate Student
Electrical and Computer Engineering, Computer Science
Email: nturtayeva@ucsb.edu
*UC Santa Barbara*

--000000000000af561406127dad7d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi everyone,=C2=A0<div><br></div><div>Recently, I was plan=
ning to measure the performance of my application of interest for potential=
 RISC-V hardware. Hence, I started my simulations from Spike to analyze dyn=
amic instruction traces and instruction count, nevertheless given it does n=
ot support=C2=A0multithreading, I started using Qemu to test my app too. Ho=
wever, it seems like I cannot rely on timing results of Qemu for comparing =
different implementations. Accordingly, given I am brand new to=C2=A0the Qe=
mu ecosystem, I was wondering whether I am missing some important mainstrea=
m instrumentation and tracing tools that I can use for performance evaluati=
on of my target app in=C2=A0other ways. Particularly, I want to understand=
=C2=A0implications of adding custom ISA instructions to the performance of =
my=C2=A0application.=C2=A0</div><div><br></div><div>In this regard, do you =
have any recommendations on where I can look?</div><div><br></div><div>Than=
ks,</div><div>Best wishes<br clear=3D"all"><div><br></div><span class=3D"gm=
ail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signatu=
re" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><table width=3D"300=
" cellspacing=3D"0" cellpadding=3D"0" border=3D"0" style=3D"color:rgb(34,34=
,34)"><tbody><tr><td style=3D"vertical-align:top"><span style=3D"font-size:=
16px;font-family:&quot;Century Gothic&quot;,Helvetica,sans-serif;color:rgb(=
0,54,96)">Nazerke Turtayeva<br></span></td></tr><tr><td style=3D"vertical-a=
lign:top"></td></tr><tr><td style=3D"vertical-align:top;padding-top:4px;pad=
ding-bottom:4px"><span style=3D"font-size:14px;font-family:&quot;Century Go=
thic&quot;,Helvetica,sans-serif;color:rgb(4,133,155);font-weight:600">Gradu=
ate Student</span></td></tr><tr><td style=3D"vertical-align:top"><span styl=
e=3D"font-size:13px;font-family:&quot;Century Gothic&quot;,Helvetica,sans-s=
erif;color:rgb(85,85,85);letter-spacing:0.65px">Electrical and Computer Eng=
ineering, Computer Science</span></td></tr><tr><td style=3D"vertical-align:=
top"><span style=3D"font-size:13px;font-family:&quot;Century Gothic&quot;,H=
elvetica,sans-serif;color:rgb(85,85,85);letter-spacing:0.65px">Email:=C2=A0=
<a href=3D"mailto:nturtayeva@ucsb.edu" style=3D"color:rgb(17,85,204)" targe=
t=3D"_blank">nturtayeva@ucsb.edu</a></span></td></tr><tr><td style=3D"verti=
cal-align:top;padding-top:6px"></td></tr></tbody></table><b style=3D"color:=
rgb(34,34,34)"><span style=3D"font-size:16px;font-family:&quot;Century Goth=
ic&quot;,Helvetica,sans-serif;color:rgb(0,54,96)">UC Santa Barbara</span></=
b><br style=3D"color:rgb(34,34,34)"></div></div></div></div>

--000000000000af561406127dad7d--

