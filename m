Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C262CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 17:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rooSe-0004TC-OO; Mon, 25 Mar 2024 13:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rooSc-0004Sw-NV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:14 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rooSa-0000LQ-EY
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 13:50:14 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a46f0da1b4fso595632866b.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 10:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711389010; x=1711993810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mUMnly82MrVRd1t3jtzRsWysxbErpHMd2zSWX9TbrpE=;
 b=KutJIRI41Gfe/w+oqfeHul2G+K1qbLyKn7I4DzeXtdih8B9n+qfeaVUiGr8EnJy47P
 lBBNDhhnrYPbmETdbduQXeM82t2cSE3DzxAEp/nffCevgeRbinwEzsEnb2sVYHeUUSbW
 DV8upxpIfnY9i2DAsHIgP+TIYucvsVtYcnP7Ds6v3dj0DSHbq2qIEKjJ98QMDFqwChnz
 IVfME+fQXC97TlJDA1ilVlptlyw6om3ZJwgj9U7QsvJJ/Qh4CI1OtS+F5FrR98BMKO0R
 hPizZ+3ftIgfOvA4mTkI3M8IlNH6pdF33fTy7PXBGr0UVTR+rLjEQeyq6AyVltLw55hE
 lHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711389010; x=1711993810;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mUMnly82MrVRd1t3jtzRsWysxbErpHMd2zSWX9TbrpE=;
 b=Udh1Z8ZIE2cqrnGCtPvBH1GkTYqUlxOCP0rLDe5p2Ge7azQmCOVaQncAawCGxbOk0o
 KSE8rGBUMtShDCF8qEJjJXYn3yijC77wEo1Z66zWOG+e/9dJ/wMpkkg1nJEc4/QWU/m7
 EOQa7k61nQcH9YVNbPYX3iEzotlfBur6JvY01i0MdOoAS5vbeU3aZ9c+QpWZoSe7VzQb
 9hHhY4VvTucridrcKFiByuCjm2plRxxsvWcc7GS9O5o6R7c3ccJ9RenDR3nL12Jm/rgQ
 su+x36wLImWg/NeBnaJbkg3dKUp6opxtdZ9+Wszm4GvCCrj9cWo+0mfIx1F/r4OipWBL
 Ya/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhazwTSHhx+Q2COHtmyuc1fuM+dP7ChkvWCwA6uvfvdtj/Z1VF6zhr7gxYD5UDd5th6d+zDp66jxBhAyoE1figirHto2w=
X-Gm-Message-State: AOJu0Yz3WA9n02O4XE4JjSZ17c+DUiRAHSyxtZarMVmbRBxffgsiqHBr
 VJACszAb/P7G7pg4iUM2XhvSyS2KWUP6/vDT5IMyQgNQ9+95D9iEfnwuu6T7Ur7anNHr0z2xAAY
 P0Rk=
X-Google-Smtp-Source: AGHT+IF9udHzvbJVSqAYQXN+uLBup7ZHa+5JPcBkF9jLPPNm6XmT+QlVnXw38vw3w3FBbUkFf0jBpg==
X-Received: by 2002:a17:906:3888:b0:a47:325e:f88f with SMTP id
 q8-20020a170906388800b00a47325ef88fmr5479300ejd.61.1711389010266; 
 Mon, 25 Mar 2024 10:50:10 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 q5-20020a170906388500b00a473362062fsm3272439ejd.220.2024.03.25.10.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 10:50:09 -0700 (PDT)
Message-ID: <f74aa60b-74ac-4bca-a253-c398e06d1ce0@linaro.org>
Date: Mon, 25 Mar 2024 18:50:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/12] SMMUv3 nested translation support
Content-Language: pl-PL, en-GB, en-HK
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 eric.auger@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org,
 Leif Lindholm <leif-linkedin@smurfnet.nu>
References: <20240325101442.1306300-1-smostafa@google.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20240325101442.1306300-1-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62f.google.com
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

W dniu 25.03.2024 o 11:13, Mostafa Saleh pisze:
> Currently, QEMU supports emulating either stage-1 or stage-2 SMMUs
> but not nested instances.
> This patch series adds support for nested translation in SMMUv3,
> this is controlled by property “arm-smmuv3.stage=nested”, and
> advertised to guests as (IDR0.S1P == 1 && IDR0.S2P == 2)

 From pure curiosity I applied the series, enabled 'nested' one in
sbsa-ref and ran (S)BSA ACS tests.

Two more tests passed. Ones which check does SMMU supports both stage1 
and stage2 at same time.

The fun part? Those tests only check SMMU registers.

