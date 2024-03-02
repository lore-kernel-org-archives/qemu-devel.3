Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D31DC5478C
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Mar 2024 10:04:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgMDl-0007f2-Oo; Sat, 02 Mar 2024 05:03:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgMDk-0007ef-04
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 05:03:56 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rgMDi-000705-KZ
 for qemu-devel@nongnu.org; Sat, 02 Mar 2024 05:03:55 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a44cf608a39so48964766b.0
 for <qemu-devel@nongnu.org>; Sat, 02 Mar 2024 02:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709373833; x=1709978633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF9HK+PyC/WtUHTAO4TbjYZTwjkaK6YrSDapHwYfDVQ=;
 b=WAz82tDpYcQxbXssBhxSZJPd7zykPhZMeg9EVohQpSKfm+Q1EOu3KxK9Cg0b8jVa6U
 8l/08soNehkShX9nwldFioJ6ttc+EQay4ul/RL39IO8PWJlU1G963RAhBxK76GNYZfsS
 jmGXVZ82dpQZKudnh8JaiLWwH/LNSX65FQjXJ0tNUEUQHY5ioEQI1wRtz+ETI4ptLPTk
 7t3Hrlp+hG3kzDJQudRKhiaZUTbl0PsAgxvE0sb41Yxu7naU+0zvRQRj5PC5wHYC1hd9
 ehMl41kslUeR0cWuIPWjS49OvLcVOhjnfjXlN1Fje0C6Me0YXcBLkd8zeQuWN/l/d2U2
 QOxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709373833; x=1709978633;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uF9HK+PyC/WtUHTAO4TbjYZTwjkaK6YrSDapHwYfDVQ=;
 b=tjmVAHtTtzWblDsAZMVv/EXeBKhX4gHmRA4XaDRH0xjU26bkM7Rb2qMndMF30I7ftV
 vFD4Jza/aZIiYYsPXJ5tJEx0PNJSvmJzY87wiUyvhuIUnCkJLofzI4rDrw6LOVMXAe0v
 BzwiCXltTl+3C0jpul61HJpdW8PN+BghL73b5KT6eIPXDsspxzL0bKw4niXjef3e+Jbi
 +z5K6E5kRQr1bm8mSEvle4QStAd76PLR3Tg0Gv9tbvf82rNtB0k9XAF63E4IjtY93R3s
 ZRCh9L59wx/ZWcDnLaI01YJTB1SuV88TPTNF1HlvEQXJ7e2E18x62TDGynS8e3DpbXYR
 KVbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1cuM36tmkmvoSpT/7xv64t5txHRr+0wQqYL8F+PC88JR76YY6UCvq1nYVg14MhTFZjP18bSUW1b+MKCQFeO3J7eMRvcY=
X-Gm-Message-State: AOJu0YxybclnZQH0JDQBGeKH9hKuEagDzmjYkOcLMDzqb6kHTv/2aL/8
 /gakt/4M+EozBP5JmGGpYkGWxwFy7IoKDRVVlm5QBljwrliFaoDS
X-Google-Smtp-Source: AGHT+IFegZhau6x7fiOcXdX8MFUOrp+txp1ZzqV0VliOeSa9ZFJVPSKKCpEKCQX+9BVwP/8gxwNbkw==
X-Received: by 2002:a17:906:344d:b0:a44:9481:4fbe with SMTP id
 d13-20020a170906344d00b00a4494814fbemr2917255ejb.49.1709373832494; 
 Sat, 02 Mar 2024 02:03:52 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-171-109.89.12.pool.telefonica.de.
 [89.12.171.109]) by smtp.gmail.com with ESMTPSA id
 j22-20020a170906475600b00a449d6184dasm1227637ejs.6.2024.03.02.02.03.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Mar 2024 02:03:52 -0800 (PST)
Date: Sat, 02 Mar 2024 10:03:50 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
CC: Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/4=5D_hw/i386/pc=3A_Have_pc=5Fin?=
 =?US-ASCII?Q?it=5Fisa=28=29_pass_a_NULL_pci=5Ftype_argument?=
In-Reply-To: <20240301185936.95175-5-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
 <20240301185936.95175-5-philmd@linaro.org>
Message-ID: <34E8F0EB-671C-435A-B505-AE8DB33C7649@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 1=2E M=C3=A4rz 2024 18:59:36 UTC schrieb "Philippe Mathieu-Daud=C3=A9" =
<philmd@linaro=2Eorg>:
>The "isapc" machine only provides an ISA bus, not a PCI one,
>and doesn't instanciate any i440FX south bridge=2E
>Its machine class defines PCMachineClass::pci_enabled =3D false,
>and pc_init1() only uses the pci_type argument when pci_enabled
>is true=2E Since for this machine the argument is not used,
>passing NULL makes more sense=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

