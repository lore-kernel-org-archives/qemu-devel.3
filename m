Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A970FEE01F3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soGbY-0007CS-7G; Wed, 11 Sep 2024 02:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGbX-00070u-2u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:27 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soGbU-0008Su-07
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:13:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8d2b4a5bf1so220567966b.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726035202; x=1726640002; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8m3YdQ1Yw6tNSF6vZvuujJyxwJoqU3tbxgDnqqqX+iU=;
 b=ikWhctN5KU/IpYKSL7ifohMQXCVyk7NfUmn6nBREw5Nh6klEyRSM8QCJAnrTB+1hQP
 KUheFGVugNChAORtVbawUTsc8hCQYAJ1TmgZUvqlPxGpp3Jlu1LKCEsySVhBo9I+CxjU
 bg5mbqilD0dC43XifGpd+NkvRU2yl2xuB3TbYow1oR0xvP5wnhtvPLQF5nWKeIXHFZy2
 g+Zir/vOwOiIupUQkVqENiE5pigY/3Da7ydiWvFfQCREqC3LHTqEDxFig+JsG3UDXU/O
 wHDI5nUFd+xsYD1WFzrRw91L94AvYMr6BG08zADeDs2EQzdixgQ8igradCtCqa3ZiHjl
 HUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726035202; x=1726640002;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8m3YdQ1Yw6tNSF6vZvuujJyxwJoqU3tbxgDnqqqX+iU=;
 b=XQghZiq5Z7PyrUdlB5CPzhdXP0nnrdkAdCALwM/1aiel57niA2aOrRUleXoQNybx56
 jzU0Z4t4ATDeRxfzmKaWFjR1UVBJkRa00JMqKaFQAx/gkxW+4ynN/jye6zqqQZmCv1oU
 cJSfXwYPG6QVOv1wmEHZrwSPwol9mSb9+ZhuHxK2RYcQElRVNNzxMoe6Vo8XdmSOViYk
 gfKvlBV9esMz0/mvcXsuFVmP0uMVjebdVDbMJyjh3E7Rba3Q7LVdNyuqignOkUQynPJL
 b1K7uSNFKnKZsETZqVX7jUUuak/cCgHyDIW5j0xiEKur9qk3z7Q7wgRysaN2Y6+vXZRH
 yhLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx3CZoOcXWCUHKdNKEYUg+RKM2y3sGmvpm2WJ0YYexXAL5C2bA7sFetrQ29c89I716P33kPWbHZiV6@nongnu.org
X-Gm-Message-State: AOJu0YwzdswCqVOjwvlmU6QudeDX6F49v1P08WVTcocqGWc6eEipb8fg
 QqAjQ3MRlIRgbDPUPprhBo48LmOFfdvmMr24uDfdBiOQqbsHsqky6b6jK1hdXJg=
X-Google-Smtp-Source: AGHT+IE68BWI8McnnoxME1op7FLJ8c1uPq9jO1r69jOWkvX8u1v0gwomWUiv15OUhrOaghKJT6dx7w==
X-Received: by 2002:a17:906:d542:b0:a86:a73e:7ec9 with SMTP id
 a640c23a62f3a-a9004a66525mr186452366b.46.1726035202098; 
 Tue, 10 Sep 2024 23:13:22 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25979e90sm573426166b.72.2024.09.10.23.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 23:13:21 -0700 (PDT)
Message-ID: <54442170-9ae0-4ca6-9ea2-fc80f49ece2c@linaro.org>
Date: Wed, 11 Sep 2024 08:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/39] hw/pci-host: remove break after
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, "Richard W.M. Jones" <rjones@redhat.com>, 
 Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Corey Minyard <minyard@acm.org>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Keith Busch <kbusch@kernel.org>,
 WANG Xuerui <git@xen0n.name>, Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, Fam Zheng
 <fam@euphon.net>, qemu-s390x@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Laurent Vivier <lvivier@redhat.com>, Rob Herring <robh@kernel.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910221606.1817478-31-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11/9/24 00:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/pci-host/gt64120.c | 2 --
>   1 file changed, 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


