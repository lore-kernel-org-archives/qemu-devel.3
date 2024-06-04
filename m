Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C06C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:05:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVhz-0007Np-5R; Tue, 04 Jun 2024 11:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVhy-0007Nc-5O
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:04:18 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEVhw-00086h-IL
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:04:17 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a68a4a9946cso366191566b.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717513453; x=1718118253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wSzs+zKcUQxrtmTuUp8fbNprhDlADaEg/kR0r35duH0=;
 b=K9tftLJa0nZfXnwcGA2YdHc1RUckQ/wy3++Yl4YJtX9yUmisO4ioXRivecn79wGsF4
 i+DuHZTi+ouEawF1aB//y0UMd0/k9yC2l7JsHf/SQyBa21Xk1P0vTm4qhJeHJ78IIMuo
 0OA7ch3JlcAb2ljkdSYpkIralHDtyx6YnjNCJ9lpPMdwC+pLJZiqjDpaFGyuRmlGC2Sk
 +19BxB8z45jqm9GBqsLdBF8yYItnkN7/TO8z0cpVkQ/SkuQEh2a7uiRFO3e0erX+tcOK
 58VGpoNrN3YY46h3bjB9Yq3rLWKqsxvZ8Vgjoddj9PJ1jk3ISSuthLhcCtsUcW4eyjpa
 1UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513453; x=1718118253;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wSzs+zKcUQxrtmTuUp8fbNprhDlADaEg/kR0r35duH0=;
 b=UkXphWQimfmpdKW3KQ0hHmPLtKeWA05a/QOmO9K++AZg2tha41+A2A7wdEGdrcpM1C
 J349gpXtgeHgPPnBCp7RLOHHmehDcDpvBR8DRbf38nV0Gk8OK1tcY20xJA7gUo0Dc5aB
 XXKvI00N5gtMyzmyDvO+uuNmJcRrwwmC+AqVHQhHOyC0VEjhc+2vr0N1EAz1M9C6D+3q
 9UGl+07vFyRiBnUUh8jMvLchjp3sy7CWRyyCd7R5CLdaw42Gmng8z0/n58SLnAH6djg8
 gwRA4bHbohEq9/wY9yoTObYMsvSBn4X/KY951pBmj/SOGhpitymNINaPJ9K8B5xHvgQ+
 Fusg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeGiEBOeC4KWrbm8mYF/thakleMoODzgXeziT9uUd3l0zpRCVX/+5vWpSeE4umOTYpI7mJK0Lh5vnCJ7YtX5/dTuhCbB8=
X-Gm-Message-State: AOJu0YzRrSWLarLXLf+Te2BvsBtzx53e9StQzYRx1Zr7ctKp/vUQxVnV
 kj6EC7L725C5sZ2Ckjhl1/DAomYgO18ILKmNayF3Z6jNwo4+J6/bmSmSkRS7cUE=
X-Google-Smtp-Source: AGHT+IGJfiY38eKkXOnQni5+IjP5Z7x2CJUQFHtXV3T8oeckHAsi1oDwsRVt9N+hfZGvMtjwluaHiw==
X-Received: by 2002:a17:906:244e:b0:a68:c2dd:8ce0 with SMTP id
 a640c23a62f3a-a68c2dd8f90mr548830966b.13.1717513453343; 
 Tue, 04 Jun 2024 08:04:13 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68c64e50casm462884466b.53.2024.06.04.08.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 08:04:12 -0700 (PDT)
Message-ID: <ff369835-ed76-4b57-8eef-117b5d8c845c@linaro.org>
Date: Tue, 4 Jun 2024 17:04:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qapi/qom: make some QOM properties depend on the build
 settings
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240604135931.311709-1-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240604135931.311709-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 4/6/24 15:59, Stefano Garzarella wrote:
> Some QOM properties are associated with ObjectTypes that already
> depend on CONFIG_* switches. So to avoid generating dead code,
> let's also make the definition of those properties dependent on
> the corresponding CONFIG_*.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   qapi/qom.json | 21 ++++++++++++++-------
>   1 file changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


