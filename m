Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185D606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pdFpOyap
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xL3tx-0004Uc-VA; Sun, 25 Oct 2026 15:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xL3tv-0004UA-VE
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:29:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xL3tt-0007qR-Uc
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 15:29:03 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so4489345e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 12:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792956540; x=1793561340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u3bJzgDnE+NhAJlyT+O9VNa9xeXJBHXDNRdLq/1Z6IM=;
 b=pdFpOyapHRhiLQhzpDN71/ocCnyqavTn6dG4oRm//1VCOuPLRBOC5Fl+UouzhFcUZa
 ATla/wPm+aAcpIMlYkxqtcpaafbM0tgeQWr5vDn4jObCLV2TQyR97MNIIqZgZ2G4ia3y
 pExj5oQlA6D+WGGd99jz5FWNcg7umBQPk1lhoQJhv6QeuyXjIWBULbgPH24DJCC7xd8u
 qP1RJtU5SC+q54lgM6E27re8WxKhUydAexienXChmm5U6SZGVU1tWCxqFXtUzmbc89iy
 z9AeIlaSL10J+gvwIIO8A7hWS+GlskWgDGhTjjP8SIN5YI5HLp9giQddOz5XlEZ3VoCa
 Jksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792956540; x=1793561340;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=u3bJzgDnE+NhAJlyT+O9VNa9xeXJBHXDNRdLq/1Z6IM=;
 b=cNCIfU1UPKTeFtN5ct7uRxh/gL7unX5RzUQ4TNgDPFPzDvGxe8qBxQdpDqbNJ++S8u
 i9TUDQI0T6dTy+tZmro8TUcdAE7fdEjy7HczsCKx4v4r4eu+X2My7pUI0+lo5fE7DvUC
 qWbOlXbLvkf8uzOQqkxWcvVjGLIScZlkAC2e1DGbaZu39Gj9BZKDpJLKynpiizeQ2EHg
 qN5fFP5cDV0lDPw/xuifwGQXM8dRtrvrPNxIpxz9UVFWsrh5QU3Z9obWpTZVtMqAvQuK
 H86J1txTwUsUc5DOEHmEWfVHNTgQBypOEx01tBJxIIvacMkxDq93Tdy+ip4ZLlIYRs5h
 cPjA==
X-Gm-Message-State: AFq9FYIeOP5e5pJDwHrNhKFAIYkvIyypiRza+jkfZJnPP+BRdAeyTGQp
 ppo3f0BfHoHMxrYNPpJZ8BGSkntrgiGsO35OuHBzjbnDJ1BjvKIEZN4kANtiet7CfFO/Vqt53hP
 de1oyIwU=
X-Gm-Gg: AYBFou0UivYKGN4Cz1DdcVs/XBLOHkhGTJV1GXzxSdPMfGAZJLgrKamlfp2z/OXzury
 YUNELlkJu2HGwPY2m51G0a3fsr/4DOBGqVObK9YMvs5RTKWJpJv1mOc9I2Hq1Mm/3HS55xVEaXm
 Kphjcq+euwoHPIaCXJlROiO4gMhlqFjAq7XGA5cDXT5yt6/A/deKkkIAio3p9E4Oy9ZN0uFIhjB
 pBW0nm7gqUzLFwKzKuRVifwhQcPDLMfxTQEBlyVPf4wHKm6CCCel0vHkq6SgD+iuA+HdKUFIzjm
 OGsP1VPI7Z76qCyYI6/SIJ9/GbQv/DSYct41NyBH9gLJluled3AdcvPI/n3wY2f3LQfsIwHKj56
 SC10PirAkFY0zdpw1ShFK1aq6mz/HxT40Bb4dRZhuNfxLXRatBPWmr+/OHUKpRam74+MSe4AJgf
 XR1zI2b06H10UOLurFMHgWBi+NI8ehQmPVDe18qqHO1YP0Bt9g5x/TkmX7sBjjoNdJv9uC4X7aw
 bgpVtM/1Bhvs8EPKZhz0wf49ZvTbTiDcdjuNkD3RyslYTuwXTE1eWS1
X-Received: by 2002:a05:600c:a08:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a35aeab300mr100179745e9.15.1792956539647; 
 Sun, 25 Oct 2026 12:28:59 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5698f1sm142462815e9.8.2026.10.25.12.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 12:28:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 424255F887;
 Sun, 25 Oct 2026 19:28:58 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Weil via qemu development <qemu-devel@nongnu.org>
Cc: Stefan Weil <sw@weilnetz.de>
Subject: Re: OSS Scanner service (Anthropic)
In-Reply-To: <53658828-9693-4235-9ffa-53f391dafc81@weilnetz.de> (Stefan Weil
 via qemu development's message of "Sat, 24 Oct 2026 17:36:07 +0200")
References: <53658828-9693-4235-9ffa-53f391dafc81@weilnetz.de>
User-Agent: mu4e 1.14.4; emacs 30.1
Date: Sun, 25 Oct 2026 19:28:58 +0000
Message-ID: <87ik2pmvet.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Stefan Weil via qemu development <qemu-devel@nongnu.org> writes:

> Dear all,
>
> citing https://github.com/anthropics/oss-scanner:
>
> "OSS Scanner is a service by Anthropic to scan critical open-source
> repositories for security vulnerabilities".
>
> Unless QEMU maintainers already have access to the best available AI
> models, this might be a good chance to get such access. I think that
> QEMU matches the required criteria.

There have been offers from re-sellers but they main issue is what would
we do with even more bugs? Are they offering to do the triage work and
filter out the non-virt use case bugs and search for duplicated already
in the bug tracker?

I don't doubt they can find more bugs - but do we have the maintainer
bandwidth to deal with them? Is anyone volunteering to take on the
fire-hose?

>
> Best regards
> Stefan W.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

