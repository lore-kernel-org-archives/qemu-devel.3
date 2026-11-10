Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F6606A7C2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=mYpV2YjF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQlSX-0007OA-MK; Tue, 10 Nov 2026 08:00:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xQlSH-0007Km-QR
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:00:07 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xQlSF-00016r-Vc
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 08:00:05 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-8b68e59ab33so1404343b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1794315601; x=1794920401; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZMo+X1qc56rPSUbOWYWYhVkTSNuI8Bf5OhC55lmr9yg=;
 b=mYpV2YjF//dR6swTHF7BUxF0WZqEk98d3QsZXTJuCvG+DJ9g8bzGqDZL5sfXFvmj1x
 bfNu0ZLscx4UFpNeAoBiCQd3yZ5Jm9v2rSpiXUlgSRMwvzyHeCMyKXv9RMVpNGlXGKav
 CFBGnGG3w2RC9EqnULazfeI5ezaE3ZMJ1xpro2Aj0cBhEz85HLJNeOl7wvki8onTISsq
 iakL3fj0GsGkWaPah0e5iSqrVobfJIkTNvan5NDuvZDW03gHZBgqif8pdMgCsQqEMstW
 V7Oz6ZTaxrS5nkFC1z8b80IHJnfZ+2MjLOyhhWjSkAUq9rH9Bim8akudO/723NsuMhM8
 HoqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315601; x=1794920401;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZMo+X1qc56rPSUbOWYWYhVkTSNuI8Bf5OhC55lmr9yg=;
 b=g+QYlC7r4wfGVk1By72RQkr7YsUn4o5Zo9QawQe4FwykilFcCabRwYiRQTJaHgjmf0
 E83o5wZU5pIHWWwdhver1oIk+NqD69LyX5Mq0beCRpDpabjpreo/q5ygxdtYH9GpuERq
 bhS73vZtXXv9rQFN8wkINrfmVNlo+c+TgL7ihHjee2RJTbHU7Ga5gTSW6JFwF1oBoM1V
 vVpTRzzdyS7f4uKTgI+GBHvx/bdWQ4FJMPJhS5slMiw1BBwEdFgdFwWuq2Z5zBHaUGyz
 SWh5ncy1Io1+eSMOX24MUx2qFqK9cvFVrYpNuHEH404E4SmhTEH55usxRJzquPkvyBt1
 phgA==
X-Gm-Message-State: APuU4Z8FFQDHKmoxkvIsyzkcLQw13ypGdq88sL81h4K6MsOVDnvnTKQz
 W6lXwHZFC7zZFmSdowWXxKfeHBlMvCRtmlBt9stt39rQsNLz4tjF+IMtN/LRaaby+QI=
X-Gm-Gg: AYBFou0DLl1RbIh+zccvxHqDX2ChxFHmOrXA6nl7/UuPkIW51wXJ0GpSfCK++zFflJ6
 Th7ItX41uRLfluT5nIrZhKaO79T6FEp2SLKS2mN0kOaMhfhDZxrty/NiU+zVfmMxb1bD6ytklEj
 sFlOcLu8AMg74FIBR3Cym1f2EejoC45qM4oEbK0GW28KzUs/n9u5kz1p+iEbmIdefWyzsrSXz3L
 nsz809zCaXDiyxtY66Imka/Ie2e/gAsJkI9sraNtzTsd8cbaG1sU/VlMcREpV4kdFroKp6CqZv8
 fL0cSSOtSsA1SxZjWm3+K3GHeXVfuoC9jlIkeKCf/Tm5z2R7qLCrbENKBIoF3ZCyrxUoOx+r9io
 9YC4LCINarFGxdA3PrnEd/YpuuF7VPd6Oq+wIrwlQwmMEAd1QEw1RdQaiwubtKmFyRr2fTySk/q
 NkFsxP1e5lT2AseWoRzDB/qAgva0EWhzYsAi4H68WP8T92jP04FC7K0RWLulzZXkxqD29YBDaaJ
 mpIzYilUkZt9dLcdgitNrSAkiynUxB4PKhrrbsFnl5PZYzs4GzOEO7Ma4FV0rTW2UWAhn9KlRp5
 K+qPCsF4+E3XGUrrybTrGnPsafpDqIqd5TNxxcDd3BEKcytrShInPz/KUqFQN5fTwGvkurgAGA=
 =
X-Received: by 2002:a05:6a20:4307:b0:3e2:3737:75fd with SMTP id
 adf61e73a8af0-3f19018a89fmr2515218637.58.1794315601279; 
 Tue, 10 Nov 2026 05:00:01 -0800 (PST)
Received: from sifive.com ([167.103.28.185]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdd8d7a5680sm731266a12.21.2026.11.10.04.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:00:00 -0800 (PST)
Date: Tue, 10 Nov 2026 21:59:56 +0900
From: Max Chou <max.chou@sifive.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
Subject: Re: [RFC PATCH 13/38] target/riscv: rvv: Implement Zvfwdota16bf
 instruction
Message-ID: <avMUr0mgv2Z4I2u7@sifive.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-14-max.chou@sifive.com>
 <ac3eb49a-72bd-47de-8386-0c6cc2aa8382@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac3eb49a-72bd-47de-8386-0c6cc2aa8382@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-09 17:15, Daniel Henrique Barboza wrote:
> On 11/4/2026 4:41 PM, Max Chou wrote:
> > ---
> > +    bfloat16 *a_vec, *b_vec;
> 
> Although we don't have any existing instances of it in the code, it is perfectly
> fine to do:
> 
> +    g_autofree bfloat16 *a_vec = NULL;
> +    g_autofree bfloat16 *b_vec = NULL;
> 
> 
> Sparing us from calling g_free() on both arrays later.
> 
> 
> LGTM otherwise.  Thanks,
> Daniel
> 

Hi Daniel,

Thanks for the suggestion. Will provide v2 for this.

rnax

