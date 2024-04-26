Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E94BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 11:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0JIi-0007l3-CC; Fri, 26 Apr 2024 06:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s0JIf-0007kW-3o
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 06:59:29 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1s0JIb-0007gV-GJ
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 06:59:28 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a524ecaf215so252458766b.2
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 03:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714129163; x=1714733963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=voT8UCcnqz6VM3ogjtv8L+inv5gyz1R2btDp3ebZ/y4=;
 b=LUX09euNRyKAJvaRO0mqsn+BwZVEwgYb4yZlq7IuW4l2PGOGeMsIpWLJhALJOG35dT
 hWqomhYUkstgVQjgq1Jiawa5nnBoGvx8MWboEtg/OuNW9Z+DEjyScd7wrpPytczaa5Zo
 Sne6SbTUz22bG6dp+3DY2YENgN0XaksBsEqVkSdq0KPmC1XUOUKZKIZSUiD+ap2bYloW
 ae0v5WSfaCLVbdTmYXcCFtKXJUJ6qE1Ft3MxW2K0bw94omioXryBzI96n700euL/MY/c
 2CFRZHA1Rzbv49aqazOXepH4dJcs/eTW1DLhZHcLbKbwegpYzFAURR0gfzIF3Cd3QBDL
 rT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714129163; x=1714733963;
 h=content-transfer-encoding:in-reply-to:organization:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voT8UCcnqz6VM3ogjtv8L+inv5gyz1R2btDp3ebZ/y4=;
 b=nrwyoqnhvyeuLeAwapYoz6Ys1liXNed00BnCFa2SOHTJztvaIhMt+U44fXdsh3eBCh
 +libEdI3QU5U3PjpVwYNI1gduGPGN7bp3tMLw+BzJqAW+/qGY/O4CYv/g2C/v4FtFFIb
 qpMZuHryJ4u6I5wOUZ5t9lz7dRNV/DCfIFDMOsxfasT/nFUrlfiBIGg+MNCt3YX7SNae
 HJHkJLsEbyf5XFmw5IAPv5DaH0U2qikZlUFEiOy3jn6LupTFuYp27b/X/EgNw63qIeZ6
 YaE0+7lc9FGFNHmnHTVGwlB6Ctx4R8a/XaXUIGpCMEzOI6MTNKXtD9Gfj0KwZcrlQaKq
 T2gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI+/fkfim32+1zAKdI9pS04Aa1/at1pcKw9BAMgFF+1PF/LBsXS5jFX9a1WKTlGDoI6sOx33DoJOftlb2l0dzPHZxZ4Z0=
X-Gm-Message-State: AOJu0YwpAJDdqIOx46dLV0LX6VpfiV2+giMlEv2d74dZ+4/2T4Ij7VgY
 gB6zwuH7yjwetq+yPCCFdWQPG9tBf74R2EQIbx8HLrhaK2GyQIVKvTZTK+o1wFM=
X-Google-Smtp-Source: AGHT+IFViIpn7dBnPt0HyOPSfGa5CsMo3ktSGymI99/C3T3KQdAwK0UQfhsYGtpDEFl7lOXtueP2ow==
X-Received: by 2002:a17:906:1c48:b0:a58:9297:91a1 with SMTP id
 l8-20020a1709061c4800b00a58929791a1mr1715465ejg.53.1714129163124; 
 Fri, 26 Apr 2024 03:59:23 -0700 (PDT)
Received: from [192.168.200.106] (83.11.4.140.ipv4.supernova.orange.pl.
 [83.11.4.140]) by smtp.gmail.com with ESMTPSA id
 mc11-20020a170906eb4b00b00a5256d8c956sm10445325ejb.61.2024.04.26.03.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Apr 2024 03:59:22 -0700 (PDT)
Message-ID: <a3541699-966b-4940-8a58-bd41dbf3001d@linaro.org>
Date: Fri, 26 Apr 2024 12:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: Enable CPU cluster on ARM sbsa
 machine
To: Xiong Yining <xiongyining1480@phytium.com.cn>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: rad@semihalf.com, peter.maydell@linaro.org, quic_llindhol@quicinc.com
References: <20240426073553.326946-1-xiongyining1480@phytium.com.cn>
 <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
Content-Language: pl-PL, en-GB, en-HK
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20240426073553.326946-2-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 26.04.2024 o 09:35, Xiong Yining pisze:
> From: xiongyining1480<xiongyining1480@phytium.com.cn>
> 
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And
> this topology can be passed to the firmware through DT cpu-map.
> 
> Signed-off-by: Xiong Yining<xiongyining1480@phytium.com.cn>
> tested-by: Marcin Juszkiewicz<marcin.juszkiewicz@linaro.org>

Thanks. Checked with TF-A and EDK2 patches applied. PPTT table will be 
more detailed now.

Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

