Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38086C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 13:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh87b-0003Zm-UL; Thu, 22 Aug 2024 09:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sh87U-0003YX-5a; Thu, 22 Aug 2024 09:44:56 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nabiev.arman13@gmail.com>)
 id 1sh87R-0001Bz-KC; Thu, 22 Aug 2024 09:44:55 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2f3ea86377aso8334731fa.1; 
 Thu, 22 Aug 2024 06:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724334290; x=1724939090; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AbXnxlj89v02fdEr014Euu9KJE2QPfERPxGOb++mQN4=;
 b=LY0TZvc3YHq0d28ZGr1ftTV0J8Z6SP+3FuIApcXuC+1kT81vikh93JQxaW4RwwYYOv
 VZRG7OCOkkzkB6wBQ50Z44+EU4f9onwOOyKG8MfWRRnai3pGP1LdTgJcqbOKZkNH4yQF
 LDYCP8LXjKNuHucone6TJKe0jrHKpee38c7NB1BhRZrf8AcKA50ReHw64J715CM68fY6
 ewk+dL889aN75PJmCHDVD0V8hDBQSfym8yTorqDtjXxRc578EHyMD15QTQ4F7hWllAv9
 OkXDG+Bj+TD9i0na4BfA0D+JzzPH4D+beHc0n3vy5BABm9f/8pxD1J661Mt0o4xXPWBQ
 zRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724334290; x=1724939090;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AbXnxlj89v02fdEr014Euu9KJE2QPfERPxGOb++mQN4=;
 b=FBKsBOB6WTMZuiT5kL9ApirSUkCoIr27trwFsK/bt6+xqqLIZts2O+ZLkG4OOYrbiY
 qybUpCoouRNTskfv2cXWnXB2bJtuUpXFqRDbuiwyEkhrd5goaLUz1iZ0l/8wTqgcj02J
 MZYdhijkCsIj7VxKKiASRZhLgBUtTQ2Vjvv7Ca7wK5v3s4DffL5y9sczergaV9lzRmbh
 1JL4xMc0Td7JjWzL7aNulDe4FDbZofTI4CzAxlIZs3e64kYFlpdLWtQsq0lFS2gw070V
 BDRzV0TUudmRPf5TQTknVsvK082TtrBin4PF2nHf8Sd1Izbx3KyFhb+jJh40bGyb3zIZ
 M4fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VbxdRyyYR9m2U7lOBDJTnzoRL1CUshLVZillgxBEpo2fScflEfLfexT1n0NuH/WIcPE9HlD8FQ==@nongnu.org
X-Gm-Message-State: AOJu0YzK0D9MebpTa0Is2+oeXy3swfx0XT2fST+WHs9hHDdGZ8OvttX2
 C/LAOiO2QGo+vaC6DKh63QPLrA7Ex7xP1bjZkdBB20xmTrkuIGL/gWndixJ9rCkiWTPgb//peYm
 l0eF2aHXeztoDMtxljb7EHhw9pM0=
X-Google-Smtp-Source: AGHT+IGtA3ebTOE/97+VJMJV3SQ3+q4xycruDNcJ0csMM62mHPbb40mNCmZXN08jSHujtRFC6Zp+hcSARpzHVuiK+z8=
X-Received: by 2002:a05:6512:2212:b0:530:ae22:a6ea with SMTP id
 2adb3069b0e04-533485dbd9cmr3217314e87.40.1724334290042; Thu, 22 Aug 2024
 06:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240820145514.63046-1-nabiev.arman13@gmail.com>
 <CAFEAcA8WPfynQyjB1_S5z=OA6k-xhxr7DNOZBR0mC9gtD-mCnA@mail.gmail.com>
 <CAGMt57c=Nv2Teu_=cqteCGs1yjPWQT7vfUs42hFL+MCZjbJEeQ@mail.gmail.com>
 <CAFEAcA_wpbEaX+iEz7syNd1tB7A77UVT75vzups=yZogJmiEaQ@mail.gmail.com>
 <CAGMt57d7f1WwfvoCoOtFSEDm8eqMZAEP17DsZuo09dLi0j-A9w@mail.gmail.com>
 <CAFEAcA-Tp8v-DTOBVfyJApb8-Wv=RuO_Qda1zHN9-jSgVW7g0A@mail.gmail.com>
 <CAFEAcA-c1yUa3W_bTQ4f8zESrdyFggCYrieEjrvEdYV-wMwavg@mail.gmail.com>
