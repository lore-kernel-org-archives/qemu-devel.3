Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65AF5C7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSFKs-0002kF-SU; Thu, 19 Jun 2025 09:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSFKq-0002iz-BK
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:29:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uSFKn-0007Et-47
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:29:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750339779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e369BF/P5W53C1UtTP1YWy+iGdArJRFsp4iZMuaoBdw=;
 b=f2NFKipdKeVgWHa5pOacpxIgNGebRe1G8oQ+s0IP45v6nt1jDAdPCWbrWcXF/GQDPRbcO8
 9xzoOldbSA5yWq0MUSdwlXGCz7lZM0Sq4NaQdIkaWcmQ/TPrlEGv3v7oYBE2ZgzcPsB5g8
 aKVV4GyClEMDGnZKhJEDOgaqL48R2bg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-e3gRH9y8OPOx3EZEU9gNkA-1; Thu, 19 Jun 2025 09:29:38 -0400
X-MC-Unique: e3gRH9y8OPOx3EZEU9gNkA-1
X-Mimecast-MFC-AGG-ID: e3gRH9y8OPOx3EZEU9gNkA_1750339777
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530c186394so3682845e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750339777; x=1750944577;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e369BF/P5W53C1UtTP1YWy+iGdArJRFsp4iZMuaoBdw=;
 b=uCiZ3PHYmO2irHlCE1v9FCDnrduO2qc4AVHo9g6jH80JCIRpciedNvNi1YauOR2TD3
 SOT22WWvEEMLZko2zC/OWpzYo3Cd2ALUzVUroRvr4vmsbsUDMUPccHvI/DRDZBx6eBdK
 BLXmNNkKYxocsk9SQ0n+UbLq+0Y4aJcD71TgNKdIaG6h6t4N4dEnHqQCOLcpsVINfKrC
 veuYz7npsB1q+2r3Q3rUJaylgv3my1jnXSOJHbtmWlsEZGW5nniJ3jskJWdVNZ+lA+t7
 3RytPleqh38RuVI9DYp2Z1Flq8ZrUTA1Busru2Uq34vRCThHHMLh/bBzpEGc8OyIK/Xc
 TK3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIdukxEjbP5LhVX+h0zjhQYY8+bUpnP0gfvD4URhOyHvsrrecigo/YMkijgN9TUn/36HvtaVEQbXRM@nongnu.org
X-Gm-Message-State: AOJu0YxNWJE0plwMZ+w9M8tZSAccXj40CxuHlfHpr2SfuNmpMFu5ofqd
 1aD4ZpXIqKE18r09+VLsnvUWpBgrvlxy7bBzZbpVPdNg/UVniZVB0r1I6JEvrZJ+LHIo83rVrz0
 FStLO9y31ZnJ51O4CK/oFJ7LRKX1pCSLTowsiGtwX/LXMA1R6qKaD1wDG
X-Gm-Gg: ASbGnct2uAn9L4rZOdzdXwcWo1dvf7AltXt0UXTcTmwUm5G0piHTR4WdizoIc1hJVrr
 wIfvM33QW/Fx+zDAKBn3oa0GgX7sYDMFQgNX7fkPvkA0z0lHgbmBYMOcp2fgYHjp/27nUAvike2
 B0y6w9yioEc8WtQSugAEwNmDU9GbYg6SKTuDHvvV/RyJWh9wwJFHFsyyTnOVRJ5DsyubCSKAHIC
 XDAcTPeBrtWVir1aSG+Xw/W3L1aYwk0ZFM4CcTuL9f1vJbL7OVkHybz8LLIEyvynFY/F5Uq0c+b
 UD68yT3qoSbYxjUUAtb0sMonQRk/a3pGABwGqRN/BAKd6wIXZ4YMv3tCrWcXdC8Acf66AQ==
X-Received: by 2002:a05:600c:5396:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-4533cad1d17mr203936575e9.5.1750339776932; 
 Thu, 19 Jun 2025 06:29:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHww/bQkcPZ9cEha+rMtKpRoFM6mmFVQrWeBnovhrG/dff76Y2oneb+aoxJH9JVYnqhKcjUag==
X-Received: by 2002:a05:600c:5396:b0:43d:26e3:f2f6 with SMTP id
 5b1f17b1804b1-4533cad1d17mr203936245e9.5.1750339776423; 
 Thu, 19 Jun 2025 06:29:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45362b34f7esm6404805e9.25.2025.06.19.06.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 06:29:35 -0700 (PDT)
