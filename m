Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE24C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 07:51:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPzBU-0002uv-S7; Fri, 13 Jun 2025 03:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uPzBT-0002ul-PO
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:50:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1uPzBR-0007Lv-8U
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 03:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749801037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bm9s1hPUFF9HM1XXwrCWwqAmDgJ8oNMZ3hcEKSa2NSg=;
 b=PHoc12kpYYvaC/aX00IFkToOmYBv1N5EcGFKJ1gKwIQt4VnWTrU3N8xfsLutzi+CjQTZ+t
 BDmYY16dx8ax1ztMFG0MU+/hSAS7LTh0P4B5sPJ35mmxhgKZYXENR5WxD/GCTcuJaNWi9c
 tCHEqpSxZz+5op3UsTphfMyyL7In4uM=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-tlojIE3NOa6_tfo41QieUg-1; Fri, 13 Jun 2025 03:50:35 -0400
X-MC-Unique: tlojIE3NOa6_tfo41QieUg-1
X-Mimecast-MFC-AGG-ID: tlojIE3NOa6_tfo41QieUg_1749801035
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2362e130be8so19203325ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 00:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749801034; x=1750405834;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bm9s1hPUFF9HM1XXwrCWwqAmDgJ8oNMZ3hcEKSa2NSg=;
 b=qmOA8KmGhJQGRUiA0Jpyxulo33J7DXz7fTuyQRQNEKziWCOJLU9wY0zek82c4wIyFy
 2HFxtJvLa89Dma6CHvA6iS670FEbhUlM3wfGeOt3Z7rO7WH8qvr02ztzVFhXmbu/A2pg
 KP5FewnMQmyeC4dkWxP+sWCNyCA/M9t6Woj8jFD5OUGg7iEcs6S3hceH71CxrWXa7lAX
 iJSYIttffvy/FlYKBBgdNRFuy9MXkhgzlPDfLeAbTDBNBR0T1Y+njtobgrgm5Oy4iXDw
 iHv19aHpDOHuJy9elkHyadyhloXwq7Y/K1SUtj4AUV1IEE8f7kUyGaJs1q2b0pETI63+
 lPYw==
X-Gm-Message-State: AOJu0YwB6Z6DjwAnXL8sJz+4lgQIFgHi5JSnCCQ3lkQRbNMhpBKR/rqp
 btNTdv9PE0xIywZzZCvjmTgrqzRY3T3aTe4rDZlFYFrkeR7/iptVd6mBgMhhGAHg8cJlhiuNbgC
 41yxVAY8igRe+YFI8eWciY5DzZ3nPhKg/Pz4gSRq57ZaGPmWLw89B53VZ
X-Gm-Gg: ASbGncs8v03oJxZMbX7osuY0WOfShhtXY7EdK7xWIyR69n33+Flv7Swcwmypn8HaNh5
 9fWMcTkWog7uGN9N/WCk3ltb4bZQGzMV3TMW48f5GO8Pc2bJ7L/Cz9kv3s9ZdjvNDlUtu6+658H
 roGvwX73tKN6FvBpkAU8IPeGoAOY2sjqCxKiHhL/xTnvehiSCIfRwenYpbx03aLtdBpAjpzFj7H
 jhn0tr77LCauZ5gjOC35vXH2XppdgA184DnNDIP6zDCQ6IPz/dMeCdeW5wtG8q2eflvBqQEpvBC
 Y/nlrPyw1g9XV/y5qfr3H/4djWVilJqb654eHKDH
X-Received: by 2002:a17:903:2a8c:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-2365d8884bcmr33277395ad.2.1749801034596; 
 Fri, 13 Jun 2025 00:50:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKo4ZWCYKZcX44o/w7Whf6Z0E5n/FBwyM+WS6Xks7Fiuvt5HziaOHYoDa0EAiLC3zNJI5WQA==
X-Received: by 2002:a17:903:2a8c:b0:234:d1f2:da31 with SMTP id
 d9443c01a7336-2365d8884bcmr33277095ad.2.1749801034164; 
 Fri, 13 Jun 2025 00:50:34 -0700 (PDT)
Received: from smtpclient.apple ([223.235.162.140])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2365dea8ccbsm8622265ad.167.2025.06.13.00.50.32
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Jun 2025 00:50:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.4\))
Subject: Re: [PATCH] hw/acpi: Fix GPtrArray memory leak in crs_range_merge
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20250613044002.106396-1-lizhijian@fujitsu.com>
Date: Fri, 13 Jun 2025 13:20:19 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 Michael Tsirkin <mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F535BBF-CA62-4F90-BD55-9C37ECF1CDDF@redhat.com>
References: <20250613044002.106396-1-lizhijian@fujitsu.com>
To: Li Zhijian <lizhijian@fujitsu.com>
X-Mailer: Apple Mail (2.3776.700.51.11.4)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
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



> On 13 Jun 2025, at 10:10=E2=80=AFAM, Li Zhijian =
<lizhijian@fujitsu.com> wrote:
>=20
> This leak was detected by the valgrind.
>=20
> The crs_range_merge() function unconditionally allocated a GPtrArray
> 'even when range->len was zero, causing an early return without =
freeing
> the allocated array. This resulted in a memory leak when an empty =
range
> was processed.
>=20
> Fix this by moving the GPtrArray allocation after the empty range =
check,
> ensuring memory is only allocated when actually needed.

Thanks for the fix.

>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/acpi/aml-build.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index f8f93a9f66c8..cf1999880119 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -160,7 +160,7 @@ void crs_replace_with_free_ranges(GPtrArray =
*ranges,
>  */
> static void crs_range_merge(GPtrArray *range)
> {
> -    GPtrArray *tmp =3D =
g_ptr_array_new_with_free_func(crs_range_free);
> +    GPtrArray *tmp;
>     CrsRangeEntry *entry;
>     uint64_t range_base, range_limit;
>     int i;
> @@ -169,6 +169,7 @@ static void crs_range_merge(GPtrArray *range)
>         return;
>     }
>=20
> +    tmp =3D g_ptr_array_new_with_free_func(crs_range_free);
>     g_ptr_array_sort(range, crs_range_compare);
>=20
>     entry =3D g_ptr_array_index(range, 0);
> --=20
> 2.47.0
>=20


