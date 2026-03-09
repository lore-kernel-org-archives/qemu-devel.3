Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25974FCA168
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 17:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzeoB-0008Ri-3f; Mon, 09 Mar 2026 13:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzeo8-0008R1-P5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:54:21 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzeo7-0003vl-5U
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 13:54:20 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4853c1ca73aso10058185e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 10:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773078856; x=1773683656; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DQpCcbWib06GwrSrjKEgPauEB4pMQNN0BW8pnBJ7+wc=;
 b=nCvCoFiRTwQEZys8B1OJihA3SERRtrpUfGVuLGt8AdyaZceE0agy+XZiJnVqtxokun
 eguSrwH5RU6wcwMgb8So0PCGV58/2bIrltxeKMDyZhmkJE0QyXoqW4AL2HerXEhkPlLE
 skdb12YZVkj7dlZ+5chh/Up9pXmn1kJUGgTYQ5s28kKx5dqRhf4sh5+AW3WGE+HeTvN4
 cnmORM8wkP2YsJJilhiyPXKrUI1Bv7a8KPIJpGazlmAS+CsTM6Zuux7FftGZaXUqxyYz
 aXNO6HSSti73RQcwrEI4uV22JzX9D3kfByKS9Koj5iI8Uf0nn9bD5/TpwsiRagViKIox
 EJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773078856; x=1773683656;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DQpCcbWib06GwrSrjKEgPauEB4pMQNN0BW8pnBJ7+wc=;
 b=oHNdtiP8bn+6AezRzjEomLUhFLtk77wdF4UHMIhVWNt/oBonbRbXK8G+V48J0NMU/l
 ajmjuGt0Sm4oQ6lbRmzNxWG34S4W2WSSevAxHqvR79Q4dxnKefi3YFEOV+F3WLRmVA+7
 hc7YD2UMRHS5AMgJl2Jqt401oVoFMfV8BU5zD5VnR2TMV1wH2OE6SvLULbY4HEBkrqBn
 FDBjrZJoo1cHI11lwchiexnm1uCKMQlZ4NoJVIE6oPP1Ms10Osay3fU6tig14iCEB+cv
 d/VRLCp0VMTqTA5Fx3ZNM4UIpeH1GIwE7KshBK3jN6E8SmQCz2KDxxPAGkxYTFqXfR8t
 qs+g==
X-Gm-Message-State: AOJu0Yzr5iEuKRFCUecBjKBsUrJjJX68D3EyjlZ8w0R5tGuthohVc53Y
 dyad6mWyKU8O9Zx/+tgN4QUzi9QpdU+y7G+Yo+MTrXzjOIvGH5jUUgOf/Xft9HbdE+tmmYXAzn9
 S65Wq+3s=
X-Gm-Gg: ATEYQzwxEKq63vyYOZ4DsgKQK6QCn6oV6FaG/NdZwY6lj5r60Fk94UUE6neXM3AYphM
 GZXitXQs3UUpYh4XHDehYtahkgbUQR60WKE7SuCvV1u9xLGfxiAirenk6F1kcSFrrApDAjbRqxx
 x2zXpoWhKpeC1FSYimRetfKnauIpO4R8pIzmzUTPgZ5QaPCKPPBeMsG0ya3eI3CZSuXzDbxOGAR
 UuBYxZeVcNkCQ1HajCSHY0lfCbwWiqnEMGYHzCW830mAZFL/WKyWqzllGz+d2exDtJuM+x5LtE1
 8oZlKG1Gap6WYSzTjJPGDXAHXcY/8vixZ8Yrj9DQzg2hYW/bTIqEod08VWcWoL1nCkJPqqVJ64U
 EOk+PIsy1nukIslmkjofZYjHQf8f9XvMaWm4xDFaDUyluyk+3wajqqmZAkkpSBru8DlsYLCAooK
 Gr3ivXcNyORBJNPuGX/7W3jQ3a57MX+NG2UTfFBGrEQJg3B3ZDNF05KLVAgYuFSaFoXQ==
X-Received: by 2002:a05:600c:4445:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-4852690febamr219281285e9.5.1773078856525; 
 Mon, 09 Mar 2026 10:54:16 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8f610sm12732545e9.7.2026.03.09.10.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 10:54:15 -0700 (PDT)
Message-ID: <80f7ebc0-2ca9-489e-a017-29965a3fa50b@linaro.org>
Date: Mon, 9 Mar 2026 18:54:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] accel: Try to build without target-specific knowledge
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org
References: <20260225051303.91614-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225051303.91614-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 25/2/26 06:12, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    accel/kvm: Include missing 'exec/cpu-common.h' header
>    accel/mshv: Forward-declare mshv_root_hvcall structure
>    accel/mshv: Build without target-specific knowledge
>    accel/hvf: Build without target-specific knowledge
>    accel/xen: Build without target-specific knowledge

Series queued, thanks.