In-Reply-To: <CAFEAcA-c1yUa3W_bTQ4f8zESrdyFggCYrieEjrvEdYV-wMwavg@mail.gmail.com>
From: Arman Nabiev <nabiev.arman13@gmail.com>
Date: Thu, 22 Aug 2024 16:44:38 +0300
Message-ID: <CAGMt57f5+hvdvyyzec=UFr1D=6NB7s08p-xRibFPGXv6iH8tEw@mail.gmail.com>
Subject: Re: [PATCH] ppc: fixed incorrect name filed in vmstate_tlbemb_entry
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: multipart/mixed; boundary="000000000000d534db062045dc09"
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=nabiev.arman13@gmail.com; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000d534db062045dc09
Content-Type: multipart/alternative; boundary="000000000000d534d7062045dc07"

--000000000000d534d7062045dc07
Content-Type: text/plain; charset="UTF-8"

Thank you.
Do I need to resend the patch with the specified corrections, or will you
do it and all I need is the name in signed-off? In the second case, you
need to specify Arman Nabiev. Just in case I'll attach the fixed patch here.

On Thu, 22 Aug 2024 at 16:12, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Wed, 21 Aug 2024 at 20:33, Peter Maydell <peter.maydell@linaro.org>
> wrote:
> >
> > On Wed, 21 Aug 2024 at 19:56, Arman Nabiev <nabiev.arman13@gmail.com>
> wrote:
> > >
> > > In my example in https://gitlab.com/qemu-project/qemu/-/issues/2522
> the .needed function returns true for vmstate_tlbemb, but not for
> vmstate_tlb6xx. I tried to do some tests without fixing the typo. When I
> changed the .fields in the two structures to the same value so that the
> size of the data they stored matched, everything worked. I also changed the
> order of vmstate_tlb6xx and vmstate_tlbemb in the subsections field of
> vmstate_ppc_cpu, everything worked as well.
> > > According to
> https://www.qemu.org/docs/master/devel/migration/main.html#:~:text=On%20the%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send%20the%20subsection
> and on my own tests I think the problem is that when reading saved data,
> qemu uses the device name to determine an object that extracts a certain
> size of data. Since the names are the same for vmstate_tlb6xx and
> vmstate_tlbemb, it uses the functions for the first one due to a certain
> order, which leads to an error, since the data from the second one was
> saved.
> >
> > Aha, yes, that would explain it -- the PPC CPU has both
> > subsections in its subsection list, but they have the
> > same name, so we pick the wrong one when we see the
> > name in the incoming data.
> >
> > In that case we can take this fix without worrying
> > about a migration compat break, because clearly
> > migration has never worked for this CPU type...
>
> I did a quick test and indeed migration doesn't work, not
> just record-and-replay:
>
> $ ./build/ppc/qemu-system-ppc -drive
> if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
> -monitor stdio -M bamboo
> QEMU 9.0.92 monitor - type 'help' for more information
> (qemu) savevm foo
> (qemu) loadvm foo
> Missing section footer for cpu
> Error: Error -22 while loading VM state
>
> So I'm happy that this patch is the right fix, and
> it can have my
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> provided that we fix a couple of things in the commit message:
>
> (1) For QEMU, Signed-off-by lines should generally be your
> full name, not a pseudonym (as I assume "armanincredible" is).
>
> (2) We should give in the commit message details of
> what has been fixed and also a Resolves: line for the
> gitlab issue, something like:
>
> ===begin==
> target/ppc: Fix migration of CPUs with TLB_EMB TLB type
>
> In vmstate_tlbemb a cut-and-paste error meant we gave
> this vmstate subsection the same "cpu/tlb6xx" name as
> the vmstate_tlb6xx subsection. This breaks migration load
> for any CPU using the TLB_EMB CPU type, because when we
> see the "tlb6xx" name in the incoming data we try to
> interpret it as a vmstate_tlb6xx subsection, which it
> isn't the right format for:
>
>  $ qemu-system-ppc -drive
> if=none,format=qcow2,file=/home/petmay01/test-images/virt/dummy.qcow2
> -monitor stdio -M bamboo
>  QEMU 9.0.92 monitor - type 'help' for more information
>  (qemu) savevm foo
>  (qemu) loadvm foo
>  Missing section footer for cpu
>  Error: Error -22 while loading VM state
>
> Correct the incorrect vmstate section name. Since migration
> for these CPU types was completely broken before, we don't
> need to care that this is a migration compatibility break.
>
> This affects the PPC 405, 440, 460 and e200 CPU families.
>
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2522
> Signed-off-by: [your name here] <nabiev.arman13@gmail.com>
> ===endit===
>
> thanks
> -- PMM
>

