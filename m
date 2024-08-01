Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6225FC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 07:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZPox-0007KL-1k; Thu, 01 Aug 2024 03:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZPou-0007Gp-Nh
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:01:52 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZPos-0005up-Bv
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 03:01:52 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-260f81f7fb5so4243800fac.0
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722495709; x=1723100509;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U3OyFyJMm7DE0+LmkOnr1LnHwmEy+eI8Z4WFiC09V+E=;
 b=ITSCfLor5TYxqh30VnbA89YZ/5rLc3tFoUb9eak//SJJS/WyJ0FwiZ4bKoCstDMZ+J
 9LBa1PltMWlQXGLQxXyhMSJD9T8+YHSBtJ5YBWL2I1H01L3imsp66iT4qvsH/TBCl9Im
 6um14oneOOu8s/p/8zUNqqBfHMzuo7YW/PHJvn79T3xM2udIZnU13swDimEpGnhui4AS
 9y/tt+Q0qhwOS1aUn6lsbZEk8eBAS6Qs5HOO31MURXgzUS/XwG4B2xT+EqaJkGOgy0sN
 Pv2NDtEJyhfzfz09OkuqxYdpwgQqJq+f3ReuRiTm1KDz30OTkXozQwUJhy1e52Az3FNw
 evSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722495709; x=1723100509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U3OyFyJMm7DE0+LmkOnr1LnHwmEy+eI8Z4WFiC09V+E=;
 b=xNsWtQl4Ln8nU5IA4Ru4lmLMQ7jS9du5hoiW4wAqhkXRi+h1iNJJ5vc2D28EoIGUPZ
 +NUv41+QOf3O8f1WwHssltQcg8sVIMl9GLVB2Y2TkedYGDtustdjAS7oTiLk51NN8XOK
 GBkJdGaU0I4cXbmYiHHPZjefOHJ0yerSXJpwFmf/PgXNsqewrtekiCFEeg2QyUG0kXOW
 l60r6xSiSrBmygdBWkc4sBWdEXFfDr2XzhVUdescM1hoi/bFNzHwvoac/froehvR7zhS
 +A3RT1RhhGjeGqFRlq0kxuHpNgwpPfn3RFYIy5TgivnEuKpBPZJbYG78IMfSCjURW2c/
 3uGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjkiwwaEcyHjFDP7xmSc2hCEPhogiiG6lQ0L31HaxSQkNJhOS8FTTCpDsy5zE71SYG2vrax/sWJtHja2Q8T/Modu60nTE=
X-Gm-Message-State: AOJu0YwE/ONb+KTHwSlwrXGMdXVRt9VNxHRLMKmiWxoOVhMFj3x6lruY
 C6wQlewEhwWDFRzu1omjvG9vC3mjDBGRM4/FWyH4iD0VYredzYXfJ7sB/cnKALc=
X-Google-Smtp-Source: AGHT+IHkoLb6YFONyBqchwplJnJ4JVYDPrEYumf/EN3N7u2N80AYv8zDRXIhMOQHOCYZsZWNByx3dQ==
X-Received: by 2002:a05:6870:7194:b0:25e:8509:160e with SMTP id
 586e51a60fabf-2687a36745fmr1835132fac.3.1722495708982; 
 Thu, 01 Aug 2024 00:01:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead712691sm10909265b3a.49.2024.08.01.00.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 00:01:48 -0700 (PDT)
Message-ID: <8ee4464e-f9b3-48bc-9fa3-0b5f0d2a5faf@daynix.com>
Date: Thu, 1 Aug 2024 16:01:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
References: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
 <87a5hyj71o.fsf@pond.sub.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87a5hyj71o.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2001:4860:4864:20::33;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oa1-x33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/31 17:32, Markus Armbruster wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> rom_bar is tristate but was defined as uint32_t so convert it into
