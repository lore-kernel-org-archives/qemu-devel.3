Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E0AE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:31:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIw1M-0006Yg-0x; Wed, 04 Dec 2024 15:30:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIw13-0006SN-2f
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:30:35 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIw0z-0005M9-WA
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:30:31 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so1856305e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733344228; x=1733949028; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8dZ8N+n0dSzf9lZBkI+qDwvxZthdbNmKnyIEsAblrc=;
 b=WXT3wsdef1XHug+rfLYWP+aHdXvwUv0A9Wz7n8hE9Nd7S5GTpVizJ58mC/Z+lOSNYN
 ySKRwnt6hYjk7dtMj+GVcX5AqzB1A7t33uPpLvhQGyM3st5mSGG8vVzmZx7+TFBawDmm
 gqb1ay+mehz55PPc57jIlUXTkJNQ59aMM+f4lXkzzWx7dcJU5JLdv27km71NjYSuDTgo
 OAmmJHl36Bj2oqVMJZ7sv1szLcAPaUt8ar9rr//IWuv+DT2yqmi/jYQ+mIOogDU8amKc
 wMyQiAoqhSUX9UXkpJ4Sm8lg1yfrNnagbfcgOf37v6LRikK3SukKQph31ZCC+a7R/Ns/
 iVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733344228; x=1733949028;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8dZ8N+n0dSzf9lZBkI+qDwvxZthdbNmKnyIEsAblrc=;
 b=XDH1s2TtJNr3zFAdFMzb1L6SK8pOsPswF8dsWquUceg0t6gQ5E9O2DGa8jFSM61etI
 StcD9hL34XzgMs4hvgaCPAwJTr0MZyFPVbgI8gT0yI9aqdFEB7OAMfx29yFCbxKuuWHg
 pa5ZAbpsiFs93fn8TLD23NS5kH4yuVfbD28cGs3NE/pJCztHq3cEVB8jo9WGPdse878y
 piVzOKLf8/v8vLAAO+JIeqEN7H7InmAJyf/M5gm8kFttfhxF2GyQ75YShWE7+r4n6x04
 GujHnb3DWFsG8WS5ZX3WXrKLtg1R27L/SjC88LNuzEgWJqBgXuxVQui6LGUdq8jq4uUf
 ab1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVekZKrCywiDSmkR6yBJloyHPf+Hl3+bhVl/7Trep6RReHExWfk5ziQxesxlx0lUtJ+YEYPxZ3snwRB@nongnu.org
X-Gm-Message-State: AOJu0YxypjyNzo61k93Y1zB+r4tVOfT+cHQovAdPxF0X3fQSHPP/ue0F
 /q1ho03K08+VXtdQ/FfLRolBj9AmJlUsM/wbT67W8t3EYeInWBA86JV9RIgyxHcUsEN4Rwt4+dj
 /
X-Gm-Gg: ASbGncu19aO4Mb2dsVMFUujef8QpT/10BQEC/Dqk0NOJAiqoCtzeTaKcCea3mnqCmMe
 X9lFUpsDWEq+fGBjpzGk+FxuUIME19Kr4H/VobhAbKaeTuUA7k9G52qCUGlIny1k2DsKanUABAd
 SGYhOD9OMhNJQRusRSg1gWBkZDfn2PSiDZspokX8OitrrWQDoYwS92p6bp8pq2RhnVuc2lNp01s
 HRqaHDfvu5jUvKk/TPGOgeo0YddIS37XC/b8Pp3WgnmBlZGGcrD09vcDfQCGwKKywCg4P7Jg7bV
 BRG7yRSzkqZwb1uLAQ==
X-Google-Smtp-Source: AGHT+IGAMclJLlVFfAG7kHLBQ+gENdpYCOZxjpL3WdDHJ1IumBMsaeT7a7WynskVdngugBQogEubFg==
X-Received: by 2002:a05:600c:1d1c:b0:426:8884:2c58 with SMTP id
 5b1f17b1804b1-434d58438e6mr32736175e9.4.1733344227741; 
 Wed, 04 Dec 2024 12:30:27 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd367f9sm18907041f8f.31.2024.12.04.12.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 12:30:27 -0800 (PST)
Message-ID: <76f6e105-cc9a-4a0e-ba31-b96c57f65e27@linaro.org>
Date: Wed, 4 Dec 2024 21:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] gitlab: force ccache to validate compiler version
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20241204194807.1472261-1-berrange@redhat.com>
 <20241204194807.1472261-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241204194807.1472261-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/12/24 20:48, Daniel P. Berrangé wrote:
> By default ccache checks the compiler 'mtime' to determine if it should
> invalidate the cache. On FreeBSD the 'mtime' reflects when the compiler
> package was installed, rather than when it was built. IOW, on throwaway
> CI VMs, the 'mtime' changes on every single job and is thus useless.
> 
> It could validate the compiler binary content, but validating the
> compiler version string is less CPU intensive.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus/build.yml | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


