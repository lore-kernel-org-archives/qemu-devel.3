Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C144606A334
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=pGvoY7aA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOJIv-0002lj-7j; Tue, 03 Nov 2026 13:32:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOJIt-0002lY-7t
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:32:15 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xOJIq-0003l5-KN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 13:32:14 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2e5fb79ce82so29643795ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 10:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793730731; x=1794335531; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8aID7GLUL64Z3LYrTFmUeHFnZDzvn+wOuaI29RKbnJI=;
 b=pGvoY7aA4smZZK6M76nSNSsTcbmvp7IsEVjdIYltOvf7nQ7r/SMAxpyJSL7zZY+LYY
 8ln53tDYV6xU/4tkGCObWnZdaR3zY7HOEZUJwsHWIrKc1Bhrfo3e5au1wEVO5LplgfQd
 7SeLr82j1bEzLvcqGSTFzH8FC71pboCGA4iZE7mhoipQiCk+4/ih2U4UO1zKRn5/nhGv
 g22VA1FsJGXQHtGJnPYogCrVvetSBG+iIH4PdVQmjpBjh7xDftOPGL/qvGHA4wAJ7eza
 0xB8VHbEJ17CPpuhhCOb+w/l/kjuc00rnOTEhoKZJF358tLH/rR6an0pUyd9/pTQFT0J
 Wj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793730731; x=1794335531;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8aID7GLUL64Z3LYrTFmUeHFnZDzvn+wOuaI29RKbnJI=;
 b=2KzPvnKhslN46z0FBREOJEWSvobCnhbisfpLSnlBk13XJ0behG/yYb9OcBfJyfSWqu
 nCDAywoXbdLMDcPPq3D+MUPWVykLWxnicc36+gB+n3EAzhAs45KikDeuZ7lftOg6vS1S
 URlqOVSrhgn1J7VL/6KXut87lq/VyWYYeObTUBWcX/om2Y7TXJITtuq5n6nizKbJxd4+
 4A9SM4HtXdUpdcUcW3EEsUGsaFvqX8OT+AQKqTRYCYecEqN/jmqjfYzgjYbM4PbkvBWT
 +ZVlKS68ASO6bFZdLAtTQ2Y/lxgxmPW/TQe/nUrCkhow/C+NI/ViQ5dGVTPKoR3o5skC
 6j5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy6mg3eIcMacJLabg/f++aP+NsIfRnfoXg861Le2mfCr10MikrbJx2hvAjvq5HN8CYQJk6RBBok+bV7@nongnu.org
X-Gm-Message-State: APuU4Z9jEeKSytfZkU4gXRRYdUEw4oIzSv5BPq5QIonGsS7ZCXDpsF14
 MVt+D6l7xTVu+PEvbv1IEemuo/1E+MsdnQ/Bi0Wyfcm0cIrSVfxcpNO2GFDA+t6Rx/8=
X-Gm-Gg: AYBFou1GJVborov2AmgbyDqhQ0y8Nbase+UZpYMbXzcvqUfTx6yYWoD8VRSCXYYjnmJ
 F18/oVXnf1gQm5pZ7Wj2+qkc17wAqV0+9YowyqbABYopZrZ9wLEV2XizhkCj58FuM/AMgh5l+Zr
 5NwBVi4Ga/LW5V55iw+ieJH1PZdST0AScXlE2IK/bc9Y+O6zIdvkhSrZFZUXTCAxkpzkylzWBDS
 HfKFUR3WXvc72tQYy/96t7bjinD6m5WjOzqsjboKfTejzaCvMblE3Nuq3afRY3Pokkqx2qATeHb
 RFtVwn1kaykslgL+1IbpCQLVV1yNz0OOukkxFVxD20EIKECNWiFO3WsDy/C/Rp6P/itSHyR/G9w
 GZh7JZUqJ81INQrRJuq/O21q9EOE9ECcXOQWDmvbp72WlznFHOapuNt9RxTLi0VHFPOQyfSd8e0
 iSWSnbWji21ttlbMumJvwPosMFNUGQeaJBBrYsuSecnTvrRTYdXyP0cRIE4nc7EirOcQbsvbS6z
 YsHkeRZcAGcH+GJ09OWt66JXicEY09AHFvZY89pXn+T+Cz8HXaMdPXiEN8/337beRGyDsA1SYXR
 IXn28nuMzJW/x8QyoHH2cYT2BeXGfRrNsQNCcWhuAhycQuDZ6fIy30aa0dNtb804/O0M5QM=
X-Received: by 2002:a17:90b:1845:b0:3a5:133:ca5f with SMTP id
 98e67ed59e1d1-3ae89787ea2mr9979478a91.46.1793730730599; 
 Tue, 03 Nov 2026 10:32:10 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b09445f7b3sm170044a91.5.2026.11.03.10.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 10:32:10 -0800 (PST)
Message-ID: <9fef8cea-fef6-4d29-bd6e-890d4f1f6b47@linaro.org>
Date: Tue, 3 Nov 2026 10:32:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/74] QAPI patches for 2026-11-02
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20261102184137.3310251-1-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261102184137.3310251-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 10:41, Markus Armbruster wrote:
> The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:
> 
>    Merge tag 'qemu-sparc-20261101' ofhttps://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2026-11-02-v2
> 
> for you to fetch changes up to 861eb824ca6a6ac031e82d27c483f3828d2b5048:
> 
>    tests/qmp-cmd-test: assert qapi-type resolves in query-qmp-schema (2026-11-02 19:35:21 +0100)
> 
> ----------------------------------------------------------------
> QAPI patches for 2026-11-02

Applied, thanks.

r~

