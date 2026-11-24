Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E7A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LWGZcJpx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVoPq-0005Lh-3M; Tue, 24 Nov 2026 06:10:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVoPo-0005Gr-Dw
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:10:24 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xVoPm-0004WV-G8
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:10:24 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4bb9d8e8e90so14707515e9.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 03:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795518621; x=1796123421; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4VBxkvLitImMl9S/0/czo+ASWIU9YXrww43npPlxCwI=;
 b=LWGZcJpxmNn2mYponWoTMFY5zMsgRyfzU7jk2D/Mzt1C1+c+9YjYt6a+WIHVC7oSf2
 qruuTXoaGwl6JHGIJn2dhf2sndIA9P2mc0uKUrnmvCKgU/GkhqTrKueJxA3pH9dj+Gsk
 A9TpdL29UKwuOVZtICp2LflJnjnO0wVCL8V70HYei7kSVbaMgxWLEU8DTjTF92KeypMg
 0CSFeGt3/Fns8WSXPkLHpblhfzM/SHt7ZuosicK7e6Z3vXEsDDRWfB7Yhj8VHhyBFazo
 CKCmVlDF336OvWHPkOtlInmYbBWLdOwurXG6qO+rJYj3Wbvvf4KmDzM7/UBmhX567al5
 Fu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795518621; x=1796123421;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4VBxkvLitImMl9S/0/czo+ASWIU9YXrww43npPlxCwI=;
 b=mVfzCLKIIyGZNg7gLy4oUyJ6SmPrPwmM3DfOC9dcgBHHxyJrpa3pI9Pq4690Slwlf7
 a9niRTIpoVQpgzATRhyqN5ScDGLqVJ+GkFTQoIgZh5uIXW00V1eK8KEGR5w2dWD4y5dG
 8dr9KPwfcg2aTYJt4bti7qc3iViFcVGqMa+Fsb4sWFF/0y7D4mqH3jFTZr2RDpifMIxV
 2Mh4iBPiWBIG+1Atc+C5HCdyyvWlOA89LOKKFwNGOGxFjqyC0V0wuYlwsTmDbzP7xsvJ
 Vm97+A0MsOqd5pW+mDvsAiJtUoBehJ1K07XMytjJM3oXXgYfqdoaFrcElTZh9l0sU9d7
 URag==
X-Forwarded-Encrypted: i=1;
 AL+hErFVhDK8Q8vKnlvK1G7AfuXm5HmeU4oYqtF16r49sbeELSZKX5YSwTMeZkU5kDCFnMh1w2wTYeSoZy8p@nongnu.org
X-Gm-Message-State: APuU4Z8EUz2YkZTJ3EUEuD9wqNkl8D3Z9dgoRTGCQG4l9j1tbuYV1gPS
 cErkuATU/T0UXtTWx/oeeL54aKAs6gyZj5sCaL3r68qJunmkKEPhO0KmWQYU3b2xg2w=
X-Gm-Gg: AZFdTZe4iAeluCMPneFWkVObWwL4Bda+ECLKwWnb2Pqjji0kn7yLy5NZGRF261A1Lp0
 knRYkUISG3XaMzJADmySbMTEmvTqZ711J7HpRTqNQ9N87vCR9qtgN8aU3pg74flnYMB4bwxI71Z
 kc21lpwsj+owRlUgll6m3+KQ9pGXIJwC/GXBeq3eNkDnvc7hh6vE4+O93bGi/5/Ou3MsDz1MwSE
 wMzZlMzvvrrhmudh2W8pp6deqJAu77P+mr1C4DHJi53gNoonlRiiN/8aG/znJz8pQ7Mh3cZb8ff
 heFArijyhJk4b/a5z6nncwdz1hcBYhwwLlcxufg4ymeResaPd62MoCO9yEFe8lN85r15Ij+EnPa
 51lu+3cDfoz0bBe0bMaumw5SSsFK/zk9EMNO3hFNLr9w7jiyHqs1KVaUhj2ZX/O61jEbbZ5XPtp
 nlMc5Mv5EgQxTEn0yMq+walsrIpYFPTTZ0mwVuTpSRhOixL3Bo9rXum0f9+W97C4LU8xj4O2tuP
 qnFsINCcpRos8jolBr8x+RU8jBYQcubd1kic/q23sz6Roo2m680dzHusuN5N7siZAjzPwYSwrMo
 tol/rvs7FrwyV0Iaxo7C81fcAgsCFZysqU2gNrHWFX8dz1YljA==
X-Received: by 2002:a05:600c:4e16:b0:4bb:69b2:d3df with SMTP id
 5b1f17b1804b1-4bb88813024mr296816935e9.25.1795518620684; 
 Tue, 24 Nov 2026 03:10:20 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884ab091sm613580705e9.11.2026.11.24.03.10.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:10:20 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD5C35F7E4;
 Tue, 24 Nov 2026 11:10:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Markus Armbruster
 <armbru@pond.sub.org>,  Utkarsh Verma <uverma@linux.ibm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,  qemu-ppc@nongnu.org,
 =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>,  Harsh Prateek
 Bora <harshpb@linux.ibm.com>,  Thomas Huth <huth@tuxfamily.org>,  Laurent
 Vivier <laurent@vivier.eu>,  Aurelien Jarno <aurelien@aurel32.net>,  Helge
 Deller <deller@gmx.de>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 BALATON Zoltan <balaton@eik.bme.hu>,  Chinmay Rath <rathc@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PReP] Maintainer status check for PReP machine
In-Reply-To: <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
 ("Philippe =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 24 Nov 2026
 11:37:02 +0100")
References: <250f899a-51c0-4007-99dc-54bd336f0693@linux.ibm.com>
 <e29c8bc1-0a25-4dfc-b429-6805c373b5cd@oss.qualcomm.com>
 <7672e73a-2945-49d9-94a8-a3d187be300d@linux.ibm.com>
 <87mrqyhb7l.fsf@pond.sub.org>
 <1fc28def-9c77-45a8-99d4-c1de8dd2d477@oss.qualcomm.com>
 <CAFEAcA88U2ef+1LWP7rP7d9=t8gtv8nOkzULBbTGG3D+ixOCSw@mail.gmail.com>
 <2216d59f-1c2e-4c15-9018-f63cce8ceb3b@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Tue, 24 Nov 2026 11:10:18 +0000
Message-ID: <87mrqyv61x.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com> writes:

> On 24/11/26 11:19, Peter Maydell wrote:
>> On Tue, 24 Nov 2026 at 10:06, Philippe Mathieu-Daud=C3=A9
>> <philmd@oss.qualcomm.com> wrote:
<snip>
>> I don't view this as "kicking out maintainers" but rather trying
>> to make our maintainer docs match reality: if anybody I contacted
>> in my run through the MAINTAINERS file requested to retain their
>> listing I did so.
>> We can discuss whether it's better to do this as a coordinated
>> process over the whole file versus single subsystems and who
>> is best placed to be sending out the queries and whether that
>> works better as private email vs cc to qemu-devel, but I think
>> the general principle is right: many people who drift away from
>> the project do not actively send us a MAINTAINERS update and
>> so we do have to do a little active housekeeping on it from
>> time to time.
>
> Since you sent the survey, I'd expect you to send the finalMAINTAINERS
> update.
>
> Instead of having individual status checks, the process should
> be automated with a script, likely running during the -rc tags.

FWIW that's why I added --list-absent-maintainers-since to
20261120200511.822573-1-alex.bennee@linaro.org

>
> Regards,
>
> Phil.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

