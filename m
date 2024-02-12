Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32CDEC4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 17:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZtu-0000Mh-5H; Mon, 12 Feb 2024 12:15:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZZts-0000Le-1L
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 12:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rZZtp-000538-Cv
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 12:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707758116;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1aKF/HMrRXJ6nv8MtrkX73O6B4O3fdyhzmK/h1hu+24=;
 b=hU4QUfe4T4CfxmZupuGFYzBLRcb7eQ4ikWmSAzbRSIQFcV/JmPnqMH4Ag2KR0VUfKJ5Vpm
 oBbermFIuGd/VXCYFxQfYG/46pUW9CZ2D+ytSwze4cshEFts8mvkSEFGI2GJCpLFbm1s9h
 9rF5zp/aC2Iqr30xLytHIXJkcnyJIyM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-9Fn_Z1N9P-aIc1YDSPamdA-1; Mon, 12 Feb 2024 12:15:14 -0500
X-MC-Unique: 9Fn_Z1N9P-aIc1YDSPamdA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6e0ee912d44so445253b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 09:15:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707758113; x=1708362913;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1aKF/HMrRXJ6nv8MtrkX73O6B4O3fdyhzmK/h1hu+24=;
 b=qHzOs5AYdtLmW+BRItmEOEhRtMgToG5ZIipbLmexlnO+zLajTzE6CanIVjyPxpt42P
 K/mCnESmx56xFAKPAY6awwAG9S/j9hqzD9iYpcEGYI4V5m/dR+rqW28hqoX30avIRfCS
 Hai1esNCQDM0Q9lxS4+POBKJjKOlxw1RjkVCe2uxHn1TTm/UXLWDrFbO1U5nv9+YUY7Y
 Yal8Fk2qzb/S5c4ub61Jef36ZT3LyzFc4mokKeKAEvAhw/l4ZLmOlhDuiSHAENDp+Ftg
 KcDIeSX0KYrPL2l8VjOuLHriXgpZ3PulDKgC7/YHH7Pr5uax6FR6IjW2sD0oIDGnsNeN
 ReYw==
X-Gm-Message-State: AOJu0YzoLCezazDH63ohpmLMZtepo0jO8VY7dSTSRU1YxWfpjbT4wfXd
 pcE01xBq2XG7uBocb1HyCdczGo4f73Ulj+Q9odLhaTvHcoeFVUQB6plDnAAQNPvBg1Q/z4jj2fa
 LbhdRGyN6jJi48BCktYaT3RA6yREjMLbOykp4y+ODyCtiVkiZbfA6
X-Received: by 2002:a05:6a00:84b:b0:6e0:e172:6088 with SMTP id
 q11-20020a056a00084b00b006e0e1726088mr4168411pfk.1.1707758113172; 
 Mon, 12 Feb 2024 09:15:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfxjROPa2NPl3HQ2a8visydvD0XkWP1C3UVF0zJ/CyLK8E76XdZ+CcNPqsvA5XVo41aEKH/Q==
X-Received: by 2002:a05:6a00:84b:b0:6e0:e172:6088 with SMTP id
 q11-20020a056a00084b00b006e0e1726088mr4168381pfk.1.1707758112855; 
 Mon, 12 Feb 2024 09:15:12 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX3BcyoBhFN1tk4C3oK2bL6GFFYP3kY6JzF7aOAP48SWCm/JGokwgOiXMJAQMj6chXYF7ovcKTQJrTxBKFeyfw/DN5DvnWZ9JezySY2ryDYHAfzBEPzScZx2WL71cbXDqRwL+9sZU0C11XwG6tGW3qLkPLGk1jjbk0VCEciN4kPW6wqMmutl/TQA2AGJOU0Fazvm20AnEL9ClWFUMOwKo3PineqDPJDSUNPqGGzJFZSSUIC00UZizj4GsT/Y7Jmg/rhe75efe5bxpuu93Km/ThjB6z6jQ==
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 r18-20020a62e412000000b006e03ab56acbsm5751329pfh.217.2024.02.12.09.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 09:15:12 -0800 (PST)
Message-ID: <9e83352e-a643-4df6-849b-ac28ab119200@redhat.com>
Date: Mon, 12 Feb 2024 18:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/5] ARM Nested Virt Support
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org,
 maz@kernel.org, gkulkarni@amperecomputing.com
References: <20240209160039.677865-1-eric.auger@redhat.com>
 <CAFEAcA_SFtmCCFBPwWjJF3uygdpdqoZuYLaQQP186fyQ+dJEHA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA_SFtmCCFBPwWjJF3uygdpdqoZuYLaQQP186fyQ+dJEHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi Peter,

On 2/9/24 19:57, Peter Maydell wrote:
> On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>> This series adds ARM Nested Virtualization support in KVM mode.
>> This is a respin of previous contributions from Miguel [1] and Haibo [2].
>>
>> This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
>> L2 guests booted without EDK2. However it does not work yet with
>> EDK2 but it looks unrelated to this qemu integration (host hard lockups).
>>
>> The host needs to be booted with "kvm-arm.mode=nested" option and
>> qemu needs to be invoked with :
>>
>> -machine virt,virtualization=on
>>
>> There is a known issue with hosts supporting SVE. Kernel does not support both
>> SVE and NV2 and the current qemu integration has an issue with the
>> scratch_host_vcpu startup because both are enabled if exposed by the kernel.
>> This is independent on whether sve is disabled on the command line. Unfortunately
>> I lost access to the HW that expose that issue so I couldn't fix it in this
>> version.
> You can probably repro that by running the whole setup under
> QEMU's FEAT_NV emulation, which will be able to give you a CPU
> with both FEAT_NV and SVE.

indeed, this should work now we have FEAT_NV.
>
> Personally I think that this is a kernel missing-feature that
> should really be fixed as part of getting the kernel patches
> upstreamed. There's no cause to force every userspace VMM to
> develop extra complications for this.
yes maybe this will be fixed later on.

Thanks!

Eric

>
> thanks
> -- PMM
>


