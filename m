Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CADEDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so5RO-0002Qc-OT; Tue, 10 Sep 2024 14:18:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so5RI-00023A-UW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:18:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so5RH-0000J7-8i
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 14:18:08 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2068acc8b98so54571555ad.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 11:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725992286; x=1726597086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IJ3BbOvxATGbK3xeLZAm7u0IhggThd8APdZa7shtZwk=;
 b=ptbYhTsejfzaGlEvuRFSIft+8YjKS5dwFqwv3RGNsesw/V2O36slOtqy4d/IvyldSz
 GRtQYHEpE6ri8ktYP4TZknHHBdlpuvpqLA7PnjQQl+xsiXItu3GqqJfy70QT7Wg1GLIx
 wofJ3QiUADePdUSYBxuyf1QBdJv0weweMkHFUsKpICPcad+pJTpRy7uxpDVqwMbFYPPU
 22WWRhJG5OL5kYgSy+Mmg+P09W01Ke4AfkvVYQ0e6o800wr+A+m8WIR/bfglhrviwM9y
 jmI/hPDjxijsNePEbwNDep44PFRYscnPZEcEPhKy9HL9yW4uTx1YcIG5nQS5NazZpE15
 OVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725992286; x=1726597086;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJ3BbOvxATGbK3xeLZAm7u0IhggThd8APdZa7shtZwk=;
 b=NWzvlD8zQsvTaFkeRsjI4PLJrK1uPsznaIUIFCcRUu2y7HFH4wUn4tQ8Da/FkiKMAn
 ogASs4FtVL/qbiDZ46m/OgAtUHZ0Njhz49CvhhC12nezE3o2F9MjUd7vHwSCJedQ8CLR
 U9QanSIK5OWhq1dhFZVoWXqr/QBQJ+kzib1wBt2sbpRxg8dZsH5Fk2L94LNP0XnePrzY
 tn9fI/o+3JRX8ETAW0T0DsQlUaEY1djBhum4n3ZyWSIxEDaaOppzYvueEnx3kY2QInsS
 3FvNydEdr5UxFlpnMisly+ClGbCuWOlMnFjrWyD7F4yhQug1d7UL2R2IQOT91wp50JTS
 JTYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4oeT1eUbqbISjacRmuXichV8rSo1DCYaaeDWuL5TUH/ANlHWg0NRb4VaOWmow6heMPLeiU6LQZXid@nongnu.org
X-Gm-Message-State: AOJu0YxnlcFiRhpZfDitRwc0JdIud5rtM2x+dNe/PvcTDqFY4qtffnY1
 Q/teap6u9Q5YHuk9cNe0Q0YP5Rw1Qc+k3/pb6tZ4dFOGaW7Z/zCvSjqbFNPLOeY=
X-Google-Smtp-Source: AGHT+IFxt15gX/mP+45nOs1fw827bX2r+fArIp46ZQ1Iy6CQMZdgIoy+MijoDJdNwKZSyfn4L2LlYQ==
X-Received: by 2002:a17:902:dad1:b0:207:1570:13e8 with SMTP id
 d9443c01a7336-2074c4c56demr19542475ad.12.1725992285592; 
 Tue, 10 Sep 2024 11:18:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f4c9b9sm51362855ad.302.2024.09.10.11.18.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 11:18:05 -0700 (PDT)
Message-ID: <41ab786e-87b7-4aa9-a259-cdf5d14003a6@linaro.org>
Date: Tue, 10 Sep 2024 11:18:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/2] target/riscv: rvv: improve performance of RISC-V vector
 loads and stores on large amounts of data.
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
 <20240717153040.11073-3-paolo.savini@embecosm.com>
 <8e0c2afd-4c31-47f8-ade9-60a83ca20859@linaro.org>
 <1753bd69-6f7a-4b34-a7ae-8a0b225b72c9@embecosm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <1753bd69-6f7a-4b34-a7ae-8a0b225b72c9@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 9/10/24 04:20, Paolo Savini wrote:
> Thanks for the feedback Richard, I'm working on the endianness. Could you please give me 
> more details about the atomicity issues you are referring to?

For instance a 32-bit atomic memory operation in the guest must be implemented with a >= 
32-bit atomic memory operation in the host.

The main thing to remember is that memcpy() has no atomicity guarantee.  It could be 
implemented as a byte loop.  Thus you may only use memcpy with guest byte vectors.



r~

