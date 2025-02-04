Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F5AC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 10:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfFl6-0002VC-4q; Tue, 04 Feb 2025 05:02:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfFkr-0002UF-4K
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:02:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tfFko-0008DK-9s
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 05:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738663321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Gufh9BgMW7zzImGAMMh/3KSW8DeCQPp3pwQV52D97ec=;
 b=cxPhyIukPCUzLAA6N5hQOLIR5Alj0GBsNS2y8T9dsq0ZH3JCR8UylT46ccnzkXRUwMHO1v
 /ih62UDZKtSjImI0GXyCfelEO852e07/fjfj4M56MWuqPiubg4krrZtFdb7su0/5XoV+Kg
 +vByhnbvURzAYAH3tXmbkLnVLu0HduU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-0NLFGUdHPbKRbDnRsslXVw-1; Tue, 04 Feb 2025 05:01:58 -0500
X-MC-Unique: 0NLFGUdHPbKRbDnRsslXVw-1
X-Mimecast-MFC-AGG-ID: 0NLFGUdHPbKRbDnRsslXVw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so37885155e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 02:01:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738663318; x=1739268118;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Gufh9BgMW7zzImGAMMh/3KSW8DeCQPp3pwQV52D97ec=;
 b=m90os58C8Dt0ARnOe7tqKfWYEkqpDlAWTPQdNPsOrTjU/BXcVoHLCCHY60YTX35aMb
 IGHnIkdZbKwbUPxjvXcTrVg4RhJ9aoDuRw1p2UtxHDJydgjGc6jhN+zURvU+BH658Mbd
 8T6An7xjvpmUzmD5BPVmrwiRWuq0vTTmy6rbmb76qUZxGUaUQLUl98WCfMkM/rcYKuxR
 Ur1nsCPGwdVVrp3L5P6gGjTOA53MpQhLHW5PKnX5eIU2T802gBFeRHudki1iY4VhjWWi
 mW1vEBfBmAkpuwFmjQoNNngC+fWc3mSpkv1ay4KpqoykUm+OFDLD0HQIg9Lf3rc3YMYp
 wSWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXRoP7bL0JWxB13hAccZrhswiMu5KYGGT88xTyPsUPPfgAHGUqyQPgu1sexlgIz7j9m5PQHC+SXERt@nongnu.org
X-Gm-Message-State: AOJu0Ywkc0palEabEbx7EZpNqQkvrYIhKoIYWsp/aKAduo2n0PNLhd1x
 /pZy+pWdWrKCazaeqchMmJp0sTxpzz9HCrNxzziVJMf8XIua0XKvuKEB1xR9MY2pn3fTdbf3rjJ
 cylPjfFMWm9z5Oeyol+lZ1DH48J3UZU2Ef/Q/fg3Fp8ZdopzQCdAM
X-Gm-Gg: ASbGnctA8nbvR1CZ4U+OEg7Onuir4nokjfU2z73E6PYxCiDsqYR4Ln275q168RhaZ+T
 k7lc5Xxh0FVu9pFZHvcKKmZTWFMM45oVpeoUwlY6Qes1xZEHUH+IYvpgMshSkQqOyYdVoIy0ieC
 BshWnqL/CN6sy9l0cZ5/NAzioEIocK7dLJnSox/07W1liyhxrMhgYaxlq9GTJfHOcYavN5+VEt8
 ByhhqqSb+CzqKVrKtUjrGIfyVUc/YwnTzU/zu5RmI3s9k8KFPntQtOZTIX1/aIYIO7kYwoDDTs5
 uxuvatakEfQn88JNRfZT2QDTnwviEvw0yDfL/H5fBxLRGjqBLRPZtl23HCWBCnaso4wtihHAXwy
 CDZFbxp6anm8Sv/EGChEaN1i4JP8=
X-Received: by 2002:a05:600c:4f55:b0:434:a746:9c82 with SMTP id
 5b1f17b1804b1-438dc3aa6c4mr242310885e9.5.1738663317719; 
 Tue, 04 Feb 2025 02:01:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0qmWN8ZZSM7ZDRgOYeag/ADHFJYXgjua1gN1m7OpPujUqnmAQys8+h7pkV0jYuTBJIt6VHA==
X-Received: by 2002:a05:600c:4f55:b0:434:a746:9c82 with SMTP id
 5b1f17b1804b1-438dc3aa6c4mr242310655e9.5.1738663317357; 
 Tue, 04 Feb 2025 02:01:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c70a:300:3ae1:c3c0:cef:8413?
 (p200300cbc70a03003ae1c3c00cef8413.dip0.t-ipconnect.de.
 [2003:cb:c70a:300:3ae1:c3c0:cef:8413])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de772sm182796375e9.13.2025.02.04.02.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 02:01:56 -0800 (PST)
Message-ID: <03289d6a-97b6-40da-bd64-9a7175957e1c@redhat.com>
Date: Tue, 4 Feb 2025 11:01:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/virtio: reset virtio balloon stats on machine reset
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>
References: <20250204094202.2183262-1-berrange@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250204094202.2183262-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04.02.25 10:42, Daniel P. Berrangé wrote:
> When a machine is first booted, all virtio balloon stats are initialized
> to their default value -1 (18446744073709551615 when represented as
> unsigned).
> 
> They remain that way while the firmware is loading, and early phase of
> guest OS boot, until the virtio-balloon driver is activated. Thereafter
> the reported stats reflect the guest OS activity.
> 
> When a machine reset is performed, however, the virtio-balloon stats are
> left unchanged by QEMU, despite the guest OS no longer updating them,
> nor indeed even still existing.
> 
> IOW, the mgmt app keeps getting stale stats until the guest OS starts
> once more and loads the virtio-balloon driver (if ever). At that point
> the app will see a discontinuity in the reported values as they sudden
> jump from the stale value to the new value. This jump is indigituishable
> from a valid data update.
> 
> While there is an "last-updated" field to report on the freshness of
> the stats, that does not unambiguously tell the mgmt app whether the
> stats are still conceptually relevant to the current running workload.
> 
> It is more conceptually useful to reset the stats to their default
> values on machine reset, given that the previous guest workload the
> stats reflect no longer exists. The mgmt app can now clearly identify
> that there are is no stats information available from the current
> executing workload.
> 
> The 'last-updated' time is also reset back to 0.
> 
> IOW, on every machine reset, the virtio stats are in the same clean
> state they were when the macine first powered on.
> 
> A functional test is added to validate this behaviour with a real
> world guest OS.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


