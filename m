Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20612C54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzSM-0001EL-PN; Tue, 12 Mar 2024 06:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzSK-0001De-7Y; Tue, 12 Mar 2024 06:34:00 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzSI-0006LB-HG; Tue, 12 Mar 2024 06:33:59 -0400
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbc649c275so2868534b6e.0; 
 Tue, 12 Mar 2024 03:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710239636; x=1710844436; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CmtbJlpo04cJOr6mQ9QHNGuBRil3vPZEQ4qji7sfh+k=;
 b=kLp2rAg8UNZF0N9ZfK7ToL/OUWq7aAYlKE0qKEtajz+rAwppEmnpa2sKyDowvvJOAN
 OWZzXxN6xzRIQJ5GUJ13EmN9akwg9c3QuNgxwO6Db5uszXsJ4x6cDf3XgwS89AKCMTdr
 2NzsKzHESBmAA7fHcsD3zE5u9dCDqNzgfcS3Bky3m/k4gbjoaPhCrEFWyRnPvSbhgbP7
 fBeSJX6MccXoYE+xrPim1YuLrrN6FxMaQrwXVbZGotWmODFFcqIMWsaZTFYr/ElneWhX
 IUbUiHdTotOOw3+eora6P3ncJX5RvrbvAeVQ6CLm2sQRBoUNPTEtWdkPhMdjyW04MPcw
 S0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710239636; x=1710844436;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CmtbJlpo04cJOr6mQ9QHNGuBRil3vPZEQ4qji7sfh+k=;
 b=CRx24zXbx3h24AX5x7jiYai6h7cAVAD9Bz0PIyQcR5Czv9qZCp7tThDEZynzu1VKfa
 WwiF1CR6k+XRMuu+KNXj9EALEkLHFbEzcD6kdoAL7Ggx9U4Dde8fqPtvyuLJLTFST/32
 4tjQeOO5ddjptP8Gp4FGaV7CfM6fvwEgVhuutdQ6cH52yqqneIdqaAlIE3ne1T4tmpmh
 InBCnAQd5EKxiLVo8oy2UTlGaNseU8cnkJZ+pTu9xyRb6fzZNotHvMUB8o6LRKSs0YHw
 oMALDaywJ3YHVmJh6Ub5rKNhArGT4lWkESHfMJDjuV5iHU6i4+AKiAGMO59x3tvXs0oL
 TDsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwESbtJZYkmLwyxYNP8+hdDZhN6E4BL5Z0oN96O5vhXNfn0DvQYKVSFrrha4lEH8dOxtL/1/5406ZG6O/uaYtDlfHT
X-Gm-Message-State: AOJu0YwJIcvHuFz6Emkvthmm3ZQRjA8BPwDy+IKRoEzB51FvowEtoYvB
 n6KjBd3U8UHWlJSoRyENXRcL9tmGU+cYqSUEpALP3lDtmInTH/ed
X-Google-Smtp-Source: AGHT+IHEvQBgCtMSy7Z5r8lr2tfSegXY6FrEqhpGOpB30pb26VvjKOZ6rr+CRUHJPISEEtHbtn46IA==
X-Received: by 2002:a05:6808:d4d:b0:3c2:4da2:dc9 with SMTP id
 w13-20020a0568080d4d00b003c24da20dc9mr5375415oik.50.1710239636555; 
 Tue, 12 Mar 2024 03:33:56 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 e6-20020a056a0000c600b006e4432027d1sm5974750pfj.142.2024.03.12.03.33.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:33:56 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:33:51 +1000
Message-Id: <CZRPCOJH4405.10GP6RXFEJGFL@wheely>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, "David Gibson" <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 09/13] target/ppc: Prevent supervisor from modifying
 MSR[ME]
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240311185200.2185753-1-npiggin@gmail.com>
 <20240311185200.2185753-10-npiggin@gmail.com>
 <39ff316c-f28d-4986-95b6-ed2705d7cf8b@linux.ibm.com>
In-Reply-To: <39ff316c-f28d-4986-95b6-ed2705d7cf8b@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::234;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x234.google.com
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

On Tue Mar 12, 2024 at 8:27 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 3/12/24 00:21, Nicholas Piggin wrote:
> > Prevent guest state modifying the MSR[ME] bit. Per ISA:
> >=20
> >    An attempt to modify MSRME in privileged but non-hypervisor state is
>
> s/MSRME/MSR[ME] ?

Yes, thanks.

>
> >    ignored (i.e., the bit is not changed).
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   target/ppc/helper_regs.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >=20
> > diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> > index 410b39c231..25258986e3 100644
> > --- a/target/ppc/helper_regs.c
> > +++ b/target/ppc/helper_regs.c
> > @@ -264,6 +264,11 @@ int hreg_store_msr(CPUPPCState *env, target_ulong =
value, int alter_hv)
> >           value &=3D ~MSR_HVB;
> >           value |=3D env->msr & MSR_HVB;
> >       }
> > +    /* Attempt to modify MSR[ME] in guest state is ignored */
> > +    if (is_book3s_arch2x(env) && !(env->msr & MSR_HVB)) {
> > +        value &=3D ~(1 << MSR_ME);
> > +        value |=3D env->msr & (1 << MSR_ME);
> > +    }
>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>
> >       if ((value ^ env->msr) & (R_MSR_IR_MASK | R_MSR_DR_MASK)) {
> >           cpu_interrupt_exittb(cs);
> >       }


