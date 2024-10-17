Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69FED374BC
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 16:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1TET-000443-T5; Thu, 17 Oct 2024 12:20:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1TER-00043F-1X
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:20:11 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1t1TEP-0000Mv-BM
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 12:20:10 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9932aa108cso166630966b.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 09:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729182007; x=1729786807; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HmpBTcOE0ntFZvS0kQpWXmflr4NC+lD3no9yEdxNmiI=;
 b=CuLfuyrdUiPuHvpob2UBWYU/7FV5lihR003Qo6QOdMYkkwo0v0Jgw1fD6y/v6ZYK9X
 27+N3W9oACnvyimaNdAYW3RlyfXVCCwZ7UgEapyTo0JGf0zty/4FaA7lXPtMl8qEYwZe
 0QtGSYtGWghC5/v94JinslLlv77YcicIxfz4y0JdE0t6rcELR28fvnIzbWgM/cQ8h7KF
 tEK9g+8QXKO5PFbvAR1zIL9pwADAEvrLlNrluky34E/YcSEjV6edVkbv4PJCmfhUD50j
 UeCg/uG0Myg49LX0HKYnY16avZa9KKDMyucVXYtIcvBWFiGdOhvn4/at+37I62LQ3eld
 8J7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729182007; x=1729786807;
 h=content-transfer-encoding:in-reply-to:organization:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmpBTcOE0ntFZvS0kQpWXmflr4NC+lD3no9yEdxNmiI=;
 b=oBe4ib7DwbjBWfZFCoAJdbw2T9nnD1dLmKIbC8XFwbhc6KrWPbunLNpXKYdU+feUQ6
 7Q96pxHFbf/4OIe6ZzaSBc5hV4sbLFLioLSYryrEIV/c7FqNm1nJSQ7OxRjG4JHYaMQu
 EGzOrKYshe+kJVx+uxG1ap/lC4kKzVECGQLg2PlxFhHOhTqs6jLDWAHVlgNtQjXDDTSz
 d+PcCCedUc5n0fsN0InGctUKqqDV0Zxl7/nY//MWTn8a22zRZ2WK91TJiYM3Ez+NAeWh
 hdcg9PblV4CcJkQE/FobRo/geHnzc5bY9EFwq/kXKWC6qdOD8ilNw2tl8z0b6yntfzYb
 7UbQ==
X-Gm-Message-State: AOJu0Yx3E9RwUL1ZhwyfRjJ1z4rmq6itcAEZv2ro5/x8bQHk8PoC4Ei0
 1HIgsxiMBFHn4Bsw1m/gZT1svDNtO6lLfwYAk8Yo7fCmqKPRc2ADkAVHQn1tlaE=
X-Google-Smtp-Source: AGHT+IGSttzxUaUhDZZgaCdVEeYQp2df1z3HHJBSILlLsGRR43kbRiALvs1wI4UZ6o20hU9GQ5z7pg==
X-Received: by 2002:a17:907:2da4:b0:a99:ffb5:1db6 with SMTP id
 a640c23a62f3a-a99ffb55507mr1572531666b.24.1729182007247; 
 Thu, 17 Oct 2024 09:20:07 -0700 (PDT)
Received: from [192.168.210.26] (83.11.13.124.ipv4.supernova.orange.pl.
 [83.11.13.124]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29844425sm310087366b.168.2024.10.17.09.20.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 09:20:06 -0700 (PDT)
Message-ID: <0b884126-1fcb-40d2-9fc2-ab0944370fd9@linaro.org>
Date: Thu, 17 Oct 2024 18:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
To: Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Language: pl-PL, en-GB
Organization: Linaro
In-Reply-To: <20241012104429.1048908-2-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x633.google.com
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

W dniu 12.10.2024 o 12:44, Zhao Liu pisze:
> Cache topology needs to be defined based on CPU topology levels. Thus,
> define CPU topology enumeration in qapi/machine.json to make it generic
> for all architectures.

I have a question: how to create other than default cache topology in C 
source?

If I would like to change default cache structure for sbsa-ref then how 
would I do it?

QEMU has powerful set of command line options. But it is hard to convert 
set of cli options into C code.

