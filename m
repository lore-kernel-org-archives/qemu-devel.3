Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52597C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 13:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSczv-0001rt-7Y; Wed, 24 Jan 2024 08:08:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSczs-0001n6-QN
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:08:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rSczq-0003zs-72
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 08:08:52 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-337d05b8942so6184984f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 05:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706101728; x=1706706528; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+w00aYVWLDaZ0z/ysw7lebbGl9R7ORAINPsdBB0cUQ=;
 b=mwkft5ih+IEoOemeqZYdNV3NAO+4Gm2QVnpRX8eNiLbfZI46hHrpoaKxlViFsAj9lz
 IW0XxbF3YwBii+lMJok4Jh21yb6FWoEMcTwovReb8+OKX5t8M9RE1ydBuw1GqH3lyglj
 RIB4jqZtxcyrbqeetQBRjC8Dsg/+2IkK2lRk/duGqZukePvFv+aD1NhMixZ79DuCgKH2
 3TKJN3TSsm/8rV0BgUpIMv4GdseV7y/mjvqDdzyg4PsqlKNp9P4iY3vwRT+2rj9XzYzu
 KpZTobPYwN900qxgr/jmlNZXQzXDuYyzDw2n8uMEmgBcQ1d0Gbxs52B9iLJYwXIpSb2v
 d2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706101728; x=1706706528;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P+w00aYVWLDaZ0z/ysw7lebbGl9R7ORAINPsdBB0cUQ=;
 b=lA0nSvLryuvs3suMRFfEkUhcaCG9UjzZ8pp2IWeFw7EprQiP3hprCHBFkeys0PREGA
 JB5BRoQZKCxwpYvFpW83PELZUnlNmX4TMaUaPB8ERyTYtpngb89DBintQ4jm1/agF4uc
 k7yinoCDWEqBJr1OYausFbKeuKipiWpBmBDUQ7Dt6mnPPk8b8U1RQxqvjcADRzzCnncD
 wfKIWngrdsVhDMTcyN/pe6lXBQ1vczaNVJN8gbRNb3IJah3POOQNBhuDae4sj+QO/cI4
 u1O+xc/w4zRO42ykj99v0Sno5jz8A3vlQH57ySiu2m3yaRDTaihNLbOpyeiEmJSVk1Vg
 XHyg==
X-Gm-Message-State: AOJu0YzAkzwkV864Ckqyqn4JjohYAh80OxgFXJZ/Niu3DfUmTEjet4PS
 TnuzoPTz8NrPgdtyR15fU9xMvVeYZMsd2ZIWmjtnsm5z9bfHs74nLA/YXPRR5+A=
X-Google-Smtp-Source: AGHT+IEuxiEzF8Ew3KDQATXOxVv+0frNsAg3XzkqsJwP9FR2cDsB2gTwNv0P4S9O4vtXVDRoWYc33w==
X-Received: by 2002:a05:6000:1291:b0:337:c4d3:cfa2 with SMTP id
 f17-20020a056000129100b00337c4d3cfa2mr512592wrx.30.1706101728284; 
 Wed, 24 Jan 2024 05:08:48 -0800 (PST)
Received: from [192.168.69.100] (lgp44-h02-176-184-8-67.dsl.sta.abo.bbox.fr.
 [176.184.8.67]) by smtp.gmail.com with ESMTPSA id
 b13-20020a05600010cd00b003392c1f40acsm10050862wrx.28.2024.01.24.05.08.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 05:08:47 -0800 (PST)
Message-ID: <33478869-d1c5-4f1c-9814-314e4076bfe5@linaro.org>
Date: Wed, 24 Jan 2024 14:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc_piix: Make piix_intx_routing_notifier_xen()
 more device independent
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Chuck Zmudzinski <brchuckz@aol.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org,
 David Woodhouse <dwmw2@infradead.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Durrant <paul@xen.org>, Richard Henderson
 <richard.henderson@linaro.org>, Anthony PERARD <anthony.perard@citrix.com>
References: <20240107231623.5282-1-shentey@gmail.com>
 <B404ABCE-E6B5-4716-BA60-3CEE74B72701@gmail.com>
 <20240114072529-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240114072529-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 14/1/24 13:25, Michael S. Tsirkin wrote:
> On Sun, Jan 14, 2024 at 12:21:59PM +0000, Bernhard Beschow wrote:
>>
>>
>> Am 7. Januar 2024 23:16:23 UTC schrieb Bernhard Beschow <shentey@gmail.com>:
>>> This is a follow-up on commit 89965db43cce "hw/isa/piix3: Avoid Xen-specific
>>> variant of piix3_write_config()" which introduced
>>> piix_intx_routing_notifier_xen(). This function is implemented in board code but
>>> accesses the PCI configuration space of the PIIX ISA function to determine the
>>> PCI interrupt routes. Avoid this by reusing pci_device_route_intx_to_irq() which
>>> makes piix_intx_routing_notifier_xen() more device-agnostic.
>>>
>>> One remaining improvement would be making piix_intx_routing_notifier_xen()
>>> agnostic towards the number of PCI interrupt routes and move it to xen-hvm.
>>> This might be useful for possible Q35 Xen efforts but remains a future exercise
>>> for now.
>>>
>>> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
>>
>> Hi Michael,
>>
>> could you tag this, too? Or do we need another R-b?
>>
>> Best regards,
>> Bernhard
> 
> tagged, too.

FYI merged as commit ebd92d6de3.

