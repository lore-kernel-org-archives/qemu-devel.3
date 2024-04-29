Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77105C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SLf-0006Pk-Bq; Mon, 29 Apr 2024 10:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1SLb-0006Mz-Pe
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:51:15 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s1SLZ-0007hX-Uv
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 10:51:15 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c730f599abso2744222b6e.0
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 07:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714402272; x=1715007072; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ECDxKUDuwic74OXC+2Os7pKo8zMsuefxi/pkv3IHWnw=;
 b=dqptGucQBrChowOSE0zeFyxx3S1Nfw6CCGoXTqSKdWA8LOICEp1ENzHOGpsvkG4/8u
 Psn/P5eGscIyQA3x2W4MX9yLsBGFvmqNl4eDxyQRX2IxQpAts2ioAug0gBsQSwZjV7OG
 4zhihF2m1gtj3fsQ0gh+KJJupEU1iho+XzQyZOepC3zoIH14mw+8KC0PtS094wnRD2NM
 NhqvyCOYDH2CUqRC/C+jArVyQ2uUXGxt85+vHXIckKzDw6wJMFd4SE9L5+38PziSr0kA
 feUWN9elUEc5bBZa1oUtHvPTvW3ssIdn1EVgPI/WZexneP4DMwkzIsg1ZUa6okJg842s
 bdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714402272; x=1715007072;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ECDxKUDuwic74OXC+2Os7pKo8zMsuefxi/pkv3IHWnw=;
 b=FXWzTaFCm5JRM0I15RxqAikFZcTPtV4kGIDxSLWVZeSLd/qrFkHRQlwgcUZWH9P6oq
 2zqjC6KP3WwzgAc45QXjBhxOP7cepxrGQ0yuhAR9lz7/aEhU2lcXZ2z1uWdtkvz9tywB
 or74E9rTzDRyBsGaVWQygSY8Fnm5nglv0vRC0NZkiiFjqp+QDtXTc9t1Duh7GMub+mqr
 i1kjQ5x2u904S+m/fwsoNOOPehB6lk59rZvZ5YoLYG+P7Vl3M2h7CqY86jkgG8AHrZV0
 6SzOECIaNIp0mNTwU+WNGiMnnVztl8zBTAh3ku7jTUgesB3VieBAmN1bTNNwCVeoRpf4
 ySTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXKjZ0NbXuEd0vnsx0LfEuXrasn4rzGigOM1vYtzdLXGa76PCMipgK3da+0dJpm4dPWQlQFsPk0bSQ0neNxZGpogyZYFU=
X-Gm-Message-State: AOJu0YwzLuecsHBlPAGqYjSdv9mfX1X70TeZ2V3WeMejhVhkDGRimNUz
 w0u4xDuAOtPBvyGlbukqufxbhGP13h/s06m+TfYH9mR6PwTK9/Xt
X-Google-Smtp-Source: AGHT+IHD9+OHeYTOFkTswEAMy/RuQNVs/Q8GwVg27pV2CPnYUrKPtDmI3mWsPkQG9QdlD8bVJ9swYg==
X-Received: by 2002:a05:6808:250:b0:3c8:62fc:2654 with SMTP id
 m16-20020a056808025000b003c862fc2654mr6788207oie.43.1714402272343; 
 Mon, 29 Apr 2024 07:51:12 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:2639:f689:1715:fc7b])
 by smtp.gmail.com with ESMTPSA id
 cp22-20020a056808359600b003c60bc31ed9sm3371755oib.17.2024.04.29.07.51.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Apr 2024 07:51:11 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Matheus Tavares Bernardino'" <quic_mathbern@quicinc.com>,
 <qemu-devel@nongnu.org>
Cc: <bcain@quicinc.com>, <sidneym@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>
References: <c7af62451b02ffdc1d68bc00093b40a8080bc3ff.1714155331.git.quic_mathbern@quicinc.com>
 <028d01da9a43$3503f8b0$9f0bea10$@gmail.com>
