Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B9F8C5B572
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 13:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wus7u-0001eq-4f; Fri, 14 Aug 2026 09:39:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wus7s-0001eZ-8N
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:39:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wus7q-0006Tk-7u
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 09:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786714749;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LXky0SHEEqjOX8UubfqEiUPD1zbdoOGebeozSEqSXho=;
 b=JweG736b1MuQHn60o485lYOwT2wa8+ad3eaITUvqTKUSvFm6lLQe8xDmKwz5KR9bV/VAAc
 VXjX1HGlSPnGPXfoU7JLr9CjTAKgNRpC2zv+O43My5h8vKrVOZsjBQyedOppnIkRqzGa32
 aZMEAQFZN9qRbD8eGXXobkC/Ea0Yi/M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-rm74SQw8MGCvLUXt5ZXxPw-1; Fri, 14 Aug 2026 09:39:02 -0400
X-MC-Unique: rm74SQw8MGCvLUXt5ZXxPw-1
X-Mimecast-MFC-AGG-ID: rm74SQw8MGCvLUXt5ZXxPw_1786714742
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49561facb1dso7055315e9.3
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 06:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786714741; x=1787319541;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LXky0SHEEqjOX8UubfqEiUPD1zbdoOGebeozSEqSXho=;
 b=szgQK82nN+cEBdoKgFGRcNNGSznb28KR0Dg5bQWjLCcdFhUQjh2zqeRDnyx8GiCoxS
 nMQXulroyb2VfBq+VsfKlnE7OECKCoLhYvS2iJaITrqHwM6oOMeGQbSZWBeeCdcoruMy
 1OtuovzBF/IzLtUYlvHtPlsck1H2VtmjwA+qETWHfAuB993b1I/SH94aGZwNQw4KA7NJ
 hQLKCNitH8JcnFgxdmHdq9pSDZHNCNzLPRs8VuVupq1315HO9UXLR6qiZVMWQiAuQR1W
 jL5E/QkNawDEpRWYLp3HGzCN1lKQq3sMXIAun5UMgvB0LpiCfldDRrRV6vtxUIEPSnBF
 aigA==
X-Gm-Message-State: AOJu0Ywapk0Ipnzt2Nh7qesz2HpW+CvQrjEViq6LnVYIcINPndJ4kxLQ
 BK5XcDyJy+yk3Q5mNzvwl7C+SSAwjEYSXFk6nv+XvrA2VQ3SjoIouyu2hro6XFQ2etTB91F2AjB
 82HZ4GV7hu/6GfTVUaPUvKR1zGi/iRrngjgd5soXIubujSYbOYcvpae5q
X-Gm-Gg: AR+sD13NAkzdi/9AjbRGxpvewfgsqxGy9GxwkdMDJIQfrbHzvBCXMr46nShaGtOXz+X
 fnqNkbFdWOO/fn0FFvpErOGSI3zR2LqeRqLux6auDYkJOnrWMeQcO2vQ+fRPJmOHP5VLm715BZc
 gqhYhFL2qAMVnEByGSU3JES98ekbPqFJxkkRIQ4d9X4kLnnd8XBZw4+lptytO23oCFvYBmaNu/m
 RYUNaNpD6/sTy9iMemEMbznSFdFk22iW4bliBBDB1mGfs3OAyZR2vWlAVTaez0qJUsm+wD09Lin
 ARJOJgcD0uc6kaO7lOacRNLBK1CqmaIMsQ4CgIaTY+xOscPOo65Km/fhLML2sEyfUzAJtooFNE+
 aEXvsdjs19G+ZhVh7P7BIgvzxS6hFZ4NYNuOijfh5wYL/Yc2P
X-Received: by 2002:a05:600c:8218:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499879357cemr96313175e9.1.1786714741638; 
 Fri, 14 Aug 2026 06:39:01 -0700 (PDT)
X-Received: by 2002:a05:600c:8218:b0:499:593b:a15b with SMTP id
 5b1f17b1804b1-499879357cemr96312185e9.1.1786714741198; 
 Fri, 14 Aug 2026 06:39:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49989af26eesm31815315e9.15.2026.08.14.06.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2026 06:39:00 -0700 (PDT)
Message-ID: <9909725f-7dd8-4f88-b016-2a6134906a60@redhat.com>
Date: Fri, 14 Aug 2026 15:38:57 +0200
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
 <878q6m5qox.fsf@pond.sub.org>
 <3099C064-6051-4B93-BE0F-C54B7FD91D82@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <3099C064-6051-4B93-BE0F-C54B7FD91D82@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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

Hi Khushit,

On 8/5/26 8:47 AM, Khushit Shah wrote:
>
>> On 4 Aug 2026, at 12:15 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> !-------------------------------------------------------------------|
>>  CAUTION: External Email
>>
>> |-------------------------------------------------------------------!
>>
>> Khushit Shah <khushit.shah@nutanix.com> writes:
>>
>>> Introduce the 'query-cpu-props-info' QMP command. For CPU model
>>> properties it reports the type (boolean or number) and the set of values
>>> supported under the active accelerator and host.
>>>
>>> For numbers the supported values are expressed as a list of inclusive
>>> {min, max} ranges; for booleans as the list of allowed true/false
>>> values.
>>>
>>> The command and its return types (CpuPropertyType, CpuPropertyInfo and
>>> friends) are defined in qapi/machine.json rather than an Arm-specific
>>> schema, since the concept applies to other targets (e.g. x86, riscv)
>>> too. Target that do not implement it return an error.
>>>
>>> The Arm/KVM implementation spins up a scratch "host" vCPU object,
>>> walks its QOM properties: SYSREG_ ID-register fields become 'number'
>>> properties whose ranges come from arm_field_get_supported_values(),
>>> and the advertised feature toggles become 'boolean' properties.
>>>
>>> Signed-off-by: Khushit Shah <khushit.shah@nutanix.com>
>> This explains what the command does and how it's implemented.  It's
>> silent on the most important aspect: why do we want the command?  What
>> is its intended purpose?
> Will add something like:
>
> This helps the management stack to discover which values are supported
> for a given CPU property. This is especially important for non-boolean
> properties, where knowing that the host has value 'x' does not inherently
> reveal the full range of valid values supported on the host.

How does x86 handle this at the moment, they don't have the cmd either?
How do they currently introspect what are the valid values for a
specific host? Is it easier for them?

Thanks

Eric
>
>
>