--000000000000d534d7062045dc07
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thank you. <br>Do I need to resend the patch with the spec=
ified corrections, or will you do it and all I need is the name in signed-o=
ff? In the second case, you need to specify Arman Nabiev.=C2=A0Just in case=
 I&#39;ll attach the fixed patch here.<br></div><br><div class=3D"gmail_quo=
te"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 22 Aug 2024 at 16:12, Pet=
er Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.maydell@li=
naro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">On Wed, 21 Aug 2024 at 20:33, Peter Maydell &lt;<a href=3D"mailto:p=
eter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;=
 wrote:<br>
&gt;<br>
&gt; On Wed, 21 Aug 2024 at 19:56, Arman Nabiev &lt;<a href=3D"mailto:nabie=
v.arman13@gmail.com" target=3D"_blank">nabiev.arman13@gmail.com</a>&gt; wro=
te:<br>
&gt; &gt;<br>
&gt; &gt; In my example in <a href=3D"https://gitlab.com/qemu-project/qemu/=
-/issues/2522" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu=
-project/qemu/-/issues/2522</a> the .needed function returns true for vmsta=
te_tlbemb, but not for vmstate_tlb6xx. I tried to do some tests without fix=
ing the typo. When I changed the .fields in the two structures to the same =
value so that the size of the data they stored matched, everything worked. =
I also changed the order of vmstate_tlb6xx and vmstate_tlbemb in the subsec=
tions field of vmstate_ppc_cpu, everything worked as well.<br>
&gt; &gt; According to <a href=3D"https://www.qemu.org/docs/master/devel/mi=
gration/main.html#:~:text=3DOn%20the%20receiving%20side%2C%20if,that%20didn=
%E2%80%99t%20send%20the%20subsection" rel=3D"noreferrer" target=3D"_blank">=
https://www.qemu.org/docs/master/devel/migration/main.html#:~:text=3DOn%20t=
he%20receiving%20side%2C%20if,that%20didn%E2%80%99t%20send%20the%20subsecti=
on</a> and on my own tests I think the problem is that when reading saved d=
ata, qemu uses the device name to determine an object that extracts a certa=
in size of data. Since the names are the same for vmstate_tlb6xx and vmstat=
e_tlbemb, it uses the functions for the first one due to a certain order, w=
hich leads to an error, since the data from the second one was saved.<br>
&gt;<br>
&gt; Aha, yes, that would explain it -- the PPC CPU has both<br>
&gt; subsections in its subsection list, but they have the<br>
&gt; same name, so we pick the wrong one when we see the<br>
&gt; name in the incoming data.<br>
&gt;<br>
&gt; In that case we can take this fix without worrying<br>
&gt; about a migration compat break, because clearly<br>
&gt; migration has never worked for this CPU type...<br>
<br>
I did a quick test and indeed migration doesn&#39;t work, not<br>
just record-and-replay:<br>
<br>
$ ./build/ppc/qemu-system-ppc -drive<br>
if=3Dnone,format=3Dqcow2,file=3D/home/petmay01/test-images/virt/dummy.qcow2=
<br>
-monitor stdio -M bamboo<br>
QEMU 9.0.92 monitor - type &#39;help&#39; for more information<br>
(qemu) savevm foo<br>
(qemu) loadvm foo<br>
Missing section footer for cpu<br>
Error: Error -22 while loading VM state<br>
<br>
So I&#39;m happy that this patch is the right fix, and<br>
it can have my<br>
<br>
Reviewed-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" =
target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
provided that we fix a couple of things in the commit message:<br>
<br>
(1) For QEMU, Signed-off-by lines should generally be your<br>
full name, not a pseudonym (as I assume &quot;armanincredible&quot; is).<br=
>
<br>
(2) We should give in the commit message details of<br>
what has been fixed and also a Resolves: line for the<br>
gitlab issue, something like:<br>
<br>
=3D=3D=3Dbegin=3D=3D<br>
target/ppc: Fix migration of CPUs with TLB_EMB TLB type<br>
<br>
In vmstate_tlbemb a cut-and-paste error meant we gave<br>
this vmstate subsection the same &quot;cpu/tlb6xx&quot; name as<br>
the vmstate_tlb6xx subsection. This breaks migration load<br>
for any CPU using the TLB_EMB CPU type, because when we<br>
see the &quot;tlb6xx&quot; name in the incoming data we try to<br>
interpret it as a vmstate_tlb6xx subsection, which it<br>
isn&#39;t the right format for:<br>
<br>
=C2=A0$ qemu-system-ppc -drive<br>
if=3Dnone,format=3Dqcow2,file=3D/home/petmay01/test-images/virt/dummy.qcow2=
<br>
-monitor stdio -M bamboo<br>
=C2=A0QEMU 9.0.92 monitor - type &#39;help&#39; for more information<br>
=C2=A0(qemu) savevm foo<br>
=C2=A0(qemu) loadvm foo<br>
=C2=A0Missing section footer for cpu<br>
=C2=A0Error: Error -22 while loading VM state<br>
<br>
Correct the incorrect vmstate section name. Since migration<br>
for these CPU types was completely broken before, we don&#39;t<br>
need to care that this is a migration compatibility break.<br>
<br>
This affects the PPC 405, 440, 460 and e200 CPU families.<br>
<br>
Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-stable=
@nongnu.org</a><br>
Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/issues/2522" re=
l=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qemu/-/i=
ssues/2522</a><br>
Signed-off-by: [your name here] &lt;<a href=3D"mailto:nabiev.arman13@gmail.=
com" target=3D"_blank">nabiev.arman13@gmail.com</a>&gt;<br>
=3D=3D=3Dendit=3D=3D=3D<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>

