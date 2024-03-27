Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE080C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 17:29:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpX5m-0003Ed-W0; Wed, 27 Mar 2024 13:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpX5l-0003EU-Gp
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:29:37 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rpX5j-00015F-Tj
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 13:29:37 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a466fc8fcccso10591166b.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711560571; x=1712165371; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=j2igbMQ6sPyPJG5h+mTjLhLlWMEXylF6AQJzWw65V3A=;
 b=NvnIj9Ti5h3gHLCOpnfB4b5U5xjusE9mntIIMeVWl3T2/We4IApZSPNF5gzn0a4HeE
 d6gmeOgzQxOfiQ1pADsoEX2+DVWRhZGbim9+SfANZkUfzmsFSdax+lKsoLWMUJw053Wc
 dXuwW33vDQFJ856DRdRj26vRdJoMtBCI0RsZGSSl9DhRh/un5Yaj7nlC/9VmCtd4jOJk
 sU3JYnFLPV+Rs6P81eHF1bS7HHakJsHBpAfQ57jEYtNeY/3ifsEYbBB6q/MBPXABsZe7
 oD512i3KfO0NMVFUperQuRfUT0XLsntahtMZUyfrRumlactaHbAuJKzm7DL7A9NYU1f6
 V2Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711560571; x=1712165371;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j2igbMQ6sPyPJG5h+mTjLhLlWMEXylF6AQJzWw65V3A=;
 b=s/ocjhIgmJT5BrsdonLYZz5gIAXu01CjwtHahgwFXSjjyp4InjR7I7QqHjvoRFMpKU
 hgXEiYAplwyN7kQrCKiRrNIzi07cDdk6J3/wp3TSXIJzGFMQTwja8OWRNlH+iO5xzQoE
 3QYtd/IDNCU3l0zXZJ0DnimT73YTJNluFUVoJG4YUC58UpycBfoO6lIURrd20LvkwVm8
 OaeOAO6ZCjJBWYSSm8ZFeG9HKbxAkFdfKiLWc7J4FJ9d/2vwZA8x8Yiog1Jdj4FSv2Zs
 3YHy6t0rYxCgceJ0li9sEnllKNQfp+EPhuIJLSYSNmKzu1NF93tfnwutdbZd1N55VHBB
 wrxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWt17C8+JZQLzmML2Pre09k5qsiF/7cuycZdDdKuT8bB8TTGEO/EoXHRDj8XtfK2IwssGEeELW6gX7uz1ZqFNi/aGiR6eQ=
X-Gm-Message-State: AOJu0YwGA5hjKMpNcJ0OtAoqtx0S5GW+gZF9cifoBzPFHZ8C34m0zBAU
 OWJuqXu409lgBDLbTa6cb6yVRPGdURKG1WSeSEFcyg9MYBSczkUItBf9KeOLQjI=
X-Google-Smtp-Source: AGHT+IF8uXFUdNYYpzbIbAerpol92xUqudHQ4uZ9LWFL/qNqbA5VsON9NktPVeBMYVDdq9rfTOUmFw==
X-Received: by 2002:a17:906:4087:b0:a4d:f958:572 with SMTP id
 u7-20020a170906408700b00a4df9580572mr110165ejj.10.1711560571152; 
 Wed, 27 Mar 2024 10:29:31 -0700 (PDT)
Received: from [192.168.200.106] (83.11.22.169.ipv4.supernova.orange.pl.
 [83.11.22.169]) by smtp.gmail.com with ESMTPSA id
 f7-20020a17090631c700b00a471c6b3211sm5733370ejf.175.2024.03.27.10.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 10:29:30 -0700 (PDT)
Message-ID: <0b0c623e-b9f7-4178-ab2e-c89b109ea999@linaro.org>
Date: Wed, 27 Mar 2024 18:29:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
Content-Language: pl-PL, en-GB, en-HK
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20240327165456.34716-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x62b.google.com
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

W dniu 27.03.2024 o 17:54, Philippe Mathieu-Daudé pisze:
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7b548519b5..345c35507f 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it harder to run the
>   ``check-tcg`` tests. Unless we can improve the testing situation there
>   is a chance the code will bitrot without anyone noticing.
>   
> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +The ``isapc`` machine aims to emulate old PC machine without PCI was
> +generalized, so hardware available around 1995, before 64-bit intel
> +CPUs were produced.

Can you s/Intel/x86-64/ here? Intel was not first with x86-64 (AMD 
invented it). Also "64-bit Intel" smells of Itanium too much.

