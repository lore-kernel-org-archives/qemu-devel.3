Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCDAC6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 17:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqGJE-0001BK-UI; Fri, 29 Mar 2024 13:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqGJC-0001Ao-8s
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:46:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqGJA-0007vw-QN
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 13:46:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e228c12468so8126965ad.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 10:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711734387; x=1712339187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tx9sPfLzUllwKuaJ6ZjHHdJA3myL7EJw/yx5Rm8D4q4=;
 b=CZmA85/0tlBl0SsTPUpuxLDNDTR/xtBSwnYCZ3rg6QGXLupEdq6ioppcuz3rMKfMM8
 8r2uBj0E+h2TZF4dyr+NeO0oOutT0uEp/YamEM6Vt2phixHtJNQXE8X4vk7NmkAMI02c
 U21+1JpRMKsX7/wZQ3K5FTcaOpAyi/xSebO87j0bGDU4+Xx59CDkL4mq+fvBqVS5weMO
 U9mNGTMRkx4b1ZKSEmSe8iIrNctyEhNBQmoHNupqXEBvxr0pPN6C0pf28eQCVLlhhjm3
 Q4ddPVDPUBgyqVJDjL028KWhR6DGxI71gebpUmCp8tiXURNtpj1Iz+9xZbgfkHgLzolG
 NXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711734387; x=1712339187;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tx9sPfLzUllwKuaJ6ZjHHdJA3myL7EJw/yx5Rm8D4q4=;
 b=eHnvDZqG1PKmpvCblCFf4YiT5yn4B943PRerJEpZHLYF0y9sT6cZxEnlmrkZqtPnpD
 23husyIBdPYhqGxHk3AXqZVCHGNf3inew4y7cstggIlQYvMsRCwsBTgmIjT3DDv/ZKTY
 ejJkYIErIDkt2qLFW1/z22UEDznVWfeyVYpXgNPHgluioGQOml0s3B09aUGq6e7z+vk6
 JL5Bdm2R51jFgm0Ged1FSbqkLjurj4EsaCewD49TIV+sK6Li4Gr7CpLAsJkDsX3DrPKp
 A8eV0QMHNQOZb0q19iI1MnlzB3gtvuuwewfrxw4npv28//RLCyl1jQ19thLasyaijJ6U
 X3cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZkRJ9MdRlBZSjWr+i73+HwTFEnk//VXPp/avAodth2FOiK9HjoQr/fzojY3GRvqDU+2zgPg03meleqJ9lSgaCDnuP2ek=
X-Gm-Message-State: AOJu0Yz5ON80hjT5k8YciPZrJNhK0cMTmdyHDjpnM+BGXypS2Zaq/HoB
 NIV5eGGMLnRdxHlQfwYzI2LucOUVIBVCgq8pcuNkl5h2T+W/NTkfY0ixYcJV18c=
X-Google-Smtp-Source: AGHT+IEVHJ/q7IK07Sp4jm6/hY5jM/WCYfVjk2tQYDCDVGGvqIfGHz6asQXvNXP9my4WDBfcnRJh7Q==
X-Received: by 2002:a17:902:e5d0:b0:1e0:c88f:654f with SMTP id
 u16-20020a170902e5d000b001e0c88f654fmr8941420plf.33.1711734386858; 
 Fri, 29 Mar 2024 10:46:26 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 m2-20020a170902f20200b001dce6c481c1sm3709224plc.301.2024.03.29.10.46.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Mar 2024 10:46:26 -0700 (PDT)
Message-ID: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
Date: Fri, 29 Mar 2024 07:46:22 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] e1000: Get debug flags from an environment variable
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>
References: <20240329150450.2843758-1-porter@cs.unc.edu>
 <20240329150450.2843758-2-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240329150450.2843758-2-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 3/29/24 05:04, Don Porter wrote:
> From: Austin Clements <aclements@csail.mit.edu>
> 
> The E1000 debug messages are very useful for developing drivers, so
> this introduces an E1000_DEBUG environment variable that lets the
> debug flags be set without recompiling QEMU.
> 
> Signed-off-by: Austin Clements <aclements@csail.mit.edu>
> [geofft@ldpreload.com: Rebased on top of 2.9.0]
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> Signed-off-by: Don Porter <porter@cs.unc.edu>
...
> -/* #define E1000_DEBUG */
> -
> -#ifdef E1000_DEBUG
>   enum {
>       DEBUG_GENERAL,      DEBUG_IO,       DEBUG_MMIO,     DEBUG_INTERRUPT,
>       DEBUG_RX,           DEBUG_TX,       DEBUG_MDIC,     DEBUG_EEPROM,
>       DEBUG_UNKNOWN,      DEBUG_TXSUM,    DEBUG_TXERR,    DEBUG_RXERR,
>       DEBUG_RXFILTER,     DEBUG_PHY,      DEBUG_NOTYET,
>   };
> +
> +static const char *debugnames[] = {
> +    "GENERAL",      "IO",       "MMIO",     "INTERRUPT",
> +    "RX",           "TX",       "MDIC",     "EEPROM",
> +    "UNKNOWN",      "TXSUM",    "TXERR",    "RXERR",
> +    "RXFILTER",     "PHY",      "NOTYET",   NULL
> +};
>   #define DBGBIT(x)    (1<<DEBUG_##x)
>   static int debugflags = DBGBIT(TXERR) | DBGBIT(GENERAL);

These should be converted to tracepoints.
See docs/devel/tracing.rst.


r~


