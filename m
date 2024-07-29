Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB3FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYPcr-0006mw-K5; Mon, 29 Jul 2024 08:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPcp-0006aw-9l
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:37:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYPcn-0002ID-LM
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 08:37:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42803bbf842so20729575e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 05:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722256632; x=1722861432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=38TyAb8OPa1jKFSVSNL0PATpSoZBUTsnN3WM6n037t4=;
 b=e5WAVtvMfwn206zIbqtCKgDDMK52+euKu73QlZ487m71cu2MMHZofiPnSTdZzqEG4+
 XbEWIFXjhTzNQuBhZzn8a8FH0r7lgl0at1Efq0bPCTqZ2RDcAXHSkM4baiwbwKwNm3mj
 n8QBE2iDni1ZDIlpV66X5i4lzqyPLApmF5F8kEiBkc06YYKrdYfKnUNP/s6JFjngXTVP
 mNbHFjx0x3nwMpycOFDi4CgztWyLgPkVCtnabcFeSWiOFKSPmop5a/NO4N8ViHyrmuLy
 eR9vZuuOY2Su52lleX8F1G+LJdKOxD2zCMjP5hEDjVUelv6PMrYjtErvGz5fhpRltGWo
 HHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722256632; x=1722861432;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38TyAb8OPa1jKFSVSNL0PATpSoZBUTsnN3WM6n037t4=;
 b=bWfMEsihLcF3uljdv7n//EskxZZfvlmFc+MyGbvgDeBHN7eyyMp+luM49n2sfbae8D
 UCEZCygmMdyfjXy1zUZdq7vBn+FnUIWz0lepHKj6cgzP2Zp4ztERT/QgLjCXrpS+giD1
 2Zn54CnkwG7lQizOAVZFbDZM5pq8m12hOrjY5ehcPwY4/xB6VAyXnY75PO2QYX0GGZ25
 JXn3GKBosg/WEmcgKIKpp3v+vYA0DFUgW2Vq5UopxnNuaMJ+B1OdUT2B+O8gPww4L4Dg
 bM57PrZ35bbz/TP5PCvtu/7wxTV/exeISEL7edDXaZxSPZhQ3z9QLXgsgc9+mPHA6OlI
 Z1sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgdGTKNMgZ5Zi3af95/xFDGMbnGcu1REgH4bRmSAYeMOCuTBx7/qFJ6xAgPsq89TI3d5uEx9FfyiqYSngRh5b+2Xvkaog=
X-Gm-Message-State: AOJu0YwiCJD7XwdINybA8pyr2Srvq8raNV/Emmmsvml0TEXz36obFUrU
 FZrHaPwF04V6JlzYw8kSueMXKeUZegAfVeZf0F+oNhlc+F0r0Z0ZQiwhTLx4c88=
X-Google-Smtp-Source: AGHT+IHKuOLNgfC6/rdT+5Lmn9BrrIiyscxP3bFp6nra5vmDENZOoJkGU8DpAi59nql+X0Vz86X2OA==
X-Received: by 2002:a05:600c:154a:b0:428:d31:ef25 with SMTP id
 5b1f17b1804b1-42811d8c0c8mr57086775e9.12.1722256632120; 
 Mon, 29 Jul 2024 05:37:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281ef5a416sm20672435e9.33.2024.07.29.05.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 05:37:11 -0700 (PDT)
Message-ID: <4595b585-d710-44f1-96b6-76daa2b73b9a@linaro.org>
Date: Mon, 29 Jul 2024 14:37:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/23] tests/functional: Convert simple avocado tests
 into standalone python tests
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
 <20240724175248.1389201-6-thuth@redhat.com>
 <124b4dd0-abe6-485a-b7ed-cfa2bd8e071e@linaro.org>
Content-Language: en-US
In-Reply-To: <124b4dd0-abe6-485a-b7ed-cfa2bd8e071e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/7/24 13:58, Philippe Mathieu-Daudé wrote:
> On 24/7/24 19:52, Thomas Huth wrote:
>> These test are rather simple and don't need any modifications apart
>> from adjusting the "from avocado_qemu" line. To ease debugging, make
>> the files executable and add a shebang line and Python '__main__'
>> handling, too, so that these tests can now be run by executing them
>> directly.
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/functional/meson.build                  |  5 ++
>>   .../test_cpu_queries.py}                      |  7 ++-
>>   .../test_empty_cpu_model.py}                  |  7 ++-
>>   .../test_mem_addr_space.py}                   | 52 +++----------------
>>   .../test_pc_cpu_hotplug_props.py}             | 11 ++--
>>   .../test_virtio_version.py}                   |  8 +--
>>   6 files changed, 34 insertions(+), 56 deletions(-)
>>   rename tests/{avocado/cpu_queries.py => 
>> functional/test_cpu_queries.py} (89%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/empty_cpu_model.py => 
>> functional/test_empty_cpu_model.py} (84%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/mem-addr-space-check.py => 
>> functional/test_mem_addr_space.py} (93%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/pc_cpu_hotplug_props.py => 
>> functional/test_pc_cpu_hotplug_props.py} (90%)
>>   mode change 100644 => 100755
>>   rename tests/{avocado/virtio_version.py => 
>> functional/test_virtio_version.py} (98%)
>>   mode change 100644 => 100755


> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


