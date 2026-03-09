Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD160FCA16A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzf0L-0004O2-Lt; Mon, 09 Mar 2026 14:07:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzezz-0003vH-2T
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vzezw-0006g7-9F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773079591;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f/alvkQgr1baGbx0ARaryDIBCWnm7KJLZWRPA88ESYY=;
 b=ip9vvP8WQnA7Ef65kvsNk/jJjDnsK02xuh9D+8+8QV7kdjDiGTO4FDqEwwA6kVCyAhtVQC
 oArhFEStPAz8YoDWUpw8TrVWNw4x9Hyw6GPCBNt37NoXGPWa3GLr7WjQ5e/Ry1bR82YMXd
 VwAxeyZaYZDX7qOaIzjuYqtAp/stqxQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-QMIQ2ZGdM9uHXdnltAboHg-1; Mon, 09 Mar 2026 14:06:30 -0400
X-MC-Unique: QMIQ2ZGdM9uHXdnltAboHg-1
X-Mimecast-MFC-AGG-ID: QMIQ2ZGdM9uHXdnltAboHg_1773079589
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439a9182148so6332391f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:06:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773079589; x=1773684389;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f/alvkQgr1baGbx0ARaryDIBCWnm7KJLZWRPA88ESYY=;
 b=K0R058UWUnKoZFDW1XSCkPSGYre2uKyD5DsY+98Iw+1KXPYqIwAL0bXdNatfj9X2it
 AIgOlZ1QjB6rC38tWX84wkBjkYWnDP7d/vyIvlFhnEwTB5ufwT2WFvn0vQ4ay2zLb79o
 R6VAo8dbubL6Z0Q9mVT9cWNooHH9yk7hlWsWG+UyfZeWQ9EzPUzcKFm6EAGsvgrusXVU
 glw68QDBq/94JEoRCELnAP0oPIe7QzbJXOOQGd3iKOh4tFHivJh7GIxQuZ5mij9cnjPk
 GtpeOAJUUy6JgeY0q373Wpq58h5JpduG79oWxd5xI7jixLbx0/7MBZ/9p9RcmnIPIfIh
 SVmw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuOjdLpV67fM1rnrUqmXSI/AuTWKIxAkVdRzlDG6KwbfW5GbQiTjo1JTGB98L8wxf4CgrKZGi4y68N@nongnu.org
X-Gm-Message-State: AOJu0YxbZITG6pQmo8JCkhF/ySzWhPzDWNdE12+r3zBXjkxvdBgK9733
 7WACRJZPJOXjAqt5oLMAxVFpALhyNT7jApjhbQS+hZ/omH0kETE1zqeaoPeydwIz+/jUdAMJZSu
 0VAReyh5uR7iUgD/oGHhwx940ulHGQPqt0q0dlyBXS08Uz80OPoobnO72
X-Gm-Gg: ATEYQzzaLv76pUQ9USQa+0UFkckiAbT7hM+/vYQ3lc+IpFvA0yolaebaCG1a8Advfhx
 tBGZOsKv5KmURHb0z3m9VUiB8bm9gDM3p+IQnrvNDKYMkvn4SROvRrWAhrvkmDLxD9pGfIe99m8
 5Hod60sc7TNDwQUfgnupYoOEiJWqFLpCCiSMNZVRP3NmIJSCdM4d1BCJfdOi2a4YWIJz3FGRwgK
 7mmRDoqXxfgy0Sjbr3kiXQqbknU4DwJgkUTKf4sVBPJKTQyuTqGQ5Hb+NW5jzq+Vj/vwizuYbZE
 xOq6PwZbzbvYcWkyYQ82y+tJq2TCKZwVqAISYBxDJLzpuDUXqw0Eo8fO7D6yq1xD3YFry5zqL6s
 eiOfxPtAMa7RevI9yyXFoH2qZgxXzCl0Y3YNNjYQXv1JUM8+3afBCURbsWk0Dfnz5PnT0aw==
X-Received: by 2002:a05:6000:2404:b0:439:abcd:b312 with SMTP id
 ffacd0b85a97d-439da64f787mr21908518f8f.7.1773079588788; 
 Mon, 09 Mar 2026 11:06:28 -0700 (PDT)
X-Received: by 2002:a05:6000:2404:b0:439:abcd:b312 with SMTP id
 ffacd0b85a97d-439da64f787mr21908447f8f.7.1773079588326; 
 Mon, 09 Mar 2026 11:06:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm31525004f8f.32.2026.03.09.11.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 11:06:27 -0700 (PDT)
Message-ID: <16b4f960-61a2-4e30-af2f-a4267ebc425a@redhat.com>
Date: Mon, 9 Mar 2026 19:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/32] tests/qtest/bios-tables-test: Prepare for IORT
 SMMUv3 node identifier change
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, jonathan.cameron@huawei.com, zhangfei.gao@linaro.org,
 zhenzhong.duan@intel.com, kjaju@nvidia.com, phrdina@redhat.com
References: <20260226105056.897-1-skolothumtho@nvidia.com>
 <20260226105056.897-28-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260226105056.897-28-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



On 2/26/26 11:50 AM, Shameer Kolothum wrote:
> The IORT SMMUv3 node Identifier field will be derived from a new
> per-device "identifier" property instead of relying on enumeration
> order.
>
> Add the affected IORT blobs to allowed-diff list for bios-table tests.
>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..df5fe417c0 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,5 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/IORT.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.msi_gicv2m",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-legacy",
> +"tests/data/acpi/aarch64/virt/IORT.smmuv3-dev",


