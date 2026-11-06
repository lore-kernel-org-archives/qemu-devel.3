Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C62D606A32C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbPwcbBd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPQap-0004IL-DE; Fri, 06 Nov 2026 15:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1xPQah-0004I0-BL
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:31:17 -0500
Received: from mail-dl1-x1233.google.com ([2607:f8b0:4864:20::1233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jrhilke@google.com>)
 id 1xPQaf-0007iU-QA
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 15:31:15 -0500
Received: by mail-dl1-x1233.google.com with SMTP id
 a92af1059eb24-150ef97e790so947c88.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 12:31:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793997071; cv=none;
 d=google.com; s=arc-20260327;
 b=rjjkZwnlZDGZUJb+LwLoGhQCgKmzk22fBfiR3oajw36nbScRpJRDojEUeV3H9fg910
 HnBuzXoEaxc1XBS3byqWgq+/SPd+D7WWEGKjQ4QlfhmDSHfFHfPJg7T44JYeOVldw+/A
 h/aDFwveh8ofTx+4LgO5CGke2fSqVqSgI6/WZiNk+0XbK6kisdPFJDLyclN5p+XYkax5
 r7oo5RsIkcLE9DFytCrNFm6NrbicRn9t29RtmmL0jj90jFp98nkRXgZ6s4uMNXWsaBbq
 FGjNI6ocqq+fHN+k6plL8jN+qPDESqmgOP7pL+ZRLj1keKswJ8sZ8hlCUULYa1MusSbG
 CFMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sKrkRuCtl/EbDCGK3LInrGyHt5BZZutlJaNdwNTR2Do=;
 fh=bNpFBLLESImBaNMtRzt7JipGCMANiwbL/y88Wo+5eJM=;
 b=akDFJxx83+NMD7/B94dxI27DudqrCFjWCcuBVK50ndGaDXtquQbW+enm/XEzCSZU9L
 TNYB0e/+1DGTWjvU4wOj8QvahRPkO7XwYkWqBGhAwMTRDk3vOI569l3JwMtKUduFNylq
 gZv+iplG2s2Xu8zQnthjKQUTo9VZtknAsC101FKr8QoYABkHfhxKGT3q2KR/X9plbZ83
 vy1XFuZ0Z1OF09YkpcrNgDWzCeMUyqFq2UXqqbCZWIQgV+PWasBTjmuDCbh24Ox1Timd
 kuUVtZtosY4iDj3GFdhb/K50CLRR6MyO72gRAsGErBadpg5cE46L+nTcVPYznZgCSDCW
 oERw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793997071; x=1794601871; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sKrkRuCtl/EbDCGK3LInrGyHt5BZZutlJaNdwNTR2Do=;
 b=lbPwcbBdwCggFacV86fm1qujibHvgoowRGBGzZ4k/uyIdL6kig8ijuQVrefPAyShOV
 IcsrrPsiMGykugJ3GedhXUVFtyZUUZ5+XCk1vdptNyH68KBLAIZbmQk8ey/sm8cbu/rM
 8SSqRD1PNR202e0I3YS8LXfuhVH2KKagXEiqS5XvXz7qQjPVlGGrLaNn19xPDJehfmMo
 JmEjzcAznBfludL9374lShbyj9n074WFBMd6n8v3pTeWbaUNyiwqd40vR9VFEdiObn2c
 oYalJ6dNKE0Hb7fDj4pBY5LohBpVYSPp6H7+37T/1UXB0qPxMk7Nn/S+0I5dDX+517HI
 D6LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793997071; x=1794601871;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sKrkRuCtl/EbDCGK3LInrGyHt5BZZutlJaNdwNTR2Do=;
 b=qmwDGDiTBTM2WolsGFhsrxv20dYhqpIAS1WgJQ6kvrwGwJGvejKhjTtK4K7fzPep03
 xVm64NSSs0KUTV615QWmt68l7QMZNyMbfiIaXF5no/NbfWzSjXEgXqkGDjFvcvY+Ghee
 BA0LHsRR6s1DRtjT7CFURXQM+3vyixI8i4mHZtHFQ6hgZ+Gln4fYC/cD2i8KFhwgQOr3
 ArZR4qK1NpqIu9njqjGx2LST+ESu8c1MWk+qA/R0ZFZHFivyskreDi5FYLllXahVFXON
 KDSY8LW4/DvA+e6oQmPDxE7gA5GKQJilqmeBRlC7BxVhM2+XPB4s32JgO/kQgrbCeS42
 KInQ==
X-Gm-Message-State: APuU4Z8XxPnqf6yzXpkr92v71e/8FT06UqYqu+cf5Q6MI9miuP+yz+pC
 ahQx5sUVWaMYBzY4WY7/3oqtbs/BJ2I0qjlxFd45O+0Zs05Tz9/f8eHwTvaSQkSj5txYFzKzhWa
 p19LkM0RLFE76g3BHJxXEzlebw4VcsN3t45pOr4k=
X-Gm-Gg: AYBFou0Th/3SUjncm2q+oNaahn7VjouwxOBEzMBZAmYNH7jsB4aRX81FLueQJpvCfZO
 oiNvshrGGGNYf3MkOBwgL3CS/8nBgdR0GJfXLEM5eY8JXQhKH7XqLAp7ZnOmfypgyjEy3oEpp4F
 FXzkd7PSkm3igBh64Cx/3QO814pLsOmC1P02NFF0LddyayZdFPx/6PRwn9tz4p6rcT50DG3Ru4C
 ThMA7HuYG429Jy73qu/ZoIUm8vE2SfPxRWH0tDJBQuAK84IIUh8hnH4e4KFTiG+gWTj0cyC6glW
 me0T6qBTp/xf4OBOeBTvtuu5X9xd4SLaP5WdNAU2wCaqX4k62+zU1nsZiCF1nGyIUxHoDbPouBW
 BgFOjhOWvTo09wX9pPniCj052BnXWLV13gBOe+WrB7IFTPji0QtUbS38ubYAaJvGHW2d0+JbAQM
 59K27ttwQYnjIKGhWBUazvB4E=
X-Received: by 2002:a05:7023:90b:b0:186:2ed4:45e1 with SMTP id
 a92af1059eb24-1b26962daafmr46162c88.7.1793997069693; Fri, 06 Nov 2026
 12:31:09 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260623-igb-trl-v8-0-c9b1fc6c3304@google.com>
 <ff0bcd39-afd6-4842-9cd5-3e39e56ec901@rsg.ci.i.u-tokyo.ac.jp>
 <CAAdrzjtjVyG-yV+MnZ5wtgef3UQ-MLCWZtHh9feeBK4ek4YXJg@mail.gmail.com>
 <f2c35b50-264d-4268-bd0e-dd52fe6269bf@rsg.ci.i.u-tokyo.ac.jp>
 <CAAdrzjvgpkSO14HZnRz2_X78LriOqo4G5ePwyh_4guKE8HWZCg@mail.gmail.com>
 <61b505bf-f8a4-4882-8dfa-e8f55aad54c6@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <61b505bf-f8a4-4882-8dfa-e8f55aad54c6@rsg.ci.i.u-tokyo.ac.jp>
From: Josh Hilke <jrhilke@google.com>
Date: Fri, 6 Nov 2026 12:30:57 -0800
X-Gm-Features: AclHuK9vJeURvM8DAaWqXQIQ4fE9iRQYB7iXkKgs9wGZH3M7FkurBTXEFydw-J0
Message-ID: <CAAdrzjuSo7dufAWkiHfUbCsnTkQSxamjJJ-4+F4h+OL-vyxNAw@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] igb: Implement Transmit Rate Limiting (TRL)
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, David Matlack <dmatlack@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Samiullah Khawaja <skhawaja@google.com>,
 jasowangio@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1233;
 envelope-from=jrhilke@google.com; helo=mail-dl1-x1233.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/08/07 14:46, Akihiko Odaki wrote:
> On 2026/08/07 3:44, Josh Hilke wrote:
>> Which version will this be added to?
>
> 11.2 since 11.1 is about to be released.
>
> Context: the network device subsystem has been the "Odd Fixes" state for
> a decade (i.e., no one is paid to maintain it and don't have time to do
> much other than "throw the odd patch in"). Jason Wang used to make pull
> requests with network device patches (igb and others), but apparently he
> recently left Red Hat.

Hi Akihiko,

Could you please send a pull request for this IGB series for 11.2? I
don't want it to get lost.

+Jason at the address in MAINTAINERS.

Thanks,
Josh Hilke

