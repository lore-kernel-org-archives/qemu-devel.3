Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27EA3CA0EFA
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 12:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqWOH-0006St-RH; Mon, 25 Aug 2025 08:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqWOC-0006Kd-B2
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uqWO1-0003WE-Et
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 08:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756125198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HzNDxd04MpsioOFSAoiD/q+VWEJ3/AlFgzJJ7B3c8Lc=;
 b=AJ/7dDA1S7IVXrw2ZfciZF0DrVJFo6at0VJI8Q1r4OWHEWJtCEwH/t3T2TfmJgE3Lp8yn0
 pPkci5+v1LkqYo/hr1x3iwXafL1u7oqDvQ7OeL4HUKXDjfLNNnSlEvgd8A49CBnRLyxU2h
 mbHPPIpy9wkbAOtCQ0oA/tEoaLS9hE4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-gNwxc3UqOmeem776Ja25VQ-1; Mon, 25 Aug 2025 08:33:16 -0400
X-MC-Unique: gNwxc3UqOmeem776Ja25VQ-1
X-Mimecast-MFC-AGG-ID: gNwxc3UqOmeem776Ja25VQ_1756125196
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b29a0b8a6aso110778831cf.0
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 05:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756125196; x=1756729996;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzNDxd04MpsioOFSAoiD/q+VWEJ3/AlFgzJJ7B3c8Lc=;
 b=j0IUgXTU4qLxigyVrPin/8KuGEqySmp1xkTojpmlZ5nYu2V4UvUraWKGe1lGPxSlqf
 YlgBS+O/1Y2O8T5gRr+fPmLeBGcVLDTFkXWhhVe49idQoVBqqOF7tdqXSAN5oBymVBXD
 X6vTGq0LPw5nC5Fa+IsS6yYlGLnDxxjNDWiePKd1kCweQm6IMHA/h4U7nR7myGTHvP19
 4UTzFaDZgd5IVp/W/GjKsb7R7NZhIWgiV8iLX9a/IPFVg9UYmeJ5pheXYBAb4uypqJ9n
 fVeAr65V4+injCn3pF+FCyUISmD/fU8qQDOY1Uw0OaRDiCeAKMunhWtfjO9z48rZaSwc
 5VuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVkKBZE9z1XUZWOfIIY5bjzvSrLnCvjcVWwJ1zKHX/HBIhrIEJKoP8mPgjWFIs8gW4y9OovtRLMXgl@nongnu.org
X-Gm-Message-State: AOJu0YxMfpWTVve4t3X/IGkFyRIVLcSCj7N7cyyMaoUh2zzuv+uprw9n
 m206undhaFO6XihA22tpj+BygL+EPFUvNho0ukw6WnSMEAlD3P2LQo1AdDBc/2jN0ktAFgataid
 VJm4gPgn9bmhxnVw35p7hbKGs8kF+nfYbfet1wIFy1F3mQejy5DbMv7F/
X-Gm-Gg: ASbGncu3BuRN/moa7N6p136oXiVR5/dXDX0kk2gkQP67+AGmle/wTZix+RcazwHEoIs
 L+lddQl/9e8peFgbT93NWuLp4gWNOJL42qFAqqY0gTLrrgpr3QlKgA9Z6n1Fy7IhkfLRLUSyo4T
 e3c7MG+L06dlXglQE55CKC5/G2qsJQlA0OVTpN1kMmr+yonavOsT73nlbQd1TL/qOnZVRLfjQ/2
 VwD+wgpQzaN4qmuIilqEYO/b6WMClNHuD+xt39Wji8f6oLwCWh51nD8C/uAnaCH5IxLW2KeVIsQ
 Pig1whcXCEJuiVeGJQomi51aUCY4W6uDSwKRb8cmFJ7EZIAUcwGL5ScFDfOZhjIyhA9UDxFIrv4
 KoqA=
X-Received: by 2002:ac8:58d2:0:b0:4b1:d6e:f038 with SMTP id
 d75a77b69052e-4b2aab1e216mr134248401cf.61.1756125195821; 
 Mon, 25 Aug 2025 05:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEb68C3HRkA7OkB59vXZT062nU3JeP4PhYEPRYMlDCSggaqPa901MlHyVlN9Hja9C0vMCbHQ==
X-Received: by 2002:ac8:58d2:0:b0:4b1:d6e:f038 with SMTP id
 d75a77b69052e-4b2aab1e216mr134248041cf.61.1756125195454; 
 Mon, 25 Aug 2025 05:33:15 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-112-084.pools.arcor-ip.net.
 [47.64.112.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ebee9da311sm479814085a.33.2025.08.25.05.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Aug 2025 05:33:15 -0700 (PDT)
Message-ID: <4f0a3df6-c509-4d7f-8bca-f32fa391e3df@redhat.com>
Date: Mon, 25 Aug 2025 14:33:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] docker: Stop building 32-bit MIPS images
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>, Riku Voipio <riku.voipio@iki.fi>,
 Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-4-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250820142108.46639-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 20/08/2025 16.21, Philippe Mathieu-Daudé wrote:
> 32-bit host support is deprecated since commit 6d701c9bac1
> ("meson: Deprecate 32-bit host support"). Besides, the Debian
> distribution we are using to cross-build dropped support for
> MIPS as of Debian 13 [*]:
> 
>    From trixie, the architectures mipsel and mips64el are no
>    longer supported by Debian. Users of these architectures
>    are advised to switch to different hardware.
> 
> Next commits will remove support for 32-bit MIPS hosts. Stop
> building the mipsel Docker image.
> 
> [*] https://www.debian.org/releases/trixie/release-notes/issues.en.html#mips-architectures-removed
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>


