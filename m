Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8084BC3DA64
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 12:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbJat-0000JV-1m; Tue, 06 Aug 2024 08:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJaE-0000GO-H4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:46:41 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbJaC-0007by-Be
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 08:46:34 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7d26c2297eso85998266b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 05:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722948390; x=1723553190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HWB6LIVN+Zwnu4OWUNEBlS8UUHECbtdYiXqrZjFNRBA=;
 b=HrzigwESO1sMiHokhZw9nzRvyrwgna4mgOHqlg9oa5mBjLksb4lpl0kp9C6XDqFT6r
 MGk+vPxnCTird8qBDw4c7pc4mBLEB6uoCmyQW/qevJvaQeXYNHuBaz9r3ftv5Ud/Di9H
 ghgifisCdqvJD+r7CxZbkD0fFGRTceF0XJnPbJceHqSUQaZAKRSl8kuzAddLkNYUfSKI
 4cNv61axUZy++RcIf8RhrG5e3NE8tZZllPoUq+9TXMhmEOVs75gnEIXhrhJ4btCu9t7t
 MjMyo+xF1K87jIfBsrzEo+Vx4SvLv8kvMhMTb+a4LlF647zmA0VYwvRzXGwe5qpqs9lN
 2caQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722948390; x=1723553190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWB6LIVN+Zwnu4OWUNEBlS8UUHECbtdYiXqrZjFNRBA=;
 b=MdZfGrnaJBMgtFfQQ/Z5qOXsgUATifAv93c9PLa08EkPR2awCeiyorLAaouvFLAzF+
 /Pbt9846ERrodXXgi3+a7iOp1P2B56tGFWbj5kgrMlbLgYt2TnsAoa4kN3oe7uJGiLdk
 8hKNL0EpMxAxKix6W9fSdU3yQVbYxOhK2Huq5H944EbCpGATqMB5AeVPTF1OpTDn+eHf
 qBVJXuGyrZlGHc78ffmXsBMvFniVzzLHFqYuAIoqZlSIdRF+rcCfhQZIZizQfSiI1+Os
 AtdG+8knaiTiP9sc9tP3569rO6y2FwHIWeRGdGfIN+X9i13dbyTLuUTBoIV/fOnmJ8wZ
 4W3w==
X-Gm-Message-State: AOJu0Yw7Ii2ndu1PZKOLPaj25lRXcApqwdFihN7MsWZvajUXaknCfOrN
 0PHw3+WvIT4SBZ7JW3c8Bz2FMVYpdm1S96Z5jLq1+iLi955EFh++JL00d5olya4=
X-Google-Smtp-Source: AGHT+IFuzz9hkW9P08+XMatbEVBhDjRSTDOyLMVrzsHywLg7EbPkPCqkbE6hxcs7qa2Wn/54qY3pOA==
X-Received: by 2002:a17:907:97c9:b0:a7a:aa35:4089 with SMTP id
 a640c23a62f3a-a7dc4e87671mr1176340166b.24.1722948389769; 
 Tue, 06 Aug 2024 05:46:29 -0700 (PDT)
Received: from [192.168.69.100] (cor91-h02-176-184-30-206.dsl.sta.abo.bbox.fr.
 [176.184.30.206]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e6asm545799966b.165.2024.08.06.05.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 05:46:29 -0700 (PDT)
Message-ID: <95478a0c-0da3-425c-b6a7-83eced408bd9@linaro.org>
Date: Tue, 6 Aug 2024 14:46:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] virtio-gpu-gl: Improve OpenGL and related display
 error messages
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240731154136.3494621-1-peter.maydell@linaro.org>
 <CAJ+F1CK3C0dM5vq8=VP63mg1xCC25XEEhsRFXaXQBeRw+ZYYRQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAJ+F1CK3C0dM5vq8=VP63mg1xCC25XEEhsRFXaXQBeRw+ZYYRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

On 31/7/24 17:59, Marc-André Lureau wrote:

> Series:
> Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com 
> <mailto:marcandre.lureau@redhat.com>>

I'll queue this via my hw-misc tree, thanks.


