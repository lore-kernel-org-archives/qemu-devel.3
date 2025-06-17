Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B15C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYc6-00047u-3r; Tue, 17 Jun 2025 11:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYRq-0007Hl-D7
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:42:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYRl-0005rn-47
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750174920;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=daHsNykC+60PUSpDLO+SebjuEw5ukuCfdxPUHgekuac=;
 b=P3DLpNXL8Ro14D+GvW+X+uLT7LvwEH5WQGCDB02NYgyz5EqR0vnbdykjKxGO5EjenYWzUW
 PHO2+ZdfUNwWkMaMksLfub5Ng900u5j7QlKLEXMqGr6JGNyGe135mEa7+xsJNcWDQNYp03
 4yuq3uqhBQmhfJ+VTx5a5ub5aBjmysg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-7Qz2L-mGOpye0Wa_RfZ7yg-1; Tue, 17 Jun 2025 11:41:58 -0400
X-MC-Unique: 7Qz2L-mGOpye0Wa_RfZ7yg-1
X-Mimecast-MFC-AGG-ID: 7Qz2L-mGOpye0Wa_RfZ7yg_1750174917
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-453080e4741so48123635e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 08:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750174917; x=1750779717;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=daHsNykC+60PUSpDLO+SebjuEw5ukuCfdxPUHgekuac=;
 b=DwJBunV+pmCC5I9I0tXwWrIgxTd2WK7Q2X0EJ5EmqwwLDvE45oik0pLK0ZR2DmHxQl
 /qQxo8VafDzmqu1aZyMlZ+twdZUaaALbrg+A+oPKQO4Y0wimPTk1avBoOEOt2U13vseG
 uhhwwA77a4Fa9+MZVm27u1zfKkWBNe3LOh97ybQoQkocs+6+bz3OFQWOAWGWEpSrBX4U
 mIkgbWtb0LdKLMRLG2RXWqLdFLlu0VTV0p2Tv5m/s1tC0ugOACCN+wvOOrcn7VtM3dmC
 nPtkxxsM5z1HdppAk2PPLxFbDC8UrjJ7JdnCjgkMiERJgZxxQjXxSDLqJb6rGRHVVSWl
 0d2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcSGwWTyQGywc/qCEqWKzJg/fXhsReVWfUr78nd0x38R71YUrWyt5B4PuRP39/NOGNKKyu+edgZ3rH@nongnu.org
X-Gm-Message-State: AOJu0YzG22wV8OfANAOUhVBaIdUI2MxnBhXHE0kzaAOeJlwynw3xmVtO
 Kt5LT6iiYkNB50JLZZEDLiNuNo8IQR93k4qbKF2rLp3CUZYgLrX0XKnBMWtKN4wyz6b9M6jbGFW
 jejpoR+Sr5MHVoT7z91MJp+pa6eybs0mJWOOQEIZUry5jyVRxDVNNU5t6
X-Gm-Gg: ASbGnct2CBA4ft0yDgl7If50ubclLnnULiizXj7pqbTWjkvIUnOMSjI8n/Hek0FpW8l
 4hFmbxAOpzOUn85Y07InCZHJhIEMS/Ak+vGcD+j2dOL41IpLdOzVgCz/dtHXIegbRSa7PijgA83
 H3CJgL4B1//8rRxrKIwJnwsRnxZp1amx2pr9D2vpBw7i31xPQnnVfNpJsPKctmKvix36uwXN2Ns
 tH01jAUI6vAPdluGgIDpte9KFvwYEIhxQ82gO072PBvtR+qVCReXoFucVsPt8SYFi9PjIUImH4V
 aG5GYVlU1Hzz/uX2E5TQbdB8Yszo4n2Dt726LTyeItssDDBou13OOhMC9oWK0XT8kIqHLA==
X-Received: by 2002:a05:6000:290b:b0:3a4:dcb0:a4c with SMTP id
 ffacd0b85a97d-3a57238b8e6mr11142645f8f.12.1750174916962; 
 Tue, 17 Jun 2025 08:41:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8sDyeEtsNeyQa24qKjABHMdoTSt5NkAscnCIBlNYErQHQEJ8mICl1VILM2p57aTOaEkavDQ==
X-Received: by 2002:a05:6000:290b:b0:3a4:dcb0:a4c with SMTP id
 ffacd0b85a97d-3a57238b8e6mr11142606f8f.12.1750174916421; 
 Tue, 17 Jun 2025 08:41:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a54af6sm14195960f8f.6.2025.06.17.08.41.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 08:41:55 -0700 (PDT)
Message-ID: <efd4cb44-3d63-43b5-9568-1263ccf7566a@redhat.com>
Date: Tue, 17 Jun 2025 17:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Miguel Luis <miguel.luis@oracle.com>, Alyssa Ross <hi@alyssa.is>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
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
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <D3582F3A-B07A-4F05-827C-B030617B77EA@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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



On 6/17/25 5:23 PM, Miguel Luis wrote:
> Hi Alyssa,
>
>> On 17 Jun 2025, at 14:17, Alyssa Ross <hi@alyssa.is> wrote:
>>
>> Eric Auger <eric.auger@redhat.com> writes:
>>
>>> From: Haibo Xu <haibo.xu@linaro.org>
>>>
>>> Up to now virt support on guest has been only supported with TCG.
>>> Now it becomes feasible to use it with KVM acceleration.
>>>
>>> Also check only in-kernel GICv3 is used along with KVM EL2.
>>>
>>> Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
>>> Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Hi!  From what I can tell, this will produce an error on hosts that
>> don't support nested virtualization when QEMU is invoked with -accel
>> kvm:tcg
> I didn’t know '-acell kvm:tcg’ could be used as a fallback mechanism between
> acceleration modes. May I ask whether do you manage the ‘-cpu’ type for ‘-accel
> kvm:tcg’ with cpu ‘max’ ?
Does it exist?
qemu-system-aarch64: -accel kvm:tcg: invalid accelerator kvm:tcg

Alyssa, didn't you mean -accel kvm or --accel tcg
>
> But more importantly, is this what you’re referring to?
>
> Although,
>
>> -machine virtualization=on,
> should work for both '-accel kvm’ and ‘-accel tcg’.
>
>> but I don't think that's the ideal
>> behaviour.  It would make more sense for it to fall back to the first
>> permitted accel option that does support running the machine as
>> configured, so if hardware nested virtualization is not supported, it
>> should fall back to TCG.
>>
>> I maintain an OS development environment that includes scripts for
>> running images in QEMU, where running KVM on those images is a
>> requirement.  Currently, those scripts simply force TCG on aarch64.
>> With this change, to take advantage of KVM NV support, I'd have to try
>> to identify in the script whether NV would be supported.  QEMU would be
>> in a much better position to determine this and fall back to TCG if it's
>> unsupported, like how the -accel option with multiple values usually
>> works.
> Thanks,
> Miguel


