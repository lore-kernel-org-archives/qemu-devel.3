Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CDBCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 13:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNYg-0000pA-9K; Thu, 04 Apr 2024 09:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNYc-0000or-Sg
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:55:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsNYZ-0003br-Mq
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 09:55:10 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4162cb37516so848975e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712238905; x=1712843705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDo/l27kP1R8ksI+nzmyQ7nTod5P/GwGfNgGyOvLomc=;
 b=RvlCHaQaMjZGzKr3VpOAe+TregT1P4dogxF4OKo6YSqaUrsJI1QPsLyJ4A1UAeipzE
 /DjP+1rBZKiw0SPudbtH2rPy3crW/nNmigqbm/50vUEba1j7cKQyhojBcqE1y5xexv89
 hGonCZ9bCqCoAtIa23qVPbBBOod7xD31+HtA9ilB02Kw8f+1X06i27zIASHp9FSWNC/Z
 OjRwHgQrFqlaW04g6gBss/QfhdN70jL2MTKQK9kgbopxIROV5gNBs6oPGUuT6+0DOYV0
 mGiYj9YMVqy4sYFRbBeVu7hScpQRI8juouJjcz7oB6SMPevlMM/yvM4AfbeJKYUvpGOF
 69pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712238905; x=1712843705;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDo/l27kP1R8ksI+nzmyQ7nTod5P/GwGfNgGyOvLomc=;
 b=jGqivTigplYLH7UBaNN/1jRpZthV9qtTI1GNPaLlsxJUOa0MwaijCCEryAhwNffc18
 JqHs3bTnTKskPQdtXEn/l00Fwye7qslGNhLZ/qvha5O1SRR1gQ0jQ0J3aLcugRykCxjC
 JaRlvWYOCMHna1ARKknOT9DXlwIK8KPHGeIccdX+KK4PrpRgy0DnSiOkgGaRLVX1dMZp
 gjy52Wt5aEWbFpQzvfwvhrBUo5bxmtuZ25k+Xf8gMRTrZpnXOuPZLZNMOPS9oBpkSEAQ
 n9pN8UkzKtBRKgsgr9buwfvV9qCeUkxsfBTiYwoMvJ3PVRNVnkhjA29GfzSQYvozwcsG
 /omA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXs7rX+QkgM5e7UuHL1rpDXsxf78cVles6wAaaqKf8h+Hx7cURFe/KKSDufQh09OVzKcI4bWE6CaTI3UbznWC5OEN3jgnw=
X-Gm-Message-State: AOJu0YwfRbCNW3YZFGoYwILr4C0u1Gwm+JkWRhcS01g39gdCz8BsY2T8
 2GNg4hI5WSZmmL7pYxlNjWUAy2f5yMkIgwxw5U9WV7HaVfGn4QZe9qfJAiGGjTQ=
X-Google-Smtp-Source: AGHT+IFU4eK3F2e7eQj1AyiMq397RWKevGlCi81VI+RMBKeb4BMe1ItuKxadVTHdGou94Pbc72RtbA==
X-Received: by 2002:adf:e4c8:0:b0:33e:72be:43ab with SMTP id
 v8-20020adfe4c8000000b0033e72be43abmr2633225wrm.24.1712238905518; 
 Thu, 04 Apr 2024 06:55:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 h18-20020adff192000000b003433a379a51sm6308980wro.101.2024.04.04.06.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Apr 2024 06:55:04 -0700 (PDT)
Message-ID: <d8e0c229-50b2-4278-b503-2133cc619827@linaro.org>
Date: Thu, 4 Apr 2024 15:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v3 01/11] libvhost-user: set msg.msg_control to
 NULL when it is empty
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, slp@redhat.com, Eduardo Habkost
 <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
 <20240404122330.92710-2-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240404122330.92710-2-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/4/24 14:23, Stefano Garzarella wrote:
> On some OS (e.g. macOS) sendmsg() returns -1 (errno EINVAL) if
> the `struct msghdr` has the field `msg_controllen` set to 0, but
> `msg_control` is not NULL.
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   subprojects/libvhost-user/libvhost-user.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


