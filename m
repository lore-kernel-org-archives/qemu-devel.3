Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ADEEC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfAt-0007qj-S2; Wed, 19 Aug 2026 08:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwfAs-0007qF-RL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:13:42 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwfAr-0000gz-4C
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:13:42 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f84023916so880101f8f.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787141619; x=1787746419; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LyYq9yvTWtehLSIm6m7ETA2l17lbTiPO4u8qv1QMT+M=;
 b=g+8IN3lTL0slKfq4L3WzBXbMvcDTuNfW/Zq/RBMwlBhEcnJN7g40lG3HXzaEag8K29
 hrdM7peFadopJr5sfpUMfpX48udiDKSKoD2i/107bc4DkEQ6hwgMAKl2+h4kWjom+9j5
 3zSbKAUXNEvoozBm/9Pq0O9WRTk9t1Fk9xvqXOATT7gsSc/xQg8KI2UvJh+K81qFx4DT
 Al4XKepEz3OQlnnqmbTNtJAKafS+ryvdcDgOxGkB/tWvpOIkwrqS6i0hMJw4Jffrvv7q
 6vX5hfTg0vkZ1J4dI3MYh5R0qX7SO9Og83SgIsZhr7XPQA7rMXp/w7yw1OiCbYemM4ff
 5ruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141619; x=1787746419;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LyYq9yvTWtehLSIm6m7ETA2l17lbTiPO4u8qv1QMT+M=;
 b=pwBOd0J4V3hj43+4Wcig+FEiaYr0Y+XSPazSfVvK2JxhAhASGW9fk8nC1utLQIaGd2
 ySFo4ts0vR2rFmeUfbku4kUSVYW7qRfHTKWlaWewBfJE6+9I1d6cxPWdl11iqm54i3Ia
 H0ARsGR6lju0gHGdVmhKujIDvNhzKnMTIAHgEo8ja/tv13RwSLjikE18J2Bc9R1ExCLV
 cDaOPrwYWsHnm7Vlcjz4qG022EPZArddOS8c8wtxM7UYCpFHYphgg6IyQvOwm9ENSzt7
 +0tv/8iQEekiPKBy/usntOp25rNNEghZVZzEzRRNzaatIBrBDsTr44CdJDPqBaVUJpf2
 ZUcw==
X-Gm-Message-State: AFuF++nmLXe2cJUcnvAIvbsxxbWRplR3gbKaWxDeEHNbRWNkspnb17CC
 K0ghj1oupJEknH3veDw0mFO+wlvTLMSNBJJfSCKfciFZpBfIsp0561cchgcSkIojZXNinja2tqY
 kDDNx
X-Gm-Gg: AR+sD10KXqi1R89QHSMBzp8Dh7Gg+dKKmDAoNa+ZL50oIgN7+fIVvjL3Wyz2vuVIHqs
 mob/RAgfcFjzmdTlZtUPyarYorRWoN0shxGoKyM+5aARhCsMrsnVo8qhxFWuJv3E4P8turR6T+o
 NSIvUpbjO6MLsBA3XHRZ3QE1AcJS0aM+63+cUUCfyVk6y9tcv4bdPcTzINWof+V9D3A5Sa14xNe
 q7mfJuVTT7smEXVcpzn76pYuQmkwALjGQOeYFgmgDu90F9CcJKjCFpnVOCzpKuqPBnzI6yl7pEW
 Li8gsrh++kruC8FuGu1VXakztGBeGC40clpT0Sn7Pdun0WG1s5Eh/GX+WROprA4QtuzRAxUjaTc
 /X1uweq8qvn2xoqFVUzR2fkraacTp+OE2m6bw1nkv05cKdLDMfVt82oMXycJ7u+KJM8KLwdczZj
 ZFSHta3n1dsXkud4fcc4P4u8OFAyUtfx1VJpQJgT5dp8pFcCmNnQHAW1wJPpT7
X-Received: by 2002:a05:6000:1846:b0:47f:7129:6e2d with SMTP id
 ffacd0b85a97d-482b1fe83d6mr7507601f8f.17.1787141618874; 
 Wed, 19 Aug 2026 05:13:38 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14cf0a3sm5151242f8f.32.2026.08.19.05.13.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:13:36 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA83B5F805;
 Wed, 19 Aug 2026 13:13:35 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org,  Philippe =?utf-8?Q?M?=
 =?utf-8?Q?athieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Eric Blake <eblake@redhat.com>,  Michael
 Tokarev <mjt@tls.msk.ru>,  Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH] mailmap: map the last From-munged author back to a real
 identity
In-Reply-To: <20260812112456.970371-1-den@openvz.org> (Denis V. Lunev's
 message of "Wed, 12 Aug 2026 13:24:56 +0200")
References: <20260812112456.970371-1-den@openvz.org>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 19 Aug 2026 13:13:35 +0100
Message-ID: <87lda2qpe8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

"Denis V. Lunev" <den@openvz.org> writes:

> qemu-block@nongnu.org rewrote the From: header of commit b67e353863
> ("block: drop force_dup parameter of raw_reconfigure_getfd()") for
> DMARC reasons, so it landed in git attributed to the list instead of
> to its author, whose real address is in the Signed-off-by trailer.
> Map it like the other munged identities collected in that section.
> This was the last one left unmapped, so 'git log --format=3D"%aN"' no
> longer reports any author 'via' a list.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> CC: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index e5dc644623..08f0fa9e11 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -68,6 +68,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-deve=
l@nongnu.org>
>  Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-trivial@nongnu.org>
>  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <=
qemu-block@nongnu.org>
>  BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.=
org>
> +Denis V. Lunev <den@openvz.org> Denis V. Lunev via <qemu-block@nongnu.or=
g>
>=20=20
>  # Next, replace old addresses by a more recent one.
>  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>

Queued to b4/fixes-for-11-2, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

