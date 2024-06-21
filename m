Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE34AC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 09:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKa9C-0003n5-DJ; Fri, 21 Jun 2024 05:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKa9B-0003lr-1h
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:01:29 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sKa99-0002DP-Fp
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 05:01:28 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57d280e2d5dso1174310a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 02:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718960485; x=1719565285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fyh7ARxKVv+TuvNrfE8Z9m/uJKQ181X3/1f0vmlAGqQ=;
 b=hbXLWGkKc9Ifo+f1g8s4sPJCKqodSFH/neiSnFTiZnf2f8RtBqhwj6egZEb2HvUGbv
 fVCq0TvZtb9Kq6M7uBywepEk+hkP6fUIigTH+7HwPCLe9TfTEJ4BrkAAhC2GiTEYML9I
 gQyVrvUvaOcsnCdc0AUvFlZPz5LIn4bnLUrSoKmCof9qeEOkfc+0pOj0yi8Z/adQXgJO
 4k/a5VnXkW5ZRUoTsZFRZunx4lFv3Ge5fnszO/N3W+lWMhflc1xPhAYjC3E2iTUTNdAd
 4gWIdKa4vhGOu/R196BIzHRLwwKoo45UszP1rAT4sEtddIq0x2xRfeAhMHBYeulreXmE
 VqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718960485; x=1719565285;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyh7ARxKVv+TuvNrfE8Z9m/uJKQ181X3/1f0vmlAGqQ=;
 b=u11KmBPKa+aAh8oMMgxE074Gs9GFg9BPVjL3ttFqYQ79sSEvCMXPFw77nYrWxpfQJH
 oC0fZqtN6GHbhyETQc1EttiIbJZAgC0o5yX854s5Fd7/TOSov4KICfD2h6tZcMt1pJnG
 7M5Y8o6Z5DtDLTzw2temQQ51SZnM9iLggLVOLK8DmdG09SSGHo/T9UbBfGW5tsy61a2e
 HAcOGC6Ymtb+VctUoyvbc4Q/b9m/bWpeMVXjDbygWTxAkYEbdq6UGNYlHXUPrzfuzsrz
 TBFfoFog3qL15BgBSrIQpWDOp1DGE2CHaGN+SHUPxB3so9bkCK++mcX6re+Jd72TMxWF
 PrKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK0ZXcwtIGol/lLrGI794xyr0bSvuldDnIsnfqbiy/9SxM4nJLjGy96XD9WOMAYhZRAEnyAQyoEE3cBXndDtM/jiMD0bo=
X-Gm-Message-State: AOJu0Yx9GXU0LCUyX0JF7ysnFSxTPXBaqov+jkvscUWqEYwbT7Ixp/hn
 5uZd1S56+yZD4FijdDdvO+iHX45GLoHDPRV/UdgqrzO1TGY5nn+xeH5+ymamVA4=
X-Google-Smtp-Source: AGHT+IH8UjwSkaPjwhyi/tLB5sXOmIMHCghySyIQeqxqPe7V3FVdJYF5iCDW/glUVlUhtmAbqNgvmw==
X-Received: by 2002:a50:cdc4:0:b0:57c:6c1c:f942 with SMTP id
 4fb4d7f45d1cf-57d07ee7911mr5184547a12.38.1718960485167; 
 Fri, 21 Jun 2024 02:01:25 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d3042b9eesm641443a12.35.2024.06.21.02.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 02:01:24 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7C6715F7A3;
 Fri, 21 Jun 2024 10:01:23 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,  qemu-devel@nongnu.org,
 philmd@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v3 3/9] gdbstub: Add support for target-specific stubs
In-Reply-To: <5d2e2b2b-9272-4d26-9c22-29c39c90b5e4@linaro.org> (Richard
 Henderson's message of "Thu, 20 Jun 2024 21:28:04 -0700")
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-4-gustavo.romero@linaro.org>
 <5d2e2b2b-9272-4d26-9c22-29c39c90b5e4@linaro.org>
Date: Fri, 21 Jun 2024 10:01:23 +0100
Message-ID: <871q4qhdp8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 6/16/24 23:28, Gustavo Romero wrote:
>> +static char *extended_qsupported_features;
>> +void gdb_extend_qsupported_features(char *qsupported_features)
>> +{
>> +    extended_qsupported_features =3D qsupported_features;
>> +}
>
> Assert these functions aren't called twice.
> That should be good enough until we need something more complicated.

They are called more than once (because we go through the vcpu realize
step for each vcpu). But we should assert that if set we are not
changing the feature set.

> Speaking of more complicated... do we have a plan for gdb when we get
> to the point where the board contains multiple cpu types?  Not yet, of
> course, but we're working on it...

I think gdb needs to be a little smarter here.

>
>
> r~

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

