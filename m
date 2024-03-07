Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14F6C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAKq-0005wr-9c; Thu, 07 Mar 2024 04:46:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1riAKo-0005wU-O7
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:46:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1riAKm-0004FJ-Oc
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804798;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gn3w3P0oyjgFKje9JWf7VjYF9RtlVwptZtpY8/vJq40=;
 b=YSBgKcsGbKSWbyagc5FQJr+o0oyHDcWmxNvOjyRgxCXpOaPhxwM9me/Y5p9+iTnViEuUde
 72XUvEiAK3n83Ru7GEIwv1CWzwCtcKSZyxqqQ7i6BLn+ZkAmgSqZLFnPmiryBBCt67pJ8v
 j4hMpPC60iJya/anUlEQKrb+16Iwmvg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-KShqYsUPMJm1oNOVKxnkSQ-1; Thu, 07 Mar 2024 04:46:35 -0500
X-MC-Unique: KShqYsUPMJm1oNOVKxnkSQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e6b0f5d23so81387f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 01:46:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709804794; x=1710409594;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gn3w3P0oyjgFKje9JWf7VjYF9RtlVwptZtpY8/vJq40=;
 b=T1RzmIhbKepVvDP0yF4A6mF7Co12j/9HFt5+SZtWEfMzvI3DteEoZM3/NA9kE1Q02L
 6KXeUyobZ5WHkhL33t3H6q0AGzeFBrH0amU+n/pBmD5/yKpMQuyuQ06AaLTI6eM8YHFB
 H77vLxnYqOgiAphpx/XBwqUL48MBVInCTEl1PyCiE5ajI+BEwRZ9Q6Qh+W0pAl+dHNoz
 h14/s3WKzGFpvZ6W5EFQPyxhXFztRiszAS6lBKfIuImO887UJ8ss6ZWVH3XhZwaEbOhm
 zeRL0eSSpRBtQy1dFpIalnqU2GevNsfBKNGroKyeZaY5XizLVpLl7OQDiouZ8IauJQuu
 DdGQ==
X-Gm-Message-State: AOJu0YwU7V34Lu8O0u18OblALpaLUVisC/o4PGE56KQ+hqRQyZvj96Za
 +wOoIdbRnu2egOsfHFf+Hz80M2BbBEJobj7u3n9Jud8CND/3HhQdXtc2mvCdeqeM3WhRh1zJKPm
 biAf5+9l3Ie1dITbRYOxKrW8earCcvkSXh671C3YwuO2MxRs2q6fd
X-Received: by 2002:adf:cc06:0:b0:33d:afbc:6c76 with SMTP id
 x6-20020adfcc06000000b0033dafbc6c76mr13425256wrh.1.1709804794019; 
 Thu, 07 Mar 2024 01:46:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGEIfbYb3BaP7pNmWRJV04PCVuRJlDIahTOdfbqjRR/fzltzm3dgzqCZntU+2QJkKExwV86nQ==
X-Received: by 2002:adf:cc06:0:b0:33d:afbc:6c76 with SMTP id
 x6-20020adfcc06000000b0033dafbc6c76mr13425244wrh.1.1709804793646; 
 Thu, 07 Mar 2024 01:46:33 -0800 (PST)
Received: from fedora (g2.ign.cz. [91.219.240.8])
 by smtp.gmail.com with ESMTPSA id
 ch10-20020a5d5d0a000000b0033e26c81b11sm15055266wrb.92.2024.03.07.01.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 01:46:32 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RESEND v3 3/3] docs/system: Add recommendations to
 Hyper-V enlightenments doc
In-Reply-To: <Zel7612e3rSgcBjv@intel.com>
References: <20240305164204.525575-1-vkuznets@redhat.com>
 <20240305164204.525575-4-vkuznets@redhat.com> <Zel7612e3rSgcBjv@intel.com>
