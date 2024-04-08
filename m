Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BA8CD1296
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 16:47:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rts8u-0007Fo-A5; Mon, 08 Apr 2024 12:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts8p-0007CF-Sf
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:46:47 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rts8j-0002K8-F7
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 12:46:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2a528a1a1bdso710223a91.3
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 09:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712594796; x=1713199596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5i2EYF6lSwBNpne09DIMgqKo6sqksecLuVakWUvU898=;
 b=oOFV/moL+lvEIcfizzg4fBnoUKavn0EtbmKeAVMrwPWVZSpdY1gVuy1Xr8vRIWAtfK
 kB/yFep1v9gh1jiaJjZOa7K65i8hqn/jTsGkIWx+QBuntt8dUejBwhDod3cnC+90eWUT
 R0uu3gDmm86Eo9V/iqpO0JxeVoI6po1EvGnR/6Cf9jVzU02FlOVTDpUN7KzyLLEHEeyg
 RxBZS6Ykau5yJXWBQe75qK8q4pB/Q0z+pedRfYJwa07zZzQVP138Xx09dz2BcMqFxbeg
 2gqZO0IdGfZ/EG10FzcMlGW2gJP5ZEt8zKkgADnx1OWj3kd2mZ0Hov+WgLaigKNviizY
 DOfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712594796; x=1713199596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5i2EYF6lSwBNpne09DIMgqKo6sqksecLuVakWUvU898=;
 b=k8wW+1F/Z4j3/2VLB5+GVKanYbKc5kIqB05FBjgjvmN82PLiX9wSxAbdtNHeNil+15
 FTAs/hx2AJ/NDspaAOHFRp41T33CXVNVs7Ppc/Xce8/hBnKat9nAwCRV2tx8XSDvlztC
 mQ9+j9gMko3jfC5yGyb1qKYj+YFTTuVjPheKCVTmag3jy/Css3NSZ7dsm8q3w5ovmK4Q
 rxmFsnEjs5uVXbRZXG5Oq21uYlfazuDpuEO6UuPF+9hhzXGGTJMLZRY7hljESSm82cA3
 htJ0BicAEp7IFk18ytBI6Fu5zIDwAPJMbZHsFFmdUwgDN19//KBNdcfDLxgE+ADFQkce
 NHlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRDVnfn3SVpfHiS7kij7Pkif7m3ljYDY5ONPGR5/V47kD8KZjWUZDH9GH/TFe0ojEYnwdqvpCHXTVqD3UPk9yaVOnHAxk=
X-Gm-Message-State: AOJu0YwamRhYqABFDKJSYBypIjrFZ5OzVCpSffB9pSeVwoW+3uzmimxl
 y3ehTlAyxD5xnf5nvtUk98hOewrdOBOywbpjmvD9PiXW4UeOhjWS2kf8aj3q2ZfWPgBK5fLBenR
 R
X-Google-Smtp-Source: AGHT+IFDrE7bFbwHH6/hpKDJ/fwIwI+5oomkgWttRVLVfgBZ0Sy/aaZDyG2DDpScGFptsLKJ5NhmXg==
X-Received: by 2002:a17:90a:fa84:b0:2a4:774f:31bb with SMTP id
 cu4-20020a17090afa8400b002a4774f31bbmr6740841pjb.33.1712594796010; 
 Mon, 08 Apr 2024 09:46:36 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a17090ac24400b002a2fe0998f0sm7053684pjx.19.2024.04.08.09.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 09:46:35 -0700 (PDT)
Message-ID: <48d7f188-04ff-4ab9-8254-ca444984bfe3@linaro.org>
Date: Mon, 8 Apr 2024 06:46:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] stubs: remove obsolete stubs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20240408155330.522792-1-pbonzini@redhat.com>
 <20240408155330.522792-10-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240408155330.522792-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 4/8/24 05:53, Paolo Bonzini wrote:
> These file define functions are are not called from common code
> anymore.  Delete those functions and, if applicable, the entire files.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   include/sysemu/sysemu.h |  2 --
>   stubs/isa-bus.c         |  7 -------
>   stubs/module-opts.c     |  2 --
>   stubs/monitor-core.c    |  6 ------
>   stubs/pci-bus.c         |  7 -------
>   stubs/qdev.c            |  6 ------
>   stubs/qtest.c           | 10 ----------
>   stubs/usb-dev-stub.c    |  5 -----
>   stubs/meson.build       |  3 ---
>   9 files changed, 48 deletions(-)
>   delete mode 100644 stubs/isa-bus.c
>   delete mode 100644 stubs/module-opts.c
>   delete mode 100644 stubs/pci-bus.c

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

