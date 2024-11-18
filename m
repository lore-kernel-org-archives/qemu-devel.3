Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A7B8D49212
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 12:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD12x-0006dR-N3; Mon, 18 Nov 2024 07:40:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD12q-0006cC-L4
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:39:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tD12o-00048p-G5
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 07:39:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43152b79d25so24810775e9.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 04:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731933593; x=1732538393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/23he7hett4u2PEZfapDlgGaYmJg/BE5RWXE8p+wlrY=;
 b=LN2j4nPflqap2nV2Wge47/2C7SL418FOjd6Pq3wrrVwRGfOYtmrwWacoSk9uwMEqdg
 uMOsboZ+4e7hUht1Ii1WybNHwlluebLH72NNNE/Dn8B4D3Gvsfp3N3UizS6tr3QZABGs
 M+3S+JnluX/ukuHoxrEAM5wbe9gua4PlrR+zjPMkY9hXh2OC75sV9nmCgrobnc2DWdt+
 vsUttBg/h/bctEmblEVr3JN7Be6+ZG1G6A3DDnsDGoPcZvveig+HLwqSVDTYqqO1I+tV
 SvHYJ5Ic/srWAuGKRKhgVBG1DJlaCh26O9+WTRrggJ+N1wr6bFYixxndP0FAh9QNL3Zp
 Apjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731933593; x=1732538393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/23he7hett4u2PEZfapDlgGaYmJg/BE5RWXE8p+wlrY=;
 b=uaIncauGdutDRqdv7NiPy3isO9Fm1ozxLj6nfBnfVQUAPLpvtIedKgKWSbN4hwDRbg
 GL07gbmzq+ksYYrETuWILZBQus4MjJdmfgP7y1Ozb1Da3ECQhLfPBnCL9REj682LM3yP
 ScSjSAqHotUeCWwDnvLq5dbfN/+hQ3c/s5taT/VALQjwDpt6tM9wSbe972inERFM/TKZ
 ZIabjaSCGiFUmfgWdOs+vrW1X17oCHNkYKMaTg80Q80CBhIK3gIGj7SqI8L9omeBkYu4
 DjNKVEtDPl5HvGREIAFhwCwkrM8mJ1feaHX2DEIgwk02tG3BK7Y4mS+Hxi5rUc/OiVSZ
 ANEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdRHwSL453UZt7NnWEne8+Zx2Y/FW+u4l2qQoQ9/0xcuOQwgNIac4mROVCMCCbzvUfyoo0FCALYL5d@nongnu.org
X-Gm-Message-State: AOJu0Yxv55OANB6UQ7VMkDLvLK2mlN0a28N4TVPbhgvg5hk1005AchCa
 ytiKYUOnc6lJQ4ug2+hi/NaK61UJWPCrmm90CgbDBRKDldM7fqTrzqlCw8LCzPd2kOGqTv5DLRZ
 7
X-Google-Smtp-Source: AGHT+IHeSi61CG9euHjfX+W6IaQ0ULjJPkQ61h2lLTIkqL10u/XkyDzF7ItGkW5EEHCbBdl+kHwq8w==
X-Received: by 2002:a05:600c:1f94:b0:42c:bd27:4c12 with SMTP id
 5b1f17b1804b1-432df72c661mr119363505e9.10.1731933593012; 
 Mon, 18 Nov 2024 04:39:53 -0800 (PST)
Received: from [192.168.69.197] ([176.187.198.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae1617bsm12871363f8f.72.2024.11.18.04.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 04:39:52 -0800 (PST)
Message-ID: <f202f7b5-5840-45c7-8b4d-a93c71c4aad5@linaro.org>
Date: Mon, 18 Nov 2024 13:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Fix !CONFIG_SYNDBG build
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
References: <20241114130152.352009-1-vkuznets@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241114130152.352009-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 14/11/24 13:01, Vitaly Kuznetsov wrote:
> Commit bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG
> enablement") broke !CONFIG_SYNDBG builds as hyperv_syndbg_query_options()
> is missing there. The idea probably was that as "hv-syndbg" is now under
> '#ifdef CONFIG_SYNDBG', hyperv_feat_enabled(cpu, HYPERV_FEAT_SYNDBG) cannot
> be true anyway.
> 
> It would have been possible to add a stub for hyperv_syndbg_query_options()
> instead of resurrecting '#ifdef CONFIG_SYNDBG' but avoiding
> HV_X64_MSR_SYNDBG_OPTIONS altogether instead of zeroing it when
> !CONFIG_SYNDBG seems preferable.
> 
> Reported-by: Michael Tokarev <mjt@tls.msk.ru>
> Fixes: bbf3810f2c4f ("target/i386: Fix conditional CONFIG_SYNDBG enablement")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   target/i386/kvm/kvm.c | 2 ++
>   1 file changed, 2 insertions(+)

Patch queued to hw-misc, thanks.

