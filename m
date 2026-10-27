Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96ED606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IMXRq0Lp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLlPj-0002W6-Qi; Tue, 27 Oct 2026 13:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlPi-0002Vi-78
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:56:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xLlPg-0001p1-2o
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 13:56:45 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so984625e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 10:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793123802; x=1793728602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pfPfto03nTAA/6E1XOVFQIo2ZsjmIrwuiMIxtQXW/4g=;
 b=IMXRq0LpghlmQEoxNyVcNcXp/dxGNZzH9hrpfkQEwpe6iBM5PSS7w3oB7enue+wdnR
 whjGWdlK4CO+LW3WxtO/n+3jSpBq1iH8xgBcyLOnQpwBOhd4RQzkN+4pgC1qZ6STqcpl
 CSC4Bj+gJoHy05nP9PwcRs2mFRJNOMlmVj9N2Rb6EAHGk+00xEV2TkqaVMLtBKfbEIzj
 +h/ZErLuoWROx05huLn+v4ZXeSWT25uM9b1439DWGha5hjtgbM77Fz8d8zKffnio6zK7
 RMPap2yVTYTLCjuZipn+HNRHqEAJ+ueW1UA8OEacDBvU51pAjU0DqNcN3AO1XSbCJwDY
 L90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793123802; x=1793728602;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pfPfto03nTAA/6E1XOVFQIo2ZsjmIrwuiMIxtQXW/4g=;
 b=pcXLFbb13GNIL7c1TU0vAjqpj6O/WhoKIEUIZKpVmxOZLvPIG0RmcuELaV86uY/1Wg
 g/uzuIZwRLUkUsgWFcJEIB+s63StkLGtBtJ+R0Dr5QSKSafoW2LpgZTTQ7b6Nokzie3p
 iNVDIalOYoQq2XrkBk+O+SToA633xVfvg/8uEjkmw3gY0/5C1tweVkcjA+HhnYuOaHmk
 GZXVWmX2kY8AtrzKzRMW7IrJJRuyifah3s2lqkWN4mQvuazMetXKngti9W2tNw+InxpP
 wsuUjpgnvE9RtOPxzPA15b5KuLh+3t/nmLnk33ab30X5DNQk2Jq6t1akVfXuGbmLgP5D
 yjug==
X-Gm-Message-State: AFq9FYJngKnOrOvZsJ4mOSZYfDzKy+vBUnXk9m3JRG+50BiSozIfYEJE
 wuflUQgXLsLMUqdSwI4SrVnhjynHV0gqv6AY8HPStxRisUV1vZCGo01F2y2deNczUBo=
X-Gm-Gg: AYBFou2Ih8i5l0aYwEVgCl2nZUmp2lqi3ZLcCNk7fHmQEBrk4JzZGH09sMRQfzdrJc4
 1/M+Gn04b5+ajO6TrB5wSAOYqhOtYma8AicZh3eFfE8q7dwxIloRLvnOa6dNR6cCLU6c/GqM7Tz
 vz9u7yLM6H1SVwLSkkHrt2/FAj9affP3rE//Z0HEwep7GvVBgWeP1S3cIuAypZ9kV4LGZJD5M2y
 o2uEJsmHxJXeRs9NSmBznxYR0Olwez48VdHRUPlZcsssvmLCgLaaAuuBPdB6ZdzOkSMisdUs3f2
 CJHz8tDjJhsQSwbKgfAYG1WvCj+RHUgU5cLtJ2fvjrZOiEq4x6XnMVXYHrCa3zQpsbcj4v/Xn+4
 wfMOvvKNEwny/ZmLqeKNnE/QE7vhu4Xw5q/me1HuqBvNjjU45yJjbcPQIWjF+O43PtoWqr0O3ls
 1/V/hF3zkRbX7z+vnSA5ZaKVDVCYkVWRcvd7GeYn07hb3v8+xUGhMs5/43AGEb3rcZVui3FEnup
 F8D1G77EJz1dKZ2/nVst10DmAMsXysdExjHPSlpM/4yHCN7CLzOsvD7qtcP5MeQeiYsvVr3xFiA
X-Received: by 2002:a05:600c:8183:b0:4a2:8c5:5f2 with SMTP id
 5b1f17b1804b1-4a35ac99b41mr181733945e9.5.1793123802532; 
 Tue, 27 Oct 2026 10:56:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a92eb9b52fsm3255075e9.2.2026.10.27.10.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 10:56:41 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 87A4B5F81F;
 Tue, 27 Oct 2026 17:56:40 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,  BALATON Zoltan
 <balaton@eik.bme.hu>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Warner Losh <imp@bsdimp.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] AGENTS.md: make the human part of the design process
In-Reply-To: <20260930085433.830743-5-pbonzini@redhat.com> (Paolo Bonzini's
 message of "Wed, 30 Sep 2026 10:54:33 +0200")
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-5-pbonzini@redhat.com>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Tue, 27 Oct 2026 17:56:40 +0000
Message-ID: <875wynrprb.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Paolo Bonzini <pbonzini@redhat.com> writes:

> This came out of the experiment with the first version of the AGENTS.md
> file.  This addition improved the behavior of the agent from the very
> beginning.  The very first answer to the same prompt was "I'll orient
> in the codebase first, then we should talk about design choices before
> I write anything".
>
> In fact, after thinking it pointed out from the start that this requires
> pre-arrangement and asked two questions (how to represent the pressure and
> temperature in the QOM properties, how much of the behavior to implement).
> Even with a single data point it seems worth trying.
>
> When asked to commit autonomously, the LLM also clarified that it
> wouldn't add S-o-b trailers and that pre-arrangement was on me.
> It included "Message written by an AI and to be rewritten by hand; not
> for submission as is" in the commit message, a "handover notes"
> section about design choices that were made without the user input,
> and the umpteenth reminder that the work may only be posted if a
> maintainer has agreed beforehand to review them.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

