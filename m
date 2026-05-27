Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E58CCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGhG-0003eA-Tf; Wed, 27 May 2026 12:01:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGhF-0003cF-3w
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:01:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wSGhC-0005V3-Va
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779897686;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RiPe4Prk+kzBu6QwStAHXAFHar9zGaaOXhVcZMTjvIk=;
 b=Qq3V/ZPGYSjBgl3tMZSG/dlS3fxEKQ/jIgg/UUQv5gRywT+0IxwBc79DayEC5jOtT2tRLQ
 dLBlEf3LQlDTiM/ssPk6LgxhrvV+kvBTEggHyB8qZeCmlokC6itwkc1mNSg+6dWzHsl+F+
 nXp5T4ye5PCaFHjwCw1NznyF8o8Tqqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-YlTu7y0WOqajhEpUMIRgJw-1; Wed, 27 May 2026 12:01:21 -0400
X-MC-Unique: YlTu7y0WOqajhEpUMIRgJw-1
X-Mimecast-MFC-AGG-ID: YlTu7y0WOqajhEpUMIRgJw_1779897680
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4905428aad6so38682405e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:01:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779897680; x=1780502480;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RiPe4Prk+kzBu6QwStAHXAFHar9zGaaOXhVcZMTjvIk=;
 b=VLKekhzQrft0YdU/Cr9rQzTnX21EIKR4x0F4qSPw+bao0nO8ySM/g/4kBcFc9Xftog
 zORZd7idlcZEXkwxDEV6yK5It6m410GpEpPKiqWxm60WxxfaMRxiHMmqlba6xAQTFi7e
 8bwHLEoxRoRrRwW0OqvQy4sDPPRyEtEKitj22oZ/9bDe0COohTtxBFY/gFwdnjsApYy3
 amyANLjfaIijHHvWTULTFyQuiFm4qfh0824cnQk5TT9Rupqy7fY66WQ/erv0dZo4cb0S
 9httieEDVFA0Ijx8joNI1k5Zr0r1VpoVLTdm1PuD7RFO6PMEdrnA22WkPXI7XXOkWEi7
 0OfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XE5rlBM0ydPpqFFdp9rmvZQMUgbU4Eu9JqQ++TNPUpZgC2/5V+/9SxmYfWhQGcoQdlNXGgMHLt/in@nongnu.org
X-Gm-Message-State: AOJu0YyUwFrpJbne/7zsVBAllUGkGWtHpJMYQVPZ0MqUp+XwXjpSh1MP
 f6CFbaRzapqSxT/zE9Q8GlANGulobLqpetyecNolwusE8TvbdmEOVALnr6nZoAgYJSlSeU61sko
 5Y3EUuaQ0tmNXHEXCcnU5ICuL5j4fnQhGJVZxLr+8VXQBt8z6GWHZTjr8
X-Gm-Gg: Acq92OHMbaNONR++PdK2YNgtd/4QpAHBYHeSA/JwoKVU9e34QvjF0DlsbVf/AOMDHFC
 DMQa1L0asntQiRanTk2GaNcF7SohxcEQSYPgsZpwLBliIU2ifZf+9mJZm9N5eOWb3n058TWso3h
 dlJSK184CROPI6vPlCOEELKJhOGYS3CWsYrq+SDnvbiMWWv+2MML7puLEdhcvhJ2envwz8RiMxb
 ZBgnxt+pmw7MgNUUgLRM1llt4xinw7A7IB0UiNKCZnz/baMour34ddvTttCngZonBffOIlASKI/
 BBW593nspQdEhT56RFl4LbT1mMrJp1YN4pIbkaPRM85nGjpKDpifeKI5NdnUSwN/SArtTGzLE4W
 lJUjIsYBnVYTWY58HtTKwJFqDfDbWXfAD2IfTkPNnzXJ1rN0enkcL63Qm3KRtBcVr7zclxA==
X-Received: by 2002:a05:600c:3b02:b0:48f:d1c0:5cd3 with SMTP id
 5b1f17b1804b1-490424b3189mr405188615e9.13.1779897680092; 
 Wed, 27 May 2026 09:01:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3b02:b0:48f:d1c0:5cd3 with SMTP id
 5b1f17b1804b1-490424b3189mr405187915e9.13.1779897679614; 
 Wed, 27 May 2026 09:01:19 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm601871475e9.7.2026.05.27.09.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:01:18 -0700 (PDT)
Message-ID: <72f22825-d810-4fa1-8fc5-123ae06af91e@redhat.com>
Date: Wed, 27 May 2026 18:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] target/arm/kvm: Ignore some writable bits that
 shouldn't be
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "philmd@linaro.org" <philmd@linaro.org>, "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-16-eric.auger@redhat.com>
 <E5402D74-AE00-4088-801C-C87A749E17C9@nutanix.com>
 <80fa5157-2376-4010-88b2-deb6ab50f87f@redhat.com>
 <6CA1EBCE-BA44-42A1-81D3-1A723C6F0CC3@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6CA1EBCE-BA44-42A1-81D3-1A723C6F0CC3@nutanix.com>
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



On 5/27/26 5:54 PM, Khushit Shah wrote:
>
>> On 27 May 2026, at 9:15 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> What would it change anyway, if we detect we have a writable field
>> matching a RESx field, I guess we would continue raising a warning, no?
> At-least for named models we want values for each bit in 
> ID register.
but if a field is RESx why don't you want to overwrite it? Are there
cases where a field is RESx depending on a condition?

Thanks

Eric
>
> Warm Regards,
> Khushit


