Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC1BC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 15:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXMYR-0006bQ-QF; Mon, 13 Jan 2025 10:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMYJ-0006az-4s
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 10:40:33 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXMYH-0004zT-BX
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 10:40:30 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3863494591bso2388342f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 07:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736782827; x=1737387627; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JX3cDKnPJEE2el+14bY7ljZSN/WFZoFD7l1/4MWrIOY=;
 b=WxgeHenamoRie4MFYdiT5Uzaqz9Xa/PTbskm13EzCPZ1qKdSX8GA9HCFklBJDcazII
 WeENHzhTIpdVCDvIbhltSkiv1c/0VmNnuZoxQpQ6ZZaUHBYo2IKKhyntgNcUSfo4TaLT
 p+MYaqNWDptuf8kyF7yxeaTwU+xJkEQpF15qRDTBZSb1jHUR4dIPPR7mUmW5k/w9DOQF
 ALH/3ByyxhKkP3iEjNY+ICpZpMm0JcU/OacctAiFwSEzKZOaybZg74fER2OclRIQ7yIo
 xmX+GN0FkbRC+CMXIlzKd9DT3yijefo2StsdhwgcYIcN+dJVnSj1WAdL2wdQncGefxUl
 N3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736782827; x=1737387627;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JX3cDKnPJEE2el+14bY7ljZSN/WFZoFD7l1/4MWrIOY=;
 b=A7x/WM+FK0u8ysV4VdZEz3TkhcOlO5qck9EzKz7G3PRFLykeHXRiF3tktewIgzjxlT
 BfkYXwcBpQ1LXVmAgF2PPqqkesSDJxRdRuAP5v2wG7keOU/KRv6Y1OwtKWpDkwLNl2sM
 eZL0XpESxb7vhFzRGGwfMEa/3utLf4h4nMgcHdmhzIZPZr4Di23L0XGbsFSTC2xBA57o
 Jb61rbZz08GZNEi7vKA1owc/CB/IEqk8jGYDonwvaiXkTLjgPXFoZpynmPMaLBrJ/qqy
 Zz42xuQ9KBXsqFZsHg2dCa03zCazp86YXKbrk2nHxoNEyb1uha+W5Wqi6CYTu1c0Cdax
 k1fQ==
X-Gm-Message-State: AOJu0YztX5ADlWw9jDR1w8RIQoMNVHPKkyZHMf7mGWEi4lZp0d6g3FVt
 B3rR8gW7wye1fudqa91wPsSI6cD+GF7XABd+x4HMWNB9y8BCN79yL6//3buK+dh8IrN01DRjEsZ
 wqxw=
X-Gm-Gg: ASbGncvMJyxl0O2sNL3Vnd2V5B7tYa1FVtLUWn85zJjlKn1azXfqePlZnH5ELh99f9H
 8owDyjZpsWvOppkgvEUMOuzmBS9F6YInGrGkrGX3c+5Sp05aj5KypoIlzcYp2tidb9VnGx5lHAV
 +hKA83A+4PaK4RT7qjGZhJvMLrL0xQzlzza+o2LDS48j2pGjatChgEnbDAMm6Cg+fS19WHKhdu6
 aTSPLQfAoiD+yfCSdtmgN8rdZXorgbY7rkP2Y7inU1lYCGhzoTr/PuXaPN8KdJWStABBimTtLr+
 rfXZqsbLFfFFTh/O1H18Cmjo
X-Google-Smtp-Source: AGHT+IHjPl9tseobsM7flDW9gvz/Rj+U3E6ZFkE59HgdUMqNPfNyAHvPmHoPFow2ZTk3g9JDkYznZw==
X-Received: by 2002:adf:a411:0:b0:38a:87cc:fbee with SMTP id
 ffacd0b85a97d-38a87ccfd10mr14192526f8f.14.1736782827338; 
 Mon, 13 Jan 2025 07:40:27 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da65a3sm184437085e9.7.2025.01.13.07.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 07:40:26 -0800 (PST)
Message-ID: <9a6988a7-d715-491c-8faf-9981bbda0583@linaro.org>
Date: Mon, 13 Jan 2025 16:40:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/49] Misc HW patches for 2025-01-12
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20250112221726.30206-1-philmd@linaro.org>
Content-Language: en-US
Cc: QEMU Developers <qemu-devel@nongnu.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Hi Stefan,

Please drop this PR since Igor made a comment on a patch,

Thanks!

On 12/1/25 23:16, Philippe Mathieu-Daudé wrote:
> The following changes since commit 3214bec13d8d4c40f707d21d8350d04e4123ae97:
> 
>    Merge tag 'migration-20250110-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-01-10 13:39:19 -0500)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20250112
> 
> for you to fetch changes up to 4a0031691596bd81c5949cf4632a6d178f8c2fe5:
> 
>    Add a b4 configuration file (2025-01-12 23:06:29 +0100)
> 
> ----------------------------------------------------------------
> Misc HW patches queue
> 
> - Silent unuseful DTC warnings (Philippe)
> - Add few QOM parentship relations (Philippe)
> - Rework XilinX EthLite RAM buffers (Philippe)
> - Convert vmcoreinfo to 3-phase reset (Philippe)
> - Convert HPPA CPUs to 3-phase reset (Helge)
> - Fix UFS endianness issue (Keoseong)
> - Introduce pci_set_enabled (Akihiko)
> - Clarify Enclave and Firecracker relationship (Alexander)
> - Set SDHCI DMA interrupt status bit in correct place (Bernhard)
> - Fix leak in cryptodev-vhost-user backend (Gabriel)
> - Use USB XHCI ring 0 when mapping is not supported (Phil)
> - Convert DPRINTF to trace events (Nikita, Bernhard)
> - Remove &first_cpu in TriCore machine (Philippe)
> - Checkpatch style cleanups (Bibo)
> - MAINTAINERS updates (Marcin, Gustavo, Akihiko)
> - Add default configuration for b4 tool (Jiaxun)
> 
> ----------------------------------------------------------------


