Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C461C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 16:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBGR-0004Th-TF; Mon, 04 Mar 2024 11:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rhBGP-0004TV-E3
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:34:05 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rhBGO-0004Hu-0f
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 11:34:05 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so4122397a12.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709570042; x=1710174842; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X4BWV3LLWweVMGGezJU4P4CxZ4Dvs4NyrCZ+++DgLek=;
 b=Ybz1OCm4bEp3cSVMvGtF3ZwwKNM83DiNIwP/XD11Acj2r1MLKIzDVwqvxW5kQ3RB/s
 uDxcwlPC7QZKF6eGaDteTsU0wR1Evdld/Htsv/8xS9qsg+JUOD4B5kFOZAErHeHeFOMV
 8WlhjrnkEKR92vLCeU++YjvjcUcPqAkEyvgnUb+04X1SmVLhFoGDoxmVlcEALauSczPu
 DjVN4aBHjt9QvUD7VCSMax3bCr4mCtZNgAajAl7UBlHorJsaYE1FwYnwCg4pXytoFtfA
 G/CUpGATZYHxRsEOxy9WMcwFDL4sPcgfXijkJP70ONxqMWY5WAW+foRoiRREVJu/AVTR
 g5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709570042; x=1710174842;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X4BWV3LLWweVMGGezJU4P4CxZ4Dvs4NyrCZ+++DgLek=;
 b=IDEuUlR4bmVW8+VymNBtLvUoCiwsw4puk13fAyvD801ghCWNv3Aos9UKd21JlXlN8e
 q31qj1+Auy6JDLlgI3AJI0HYFY2Ni6+SZdXrMQBtCX9SabTen8hkFuQqmonylI80YDTg
 ZdRLAdYLePnK+niotDrWw3CyQszmigh53hUbh/HqBe8VNG/BQC7Q5JSa/ylHxQwNApVk
 Mf3JNhPM2OKqatDKl3E5UPtlpCaI99jxN4NelJBN9hDZlXvpNo25N6t9PElFiLAODJP2
 bF5Qkd81vxNLaItWIaURb7tajAikuWPENKZ5y+4dFAU7XiKBNVD1niEPNloCmRoAT07b
 u/Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV87p6lzc3TEu2WdcXfK/wnLkCJW3h7Kc+B3eQd9/obcrXHHsDppe8cmSajz0DIAjuOMP72y5z0ffO7lNOQRO/2kqVbnQY=
X-Gm-Message-State: AOJu0Yxz6+XUvbw+Y8zJcm9jVnYE5dbeRH/KADBrnRORS2YaQumad8+f
 VfP2XIKzxcixuHPz+NHf6nCu40UUTs097aOoCzCktz91PTYEIhQZ
X-Google-Smtp-Source: AGHT+IGKx1zUgiEOpaeuxseXwwc9YIlUDtpKrkhWzXQSC61SexxtrpQlfGK5HZIIxm9ajnsKFHcHtQ==
X-Received: by 2002:a17:90a:f007:b0:29b:1c83:4e06 with SMTP id
 bt7-20020a17090af00700b0029b1c834e06mr6706551pjb.36.1709570041133; 
 Mon, 04 Mar 2024 08:34:01 -0800 (PST)
Received: from localhost (220-235-220-130.tpgi.com.au. [220.235.220.130])
 by smtp.gmail.com with ESMTPSA id
 st3-20020a17090b1fc300b00299ef19177dsm10351172pjb.8.2024.03.04.08.33.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 08:34:00 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 02:33:52 +1000
Message-Id: <CZL3ZYYZELI4.2S658P3W949GV@wheely>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, "John Snow" <jsnow@redhat.com>,
 "Cleber Rosa" <crosa@redhat.com>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Wainer dos Santos Moschetta" <wainersm@redhat.com>,
 "Beraldo Leal" <bleal@redhat.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 4/4] replay: simple auto-snapshot mode for record
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>
X-Mailer: aerc 0.15.2
References: <20230814163135.187882-1-npiggin@gmail.com>
 <20230814163135.187882-5-npiggin@gmail.com>
 <95adc4ea-225c-bcd5-cec2-9edf1c2cf496@ispras.ru>
 <CZEU6LST3QJK.25NCID08671V5@wheely>
 <b212b1a1-eca9-40ae-992b-ff24f41844e3@ispras.ru>
In-Reply-To: <b212b1a1-eca9-40ae-992b-ff24f41844e3@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Wed Feb 28, 2024 at 3:07 PM AEST, Pavel Dovgalyuk wrote:
> On 26.02.2024 10:36, Nicholas Piggin wrote:
> >>> @@ -313,6 +317,27 @@ void replay_configure(QemuOpts *opts)
> >>>        }
> >>>   =20
> >>>        replay_snapshot =3D g_strdup(qemu_opt_get(opts, "rrsnapshot"))=
;
> >>> +    if (replay_snapshot && mode =3D=3D REPLAY_MODE_RECORD) {
> >>
> >> Can such a snapshotting may be useful in replay mode?
> >=20
> > Does snapshotting do anything in replay mode?=20
>
> Yes, you can create as many snapshots as you want if 'snapshot=3Don'
> option of the disk image was not used.

Actually something goes wrong and the machine crashes when I try
this, so it's not so simple. It's a nice idea to be able to do
because it really makes reverse debugging much faster, but no time
to look into it further at the moment.

So I will resubmit basically as is, which works for me nicely.
Tweaks can be made or other timer behaviour can be added later,
it's not a hard API with precisely defined semantics. So it would
be nice to get the basic mechanisms merged and tests added.

Thanks,
Nick

