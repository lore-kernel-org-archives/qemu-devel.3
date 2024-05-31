Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D97C27C44
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 09:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCz0T-0000Ul-2s; Fri, 31 May 2024 05:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz0R-0000UO-4e
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:03 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1sCz0P-0004sO-D7
 for qemu-devel@nongnu.org; Fri, 31 May 2024 05:57:02 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e95a1f9c53so22984781fa.0
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 02:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717149419; x=1717754219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=eTxotFDg5HC5VufmvEJCZwC0zHWN9oWX0NtnsJNidHA=;
 b=CEdiRw2FqOBzGx1AEK0ohzmi9Qdry43L8g1i/uBplUy+fGeZZHo+gJRv426UuteSmH
 96iWMJVTVHOLBGOxyRHw8SjpoheBCWHHknyaAYHbEWPvpVfSJFZhf/ffMbqMSTlnOtRE
 PiUeJHeLXBANdgmnrBcg61blFD46OnYcaSYlmKpwAKOh26PDrXWtKwAi78RYOmqBhsds
 sPEz724VZXfEHHivb10JGuraZPpH+3QrEaHNKAnpX4pR4OKroFl+EZ5cykG2VS0r0fdd
 zi6Jh3TmylV99fi8JS8tHQsq4SpqYksgFbYvR0O86FChIWn9/a8hwrcJnSA5ONor/7QZ
 Gxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717149419; x=1717754219;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :references:cc:to:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eTxotFDg5HC5VufmvEJCZwC0zHWN9oWX0NtnsJNidHA=;
 b=WkR+8Iuz2w/ppAVoZg3SGENGzjJU7+d1hVd8yxPzV6mVfkTTzLZafDxDjrCuV0K+F8
 Paih0S1emTIcIdaUxNsIjrDuKWBvPlj23/MOwvy7j/ODPNa/29iV/I1jUv29MzOtNBqK
 u0Ka5fLwAp6wThxXUkoYm/PZiYav0Lw57kDU6VMMrr2Uew5HtTXwox7Vo2QnR4p0XZtO
 z4c0RuMZsk5mFG31GcRWPKO7mU2RAVDSl+U2mpdlr+1dSLF7rHG98xZoxqjSM4GpDLKd
 94lfTyBACCJ8ZEz+Ts14TNxgcfukb7zyxpc8Y3CLVANV3ds2XqjnDbWfKNbwdbeyCXAY
 3zoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3OsKGhxKINTJQSblNz6/DNjyy2+zdFkXimEWavzaIW86bZYOzejQ1K1xMCcZ6e0QfzlMw2MvrD8kLvNgBk2MbFtTHds8=
X-Gm-Message-State: AOJu0YzNuAWM0d5XgmIAogj25osc/aMeDzqb17SyBCw9PCjdiKphmmd+
 hpz0uQ2IvUL/5N27os6MYbx3Sls/Fm23uPzgZ5MTTC0WNj+31eni
X-Google-Smtp-Source: AGHT+IEeGf9pw8BCYVzjYWzmpiH+1eGH7JhqRd4dZK/8oxCqOjugFt64RvUpuwxlKzw/gO+6K7zG9A==
X-Received: by 2002:a2e:9903:0:b0:2e9:794c:19ae with SMTP id
 38308e7fff4ca-2ea95122772mr10466311fa.23.1717149418688; 
 Fri, 31 May 2024 02:56:58 -0700 (PDT)
Received: from [192.168.3.251] (54-240-197-236.amazon.com. [54.240.197.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd04c0d98sm1473887f8f.24.2024.05.31.02.56.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 May 2024 02:56:58 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <cd6fec85-c5da-4b89-9ceb-cb10ef4048e4@xen.org>
Date: Fri, 31 May 2024 10:56:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] hw/xen: initialize legacy backends from
 xen_bus_init()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Anthony PERARD <anthony@xenproject.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240510104908.76908-1-philmd@linaro.org>
 <20240510104908.76908-6-philmd@linaro.org>
Content-Language: en-US
Organization: Xen Project
In-Reply-To: <20240510104908.76908-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=xadimgnik@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 10/05/2024 11:49, Philippe Mathieu-Daudé wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> Prepare for moving the calls to xen_be_register() under the
> control of xen_bus_init(), using the normal xen_backend_init()
> method that is used by the "modern" backends.
> 
> This requires the xenstore global variable to be initialized,
> which is done by xen_be_init().  To ensure that everything is
> ready at the time the xen_backend_init() functions are called,
> remove the xen_be_init() function from all the boards and
> place it directly in xen_bus_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-ID: <20240509170044.190795-7-pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/i386/pc.c              | 1 -
>   hw/xen/xen-bus.c          | 4 ++++
>   hw/xen/xen-hvm-common.c   | 2 --
>   hw/xenpv/xen_machine_pv.c | 5 +----
>   4 files changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


