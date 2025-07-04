Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87658C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 15:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXiUZ-0003X7-G8; Fri, 04 Jul 2025 11:38:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiUU-0003R9-Uv
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:38:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXiUT-0006pp-9H
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 11:38:18 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4537deebb01so6309005e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751643496; x=1752248296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X+1qdRe8xdVibZVctag5le32T2XQilUjEKnUgN01u1I=;
 b=VInX977Ixg4a8vRbMrhE7rHRCRuG4DYxki8KBXunzoWcxOjjcMKYCe5pPZDLx3dGba
 a3I+w63cc1vQFNR9spo9GMMZqe4vm98DTZHioZR+GM17HA6iTruWXT/evXXBjgBD2hZF
 ioPwudX29oab268fwOMFHwxUvwIrhf4kKm9+lo7r4cGqsVoAOmUYk4AOUJjLpqFjuxu2
 4rvDQNRUQM7MGJmA2yIbltntejx9ilNwkPCZ/UkGPsX6RVMlYivISaq/uRPkFvYiLb4n
 WK4tyc65aWH6QufX3kzYytiF0P3iFHG5n5D2fzvGphHhbfR0zIEKmBlHJk1bsipNJdu9
 zTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751643496; x=1752248296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X+1qdRe8xdVibZVctag5le32T2XQilUjEKnUgN01u1I=;
 b=qaKTj3v90moiimLUD08VHAdFvRqx4vARIfURU/qhtR06Te726B+rVYmJrSmwOE9aNc
 frsGvngF2hYzcxgKqiIS867NIHDFF0IM+R/myGHzJAHAG3GTedfBs7SL/V11hP2kP/Qz
 dRyvTz8tshv5/bpnpyW0eKjyz/HGhnT6YFL1kVgKLtCA72IjNBO7r0t2CK1QGEW/bI+G
 +yF6VtndaOHxMiJOQc/Nl6zJHYS7ceWnGoAgC/K9T8q77eAL/cJsumYIzOIZvNmF9vb5
 w6AQVSngALZrcupyqiYBo14bYLpEweurhXTE30FhYwAKwTg4T3WADXNG16QCRXsEiueO
 eyFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIBwoiqByXlMqB+HMs1GpnRgWozfnwQETAguUoufRvpnUUVafS3kevlQ0Lu+KovHjVYwr4F+8cLL1m@nongnu.org
X-Gm-Message-State: AOJu0YwSzh6c6xoN4j3bUcbGO4JXAW1uZXF9NNVQg1JqxAH8AiHoHdBf
 bgNwwhTH2ipvWLt0MqZVZpFjoxVY2TDtqpnPW6gAaOUJh1lMRdOVMMwgIX7xKNAy4bM=
X-Gm-Gg: ASbGncvBDK4VH/ax7y6R146vwz1rCnozRu9xcUZ0PYVM0Jqf4fLENWwltmz8tsSv/zc
 0fY1+WIfQGWfsgPKGSS9v0o70y2rcw8vIfEEL+8LFMCt646DqpdcKCmy3U9c8kkDTz5qi4HmXrH
 F8pLjlGvnGCQI1PUkk9Gcs4l4kGv3DbhlxjczT3yfbSbFuebdL8oiHT9/iu6OwrGMiYWufO/auG
 ISF7Pdyt5N7q+IVqcHrLOpPQW6PJJdE2mvwACgfkrW+18bWTuReSWsabDEwv4W0tgZ3RCQ2KbhZ
 V9aMaaWY6VfR/0o4Q4lO1SvoGXib5v1MFMICkQyGL2mlqZ4LNzkK/3cIagcS+UkO98YV/869Qd1
 DsFfbKB3tf9t79FsPmm0JDG8FGnxknbjh1j4=
X-Google-Smtp-Source: AGHT+IHcuHHEjdUxb/M2/nYp/Y7UU9l7VBD5evkn10b3F9rJKXR4hMJh3JkKziAT6lAW/WHWxWWugQ==
X-Received: by 2002:a05:600c:8595:b0:43d:82c:2b11 with SMTP id
 5b1f17b1804b1-454b5110eb1mr19523955e9.23.1751643495625; 
 Fri, 04 Jul 2025 08:38:15 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1687488sm29576705e9.25.2025.07.04.08.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 08:38:15 -0700 (PDT)
Message-ID: <05f558c0-9047-496d-9d47-b66d02d7b8fe@linaro.org>
Date: Fri, 4 Jul 2025 17:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm/cpu: store id_aa64afr{0,1} into the idregs array
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-3-cohuck@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250704141927.38963-3-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/7/25 16:19, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   target/arm/cpu-sysregs.h.inc |  2 ++
>   target/arm/cpu.h             |  2 --
>   target/arm/helper.c          |  4 ++--
>   target/arm/tcg/cpu64.c       | 16 ++++++++--------
>   4 files changed, 12 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


