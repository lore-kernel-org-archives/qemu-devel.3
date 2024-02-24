Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4020BC48BF6
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Feb 2024 06:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdlW3-0004Uu-Tp; Sat, 24 Feb 2024 01:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rdlW0-0004UP-MA
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 01:28:04 -0500
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rdlVv-0004bo-0a
 for qemu-devel@nongnu.org; Sat, 24 Feb 2024 01:28:04 -0500
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-21e95f4ed73so534312fac.0
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 22:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708756076; x=1709360876; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVUcSadwbNkCcuXYKuEblEoiQdQzY4vKOXAKwjhaqWI=;
 b=diRLD0KfOi42QO5SsC9/AgDeqBWE6ylS56eUaIuOmotEFPNLqVlyWwTPB5od9pBY0j
 Ayf2H4X+4Tp+6UUfHMU7a0/B7rUb3oqCEepqPm7mmohcN1sLTV5UuzYO0n0MxXXywdYr
 zMW72+X93dHb0Zut9JqnPTy5PwWw9qdSN4HCN/GZs2RD/ivLz/e2qk1F+YwPpvqHvfXy
 1oeFNGfQkGFbpTlyEq3hw0qTWQDdpb2EWeR/Dx06HYbr6ct6c8FvlECdETGCd6QJKETe
 lJ/LwNWwP5rMlPRGfhutGZgpKNsBAbqcD+Mygp6BrRowObxdPzIXMSqD1v2PmITGddgo
 qlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708756076; x=1709360876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZVUcSadwbNkCcuXYKuEblEoiQdQzY4vKOXAKwjhaqWI=;
 b=ksgVdvFLpjncwl+YsQKpoONc0+FKXx4KbboQaHj7oSNrA82Bl7nnAvITZSrImrad7a
 87WnqatrCUcnpEbiZ7+FsuLCKXF3kfOl4v+mF1Nqoap1yMZSIi2O6NWFXmpCYt9LeG8C
 m6rvrwfFaR6zneyKWn6HBC+OHkkz/KNZ7qi5L8Il6Pq8/7FWHWKyWIUdYX/VkVEsC8SS
 I9wKoVcpxM+6/9oTNnJcMGSTygYhYa/YnzesglEEkK/9exRGLjCLEn5bqVdMwWxjz8f4
 ziTQGjnzicUGr6O+/JaIv08Upp/AgOvD4vifobqIwHf6nNHGDkP/y7QX20gMePAAMoDe
 j0PQ==
X-Gm-Message-State: AOJu0Yzkh0fqYuNdci2vBDYXFhS/MySgKK8Ble+Ar1l+Sxour2FjMiWk
 IWpAYyO1/R5qKQRmXfwKvvMjJyXo4Os/yeGHitwexYLxJnl/XMnof4I43B9zAphOq7Hg0bn5Yel
 WxU9TR+pKmNAhQ2yj1VzDcnQRvMud59dinRCSkxzTC7S1uLadp5Eys1rLXp7UMOILGU0=
X-Google-Smtp-Source: AGHT+IHEMDRNxq3Be6eKjHBX7JpdRKBPEohiwma0OXTF9zHF+06u4RSJ7MEO+8ZCUo/BFPVKNQYtdKkxT63PdZDTrXuCJe3G65CK4nHD
X-Received: by 2002:a05:6871:7820:b0:21f:a194:2350 with SMTP id
 oy32-20020a056871782000b0021fa1942350mr2342307oac.14.1708756076312; Fri, 23
 Feb 2024 22:27:56 -0800 (PST)
MIME-Version: 1.0
References: <CAK4oD7DS0WiZcze37b8ERh50_ht=HNS3Bk8aeRmCjx_ndMG1gw@mail.gmail.com>
 <877ciwail4.fsf@draig.linaro.org>
In-Reply-To: <877ciwail4.fsf@draig.linaro.org>
From: RR NN <rnn59437@gmail.com>
Date: Sat, 24 Feb 2024 09:57:44 +0330
Message-ID: <CAK4oD7D5T2+AVcAHiCadyqvjv-BbdCBP_EXgU6t+7HDG1OMWDQ@mail.gmail.com>
Subject: Re: Support Android hypervisors
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000efbac106121ac698"
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=rnn59437@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_KAM_HTML_FONT_INVALID=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000efbac106121ac698
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=99=8F

