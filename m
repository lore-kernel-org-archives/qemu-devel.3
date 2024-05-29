Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E6DAC25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 00:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sC709-0003MJ-OT; Tue, 28 May 2024 20:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC708-0003Lz-1q; Tue, 28 May 2024 20:17:08 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sC706-0000OQ-8D; Tue, 28 May 2024 20:17:07 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2bdf3f4d5ffso1190323a91.3; 
 Tue, 28 May 2024 17:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716941824; x=1717546624; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/IIhxLm0bdauQm+U/mwl2+Ph2brwdY0aU3xObzJMxI=;
 b=QY6qRAi3vequcX6IZ588cBVnlZmgIOzSUCa7U1XjY6H71iYFjLh+IEqRHYXReq/ufq
 9MQ0UBHu09NtzAfG316x/2/0haiUzmabjt9FMcKq7+pFazsMXvT2W/8mRZkpdffqNJjK
 d/TPuxRfxRGCVtquM/uBZUkXhNlEC+1LWhrjbyBrU3jf15+pmLU+sIs301RCrPobFjXe
 JRsWWK/FJ47fJrNWB1vtMjlq9JDbeNiWffNKp8yUrg6KivoNDWUVbtowiMcY3StOil/C
 ens74weYT4qopfBsuVt31W5WsL0n5QhUfaCmxMwx2Vyk+JznoJYexk1+Ze8k+EvrMVUh
 4sHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716941824; x=1717546624;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=E/IIhxLm0bdauQm+U/mwl2+Ph2brwdY0aU3xObzJMxI=;
 b=mNI1pe4sv5ZLv+zyZoeKuWl8FQPsLbxRcVVQlUP+OtMHZ6vmHGL6SLyX/E9lBX+UMn
 T1sSPts3k2WRbgywWvK1Md7ECwb/amKFsSdQb/iUhpNy3RqUxam8PcMexNrZj7JRoMeE
 VImbX6fqn3Ha9y7FgLQfrf8ZGyj0trT/kQfosyCi5l1tZWKk+MP4X43YDMny7OBQ+//h
 jfl8we99p6jUNAN1wNYbqbTRTB77QCveCJd74Md4NtTjUBRI4pCj4TKBqptSUGxStS1u
 Gzr6mnxHYqhtZqQjyw+MrXyFcW0SFFyj5phD4NG6sZHyvPEf2yHQH9YoN0OSIomkU3Qa
 k1Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeXagsy1GE0ZEPpvqWgiGS3uYXYHiJzyYbywhptc/sWnIrrQ6Ct1YzYcnmVC65ZgMg8WqO+xgqtHnzsFfqDWir11bG
X-Gm-Message-State: AOJu0Yxq6fPGM2hGbUSHG5XgycQi04Uf2yWJJAoSvfVW4Cu6xltjbIj4
 PDqFudpjL5Aaa6WB5QY1PN//f2I2Lehqr+lozlPDiJMgJddFKIoA
X-Google-Smtp-Source: AGHT+IEYcTIfUxHrbDHC5a9VT9CkLXhH/ZVJjzjeVzS8IDeG6GSD2MZvcfDKly1Racw3P7rRMYFymg==
X-Received: by 2002:a17:90a:e7c6:b0:2bf:8f9f:4adb with SMTP id
 98e67ed59e1d1-2bf8f9f4c62mr8341852a91.1.1716941824066; 
 Tue, 28 May 2024 17:17:04 -0700 (PDT)
Received: from localhost (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bfcf3f3ccdsm4378898a91.47.2024.05.28.17.17.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 May 2024 17:17:03 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 May 2024 10:16:58 +1000
Message-Id: <D1LP2UJ14DJ2.B5J6N64F9URO@gmail.com>
Subject: Re: [PATCH v4 11/11] ppc/pnv: Update skiboot.lid to support Power11
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, "Aditya Gupta"
 <adityag@linux.ibm.com>, "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Joel Stanley"
 <joel@jms.id.au>
X-Mailer: aerc 0.17.0
References: <20240528070515.117160-1-adityag@linux.ibm.com>
 <20240528070515.117160-12-adityag@linux.ibm.com>
 <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
In-Reply-To: <968da156-8621-4509-a0b2-726411e71b5e@kaod.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
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

On Tue May 28, 2024 at 5:15 PM AEST, C=C3=A9dric Le Goater wrote:
> On 5/28/24 09:05, Aditya Gupta wrote:
> > Skiboot/OPAL patches are in discussion upstream [1], with corresponding
> > commits in github repository [2].
> >=20
> > Update skiboot.lid, with binary built from 'upstream_power11' branch
> > of skiboot repository with Power11 enablement patches [2].
> >=20
> > ---
> > This patch can be skipped for now, if need to wait for patches to be
> > merged in open-power/skiboot. Have updated the skiboot.lid to aid in
> > testing this patch series.
>
> When is the merge in skiboot planned ? QEMU 9.1 freeze is in ~2 months.

I think I will try to get spapr bits in for 9.1, but may just skip pnv
for this round since there's a bunch of other stuff including some pnv
churn I'd like to get in 9.1.

Thanks,
Nick

