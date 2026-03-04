Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D7EFCE33
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 17:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqPs-0003kY-Tx; Wed, 04 Mar 2026 12:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqPs-0003kM-DN
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:53:48 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vxqPq-00086x-QZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 12:53:48 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-65f812e0d93so11031630a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 09:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772646825; x=1773251625; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PHTF1uAFn3v1mnrNi/Lb8WMbQLKylCEkPqTrG9+S8CQ=;
 b=dCVYQtyG2Brw6jxbizVASIQidgxWQ7GVCGXibWB5le5cO0MkcPgSie7Ip2Gk4Bb4Vr
 XNv+rLaHdkKBE9M6zV7S/TA++5uunLbNtyb0rSK0mnZM+49cYx1AlBINEGJR4QowQCAl
 JK5QYIDD/70pGakZHrLmS+SyHbEwTwJutEiaba7jKQE1hZT71E44kfjdfCH3pfLl0qMs
 vsSbxjiGxH30gB/mUK8o88lVcmoSQRg7ilbsD7d0jg65hlfpDXB0UCWTc+p8FHXz/+B7
 DX9yJKr7utxOy9f6cEBVFoG8578SBo84A54pJKgRdpf2utJOwkLzHKG0QwXmHwJKL98O
 fVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772646825; x=1773251625;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PHTF1uAFn3v1mnrNi/Lb8WMbQLKylCEkPqTrG9+S8CQ=;
 b=dmURwdhsEVQkw5/FEF7ZSYyMu4s4AWfxux7nDCZhlCBzv//XrrcKViKaIejuPILOxe
 iIK0AiibvbsYDKdCxT/6EPYx6ymjqwGB4zopAT6IxMd+ejbQQcDssqrhUVkFvHqlKpwI
 VcgmWk5zs2rcLWWDWie0OSwRRp0/gfhY6f3hb5c6069qTx6I6Ne0PSjdTj1e7boiFygg
 Krdzw1e7wm6TEOmgPycBONI/ZszPYWXidDIJXbz354l+F4EldwR+SSehz8bXLLpWWw0K
 qQGT4yz/b3eWAIjCoAn8pZ0/vC7DXhSxScNBKgNTaXAcDP6qpK5tUICiNx2mVYOOTEGr
 WtoA==
X-Gm-Message-State: AOJu0Yy84BqUO+Nw00OzjAiOhBWq2bMDlkPAxjRY3NsJg+gCs6Fc82FD
 XUMfYWihVndFtFEarR3dK/Lh/XCK4Kak9GbBf3b9xJW+R9peuaoaCIsMfr9A9M4mQ0w=
X-Gm-Gg: ATEYQzzPZ8eokeioA0BnNqObvc7SS8lAt56zZWjO2gwc3bgDEjs8Y/KIYktRO7an2s5
 GPbRopV+z1zLlssxzgtVnhmtTt2ZaA054Ergu3h398xMm4URz6sQlTvlloiVmT8BM15eZbBUvhV
 D3GZFq48qhoDbjT+wnATe1OXPGLblIJJ4/nPHpvL3dzLMTLH1rWNsZE9leFqsSAiL9Jdw4mz2Ii
 Vjp4rAP/p4aO9YKPeqqdWYjVvInEETsB9RyTm3keX0o834grEVWc4mKrOKAjrX6INWc0tjw4XEP
 U9wC8CEvgobOp4hkKZK9o3g0QGCoRhYm32JJWBbFxfauLs8uM3sL6wnFOWPViUiTc9un86YC+QY
 gNYasBD6Zc3RvDJxbQ3OjljIEicaIBXlMtLP46VFUc4bM12f5uUVoSvyXkKwDagtgEiyNvr306N
 QRU6zNkpYftgUgKHpDsiIfNcQ=
X-Received: by 2002:a17:907:7b85:b0:b8a:fae9:5c60 with SMTP id
 a640c23a62f3a-b93f14bd717mr177658166b.51.1772646824272; 
 Wed, 04 Mar 2026 09:53:44 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b935ab137a1sm800686866b.2.2026.03.04.09.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 09:53:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8EB005F832;
 Wed, 04 Mar 2026 17:53:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  ltaylorsimpson@gmail.com,
 matheus.bernardino@oss.qualcomm.com,  marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com,  sid.manning@oss.qualcomm.com,  ale@rev.ng,
 anjo@rev.ng,  berrange@redhat.com
Subject: Re: [PATCH v3 0/1] Update hexagon cross container to 22.1.0
In-Reply-To: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com> (Brian
 Cain's message of "Tue, 3 Mar 2026 13:05:52 -0800")
References: <20260303210553.2044313-1-brian.cain@oss.qualcomm.com>
User-Agent: mu4e 1.14.0-pre2; emacs 30.1
Date: Wed, 04 Mar 2026 17:53:42 +0000
Message-ID: <87tsuvo509.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Brian Cain <brian.cain@oss.qualcomm.com> writes:

> *** Note *** that this patch should not land without
> "tests/tcg/multiarch/linux-test: use portable alternative for dirent64",
> a newer musl present in this toolchain exposes this test issue.
>
> Changes in v3:
>  * change debian from 12->13

Actually I meant to grab this one, but I get merge conflicts :-/


>
> Changes in v2:
> * none -> v2 was unintentionally chosen for the first rev of
> this patch.  :(
>
> v2: https://lore.kernel.org/qemu-devel/20260303175444.1540049-1-brian.cai=
n@oss.qualcomm.com/
> v1: <none>
>
> Brian Cain (1):
>   tests/docker: Update hexagon cross toolchain to 22.1.0
>
>  .../dockerfiles/debian-hexagon-cross.docker   | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

