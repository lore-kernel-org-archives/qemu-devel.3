Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D081BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 04:53:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2kuq-0005UP-Vw; Fri, 03 May 2024 00:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kup-0005Tn-PO; Fri, 03 May 2024 00:52:59 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kuo-0007rZ-5V; Fri, 03 May 2024 00:52:59 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5e8470c1cb7so5984411a12.2; 
 Thu, 02 May 2024 21:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714711976; x=1715316776; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJXHGosUR87MC0uF1e7wTCZ/N78Gck68SXeqJJLtVgc=;
 b=llu4jp2BxwCDr+USdib3jpMakWiPFehKV/8VWbiuQ1h74uSGez2P0U32T1N09DrU1A
 I3usPw1KKH/CXX08iw9qqQKRNbH2zaI4D4IFf2FsDc7IzYmEQmR4McraWNHsOtrsKdeE
 pJpRRusdG9WNqlbxujSVEk9cWWFptCNEQ1gqJBwk4VcP2oTqMVGZ2waVCWhw8do2EKxQ
 5hC8HtIvIUDEPadS85gzmL7KfMH7Vvd+I20BwzbtEuuKulHYNP00YkQbSp5q2k2MGtn2
 l77q5wtyNidrV9FYuIv5R9EgqVAzrOFZoVT44NygmvSo5Kwhut9CKILPTg6ZInMKxVRC
 RdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714711976; x=1715316776;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qJXHGosUR87MC0uF1e7wTCZ/N78Gck68SXeqJJLtVgc=;
 b=aERUY8g2mfiHnFcx1Q8oF5tgzY+2RZXRKg6IFv8wouNCOAWY60UX6C0P7QCMmI81Zg
 uXgZymKaExLVDFyIu8nLKo5rUYP3Rni6ZgsEGEGjaKucaUYhdJI6Juaxu7bnBPDADS65
 tkyXR9Vw+8lPGohIIvQhSdfeIJnYNIWvERG9rhN34io4pmicmknObwg7Rsz+ZUsMik3T
 pYOkaxRfFow9M8TKh3Q4OzNImG2HD6WmCZrbVUX72wCYSK4CB4mFqZZucz6walQJR9Ar
 q9Nl1IGQZa+sSz1A86w6KovjAFK6uDY4xNPTtpUe5ru3wRYl3uDHYbf9PUYvp3vGCfvp
 0tVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxuIbs4LJQfmn3sQmVZh0Cg3MT8/I8s/jkwhYOOji7adLZ4y3n7NJU8/xM/hjOp1U1XgzhlrTrRZ0LqF6o9Ny8p7Jf
X-Gm-Message-State: AOJu0Yz9Zqbmlg4SKcfQ+E0d7q30BBUoRNomcvSFETyiGqeGbzSaQdRk
 HJ5CViEqRrcZJSCNfEF9QQOOXLZKlkjt9KrmCChTG/iWJhWjlgal
X-Google-Smtp-Source: AGHT+IH6kMBdUk0+hbHnMSRGp3ENCAFpVZwCiDutD2z2tzETLq4FQmEEJWA3jeDXI74FmX42PZCCxg==
X-Received: by 2002:a05:6a20:2446:b0:1a7:a412:c881 with SMTP id
 t6-20020a056a20244600b001a7a412c881mr2209022pzc.30.1714711976092; 
 Thu, 02 May 2024 21:52:56 -0700 (PDT)
Received: from localhost ([1.146.23.181]) by smtp.gmail.com with ESMTPSA id
 o16-20020a17090323d000b001ea26bdfca6sm2264429plh.282.2024.05.02.21.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 21:52:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 14:52:48 +1000
Message-Id: <D0ZQNVR81YNL.EMCJHV8VARRB@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, "David Gibson"
 <david@gibson.dropbear.id.au>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>
Subject: Re: [PATCH v2 09/10] ppc: Make Power11 as default cpu type for
 'pseries' and 'powernv'
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Aditya Gupta"
 <adityag@linux.ibm.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240426110023.733309-1-adityag@linux.ibm.com>
 <20240426110023.733309-10-adityag@linux.ibm.com>
 <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
In-Reply-To: <3d64c7e6-6128-4723-b7c5-11967b0a7457@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x531.google.com
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

On Sat Apr 27, 2024 at 12:32 AM AEST, C=C3=A9dric Le Goater wrote:
> On 4/26/24 13:00, Aditya Gupta wrote:
> > Make Power11 as default cpu type for 'pseries' and 'powernv' machine ty=
pe,
> > with Power11 being the newest supported Power processor in QEMU.
>
> This is too early. We should merge Power11 support first, possibly in 9.1=
,
> and then change default in a future release, 9.2, 10.0

Agree. Since P10 is the released chip that is what users will want
to use. Developers can set -cpu by hand.

Thanks,
Nick

