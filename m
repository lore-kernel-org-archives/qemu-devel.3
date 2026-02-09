Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A402E81BC2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 13:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpRkf-00027K-Iz; Mon, 09 Feb 2026 08:56:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpRke-00026S-V6
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:56:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vpRkd-00031N-7B
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 08:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770645390;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T/kghJvJzOuQupgyPtOctBnlCw+t1TZpQbDUlBqUdFY=;
 b=g0S6gxy1b4NkwVJwQ497ZWVPzOuGskGAoXoE0armj/kqZEGcawwPoLc4Sw+Wra2w/1LdMk
 7D8fKFEYzt7/AWcyXbaEoySKfAqXw73wWsz3qlUiUMFlRaKUzSZXUbLUR0OiaUO29VBo4Q
 anklssYIwUZPFYsgTGPNAMstT+qCmzY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-qBOpxmRLPJiJxZ1tFFCOvw-1; Mon, 09 Feb 2026 08:56:29 -0500
X-MC-Unique: qBOpxmRLPJiJxZ1tFFCOvw-1
X-Mimecast-MFC-AGG-ID: qBOpxmRLPJiJxZ1tFFCOvw_1770645388
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-482d8e6e13aso33668615e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 05:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770645388; x=1771250188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/kghJvJzOuQupgyPtOctBnlCw+t1TZpQbDUlBqUdFY=;
 b=HsGQ/SvWAyuh4iGOgKYb7onQ99a0K9ZPTL5iViCcCrTmBS5oFlODNa6A3aso+eZ61G
 fUIgURlgbLTHBOTYqxOETPihZV0/5sCODrKJgptC193vJeFAdIYPszL4id75gTncndZC
 sxaF73zfSFLGZPlaFWjJUEiUIFDxNpUPV47bY9QrtXaJVYAzrjSgzwu5RQ0eGoV9cA5Y
 Dlpooalnk3zPRztoha/h43a6uTxpgE5qRBVDiLkUsUf5zbjufPTEqWJv2b+KPgz7uS5P
 mFxTjpOiLEmlHFYNmfWOw3DDGHB9JEtgKcMnK9ADP6o0LjnnavIeBLTwEAgKzXtFO0Lr
 kYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxtc9QNAd+iRx2OVOkkTojrtNwoZLTb2cvSLWQPur7mYwxWTVS4uUYgxW+YldTooCtm/p9wrW02F04@nongnu.org
X-Gm-Message-State: AOJu0YzatKZD0o4rmXqYNZ8HNrWRcyqcnX5IOLhsAOWsczje8vsfgdG0
 khrSekdZvUTOAFkXGKJMC79WtubM6vSNVY6NEEIEnfM30YioqvyNl+r2CtVrSdA/iM5nKEPD/Xx
 xlG4ZaL1rk2Mkt4cfWHbmJtB7uHBndnPyVrecHINRphYp7BLRZinMo8+w
X-Gm-Gg: AZuq6aJAXrhKRifENGRpSokP3M5bnpTFQR5EYslpQttJYegDK5d2LncSGQN97f/ILCA
 PTxyNgHdXC6XWPVHNlZfLg2Qu4wA83wAjWo4GqwPGOFTdtqmkFiscxYszgsqlfzfogJhl0dRUqn
 BCX4JKITVh2wQHCqkmCNeZ++h3EJVRKeVk90e2wZQTAYI8WwWc3UyR5FAOTd45u4ngVpH7rWCWk
 xTvDlYRDwt1UflHdLEufr8ntC708HxzJTC14g0HJ8X8w2HaWsCA3Vj/QxMnshnlPXWfsCP1jIHF
 Lah2ddhRh3TlrzUlFVyZdgFqd7vh4RrdB49h+iqgbCA78YXnpML3kjWBgw+IelJuvOy+Jvi7tOm
 oy6M34wjgxO78mjzqpBZXdjB/AOl4pYwTJdpFzo13E/0Kj9DRqE8VJ4uCHw==
X-Received: by 2002:a05:600c:621a:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-48320928d7cmr162110045e9.3.1770645387680; 
 Mon, 09 Feb 2026 05:56:27 -0800 (PST)
