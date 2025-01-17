Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F85C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 14:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmz9-0001r1-Tc; Fri, 17 Jan 2025 09:06:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYmz8-0001qN-9F
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 09:06:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tYmz5-00064y-PG
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 09:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737122762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=3/DYc+7yVdObzlMoG4kdXIf7FEyFchXDz5IdKcKY+eA=;
 b=fZQPXr3uKtVQNjgKR8ajZsykLU80qbErv4pxcgcQnK8Xprg/pet3TwcNxsBd8sSrTFACNx
 FIuEyqFFEvrpbvABayQEtTWYUxMsVD2MAe9EfYRHOt0X/oedJvxALPBsPCLBdjxX3IhCmQ
 aom1CpfPj2yFqHdyQBC7+TZ8luYwct8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-7_8J68UAM_CFpqfC1qiAdg-1; Fri, 17 Jan 2025 09:06:00 -0500
X-MC-Unique: 7_8J68UAM_CFpqfC1qiAdg-1
X-Mimecast-MFC-AGG-ID: 7_8J68UAM_CFpqfC1qiAdg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6eeef7cb8so340379085a.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 06:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737122760; x=1737727560;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3/DYc+7yVdObzlMoG4kdXIf7FEyFchXDz5IdKcKY+eA=;
 b=E+bMJxvYn6Mgfo67AVOc0taf70VuimsjV8bpUFD5wqUfUXFmS+hBVRGekNr9oMJrz/
 OqFFuRQGYp2Iy0sKlgIbUB4vlUavUJI+BbboYUS9JB0eRhXTDHjIF9mxwN7XdUTMzmyi
 oS40swYvcUbjFCuoDxpa23rlVMQ+YRJT+bH7A9piSQ9HTe8zmpa68dHaU93QYn09vFLD
 Ua/l+nVczDohaQ2k4nnguRpu6J0/IGQSJzrmeI3d6YE0F7hB1FrQZYNDL5dxWaPDF3C7
 EpgNtZezcBFtTPC4SW1kVZL+4BfpOqZcwO/rXImfmlvp+au+OFdkq5Rcuu69DE+E/cko
 YSJQ==
X-Gm-Message-State: AOJu0YxyFVz5vEdcBRGFKmLEF6OKntqvxflwP1H3OC05sfQv8NE4bA4P
 bwtwLLE4ExrSCHNLQkk4NWfkwHIAUTQQ7jq9MqfZxfqiypcNz49WNAKf66g6RA1j7zymMnX5v6u
 xNhCMhe1OzzCrSnDJ0Pe8EpdBuoLe222Gl9sm9hsMG56/bKoZe7Voet8mgjEN/LDXHm2KlQyoIy
 iyPQUJJj/FQjA78BiY8crpkuyuvBQw/Dm7RRM=
X-Gm-Gg: ASbGncuVwy0oelIUtAwLZ5zwrhhfsbXhvhoYG1wGwpG0JPyac1+cyx2/HRkAjUoBjl2
 TnyKaLywFfVMstzzscyDYsJo3SamAZQc18176IjUKlRjHefSFjkfNCmVqbSspOPfy2EB3HMD8XZ
 9PmCpLjt9ZcYcgtWdXzgvxXpywjtaIFpac9kv2Xw0yT16eoNczg+P/J6mFU4qSrnqaCUBtKdg+O
 oQXnKFprU5RYpjUcpMOozsXbG0po8B2y7/puMDNlAMauzQJqubD5o8LApjK+zngM8nPKj0WCAr8
 7+jIUsfIdsA4Y2t89JA=
X-Received: by 2002:a05:620a:2894:b0:7b6:d611:5d35 with SMTP id
 af79cd13be357-7be63249f09mr402482985a.32.1737122760254; 
 Fri, 17 Jan 2025 06:06:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzgthHyCQuQCs0f990+8+u1trHywbfBBBxFvGEso0mTZon1DD7jg+wduEYvMSa2l/Y8eCajg==
X-Received: by 2002:a05:620a:2894:b0:7b6:d611:5d35 with SMTP id
 af79cd13be357-7be63249f09mr402479785a.32.1737122759886; 
 Fri, 17 Jan 2025 06:05:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61473cb9sm115733185a.11.2025.01.17.06.05.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2025 06:05:59 -0800 (PST)
Message-ID: <fee03f11-bcf5-4586-abc1-2d38ce6a7f9c@redhat.com>
Date: Fri, 17 Jan 2025 15:05:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] net: Fix announce_self with vhost
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, 
 qemu-stable@nongnu.org
References: <20250117111709.970789-1-lvivier@redhat.com>
Content-Language: en-US
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20250117111709.970789-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

CC: qemu-stable and qemu-trivial.

On 17/01/2025 12:17, Laurent Vivier wrote:
> announce_self that sends a RARP packet after migration
> or with announce_self QMP/HMP command doesn't work with
> vhost because of the vnet headers.
> 
> announce_self is the only user of QEMU_NET_PACKET_FLAG_RAW and
> this flag is not correctly managed.
> 
> This series fix a problem with this flag in filter-dump and in
> qemu_deliver_packet_iov().
> 
> Laurent Vivier (2):
>    net: Fix announce_self
>    net/dump: Correctly compute Ethernet packet offset
> 
>   net/dump.c | 3 ++-
>   net/net.c  | 1 +
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 