RR reacted via Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

On Thu, Feb 22, 2024, 14:09 Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote=
:

> RR NN <rnn59437@gmail.com> writes:
>
> > Android Virtualization Framework (AVF) supports "KVM(pKVM)"
>
> Does the user-space API change for pKVM? As far as I'm aware the
> userspace API is the same.
>
> > also Qualcomm's "Gunyah"
>
> Feel free to review:
>
>
> https://patchew.org/QEMU/20240109090039.1636383-1-quic._5Fsvaddagi@quicin=
c.com/
>
> > and MediaTek's "GenieZone" as
> > the hypervisor. Please Add these hypervisors to QEMU.
>
> Generally the QEMU community hasn't the bandwidth to implement every
> requested feature so we rely on those with an interest to step forward
> and work on the code.
>
> That said it doesn't look like the kernel side of UAPI is anywhere close
> to getting merged:
>
>
> https://lore.kernel.org/lkml/20240129083302.26044-1-yi-de.wu@mediatek.com=
/
>
> I should also note that proprietary hypervisors locked to specific SoC's
> make it even more challenging for open source developers to work on it.
> I for one wouldn't want to try and get a hypervisor working if I
> couldn't see the code and get it up and running under QEMU's emulation.
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000efbac106121ac698
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=99=8F",
  "version": 1
}
--000000000000efbac106121ac698
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=99=8F<=
/p><p style=3D"margin-top:10px;margin-bottom:0">RR reacted via <a style=3D"=
color:unset;text-decoration:underline" href=3D"https://www.google.com/gmail=
/about/?utm_source=3Dgmail-in-product&amp;utm_medium=3Det&amp;utm_campaign=
=3Demojireactionemail#app">Gmail</a></p></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 22, 2024, 14:09 Alex Be=
nn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@linaro.org">alex.bennee@linaro.=
org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">RR NN &lt;<a hre=
f=3D"mailto:rnn59437@gmail.com" target=3D"_blank" rel=3D"noreferrer">rnn594=
37@gmail.com</a>&gt; writes:<br>
<br>
&gt; Android Virtualization Framework (AVF) supports &quot;KVM(pKVM)&quot;<=
br>
<br>
Does the user-space API change for pKVM? As far as I&#39;m aware the<br>
userspace API is the same.<br>
<br>
&gt; also Qualcomm&#39;s &quot;Gunyah&quot;<br>
<br>
Feel free to review:<br>
<br>
=C2=A0 <a href=3D"https://patchew.org/QEMU/20240109090039.1636383-1-quic._5=
Fsvaddagi@quicinc.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">htt=
ps://patchew.org/QEMU/20240109090039.1636383-1-quic._5Fsvaddagi@quicinc.com=
/</a><br>
<br>
&gt; and MediaTek&#39;s &quot;GenieZone&quot; as<br>
&gt; the hypervisor. Please Add these hypervisors to QEMU.<br>
<br>
Generally the QEMU community hasn&#39;t the bandwidth to implement every<br=
>
requested feature so we rely on those with an interest to step forward<br>
and work on the code.<br>
<br>
That said it doesn&#39;t look like the kernel side of UAPI is anywhere clos=
e<br>
to getting merged:<br>
<br>
=C2=A0 <a href=3D"https://lore.kernel.org/lkml/20240129083302.26044-1-yi-de=
.wu@mediatek.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://=
lore.kernel.org/lkml/20240129083302.26044-1-yi-de.wu@mediatek.com/</a><br>
<br>
I should also note that proprietary hypervisors locked to specific SoC&#39;=
s<br>
make it even more challenging for open source developers to work on it.<br>
I for one wouldn&#39;t want to try and get a hypervisor working if I<br>
couldn&#39;t see the code and get it up and running under QEMU&#39;s emulat=
ion.<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div>

--000000000000efbac106121ac698--