Message-ID: <01ab0b6e-ccd5-4465-98c0-70b8ec2ac87a@redhat.com>
Date: Thu, 19 Jun 2025 15:29:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Alyssa Ross <hi@alyssa.is>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "gkulkarni@amperecomputing.com" <gkulkarni@amperecomputing.com>,
 "gankulkarni@os.amperecomputing.com" <gankulkarni@os.amperecomputing.com>
References: <20250527062534.1186004-1-eric.auger@redhat.com>
 <20250527062534.1186004-6-eric.auger@redhat.com> <875xgutpuh.fsf@alyssa.is>
 <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
 <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
 <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <0EA149E9-D637-4BC0-A10F-7B896581A914@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 6/17/25 5:50 PM, Miguel Luis wrote:
> Hi Eric,
>
>> On 17 Jun 2025, at 15:41, Eric Auger <eric.auger@redhat.com> wrote:
>>
>>
>>
>> On 6/17/25 5:23 PM, Miguel Luis wrote:
>>> Hi Alyssa,
>>>
>>>> On 17 Jun 2025, at 14:17, Alyssa Ross <hi@alyssa.is> wrote:
>>>>
>>>> Eric Auger <eric.auger@redhat.com> writes:
>>>>
>>>>> From: Haibo Xu <haibo.xu@linaro.org>
>>>>>
>>>>> Up to now virt support on guest has been only supported with TCG.
>>>>> Now it becomes feasible to use it with KVM acceleration.
>>>>>
>>>>> Also check only in-kernel GICv3 is used along with KVM EL2.
>>>>>
>>>>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>>>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Hi!  From what I can tell, this will produce an error on hosts that
>>>> don't support nested virtualization when QEMU is invoked with -accel
>>>> kvm:tcg
>>> I didn’t know '-acell kvm:tcg’ could be used as a fallback mechanism between
>>> acceleration modes. May I ask whether do you manage the ‘-cpu’ type for ‘-accel
>>> kvm:tcg’ with cpu ‘max’ ?
>> Does it exist?
>> qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg
> Maybe Alyssa is referring to ‘-M virt,accel=kvm:tcg,virtualization=on,gic-version=3’ ?
>
> The above didn’t triggered any error. Anyhow if the above does what Alyssa’s saying 
> we would just be missing the check for || !tcg_enabled() in this patch, I believe.

After discussion with Paolo, the lack of the CAP should be detected
earlier in kvm_init/kvm_arch_init to allow the fallback to TCG.
in target/arm/kvm.c kvm_arch_init() some generic caps are checked but
none of them are related to machine settings and this code is virt arm
machine agnostic.

I checked and adding

    if (object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
        VirtMachineState *vms = VIRT_MACHINE(ms);

        if (vms->virt && !kvm_arm_el2_supported()) {
            error_report("KVM does not support nested virtualization");
            ret = -EINVAL;
        }
    }

at the end of the function would do the job. But as I said previously
this is not done for other virt arm machine options that are accel
specific or require special KVM caps (secure, mte for instance) so it
would be a change in the approach.

As pointed out before fallback spirit was rather: "KVM isn't enabled"
than for "KVM doesn't support a specific feature".

Thanks

Eric




it's purely the first accelerator that says it can work
1:03
<https://redhat-internal.slack.com/archives/C04KFKV2SE9/p1750331005242709>
pbonzini
Where "can work" is only based on the host.


>
> Miguel
>
>> Alyssa, didn't you mean -accel kvm or --accel tcg
>>> But more importantly, is this what you’re referring to?
>>>
>>> Although,
>>>
>>>> -machine virtualization=on,
>>> should work for both '-accel kvm’ and ‘-accel tcg’.
>>>
>>>> but I don't think that's the ideal
>>>> behaviour.  It would make more sense for it to fall back to the first
>>>> permitted accel option that does support running the machine as
>>>> configured, so if hardware nested virtualization is not supported, it
>>>> should fall back to TCG.
>>>>
>>>> I maintain an OS development environment that includes scripts for
>>>> running images in QEMU, where running KVM on those images is a
>>>> requirement.  Currently, those scripts simply force TCG on aarch64.
>>>> With this change, to take advantage of KVM NV support, I'd have to try
>>>> to identify in the script whether NV would be supported.  QEMU would be
>>>> in a much better position to determine this and fall back to TCG if it's
>>>> unsupported, like how the -accel option with multiple values usually
>>>> works.
>>> Thanks,
>>> Miguel
>


