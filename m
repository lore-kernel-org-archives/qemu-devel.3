Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B8EC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rer5B-00047q-6G; Tue, 27 Feb 2024 01:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rer59-00046p-2R; Tue, 27 Feb 2024 01:36:51 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rer57-0006lH-DC; Tue, 27 Feb 2024 01:36:50 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so16999615ad.1; 
 Mon, 26 Feb 2024 22:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709015807; x=1709620607; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ENnv76HH9bmfOuMJd1R5CO+Sqty863azKMzrYb60ums=;
 b=O3jVY831t10qiH+EhLDyPLbWt57lLr9e0FaptuJ69/3B5+d2IGUprLVGk6YhIgttWb
 lifM9MbHcuSibty/4VXZoan82PEgG4ZgsRfwS85JX7jWoL5KB2EgEpAgTA8uoFylqr/d
 OuXaujIBHtn3G0kt0sRYeOeU3yRW2F47LzoYNazG+S/A3UVpxjDL2klYQAFnDZmBQcIr
 C8I8+s+xPQVSbbQ1F+0nO8f+V9nvrcPfRY5VUwI/RHZfimgx7JWMA4j/2iRZA37k0Edo
 ilXBJJ/wHNhRsPPI/gNQeURRXlshrwY1d7AweBncVyv+l+hmc+oh1+RVYc/9P/HuSPL1
 E7bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709015807; x=1709620607;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ENnv76HH9bmfOuMJd1R5CO+Sqty863azKMzrYb60ums=;
 b=D/ckV2ogWsh/+gEKDph6KE7GkafsSIBy5uD2kAu21qRHG+FrQJnJ50hOjebnSDkjEr
 sh1lZANmJC2P3xV71PctUNjrebYzVik+d5voWQCuAtPhFgBGibGgkyaSrVBwqBBhHq5F
 kmlTfxt81t3AJCr18T4flz+dPhFyPJlruJUqs0DaZQW2i7Z4HNFXCijS2LZi1vzEeNPQ
 uyhCkruj1aSgXpukkHT/db33juPFSRCMXwVn/Tixc/mACWsYghKHVT3+mBfRphcN05X1
 XdjDn45PQJaejLSOdmxGpNvT9C+SSUFnux25TjUiKBch9j1w/dJ1ENHOmk4mRSZtq63b
 xK+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBkm8DEM1a5yu4z6GwDswqBTrvSb3Ydgppduy0zIO2vcLDNf2H/jj4oM/BwlVDiip8AJZxVTUn48WLpbOxC8zcNpjl
X-Gm-Message-State: AOJu0YwfNYxJbW2dEQREtTCNx77jCIfwe2g/48N7L6seO7RgbpkKEko/
 1OXbwbD4Loz3NwA09RetBzNFgrTyLL7Jr/j7n8etHhyFDU2I/uSwN2Xy4kxd
X-Google-Smtp-Source: AGHT+IFrkDzwonkpi44Qzu6WfD3gkFvrD1WhfuHagQPj8rxq+E7pqEUIaRVkgKwOhUmrQviWfcEkSA==
X-Received: by 2002:a17:902:e887:b0:1dc:6f25:cb7 with SMTP id
 w7-20020a170902e88700b001dc6f250cb7mr10408953plg.20.1709015807585; 
 Mon, 26 Feb 2024 22:36:47 -0800 (PST)
Received: from localhost (110-175-163-154.tpgi.com.au. [110.175.163.154])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a170903248600b001dba739d15bsm743690plw.76.2024.02.26.22.36.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 22:36:46 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 16:36:41 +1000
Message-Id: <CZFNJGTBCAHX.2OZVSK9U6SH2V@wheely>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v6 5/9] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: aerc 0.15.2
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
 <f0b24f1d-1d6d-477d-948d-976b89f922d6@linaro.org>
 <b06a66b4-d31b-d106-1a4b-fcfc9e3bd1b2@eik.bme.hu>
In-Reply-To: <b06a66b4-d31b-d106-1a4b-fcfc9e3bd1b2@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

On Thu Feb 22, 2024 at 10:20 PM AEST, BALATON Zoltan wrote:
> On Thu, 22 Feb 2024, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 22/2/24 12:33, BALATON Zoltan wrote:
> >> After previous changes the hypercall handling in 7xx and 74xx
> >> exception handlers can be folded into one if statement to simpilfy
> >
> > "simplify"
> >
> >> this code. Also add "unlikely" to mark the less freqiently used branch
> >
> > "frequently"
>
> Could these be fixed up when merging please? I'd not resend again unless=
=20
> there's some other things need fixing.

Main thing was the gen_exception_err code shraing with sc. If you
wouldn't mind resending the series with all fixups. I'll plan to
get another ppc PR in before soft freeze in ~ 2 weeks so and I'll
grab this if possible.

Thanks,
Nick

