Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54329606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jKBEQf6c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWb6R-0004y9-P9; Thu, 26 Nov 2026 10:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWb6P-0004xR-HS
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:09:37 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xWb6N-0007r4-TO
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 10:09:37 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4ac08f4a0b2so5053240f8f.3
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 07:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795705772; x=1796310572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Tywsr03pAYQcTzE56HpjdIbc/rsi6UPJdZzlBYRdd1M=;
 b=jKBEQf6cv6OBgRB749/FxeZwFJpVkVhPopshrHQeM+cwzIf+Iq3b8kPMARoLjvNRF1
 xVUTuaRp40mKgtP7okSg9gw2TIRjqAgA/ED2/IgZd8jEYR28Rle4J168RDckm/ivX+zL
 9LH/4xvOzorr8AIKRbrfj1XwH6zV2TBd1Ohn+CHMBqbI+6j/HM/z36OILBi7x266kGiv
 n3AU28FqqwRMi2EMW43W4993bwnU//BQ8AQdRzwXlxfUJNbOL1dzPIPLx++LYagXsFvv
 JLklJdNEWeF6rIA/O1aGB6nMJ1i2wMDvLthCQtV02PaYkigl5ZeAoBNJcZWx7vfhbwc7
 qD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795705772; x=1796310572;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Tywsr03pAYQcTzE56HpjdIbc/rsi6UPJdZzlBYRdd1M=;
 b=Jyz6UpUc/6yyasVVSss6Wm1s4afvPGkuQw4hD3KFl1Z0PHLldsMafETcF1CbAn1gR1
 /yA6g6rFtA//TzVqEcWrMnYJyq3I0D5xvKOmDRfStUiAIruOKIQNOTPoy2neEnjcYfS7
 GHqW6EQpeUIebqn9twJspoBOuxj7VXA+VHm2LxWT6qby7eysBsD4/2P5lhhH8dq/SPLz
 96MSfhES4yMa5F616/yVgLNvlaMcPdEo4ym5sr9nnPTaSmUbep9pPxkZlNJ32JclRgO9
 +hoOnzOkmKSo0gMB4AvilZn5BUqrg1pHAauh0/vytQWQRmPHhqZygVpVHXNoWvP1OBoy
 DbsA==
X-Gm-Message-State: APuU4Z/DzqJ7vpkAzFbYKaePSZzRP6tt7OzdentnLbkTOX494c4olbhu
 Op6Mup8HaJRLqiCZ+zlAEodoThFs8fLHWM26Jc5qZKyHaxYDoqu8Yn6TEjdihdPT2j4=
X-Gm-Gg: AZFdTZfryjCVSjNYmTuVd4hdteS8vvDIw2njqtq9SP9jv4O3PLp7OuUHsZwtI8/S52A
 v0XtQo/aHpCpNZX0GHpyO5/C2rHkg7Y8OFV3cwZ4dFWjEo7evDotf3ukjZByNMOLAeejyTYC1T5
 fyMwXRgpo6N6UlMJ9WiLZSyt+NQGuvGtzcqMjR/dwHSMmIyhGL1MJRW6JTsZ2aXxFjZH3kYhuzj
 kXC0k89bONgnH1iOn2sHnu7Wl02hgg+kr3zaxNI2Kfixk7qU/dqvbFu18HjbWLGjWwsGA0yjg8G
 Ud74tCi1EmA92bjUnRfSBtEG+b3/7sSzgiSFxYNFoVYyh0Y4tvdZF4+iFcPpYDsXqxKdjxSA9ZG
 QviBFb4DaRcvgUPHrJ4a/QeBf8l3Px7lZCqWuFBBX5XHEaWEQ7/mUrK+HhMHWr520uZmxuRDfdg
 i9JY14pClMoMCU5hTew8d+T2Nn2D+Q4SSSan9lPwjpCNy83M/5Z1aSplsOB1olvwO4pRyjADet/
 0ldeyore2V9jI0H4UEdPnmggDygbycA5lPLyqnp9Vs/lD0lNo21wFiLDQDK9D65CwEc4Q39uRrJ
 mbH2on+CDmSuo3ptsmWyTI2kztn37L+cLyDw5H7gR4nBjhgGGA==
X-Received: by 2002:a05:600c:638f:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4bb8880607cmr403779665e9.13.1795705772568; 
 Thu, 26 Nov 2026 07:09:32 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a12acsm640166855e9.8.2026.11.26.07.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 07:09:31 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F01B95F885;
 Thu, 26 Nov 2026 15:09:29 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Frank Mehnert <frank.mehnert@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  peter.maydell@linaro.org,
 Frank Mehnert <frank.mehnert@kernkonzept.com>
Subject: Re: [PATCH for-11.2 v2 2/2] tests/tcg/aarch64: test WFE after a
 failed store-exclusive
In-Reply-To: <20261126143258.1056688-3-frank.mehnert@kernkonzept.com> (Frank
 Mehnert's message of "Thu, 26 Nov 2026 15:32:58 +0100")
References: <20261126143258.1056688-1-frank.mehnert@kernkonzept.com>
 <20261126143258.1056688-3-frank.mehnert@kernkonzept.com>
User-Agent: mu4e 1.14.5-pre2; emacs 30.1
Date: Thu, 26 Nov 2026 15:09:29 +0000
Message-ID: <87qzg7tys6.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
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
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Frank Mehnert <frank.mehnert@gmail.com> writes:

> Add a test case for the common spin lock pattern "WFE, load-exclusive,
> store-exclusive, on failure back to WFE", where the lock is released by
> a plain store and without SEV.
>
> CPU 0 executes LDAXR on the free lock, then CPU 1 takes the lock with
> a plain store. The following STXR of CPU 0 must fail, and the WFE after
> it must complete at once because the store of CPU 1 cleared the global
> monitor of CPU 0, which generates a WFE wakeup event. The virtual
> timer interrupt, 1s out, ends a WFE that misses the event, so the test
> fails instead of hanging.
>
> The test starts CPU 1 through PSCI and therefore needs two CPUs.
>
> Signed-off-by: Frank Mehnert <frank.mehnert@kernkonzept.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

