Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31514C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:09:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJWhs-0002Mp-9I; Tue, 18 Jun 2024 07:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWhq-0002MM-23
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:08:54 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJWho-00046N-FV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:08:53 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6269885572so1076894566b.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718708931; x=1719313731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TUa1inIX9KdwJHKeGFbDHGO0EDxxcgeVNNKp5ffKjYY=;
 b=NHL9d2a1uE4ZapKUD3PvxJsPqZ9UjVvZAN7nqUwXTz/OSetgQDTWtAe3zrAFPUqZpv
 ShoaDezLn0WxldQiw/ha5pODqFBlc2352gocSGnxSLa+8O2EQXuFCfcazrfdUU3lcyMv
 IH/E0l/R/pXCNRvDlomZJDed0XXqsRilkYcGlnzcF9hmixehoEoUT6kUPUeVX7yjhu2V
 npZX8foTFlIcWpxmSgpRhpYsPlaJRxhTgZXBupaD0p3uDc72nBI9p6F4cBmYkDTY1NOs
 PKjp116sDl9ekJo8XyRuMq8eWCcFRoHC5SECKoCtXZddTyGfd/YQjJHfGUa9gd72Pvrb
 IfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718708931; x=1719313731;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TUa1inIX9KdwJHKeGFbDHGO0EDxxcgeVNNKp5ffKjYY=;
 b=DjraGxRk87T6eJUh3Qo5mbBifFK0I+Di/MQMJu8Knp+0yT5JqIM/cz83Bpx5lWUrHc
 EVtscL3WMisqidL5wjdP2B4RDMX15PYIx+v4ZcYlnEF2sS/4tEkd+F0PZjJ7J51MaLVg
 DLcSv7shSQ9PtHrTdmErLoWm5U0VO9sr9fg4ewBBB+rK2dtJeE+X4g2G3Lz6ptaPmJtY
 azRvEgjgOsI3Q11jLktESSw0drRCgFa9z7ORXTPfQ2GkzIAhrZ3UmAvgSnvZPWvhNHMP
 gl5uG+8kmrgRdu5w/AiJb7mL+w/4t4tKROdM8oUELxekCQk4ummc94QBckjzZl5Th+LA
 a4RA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxc9gp11faxuJ5XAZs1MWZNOsrOnSHY08jpyv0K354N0U2X0XOHp0q/Q3BgcI1uHLC4jC6GkfcIA3YqkORZzQs71jUn64=
X-Gm-Message-State: AOJu0YwhCGUwVUZxs7EzyPa1sTScCkwAOFP32VRIMIWGj0cZMjSpbIWu
 DSMhQ90w+L1c+gy6JZ6oHCVlC9n/x1p1bi70xOuUIeOHjxaZy8aBvtz11aWd58lRYwSKIjk9sDT
 au+4=
X-Google-Smtp-Source: AGHT+IEWOyL7yTFsmsSyir5tQhxbluhVNQhJn74o5D642Kwf7mxM1ofGsp9yGSyxaAEYq/J2aUUHkg==
X-Received: by 2002:a17:906:b318:b0:a6f:259d:9a5f with SMTP id
 a640c23a62f3a-a6f9508e83cmr133167066b.35.1718708930655; 
 Tue, 18 Jun 2024 04:08:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56da4486sm607939266b.1.2024.06.18.04.08.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:08:50 -0700 (PDT)
Message-ID: <01fd70a0-30e3-45aa-ac95-ce36e593a264@linaro.org>
Date: Tue, 18 Jun 2024 13:08:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] stdvga: fix screen blanking
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Anthony PERARD <anthony@xenproject.org>
References: <20240605131444.797896-1-kraxel@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240605131444.797896-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x634.google.com
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

On 5/6/24 15:14, Gerd Hoffmann wrote:

> Gerd Hoffmann (3):
>    stdvga: fix screen blanking
>    ui+display: rename is_placeholder() -> surface_is_placeholder()
>    ui+display: rename is_buffer_shared() -> surface_is_allocated()

Since Marc-André reviewed, I'm queuing this series, thanks!

