Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1A9D75BDC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 09:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE3Lw-0006zW-VT; Thu, 21 Nov 2024 04:19:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3Lv-0006zC-8j
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:19:55 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tE3Lq-0006Uc-G2
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 04:19:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4316a44d1bbso5195715e9.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 01:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732180788; x=1732785588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIDdrERkWlbZ6yxoIaloE1RT3v/1aqz5I9Ys1+A7e8o=;
 b=G9RcEOINLLur5A4DovvxwmWXPvFkPbsU9buqGB6czoRc1Syfx899hYI1ZkYLl3D5UK
 I70woVcBh9zZLQOBzNs8Ph58FiIOfZgKI92JH4u07YezloeDgWQ93G6Ghv1aeItZA6m0
 VT3IIeOUMhsSmH4lXfD08AlSEFJhaaFOABax5ARgR66GppBhW7XGuBznXv03zgLMpa7j
 RWbdbY+G44E9+jzT892PWtUphDOnsLTvAfHxjYxqslYzPKlZFQRMVqoqNkfn/xmesC0Z
 y6us+E4mzZ1rxUZrja2TIHHdV4N8OqsxuzMFxvQcBSUL2Vt+0mH15jZ01kVWmUKbiJY/
 1aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732180788; x=1732785588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIDdrERkWlbZ6yxoIaloE1RT3v/1aqz5I9Ys1+A7e8o=;
 b=GjRIQtaRDCmdmrufkDlDfvBooPi13sACkWH6INmLxZGmad3wF+ZFEs+keHtJJGlLm6
 Y/X2bvfMepIXKLEL0LDUxyvnDNP8kQyQFIujs8zETyG50vdUZz5TF54bMVfU2sUHUm1+
 iy+ciOBWjgTrgkBOoowU/YJ5iVG7L95GN0XZitBce1KxjDxIODzHjKXnV0oQFk1kdpm3
 4xPq4RNuTDnUzsOqpXHgNYlLsB8yolMa0LynJIpmTEsOAabtEuu/k2UFekDyPJ/5cxdX
 ZZ5YLig3bBhaSCizf6moBaJ7TO0nuxqX82B5FxX1aBMeEgAZfSdGlI7191N1qrjQH+6c
 6SzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX946WmQjSMu10+Hug/RbDxTFgWKG+1A4OrOSxJV1vLwmnp9WmxpbI9GiNVLMzTI8QiPucWIgiIJC4@nongnu.org
X-Gm-Message-State: AOJu0YzcbhZytjuXtEb00sSkEQiDV3gPVQ4m/MNUgTIKmLNW2fTIVz8U
 miAb1MWIgjEjblYUvL/UN9aIkOL0QXVZ5JgSbusS2cAW55pu1mIehiqviYMLnJI=
X-Google-Smtp-Source: AGHT+IHB0IcqnWhyM1Zddf3gDsivObbS2nnaT6M1RoevEVnoKLgAdcrWtfDHOT/ZgNFCMzXLnJPaDg==
X-Received: by 2002:a05:600c:3b83:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-433489b0c6bmr60326475e9.10.1732180788639; 
 Thu, 21 Nov 2024 01:19:48 -0800 (PST)
Received: from [192.168.69.146] ([176.187.204.90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b01e0584sm47511745e9.5.2024.11.21.01.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 01:19:47 -0800 (PST)
Message-ID: <0ffa4155-327e-4f49-a7fd-7a8cc6788c69@linaro.org>
Date: Thu, 21 Nov 2024 10:19:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/12] ui/console: Explicitly create "/backend" container
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20241120215703.3918445-1-peterx@redhat.com>
 <20241120215703.3918445-6-peterx@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241120215703.3918445-6-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 20/11/24 22:56, Peter Xu wrote:
> Follow the trend to explicitly create containers, do that for console.c on
> "/backend" container.
> 
> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   ui/console.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


