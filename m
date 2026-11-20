Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D7606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=P8yuglRe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQFF-0003Fv-5W; Fri, 20 Nov 2026 10:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUQFD-0003Ej-14
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:09:43 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xUQFA-0007Oc-A0
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:09:42 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so7846325e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795187379; x=1795792179; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=eXjlIdzRAyPiGP26Ta4PQK01jIWRUA7UZbAweyQ4rE4=;
 b=P8yuglReB3wkjd1Ptb+bg0i6pK3Aa5uRpHBHHNmIMqRCUn4ywOpP4n/+BgH7pE46bJ
 +grFIz3Ux0mapIoANDUjouk5RDqpnRN7Ztd5J6+QTzlRY5nCqT6/74oXkRKlG9pVxiOv
 aaSQ0U4ig7ZrScM0unysobEo4HkPJ0goygprb98KZljbsn8+zJDi3542qEjIHa/tVVZM
 UQZ5BRxYGEgYlswoLXntDnQdGKV+forc77q17ueIh7VgqS9fjM4y3k0CinI2JenLJzsm
 lourcbJLkUS7FW4CwfRB73OJUpUNgd9MU6F5OZtzD9TIy0huwZ5n6+8dWJUE2WE6D1+f
 f1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795187379; x=1795792179;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eXjlIdzRAyPiGP26Ta4PQK01jIWRUA7UZbAweyQ4rE4=;
 b=jQTTzLznCUEMU3SMJ1Nx8Dv5DVLfKAcyKW3m/jRApp89AZ7p2gvkpuLS+Cqm3aE4YI
 JHkU8UcGaJOVExzrgkcOIXBeOPuA9aWRivLT3AN7jxe346UduNHuFQWBJGWT7vWkA81B
 Uov/UgC8v+ZtarRlrFcnqKI7VMxauAlN6TliVEvnEZIa+AVwm30TCdywU5oden9wtaiW
 aqx4gFAp37aSKX4RV4dLQSWlrm/mUdDuwIEBh7Ll+1l89KAdbIxKdHPJRmVe5MzOJFTm
 oUlfSfFs9Rq1mFbG3zM+MifAm1V1YLQg0hi6BSSg/9EX/eKOUxStlMmrHnnRoyn1oscr
 YQ8A==
X-Gm-Message-State: APuU4Z/CGz5xQrGZpz5mNnhdkpjHpOoYxSkmvtCaBZ6axfaNKkwSVNDf
 5SgNg4DbE2aJLFFmJBk5k/udjNDVHAMqrPXmlMyJ1lG385okQDLIfczm/y2iyKX9Icc=
X-Gm-Gg: AYBFou28ORm1ptEX32tOPOpu80DQ69J+mg5lBDAFO21RKFxajWfe5yEjO+ArAgxubcy
 Z4x9X3OZ7TQqG6apfYCekyIbOsFl6nxrShGmJwcFlqnUe+QdvGHLF9MtQA4jfZkEDd4Pho1y2ky
 CgpkirhrBG+nkwyvK7YcWC5qFvrApzp0cY7dOAtmx28GeCfcpBHt2ZP8Md7h9TuRnViFSeokGtd
 o+nR665NkfX6Woe6zn/QP1cA6c6z8LyqJpo6BvCxm02Q6QPk1mpk2+UMfyhKrvpbNDTU/lEg6NF
 hO2pkZOJXfnJoV4NB2u64S4lyJXJ0K5oLujW7y9NGfIBW9tJpxUDIP635OUw6VD/cuFGI5ERR7o
 QyFcgy2vEC4EmN+fTAztrDw6k0yHCsY9g3kZfdVar0VgD8ST3cQoFQIUE2qra1ZG/Acu8r3zW9o
 2M6xbdERbM8LNRezlbU3oM9TDNwE+pE9gvg2QyuCMCXRBC2eai9ETEyC2DIdV7bkRLxhX4Qg2ml
 udOifehYDHzg4yROzO282M7wpClGcWrmPlwzbKPjSgHUMPx5htlEkpH0Kb4Dv6uH0S/02UulAze
 jCgiyk60OV27eJVd/A7kdX605IjNC6GqSXVMqkbAkdchVBWAWng=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4bb8881c630mr83051225e9.27.1795187378555; 
 Fri, 20 Nov 2026 07:09:38 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab658e2d60sm6141798f8f.3.2026.11.20.07.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:09:37 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DF8A35F7FE;
 Fri, 20 Nov 2026 15:09:36 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  peter.maydell@linaro.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Kuan-Wei Chiu
 <visitorckw@gmail.com>,  Palmer Dabbelt <palmer@dabbelt.com>,  Alistair
 Francis <alistair.francis@wdc.com>,  Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,  Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>,  Chao Liu <chao.liu@processmission.com>,
 Joel Stanley <joel@jms.id.au>,  Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,  Michael Ellerman
 <mpe@kernel.org>,  Portia Stephens <portias@oss.tenstorrent.com>,  Halil
 Pasic <pasic@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Eric Farman <farman@linux.ibm.com>,  Matthew
 Rosato <mjrosato@linux.ibm.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  qemu-riscv@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2] tests/functional: use immutable tuxboot kernel URLs
In-Reply-To: <20261112133320.418012-2-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Thu, 12 Nov 2026 17:33:20 +0400")
References: <20261112133320.418012-2-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Fri, 20 Nov 2026 15:09:36 +0000
Message-ID: <877bi75ykv.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> tuxboot rebuilds the 6.18.54 kernel images in place, so the URLs
> without a datestamp now serve content that does not match the recorded
> hashes and the tuxrun tests fail to fetch their assets. Point the
> x86_64, arm64 and s390 tests at the immutable 20260930 snapshots and
> keep the hashes that were recorded against them, instead of implicitly
> switching to the rebuilt images.
>
> Do the same for the riscv64 6.11.9 kernel assets, which still used
> non-datestamped URLs; their recorded hashes already match the 20241122
> snapshot.
>
> Fixes: 8ac1aab21fca ("tests/functional: update arm64 tuxrun images")
> Fixes: 09961fafc5a0 ("tests/functional: update s390x tuxrun images")
> Fixes: 467c9eb7dd31 ("tests/functional: update x86_64 tuxrun images")
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

