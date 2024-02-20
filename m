Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE89C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPDA-0003XT-AA; Tue, 20 Feb 2024 07:27:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcPD4-00035R-QG; Tue, 20 Feb 2024 07:26:57 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcPD0-0006Oj-QQ; Tue, 20 Feb 2024 07:26:53 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e46e07ff07so1082235b3a.3; 
 Tue, 20 Feb 2024 04:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708432008; x=1709036808; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Swmg1pthiO2vneKYWTfj9agVDiIMgVPosPcSkRKiMwo=;
 b=Lp3AMM+OS/BOYlQ8u5t/N7m28/avvxPu4EhgQaxpWZqeKi/XvAtihgLJwAHhBgy6IF
 aDGfQj7JvPGSBd/H8u9USJ5wKO8Cje4BqTYattCqScuSY6mzrMRoeO3vLl1ZHJ1mb1sT
 Kuj+sGCplhwutqqYto3AmPo6vAXWkEUcFRErJ+JQA2kKI+lMZmLitaUBPHtOauT0mRRZ
 INiSItcmBSzXvyKfVjZiSSxx/ya4UG3QDRv8OVMGYsaXa6Q0mp6lZgx7VVU9Xc9PA/FU
 2ciX5yIPclr38jCyFaqmnfy7h3qZlf6o9tz1gyLeJFr1B++Nz0pZBe1LfXqQFOo4ObH2
 ++jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708432008; x=1709036808;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Swmg1pthiO2vneKYWTfj9agVDiIMgVPosPcSkRKiMwo=;
 b=q2qGQJFItw+GCgpFId4PE5pkHPVgv0hiLEgueeTAWXtCGdcP4oHx7u4SvYRV+66d3O
 4pjVPFDoarh2W/VGg6cAxsfNHi2aA9zQNB/e5DHQei7RA4RnMk7n1Xf//EcgZlW8bWvx
 uQ6ycF78TflXvYABGBNrHf2quQkQrTfWcKuDjApZxpZgZo+3T9KMNH7EUm1wY6S5Hf7y
 wbAKS5KR1W4ZxKkDN/F4EVsp0vWteg0qYp+CvbHEtYSOmTfmmCE1UHiGAsJnOA5Z5AsT
 YgrTeatSA+HvseYxPgjlkWbccQYSz3Vh0bDNWtwP8uNMggLZLU4g6TxtpNKXXurQlM86
 0/CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgsXvTmKTKPfKyLb0GH7+d2vIWcMbIc+/dgA89fLAffld3ozTjfQuM0NmzVRFtafiJGSbdFauA1WaXeQ7wMKknTvxps8E=
X-Gm-Message-State: AOJu0YxdezNZMZ8zDHEN7/JBHn5OcVOMkLTn9Vg7cV1WrpDlz/mbeu5K
 Jrvdd7fcPLXdrLI69963zjMOuU047cYIdee7uMrizK0aMy6+T8la
X-Google-Smtp-Source: AGHT+IEXcJ3sYRsJFKqMPh/5B63u4kGgHRseezvhz1aNTFI1mdcETmqpIsg+XS+OfvcM71JN+Z3mTw==
X-Received: by 2002:a17:90a:eb15:b0:299:17a7:c441 with SMTP id
 j21-20020a17090aeb1500b0029917a7c441mr11950254pjz.42.1708432008340; 
 Tue, 20 Feb 2024 04:26:48 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 mj5-20020a17090b368500b002997c1ec62csm5409398pjb.16.2024.02.20.04.26.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:26:48 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 22:26:42 +1000
Message-Id: <CZ9WLN0L85VW.16ODYXIMLHEX1@wheely>
Cc: <qemu-ppc@nongnu.org>, <groug@kaod.org>, <danielhb413@gmail.com>,
 <clg@kaod.org>, <david@gibson.dropbear.id.au>, <saif.abrar@in.ibm.com>
Subject: Re: [PATCH] target/ppc: Update gdbstub to read SPR's CFAR, DEC,
 HDEC, TB-L/U
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Saif Abrar" <saif.abrar@linux.vnet.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230918092616.15398-1-saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <20230918092616.15398-1-saif.abrar@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

On Mon Sep 18, 2023 at 7:26 PM AEST, Saif Abrar wrote:
> SPR's CFAR, DEC, HDEC, TB-L/U are not implemented as part of CPUPPCState.
> Hence, gdbstub is not able to access them using (CPUPPCState *)env->spr[]=
 array.
> Update gdb_get_spr_reg() method to handle these SPR's specifically.
>
> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

I had a minor comment but NBD for now.

Thanks,
Nick

