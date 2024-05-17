Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00102C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 03:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7oWI-0003Z8-3R; Thu, 16 May 2024 23:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7oWG-0003Yq-EF; Thu, 16 May 2024 23:44:32 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s7oWD-0002by-IJ; Thu, 16 May 2024 23:44:32 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1ec486198b6so1366815ad.1; 
 Thu, 16 May 2024 20:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715917468; x=1716522268; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6Qmp6378Gu8u2ixR1XsK7ZRTusBeLsxKAwDsIpfXos=;
 b=Cd8R9pFwHtyh8WQy3I0ljrsNjpXBviVZJ5dzWkGdjJ1iUPNz2oWSI+u12Hk3c81nAZ
 CvaI8Mt5wfjPsSO9ynn/Bv9L0vhWn1jukjQi4f5joAv8jwwszRg1jeRMFMzEonvYJw2/
 mjVkmLgyA/F2KwaqFhOryxguK5nW/Bxr7SIjxJhN0WMi+PijynRGpdqZa5DExmMSf9bT
 0O+2xPScKEBtye930d9ZKGZ+TfST219v22l49BnVOBnrmsQB69XjAgbD//O3fH5zKUAh
 +XQffLmbVqGm8dDcjG+H/II5WVObx+AuVrZwLfd4wdDxfc734NpPJHFKf7XdME238o3V
 nHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715917468; x=1716522268;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=d6Qmp6378Gu8u2ixR1XsK7ZRTusBeLsxKAwDsIpfXos=;
 b=BZspoEgmDmzw8hfDxlhTd0etAkcgVm536L9GbM+yxOiAdWlJGjVFkRgZsc4WqTflVv
 yuC3UflGXtd7KFUKKat7CFA08Cxrow7dw31ctZ0QTv2EPdxz/Fp4RImk4pdkPBT7O4Bs
 n5QJrjnfwlmPexQG390V0yj6ZDfKSLW06w0MB+UlJ0GIvEkHpmbU3ZSI3EkHU9OgEIRC
 mks3Y3Jw7wtwO29wHpX3QbjinZd57jnZqOaHZZBZFXlLY78JEMGx1PmkjpjD5blVMuI/
 SppxU9pUU9kssRvKE/U2/5BzlVMFBBCc+oUkmoaRHeNq4zDo1M4IumTFz7ZtWdzJgmiF
 PfeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5Dws3voTs9BiUfuhQ1CY0irzoX5hvcwNNb1/n4toFWokxCwOMLQ1CNtxqThiATfY9nH/hc2bI6a//mEhroV6Q5AhY1wvw24ewurD9nb/ehEJsuSsIHckCB1A=
X-Gm-Message-State: AOJu0YzmgojjM7Uw4ImgGTxDwTgkfX50KbleBWqBzUnu3Kenqobl2HA6
 bW0qaXlPDoVw39spzJzKUGwGLCi0b4/h/PDEK72HHF0Z0mSi0gc0
X-Google-Smtp-Source: AGHT+IF3F90np45n6VEhE4Zl2OnDXpR8LUk1b2ONujf3rSvQn7jI3q0dr6tH0vlhEAtQMYpYSYlRpA==
X-Received: by 2002:a17:902:c952:b0:1f0:936a:6de with SMTP id
 d9443c01a7336-1f0936a0943mr69290585ad.58.1715917467603; 
 Thu, 16 May 2024 20:44:27 -0700 (PDT)
