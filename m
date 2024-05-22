Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4842BC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 01:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9aqk-0000Yg-94; Tue, 21 May 2024 21:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9aqg-0000Xn-Fp; Tue, 21 May 2024 21:32:59 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s9aqf-0005rs-26; Tue, 21 May 2024 21:32:58 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ec69e3dbcfso6398535ad.0; 
 Tue, 21 May 2024 18:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716341575; x=1716946375; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3tuUOjU2HbAXkFYHvjKSZnCFMc3zJ5inIuMBqhIA/Q=;
 b=mcUsw5ahkSWDADHUfaqYAOKMkrZcRoYT/Y70WvV+NPSclAWJ+jrwQPoYG8UHDR/7nY
 QJm0jY6tPuPzDA6MDwORn9f7HujWQQ5VQC50HUDMMzMEEKHSg3+MYSbYegvgguIrQ7oH
 Ox88+aHG0dsENVMrtS6qCFQNedtO+GzYFrilYDjteGvbssbVz7vvF3cgOoDGAldcw4Bc
 vJvzo1flNgpZTZyPcDnO6HEr3y5gvEiNt6egMp8N7cz5NlpBBHu8ojMZnsSrPeIlL3RO
 FJpmw1HWaOJxfSnBKjvOfgvjUG/3kyyfFS8eTuPu2qs1CN+PaisbxH0PutiI/UbOmetn
 VO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716341575; x=1716946375;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j3tuUOjU2HbAXkFYHvjKSZnCFMc3zJ5inIuMBqhIA/Q=;
 b=hoWtJHmdNmiDwwUVorBk5/UPh7XCQ4wG4iCOIseU5QUvup16WpydpwkEBmCMtZmn2V
 /2Tk48KT/28CUH8lmNSUcdRMUsChhA8YR/SHYtuvew1z0ewya1z0HL81SKJeDyLUNGTH
 YtUgNlT2jAQTt/31l7rxgHmY2PqrxhNuJcmwefdJflIQjikcfMvHEZ4qL6zKnm/zf2TS
 Wl8yy9QIznj+41NLmg9OdrsQCxeENdcx2Tw6DXZE0sQ1Sc08ZnOWSanypB/P0BWou0iF
 d3zhCe22ncVjngVpNwXHU5h6UelBOLlszvJNJY7bjnE059y0HZJURTfBuLccdV3Dfc+C
 1QQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1PSZ1yqqXuhEBbrUWodIfs7BZsXwJmXwyam6OLmWj4SO0JLD0wuug8SQmzLlEf4FcdmQRaGo1hVLLSFLGGfIisjx
X-Gm-Message-State: AOJu0YwOafCqisKZERhJElA1nTE6jAqe1np2uJY3MF7FwoWcRGkprkA/
 bIoyZOA9BbGEdSTrvO6kt3WyjXNQ2donZoD3qaCQuNHvIHH64/g2
X-Google-Smtp-Source: AGHT+IGSOaSFg6E/mtgEPzTBsVgk1R44SrmK5RXXCkA9EUZqCmKgg7BCApxzDmNjMbvpZprZEvNANA==
X-Received: by 2002:a17:903:230c:b0:1ee:b56b:e03b with SMTP id
 d9443c01a7336-1f31c9ed413mr6690045ad.49.1716341575096; 
 Tue, 21 May 2024 18:32:55 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f326bd5b70sm443065ad.237.2024.05.21.18.32.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 18:32:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 11:32:49 +1000
Message-Id: <D1FSB461VH13.339I0W6KA470U@gmail.com>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "Glenn Miles" <milesg@linux.vnet.ibm.com>,
 "Chinmay Rath" <rathc@linux.ibm.com>
Subject: Re: [PATCH v2 03/12] target/ppc: Implement attn instruction on
 BookS 64-bit processors
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-4-npiggin@gmail.com>
 <f407d5ba-2405-4723-bf86-dacdb7cf9a91@linaro.org>
In-Reply-To: <f407d5ba-2405-4723-bf86-dacdb7cf9a91@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed May 22, 2024 at 3:34 AM AEST, Richard Henderson wrote:
> On 5/20/24 18:30, Nicholas Piggin wrote:
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index c358927211..2532408be0 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -3025,6 +3031,12 @@ static inline int check_pow_nocheck(CPUPPCState =
*env)
> >       return 1;
> >   }
> >  =20
> > +/* attn enable check                                                  =
       */
> > +static inline int check_attn_none(CPUPPCState *env)
> > +{
> > +    return 0;
> > +}
>
> No point in putting this here, as a static inline...
>
> > @@ -2138,6 +2158,7 @@ POWERPC_FAMILY(405)(ObjectClass *oc, void *data)
> >       dc->desc =3D "PowerPC 405";
> >       pcc->init_proc =3D init_proc_405;
> >       pcc->check_pow =3D check_pow_nocheck;
> > +    pcc->check_attn =3D check_attn_none;
>
> ... when the only uses force an out-of-line instance.

Yeah... I was following existing convention (although apparently not
naming convention :/).

>
> Alternately,
>
> > +#if defined(TARGET_PPC64) && !defined(CONFIG_USER_ONLY)
> > +void helper_attn(CPUPPCState *env)
> > +{
> > +    /* POWER attn is unprivileged when enabled by HID, otherwise illeg=
al */
> > +    if ((*env->check_attn)(env)) {
> > +        powerpc_checkstop(env, "host executed attn");
>
> ... allow the hook to be null to indicate no attn.

I'll add a todo list to change this and check_pow to follow this
suggestion.

>
> Otherwise,
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks,
Nick

