Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FDFC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezjR-0003Q3-Ce; Tue, 27 Feb 2024 10:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rezjP-000351-HH
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:50:59 -0500
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rezjN-0000jJ-Is
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:50:59 -0500
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3c1a9b567edso658621b6e.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709049056; x=1709653856; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H04cXXxrHiwASjhYMcqSrzY1/ionv2x3n4q/9mp5I2E=;
 b=Dm+7A9mKlkEzKSNzogvz4uBSyz496jy2q4ccgYfiAODbsa4gxV3u9crW4FPH099hr5
 z/TLK4x0zfeKqakuoj3qC4gA41gTtkv4GF/I0HFP3eDOqysiSAdPZzhAyceiOcv8VNLf
 6M0yp0oFzCRAb65oideFn149BFO8aNhe1HGySyKElPMwimjrvc0VDze2ZPK/DTvT3qXR
 Jku4zCpgOfqG5IWgmm0KThkROC6g7G2uovzSpOgmYyIgWq4sXWNDp6m2a0yHjC883PoB
 U9BviEKn8RTpGVxzfu4KM5ehk2sNaIK4BAfUa84zTr/JbLqzU2C9M//utRO76u1ZzGtC
 tlrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709049056; x=1709653856;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H04cXXxrHiwASjhYMcqSrzY1/ionv2x3n4q/9mp5I2E=;
 b=VVM707riPQROm46TXQObCnPk89ng9hllDVaAo8gVjaexx1IN/dpkQn4tSKtKuR/ePB
 /NWFIgMSK9E67Mh0meZcax5HhPC0VM2UE8Tu2+SA26XgosyZw8Wkylvhc7EAPkjG3kYn
 tXig5vH0XCstSkQ1n/H2G7LZvslfXJ5/bCuLj3cjDIhIzcIe+wbzi+ZKAERBZPo0JGn7
 lHrH08WCMCRYWCNEgRGedKLdLtIHK+w7Ze7F3mLnIoeYUXSbbTrtbzlouA7K1CvkKFDh
 QmjZKeQKWOn9E+iAR1+wZkgAg52xGUJP2Bec3ELJP61JDCcMvVzIRcLYolM7OgUBY3xz
 WClA==
X-Gm-Message-State: AOJu0YyzpcC4KXM4S2gZ/nWI3RNxyeXSaIDqIYL9x/0qIq86SgzWVbRM
 51awu3Wd5sQZDnXSMaEZ6vZxPz90twcUYpMjPDMyjdTK4MgspPm9
X-Google-Smtp-Source: AGHT+IEwUXGsyWfm+Z2pEzmLZpWeoZ3hvFMZt7gjG70ABiJfalbxHG0NvYwY/Wd7SsPcNjr6U7ypQw==
X-Received: by 2002:a05:6808:144f:b0:3c1:861d:765c with SMTP id
 x15-20020a056808144f00b003c1861d765cmr2693874oiv.54.1709049055992; 
 Tue, 27 Feb 2024 07:50:55 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-e80a-30fc-e8ad-af19.res6.spectrum.com.
 [2603:8080:1f00:9c00:e80a:30fc:e8ad:af19])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a05680809b100b003c16fffa307sm1475199oig.49.2024.02.27.07.50.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Feb 2024 07:50:54 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>
Cc: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20240226201722.391879-3-ltaylorsimpson@gmail.com>
 <20240227141938.63106-1-quic_mathbern@quicinc.com>
In-Reply-To: <20240227141938.63106-1-quic_mathbern@quicinc.com>
Subject: RE: [PATCH 2/9] Hexagon (target/hexagon) Mark new_read_idx in trans
 functions
Date: Tue, 27 Feb 2024 09:50:54 -0600
Message-ID: <022501da6994$bf6ba4b0$3e42ee10$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJoHxtF9W0NyNUfocrWrIMYiItjuAG1z3s+r/U41zA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Tuesday, February 27, 2024 8:20 AM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>
> Cc: qemu-devel@nongnu.org; bcain@quicinc.com;
> quic_mathbern@quicinc.com; sidneym@quicinc.com;
> quic_mliebel@quicinc.com; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: Re: [PATCH 2/9] Hexagon (target/hexagon) Mark new_read_idx in
> trans functions
> 
> On Mon, 26 Feb 2024 13:17:15 -0700 Taylor Simpson
> <ltaylorsimpson@gmail.com> wrote:
> >
> > diff --git a/target/hexagon/gen_trans_funcs.py
> > b/target/hexagon/gen_trans_funcs.py
> > index 53e844a44b..79475b2946 100755
> > --- a/target/hexagon/gen_trans_funcs.py
> > +++ b/target/hexagon/gen_trans_funcs.py
> > @@ -84,14 +84,15 @@ def gen_trans_funcs(f):
> >                  insn->opcode = {tag};
> >          """))
> >
> > -        regno = 0
> > -        for reg in regs:
> > -            reg_type = reg[0]
> > -            reg_id = reg[1]
> > +        new_read_idx = -1
> > +        for regno, regstruct in enumerate(regs):
> > +            reg_type, reg_id, _, _ = regstruct
> > +            reg = hex_common.get_register(tag, reg_type, reg_id)
> 
> Nit: since we don't care about the remaining elements of regstruct, we
could
> simplify (and future-proof) this even further to:
> 
>     reg_type, reg_id, *_ = regstruct
> 
> Or perhaps even eliminate the variable entirely:
> 
>     for regno, (reg_type, reg_id, *_) in enumerate(regs):
>         ...

Let's go with the second option.  I'll make the change.

Thanks,
Taylor