In-Reply-To: <028d01da9a43$3503f8b0$9f0bea10$@gmail.com>
Subject: RE: [PATCH] Hexagon: add PC alignment check and exception
Date: Mon, 29 Apr 2024 09:51:16 -0500
Message-ID: <028e01da9a44$b05d2940$11177bc0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJzRyC/evNEDGnzkOUKIb6QtlGw1gFHrDeIsEO8m2A=
Content-Language: en-us
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x22c.google.com
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

PS  You should also update the pkt_raises_exception function in translate.c
to return true for packets that contain these instructions.  This will
ensure that none of the machine state is changed before the check is
complete.

Taylor


> -----Original Message-----
> From: ltaylorsimpson@gmail.com <ltaylorsimpson@gmail.com>
> Sent: Monday, April 29, 2024 9:41 AM
> To: 'Matheus Tavares Bernardino' <quic_mathbern@quicinc.com>; qemu-
> devel@nongnu.org
> Cc: bcain@quicinc.com; sidneym@quicinc.com; ale@rev.ng; anjo@rev.ng
> Subject: RE: [PATCH] Hexagon: add PC alignment check and exception
> 
> 
> 
> > -----Original Message-----
> > From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> > Sent: Friday, April 26, 2024 1:16 PM
> > To: qemu-devel@nongnu.org
> > Cc: bcain@quicinc.com; sidneym@quicinc.com; ale@rev.ng; anjo@rev.ng;
> > ltaylorsimpson@gmail.com
> > Subject: [PATCH] Hexagon: add PC alignment check and exception
> >
> > The Hexagon Programmer's Reference Manual says that the exception
> 0x1e
> > should be raised upon an unaligned program counter. Let's implement
> > that and also add tests for both the most common case as well as
> > packets with multiple change-of-flow instructions.
> >
> > Signed-off-by: Matheus Tavares Bernardino
> <quic_mathbern@quicinc.com>
> > ---
> 
> 
> > --- a/target/hexagon/genptr.c
> > +++ b/target/hexagon/genptr.c
> > @@ -473,6 +473,7 @@ static void gen_write_new_pc_addr(DisasContext
> 
> You haven't added the check to gen_write_new_pc_pcrel.  It's not needed
> there because the encoding guarantees the target is always aligned -
right?
> However, there is a call to gen_write_new_pc_addr inside that function.
In
> this case, we'll add a check that isn't necessary.  Consider adding a
parameter
> to indicate if the check can be avoided.
> 
> 
> > a/tests/tcg/hexagon/Makefile.target
> > b/tests/tcg/hexagon/Makefile.target
> > index f839b2c0d5..02d7fff34c 100644
> > --- a/tests/tcg/hexagon/Makefile.target
> > +++ b/tests/tcg/hexagon/Makefile.target
> > @@ -51,6 +51,19 @@ HEX_TESTS += scatter_gather  HEX_TESTS +=
> hvx_misc
> > HEX_TESTS += hvx_histogram  HEX_TESTS += invalid-slots
> > +HEX_TESTS += unaligned_pc
> > +HEX_TESTS += unaligned_pc_multi_cof
> > +
> > +run-unaligned_pc: unaligned_pc
> > +run-unaligned_pc_multi_cof: unaligned_pc_multi_cof run-unaligned_pc
> > +run-unaligned_pc_multi_cof:
> > +	$(call run-test, $<, $(QEMU) $< 2> $<.stderr,"$< on
> > $(TARGET_NAME)"); \
> > +	if [ $$? -ne 1 ] ; then \
> > +		return 1; \
> > +	fi
> > +	$(call quiet-command, \
> > +		grep -q "exception 0x1e" $<.stderr, \
> > +		"GREP", "exception 0x1e");
> 
> We should also test endloop instructions.
> 
> Thanks,
> Taylor
> 



