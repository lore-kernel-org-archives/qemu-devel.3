Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5354C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:57:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoTu-0007oY-6f; Wed, 21 Feb 2024 10:25:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rcoN7-0004xl-Fp
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:19:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rck3A-0006NY-9H
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 05:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708512122;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Nsnmg5mi/lerDRFafL3w6XSxkCdhTGMidZW9pcicK2c=;
 b=IYWZOv5X7QjCVbhi+tG4JyE70fLKdr3WwZ2Z1BufQB8/3VAv2sO0XoWk8vxifRV2Pl/esA
 QWQjyW6v5a2H3W6+pinVwKKRzypn2y6/t4Fa+VOCfob/2DqpZx4c0C+ZlVSfxyP/b79rzf
 J7QEu2xJXpHHAErl5lilH4tNNYecoWE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-yj_psGmXNlaGGPlxEcqpeg-1; Wed, 21 Feb 2024 05:42:00 -0500
X-MC-Unique: yj_psGmXNlaGGPlxEcqpeg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33d308b0c76so1735616f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 02:42:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708512120; x=1709116920;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Nsnmg5mi/lerDRFafL3w6XSxkCdhTGMidZW9pcicK2c=;
 b=Nfo6mf+kHoZ88iwl+JabLwiUdtOzYjdbHapE3EbfTUqxQMARgYR6W/h1tK5Wqr8e7O
 nV6DLGljlwhWA7bR44Mpfte/lg/WAyGacoumBGwCrJjY/H6s/EPopXAjKflYJRbWaju7
 WIcNPnXwLQeHWWKNxgbOpF+1G5IPdPkp+uljbAyuhZJ07ZYo8bjMOI5iszhbjmi31FoF
 /ykDSx6y8XVP8x3LkgC7sSE1h90xsOV5Mz9zmEZkvTmcxzs6cujq2bwkVCu+CFH1l0P/
 +jp1jK1rRSIlPs+d+EE6v0fqeZ1R9YH9PJI4C0AA7WVCP1RnudFul3fAoPYA8oRr7+5v
 deug==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOHkK44X/Cu78NP/ZpzEXv4VCy46M9zJSWaCNG+qqaw5X+UoDBc/f1AE/Mw7LqZOlOA2ldeVf9BNn7JLE0baNtP+GF5L0=
X-Gm-Message-State: AOJu0YwzUmH9baEwmOfgzoohCKvXByY6/WKM4dkoPCZYj0Qef0oQvGyP
 0/+Jo3gBPW5tniYzLqcJydoRc0tP+/sK2MrDcS8s1tb1Ic/sTn0Pb0R4jOkxzqqTQ/bEGHrENEf
 wjD3WWuA5bSlr8OulkUhzjn9ISSaH0zmt9zJq0VxK33z+FqQN7RDz
X-Received: by 2002:adf:ff8c:0:b0:33d:251c:78b2 with SMTP id
 j12-20020adfff8c000000b0033d251c78b2mr11514081wrr.28.1708512119869; 
 Wed, 21 Feb 2024 02:41:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFccVb7rN0npvu4Uk+AiVoe2vtq3XI1WnI8yylZ1RarnLjzJ2w8FRRnRpXZElrF5//VXjIMlQ==
X-Received: by 2002:adf:ff8c:0:b0:33d:251c:78b2 with SMTP id
 j12-20020adfff8c000000b0033d251c78b2mr11514063wrr.28.1708512119575; 
 Wed, 21 Feb 2024 02:41:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 bt21-20020a056000081500b0033d1f25b798sm16542591wrb.82.2024.02.21.02.41.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 02:41:59 -0800 (PST)
Message-ID: <8c0f6a91-7ae2-46c6-a8ad-18ca096a6115@redhat.com>
Date: Wed, 21 Feb 2024 11:41:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio-iommu: Use qemu_real_host_page_mask as default
 page_size_mask
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, alex.williamson@redhat.com, clg@redhat.com,
 peter.maydell@linaro.org, Peter Xu <peterx@redhat.com>
References: <20240117132039.332273-1-eric.auger@redhat.com>
 <20240213044312-mutt-send-email-mst@kernel.org>
 <6d4b5766-f8e2-4889-827d-01d3509239f7@redhat.com>
 <20240213060731-mutt-send-email-mst@kernel.org>
 <417ea71e-fb45-4e1d-b8e5-9d54d93dba3b@redhat.com>
 <20240213064017-mutt-send-email-mst@kernel.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240213064017-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/13/24 13:00, Michael S. Tsirkin wrote:
> On Tue, Feb 13, 2024 at 12:24:22PM +0100, Eric Auger wrote:
>> Hi Michael,
>> On 2/13/24 12:09, Michael S. Tsirkin wrote:
>>> On Tue, Feb 13, 2024 at 11:32:13AM +0100, Eric Auger wrote:
>>>> Do you have an other concern?
>>> I also worry a bit about migrating between hosts with different
>>> page sizes. Not with kvm I am guessing but with tcg it does work I think?
>> I have never tried but is it a valid use case? Adding Peter in CC.
>>> Is this just for vfio and vdpa? Can we limit this to these setups
>>> maybe?
>> I am afraid we know the actual use case too later. If the VFIO device is
>> hotplugged we have started working with 4kB granule.
>>
>> The other way is to introduce a min_granule option as done for aw-bits.
>> But it is heavier.
>>
>> Thanks
>>
>> Eric
> Let's say, if you are changing the default then we definitely want
> a way to get the cmpatible behaviour for tcg.
> So the compat machinery should be user-accessible too and documented.

I guess I need to add a new option to guarantee the machine compat.

I was thinking about an enum GranuleMode property taking the following
values, 4KB, 64KB, host
Jean, do you think there is a rationale offering something richer?

Obviously being able to set the exact page_size_mask + host mode would
be better but this does not really fit into any std property type.

Thanks

Eric
>


