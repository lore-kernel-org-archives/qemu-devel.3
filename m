Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959C6C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxIh-0008Td-38; Tue, 12 Mar 2024 04:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxIb-0008QB-Iy
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:15:50 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxIZ-00083p-Kd
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:15:49 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33e82c720f8so4302816f8f.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231345; x=1710836145; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tp6NxClbVXDyJNhhoI3KPgtNdC6YE4wKSWnCt9ou050=;
 b=btHYXCC0GrFDdgtao8pKJCy/EtVerfbBydzlmrEHcF9DfFGYpDF8mznzkI02tUVG0y
 +HEvgrRmc/554/4vtsU81TXO8V8xGoRieryqf+6yctGNOQYJaZ42V21a1+0V320mhlAf
 PymFLFK+lixUwK488Fra5ApU/TUxYZnZSOlWB1F/T47yaHTtbe12LlcD//GJQk+KOn8O
 8zI/9SAzT9nsrP4tDEduCLmdc3oHT0ne5UBWMY2D/Db4PQRgr7q2cED+gGRKP+GcUSyc
 /1dlI8LMTPxZBH1sntnoBivKVHjlu5n6NjpAeIIyMj5wqZf0GbfOGtPOxOoVFMFHPbvF
 9aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231345; x=1710836145;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tp6NxClbVXDyJNhhoI3KPgtNdC6YE4wKSWnCt9ou050=;
 b=xEeATIq9Pvc7uV8cW+dNHNDaacoMUiw9EUaWn/J4k/05lS2qmBnjvYR7OSDrhiaKN4
 q8AH6DF8KGkZh557IHBVd6/wL3CipBOOmvVLjMrBxNPsNi0nxCYDehA8zVsKoXn9NMwv
 hvU68OIGSB0SFyYbz6g6ljZKC8u0D3WhjzlNDzYduEcnfJbiQ1DMLzAfSAN04lJTQc5S
 kAZidQ/ZDuRZH7uEAA7HKEv3ur9gKpBfPLuoT3Bjf0yEAXVa51+wgJiKAGPL1SZ+iuLp
 FDxBu/beB4Tt0Mhl3Ya0b2aT9EBYDdPc5Gu7dUPYIr3TdYzFkOp0su0lwtLWrIuqmkWn
 LGWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV932rnVYPMgMpSlUQiYhrhiQgake4nSW80+H8QJaj6uGBV0QfUb3rRNRxyDVXhG0rVLIk4NL/4sERvR3IOHzuuSDjiTZk=
X-Gm-Message-State: AOJu0YwI+KEo/PFj79sKj7HnEIBadVVTtgfZ2k/I3+fMqs2j5JPBOyIx
 WC+nBHtYoqolGqmrLXe921j55UUYQCfX8ckaO6Babzwa+qZtMeh83SPm+nshuJrSylme5PXSmwt
 s
X-Google-Smtp-Source: AGHT+IH2OjX5I57TvwWfbMU69YBgVhUIYPXHX7u7LoguQjji6GnSUBqRAjpaK5jn90UajvKCb1AAFQ==
X-Received: by 2002:a05:600c:3b8d:b0:413:1f8d:f97f with SMTP id
 n13-20020a05600c3b8d00b004131f8df97fmr5978237wms.29.1710231345534; 
 Tue, 12 Mar 2024 01:15:45 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 q14-20020a05600c46ce00b00412b4dca795sm11617377wmo.7.2024.03.12.01.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 01:15:45 -0700 (PDT)
Message-ID: <32db6066-3bda-4598-a438-78e147902b9d@linaro.org>
Date: Tue, 12 Mar 2024 09:15:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Always require an objc compiler on macos
 hosts
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240311133334.3991537-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311133334.3991537-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 11/3/24 14:33, Peter Maydell wrote:
> We currently only insist that an ObjectiveC compiler is present on
> macos hosts if we're building the Cocoa UI.  However, since then
> we've added some other parts of QEMU which are also written in ObjC:
> the coreaudio audio backend, and the vmnet net backend.  This means
> that if you try to configure QEMU on macos with --disable-cocoa the
> build will fail:
> 
> ../meson.build:3741:13: ERROR: No host machine compiler for 'audio/coreaudio.m'
> 
> Since in practice any macos host will have an ObjC compiler
> available, rather than trying to gate the compiler detection on an
> increasingly complicated list of every bit of QEMU that uses ObjC,
> just require it unconditionally on macos hosts.
> 
> Resolves https://gitlab.com/qemu-project/qemu/-/issues/2138
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Per the commit message, in theory we could allow a no-objc
> build and disable coreaudio, vmnet, etc. But I didn't really see
> a reason why that would be useful, and it's bound to keep
> breaking unless we actively defend it in CI. So I preferred
> to simply require ObjC on macos.
> 
>   meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued, thanks.

