Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66533C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 12:58:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rppK8-0006Sd-Li; Thu, 28 Mar 2024 08:57:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppK6-0006SE-Oy
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:57:38 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rppK2-0006XF-Gb
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 08:57:37 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-56b0af675deso1060004a12.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 05:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711630652; x=1712235452; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1AVngzRg5tYuiQmadZghRuLp3eJrZYi2vOKDqQZUD1Q=;
 b=uCySL+fPw6R92q5EI7dgBdpQ7wviWYhxleoSaXrnRpNB+MvS4UC939J0F9r1vObOZM
 Vz+ceKYw0G8ZeZDfXGYkS5myJ9yjDrScclNhjgWhUold/9e4VodWaA4W0LJ+Rb3XFZb7
 tMvSyjP1twGDelyo8DBLEpoZXvvRPR4lg66TUVnzKTgM0vGlqENzSv5lP9r/2/+rxdRv
 ggeX+cVL13azUDDUCxNOXjgZNVymjdv70P2jvQiuKYSxpyCzMz1FMcz09fu6C0LkdJSk
 QckpurV4NWjgqi90IUXer1+aE0F3Yl643pEJcd50eqyny3aBSYxL2cnkyvcMqQDdv4dC
 WFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711630652; x=1712235452;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1AVngzRg5tYuiQmadZghRuLp3eJrZYi2vOKDqQZUD1Q=;
 b=OUQqMyVXs+cC3WnLXnJJrReHsVQOIIWGtO93/OED0unvNCUFAJQ5BG+FzZGsZhjSrT
 IsOPUNN6aSgUuy0/2vlvEg3K9A4rePBEwuW2vMRi/Yu4YyM9bCHjh8gfcq13tRHUQe8n
 JIs9tV3qAzhD84OSmSmmcmFPCm2Od5SFl+zBtbR9ma2Z53jNMTbv7J50RqUHdAbHVfs7
 YBWBB2W5aHl4io5k6cG6BC0EPQM4oe0KJixE8J4daRG54HwNGGfW9RVwptuOWIl39uV3
 WYVFC7CTm2PcRxJHxdbLqm6K1cDrShCNGIeHSz2GIC8s+52LYzpKcd6t+7CRM8q7F9id
 npkg==
X-Gm-Message-State: AOJu0Yywv7hiNYw4s34dNO1EL3rvKhQYOFhKInotjL2VBG0cVKrd1Rd+
 gLwOmDweorR73HjZwpnA3reZNFclldKwF2bqo3AQPvdIivKNexiSXckY9f2GX9o=
X-Google-Smtp-Source: AGHT+IFjE49mixQRKwPfyNIMm/3v9QgsDh8zggrin2oVWDU2BMp5XpWd1/jLuLt9EkeRPQKqVMiDWA==
X-Received: by 2002:a17:907:780e:b0:a4e:1035:3ed7 with SMTP id
 la14-20020a170907780e00b00a4e10353ed7mr1918504ejc.25.1711630651623; 
 Thu, 28 Mar 2024 05:57:31 -0700 (PDT)
Received: from [192.168.69.100] (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 s7-20020a1709062ec700b00a46abaeeb1csm723295eji.104.2024.03.28.05.57.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 05:57:31 -0700 (PDT)
Message-ID: <07348327-a61c-4cfb-bb5c-658448e3fb42@linaro.org>
Date: Thu, 28 Mar 2024 13:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] rdma: Remove RDMA subsystem and pvrdma device
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, qemu-block@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>, integration@gluster.org,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 devel@lists.libvirt.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240327105549.1824-1-philmd@linaro.org>
 <ZgUy5rFScwNkmZQK@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZgUy5rFScwNkmZQK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
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

On 28/3/24 10:06, Daniel P. Berrangé wrote:
> On Wed, Mar 27, 2024 at 11:55:48AM +0100, Philippe Mathieu-Daudé wrote:
>> The whole RDMA subsystem was deprecated in commit e9a54265f5
>> ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
>> released in v8.2. Time to remove it.
>>
>> Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
>> in old migration streams.
>>
>> Remove the dependencies on libibumad and libibverbs.
> 
>>
>> Remove the generated vmw_pvrdma/ directory from linux-headers.
>>
>> Remove RDMA handling from migration.
>>
>> Remove RDMA handling in GlusterFS block driver.
> 
> The RDMA support in GlusterFS is completely opaque to QEMU.
> All we have there is the CLI syntax to enable use of the
> RDMA support inside libglusterfs. I'm not convinced that
> the justification for deprecation (lack of maintanier)
> applies to this scenario.

I'll quote commit 0552ff2465 from 2016 then:

     block/gluster: deprecate rdma support

     gluster volfile server fetch happens through unix and/or tcp,
     it doesn't support volfile fetch over rdma. The rdma code may
     actually mislead, so to make sure things do not break, for now
     we fallback to tcp when requested for rdma, with a warning.

     If you are wondering how this worked all these days, its the gluster
     libgfapi code which handles anything other than unix transport as
     socket/tcp, sad but true.

> 
>> Remove rdmacm-mux tool from contrib/.
>>
>> Remove PVRDMA device.
> 
> I agree with Thomas that each functional area listed here
> should be handld in a separate patch, since they're all
> independant.
> 
> With regards,
> Daniel


