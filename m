Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8555FC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 09:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOvJ7-0006yF-Nk; Tue, 10 Jun 2025 05:30:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOvJ5-0006wp-Cl
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:30:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOvIz-0000JG-57
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 05:30:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so4232466f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749547802; x=1750152602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ciRjeOIPXJsnOjBHMvIx4F0UVl6dPJTInJFKPVLHeuk=;
 b=z6k0kA38GTSw/VnCyFo4NQMivBKJQQFM3b7vUf/A5LthmUBuo0BkO4wip3c40PTN/+
 LgTnsuiEtepnHto+6WOEF7doYONUyoGVc4L7Hjet7WnhFtgk0DuVn6H0wms8vSpCbNrD
 /VOGc/vkmV3Jr9XRsQfRYl6jCShbXnhW2GUYl2OP1CecfeJhc1bXXyWNi/8WxvaD3a+b
 OUlp/Viq63qq5v9WlcIbzx9//kjNYYvZa7kWYqCQJLvNAoP3CmxdQqhLIpVMixzPPcjB
 jfJYoM8XV4DlPU8IvuKI1sHRjgduI5cJivKTK5GTC8YaoFIBxsT5q6MOZsLk8MgOer34
 /U1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749547802; x=1750152602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ciRjeOIPXJsnOjBHMvIx4F0UVl6dPJTInJFKPVLHeuk=;
 b=FMbAPTomhiynVEsFnHqzzT8IYl5a+zoYcoIOm/iPFCsw4SZh6cDvGurzQcDNXGaFSp
 lJY1c2IaI6UEKmJC/MnNUVjPF7OItBkYV67EAfHWWczDNFQhSJljCNVAr81RwdnoLJi7
 X7a1sYb/fgtDhkcsYA4xzBactRCs4eHnSQnSTpDnl9yNl0+aus0aDW131nqTkr0HZch/
 HDsCzaCNYh0almyBBjC0uLB6/zcdcijptGuflqDFmcXyKokV7BTTjz6rwlWiTpE7OxxR
 DDFiy0Lz+3ngpp2HwVbxqTMpA6HGy2m2Vo0CK12KrD/mQ6lMn9u+8gl6xisl50dpDOmO
 0G1Q==
X-Gm-Message-State: AOJu0YwTiA+GnziLuRxhQz2m/Mcd57p2sRPkyXAYOoAmDGpHn7Sbcxu0
 Lsz6EwKkIilz2kfk31gTTXh3sbjOKaSpQFidWpIs8SgQfdner7T++5EGgmoaQQA9tLhZq1hyAs4
 PysMzyMQ=
X-Gm-Gg: ASbGnctFPWt05z/dVvY3mJTtCiCc90H67o6/05UoiBHkDoC31j9dN/2EBEy7wqFqySt
 +ZI2HJJAGWrEq8ymEHzwuND2b6e7FkvWk2lSen5+iZe5+5FZZKXFpl5lpul/F+HfgsxB3xhRW9O
 OnW/+0VLkt4GZ4DC7am8HmiMvtTdGMR31p7Z56iP5ws2w8MVNmrbJS/1Fnizy16mrvG6xMPaG2k
 36ylBItD7bopPMjHTyMJkr//9gGcRjm/JuqxZ8q22lFHqFU9usAaojjSFs5D+5fTPPHGZOMf3rp
 gkyLk4jahhvYCEzylyv1Kpi6caZ1DOFYEHvoORXpaR1n8V9MFQQw46Qr9AP/AXi0hjU96u8AQwn
 a3aQjQfllPzxDZyfFgPuVmCHKOhlEj6SEOw4=
X-Google-Smtp-Source: AGHT+IG7MyE646W5lWgsJPrsV6tOo1D664KeBOXMorqAQDwugpnz83IFaKb7BqcQUYEvtcwvKjmZuw==
X-Received: by 2002:adf:a3c8:0:b0:3a5:52cc:5e29 with SMTP id
 ffacd0b85a97d-3a552cc5ea9mr1009854f8f.7.1749547799562; 
 Tue, 10 Jun 2025 02:29:59 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4531ff595b7sm6205565e9.2.2025.06.10.02.29.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 02:29:59 -0700 (PDT)
Message-ID: <b85339d1-4347-4ac5-b0ba-47c9e941f28c@linaro.org>
Date: Tue, 10 Jun 2025 11:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] system: Forbid alloca()
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250605193540.59874-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605193540.59874-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 5/6/25 21:35, Philippe Mathieu-Daudé wrote:
> Eradicate alloca() uses on system code, then enable
> -Walloca to prevent new ones to creep back in.
> 
> Philippe Mathieu-Daudé (4):
>    hw/gpio/pca9552: Avoid using g_newa()
>    backends/tpmL Avoid using g_alloca()
>    tests/unit/test-char: Avoid using g_alloca()

Patches 1-3 queued.

