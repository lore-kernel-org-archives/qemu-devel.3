Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3170D3E1BC
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2024 07:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t247e-0003rg-4H; Sat, 19 Oct 2024 03:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t247c-0003rH-A0
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:43:36 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arikalo@gmail.com>) id 1t247a-0006TB-OI
 for qemu-devel@nongnu.org; Sat, 19 Oct 2024 03:43:36 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7ea0ff74b15so1917991a12.3
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2024 00:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729323812; x=1729928612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FQ3a6Ym6jY8h+6Kp9vXLv9LvLSTASS3Zq9QQoiZR3/o=;
 b=IOnJ2/6Ee6mfqc7gqIfXyj9UcpOhuHBvyl0rRWDhAdVQTnjExrVuU8JboMFhz3mi2n
 BmBVYd9VeJlo/FEhfnQMAO/l95ZWY5DSulQd51sdk18wUdclPjfHtETXomvaZS+P8s1A
 g8n6r0fJM428wfc4rZQ2GTw9t1BE1Tu92iEkLkT2OaCuhROJHDKJG9Z18/bcJQU/nOTf
 fu0aRmmYkIzFBs7VeKsfjZyNrzhGc7UWocOCpCCxe1gG7pupxeyoncTd37vmOoc04R2D
 ybZZnLTb8QP5oN58H8jLIpID2w0Yv9Tli2nst4CrYkHjXD5i5szthlKvLgMOLkzDvyNx
 M4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729323812; x=1729928612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FQ3a6Ym6jY8h+6Kp9vXLv9LvLSTASS3Zq9QQoiZR3/o=;
 b=NJCAiWG52Jq14zeuQdmjnCT/2znX3QE8YcnHeVGbWu8F+SN99vTj5gy1QDnfHkrG2c
 S3GmHKY0zojageHkOP/QIRodF4A0Ukm1gPmzS6ad4iBL2JHiH3DLTb9Gvxa1jsTe55y3
 vfCId3aN/6Mmr+51yXmxNK3K1QrhqhkLdT2XMNqhgyTYaFkQnOPIzRmJ9Df432aZEstC
 99dKWK7hAxQuNPS+JCe0bWsp0AVFYP2WVht1hhawoapW9D4isGusN0qmstpFFxl2pym9
 gJe4c2P30rMHYzlpy0Okl7ga6Ugj8cA8JvHLxTkYq/bEsSaiLE47H7toTGMtyn55VA6w
 Z6Xg==
X-Gm-Message-State: AOJu0YzbQWg9JuT+mfAsRbxfuyZ/4YZqx92NZXfctkJW3bNTQTRR6sZn
 xv8D8NznhlN9GIMNVyKBr5pq9FS+8l5wSMNCbEJMjOUdEzWVkrVlgBvOWxnFNnoVfb8G4WN+Mb2
 k3oEje1TBvRPgLDw+hqDmCmQyvWM=
X-Google-Smtp-Source: AGHT+IHEVfqaMwqSIgRc22/9bo0MHebTQIMd4sQsC3TOU/LlNBukPFmIOwoia2iKQ9iwJAQ1XXlieDhASsRVJKysy1Q=
X-Received: by 2002:a17:90b:1203:b0:2e2:cf5c:8ee3 with SMTP id
 98e67ed59e1d1-2e561612edcmr6244442a91.10.1729323812244; Sat, 19 Oct 2024
 00:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
In-Reply-To: <AM9PR09MB4851FB6034EDB7FA191BA47E84402@AM9PR09MB4851.eurprd09.prod.outlook.com>
From: Aleksandar Rikalo <arikalo@gmail.com>
Date: Sat, 19 Oct 2024 09:43:20 +0200
Message-ID: <CAGQJe6rWDORxPiqdd63fgzt3xt-TEx6K5Znkai9CqnyszrnkRQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/8] Add CP0 MemoryMapID register implementation
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "cfu@mips.com" <cfu@mips.com>, 
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000087d6020624cf9337"
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=arikalo@gmail.com; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000087d6020624cf9337
Content-Type: text/plain; charset="UTF-8"

Add CP0 MemoryMapID register implementation.
>
> Cherry-picked 9e0cb40adb110c2c76e2e97719ba8afcce72bcf5
> from https://github.com/MIPS/gnutools-qemu
>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
> ---
>  target/mips/sysemu/machine.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)


Reviewed-by: Aleksandar Rikalo <arikalo@gmail.com>

-- Aleksandar

--00000000000087d6020624cf9337
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"></div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr"></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Add CP0 MemoryMapID register implementation.<br>
<br>
Cherry-picked 9e0cb40adb110c2c76e2e97719ba8afcce72bcf5<br>
from <a href=3D"https://github.com/MIPS/gnutools-qemu" rel=3D"noreferrer" t=
arget=3D"_blank">https://github.com/MIPS/gnutools-qemu</a><br>
<br>
Signed-off-by: Yongbok Kim &lt;<a href=3D"mailto:yongbok.kim@mips.com" targ=
et=3D"_blank">yongbok.kim@mips.com</a>&gt;<br>
Signed-off-by: Aleksandar Markovic &lt;<a href=3D"mailto:amarkovic@wavecomp=
.com" target=3D"_blank">amarkovic@wavecomp.com</a>&gt;<br>
Signed-off-by: Aleksandar Rakic &lt;<a href=3D"mailto:aleksandar.rakic@htec=
group.com" target=3D"_blank">aleksandar.rakic@htecgroup.com</a>&gt;<br>
---<br>
=C2=A0target/mips/sysemu/machine.c | 7 +++++--<br>
=C2=A01 file changed, 5 insertions(+), 2 deletions(-)</blockquote><div><br>=
</div><div>Reviewed-by: Aleksandar Rikalo &lt;<a href=3D"mailto:arikalo@gma=
il.com">arikalo@gmail.com</a>&gt;<br><br></div>-- Aleksandar<br><br></div><=
/div>

--00000000000087d6020624cf9337--

