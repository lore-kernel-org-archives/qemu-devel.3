Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3EDC48BF8
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 01:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcEkY-0005Tb-9R; Mon, 19 Feb 2024 20:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcEkU-0005Sq-Cp; Mon, 19 Feb 2024 20:16:43 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rcEkR-00011c-QL; Mon, 19 Feb 2024 20:16:41 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so6588125ad.2; 
 Mon, 19 Feb 2024 17:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708391798; x=1708996598; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SyBPUOhf7rTliTeN6/xMQqpvcUtjA3nrBIb86M+2emM=;
 b=U2VXbzA6qB93HReTKA1KRsj39Tyj/3k9QGvsXCr0JPGPmxBRgvHJHQfORzLbxuTgiv
 mLKLF3uFdIE89PFrpBIfgVTAsRYxFK/+ndAfyVE70qTIqcbod5W3o1FAobJQvR6druHm
 m36u46PmEkUZBqoacu90hMtKE2S9UdT5BwCWx3FEn+gB7L67wi0aeM4+av7YutSCcb2S
 ZUU8I8B9uG223M54uI/owKOFv3Ry31bNRQcO19FLvm8L8diFugq+k9iWVX5TsTZ14Phb
 sH/pVex80r+dTJs93RsE8SPDhOUaNApprZBYTDXWgfmE1bqpiSpIz1pjalqkWSz6LWag
 /mTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708391798; x=1708996598;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SyBPUOhf7rTliTeN6/xMQqpvcUtjA3nrBIb86M+2emM=;
 b=XMo6sG0WfWUkD47T++WRdRJVOTXo3+ZJ0+aVYfnUN93Y4EgzUY4tPYQqRPUxNoaShA
 SvJ7m2V8x6xAdycNWyxFsKsi0vfD2rO8UkfHy5e6bw/p3FDSjJSkRm1YB8NGrVP0AmCP
 cLaWjxkLacYPwY6JR3ot7ag1bpAOLorTak1t+kXooTMx5lvluk0Bm1hZoXkkChx5OGz7
 A4aN0r3RGeFaWGt2bwKXEPapmAdIeBQ/jmkmi8QHgT2n4Q8C42BuoWt96WhxGUHTA4zB
 24f2I3/OqRwhsg2CJ+liAwWRkfcZZpLkZMjjHyspvvUFFnKBYNUgcoqJqL8bE8+TgyT3
 CVLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmNVdEy89oT/7lwThBDQ2i4jbFHHqbRBL/UXnT19oAyjoqCJXBT65vGn39SUuwFyYvfBl3A3LeQMhCSAIaLVR2DX+r
X-Gm-Message-State: AOJu0YzCvBSYxXZAVwY3JGK9YyLPmkriOM4F9c/8ITpX4NYXE0189niw
 2vgajcBUWqAIY+r57UjtSUj2l8fhfiw7LlGJmjEwt74yWGP+JNgtRMiQTUIw
X-Google-Smtp-Source: AGHT+IHfYpXQSY6BJUn3jqMxS+BHxm+UILYojwLCDDfKp6wrl5u+mrT2jtmjGHL5ghuzqUJSYGqr8A==
X-Received: by 2002:a17:90b:3847:b0:299:8265:c79f with SMTP id
 nl7-20020a17090b384700b002998265c79fmr3079710pjb.46.1708391797868; 
 Mon, 19 Feb 2024 17:16:37 -0800 (PST)
Received: from localhost (123-243-155-241.static.tpgi.com.au.
 [123.243.155.241]) by smtp.gmail.com with ESMTPSA id
 k10-20020a17090a9d8a00b002997a5eea5bsm4086687pjp.31.2024.02.19.17.16.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 17:16:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Feb 2024 11:16:31 +1000
Message-Id: <CZ9ICIIHUKHQ.10AD3D7SXFFMU@wheely>
Subject: Re: [PULL 09/49] tests/avocado: Add FreeBSD distro boot tests for ppc
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Warner Losh"
 <imp@bsdimp.com>
X-Mailer: aerc 0.15.2
References: <20240219082938.238302-1-npiggin@gmail.com>
 <20240219082938.238302-10-npiggin@gmail.com>
 <dda9aa91-8673-4698-b97a-5c43dae0b0f2@eik.bme.hu>
In-Reply-To: <dda9aa91-8673-4698-b97a-5c43dae0b0f2@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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

On Tue Feb 20, 2024 at 12:49 AM AEST, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Nicholas Piggin wrote:
> > FreeBSD project provides qcow2 images that work well for testing QEMU.
> > Add pseries tests for HPT and Radix, KVM and TCG. This uses a short
> > term VM image, because FreeBSD has not set up long term builds for
> > ppc64 at present.
> >
> > Other architectures could be added so this does not get a ppc_ prefix
> > but is instead named similarly to boot_linux.
> >
> > Reviewed-by: Warner Losh <imp@bsdimp.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> Didn't you mean to put this below ---?

Yeah, I'll fix that too in the PR respin.

Thanks,
Nick

