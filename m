Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF8BCD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 15:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNukd-0002qU-06; Fri, 15 May 2026 11:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNuka-0002q1-Ql
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wNukZ-0005fm-14
 for qemu-devel@nongnu.org; Fri, 15 May 2026 11:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778860012;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YvOUScZZ/Xv4TAXhr6Aj3DCRwHhk5SYpQlDYhFoqcQE=;
 b=hIecpRQskD0Ublyhw7GM3bvRhhyGsvzd27QIRd6uwK2KU72UZNn5DpIptrzjOm1UaAdCxO
 dOtzYVRqQCBP2E++JEJ3qx/fVoIt3OoQvWl8zBcyjdHhq4PTc2G+SHZdsNSJ03AVLZLF22
 xPturAyJNgerT0D+BMvTlhyMdKnXx1M=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-e8FevEleM_6ZEOSiGI-UFA-1; Fri, 15 May 2026 11:46:51 -0400
X-MC-Unique: e8FevEleM_6ZEOSiGI-UFA-1
X-Mimecast-MFC-AGG-ID: e8FevEleM_6ZEOSiGI-UFA_1778860010
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48fd3dbd16aso25388105e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 08:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778860010; x=1779464810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvOUScZZ/Xv4TAXhr6Aj3DCRwHhk5SYpQlDYhFoqcQE=;
 b=NEf3ft/fBVzPjulSlGaAGyDgrUCSRpq3+SEgN6bGS/9/8d1sUU9mIkUm6ZcT2G9Qph
 ZVaNrp7B27bv8WIhNgaY5gPZeFl3ng3RHumQKBG6sKdppngWlkET/kZuKBOCCN+1eX2K
 PeuVk4a4baCx3xQbc3hOlp5mGB2mxJfddqc/7rzF26RHQo7Eg/JFcPYkJPQWEAPuECD5
 2tV0fZjRJJ5zNGt/lnAYf8LsUQFZoCx5bDlKsDgC2ElskScVtq+7ELChKCas9De1jbWs
 VBkJJPlRlEnY5Nf7fvws8BCBTDZFKCv1I457RhkKObIIFnRindUZL/C5Dz/KwXGaCO27
 tJkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CRbH5UpcunBh/gA6jyc4/debO7kn06j7JM2Dz1tl8kEAnbBKfj0cMimS57cUtQrS5JkhzSV0fShR1@nongnu.org
X-Gm-Message-State: AOJu0YxFlrCK0cDIfPg1lWCxuaokGPSVO4Yrdryp3WzcyLo/3JE3GWqb
 2FflobDqZdRUrQi/HmUYQi/3twYElwxbiwpBw3jQGrXLF2rilh66yzgNgQzy0uV72qcO7ntWjNG
 AblhI+GSGnORGj09wLMP72UG3bP9tkMI0ydViylJQSNj72cK4GHud/SB4
X-Gm-Gg: Acq92OGNObSBBkMSaeccru5OFmWeE/MOnepb042acQD4uJBaJWpiPKtek0I3iWrbVLG
 Vw4f/VJMPHf8YQLbyACuHDtfjmLO8tThQ8jbhIHEC9fEFUGiCqV5lO1KZwwAIGaVu9rgzD+SGCP
 omtSADWALJvUsAhC1nWzHpdgSKVAV8hwRg7nAAM00GNbvnETlyOoq2+0YLKadR7zF9xGTBOnnKw
 wHOR4w0Qsr8M5NEChN/4T09vl+N/trsz+pZoDTVae0kfAWR6RRiHdauXbMmbcXS5GS5qgxU/l0s
 wsg4eZJkRNbg0QDAcokGhcbgk7jmGX+L0x99jnPd0YbZoxET1fiTDPSL8V+DCFGAze4DDRMPhtQ
 G/5KcYGVpghMU4vNmqQdlRlyF5otE4UXkgNIbOkm54bKSHA+1xAgn52V68VtvVhg54p/4Hg==
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr69927775e9.21.1778860010036; 
 Fri, 15 May 2026 08:46:50 -0700 (PDT)
X-Received: by 2002:a05:600c:8189:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48fe6323addmr69927295e9.21.1778860009715; 
 Fri, 15 May 2026 08:46:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm15937194f8f.10.2026.05.15.08.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 08:46:49 -0700 (PDT)
Message-ID: <338ec6f3-499f-4232-9049-17118209c05f@redhat.com>
Date: Fri, 15 May 2026 17:46:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 05/13] target/arm: named_cpu_model: replace FIELD
 macro with IDREG_FIELD
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: Shaju Abraham <shaju.abraham@nutanix.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>, Jon Kohler <jon@nutanix.com>,
 Jonathan Davies <jond@nutanix.com>
References: <20260513163356.3033159-1-shaju.abraham@nutanix.com>
 <20260513163356.3033159-6-shaju.abraham@nutanix.com>
 <2a1eb06f-1293-4d6a-8354-445891ba36ec@redhat.com>
 <A84C8759-6EF8-4DFA-B5C5-A4381022F81C@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <A84C8759-6EF8-4DFA-B5C5-A4381022F81C@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/15/26 5:36 PM, Khushit Shah wrote:
>
>> On 15 May 2026, at 8:58 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> MIDR_EL1 is also described in 
>>
>> target/arm/cpu-idregs.h.inc 
>> so it could be removed I guess. Please check others
> I do not see MIDR_EL1 in cpu.h, both MIDR and REVIDR are
> maintained separately in ArchCPU struct and are not in cpu.isar->idregs[] (or is duplicated).
it is defined in cpu-features.h just after CTR_EL0

Eric
>
> Warm Regards, 
> Khushit