Date: Thu, 07 Mar 2024 10:46:32 +0100
Message-ID: <87sf12l6h3.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.365,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Vitaly,
>
> On Tue, Mar 05, 2024 at 05:42:04PM +0100, Vitaly Kuznetsov wrote:
>> Date: Tue,  5 Mar 2024 17:42:04 +0100
>> From: Vitaly Kuznetsov <vkuznets@redhat.com>
>> Subject: [PATCH RESEND v3 3/3] docs/system: Add recommendations to Hyper-V
>>  enlightenments doc
>> 
>> While hyperv.rst already has all currently implemented Hyper-V
>> enlightenments documented, it may be unclear what is the recommended set to
>> achieve the best result. Add the corresponding section to the doc.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  docs/system/i386/hyperv.rst | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>> 
>> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
>> index 009947e39141..1c1de77feb65 100644
>> --- a/docs/system/i386/hyperv.rst
>> +++ b/docs/system/i386/hyperv.rst
>> @@ -283,6 +283,36 @@ Supplementary features
>>    feature alters this behavior and only allows the guest to use exposed Hyper-V
>>    enlightenments.
>>  
>> +Recommendations
>> +---------------
>
> This guide is very helpful!
>
>> +To achieve the best performance of Windows and Hyper-V guests and unless there
>> +are any specific requirements (e.g. migration to older QEMU/KVM versions,
>> +emulating specific Hyper-V version, ...), it is recommended to enable all
>> +currently implemented Hyper-V enlightenments with the following exceptions:
>> +
>> +- ``hv-syndbg``, ``hv-passthrough``, ``hv-enforce-cpuid`` should not be enabled
>> +  in production configurations as these are debugging/development features.
>> +- ``hv-reset`` can be avoided as modern Hyper-V versions don't expose it.
>
> Does the "Hyper-V versions" means Hyper-V guest version or Microsoft's Hyper-V
> hypervisor version? 
> It would be better to clarify Hyper-V guest and Hyper-v hypervisor.
>
> And it would be better to have a clear version number.

This is about QEMU/KVM emulating certain Hyper-V version, not about
guest Hyper-V version. To be honest, I'm not sure what was the last
version of Hyper-V which was exposing HV_SYSTEM_RESET_RECOMMENDED. I
don't have anything older that WS2016 around now and the bit is not
there. If I'm not mistaken, it was already missing in 2012R2. I would
appreciate if anyone has more precise historical info to add here.

>
>> +- ``hv-evmcs`` can (and should) be enabled on Intel CPUs only. While the feature
>> +  is only used in nested configurations (Hyper-V, WSL2), enabling it for regular
>> +  Windows guests should not have any negative effects.
>> +- ``hv-no-nonarch-coresharing`` must only be enabled if vCPUs are properly pinned
>> +  so no non-architectural core sharing is possible.
>> +- ``hv-vendor-id``, ``hv-version-id-build``, ``hv-version-id-major``,
>> +  ``hv-version-id-minor``, ``hv-version-id-spack``, ``hv-version-id-sbranch``,
>> +  ``hv-version-id-snumber`` can be left unchanged, guests are not supposed to
>> +  behave differently when different Hyper-V version is presented to them.
>> +- ``hv-crash`` must only be enabled if the crash information is consumed via
>> +  QAPI by higher levels of the virtualization stack. Enabling this feature
>> +  effectively prevents Windows from creating dumps upon crashes.
>> +- ``hv-reenlightenment`` can only be used on hardware which supports TSC
>> +  scaling or when guest migration is not needed.
>> +- ``hv-spinlocks`` should be set to e.g. 0xfff when host CPUs are overcommited
>> +  (meaning there are other scheduled tasks or guests) and can be left unchanged
>> +  from the default value (0xffffffff) otherwise.
>> +- ``hv-avic``/``hv-apicv`` should not be enabled if the hardware does not
>> +  support APIC virtualization (Intel APICv, AMD AVIC).
>>
>
> It's also better to add blank lines between paragraphs above.

Np, if I am to re-send this I'll add these (hope it's not an acceptance
blocker, we can always do a follow-up).

>
> BTW, may I ask another Windows question? I understand that Windows such
> as Windows 10 and later is already a virtualized architecture with
> built-in Hyper-V to run root partation.
>
> So is it true that booting Windows VM via KVM + QEMU is running Windows
> Guest in L2? Or what is the relationship between Hyper-V within Windows
> and Hyper-V enlightenments with QEMU + KVM?

Hyper-V is a role you can enable in various Windows versions, both
server and client. When enabled, you get a hypervisor (which is called
'Microsoft Hypervisor' as I was told) and your Windows becomes the root
partition (similar to Xen Dom0). In case you run this on KVM, Windows
becomes L2. Hyper-V enlightenments provided by KVM/QEMU are consumed by
the hypervisor then.

Note: Hyper-V role is optional, in many cases Windows guests run without
it (no Hyper-V VMs, no WSL2, ...) and thus consume KVM's Hyper-V
enlightenments directly, no nested virt involved.

-- 
Vitaly


