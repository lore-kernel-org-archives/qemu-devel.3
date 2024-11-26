Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F08FFD3B7C1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 09:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFrtE-00027U-VZ; Tue, 26 Nov 2024 04:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1tFrtD-000272-4P
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:29:47 -0500
Received: from gw2.atmark-techno.com ([35.74.137.57])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dominique.martinet@atmark-techno.com>)
 id 1tFrtB-000290-D9
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 04:29:46 -0500
Authentication-Results: gw2.atmark-techno.com; dkim=pass (2048-bit key;
 unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com
 header.a=rsa-sha256 header.s=google header.b=hk4pSnja; 
 dkim-atps=neutral
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by gw2.atmark-techno.com (Postfix) with ESMTPS id 1B426526
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 18:29:38 +0900 (JST)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-29678d451b1so2937575fac.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 01:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=atmark-techno.com; s=google; t=1732613377; x=1733218177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ytpt1At+kByxx2N4/uIMj3TAJFX5iDpIGrRspMUx5TQ=;
 b=hk4pSnjaJB7lmcDk6JkOHT4RqH2TEYV6EPX124/AX4hVo1ITiQJjXihG/EY5BR8ZKW
 JkBm0S+qNn7S4nIXA5MDfJd7cgXdX6a87pJCwwgE80NGWF0OjcjYSeHDwzv2gTrmbzPM
 2YTB+BbMxCP8TjT0rKtGulFBB9wHaUr3EhSb1K2r8+FD7KF8vT4pF7Zv1iAUNjYNChNq
 Vw6vfOmif9LmK6oAOo5hbcqeRLsF75xnNP08D473drw3Mm0zjuIOegtpZtZ0F01z9GX1
 y4oiWh6mqpui3Mm/GWMhb3thJLyo0hLe5IzV+gq5lVs4UJ73c9BgkAI4LMasf7e8OTCF
 jcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732613377; x=1733218177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ytpt1At+kByxx2N4/uIMj3TAJFX5iDpIGrRspMUx5TQ=;
 b=Ym5+l0Pypg/lNMSKT6MDILjTJ6FWdRGI1Ml9sE04aqpIk3QjX9uHS09IUctshBm2LK
 s21PaHmRB8OgUVlAVHEz98/CnIz/rKtri8hO1eE4eo8arCfn2g6Mk6cmFXfWAOwlbYFl
 Owv2wRFEFr0asndXqHC65Hn8iO5k/qJ6kBv+k/s+rdte7O559t1nNnRv3D0/NP+xx1ZP
 LXX/AKFyj7lcQlPuY2cWwlBIzh0L+XgLy0F2gmvw6kOXbupvngwUoebu/ErysdW8n6i7
 8KVf+Cq19uzKlnUQK/7yyAMDvw/gSzZ6npNXBkkqv3JhpCWvsP5GbPtFkMgKrEHJRAWr
 VJTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK5L/FvsbKFlyVsnJFoOxqr91b1abRQOHUm0fde4TE3gp2zBrM7GYtpGpV8lIr7kKydbwXFmu+KaD/@nongnu.org
X-Gm-Message-State: AOJu0YzJdd3lD4LUv6M1wJFVbDx9MEKC+uSFBikzdDCJFvXTKoxrC6eu
 PjoREe7p1+JvCKdmKqt9U82bsufBKRO4xW/k3fvKOXPpunBY1Ms1DLyRNH7tl95ljQfTm3vqIZi
 Yn3mg/NOVCu0xDcC8nmJtH0NXK9xKUlszJ//PuyaYuuEuRWNLlNjdVg==
X-Gm-Gg: ASbGnctOkIo5ffu03p6izV+6wNmnSrFv1GacQLDVxs3OjhP+VKDQ4F8z2WJ2nsdvI3/
 L+hpPLlQEnxWLEOytGJyKddMHSltdOh4t8T0dxtdeUrCCIICRsyFeqtXd3D8pDmQF8nTh6OZiC+
 i6l6JcmARhtbU+iM1S0j4Wc6RdOJ2EbDGT3lO0oLs1pltmDRGb5bUTfceT7MtJrnQk4UyFh2iFU
 KSZQAND+oy9dZBjgJylSzFgdf82+S26JMGoK1qscwjsrGBV99a191aNlNMQdJXvxUgIS+U0xP1/
 6zp1fVJ0WHBPQT4R83yohlQWq79jERVYYA==
X-Received: by 2002:a05:6871:582c:b0:26c:5312:a13b with SMTP id
 586e51a60fabf-29720df620emr13587912fac.30.1732613377581; 
 Tue, 26 Nov 2024 01:29:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb2oy79f1fT/p67Da8bzjREHu+Ufr0ESzqkHhkVuHIuiz3mHdCQ4vfJpvL2jktRt+ipG21Dg==
X-Received: by 2002:a05:6871:582c:b0:26c:5312:a13b with SMTP id
 586e51a60fabf-29720df620emr13587867fac.30.1732613376354; 
 Tue, 26 Nov 2024 01:29:36 -0800 (PST)
Received: from localhost (162.198.187.35.bc.googleusercontent.com.
 [35.187.198.162]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbcbfc4c28sm8222084a12.3.2024.11.26.01.29.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 26 Nov 2024 01:29:35 -0800 (PST)
Date: Tue, 26 Nov 2024 18:29:24 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 deller@gmx.de, qemu-stable@nongnu.org
Subject: Re: [PATCH 3/6] linux-user: Adjust brk for load_bias [regression]
Message-ID: <Z0WU9GN9TBjJ1fbs@atmark-techno.com>
References: <20230816181437.572997-1-richard.henderson@linaro.org>
 <20230816181437.572997-4-richard.henderson@linaro.org>
 <Z0V0undiZVtHIy7z@atmark-techno.com>
 <3f1f56122cde6ac457f774b79fa4ba4113a38a33.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3f1f56122cde6ac457f774b79fa4ba4113a38a33.camel@linux.ibm.com>
Received-SPF: pass client-ip=35.74.137.57;
 envelope-from=dominique.martinet@atmark-techno.com; helo=gw2.atmark-techno.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ilya Leoshkevich wrote on Tue, Nov 26, 2024 at 10:24:12AM +0100:
> I think this is
> https://gitlab.com/qemu-project/qemu/-/issues/1913

Thank you, I should have looked there first !

I'll continue to follow-up on the issue if time permits as it doesn't
look like this has had progress in the past few months

-- 
Dominique

