Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED37CC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU4j-0003Sh-El; Mon, 26 May 2025 05:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU4g-0003SK-3Y
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:24:50 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU4c-0003TZ-SI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:24:49 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so1430109f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251485; x=1748856285; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3ZKxr6bSGU5ifqS5UUoLOZyPIxtRh/BmTIMqdYSQm0=;
 b=SbxUGvf+LMR0EhcmTPcMYqGat6TzZdp1DHycrMNXVau/B7/Vwgj7MGnsbh0ySzWfWg
 nBfksOBIhXt2FwcZErO210PqrA3s/M8whtLQkw15GHoU85PoU2ZHzw3t5pt+d04ohsI/
 rLXE9DXfkDAN1y7qiEIjyLCHLzgK3ON5suqwp36ywiXQA4L7wQMEk9JofZCF9oxMQ7cO
 mLe3tXTnYLSpBTe4aEAz04psHkjugJuN9uBElZw6E2820mwJLjdNqHwQg8KjeGHUbzXK
 eOex+uj80YlKCOkCkIjgC5MIFqGXxC5Bpjq8OL9Ry/TO/bBQLCf1/89I/02Yp0djCdd7
 Asuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251485; x=1748856285;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3ZKxr6bSGU5ifqS5UUoLOZyPIxtRh/BmTIMqdYSQm0=;
 b=FCme5bC3Hlq14GzX0AcdKBLm1F5qeZND2j/WsH+jZp/Wt3eDmEW8EEKjsRUC2ILM6S
 U9KnIsx8uUWY3Jw4FRsa4cBc+KyiZLu8r0bRsB6inM3k4qtqC00PdYtA9O7AkGzrJDEf
 ZbwD6uipcwXMV4I8N4WPLvGylT5Zb+UxFrky7WUYSdK9N4ywIdDRiVfna2PNRC4/COJi
 F3ANvBnb3bet8vmbaFUFzzaK5uHANROh5+kkOIAvQZeFUcXBewy5RbbayTxvK3osHDZO
 l/etAbKO1nONClQnmc4F3xQa2OXIUHGenjf+VD1D6Gp9eY8oMtl7MixEtJnPztJI7M2R
 u5Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUldP37rL2g6hWT/yWQ1Qj4CvDezyf+6OBoYJpGXa+QgiZ0q+oCM6X7GwFaUGjdectCZanaycMTpuAK@nongnu.org
X-Gm-Message-State: AOJu0YxTiF9DL6zyHxEz06DBcN6hG9XhidgJbDaVt9OacblKc6bKqnPp
 jw2bX7aaJI4inCKWzKc0estvlkMI3B/OqJiHt1YTpWwzy3Wc7tlne1YYA+0anvYa0Wk=
X-Gm-Gg: ASbGncuQbO2uliZavBEzJYi+NgiSPJNEkwim+bAmqkl9FyPFvL0MWvYhFaQqp3O+UXm
 u67ziu2wCkHh0t1DsRPgzDu9kCJJtph7czlkhD5CtD2irrPc/kmAfps5Z9WtKe4Vo17+6NSx0A8
 3jsh/KVqpqZAnH3u8A5yOmUkKFlAGsGY/WsJHQvtBv/G0+Dy4Vk2pVGiRUGbRIz7Rkh6nmHkvy9
 o61AMio/UuuBHI3QsPy383LVSskvp5ATHQySTSCmFB0Rolc4BLwLiQSvbhLtOj2Yby2wO4mMAqM
 Y5FuAqnTjt7/Ao9+Feg+0f2GaYqVVzXRjbf/rE5pTk0rbXRGLjw55rIKJDKJNFm/OjF+EexEiYK
 AQ62jAQZrmA7CJ38ClxzI1Acq
X-Google-Smtp-Source: AGHT+IHb++datmEhVVbP7NSmI8YqwSj5e+VzVNcjK7/hOdNpcZyizxraquDPO4qtjv0oFdakiMO8Kg==
X-Received: by 2002:a05:6000:2512:b0:3a4:6093:d596 with SMTP id
 ffacd0b85a97d-3a4cb484588mr6216221f8f.37.1748251484944; 
 Mon, 26 May 2025 02:24:44 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d56641absm3723254f8f.4.2025.05.26.02.24.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:24:44 -0700 (PDT)
Message-ID: <f1610782-922e-4c1c-a731-5010a792be54@linaro.org>
Date: Mon, 26 May 2025 11:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/11] migration/colo: Replace QemuSemaphore with
 QemuEvent
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-9-5b784cc8e1de@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526-event-v4-9-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 26/5/25 07:29, Akihiko Odaki wrote:
> colo_exit_sem and colo_incoming_sem represent one-shot events so they
> can be converted into QemuEvent, which is more lightweight.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/migration.h |  6 +++---
>   migration/colo.c      | 20 ++++++++++----------
>   2 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


