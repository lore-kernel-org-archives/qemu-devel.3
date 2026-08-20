Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F66C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5CU-0000t1-EL; Thu, 20 Aug 2026 12:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wx5CS-0000q9-Sv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wx5CQ-0001Te-Nv
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787241661;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfcVWwh/y440qFMJt0bsGIXtJnzC4KlT0imLo1y60K4=;
 b=U+TJrE+n9K9zcWIFFAxFdSSc2yNYnV7ypBc6QsZJxKuEink30EC3VHI2dFUmqQMp4Ttinu
 ThAvhoanZ70rPnTejK7YTYwysUOL5g1I7WfBnvZKiFG69NUPL4ktZKDIhytPGCKRuOU7Wc
 QB+HfnmF49teOhavTygrIsZ8YYTUCIw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Z_9m3VgwNuyBNuTiO81X2A-1; Thu, 20 Aug 2026 12:00:59 -0400
X-MC-Unique: Z_9m3VgwNuyBNuTiO81X2A-1
X-Mimecast-MFC-AGG-ID: Z_9m3VgwNuyBNuTiO81X2A_1787241658
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490a767b782so18597415e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:00:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787241658; x=1787846458;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bfcVWwh/y440qFMJt0bsGIXtJnzC4KlT0imLo1y60K4=;
 b=nBUbpVyGxZ1V/BBX6vISLWyrNRUeFXgehZePXRVJuDTcHR1d0za0UqWtK9RHamZATL
 hKd2RcIJhSSD2nECdw8Mt5NZF6eTxrVmzZzcTyKxgwuVwABItSj1Wgi4MZrlKnAdHDRI
 JOHDeCOrGLNcijGvtDxyqyw5TRFiD3lFpvk+h+IENNV/3MKKyTsTnF+T1UiuWDZYc84Z
 h21EKSXVSBt8c1jRenPCffRo/CUsJfpmtIsooSz9ofOABAV7vbB7a+UqT1+TNELX25Bc
 KCh3kXqqnnhkdo3ldI6vn0PrM7qu/4oiRMEkrxJZ/5ZW9JkbryBSxnHSsIwUM9vaWadT
 kgCg==
X-Gm-Message-State: AOJu0Yx5banFm0fwctkurb+k9J/7CIeOYTWdHaR7dYInCve3C2wssBJu
 20ycIZ9AlxGo9GOIVoeJTNI2DPnGc0tqWglOU59OmrPDAt0UYOWyj/e2NgABk5XnkULaQQscYry
 wR0gC59VZR+NvYM1tRks/wC0VZHuW2K7VF+JJpXYVNUWIp5Ru/lxP5/dH
X-Gm-Gg: AR+sD11XVhQQMZ8q+eyB1wKDUZHpXzwIzBf0IJQ6nSaT9sH3eOvqGbkIWZYkbfdz9Bp
 Hah3qyV40k1NOa3DjdKPgdxiq4sIhcCp1idPZzX1jAFXL2A6n4IiQ4hMevpgUsfGJphmDKVu2h+
 A+h3k2bHdaXaxeblQ8GudnuoNcQUNEGtHU83miOi5FzjuRPzWxbgqwepsnWiUzPGYRPO9CEAKt9
 fUvQQdcwMEH85zsYjCiJHmNLF/lPmLXqimc5b4cDG0hGXKI0ZAa0sNpSGF1SUTuGp/Zk1pEyA5s
 uOO7ZdvYqKvB5DcJADUid0r3Q+Ss501jNvLx0FhQpwJBtEsXkNgZBnAzKchjcnSKDA2mq3ECVJ5
 ReG+Dvr9BoJU3GthAaHJyUT09hox3XBdMDtBajQWoo6h3NhV6
X-Received: by 2002:a05:600c:8b62:b0:499:a6ae:20a1 with SMTP id
 5b1f17b1804b1-499aa1dc5b6mr266871925e9.14.1787241657676; 
 Thu, 20 Aug 2026 09:00:57 -0700 (PDT)
