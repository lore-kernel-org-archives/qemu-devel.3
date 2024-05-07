Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E179AC19F4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 21:06:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4S0l-00030d-FO; Tue, 07 May 2024 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s4S0e-0002zR-7L
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:06:01 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1s4S0b-0004df-2B
 for qemu-devel@nongnu.org; Tue, 07 May 2024 17:05:59 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-23bd61fbd64so2457365fac.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 14:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715115955; x=1715720755; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=vGef84+m4oQ4iOIrxb0PfmIZtWMtXpB40ysiWFdCci0=;
 b=JmaYaS687SLRxY/OD4guMxFvu7sMgRnAHrpUjQGrNjjzEzSTWGway25Xn7lYtb41g+
 LprX5GiOJRVVCWaFGhIcmqWIBATaQfCyRotHyttA+hrkvOeBDzKb1lHp6Mk01XDnmjzP
 k4EB0hC/BaU5cvAXVs0ve26JhYhRWBeKs5zigXk1pmbetZeOZbjjJfoMJIuW/QVkomnE
 zg+chruvBcEjOW5K1d6txx9j84J1iJeCmrJ90gSu6NnS4F6mshpAOE/P0OwOGnUhi5iI
 BplLv8EEllB96e2dhow8xyRTfsONWVpHWTyqHEkyPl/hS/3qmXTYQsWFQnbjReY3yvIh
 5Hmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715115955; x=1715720755;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vGef84+m4oQ4iOIrxb0PfmIZtWMtXpB40ysiWFdCci0=;
 b=Czf57/znWlO5kyP12KxGYLB842OvPpkxuFUG0rGrPrLSvb2NhKvXZYKHVlkxuCD5bi
 w0e3JWdfHcK6UajUHU1g3S5ziVoIRvCNHj/Ps2lCDeW+Lm+86kwe20mbyndmbSKJtW3K
 lqg6l94/K99kqezPHHtROB6qXoq+ExGVTEabTUBp/TQ7Rqus0aM42RIcOGRdz47jnNWH
 aRt3BLE4vnhuFic0iFYPB+Yfj3/FNV7lV6QgZgh0shtojdDYk8OSnwR/kZqD9Gq/DBvQ
 wGdEFlXf3PV9n4X8vMWr1/dkUPy1cu7BKViUMnX+G+bUpljxR+glNjza8gTy8GaP5Vqd
 3zlA==
X-Gm-Message-State: AOJu0YxCyIo4cdnaQ1CBfb7/h7SmKl6TLi5eCRjJTGvATET9KiHpNf6v
 0mLXx0fGR4avoZwVZLOk7zuJS/4kq6X95uSa97pQbLJkdRshjtGXXEu9uQ==
X-Google-Smtp-Source: AGHT+IGmggmH+4zsP2G4CrPpcYBhQ9pzdYt65rdFMWqvGpJUXL0CpVnmw6Xm8IW97yAdZAXohCgUHg==
X-Received: by 2002:a05:6870:5e0e:b0:23e:6d44:f984 with SMTP id
 586e51a60fabf-24097e768b7mr818963fac.26.1715115955338; 
 Tue, 07 May 2024 14:05:55 -0700 (PDT)
Received: from DESKTOPUU50BPD ([2603:8080:1f00:9c00:9853:4f9b:dc74:424c])
 by smtp.gmail.com with ESMTPSA id
 qg17-20020a056870de1100b0023b5203fc58sm2723517oab.37.2024.05.07.14.05.54
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 07 May 2024 14:05:54 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Anton Johansson'" <anjo@rev.ng>
Cc: <qemu-devel@nongnu.org>,
	<ale@rev.ng>,
	<bcain@quicinc.com>
References: <20240506183117.32268-1-anjo@rev.ng>
 <20240506183117.32268-4-anjo@rev.ng>
 <067f01da9fe7$51597590$f40c60b0$@gmail.com>
 <f7fmzerjibovuo7uevxmold5g6jvvjazfckhtv6tqkatpgbtzy@ging72uqq27r>
In-Reply-To: <f7fmzerjibovuo7uevxmold5g6jvvjazfckhtv6tqkatpgbtzy@ging72uqq27r>
Subject: RE: [PATCH 3/4] target/hexagon: idef-parser fix leak of init_list
Date: Tue, 7 May 2024 16:05:53 -0500
Message-ID: <071701daa0c2$5988d450$0c9a7cf0$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJLdJdU/DG86JVEEIa8gVqwbMNhjgHc4CmKAZKcipcB0QeirbCAlt3Q
Content-Language: en-us
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x31.google.com
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



> -----Original Message-----
> From: 'Anton Johansson' <anjo@rev.ng>
> Sent: Tuesday, May 7, 2024 4:47 AM
> To: ltaylorsimpson@gmail.com
> Cc: qemu-devel@nongnu.org; ale@rev.ng; bcain@quicinc.com
> Subject: Re: [PATCH 3/4] target/hexagon: idef-parser fix leak of =
init_list
>=20
> On 06/05/24, ltaylorsimpson@gmail.com wrote:
> >
> >
> > > -----Original Message-----
> > > From: Anton Johansson <anjo@rev.ng>
> > > Sent: Monday, May 6, 2024 1:31 PM
> > > To: qemu-devel@nongnu.org
> > > Cc: ale@rev.ng; ltaylorsimpson@gmail.com; bcain@quicinc.com
> > > Subject: [PATCH 3/4] target/hexagon: idef-parser fix leak of
> > > init_list
> > >
> > > gen_inst_init_args() is called for instructions using a predicate =
as
> > > an
> > rvalue.
> > > Upon first call, the list of arguments which might need
> > > initialization
> > init_list is
> > > freed to indicate that they have been processed. For instructions
> > > without
> > an
> > > rvalue predicate,
> > > gen_inst_init_args() isn't called and init_list will never be =
freed.
> > >
> > > Free init_list from free_instruction() if it hasn't already been =
freed.
> > >
> > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > ---
> > >  target/hexagon/idef-parser/parser-helpers.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/target/hexagon/idef-parser/parser-helpers.c
> > > b/target/hexagon/idef-parser/parser-helpers.c
> > > index 95f2b43076..bae01c2bb8 100644
> > > --- a/target/hexagon/idef-parser/parser-helpers.c
> > > +++ b/target/hexagon/idef-parser/parser-helpers.c
> > > @@ -2121,6 +2121,13 @@ void free_instruction(Context *c)
> > >          g_string_free(g_array_index(c->inst.strings, GString*, =
i), TRUE);
> > >      }
> > >      g_array_free(c->inst.strings, TRUE);
> > > +    /*
> > > +     * Free list of arguments that might need initialization, if
> > > + they
> > haven't
> > > +     * already been free'd.
> > > +     */
> > > +    if (c->inst.init_list) {
> > > +        g_array_free(c->inst.init_list, TRUE);
> > > +    }
> > >      /* Free INAME token value */
> > >      g_string_free(c->inst.name, TRUE);
> > >      /* Free variables and registers */
> >
> > Why not do this in gen_inst_init_args just before this?
> >    /* Free argument init list once we have initialized everything */
> >     g_array_free(c->inst.init_list, TRUE);
> >     c->inst.init_list =3D NULL;
>=20
> Thanks for the reviews Taylor! I'm not sure I understand what you mean
> here, we already free init_list in gen_inst_init_args, since =
gen_inst_init_args
> won't be called for all instructions we need to also free from a =
common
> place.
>=20
> //Anton

It just seems more natural to free the elements of the array at the same =
place you free the array itself.  If there are valid reasons for doing =
it elsewhere, I'm OK with that.

Taylor