X-Received: by 2002:a05:600c:621a:b0:47d:92bb:2723 with SMTP id
 5b1f17b1804b1-48320928d7cmr162109655e9.3.1770645387199; 
 Mon, 09 Feb 2026 05:56:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483206b8ebbsm373368885e9.1.2026.02.09.05.56.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 05:56:26 -0800 (PST)
Message-ID: <990d4306-d0b0-4f7f-9e09-de1727f9312e@redhat.com>
Date: Mon, 9 Feb 2026 14:56:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/11] target/arm/machine: Improve traces on register
 mismatch during migration
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com,
 ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <20260126165445.3033335-3-eric.auger@redhat.com>
 <CAFEAcA8dVLEa9gJ6y=hP94ZZtcNQemRawpfyWo1kLusBdy25kw@mail.gmail.com>
 <87ldh2rsfs.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87ldh2rsfs.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/9/26 1:51 PM, Cornelia Huck wrote:
> On Fri, Feb 06 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On Mon, 26 Jan 2026 at 16:55, Eric Auger <eric.auger@redhat.com> wrote:
>>> Currently when the number of KVM registers exposed by the source is
>>> larger than the one exposed on the destination, the migration fails
>>> with: "failed to load cpu:cpreg_vmstate_array_len"
>>>
>>> This gives no information about which registers are causing the trouble.
>>>
>>> This patch reworks the target/arm/machine code so that it becomes
>>> able to handle an input stream with a larger set of registers than
>>> the destination and print useful information about which registers
>>> are causing the trouble. The migration outcome is unchanged:
>>> - unexpected registers still will fail the migration
>>> - missing ones are printed but will not fail the migration, as done today.
>> Improving the diagnostics here is a great idea.
>>
>>> The input stream can contain MAX_CPREG_VMSTATE_ANOMALIES(10) extra
>>> registers compared to what exists on the target.
>>>
>>> If there are more registers we will still hit the previous
>>> "load cpu:cpreg_vmstate_array_len" error.
>>>
>>> At most, MAX_CPREG_VMSTATE_ANOMALIES missing registers
>>> and MAX_CPREG_VMSTATE_ANOMALIES unexpected registers are printed.
>>>
>>> Example:
>>>
>>> qemu-system-aarch64: kvm_arm_cpu_post_load Missing register in input stream: 0 0x6030000000160003 fw feat reg 3
>>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 0 0x603000000013c103 op0:3 op1:0 crn:2 crm:0 op2:3
>>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 1 0x603000000013c512 op0:3 op1:0 crn:10 crm:2 op2:2
>>> qemu-system-aarch64: kvm_arm_cpu_post_load Unexpected register in input stream: 2 0x603000000013c513 op0:3 op1:0 crn:10 crm:2 op2:3
>>> qemu-system-aarch64: error while loading state for instance 0x0 of device 'cpu'
>>> qemu-system-aarch64: load of migration failed: Operation not permitted
>>>
>>> With TCG there is no user friendly formatting of the faulting
>>> register indexes as with KVM. However the 2 added trace points
>>> help to identify the culprit indexes.
>> Could we move kvm_print_register_name() out of kvm.c and into
>> somewhere that the TCG code can use it? (I did think when I
>> was reviewing the patch that added that that we might want it
>> for TCG too eventually.)
> I'm wondering which parts could/should be generalized -- the sysreg
> encodings match with the CP_REG_ encodings, but I don't think much else?
> Might be worth trying to split those regs off?
>

In target/arm/cpregs.h, there is cpreg_to_kvm_id() which is used to
convert some cpreg into kvm regidx.
Those latter are stored in cpu->cpreg_indexes. I noticed that because
when advertising TCG 

DBGDTRTX 0x40200000200e0298

as safe to ignore in the incoming stream I used the kvm regidx in the prop value.


cpreg_to_kvm_id does not use any KVM header. I guess we may rewrite 

kvm_print_register_name() into something similar and use it also for TCG. what do you think?

Thanks

Eric



