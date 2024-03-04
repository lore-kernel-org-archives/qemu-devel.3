Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F35DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:06:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhBkr-0003Hs-FD; Mon, 04 Mar 2024 12:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBkp-0003Fd-BR
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:05:31 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rhBkm-000380-Tl
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:05:31 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dca3951ad9so45229065ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709571927; x=1710176727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lN8RI5YvfYZcH0Wq2UYjR+mhbaFX6mxWqsN35cYViuc=;
 b=Vv9qQqcFLWaEp0nYQdK5RiBHMT9bTX5xTBEetGSv3XfS8EhZ0CjlGcax8wN8qjhiFS
 D4yBtEnPnRBm+kZaoDm2xop9rf7v4yYUQm7rJ/tZWQh+LXk7mI9X2Kdr9zevgAnzDKqc
 JiTXrQyNFUc82Edeo6VNMfWv86w5KBZ4R/TvrShIqASI+rhieiNEzsU669LWBFV+cXya
 dcQgoR3tyoCVcF07iIvx18S5OiNzj3mJoCi4D0sL6nN0xbLGr3cvaeqVLo8ItjEiLXMn
 JbyBamfTacj4mqk9zo0A6/FC5HpSpSC02gx3tAQLROMSOEyF5ocM8nTHCsIPgrjx/TWV
 B1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709571927; x=1710176727;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lN8RI5YvfYZcH0Wq2UYjR+mhbaFX6mxWqsN35cYViuc=;
 b=tEQTVO0Usylzqm38AXBkteFiNccW9DhQe6GF4Usuvo1b7lYunEJfEMcpDxODDMHHVY
 hS9TVzYFQ8CLCSwA3xFSvROfTlC3nkqO/F6+TXWDn+uuwEWPiLW6bZaoesiYa54sAUlV
 bNDSLDE76sX/EaRhEVnGGi3unxDe2KniUJywy6tAFk9uWZ2Cz9dzLtQjWhfVNjM76Q3b
 HGnGKf48YrDQ7WjCwm8Il3+nVD+FaWPUDJ3RK9ofhEpi/A2pc350VFteKsndYSaHeQ9h
 ObIvxXCVf0qfaJ/RSRWWV+Q42QmtVIiOWCUfoB1+zX6ZAdNrdzXj8Qr0qEqZWBTj/YwH
 pi4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVQ0omrjJA08tSoL4R+0sYIARQRRnGE3FYACs29Lzwx0r+9EWR9PsNc6QdFtu/QfQ4tEyRCAo5BTC/XnPRXF8JdB03v5Q=
X-Gm-Message-State: AOJu0Yzr3fFySXaBpyc57ruDeSDpYY1+xUti5PmmnxdNCgp/nVuiodJz
 AJUtksKYmyXhKJ/rqzqcbEDL+VMlM38BtVPpV7zMMVO0LACiLrZYe2sLHWAY33U=
X-Google-Smtp-Source: AGHT+IGf85ccNNe0LtqL8VE9Z1nOAHp1yzFh34LFzozzNYz7v/RM3FKaTWHJJafaUMdA6AfB15aKFA==
X-Received: by 2002:a17:902:c183:b0:1da:1daa:e2bd with SMTP id
 d3-20020a170902c18300b001da1daae2bdmr9446363pld.19.1709571927217; 
 Mon, 04 Mar 2024 09:05:27 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 f6-20020a170902ce8600b001db45bae92dsm8779548plg.74.2024.03.04.09.05.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:05:26 -0800 (PST)
Message-ID: <27a535c1-e623-4cb2-8595-f20d822308ee@linaro.org>
Date: Mon, 4 Mar 2024 07:05:23 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix CI build on Free BSD 13
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240304144456.3825935-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240304144456.3825935-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/4/24 04:44, Daniel P. Berrangé wrote:
> Daniel P. Berrangé (2):
>    meson: detect broken clang 17 with -fzero-call-used-regs
>    gitlab: update FreeBSD Cirrus CI image to 13.3

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

