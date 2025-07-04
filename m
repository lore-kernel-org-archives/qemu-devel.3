Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F2DC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbiT-0001fk-PS; Fri, 04 Jul 2025 04:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbiS-0001fS-Jb
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:24:16 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXbiP-00055L-VU
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:24:16 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so4488815e9.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751617452; x=1752222252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gbVbXkk5gDrDkKIlQNzN2k5Qj4CadpnxfSGFBliSJPE=;
 b=hgPPl+o3Y91296Ct5i+QPr7vVE9DqGUNyHf/GqhPeiAA37O3v1vguYADejHn+3Cfrn
 3C1W5NTQ+CB9AwPlBQxcd5C+qBtHH4cmrRPsdluTuH88RE5VDKD5OFIUYY/TfB81U4JW
 X8zh+/9r/I/AIxbs1tpuh9pBkcqwQ+V+fmBwxwPhXLFIxkf/r0AmmEoLXwWPd0SCNMcS
 KWPOPLieMw9I7tRUHI8rPIxBFKd4+XeQhyiGyjC5AlYNj5W1x7U/rCEsFlwcIFgxo59g
 XTOhLJPjLIkRcsNLKqZeYCiNm0VqEt5kbQBUAuANyorCjyKGpygXjHZeoBz45i5hxIHz
 VhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751617452; x=1752222252;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gbVbXkk5gDrDkKIlQNzN2k5Qj4CadpnxfSGFBliSJPE=;
 b=SjagSQdiHZjwipR7PTIpDuZm1Rifz800pafcgmPdJ02hU8RKlhpPPxGQngAF60LnSN
 W6jtuEO4g/TOc3gCirbKSLNBhP4ztKBMSHb+p787Y7PGhk+kGxRYxTp1a4CHfMNPlRD+
 M/sStkXTTL4fyz/Iz3O2jX7SdWHBLC4wD3mClTo2Q9qqty60Q3dQ30wcgorVuSe/QU/V
 4uRlsQtWEJgmz7oZFF9zHjZBF72kBgd793eu153jH7MJjkqPyyp6D36P7+UIBDibgvga
 qnjVc7fWYOUjN1wcnmlJuytTIRdS8k4yEHXA4NOrT+AESImwp6CYQWuN5z8TCEkWTHRW
 GNBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFhvXtUW0k/mRicUpCtQHV373bPFTNXw/gMdbvzDWw+NrbwQ7ETvMpz+WMLs1gbbgzqZe8AVepqY/P@nongnu.org
X-Gm-Message-State: AOJu0YwnmLGeVTH787W81ljy+r6zrI6hDx5P7yZ3eXN0NA9R3NmVLOhi
 KBOoHFyrdtlFxQuTubZNfSERxsaP20hjHifkvLfiMAM9vi2GC7aOJQaeSKNwQyEoyqg=
X-Gm-Gg: ASbGncvLLli6E39TXWpo6Culpzz3E6IA5cwU3z5Hy6D87QA3CxnhE8p+GG0sfgMd7EJ
 1Br+xpESBnnTVu9mfsQeNCTbTKq3WkCsvDdXXIdUyIthswfQ6ZmLfaTstLMpzLugaZ8KT2QCj7G
 Ylrdeh2F5ziaY11vn3g9WNeqaGoD4LPuwPeZ0xC+3Un/wpIsTTfs3L7VGShPIps3HrlX+jk88Cp
 +8+H/q72cjwNgkr8xkWhqIOeAGvBoJtHEHqH6VPauSSS5ZzjsTP32IAHP1dP4VRyGfh9mU6IFyM
 BOKx9+8aVGk3VqidkBei5wkYmdRbHJ/+44dx+hkw3tB0SBbKVmnXTVC4Ztck66ZBdmHhiAtmxxa
 f1/T/QQeedtI9EKbiCNVU7XOB//VCIg==
X-Google-Smtp-Source: AGHT+IFUpR6YVd+jwwGoGAPDXDizijOZsEJuq4QgesB8hsZrhPWodKx66l1+jFS6o4KLQyfu2as9sg==
X-Received: by 2002:a05:600c:a385:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-454b1f63e81mr14382345e9.11.1751617451892; 
 Fri, 04 Jul 2025 01:24:11 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1893479sm19374815e9.39.2025.07.04.01.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 01:24:11 -0700 (PDT)
Message-ID: <7e3cd619-e934-4c2d-8ac6-a9d9bcdc798d@linaro.org>
Date: Fri, 4 Jul 2025 10:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/39] accel/kvm: Remove kvm_init_cpu_signals() stub
To: Xiaoyao Li <xiaoyao.li@intel.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, kvm@vger.kernel.org
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-6-philmd@linaro.org>
 <9292a723-eb6f-4106-bbf4-e046146686e4@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9292a723-eb6f-4106-bbf4-e046146686e4@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 4/7/25 06:13, Xiaoyao Li wrote:
> On 7/4/2025 1:32 AM, Philippe Mathieu-Daudé wrote:
>> Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
>> to accel/kvm") the kvm_init_cpu_signals() stub is not necessary.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> 
> BTW, it seems we can further move kvm_init_cpu_signals() into
> kvm-accel-ops.c and make it internal static function?

I suppose we can if we move kvm_immediate_exit to KVM's AccelState,
but KVM code isn't really using it. We ought to move KVM specific
fields from CPUState to KVM's AccelState. Not a priority.

> 
>> ---
>>   accel/stubs/kvm-stub.c | 5 -----
>>   1 file changed, 5 deletions(-)

