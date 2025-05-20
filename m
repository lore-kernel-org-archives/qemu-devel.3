Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E10C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNYr-0006kr-GA; Tue, 20 May 2025 10:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNYo-0006ke-MV
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHNYn-0006j9-2P
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747749790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kfJ1CUNE+y3P1pd1MzJ/hBSfO0c+3nAa4wj5doSQMSc=;
 b=LDsoVXmQxWRTeSaxXXa8stiYvukOoMhV4T7G1u+anZYirK8NvO19R93FUtdSUMx+5DUwAx
 8xGKTqEw3tpjdoeOeMqPZP9U1nua29FAJPziWAFctfkr3b+H2YgZegemQBMjjWN6EnQ3U2
 YAxYr6hZU9UtT43ypZRwgpJSNJZjG1c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-4aSdhzwdObmduVxVHv7tJw-1; Tue, 20 May 2025 10:03:09 -0400
X-MC-Unique: 4aSdhzwdObmduVxVHv7tJw-1
X-Mimecast-MFC-AGG-ID: 4aSdhzwdObmduVxVHv7tJw_1747749788
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-601a1d9406aso1148590a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747749788; x=1748354588;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kfJ1CUNE+y3P1pd1MzJ/hBSfO0c+3nAa4wj5doSQMSc=;
 b=WYJZtu1M82M+Dp11EmGJEA1JUVGwUXbBYJHG7gpZ5TZsBFEB9RvXcNwKUkzWSlI4Mt
 tms2Fp9MCx4ef/D1slO79pyYOBDUmM3vro4wEFPxOLarNSPOQPrnIdbzmro7eNM93jqq
 XXZY/8sBeHs96q+lpTc/gqwWZF5P5q7PDqGHAtIARNlgS/UuHddge7lWlQpsyebihCdn
 w26AywS7jU6y494PJ86GOSemhuK9rRK3bqQYTb5AhuYmhj1okISe1CBQqyRoy9zq4ap4
 jDgFY1yjA93btCEcKazmmS8PJv5ZFAOxVxdnVVlTzT5VSObiErikakr9CwFJTSzvszTd
 Jikw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA+1RAxlPWkyOZNIgH5+i6A5/dfhyGuef2cRI7QkyLfWLMkE28havla/K1YJK5okOXlzEzuN3b6rGD@nongnu.org
X-Gm-Message-State: AOJu0Yy5HageQ5DATeodVyvo2JuAumTaKCT0qAwwXGjWoWARXWfg6NKi
 X0lXWALL36FMNLByYixbp8A6IbccvAUf5oyd9HP8p/4/iRxtbB2sRAIEbgFG8RfCjUhSEjUJiCv
 dl//xAz6YNGARK0Y5hZAwicSzs2B3MOSfVnCxqgo4v6lKENojAWjKG85X
X-Gm-Gg: ASbGnctTeilQAFd2EqmUGRYQmO5bBUKUIjqcyb2PTeq5E9J/K6BJOXAqf4tret2WSjH
 PwXC3G+YgEWDbik2Mwqh6oHcttbKLkYFKyNDeFeUZAlzliFLBYSOYmqQLrAFpkehn90K+0vjaw2
 9WoucI7mhJA19a1/fM1eQ68WajOzV5xRD9QoNRhYdaLngVOxzFO8wpWzRh/zwep6cWZaKp+XVVL
 C3kFQ5q3ZwI/37dqXG/0HsiN3i0VhY+LXko9k399C+MiJyfFdLuNFoUtLQA6qRYi6/v5kcE/7PT
 t32CN+9v2vdm+Q==
X-Received: by 2002:a05:6402:27d2:b0:601:b0a6:f08c with SMTP id
 4fb4d7f45d1cf-601b0a6f3fcmr9868242a12.33.1747749788111; 
 Tue, 20 May 2025 07:03:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWXxlomN126QmdpoCUoKe2NsIbeM88QMF70EWPvvrnCcu5ornMSDfHowcLHpD0+3bLL52E3A==
X-Received: by 2002:a05:6402:27d2:b0:601:b0a6:f08c with SMTP id
 4fb4d7f45d1cf-601b0a6f3fcmr9868157a12.33.1747749787225; 
 Tue, 20 May 2025 07:03:07 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-6004d501f7asm7204189a12.19.2025.05.20.07.03.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 07:03:06 -0700 (PDT)
Message-ID: <4378830e-7bd9-4b88-bf4a-e061399f1f0b@redhat.com>
Date: Tue, 20 May 2025 16:03:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 19/25] target/i386/mshv: Set local interrupt
 controller state
To: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 magnuskulke@microsoft.com, qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-20-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250520113018.49569-20-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

These:

> +/* Defines poached from apicdef.h kernel header. */
> +static u_int32_t APIC_MODE_NMI = 0x4;
> +static u_int32_t APIC_MODE_EXTINT = 0x7;

are available in other QEMU headers (search for APIC_DM_NMI, 
APIC_DM_EXTINT).

Also they should have been #defines rather than statics; and also these 
nearby ones from patch 21 should be #defines in cpu.h instead of being here:

> +/* IA32_MTRR_DEF_TYPE MSR: E (MTRRs enabled) flag, bit 11 */
> +static u_int64_t MTRR_ENABLE = 0x800;
> +static u_int64_t MTRR_MEM_TYPE_WB = 0x6;
> +


Thanks,

Paolo


