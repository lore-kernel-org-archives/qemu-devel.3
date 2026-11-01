Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0300606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=l2wuGHjO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNKHR-0000Te-RH; Sat, 31 Oct 2026 21:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNKH8-0000RQ-HF
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:22:28 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xNKH6-0008B3-TJ
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 21:22:22 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3ae57dc1ea9so939104a91.2
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 18:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793496139; x=1794100939; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Ff/E93qVaZ+DssyGpSjddTARmEyhMkqgD7yoilBkN8=;
 b=l2wuGHjOeVapGXHcTm5aHUbEOWR3uLwX81Xt19jSxexKXZ15vrRaDVjaFMiqPBBFrS
 kp5YAQB+sDg12mNSTrFovQOBuBmBCDF4SFEBz+mlaqcFLSaQ4fAWNtyja4c/ooCZv8wT
 ri5xJNoyGlo9RZf+LNPEiOfSdV4SqaZOJuKj1m7kIF7CV3a45n/K7/WDEMezG+Efn/jN
 e4zEAET4KpgalXImXT64RlClqWB1kj1uPYRzlFHA1xgqRtWBagRruR3pUtUtbZRyCylH
 rpHaB+sWT6OUlCaEO0QKdg/Sr9dCshOnU/NzPaDFLGqIOPkrKeTkghHe80tbPzUFgb2o
 Ppjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496139; x=1794100939;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0Ff/E93qVaZ+DssyGpSjddTARmEyhMkqgD7yoilBkN8=;
 b=BXf/7XzeHiwE12gSq3iLb2P8DwVh9Y02YhmDX7tnI9908TNVGKIlzqRHytd2jIirU8
 wv5NwHoNMAjKpJAXHOH1R1IPsrM4g5n7zeS19whpeIIkg4HMTBxmHs3IFsoyfmRXpY/m
 t9Xdzf87054BJ6h3sozWZ5QX7OPKlXhUxj3TTUPkGeXrH77wouCv3GAgy/wWw9Izc/m3
 dBfZxGZKSJhEOMB+E4T0vFTpvfA3HEXgZKcO0n6GlzNgbilKpU9RwKHCpjBjm+6iUaNP
 KV0BHarPsyDj9g5OUbhV+FabuGR7knvQC9+yicdsWztEyGX+GDZnsRV/fD0WiNN7HBit
 XMcA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWUuktM98walH9izsmvgroJ6sDCQpFhE9f3g8wHU5+2zOstvTtOt0GpGsxxmjMPMXnKh7fNGwwCyp7@nongnu.org
X-Gm-Message-State: APuU4Z+zQcc/CVF4G3qyhduZXlRGbL2/XcD/uWBU52lORPyQZrmJ/sfm
 NRnSGf+6M48K6XCrgKLwCB7VLQUi6IkaWkQXdiaF56vDeRi1ZSGZWP1Lkun1RiaWqAY=
X-Gm-Gg: AYBFou0chlahaM9SpklX5IO4bF9rpYE7OPddnN6AjKUqPYdDAgEcI0wMSFFrl2prbJ+
 tAxlxtu5Agb6/1nPUAoTls4uW/ju9G2EkMpxVpW6j+KEC1wvmSgRHXVbyI/JyifJp1Y1BOHKHZL
 mTFhuijfCWtXjplhkzefKy3c7MIECB2cPduDwLW3Ul4z3UyZOFE8SAjo97Yro2VqJ2czwWe2ELw
 WL8sX7+AiN2kfh0cWkzlB2gA7W+6PnF9rIHhb4JSuiupy7jiv2iJqF510fJW008drSjsI/gQC8/
 HG70Xvk7L7GLFTEvqjkalcPdPB6h41+SEC8kJTT+vC1So/XL3EvO8yABbyvpkRfGiuzL5NDeZy1
 DXGi69eCbe0pI2ytrRxy4jafw/Wuh9xs/msjag5oFHfk7+j+faI5ZXZpWTSpJhcQT5ADLB1Idd4
 F3NcA13CfENS1aSkXrzmu2ykDlwwKZoChhJLXyzFCrDgjQjR0bCIW0xcZ/xrpKG3iECsaN6F75l
 J8HFrHCs8y+/gf1y94OfwyX8c5UpBsVpXCFEc3LQvjgjDG5PgmH5k+o8QAz5axTQHdIQqokpDCw
 5ZzI+ZAAnAxiT5CUGFb5H3wKsYtNE7pvilMp9s3xP8CMQTY//bl2GweDinxTbZTHfGyGOBNp
X-Received: by 2002:a17:90b:2e07:b0:3ad:fb12:9bf5 with SMTP id
 98e67ed59e1d1-3ae897df966mr4393920a91.62.1793496139159; 
 Sat, 31 Oct 2026 18:22:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e7d5b8csm13840230a91.1.2026.10.31.18.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 31 Oct 2026 18:22:18 -0700 (PDT)
Message-ID: <f870f8d3-5715-4164-80d5-7af386896df3@linaro.org>
Date: Sat, 31 Oct 2026 18:22:17 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20261031070152.197043-1-clg@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261031070152.197043-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 10/31/26 00:01, Cédric Le Goater wrote:
> The following changes since commit 4075aa42daecf701cd3869da8b3271dc3c04a4b1:
> 
>    Merge tag 'block-pull-request' ofhttps://gitlab.com/stefanha/qemu into staging (2026-10-30 15:26:36 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/ tags/pull-vfio-20261031
> 
> for you to fetch changes up to 33229ae31134c58c633c6eb77f1c8507a731a34f:
> 
>    vfio/igd: Use version mapping for MTL/ARL quirk selection (2026-10-31 06:48:11 +0100)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Extend vfio-user protocol to support multiple file descriptors
>    for sparse mmap regions
> * Add per-subregion file descriptor and offset to VFIOMmap
> * Add setup_sparse_mmaps hook to VFIODeviceIOOps
> * Implement client-side multi-FD sparse mmap support in vfio-user
> * Reorganize pci.h declarations into sections for readability
> * Use version mapping for MTL/ARL quirk selection in IGD passthrough

Applied, thanks.

r~

