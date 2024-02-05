Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B07C4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 08:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWuSG-0002f6-JW; Mon, 05 Feb 2024 03:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rWuSF-0002ej-BX
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 03:35:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rWuSD-0007LK-Gw
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 03:35:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707122147;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SzGEh6DKD/9fITIH7EPcmy8YZhlDYDZMVhSftFJvAqU=;
 b=grggIxcHqxI/7N2OVlalAmNAImg84oyAfaoiAkcaOT+TNtjw8tzEiZyruFbCghVuziRo6A
 FAt0o16QW6uCUApQlM0XfdP09Pvh1B21yeo8ettcCs7w3aSM1s4MNDPJ6JSsDGViEiaHty
 Gde4YrZpweC9QoSlcNMdT4On08yo6Ww=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-4YZ_T9kDML2NiWeT_ZB6EA-1; Mon, 05 Feb 2024 03:35:46 -0500
X-MC-Unique: 4YZ_T9kDML2NiWeT_ZB6EA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-50e9e5c8f49so4774695e87.3
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 00:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707122144; x=1707726944;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzGEh6DKD/9fITIH7EPcmy8YZhlDYDZMVhSftFJvAqU=;
 b=L4S4CMll3KMNB2LEWWj17RfQUelsE5ZtOAZW1E3m/rk7A+mSCzqGJr4pYtxxvO/DZb
 saY44gs4jgJwhrJ7F/jojJkVgjfEvcanaTcqlgFqek8vZLccMdZO6XaYsMsFe+0jjXRZ
 WCB9D4tM7iRpcWHcTM5/meDP+3BJ4D3G6sLFyx9w5yRZzXiQ8ApGFt3NLjMIeRZ7fTIt
 N8RMHryErA8ITmYD/buOpvLZFdGSgHWnN5Pqzzeebi5B1dP6Luh7PpYeAi+/lMWeRpnT
 KgKluNoXd6X0mgZIR1oP5U8jsbjQHk3AbzSqP9pLgiCMpkEXv05muhhw7yaLZIUqSWJG
 kyuA==
X-Gm-Message-State: AOJu0YzUthabd/4vf1b3/+r1fyUdJRFO+ThkBdNJj8oxMP/M05/P/4PY
 KqX8+EaEgmduz25WX26h5ZX1Xa7dDpkRuK6vCLyLVM8NXJo2964bGHJpyJLiEELQy7dzuRaoCU0
 /m+Lqo46A4ErP4hPjzvoXHfiWEbt6qIqT3abbJ96imjbLawhl0YIl
X-Received: by 2002:a05:6512:3d8d:b0:511:4fbb:47ac with SMTP id
 k13-20020a0565123d8d00b005114fbb47acmr1630199lfv.29.1707122144553; 
 Mon, 05 Feb 2024 00:35:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGScqPH9LVBDJIT3ODDsumebsSqIkWKjLxg52TpsUgijjgmKFeVl6kp05zq7m3IfE5H94Wapg==
X-Received: by 2002:a05:6512:3d8d:b0:511:4fbb:47ac with SMTP id
 k13-20020a0565123d8d00b005114fbb47acmr1630173lfv.29.1707122144085; 
 Mon, 05 Feb 2024 00:35:44 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWggbX1+hvoXQqvz9r8+zoggGi2v0iV/FagUlHN4Q6HGntq9ZJUPZhB/RtdVuNp+99FXvfXqxN1p9hrU7pK56DxjoXqHuLKSZ1SLvSyOsCqwl5iRfHT6qCi0in6X+BfJ130GNy5NF7Z44YQ1w==
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w9-20020a05600c474900b0040fde0ec31esm411392wmo.31.2024.02.05.00.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 00:35:43 -0800 (PST)
Message-ID: <65beda13-d994-4bb4-8dd3-e01d592f2b7e@redhat.com>
Date: Mon, 5 Feb 2024 09:35:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/15] tests/qtest/migration: Don't use -cpu max for aarch64
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
References: <ZbcSqyGNLGu7ugBb@x1n> <87sf2ge3qu.fsf@suse.de>
 <87y1c7ogze.fsf@suse.de>
 <CAFEAcA_BPf4LSh-JF1NVVVdaLoKgUcsnGeP7sHt-f73r4zyh7g@mail.gmail.com>
 <ZbjT5OYpzNJjkMw9@x1n> <87wmrqbjnl.fsf@suse.de> <ZbnG3qkMBPdsQxan@x1n>
 <878r45lkeb.fsf@suse.de> <ZbsIYKJ5fYG6zsVi@x1n> <87y1c4ib03.fsf@suse.de>
 <ZbwuSM7LjWCsa_VB@x1n>
 <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-h6BDiY4G1uBymcmmnzagHTvhevb1wXPzwBOwZYM338Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On 2/2/24 11:51, Peter Maydell wrote:
> On Thu, 1 Feb 2024 at 23:50, Peter Xu <peterx@redhat.com> wrote:
>> Fabiano, I think you forgot to reply-to-all.. adding back the list and
>> people in the loop.
>>
>> On Thu, Feb 01, 2024 at 10:12:44AM -0300, Fabiano Rosas wrote:
>>> Peter Xu <peterx@redhat.com> writes:
>>>
>>>> On Wed, Jan 31, 2024 at 10:09:16AM -0300, Fabiano Rosas wrote:
>>>>> If we ask for KVM and it falls back to TCG, we need a cpu that supports
>>>>> both. We don't have that. I've put some command-line combinations at the
>>>>> end of the email[1], take a look.
>>>> Thanks a lot, Fabiano.  I think I have a better picture now.
>>>>
>>>> Now the question is whether it'll be worthwhile we (migration) explicitly
>>>> provide code to workaround such issue in qtest, or we wait for ARM side
>>>> until we have a processor that can be both stable and support KVM+TCG.
>>>>
>>>> I actually personally prefer to wait - it's not too bad after all, because
>>>> it only affects the new "n-1" migration test.  Most of the migration
>>>> functionality will still be covered there in CI for ARM.
>>> That's fine with me. We just need to do something about the arm CI job
>>> which is currently disabled waiting for a fix. We could remove it or add
>>> some words somewhere explaining the situation. I can do that once we
>>> reach an agreement here.
>> Yes.  IMHO we can keep the test (with SKIPPED=1) but amend the message,
>> which will start to state inaccurately:
>>
>>         # This job is disabled until we release 9.0. The existing
>>         # migration-test in 8.2 is broken on aarch64. The fix was already
>>         # commited, but it will only take effect once 9.0 is out.
>>
>> IMHO then it won't mean 9.0 will have it fixed, but we'll simply wait for a
>> cpu model that is ready for both kvm+tcg, then we replace "max".
> We already have a CPU model that works for both KVM and TCG: that
> is "max". We're not going to add another one. The difference is
> just that we provide different cross-version migration compatibility
> support levels for the two cases. (Strictly speaking, I'm not sure we
> strongly support migration compat for 'max' on KVM either --
> for instance you probably need to be doing a migration on the
> same host CPU type and the same host kernel version. It's just
Yes in general migrating to different kernels will fail. Same for
different pCPU types.
We need CPU models to work around some of those limitations. Adding
Sebastian in copy. He is currently working on this.

Thanks

Eric
> that the definition of "max" on KVM is less QEMU-dependent and
> more host-kernel-dependent, so in your particular situation running
> the test cases you're less likely to see any possible breakage.)
>
> -- PMM
>


