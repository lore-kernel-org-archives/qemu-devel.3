Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96678C021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 08:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmTiZ-00077C-Tm; Mon, 24 Feb 2025 03:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tmTiW-00076v-Bo
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:21:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tmTiT-0000ve-MD
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 03:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740385287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PuMA/hT3qsBQKcqee9ZSWczKhyJ790uukn/WlIpfkNo=;
 b=FIRUlScMB1fiGmlDnpPXvP3MPWVDmVTjU6q4bVbLxsqlj5b/cX4243H5cOTGcl6Sio1dZY
 daDDPOPbp2MOyMWMxc8mHJ64VyBjodgTN0SueET95VWGJVTXCDB4xQiYokbBQBE0x5ueYT
 Lshq4ddjbUoGDYUB31KRo+lty4MF/zQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-lkjW6UBAPQ6H6NpwNID3QA-1; Mon, 24 Feb 2025 03:21:25 -0500
X-MC-Unique: lkjW6UBAPQ6H6NpwNID3QA-1
X-Mimecast-MFC-AGG-ID: lkjW6UBAPQ6H6NpwNID3QA_1740385284
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso31730555e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 00:21:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740385284; x=1740990084;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PuMA/hT3qsBQKcqee9ZSWczKhyJ790uukn/WlIpfkNo=;
 b=DX13zPcpdr8le7hCB7uWScJhQ5VUxzt+rR/mvVwYAlG8FWFXupoZxzSmoYk9f5Ihau
 Pc85R8siWM5pvJwx7YIT4F+I6oJ82wswkn4qKz52sEl8e8j6CklnuOEnXiWkEFbZVvp4
 ml1h8+8nmlT9YiWBRgAyFKP+95lwMBh/6rHUhV81PAkEjlU0mr/fxv1+b3nhPNXp2LjU
 H9Z0X3fqtJg6naIbbbhdDW5J4a5jZL2BUQq9mEYn8QtSF9yab7eavMH6vvEgLNaVU93s
 0cq04fbuET541YWNtvaUYPu0oSBW362bIR9bytJ5m1BWUmYfo3wcRuY7gRrDfKL79fWg
 uJSA==
X-Gm-Message-State: AOJu0YxN6ivHZkWwiZqpOKxrDG6Hcc4JKp1AfklsOLwZGoE1CTgOoHjB
 3naIkcbBF0DIdRshP5zd6MAZxXQ/h54TKYtI3znR+/FR7NIocB0DnS5vdlV2R5VT3uvnznX5Qgd
 rSCyTvu3phE57PoLP8WKIM8fsXwtsG9151WKBGRQsyge3hMWx5Gky
X-Gm-Gg: ASbGncucouw5J8dBvhK5dS6PmDtKhf16zWbA425OOrJlbqmiu+VEnkX/Hh9HznYGBba
 fWYFMU5yy0o8WZbbZ0dPU1kKeuP90/qNrCYRrZ/16+GYYJDbQJgLfz+xjNC99PAe1ov8UOtJQBb
 Iw+6hQhNLXnXbiYYny0Gxaf66LcRmWcg1NfDjl2u8Z+d5XsSYu+yLmSQHlMLCjZZSadrxYaBlgs
 IShSWEQTltAntlVf146q3oGBiU1aN8vUXfqQDhq95hMXVurK7KUAYmfJHjow7RUQ72rBFHAD4Tn
 JUG46NBOnHY1m+IFG5H8TYOJksY8nKZV4QuvcxkS09vrGaSffv5Guw==
X-Received: by 2002:a05:600c:1c25:b0:439:86fb:7325 with SMTP id
 5b1f17b1804b1-439ae223e66mr114635835e9.31.1740385284305; 
 Mon, 24 Feb 2025 00:21:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKtDed2upfG2zPNtj8QfX29FTBH3CsUwy3O0Y+Pd3lU7J1g0w6ptrHXkrWeJ/XcXjcGs/hfw==
X-Received: by 2002:a05:600c:1c25:b0:439:86fb:7325 with SMTP id
 5b1f17b1804b1-439ae223e66mr114635475e9.31.1740385283917; 
 Mon, 24 Feb 2025 00:21:23 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce336sm99923455e9.2.2025.02.24.00.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 00:21:23 -0800 (PST)
Message-ID: <44421da6-fcec-477c-bacd-2464cd4bfaf5@redhat.com>
Date: Mon, 24 Feb 2025 09:21:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] PCI: Implement basic PCI PM capability backing
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, eric.auger.pro@gmail.com, eric.auger@redhat.com,
 zhenzhong.duan@intel.com, marcel.apfelbaum@gmail.com
References: <20250220224918.2520417-1-alex.williamson@redhat.com>
 <20250220175420-mutt-send-email-mst@kernel.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250220175420-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/20/25 23:54, Michael S. Tsirkin wrote:
> On Thu, Feb 20, 2025 at 03:48:53PM -0700, Alex Williamson wrote:
>> Eric recently identified an issue[1] where during graceful shutdown
>> of a VM in a vIOMMU configuration, the guest driver places the device
>> into the D3 power state, the vIOMMU is then disabled, triggering an
>> AddressSpace update.  The device BARs are still mapped into the AS,
>> but the vfio host driver refuses to DMA map the MMIO space due to the
>> device power state.
>>
>> The proposed solution in [1] was to skip mappings based on the
>> device power state.  Here we take a different approach.  The PCI spec
>> defines that devices in D1/2/3 power state should respond only to
>> configuration and message requests and all other requests should be
>> handled as an Unsupported Request.  In other words, the memory and
>> IO BARs are not accessible except when the device is in the D0 power
>> state.
>>
>> To emulate this behavior, we can factor the device power state into
>> the mapping state of the device BARs.  Therefore the BAR is marked
>> as unmapped if either the respective command register enable bit is
>> clear or the device is not in the D0 power state.
>>
>> In order to implement this, the PowerState field of the PMCSR
>> register becomes writable, which allows the device to appear in
>> lower power states.  This also therefore implements D3 support
>> (insofar as the BAR behavior) for all devices implementing the PM
>> capability.  The PCI spec requires D3 support.
>>
>> An aspect that needs attention here is whether this change in the
>> wmask and PMCSR bits becomes a problem for migration, and how we
>> might solve it.  For a guest migrating old->new, the device would
>> always be in the D0 power state, but the register becomes writable.
>> In the opposite direction, is it possible that a device could
>> migrate in a low power state and be stuck there since the bits are
>> read-only in old QEMU?  Do we need an option for this behavior and a
>> machine state bump, or are there alternatives?
>>
>> Thanks,
>> Alex
>>
>> [1]https://lore.kernel.org/all/20250219175941.135390-1-eric.auger@redhat.com/
> 
> 
> PCI bits:
> 
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> 
> feel free to merge.

Applied to vfio-next.

Thanks,

C.




