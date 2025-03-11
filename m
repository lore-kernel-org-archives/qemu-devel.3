Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78685C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1truTR-0000BB-RL; Tue, 11 Mar 2025 03:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truTL-0000AN-C2
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:56:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1truTJ-0004Xm-0j
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:56:18 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso948093f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741679774; x=1742284574; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X7Iu1u2dXqtHxA7odZOWuoQYWQu8cNtKWb4foxrTEPs=;
 b=dEvV5lRxK2NfyobMDnxRipzgmdepgBK2D7PI2Xc+dByw+syB0epWXsskdPVCPlKY+y
 1YkcAh1R3KHQAPYZRx4A8arK5NM/U9fSwyQl+HcbvtN8+xZZOpLEPSpu1Johs1FC4HT/
 W7u1J13MUF/NUuDyrxVeNBsW3wu9xTObdyOO9BbgrPQoowjS/5IViyU++oqb0zLwcusM
 hezbu2/7TbD36ORpuE0p1EGUO20lVMFdgPUPcGHywnA8J9DrYbUDPo4DLcj0W784O9Lz
 xtQ99A0XLIdXlGGg7386qXVB5BBIu7iuCAGaxW0IEpUyIcyBHeh91wGXyf04yXuMR+5L
 zrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741679774; x=1742284574;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X7Iu1u2dXqtHxA7odZOWuoQYWQu8cNtKWb4foxrTEPs=;
 b=pdzCIjLeRNaM8q+jB6GYM42lrxWO9mUjJcy4pLntYk980ZZVXUscf5mxyHi2U1gnhZ
 khCZ8yWb1GQ5gi84xETGRrP0LbXi1v14nymgqzSyzHyVA1g9SYspCdkyA1iVs4ohYVMj
 meBMmh0WxeI7p0X3oiVaRx3qAepNBDyZHujTk+eCvct2Ab+bG7UeqNnKizd/1/rvY3Gg
 br/jW0h8s7sWkBYohG/dOu1hGtLo6zpp6cc5+Y6qJcQWWRjEforaZC/HrVEYtfZk64iU
 dglzg5IlDknDxrECFjm0FdeCYdzOhK8WAuM5oCyMKanBM+e4zVpJcdK1abi7Li9bZzgb
 6/Bg==
X-Gm-Message-State: AOJu0YxgWKYdGBiiIUQXEzPi2oNi07tROUeD/y7y05sBc3Anf9sTwDZK
 YMRFj3Dkku22d9bpdSdxIE/ennGYfBIasqUYoQzmyxCQQVFf7kvpK3t2E29yKaiQEuXI9a8y2db
 Guc0=
X-Gm-Gg: ASbGncv78yx2bJkERNeJzIAXTJ2nl/Ouw1sYtb4ELBk4m84yke+TN0KsxpZ95Xi1Xp2
 SYS/u3xL7U3Qrb7Q51XHSRK1QqRjCnV0DLqNXSp2eDDB9CGaHW+73gyUzNOSeiaKEvAOFEtzGnF
 p0lHmYP9SiUjtlex1IGwtw+goLPvOOQTMLHxUo6hE43WuVyEOLzpMoSN6JvK9YIU4FEhb8Cl/Tk
 vhVNttlYZbhXKqClkOjtmFZNP+XikWLKukwFuWnclV/5VbKk3SaKIIU++RcJUXveuTLuYYx5nmI
 L2mUDCfSvTJznk2pmeUXFy2/8CSkj9kivqPs4rD+i6H3fkXqp2FSijLSgpxwi3ITJK9UF9TWKsb
 Z5bGwoXRX5iYa
X-Google-Smtp-Source: AGHT+IEtiRF/8Iuorn7Gjtn0HyQeDa/EcflgYbR8utiTJ0JsmB5lzqLJ5M2/N+y0q4woAzCFGdNG9A==
X-Received: by 2002:a05:6000:1867:b0:391:253b:405d with SMTP id
 ffacd0b85a97d-39132d98a1emr13213647f8f.41.1741679773775; 
 Tue, 11 Mar 2025 00:56:13 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfba8a9sm17297839f8f.9.2025.03.11.00.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 00:56:12 -0700 (PDT)
Message-ID: <28c4b011-29e6-479a-9eb5-96c0bac5b8c6@linaro.org>
Date: Tue, 11 Mar 2025 08:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-9.1 00/21] qapi: Make @query-cpu-definitions
 command target-agnostic
To: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-riscv@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
References: <20240315130910.15750-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240315130910.15750-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

(+Pierrick for historical background)

On 15/3/24 14:08, Philippe Mathieu-Daudé wrote:
> Hi Alex, Markus,
> 
> Markus mentioned QAPI problems with the heterogeneous emulation
> binary. My understanding is, while QAPI can use host-specific
> conditional (OS, library available, configure option), it
> shouldn't use target-specific ones.
> 
> This series is an example on how to remove target specific
> bits from the @query-cpu-definitions command. Target specific
> code is registered as CPUClass handlers, then a generic method
> is used, iterating over all targets built in.
> 
> The first set of patches were already posted / reviewed last
> year.
> 
> The PPC and S390X targets still need work (help welcomed),
> however the code is useful enough to be tested and see if this
> is a good approach.
> 
> The only drawback is a change in QAPI introspection, because
> targets not implementing @query-cpu-definitions were returning
> "CommandNotFound". My view is this was an incomplete
> implementation, rather than a feature.
> 
> Regards,
> 
> Phil.