Received: from localhost ([1.146.118.37]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bad6386sm146845585ad.80.2024.05.16.20.44.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 May 2024 20:44:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 13:44:20 +1000
Message-Id: <D1BLZ35ZE9EI.18TYUB70KCCY7@gmail.com>
Subject: Re: [PATCH v2 1/4] accel/kvm: Extract common KVM vCPU {creation,
 parking} code
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Salil Mehta" <salil.mehta@huawei.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "danielhb413@gmail.com" <danielhb413@gmail.com>, "vaibhav@linux.ibm.com"
 <vaibhav@linux.ibm.com>, "sbhat@linux.ibm.com" <sbhat@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240516053211.145504-1-harshpb@linux.ibm.com>
 <20240516053211.145504-2-harshpb@linux.ibm.com>
 <fc08e87c979a4916aaff649724df9c6b@huawei.com>
 <bfb5888c-c66c-4000-ba12-5af202b0fe17@linux.ibm.com>
 <2e290791a92949d79fe0fdfcb972a029@huawei.com>
 <49f4d0cb-260e-45fb-a678-2dec45c9fab8@linux.ibm.com>
 <7a5608c768254869a4a6b68d719c24f1@huawei.com>
In-Reply-To: <7a5608c768254869a4a6b68d719c24f1@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Thu May 16, 2024 at 11:35 PM AEST, Salil Mehta wrote:
>
> >  From: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >  Sent: Thursday, May 16, 2024 2:07 PM
> > =20
> >  Hi Salil,
> > =20
> >  On 5/16/24 17:42, Salil Mehta wrote:
> >  > Hi Harsh,
> >  >
> >  >>   From: Harsh Prateek Bora <harshpb@linux.ibm.com>
> >  >>   Sent: Thursday, May 16, 2024 11:15 AM
> >  >>
> >  >>   Hi Salil,
> >  >>
> >  >>   Thanks for your email.
> >  >>   Your patch 1/8 is included here based on review comments on my  p=
revious
> >  >>   patch from one of the maintainers in the community and therefore =
I  had
> >  >>   kept you in CC to be aware of the desire of having this independe=
nt patch to
> >  >>   get merged earlier even if your other patches in the series may g=
o through
> >  >>   further reviews.
> >  >
> >  > I really don=E2=80=99t know which discussion are  you pointing at? P=
lease
> >  > understand you are fixing a bug and we are pushing a feature which h=
as got large series.
> >  > It will break the patch-set  which is about t be merged.
> >  >
> >  > There will be significant overhead of testing on us for the work we
> >  > have been carrying forward for large time. This will be disruptive. =
Please dont!
> >  >
> > =20
> >  I was referring to the review discussion on my prev patch here:
> >  https://lore.kernel.org/qemu-devel/D191D2JFAR7L.2EH4S445M4TGK@gmail.co=
m/
>
>
> Sure, I'm, not sure what this means.=20
>
>
> >  Although your patch was included with this series only to facilitate r=
eview of
> >  the additional patches depending on just one of your patch.
>
>
> Generally you rebase your patch-set over the other and clearly state on t=
he cover
> letter that this patch-set is dependent upon such and such patch-set. Jus=
t imagine
> if everyone starts to unilaterally pick up patches from each other's patc=
h-set it will
> create a chaos not only for the feature owners but also for the maintaine=
rs.
>
>
> > =20
> >  I am not sure what is appearing disruptive here. It is a common practi=
ve in
> >  the community that maintainer(s) can pick individual patches from the
> >  series if it has been vetted by siginificant number of reviewers.
>
>
> Don=E2=80=99t you think this patch-set is asking for acceptance for a pat=
ch already=20
> part of another patch-set which is about to be accepted and is a bigger f=
eature?
> Will it cause maintenance overhead at the last moment? Yes, of course!
>
>
> >  However, in this case, since you have mentioned to post next version s=
oon,
> >  you need not worry about it as that would be the preferred version for=
 both
> >  of the series.
>
>
> Yes, but please understand we are working for the benefit of overall comm=
unity.
> Please cooperate here.

There might be a misunderstanding, Harsh just said there had not been
much progress on your series for a while and he wasn't sure what the
status was. I mentioned that we *could* take your patch 1 (with your
blessing) if there was a hold up with the rest of the series. He was
going to check in with you to see how it was going.

This patch 1 was not intended to be merged as is without syncing up with
you first, but it's understandable you were concerned because that was
probably not communicated with you clearly.

I appreciate you bringing up your concerns, we'll try to do better.

Thanks,
Nick

