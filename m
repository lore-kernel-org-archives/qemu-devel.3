Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DD7C54E49
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezjM-0002uK-N8; Tue, 27 Feb 2024 10:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rezjA-0002Yn-Tg
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:50:48 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1rezj7-0000d5-Lv
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 10:50:44 -0500
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6e4953d801bso1443981a34.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 07:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709049040; x=1709653840; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yIHA0BNWG2vEwc/Osfcn5tjtHAa4zi9RFMWsDcOlcDM=;
 b=cIodAIbDVqQWQOkNacuKI9cDy77KpOULW90LdmFQnTOZY/L6jZoeeUiG8ip90KMMd7
 ahmsgzIcPSTKRXpRp3QKMKm6gLs/A68copWmEp8dks7lpKCbVAkna/sK/CsUrB5sOidE
 DOM6wJdkicnurqPtEaMS5thlNYzkfZVG4grz7OMrhHaSHkGMZVsAUvquKDAt+RGvhrUv
 BEKquJZLo/vIq909dI+CpbLVrBGPQX07XikfDPNlXbzURjdpYQxgimFo9Vqa6ofwbSnK
 jnq2PICr9WM1QmwCeU/T9rodRaZAKiwpchc+XLBBbWoko+aF358pfXmdbhuN1E2s8OXw
 oO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709049040; x=1709653840;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yIHA0BNWG2vEwc/Osfcn5tjtHAa4zi9RFMWsDcOlcDM=;
 b=Ja5FHHWwHbF6sbYzEWqnZ5I8tzGtanJ1E7Aud6b2JCar3BrjUdw67u1rN7PPpFlRQW
 ZzuMWjAwEqc0XH63nyz5Ti50x70RHXd6Ab7RzMj1u8kVBY+8MiFdaJPbg1IINEd9EY+3
 ZU/NXZAZiW1LP/Q0R5v7cZQfkGiJUbkV8Zhr90L16s68mrPLMFWsppjQynguW0RuRrF+
 Zd3dql2lE8wPgR+SRsC4yMxPevjzJE1NJIh1VETnv4+hFnVwHuRaq7Sv6n2NZ9O1zKr5
 1Bs72kGAlSZwa+vp2hfYyNUo5WC+QaOfys65CEjPk04CZTVoVcV0aa3BQK1VwJAAFmrQ
 rIQg==
X-Gm-Message-State: AOJu0YysSOkLyrgO7lMrucNmblMOoDtwzPhRnNKZA5YOoMRC6BroUQSO
 FUcHHWo+IDrFrKyAhN0pOrv17gbnXUEvlr2llPJWtNaysK7GoT/Z
X-Google-Smtp-Source: AGHT+IHd5aE00L/Ph58bAaepbEXrcINAeoMRzv+lRbOAfLakr8U2x5C3gaXStQbq/Nl8SOKJ5bOP2Q==
X-Received: by 2002:a05:6830:148d:b0:6e4:9602:a2d7 with SMTP id
 s13-20020a056830148d00b006e49602a2d7mr8579156otq.5.1709049040344; 
 Tue, 27 Feb 2024 07:50:40 -0800 (PST)
Received: from DESKTOPUU50BPD
 (2603-8080-1f00-9c00-e80a-30fc-e8ad-af19.res6.spectrum.com.
 [2603:8080:1f00:9c00:e80a:30fc:e8ad:af19])
 by smtp.gmail.com with ESMTPSA id
 h8-20020a9d61c8000000b006e4899f4f56sm1542304otk.76.2024.02.27.07.50.38
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Feb 2024 07:50:38 -0800 (PST)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>
Cc: <qemu-devel@nongnu.org>, <bcain@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <ale@rev.ng>, <anjo@rev.ng>
References: <20240226201722.391879-5-ltaylorsimpson@gmail.com>
 <20240227142112.56005-1-quic_mathbern@quicinc.com>
In-Reply-To: <20240227142112.56005-1-quic_mathbern@quicinc.com>
Subject: RE: [PATCH 4/9] Hexagon (target/hexagon) Mark has_pred_dest in trans
 functions
Date: Tue, 27 Feb 2024 09:50:36 -0600
Message-ID: <022301da6994$b5d2d360$21787a20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxMsYHZp6pBZrywqY0XSMT3CTKNAF5BitzseT5jJA=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x335.google.com
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
> Sent: Tuesday, February 27, 2024 8:21 AM
> To: Taylor Simpson <ltaylorsimpson@gmail.com>
> Cc: qemu-devel@nongnu.org; bcain@quicinc.com;
> quic_mathbern@quicinc.com; sidneym@quicinc.com;
> quic_mliebel@quicinc.com; richard.henderson@linaro.org;
> philmd@linaro.org; ale@rev.ng; anjo@rev.ng
> Subject: Re: [PATCH 4/9] Hexagon (target/hexagon) Mark has_pred_dest in
> trans functions
> 
> On Mon, 26 Feb 2024 13:17:17 -0700 Taylor Simpson
> <ltaylorsimpson@gmail.com> wrote:
> >
> > diff --git a/target/hexagon/gen_trans_funcs.py
> > b/target/hexagon/gen_trans_funcs.py
> > index 07292e0170..f1972fd2dd 100755
> > --- a/target/hexagon/gen_trans_funcs.py
> > +++ b/target/hexagon/gen_trans_funcs.py
> > @@ -86,6 +86,7 @@ def gen_trans_funcs(f):
> >
> >          new_read_idx = -1
> >          dest_idx = -1
> > +        has_pred_dest = "false"
> >          for regno, regstruct in enumerate(regs):
> >              reg_type, reg_id, _, _ = regstruct
> >              reg = hex_common.get_register(tag, reg_type, reg_id) @@
> > -96,6 +97,8 @@ def gen_trans_funcs(f):
> >                  new_read_idx = regno
> >              if reg.is_written() and dest_idx == -1:
> >                  dest_idx = regno
> > +            if reg_type == "P" and not reg.is_read():
> > +                has_pred_dest = "true"
> 
> I got a bit confused here. Why do we use "not reg.is_read()"? I though
this
> would be "reg.is_written()".

The original C code is
            if ((strstr(opcode_wregs[opcode], "Pd4") ||
                 strstr(opcode_wregs[opcode], "Pe4")) &&
Checking for reg.is_written() would also match Px4, which is read-write.

Would it be more clear if we checked for reg.is_written() and non
reg.is_read()?

Thanks,
Taylor



