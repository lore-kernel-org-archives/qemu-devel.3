Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E71C88E67
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x61Wg-0005b2-Ex; Mon, 14 Sep 2026 03:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x61Wf-0005an-LV
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:54:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x61We-00045t-5B
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 03:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789372490;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYuLJW4P/YrBVk/hs4Chg8zTHAJI+p8avT4eA1ZbX3E=;
 b=K/Pq8LoDUBD13F60SkSwcp3dve7L/af2PwcT2BuUG7vBAqnESlZdix5KRWukFN4tXo8U1n
 TV8eIfuuNgYdnjRclVu7h79VuLB5WbJJFpxXVF6GkTkAHLmP9mHtOzBFOg8VMWOMWVnvw/
 U87nL3kUBfL75qRLwEWPHBHjYr6TSDs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-9-IqU8n5Pz6adrI-xs6fXw-1; Mon, 14 Sep 2026 03:54:49 -0400
X-MC-Unique: 9-IqU8n5Pz6adrI-xs6fXw-1
X-Mimecast-MFC-AGG-ID: 9-IqU8n5Pz6adrI-xs6fXw_1789372488
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49d156c917cso25186355e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 00:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789372488; x=1789977288;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dYuLJW4P/YrBVk/hs4Chg8zTHAJI+p8avT4eA1ZbX3E=;
 b=EVp3Wt4lBzhGmTL+ZsvuGD/FgV73LraOy+AmObQPSQW2rPML85vPcbarmrTDAdqQzG
 kBcIY1n/FSQZx46jf+9kz5kIQIHzD8Onyy3K9g32Q2Gl/KBzC1b/bFUMK6a02ZdN5LvU
 W0T4hOmwTNyjkT83UrjN9HP3ufxkd2ErmtK+Jpe7LZ1LROyZBNRHTe1oTQFj1EkM74i3
 g9I+n3drCqdvgqlkh0VViyhNXiv9EtZas9RcL2nxqCPzjUQNRVFqUNlQ4csNdGMbAgwH
 w8EifDJAJcRsbc9hidqgl4qK3LxZlk8tDuxHmxax7B8w9GZuC60IvrWg2URwnboTRudp
 mE3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwGrCHHLGTey6uSxKA3erXA8vS5IdTmyUqqYLV/y/o8UbndW2OcVDXp2uWETT4YxNTm0eqgXve14988@nongnu.org
X-Gm-Message-State: AFuF++lTF/t7IxP0e/0EdXIa0DWF9bRKbKj0F99kH05yNdmriqz+SOnP
 uqGWHpeYMBvX9lm/PNi+bqq/Wst8DYQFSz2Zv7GM09a82EZHCYzq0051pHRduKeYdn1tsGOvcho
 xWY2f3eg/nwJcymJ65xllDqp03Z9uvIHUwSwqcdbEyLWwXeBtuECHtA70
X-Gm-Gg: AYBFou31ar9gQzv3AshamsNvz1I3G8Z6phLktgXoqUnQ89+hiacMJMIRXuyBBPZoGsi
 wGw/tkeOgjQzhZY0Ilx+Im3+gbgbcVJQ7rrfjodCSZx34B9EUikwmEfHCEx1QF0ndz8M9wIKRB0
 g2etGDO9aZGI+VNQlyKSo3iiiNq9LaLIFMldb4uSuOXFEhce6oLr0BEWLU0IRr8USrvzgnUVxGh
 vjAB7LE5dFb7cfvwKbTXuckvEQE44dgi9/gSuYbG+AblwFsvU3Cby1dR80pbUZlttyd5OK9qQt5
 KK+jZJh3b5d1Ysic5QyJjiXXGyvNyGvszpo6KmEqRsnXrIwXpeipgTW/h1TVYXT0nDF+r5CiLXt
 ZxFtP7ZEycd2oZCqFtkuWqUXQaom5K/vhnzMjJEo2Qrrq5/eW
