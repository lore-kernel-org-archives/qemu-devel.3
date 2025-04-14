Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA4BC369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 16:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4N3g-0000oZ-OO; Mon, 14 Apr 2025 12:53:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4N3e-0000oD-P8
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:53:18 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1u4N3c-0000Np-RS
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 12:53:18 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d43c972616so12522095ab.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744649594; x=1745254394; darn=nongnu.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hmsbxMU9jlieA4cuU5UJRciW2VrVQnuH77h5Uovvq3E=;
 b=FDTzgZvYS+ZjcHmmXmoXXbzCIPrZQ1eWo1H8n+SccQBOqrugxwFtgLop+jib9bY1Ms
 q0+L2n0d8vwpoFdDPi9AgRzAaeZbM0S6f0bz8fWGCtj+FpuQq9Oozm02MO/g+OzhDZTU
 iNSHl1zhPFo7XIm46L4SIDHXSumm39PQJQ0VNR5eqQEHOYMP8teY6v29pIR276e67fLd
 KbYlW8JWVxkP5mxQs8jMFC7GCkgyZNPQQ757i62f1up+rCDM3pLjoejO6nW0Jo6OAMKQ
 pfhc9HTcvyLWGZRaIq6QEmMIHCBrSVaVd/IEG7GNTG7cAGdrPl8FWKN4YSLRQ2tv5pU0
 mpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744649594; x=1745254394;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hmsbxMU9jlieA4cuU5UJRciW2VrVQnuH77h5Uovvq3E=;
 b=wEEuOK29Q3O5pgcxWBC4RAh25n/vfCKOOlrKHRSnVHZz93VNBVWM9lXHOoCDA7fhh/
 6CRLH4VPATR0+3wW/82r0DlJ2oUQ6eB/muJXxUYdDYKKc5j41ET2/NqGyImwBWklDLfv
 d8FbzX4loiG4HmnXUssxX2+MmM3gDWR7zFPFTzhrYmJpviRPasPGgzSX3/m4xHvsr7Gt
 JxNWj3oa/prADcUfgEXJR0RnmnJhmybD/Ap/T3FyG+aQlPfZylWFOmL5GGZ5+gsD+UAB
 zpvt0RO+Mtd0ipsgcVJkDlbxQRov1KZWUqDue5GWPtMtHpCbIABslLXnMzwSnfTGTSZm
 JJyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNDMxi+bXogZES9nW9/VUFigJOIT74tqeYbVTLOaOfXqNNZW2HDAQXwhbG6lLvg5AA/HzZ1E7T2PkH@nongnu.org
X-Gm-Message-State: AOJu0Yw7F7nicH+kLQxZ9JZx2Zr75Gcu4kSYW9nYIT0EUHIM8ouwuONQ
 y67hI5U2mu2GweFMf6S2ZSEtdgUtw+vKAiQpSo+NO2wJvbEtSJ57+ypyDIvw
X-Gm-Gg: ASbGncsKm9tudMik+XP2tkboILBobSmggN+SGjoBZB4+ma9dRh03N6ox944BZsKlC+1
 jxqbXq/36qibEigu3y9I/nu5wAcVZ8gZrOBKu5smRiG4uZ8YUvCdJdeInxA7TlI/WIcaxeOz/9C
 vnyVFuQ6Gtptaq9MhISoNNchxVDvaOIeObh2VbzztTW2nilGQL95dJyRAYvhla2In5lL4C7JhEU
 eSV0dIYUlfJ0z8xGJh1hw9uaQNZnV+f4OSBdbc4j8uQPNIMiOuGjj1R9GG8lPuLqglPtAcS+7GD
 bQgkuQJrRW2JfCiEyBqN2vQzogMKCvg/MU1WG+K7rK9lEPnVAcc1e81bAHaP+EGBq/L0bFGo7Eo
 =
X-Google-Smtp-Source: AGHT+IECxQpz0UM9MH8LUR9wXpOBc2EQaLGJ3hO0sDMghU70akPD7zw5EhSUC92vfuZVi9YInnwP4g==
X-Received: by 2002:a05:6e02:3c07:b0:3d3:d344:2a1a with SMTP id
 e9e14a558f8ab-3d809b01940mr3099565ab.0.1744649593041; 
 Mon, 14 Apr 2025 09:53:13 -0700 (PDT)
Received: from DESKTOPUU50BPD (c-67-190-160-7.hsd1.co.comcast.net.
 [67.190.160.7]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d7dc591f6csm28605425ab.69.2025.04.14.09.53.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 14 Apr 2025 09:53:12 -0700 (PDT)
From: <ltaylorsimpson@gmail.com>
To: "'Brian Cain'" <brian.cain@oss.qualcomm.com>,
	<qemu-devel@nongnu.org>
Cc: <richard.henderson@linaro.org>, <philmd@linaro.org>,
 <matheus.bernardino@oss.qualcomm.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <marco.liebel@oss.qualcomm.com>, <alex.bennee@linaro.org>,
 <quic_mburton@quicinc.com>, <sidneym@quicinc.com>
References: <20250407192705.2605614-1-brian.cain@oss.qualcomm.com>
 <20250407192705.2605614-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20250407192705.2605614-3-brian.cain@oss.qualcomm.com>
Subject: RE: [PATCH v3 2/5] target/hexagon: Fix badva reference, delete CAUSE
Date: Mon, 14 Apr 2025 10:53:09 -0600
Message-ID: <058101dbad5d$b56042b0$2020c810$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFxbseScfkce8xHjxBW05Q6egvQNQFD5cvPtG29N+A=
Content-Language: en-us
X-Antivirus: Norton (VPS 250414-0, 4/13/2025), Outbound message
X-Antivirus-Status: Clean
Received-SPF: pass client-ip=2607:f8b0:4864:20::12f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12f.google.com
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



> -----Original Message-----
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> Sent: Monday, April 7, 2025 1:27 PM
> To: qemu-devel@nongnu.org
> Cc: brian.cain@oss.qualcomm.com; richard.henderson@linaro.org;
> philmd@linaro.org; matheus.bernardino@oss.qualcomm.com; ale@rev.ng;
> anjo@rev.ng; marco.liebel@oss.qualcomm.com; ltaylorsimpson@gmail.com;
> alex.bennee@linaro.org; quic_mburton@quicinc.com;
> sidneym@quicinc.com
> Subject: [PATCH v3 2/5] target/hexagon: Fix badva reference, delete =
CAUSE
>=20
> The BADVA reg is referred to with the wrong identifier.  The CAUSE reg =
field
> of SSR is not yet modeled.
>=20
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c index
> 766b678651..62f1fe15b8 100644
> --- a/target/hexagon/cpu.c
> +++ b/target/hexagon/cpu.c
> @@ -216,8 +216,7 @@ static void hexagon_dump(CPUHexagonState *env,
> FILE *f, int flags)
>      qemu_fprintf(f, "  cs0 =3D 0x00000000\n");
>      qemu_fprintf(f, "  cs1 =3D 0x00000000\n");  #else
> -    print_reg(f, env, HEX_REG_CAUSE);
> -    print_reg(f, env, HEX_REG_BADVA);
> +    print_reg(f, env, HEX_SREG_BADVA);

Since BADVA is a proxy for BADVA0/BADVA1, consider naming it =
HEX_SREG_BADVA_ALIASED to help avoid the problems we've seen with =
HEX_REG_P3_0_ALIASED.

Taylor



