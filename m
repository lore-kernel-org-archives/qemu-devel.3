Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C428CA0EFA
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 08:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqosU-0007nq-Kz; Tue, 26 Aug 2025 04:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1uqosJ-0007n4-QM
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1uqos7-0005J3-K8
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 04:17:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756196253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=otsioMDDDis+4o/eJGjGOmPyrqxlHNYb4cwQxBf4zb4=;
 b=hIJLWGWR7GR8qnQiqNVuMVNwmgokfAqR23CFWSlZUrHnEU3WOuKvnRkSjRUXQZiErexFL4
 QHFqdnZG3mk8wVEl3JjQxw/fm0fUNnn2qZz1SXiOI81mSoxehZfHiyV+GrEzCvjk6dpWR/
 AF7ks1gd6ADKGr/IMFcEBlMY/kdUXV4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RMCC2RTnMQ-cqWBO2YcmUQ-1; Tue, 26 Aug 2025 04:17:30 -0400
X-MC-Unique: RMCC2RTnMQ-cqWBO2YcmUQ-1
X-Mimecast-MFC-AGG-ID: RMCC2RTnMQ-cqWBO2YcmUQ_1756196250
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70d93f579ceso95340326d6.1
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 01:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756196250; x=1756801050;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=otsioMDDDis+4o/eJGjGOmPyrqxlHNYb4cwQxBf4zb4=;
 b=AC9FG5qDBaXHZhPJEtxLKdbjhMtrH+iOV6SgyIesDA6pdKY8kkHHuDf68vBDACjnc/
 N5jGVifsPs34FIpxPLP6eJQv6Ji8lpckHLdnh7Gq5SaQD3Z6KkkwrsDzMw+y6oMzCYhN
 Ee1WJsWSJhs8kXvG9JvT84B05r806x0fzKeKJ9wB7ZgBcsyCjmhlGYpQI+E9dC3CGQK4
 MlNzANqYnKh3gJTl9glAecAwWceuEq5rlt4H/+tDI3IO+4Heg/x3ocO7CfPazgRmEEq7
 lH+UUbCdXADvBw30ulSTqsu1dpeFI6c/G/wwJA4XkSXIKNZjIc4G1UZ34yVklcgZuyKX
 /OKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLBQGuT53WtLa2zWBleXc2lw0ojaea2pmIAIneZd6Tw1pY2ESYEhWVkq+Oz9LSuwE4omew3POWSZRh@nongnu.org
X-Gm-Message-State: AOJu0YwDOyCAa4OWCN8IPOUfyl0ot6Lb/omL9N3cFqU3hSpriwZg0bI0
 gXZFYPn5xcyh8s7MFkoMPd6bi9GXkyIpfOEPpxPQgk6CeZFLztVEPwXAyt35ldyDIU9IgwlgzzT
 SVqKpgYd5Uy7eING5kBkMFkHM1rQQeU15E3GBZ7GCKFJi5dcvvM59vUfA
X-Gm-Gg: ASbGncvL3BhMkb6DVL7zLlOjQIx2ITGDj/a6cSBSEoDnsQditK0LxLH8zgSVlq/YY1s
 Lk8BZeB7d3/7etcC85Np6WlRi0AzmIcJO5Zh37qL5JRB31MCNK0MmMsLRf1yDm3aXpgm9Ghv8k/
 GM7GpTe0UvFlgjqGX232Br4D9QaWKRrlwAWpWDBM9S1XjK6V0nTjXNvBW1ALc5VqM80Y6R+h/Oc
 sD5OVAMtBcz0a74q+Fn1kXXvMYyg/i4fYF/mOM76MTcsY+MNSBsmtzVIP9gG7cEa2X9xPpPYuvY
 NUui1GcfYGSRnUv9v8oEcqeREwjhprknBuu6qBw=
X-Received: by 2002:a05:6214:e81:b0:709:eddb:d1d4 with SMTP id
 6a1803df08f44-70d971f6a61mr191867226d6.2.1756196250285; 
 Tue, 26 Aug 2025 01:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1/dwDwvT99sdugEh9RL8Dlt04TXKclv+cwzMW3B/UX1+oQOrpzkhZaKP4YQDE99/6G32uuQ==
X-Received: by 2002:a05:6214:e81:b0:709:eddb:d1d4 with SMTP id
 6a1803df08f44-70d971f6a61mr191867086d6.2.1756196249902; 
 Tue, 26 Aug 2025 01:17:29 -0700 (PDT)
Received: from [10.43.3.236] ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70da728584dsm60638836d6.37.2025.08.26.01.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Aug 2025 01:17:28 -0700 (PDT)
Message-ID: <5af5b42a-c3af-4c4f-8cdd-139bced29613@redhat.com>
Date: Tue, 26 Aug 2025 10:17:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] qga: Fix --retry-path behaviour
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Jan Tomko <jtomko@redhat.com>,
 Yan Vugenfirer <yvugenfi@redhat.com>
References: <20250825140549.146617-1-kkostiuk@redhat.com>
Content-Language: en-US
From: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
In-Reply-To: <20250825140549.146617-1-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/25/25 16:05, Kostiantyn Kostiuk wrote:
> 
> 
> Kostiantyn Kostiuk (2):
>   qga: Fix channel initialization check in run_agent_once
>   qga: ignore channel_init() fail if 'retry_path' is set
> 
>  qga/main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Michal Privoznik <mprivozn@redhat.com>

Michal


