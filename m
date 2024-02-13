Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9DCAC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZt9j-0000Kn-JO; Tue, 13 Feb 2024 08:49:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZt9d-00008s-V2
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:48:59 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rZt9c-0006xX-1K
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:48:57 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e0a37751cbso2022782b3a.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1707832133; x=1708436933;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bBTEBJ3qO+plMGu30S0QHrA0mOlb6YINhNeB3t08BYQ=;
 b=l6WfIkPSiUMoGYNw0mM3Er+GZSwgLmFDpaVpDsmJloJ8kKi7I7pDGmYkeg/2xXXFcT
 jKMtrgMPxF0xfiAJ7U8pfab/DCOpr77mOWY+iKg2EfJukJoeGK/5eMO34nzhE7P/xsPH
 mcst/PRvACUJYV/bdesb9AMT8r1WmhAUICL3M2xuIDvwUNTZLFKzxje2Q1yzPFvVdxml
 lOSXQgBecFH38tO6j+1XDwCbxDZs+Xwfd8Mh/G2TMQlxBLJAGS4W8bAGYiDxV3jPzNVP
 BrxFuzkGttFMhRt4LppoDV69f92Qn08Ar/V0m12mUzvbDFptdRgLEKt7wJwBJ1QiOzzI
 iRQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707832133; x=1708436933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bBTEBJ3qO+plMGu30S0QHrA0mOlb6YINhNeB3t08BYQ=;
 b=wf+afuHRLk0CJeq2ckAG4Y0NFNew4BLtB0bdgdoutDHFlkv/xSrtOp6nDQBrgtKxUh
 vYrMK+G1Karv7Vskf9zeqoYWXQghNLAXJ89+SGq32peQMu1ksZ8/J14JDJCLzMXmgR10
 JS7jpJD6jKplW9v5WMrHEszuX8zHl7N8xyz2HexKE5y/jFi+WMTxnclESsiVi0JlkLWV
 GclHqzkXuOZThmPhf8SYg821mHl0cN1C+h/fcsazn7gZu9virhCfx7rxJXeHIU3A3/I7
 THkr7av145IikkSqBN4pILNefZ0eOqHSUZzK22ajEv6WoFUDPU8+lKbFCsikbCPOaKoO
 sndg==
X-Gm-Message-State: AOJu0YxLPQUzeyW7VYksMrbjBkb2lACFTE8c/+KP6B5p3iCb/DXNgwxb
 6K698D1Ez+XaEPpglTdmaD4v1Ax1yggIS5xB4dajC0l5lp8bUqwgU/J07KxTNKY=
X-Google-Smtp-Source: AGHT+IFy4oBiwpal5qIYcnL/cqjmggdlujuvOnkkPzqo8NuXDHvd5RJ/NRNFGTFs4j5vdRA5yN+KDA==
X-Received: by 2002:a62:cdcf:0:b0:6e0:6c0d:f55a with SMTP id
 o198-20020a62cdcf000000b006e06c0df55amr10030759pfg.8.1707832133667; 
 Tue, 13 Feb 2024 05:48:53 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUz3p1t208x0u2FNvQDVV3oWiiE01Mx9Yr58NfofoBWRyWm2F9b4zZ0SEo3aGWoU8m5hqNW/IHnvaCBBPqpMzcJgsgjjRSjpu8Nk/SxsXVsCycd13PkgD1q3vPLL5T+BVcCyUvja77mFskB/NpDsAQb64Q3XTAT9tlhVgik2f0uDNYugfNNF4ei3VACriteH7of46lk9JKxUf6/8Z7JuVcUg2336sPFYs6UVVwWrF90tdvP1E9gpT6soJhB4oMDnQQVP9J1HUl1uY/S2ekOcLm4j8HfOIZ0ZI0Y254T5w5fn8Gk8uOOMVFoW2grSoNFz+icccQarM1Jkr3ToXnDCYI3Jy7xDMA+d65yy7FlKX/3A4bPp1vHaA2s8XZSEtCQipPhC1s+lvsshlygrG/JYW1LYHHTzFl1FQbJqEKPTlCX3HyMWl3bDhnV8gyJsdfXy0UcWp9a9iZpgw6oXViDin8=
Received: from ?IPV6:2400:4050:a840:1e00:9ac7:6d57:2b16:6932?
 ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with ESMTPSA id
 jw12-20020a056a00928c00b006dddf2ed8f0sm7362637pfb.154.2024.02.13.05.48.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 05:48:53 -0800 (PST)
Message-ID: <8d6b0da4-8127-4864-bfd9-c38bd1043a98@daynix.com>
Date: Tue, 13 Feb 2024 22:48:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
To: minwoo.im@samsung.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>,
 "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20240212-reuse-v3-6-8017b689ce7f@daynix.com>
 <20240212-reuse-v3-0-8017b689ce7f@daynix.com>
 <CGME20240212102210epcas2p4346c0dfc475ecee9f359d634eba46783@epcms2p8>
 <20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c@epcms2p8>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240213085108epcms2p86672b5f11b0b4a22244256b85c66721c@epcms2p8>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2024/02/13 17:51, Minwoo Im wrote:
>> -----Original Message-----
>> From: qemu-block-bounces+minwoo.im.dev=gmail.com@nongnu.org <qemu-block-
>> bounces+minwoo.im.dev=gmail.com@nongnu.org> On Behalf Of Akihiko Odaki
>> Sent: Monday, February 12, 2024 7:21 PM
>> To: Philippe Mathieu-Daudé <philmd@linaro.org>; Michael S. Tsirkin
>> <mst@redhat.com>; Marcel Apfelbaum <marcel.apfelbaum@gmail.com>; Alex
>> Williamson <alex.williamson@redhat.com>; Cédric Le Goater <clg@redhat.com>;
>> Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrangé <berrange@redhat.com>;
>> Eduardo Habkost <eduardo@habkost.net>; Sriram Yagnaraman
>> <sriram.yagnaraman@est.tech>; Jason Wang <jasowang@redhat.com>; Keith Busch
>> <kbusch@kernel.org>; Klaus Jensen <its@irrelevant.dk>
>> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; Akihiko Odaki
>> <akihiko.odaki@daynix.com>
>> Subject: [PATCH v3 6/7] pcie_sriov: Reuse SR-IOV VF device instances
>>
>> Disable SR-IOV VF devices by reusing code to power down PCI devices
>> instead of removing them when the guest requests to disable VFs. This
>> allows to realize devices and report VF realization errors at PF
>> realization time.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> Hello Akihiko,
> 
> I think this patch fixes the issue reported in [1].  The latest master branch
> also causes an object-related assertion error when we enable VF(s) and disable
> through sysfs over and over again (at least twice).  But this issue is also
> fixed with your patch.
> 
> **
> ERROR:../qom/object.c:753:object_finalize: assertion failed: (obj->parent == NULL)
> Bail out! ERROR:../qom/object.c:753:object_finalize: assertion failed: (obj->parent == NULL)

I looked into this and found it's not fixed with my patch though the 
symptom may be gone.

The problem is that object_ref() is not called when copying subsys. An 
obvious fix is to add an object_ref() call, but I think it's too hacky 
and error-prone. It's better to enumerate nvme_props and call 
object_property_get_qobject() and object_property_set_qobject() for each 
property.

Regards,
Akihiko Odaki

> 
> Klaus,
> 
> If this patchset is applied, I think [1] can be dropped.  What do you think?
> 
> Thanks,
> 
> [1] https://lore.kernel.org/qemu-devel/20240109022953epcms2p54550dcfc9f831a515206513ae98e7511@epcms2p5/
> 

