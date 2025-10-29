Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31732CCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:58:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEEAI-0002BR-33; Wed, 29 Oct 2025 17:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEEAC-00028b-6d
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:57:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEE9z-0008Jp-I1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:57:02 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-421851bcb25so191841f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775003; x=1762379803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=paKoow7DG19YmUwOSTSjbNJKgSif1YPzot8EI6qtg+w=;
 b=VnRYYXtQpNrb1tLh8+DlFfcqCZ9XRryK72MBwynCbaKHjcxog6xx1X5Vhhqi2toq7f
 CYZPu+tqQFPHGqtcLFbYcwrAkrjCOFJ3P0WW1wjagstT93SW7wM/qE4Ps8mdD5U0VDHt
 WEKW+yI20TQb2FXkOpoEBktAEDX1btv4fdCbeueQyzJ59d0BQvz0fI1bhwt/w5SAvbc8
 Sn0kocNoyFSzJOE1lwZUcI/6nzKUzaiC0My+muQOg8/M8uHa8bjdTU2UoVtTZRTmnfbb
 UDopTOJ80g63gDEKPtcdrGaybWIUpIFUTk81PZLods7H8kB0/HZhneMFumik2AqKouf/
 ETjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775003; x=1762379803;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=paKoow7DG19YmUwOSTSjbNJKgSif1YPzot8EI6qtg+w=;
 b=DH4URKKvgHBWLU1I6BWYYfHaINX839iFXkA37y/v/6noTFG9kXHZC0v0fHq2+Vxa2j
 TK0SLh5U99ryuw0npKThBDd20kj251sIRBvS7sZoJ9C2nVrXM9ccKN/LPtKdShDGqjdN
 dSmU7/IBiCV/tjMRX0JWtABPmY4NHBgs6rReqlU4HLMvIzMqgQVBCEXEIVkzPv4szASv
 owajPD/hPf42QL84wSTuRcF1t8DyMLZOMj2mN0diVreuxCuw1XoPxV9MGa1YjwVPcKF9
 OY7Emnv0vVzBgaOhIIZN0tT4ndeWXM50Nr2MRZpgnSAGvustgBoelurWbsV5ki3G7/KL
 yw5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdy7hiVKNbNlVIqhphJXG+hW/faVvZlMWZB89EN8fn7WbWzAAynog9L8Itu0hRDUsbICvW1ouEgEPo@nongnu.org
X-Gm-Message-State: AOJu0Yw4Gemj068DeLGhloQqQiy3fEwVDRUddG5+G4LbBwm/FsvfmIz5
 a62Sw7sZKQDnQOOMf2RjM6pDLyQn5ixV0T6/C5Rp04C0AmsLglnyhc0rQjojHNsSuBs=
X-Gm-Gg: ASbGncuO2wzJu735iPttX+ho3/ngwRyZUrV3686w78afemGPz5mfwB07jjpmKW/p3L/
 N+VtTmu5n1ATzgT/+cHFDjUviO674Nc4Z3Tj86tifxnrXdLZ7UNk9ADICQbTOEQAw2ZtHv2Sjso
 WeIR6AQHi563cYaKKamdivyApS7svu5P3FRaSxbg76MCu2Zmnz9W8HneZazCikS7dD05bzPNzok
 c5MT+PicqYTn1RcAo0+Z83HIAOpRV5TqoegBSNjvev/qSGzrUBCSM3+/P9BbJ5zapg+4FmGnewJ
 +08iZCoYKMg7gKAenagse/9uXAKElCdY0n7etm/r8ZXkegYoju9+15K4q+FFJluo9hXM4xWy5vF
 jCGBpm/B0tbtbXOSGDe9DGuhy7M2bkW+n7IOvpYvKPoXBPakPNCt9Vyyq/J9Y5EG/KwA3QLSmpi
 u4J05Ua7V6eQxJcR2ZSJY2z5gD4kJVr8JCu//uzijQCGw=
X-Google-Smtp-Source: AGHT+IFsPnro7/ReIh7qIRluoLqYKmkN8pn4KD6TtVIg8Ev9AaG+y9Tid6XDLT8g3NgaDp5H2OQpcA==
X-Received: by 2002:a5d:588e:0:b0:3ec:dd12:54d3 with SMTP id
 ffacd0b85a97d-429b4c98623mr862981f8f.35.1761775003564; 
 Wed, 29 Oct 2025 14:56:43 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952ca569sm27798854f8f.12.2025.10.29.14.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:56:43 -0700 (PDT)
Message-ID: <ca0fb671-0ec3-46f1-a18e-1f3373d0e343@linaro.org>
Date: Wed, 29 Oct 2025 22:56:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] single-binary: Prepare hw/riscv for single
 compilation
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <494cb717-88eb-4243-a39c-62e94f89f285@linaro.org>
In-Reply-To: <494cb717-88eb-4243-a39c-62e94f89f285@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 28/10/25 08:25, Philippe Mathieu-Daudé wrote:
> On 27/10/25 13:35, Anton Johansson wrote:
> 
>> Anton Johansson (3):
>>        hw/riscv: Use generic hwaddr for firmware addressses
> 
>>        hw/riscv: Widen OpenSBI dynamic info struct
> 
> Queuing patches #1 (without kernel hwaddr change) and #3, thanks!

And now #2 also queued.


