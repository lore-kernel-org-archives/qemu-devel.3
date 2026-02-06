Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386E5EE6B60
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:36:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTV8-0002s0-LH; Fri, 06 Feb 2026 16:36:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTV7-0002rs-NQ
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:36:29 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTV5-0008Rc-VS
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:36:29 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432da746749so1690023f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770413785; x=1771018585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1KK2RYDp+BcPLUrAgRKXB1pt4AvbZE7v0RcuKmQCa4=;
 b=gJtFFScUHGTk4UlNwqFfDlF1dwR9JUeHdL8SWePr5U2+4uiVXB2LHz1Ku5lF6JIkUU
 m+/V/M+/+LarIWmoAE4Kyirj0/LEosv7G9SNpjf6p+a2+Y5l0Gmvg+G2eCRvhrqyLtRB
 U5N82BfZH3aIEJZx7eArzyu2MlLg0mz8j/swFOHE0bzy2PnEy4bI0ERSGwyYuSfqkaIl
 jq6q7xGQO7J96xmlXDFC0dqi0vVLVXUjgsFv1O8UKsDYkym5jXb5KXdN/kuvNIi7FvmS
 eogeLTAQ/RTnkm7C0WDPFhCQJQEflzfYOrUYT/IAvtD6nt9rCFBy8mAZt5hEb+Gm9JTs
 qGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770413785; x=1771018585;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1KK2RYDp+BcPLUrAgRKXB1pt4AvbZE7v0RcuKmQCa4=;
 b=R31kTvNVSlee8EzSAlhXWujv/Kg9BMeemcjJRMkZdG8knqDpqtaFsTjovjK15sCG26
 dYyMNr85oSfh4YN9Vl3wkrTlASU+ve2ESWqFZXwesKfTitqPQD1nX+5YEW19Fd7R4Cdt
 WlOmSUk8fCnyt5usxOqIRxrmNqrgiOBMcBViQiC0LaJVviimFJhid2RdKLPMmpt1+dAO
 0RKdSdlcBeuBOu+NLS0UNd4v+uj0hOZmc/Sp2kmvmKmPa2lGnoz8BNumrBWIB0gWo0Wa
 34MiFgXeQU7jNq0Rda/+96Y/LWWMommSTdSootDC6TDpy6CidhvE+8UUrkUMgFeM10Jz
 aDiA==
X-Gm-Message-State: AOJu0YwytNC1XiCbCLEb4KHkxLHeNPkT0yIgEijbxoRBl9FrhUg61ibs
 De9Kz4UcwSzLlgaJvtgM3amcKucuH/JL1ezz5/IXxnfcqkB1WGUL2VRcKQAEgDhhegFZYef9Xah
 iGAw0MmA=
X-Gm-Gg: AZuq6aJJtb045HRHGJO4R2O0fKeUEhhu4Po54QiGaStD0fGaVgB3h1SoEJNYS5Bk1oe
 npHTqDtpC2VrPJPxRF95OQHB9KIq/zIxQM249Tpvs3j4yK0Rkbk/WwEW+//i4E+xhY3ozCEuwgA
 +B7WRXyebXCD8m6K13w8Wvb0CSFvvzWq1y/tmYgelPNDMyj/41ERtbDfyOI8Y9Sm50qpdIKXdKR
 8x+OYwFBiHaVduidCpkssH/hF+LSfBikzLXMUNP0k76mtcsJobiQpB8jItNJParEiCBsg9k2LkO
 Crlsd4jgF/sLauCjvhmaFKo+vJdWLznMtVerBQ6MxluDjMTEc1Oj88+8JK6BSnr4RRT9ulyDQHv
 ZJFZT276Ips7O22tYFci+d1bSVJ5AQeIBxqgZYnINEbLEsAm7fHSYFlg4RHs6xltavg1OOMgwvX
 WaQvgBfFbKXMTHaFHGJx6+1ElN7bu9X/F0K2ohtv8jcjWMdOkfxQqVeA==
X-Received: by 2002:a05:6000:2410:b0:432:8651:4071 with SMTP id
 ffacd0b85a97d-43629658aa2mr5791027f8f.18.1770413784877; 
 Fri, 06 Feb 2026 13:36:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43631c8d378sm1893258f8f.21.2026.02.06.13.36.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 13:36:24 -0800 (PST)
Message-ID: <b728dba4-ad7b-439d-89b3-cbb58ad4a021@linaro.org>
Date: Fri, 6 Feb 2026 22:36:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/i386: Stop using the legacy ldst_phys() API
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260204204103.46343-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204204103.46343-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/2/26 21:40, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    target/i386: Use explicit little-endian LD/ST API
>    hw/intc: Mark x86-specific [IO]APIC peripherals as little-endian
>    hw/intc/ioapic: Replace legacy st_phys() -> address_space_st()
>    configs/targets: Restrict the legacy ldst_phys() API on x86 targets

Series queued, thanks.