>> OnOffAuto to clarify that. For compatibility, a uint32 value set via
>> QOM will be converted into OnOffAuto.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I agree making property "rombar" an integer was a design mistake.  I
> further agree that vfio_pci_size_rom() peeking into dev->opts to
> distinguish "user didn't set a value" from "user set the default value")
> is an unadvisable hack.
> 
> However, ...
> 
>> ---
>> Changes in v2:
>> - Documented in docs/about/deprecated.rst (Daniel P. Berrangé)
>> - Link to v1: https://lore.kernel.org/r/20240706-rombar-v1-0-802daef2aec1@daynix.com
>>
>> ---
>> Akihiko Odaki (4):
>>        qapi: Add visit_type_str_preserving()
>>        qapi: Do not consume a value when visit_type_enum() fails
>>        hw/pci: Convert rom_bar into OnOffAuto
>>        hw/qdev: Remove opts member
>>
>>   docs/about/deprecated.rst         |  7 +++++
>>   docs/igd-assign.txt               |  2 +-
>>   include/hw/pci/pci_device.h       |  2 +-
>>   include/hw/qdev-core.h            |  4 ---
>>   include/qapi/visitor-impl.h       |  3 ++-
>>   include/qapi/visitor.h            | 25 +++++++++++++----
>>   hw/core/qdev.c                    |  1 -
>>   hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
>>   hw/vfio/pci-quirks.c              |  2 +-
>>   hw/vfio/pci.c                     | 11 ++++----
>>   hw/xen/xen_pt_load_rom.c          |  4 +--
>>   qapi/opts-visitor.c               | 12 ++++-----
>>   qapi/qapi-clone-visitor.c         |  2 +-
>>   qapi/qapi-dealloc-visitor.c       |  4 +--
>>   qapi/qapi-forward-visitor.c       |  4 ++-
>>   qapi/qapi-visit-core.c            | 21 ++++++++++++---
>>   qapi/qobject-input-visitor.c      | 23 ++++++++--------
>>   qapi/qobject-output-visitor.c     |  2 +-
>>   qapi/string-input-visitor.c       |  2 +-
>>   qapi/string-output-visitor.c      |  2 +-
>>   system/qdev-monitor.c             | 12 +++++----
>>   tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
>>   22 files changed, 161 insertions(+), 73 deletions(-)
>> ---
>> base-commit: f2cb4026fccfe073f84a4b440e41d3ed0c3134f6
>> change-id: 20240704-rombar-1a4ba2890d6c
>>
>> Best regards,
> 
> ... this is an awful lot of QAPI visitor infrastructure.  Infrastructure
> that will likely only ever be used for this one property.
> 
> Moreover, the property setter rom_bar_set() is a hack: it first tries to
> parse the value as enum, and if that fails, as uint32_t.  QAPI already
> provides a way to express "either this type or that type": alternate.
> Like this:
> 
>      { 'alternate': 'OnOffAutoUint32',
>        'data': { 'sym': 'OnOffAuto',
>                  'uint': 'uint32' } }
> 
> Unfortunately, such alternates don't work on the command line due to
> keyval visitor restrictions.  These cannot be lifted entirely, but we
> might be able to lift them sufficiently to make this alternate work.

The keyval visitor cannot implement alternates because the command line 
input does not have type information. For example, you cannot 
distinguish string "0" and integer 0.

> 
> Whether it would be worth your trouble and mine just to clean up
> "rombar" seems highly dubious, though.

rom_bar_set() and and underlying visit_type_str_preserving() are ugly, 
but we can remove them once the deprecation period ends. On the other 
hand, if we don't make this change, dev->opts will keep floating around, 
and we will even have another use of it for "[PATCH v5 1/8] hw/pci: Do 
not add ROM BAR for SR-IOV VF"[1]. Eventually, having this refactoring 
early will result in less mess in the future.

[1]: lore.kernel.org/r/20240715-sriov-v5-1-3f5539093ffc@daynix.com

