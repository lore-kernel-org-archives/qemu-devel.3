Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D5DC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 11:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siXwB-0007eZ-1A; Mon, 26 Aug 2024 07:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siXw9-0007aX-AM
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 07:31:05 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1siXw4-0004zS-QE
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 07:31:05 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5334c4d6829so5748245e87.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724671859; x=1725276659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YyiZMCqmyhU9rGr4rY0v8PwwB0+3MGO2f9UnbctBHJU=;
 b=DDM9BPq5yqVdpn/IH+h/WnwmlHNVx7cmvjUTzjAecCwB3rgIcBu7w73PlG5c78tCt/
 wuCu6/Ccn0CFSF0OKXWOdkZ1k4XssUqALPlwCP1aFnwcwnJRndMT/CoTj2OLRR0jf4gg
 A5ETfcp9U/NX6poC/aLqQQxSMrM7CW4qVAPTWG55ewTZLeTMij0xBL/QaM3ZLszvJTJU
 bpxaVS2QlERAsWFloor2nAOyp3c0DwPqQamKquoqZzsKIK7IBdsN7K1ZhQoXnGIZiApr
 NJ8dVvmZ3zGkG7dX1zro1ozeiGGqZX9g9Oh6KibdClK9QmPhOuVaNJTNc9D4bwsD3kQT
 yANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724671859; x=1725276659;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyiZMCqmyhU9rGr4rY0v8PwwB0+3MGO2f9UnbctBHJU=;
 b=JjsktQ5DEPUhjWM/WYn0O4uWEXItjdASh8aUzYOa1cSDhYtBp27Hqxjlr1z5qZRmG4
 nZ4Xqp8Yx5y9pWCmtijrOHHGkvO67zadzrpuf+L0UUA1Fe6q7ZHknSFLqDDLGU9865SA
 D2lxWiJTUKdKu2npJtDnKy5LnCIiEBKl/rkRcZQk/PP/1Xg8Fk8i2sU/081hz2pHsBgS
 Dx18X8Qp4B2UUhTAwDfDz492Y22+uYUut8vI47EDeaHrXEhjEzsNF3TCyXEPVpLkiEv2
 Y8SFryhsrnWnFGAEz2D/tHL//RqZ0FIrZCPr3cFPNojgGb7NUUq2+iq/Ucgz+C7gTlls
 DCbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUmPVU6RzddHdOKHEgE3tgkFRe8tO0zMOurc56DOpH3GWdYFVQ2yTQAEpWPJbDWeS6q6bzAcUqwu9G@nongnu.org
X-Gm-Message-State: AOJu0YwSdk5TzraZNEuwxVEaa/K0JxPfhLtbfR0fWCUKdtdU/DiJGX2h
 lMDWO190hEJLXNAzD4SHaFmJbKn0wsDmZcpQOD8h5PzkNJagg3+niLSbJoxb0I4=
X-Google-Smtp-Source: AGHT+IFQexePo8ZHJF4NXJeTHlbfkDIdQpQ9wzP/j2C3vjVoFh/r0QLm28V7lupTakjLKKo1q+NfAA==
X-Received: by 2002:a05:6512:10c9:b0:533:88d:48ca with SMTP id
 2adb3069b0e04-534387c47f5mr6217039e87.55.1724671857981; 
 Mon, 26 Aug 2024 04:30:57 -0700 (PDT)
Received: from meli-email.org (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868f48a5d0sm648353966b.159.2024.08.26.04.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 04:30:57 -0700 (PDT)
Date: Mon, 26 Aug 2024 14:29:07 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@intel.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Marc-Andr=?UTF-8?B?w6kg?=Lureau" <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 "Philippe Mathieu-Daud=?UTF-8?B?w6k=?= " <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 "Alex Benn=?UTF-8?B?w6k=?= e" <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v8 6/8] rust: add crate to expose bindings and interfaces
User-Agent: meli 0.8.7
References: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
 <20240823-rust-pl011-v8-6-b9f5746bdaf3@linaro.org>
 <841befb6-5ce1-44e5-890c-4e60fcbd4fa6@intel.com>
 <itc2k.22cnsecjnvt9@linaro.org>
 <c6c08785-3bd6-42a0-9fe8-ecd52974ecde@redhat.com>
In-Reply-To: <c6c08785-3bd6-42a0-9fe8-ecd52974ecde@redhat.com>
Message-ID: <itpbj.iuoq6f0pob1o@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 26 Aug 2024 11:24, Thomas Huth <thuth@redhat.com> wrote:
>On 26/08/2024 08.41, Manos Pitsidianakis wrote:
>> On Mon, 26 Aug 2024 08:31, Junjie Mao <junjie.mao@intel.com> wrote:
>>>> +unsafe impl GlobalAlloc for QemuAllocator {
>>>> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>>>> +        if layout.align() == 0 {
>>>> +            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
>>>> +        } else {
>>>> +            g_aligned_alloc0(
>>>
>>> One more thing: g_aligned_alloc0() was introduced in glib 2.72 [1] but the 
>>> current glib version check in meson is >= 2.66.0.
>>>
>>> Glib 2.72 still supports Win 7+, so no increase to _WIN32_WINNT is needed 
>>> for this version bumping.
>>>
>>> [1] https://docs.gtk.org/glib/func.aligned_alloc0.html
>>> [2] 
>>> https://gitlab.gnome.org/GNOME/glib/-/blob/2.72.0/meson.build?ref_type=tags#L509
>> 
>> Hm. Was there no way to have aligned allocations before 2.72? We can emit a 
>> cfg from meson if glib is <2.72 and handle it differently.
>
>Can't you simply use our qemu_memalign() function instead?

Thanks, that'd solve the problem.

