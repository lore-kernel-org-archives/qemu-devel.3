Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92F5C021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tie9R-0002O6-UE; Thu, 13 Feb 2025 13:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atharvd440@gmail.com>)
 id 1tie9Q-0002Ng-Dr; Thu, 13 Feb 2025 13:41:28 -0500
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atharvd440@gmail.com>)
 id 1tie9O-0002PB-Rm; Thu, 13 Feb 2025 13:41:28 -0500
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2b89395a3efso633769fac.2; 
 Thu, 13 Feb 2025 10:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739472085; x=1740076885; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=veGDzPCf0A1jw3PyF+AxYv4rMg+66t7jGc7wC2IlyVQ=;
 b=H4KTGFnPeUm/DvOirigAAoBPKA3HYpXsetUxMtsF9gTLfpz6jTKjfKEPSzVrtzc40Z
 V7uBaLz+79H2z9xPnzEX/YsjNwC2PoxQ3b8bPwFhR3LRUMT8lIFrVz7//EDSByinAOBj
 S77wLYjBxeTi5h5Q4AxVGOhAdxyN/0sRmqedZsp2+P//67qRTMgoy1ziqt+qWfytw9sP
 k25cfo2S383XfbcffcBIALpJwE1m4Q2EfWKIy1UYy6CImZxDo89OIShHs1UvSAxwKnVx
 wCPZ0PQcbiXqzPt+mGZJhK3wz5xjZKsgqdwbJOYV0/7+E8c3RIjDbjZJX/hA5nr72ZZF
 cmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739472085; x=1740076885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=veGDzPCf0A1jw3PyF+AxYv4rMg+66t7jGc7wC2IlyVQ=;
 b=jIO1j+BWVjWtL98VOI2BOznb0q8PmUCVEXTdjYmHxndUPwjc6vUuv+p//+U9NmE88L
 JojG64qr4PRNv8GArlXoo2E3Y4KP28h6gD4ZJ4yqBIW8KLxt5KzUZQjZPs2po30nmSe4
 5+6J+Wu31odXfUzmQQTUoLoK1XxI5uXRnAu/lfiZ7Dw/Gz6mnN1ioRFNK/f0ZOHnvakJ
 sSY0IUEm16ikO1NuMub9u5b6kRAAliE82pwlQ4GmJ9Vwt4q3fZ4aZI7n4vwj8dkfmrR5
 bNKhH5T0lAm5qqwHcOV7shifRJrknLXh77tXdnxfnviNYegdptqeVO0JC8GTJyWUtyWi
 Fuxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXM9X+fBEccTYAZWXXYFK276SnYqL8YCV+/CyoROrhwRm1VbcltpkLXjI8gYDcOnCXJqnyUjDov/Q==@nongnu.org
X-Gm-Message-State: AOJu0YyXaUuQ+A67BYPzUUifNJ5S/ifQWbZlFVQc7iIAbZzrwf1yij8p
 9/3SSwja+cDXSxna9IH8EI5EsVnaHiHkFzx4En/38YYn1l/bZ9KxMOpmaergGt19glDe+5PsDhe
 69PYXUrvH4WPJDifjeiN6J9xf6pA=
X-Gm-Gg: ASbGncv7eIn1IoR/Vgh08kkEkZgJqIWAWJnVDWuAKwlv8ytRo+18Bx2z6kEOzkmVMJx
 XLcWZJNJgd3KF0mUQnsRN/X45W8E1Mlpn2VkZDlLY+P4+cuV3q3Q36t+8MlkPTBhuDynTPpTClx
 s=
X-Google-Smtp-Source: AGHT+IGo/Gb1ISWqTTxwOE2ZQ6XvGgJWqsTfNd94XYSe2KYxf7pwqHrqKAPbWjbyXO95VHlqISts8WA0qICXyFiuyCM=
X-Received: by 2002:a05:6870:1642:b0:29e:32f2:cd4d with SMTP id
 586e51a60fabf-2b8d6448834mr5360406fac.2.1739472085116; Thu, 13 Feb 2025
 10:41:25 -0800 (PST)
MIME-Version: 1.0
References: <CAKTQj-53s_n=7qdm5eV8vrCLR-AKHBpq1pqCewNKPmyYtHVZJw@mail.gmail.com>
 <ec9c9ae7-e14d-41d3-a7be-559dd21f5478@redhat.com>
In-Reply-To: <ec9c9ae7-e14d-41d3-a7be-559dd21f5478@redhat.com>
From: Atharv Dubey <atharvd440@gmail.com>
Date: Fri, 14 Feb 2025 00:11:13 +0530
X-Gm-Features: AWEUYZlCh9dOd38tLWfLQKAs9G7IaA_vWwnNibfGTZPk3A7jnS4zAq64rMq4kiQ
Message-ID: <CAKTQj-44s2wbF0PFkkncndAvO-ToFUkcmy7QzWxA0iHyZo+Mpg@mail.gmail.com>
Subject: Re: Question Regarding the PowerPC arch Support
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000baecd5062e0a67eb"
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=atharvd440@gmail.com; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000baecd5062e0a67eb
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Feb, 2025, 00:05 Thomas Huth, <thuth@redhat.com> wrote:

> On 13/02/2025 19.18, Atharv Dubey wrote:
> > Hello,
> >
> > I am new user to qemu and wanted to ask if qemu supports AHCI mode in
> > PowerPC emulation.
>
>   Hi,
>
> it seems like the "powernv" machine of qemu-system-ppc64 supports AHCI,
> but
> I don't have a clue how to use it. So let's put qemu-ppc@nongnu.org in
> CC:,
> the PPC experts should be there, maybe someone on that list can answer
> this
> question.
>
>   Thomas
>
>
>
>

--000000000000baecd5062e0a67eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"></div><br><div class=3D"gmail_quote gmail_quote_container=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 14 Feb, 2025, 00:05 Thomas =
Huth, &lt;<a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">On 13/02/2025 19.18, Atharv Dube=
y wrote:<br>
&gt; Hello,<br>
&gt; <br>
&gt; I am new user to qemu and wanted to ask if qemu supports AHCI mode in =
<br>
&gt; PowerPC emulation.<br>
<br>
=C2=A0 Hi,<br>
<br>
it seems like the &quot;powernv&quot; machine of qemu-system-ppc64 supports=
 AHCI, but <br>
I don&#39;t have a clue how to use it. So let&#39;s put <a href=3D"mailto:q=
emu-ppc@nongnu.org" target=3D"_blank" rel=3D"noreferrer">qemu-ppc@nongnu.or=
g</a> in CC:, <br>
the PPC experts should be there, maybe someone on that list can answer this=
 <br>
question.<br>
<br>
=C2=A0 Thomas<br>
<br>
<br>
<br>
</blockquote></div>

--000000000000baecd5062e0a67eb--