--000000000000d534d7062045dc07--

--000000000000d534db062045dc09
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-target-ppc-Fix-migration-of-CPUs-with-TLB_EMB-TLB-ty.patch"
Content-Disposition: attachment; 
	filename="0001-target-ppc-Fix-migration-of-CPUs-with-TLB_EMB-TLB-ty.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m05c3p4r0>
X-Attachment-Id: f_m05c3p4r0

RnJvbSAxZmYzMDA2YjU4MTQzOThmMTZlOGFkNDczNGZiYWMyZTEwMDI2MzAzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBhcm1hbmluY3JlZGlibGUgPG5hYmlldi5hcm1hbjEzQGdtYWls
LmNvbT4KRGF0ZTogVGh1LCAyMiBBdWcgMjAyNCAxNjoyOTozMyArMDMwMApTdWJqZWN0OiBbUEFU
Q0hdIHRhcmdldC9wcGM6IEZpeCBtaWdyYXRpb24gb2YgQ1BVcyB3aXRoIFRMQl9FTUIgVExCIHR5
cGUKCkluIHZtc3RhdGVfdGxiZW1iIGEgY3V0LWFuZC1wYXN0ZSBlcnJvciBtZWFudCB3ZSBnYXZl
CnRoaXMgdm1zdGF0ZSBzdWJzZWN0aW9uIHRoZSBzYW1lICJjcHUvdGxiNnh4IiBuYW1lIGFzCnRo
ZSB2bXN0YXRlX3RsYjZ4eCBzdWJzZWN0aW9uLiBUaGlzIGJyZWFrcyBtaWdyYXRpb24gbG9hZApm
b3IgYW55IENQVSB1c2luZyB0aGUgVExCX0VNQiBDUFUgdHlwZSwgYmVjYXVzZSB3aGVuIHdlCnNl
ZSB0aGUgInRsYjZ4eCIgbmFtZSBpbiB0aGUgaW5jb21pbmcgZGF0YSB3ZSB0cnkgdG8KaW50ZXJw
cmV0IGl0IGFzIGEgdm1zdGF0ZV90bGI2eHggc3Vic2VjdGlvbiwgd2hpY2ggaXQKaXNuJ3QgdGhl
IHJpZ2h0IGZvcm1hdCBmb3I6CgogJCBxZW11LXN5c3RlbS1wcGMgLWRyaXZlCmlmPW5vbmUsZm9y
bWF0PXFjb3cyLGZpbGU9L2hvbWUvcGV0bWF5MDEvdGVzdC1pbWFnZXMvdmlydC9kdW1teS5xY293
MgotbW9uaXRvciBzdGRpbyAtTSBiYW1ib28KIFFFTVUgOS4wLjkyIG1vbml0b3IgLSB0eXBlICdo
ZWxwJyBmb3IgbW9yZSBpbmZvcm1hdGlvbgogKHFlbXUpIHNhdmV2bSBmb28KIChxZW11KSBsb2Fk
dm0gZm9vCiBNaXNzaW5nIHNlY3Rpb24gZm9vdGVyIGZvciBjcHUKIEVycm9yOiBFcnJvciAtMjIg
d2hpbGUgbG9hZGluZyBWTSBzdGF0ZQoKQ29ycmVjdCB0aGUgaW5jb3JyZWN0IHZtc3RhdGUgc2Vj
dGlvbiBuYW1lLiBTaW5jZSBtaWdyYXRpb24KZm9yIHRoZXNlIENQVSB0eXBlcyB3YXMgY29tcGxl
dGVseSBicm9rZW4gYmVmb3JlLCB3ZSBkb24ndApuZWVkIHRvIGNhcmUgdGhhdCB0aGlzIGlzIGEg
bWlncmF0aW9uIGNvbXBhdGliaWxpdHkgYnJlYWsuCgpDYzogcWVtdS1zdGFibGVAbm9uZ251Lm9y
ZwpSZXZpZXdlZC1ieTogUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPgpS
ZXNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzI1
MjIKU2lnbmVkLW9mZi1ieTogQXJtYW4gTmFiaWV2IDxuYWJpZXYuYXJtYW4xM0BnbWFpbC5jb20+
Ci0tLQogdGFyZ2V0L3BwYy9tYWNoaW5lLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvcHBjL21hY2hpbmUu
YyBiL3RhcmdldC9wcGMvbWFjaGluZS5jCmluZGV4IDczMWRkOGRmMzUuLmQ0MzNmZDQ1ZmMgMTAw
NjQ0Ci0tLSBhL3RhcmdldC9wcGMvbWFjaGluZS5jCisrKyBiL3RhcmdldC9wcGMvbWFjaGluZS5j
CkBAIC02MjEsNyArNjIxLDcgQEAgc3RhdGljIGJvb2wgdGxiZW1iX25lZWRlZCh2b2lkICpvcGFx
dWUpCiB9CiAKIHN0YXRpYyBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV90bGJlbWIg
PSB7Ci0gICAgLm5hbWUgPSAiY3B1L3RsYjZ4eCIsCisgICAgLm5hbWUgPSAiY3B1L3RsYmVtYiIs
CiAgICAgLnZlcnNpb25faWQgPSAxLAogICAgIC5taW5pbXVtX3ZlcnNpb25faWQgPSAxLAogICAg
IC5uZWVkZWQgPSB0bGJlbWJfbmVlZGVkLAotLSAKMi4zNC4xCgo=
--000000000000d534db062045dc09--