X-Received: by 2002:a05:600c:8b62:b0:499:a6ae:20a1 with SMTP id
 5b1f17b1804b1-499aa1dc5b6mr266870255e9.14.1787241657090; 
 Thu, 20 Aug 2026 09:00:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fda98sm231359415e9.1.2026.08.20.09.00.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 09:00:56 -0700 (PDT)
Message-ID: <4d45766a-f0f5-4e59-b1ca-cf8d5b039a80@redhat.com>
Date: Thu, 20 Aug 2026 18:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 16/19] qmp: add query-cpu-props-info command
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Prerna Saxena <prerna.saxena@nutanix.com>
References: <20260716213858.609699-1-khushit.shah@nutanix.com>
 <20260716213858.609699-17-khushit.shah@nutanix.com>
 <87y0f5u78t.fsf@pond.sub.org>
 <6AA3BD42-9596-476B-9F64-AB09372821B9@nutanix.com>
 <87tspa5skn.fsf@pond.sub.org>
 <FD805FA0-9323-450C-9D79-319C0883F05E@nutanix.com>
 <FDD5760F-94E6-46F4-AC62-AB0DC98322FD@nutanix.com>
 <8733wu5qfs.fsf@pond.sub.org>
 <08DA9B28-D5BD-4EC3-8182-FEE212F0C2A0@nutanix.com>
 <871pcd12bf.fsf@pond.sub.org>
 <5F6481F1-B5E1-4B30-A4D1-481D9C0731AC@nutanix.com>
 <87o6fgzopu.fsf@pond.sub.org>
 <7B2898F0-DA7A-4DFD-A2CB-997833A47A05@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7B2898F0-DA7A-4DFD-A2CB-997833A47A05@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 8/6/26 11:24 AM, Khushit Shah wrote:
>
>> On 5 Aug 2026, at 6:52 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>
>>>> On 5 Aug 2026, at 12:28 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>>>
>>>> !-------------------------------------------------------------------|
>>>> CAUTION: External Email
>>>>
>>>> |-------------------------------------------------------------------!
>>>>
>>>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>>>
>>>>>> On 4 Aug 2026, at 12:21 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>
>>>>>> !-------------------------------------------------------------------|
>>>>>> CAUTION: External Email
>>>>>>
>>>>>> |-------------------------------------------------------------------!
>>>>>>
>>>>>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>>>>>
>>>>>> [...]
>>>>>>
>>>>>>> Stub file was missing on arm user builds. 
>>>>>>>
>>>>>>> I have fixed this on the private branch if you want to take a look.
>>>>>> I'm willing to pull an update to v3, assuming it's a small fix.
>>>>> It is a small fix :)
>>>> Please tell me what to pull.  When you're ready, of course.
>>> It’s on the same private branch: https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_khushit-2Dshah-2Dnx_qemu_tree_upstream-2Drfc-2Dv3-2Dfixups&d=DwIFaQ&c=s883GpUCOChKOHiocYtGcg&r=PGWMyignA0NiDmTlyP7vOTHozBws_VN86yrVmSMkBp0&m=lv46ybodStjAtdapjMwLnohED9-uQST3KdkvwYej9yhiKYNrRdzDyHjeuYqUxdyg&s=7IbcSv1pGL29PTHAOxj2lZWr2tySQeQqB88qHxlTpvE&e=
>> Builds, but fails "make check" on my box *sigh*.
>>
>> tests/qtest/qmp-cmd-test.c needs an update.
> :’)
>
> Fixed it, available on: 
> https://github.com/khushit-shah-nx/qemu/tree/upstream-rfc-v3-fixups
>
> On my machine, qemu:qtest+qtest-aarch64 / qtest-aarch64/device-introspect-test
> still fails. (It will likely not fail for you if you are on (arm + kvm or any
> other Arch))
>
> I have reported this to Eric as the fail stems from the base "customizable host
> model” series.

yes my bad, this will be fixed in v8

Eric
>
> Sorry for the hiccups, and thanks for your patience, will take care from now on.
>
>
>


