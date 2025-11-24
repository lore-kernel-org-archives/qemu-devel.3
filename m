Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 425D9CFD318
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 16:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNZqE-0007Ze-I8; Mon, 24 Nov 2025 11:55:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNZqC-0007YY-C3
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:55:04 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkrcmar@ventanamicro.com>)
 id 1vNZqA-0000wf-Sf
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 11:55:04 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-429c5e0f94eso539302f8f.3
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 08:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1764003301; x=1764608101; darn=nongnu.org;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=de/nL1X6CIhlZMzkys7paLOokbEaoPrAmuKY8a3olBA=;
 b=U45MQOtHKyl4/h8COmCuXj0r922CQT2BGbq7AXRkpEVlB0W8EUUTkS0DaZRqiEsurA
 M+5W/v1m5nhJNauB63YkeUNmzDrW0B/ZqPT06jvJJrFRE+geF+/yY7Iuzd3+qH3SAQ4J
 PJo6W6lLRH0iBriTnIiMhjw3YJAMOS8HCVQVqhL1zD3dhJ+dP6f4o5gMatcJLw1mm+th
 VBndFJONa4iZ/FbKleZ4ttvTK91CHn4j1kD4/pPSMX/AvCo01db4BzVlJqVudCEdZIGU
 j/RgGATgcgam3WRBBlzE/g0eXdb5ePKw89fP9m/AfifA4MGrQ5Q5JitNBAKLtu6kGkFI
 lUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764003301; x=1764608101;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=de/nL1X6CIhlZMzkys7paLOokbEaoPrAmuKY8a3olBA=;
 b=rhS3DWI/AK0+tMXpsn0oy8RfHcjuVWwGdBSKOei4REa9DTbWgWFiMcZKkdFnpDYHv6
 nirtjzgzcIjyRneyPZuZTdIDkZZy/8jAxJWWeZc6FiDFphDA7KwTjoiwWMXgddFc7ZYR
 gVLadWbLy3K7QzHr1MrdHKR/sVGHtpAOZbW+J+Kk29PAAvhHA++z+Lfj94Acqu2mY1zw
 dlKkMb5/d0KsBuLNbRb7whJwTjCFrrrv7OqunY67VwjxixbhQkmzLe3lCj4qSI0YBhxd
 XOoMbnSoLIix+2vohAWoS4sr9RIsIQrIXAiKTgu6beM2Lu+xijf4wF0+OhH2NIpAIQlc
 zfPQ==
X-Gm-Message-State: AOJu0Yxrzq12gK3aMNLzrzzEjwcBm/3ZkokS0hKF+SJOq+1dyH15z0RH
 xPmf0tkd5HRDWpnxSYsgTNrvdcjd6QJJZpO/7l2W8T8NyyrdPvyZS3OP13fJTk49iI8=
X-Gm-Gg: ASbGncutBB97z3kU4BRIx1yXMBE+Wt9x2mm7ipoSvBYGuqvhvYx0C2paEHjukHo9+sM
 sMtWSzQdxjjn8o0PRdfHHW5zrW+E2BgQHzzUyfgMEQWcrD9OoU+OCJpByjd8P7amvqK+yzJtjrY
 hYMKe4UPBkFcnk6U8QoaPppUuuRicfZmimmDk3keAR2sGbD2AGUMTmYkXRz1+lnP0CWkZ1V//4t
 aT2j92wVsnqJqlLcYFbeM8e2TcTfjmuElYvTe7SLzOWfqrmOsqzL40LndaKWDXrQfJHAWLm66Pk
 EJlECsENbasKHmaMEtSYFbTgYddTwT6Q5k7hU7C8fupR0eumdNMcCrOGRSQ7XPnHSr4F4DkjIRC
 6O/PvGLn/cVJZ63KM0YgDQ81I8hB1NTxcINMTfPSmiqXzR+2Yo2AdkfLXNJ1hUQmynX9CWvagtG
 pMmZX34q0gBw==
X-Google-Smtp-Source: AGHT+IHrHQe/gGtpnjuGp01WJdMtGbyDl6MaVugqBX/YEn4FtcnTRmcRG4/lv4qEi6lGJfrvotdinA==
X-Received: by 2002:a05:6000:310b:b0:429:c8f6:587c with SMTP id
 ffacd0b85a97d-42cc3cbdfc2mr6933915f8f.0.1764003300617; 
 Mon, 24 Nov 2025 08:55:00 -0800 (PST)
Received: from localhost ([2a02:8308:a00c:e200::3052])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7fa35b7sm29698215f8f.20.2025.11.24.08.54.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 08:55:00 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Nov 2025 17:54:26 +0100
Message-Id: <DEH2YXGOYGO7.1J2NUI1KD165O@ventanamicro.com>
Subject: Re: [PATCH 1/7] riscv: implement Ssqosid extension and srmcfg CSR
Cc: <qemu-devel@nongnu.org>, "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Alistair Francis" <Alistair.Francis@wdc.com>, "Weiwei Li"
 <liwei1518@gmail.com>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>,
 <qemu-riscv@nongnu.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "Nicolas
 Pitre" <npitre@baylibre.com>, =?utf-8?q?Kornel_Dul=C4=99ba?=
 <mindal@semihalf.com>, "Atish Kumar Patra" <atishp@rivosinc.com>, "Atish
 Patra" <atish.patra@linux.dev>, "Vasudevan Srinivasan" <vasu@rivosinc.com>,
 "yunhui cui" <cuiyunhui@bytedance.com>, "Chen Pei"
 <cp0613@linux.alibaba.com>, <guo.wenjia23@zte.com.cn>,
 <liu.qingtao2@zte.com.cn>,
 <qemu-riscv-bounces+qemu-riscv=archiver.kernel.org@nongnu.org>
To: "Drew Fustini" <fustini@kernel.org>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251119-riscv-ssqosid-cbqri-v1-0-3392fc760e48@kernel.org>
 <20251119-riscv-ssqosid-cbqri-v1-1-3392fc760e48@kernel.org>
 <DEDNGGQCPNKP.25HNT2IHYB0C2@ventanamicro.com> <aR9+NoQVkxq3mcP6@x1>
In-Reply-To: <aR9+NoQVkxq3mcP6@x1>
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=rkrcmar@ventanamicro.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

2025-11-20T12:46:46-08:00, Drew Fustini <fustini@kernel.org>:
> On Thu, Nov 20, 2025 at 05:07:03PM +0100, Radim Kr=C4=8Dm=C3=A1=C5=99 wro=
te:
>> 2025-11-19T16:42:17-08:00, Drew Fustini <fustini@kernel.org>:
>> > diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> > @@ -216,6 +216,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>> >      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>> >      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>> >      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>> > +    ISA_EXT_DATA_ENTRY(ssqosid, PRIV_VERSION_1_12_0, ext_ssqosid),
>>=20
>> Just out of curiosity, where does PRIV_VERSION_1_12_0 come from?
>
> Ssqosid was originally ratified as a separate document but it since was
> add to the Privileged Architecture document [1]. However, the Supervisor
> Level ISA was version 1.13 when Ssqosid was added, so I should change
> the above to PRIV_VERSION_1_13_0.

I was mainly wondering if the PRIV_VERSION_* symbols have any meaning.
I think PRIV_VERSION_1_13_0 refers to manual version 20241017 while the
changelog has Ssqosid in 20241101...  I guess there is no meaning, and
PRIV_VERSION_1_12_0 would work just as well. :)

