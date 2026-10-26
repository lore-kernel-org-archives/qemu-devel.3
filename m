Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D39606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TaxwLPPK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAU-00050B-29; Mon, 26 Oct 2026 09:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xLLAQ-0004yg-Bm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:55:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xLLAO-00006c-Up
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793022911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AYIyUjcnnUXti+/sgQo976EJjdmpRoD/s64kOynFb+I=;
 b=TaxwLPPKLJrDYLNPhLTyHE1iB7y+ocG8v8ecLk9/Ri2wfWvec3lzCHa88OVHQoVdp0GmhQ
 ZppQkD1Vgv1VBcpKVuzDO0HtSGyr/YjHI/SeW61t/xX+Vf3PZXnhHulJnXwZQZ7oTHPotF
 srDFQ1ZMoxZRISpWvqjBnR4R8n2dAu0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-wzgwS9d-Pr66TMeNihazBw-1; Mon, 26 Oct 2026 09:55:09 -0400
X-MC-Unique: wzgwS9d-Pr66TMeNihazBw-1
X-Mimecast-MFC-AGG-ID: wzgwS9d-Pr66TMeNihazBw_1793022908
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a318cd95e8so22407345e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 06:55:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793022908; x=1793627708;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYIyUjcnnUXti+/sgQo976EJjdmpRoD/s64kOynFb+I=;
 b=ZQyKgdsadiI8xwD3XMUGkvdFbokUAO3v/OcZGFNmaJkLHuzXgAZCsKBsVV+UdNrUcj
 tYDJUPE4BuEZyFWzOQj5uAOzVesWjiuTVAHdf22NF/P9Iz/Vl8khJDVOXNcNq9qoIgzC
 VhM51dO96/Oh65jOoNFfgQB5SI7KutXI6ErIjCfEj/W3LKH2PDT48fnhL9MdlyqZ/m2P
 FoEEXkZBtDfmq6N8CAf0LuR6CkK3CRLeA5PhTijTHHV5mjiVK7Zf967S0Dtf6smbjzIP
 dHVDxBSiKPHI3xUDDSyO0YQid4nJZ3L5iFcrNvQn7nyWqGsnAitzB1itfDbBLdKaD8Az
 e15g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFM5XmtWQ74qwpl/C2YKfzdHUUAdENtFtZ4VLXSQ+jMxe2E20I9cdp0Cy0Wm7NT3iCm3rFox7neSt4@nongnu.org
X-Gm-Message-State: AFq9FYLBVteELvKtEac66wWCNI1iUXJp9cqbUiJP8rDuotuRQIzXpPdG
 DGA3eLxxBALTMC7oODHIaYNKOui4UjWevhhSR9jW5vnYumZAV92LxRmz8tLrwqruT9jKGDJ/BuF
 e7C45vg0VbzvtJegihB7AZ+ouwNFtKKUgpZvKTc4/z80QUip0MVVwU8PI
X-Gm-Gg: AYBFou0NjOsKonmvGKm131nC7+yWgT8pnq2246EbKjgAbdxh3xgWKSDaZJ4ZjLUHgcN
 yiFRYob62kiObjtJ4s2Ht3jQGiETIE9TQKO48L5W070g7Fcal6melpex3GZnbTF8T7rQfd5pvy0
 q7ES7IHS0dvJ8G5MBcHOdgGjv/OBNCZJYvLuvxUON282Zd+Rof6kTautBQCbaxxwxrq67nNvMfN
 BhIARylAGQ1gemSKf5hF6ltowI/ajwBxM9UFpbzNG5LX/dbWxa0yy6J5HJGevAk88D4tJ8UMq+O
 WcTPTB6Nf+6JuQSzPAwXM5TkrB6fOyLK14sVPv0mrEBu5YBULIMNroijQ0L+rAcrumqHU8FKEVF
 8cHsWGJP5d8TFT7XsxxfnoqSjmbBkPFArZbBCOxbTnQtZRUAm
X-Received: by 2002:a05:600c:4f05:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a35ae71b30mr145150265e9.5.1793022907661; 
 Mon, 26 Oct 2026 06:55:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f05:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a35ae71b30mr145149665e9.5.1793022907163; 
 Mon, 26 Oct 2026 06:55:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a56992dsm186668015e9.6.2026.10.26.06.55.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 06:55:06 -0700 (PDT)
Message-ID: <71a7a633-b0d1-496b-a4a8-fc887aaad685@redhat.com>
Date: Mon, 26 Oct 2026 14:55:04 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/26] kvm/arm: Introduce a customizable aarch64 KVM
 host model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
References: <20261010133725.642498-1-eric.auger@redhat.com>
 <CAFEAcA9XE0TLxp+DNzFSbkxbj7f0M78N+tf1a01cJ5rNkM7NBA@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9XE0TLxp+DNzFSbkxbj7f0M78N+tf1a01cJ5rNkM7NBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: eric.auger@redhat.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 10/23/26 1:44 PM, Peter Maydell wrote:
> On Sat, 10 Oct 2026 at 14:37, Eric Auger <eric.auger@redhat.com> wrote:
>> This series enhances the current host KVM model with capability to
>> set writable ID reg fields.
>>
>> Since v6.7 kernel, KVM/arm allows the userspace to overwrite the values
>> of a subset of ID regs. The list of writable fields continues to grow.
>> The feature ID range is defined as the AArch64 System register space
>> with op0==3, op1=={0, 1, 3}, CRn==0, CRm=={0-7}, op2=={0-7}.
>>
>> The end goal is to get more flexibility when migrating guests
>> between different host hardware. This series is a prerequisite for
>> aarch64 named vcpu models.
> To help me with review prioritization -- are you hoping this will
> land for 11.2, or are you expecting it to be 12.0 material? (Given
> the softfreeze date is rapidly approaching, it feels to me like
> 12.0 is where it's going to be.)
for the whole series I think this is too late for 11.2. What would be
nice to get in 10.2 is some prerequisite patches like those you reviewed
plus [PATCH v10 16/26] target/arm/kvm: Pass an Error handle to
kvm_arch_init_vcpu which are rather independent. I will prepare a
separate reduced series containing those + fixing the oversight of one
midr conversion.

Thanks

Eric
>
> thanks
> -- PMM
>