X-Received: by 2002:a05:600c:3484:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49e7a6865c1mr15391815e9.15.1789372488008; 
 Mon, 14 Sep 2026 00:54:48 -0700 (PDT)
X-Received: by 2002:a05:600c:3484:b0:49c:f13e:e52 with SMTP id
 5b1f17b1804b1-49e7a6865c1mr15391265e9.15.1789372487661; 
 Mon, 14 Sep 2026 00:54:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6499d57bsm442316115e9.3.2026.09.14.00.54.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 00:54:46 -0700 (PDT)
Message-ID: <7fdbeeb9-3439-49d2-9ad9-33c3379d58c4@redhat.com>
Date: Mon, 14 Sep 2026 09:54:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
 writable reserved fields
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "shaju.abraham@nutanix.com" <shaju.abraham@nutanix.com>,
 "khushit.shah@nutanix.com" <khushit.shah@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "philmd@oss.qualcomm.com" <philmd@oss.qualcomm.com>
Cc: "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260826093747.1670077-1-eric.auger@redhat.com>
 <20260826093747.1670077-16-eric.auger@redhat.com>
 <SJ0PR12MB8614E4CF6C7C81CAE67A018DABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Language: en-US
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <SJ0PR12MB8614E4CF6C7C81CAE67A018DABBE2@SJ0PR12MB8614.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi Shameer,

On 9/11/26 3:50 PM, Shameer Kolothum Thodi wrote:
> Hi Eric,
>
>> -----Original Message-----
>> From: Eric Auger <eric.auger@redhat.com>
>> Sent: 26 August 2026 10:36
>> To: eric.auger.pro@gmail.com; eric.auger@redhat.com; qemu-
>> devel@nongnu.org; qemu-arm@nongnu.org; kvmarm@lists.linux.dev;
>> peter.maydell@linaro.org; shaju.abraham@nutanix.com;
>> khushit.shah@nutanix.com; yangjinqian1@huawei.com;
>> cohuck@redhat.com; richard.henderson@linaro.org; sebott@redhat.com;
>> Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
>> philmd@oss.qualcomm.com
>> Cc: maz@kernel.org; oliver.upton@linux.dev; pbonzini@redhat.com;
>> armbru@redhat.com; berrange@redhat.com; abologna@redhat.com;
>> jdenemar@redhat.com
>> Subject: [RFC PATCH v8 15/20] target/arm/kvm: Ignore and trace unexpected
>> writable reserved fields
>>
>> External email: Use caution opening links or attachments
>>
>>
>> KVM currently reports some bits as writable whereas they are
>> RES0 or RAZ. The code easily allows to do some sanity checking
>> for such inconsistencies. Let's add a trace event when this is
>> encountered and skip the field
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  target/arm/kvm.c        | 8 ++++++++
>>  target/arm/trace-events | 1 +
>>  2 files changed, 9 insertions(+)
>>
>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>> index 2557d7b0d9..8ec9bc51cd 100644
>> --- a/target/arm/kvm.c
>> +++ b/target/arm/kvm.c
>> @@ -433,6 +433,14 @@ decode_idreg_writemap(Object *obj,
>> ARM64SysReg *reg)
>>          }
>>          lower = field->shift;
>>          upper = field->shift + field->length - 1;
>> +
>> +        /* Sanity check the field is not a reserved field */
>> +        if (strstr(field->name, "RES0") || strstr(field->name, "RES1") ||
>> +            strstr(field->name, "RAZ")) {
>> +            trace_unexpected_writable_reserved_field(reg->name, field->name,
>> +                                                     lower, upper);
> This hangs QEMU on my setup, the guest never starts.
> I think, we need to advance map/i: 
>
> +            map &= ~MAKE_64BIT_MASK(lower, field->length);
> +            i = ctz64(map);

Thank you for the report. Corrected in v9

Eric
>
> Thanks,
> Shameer
>


