Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63153CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbwYe-0001gD-HF; Tue, 23 Jun 2026 04:32:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wbwYQ-0001f1-P7
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wbwYN-0001g5-BJ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 04:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782203536;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VXcYChGDCgCZU0HD3bk3aBjI+qRlzASUENGEs3N9t1o=;
 b=gzsOV7x8zx442uADxa+5A2zL3Gfz6pj/7fVe0PmzNGXh8jpwV/GPuNnMSQ9zdipMgFBqVc
 FqJrMhlLDWB0b4Lh11vB19wuL8ZKTAZdQ+zSivqLFEVPC7sm8c6ONhiSBjylvMsrU4njeH
 qbsjasq0twIg8HX2xiSDrc0RUlWpwTM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-Nkxrh2MZNAKewn9KUy6cHg-1; Tue, 23 Jun 2026 04:32:12 -0400
X-MC-Unique: Nkxrh2MZNAKewn9KUy6cHg-1
X-Mimecast-MFC-AGG-ID: Nkxrh2MZNAKewn9KUy6cHg_1782203531
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46315372c3eso4771297f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 01:32:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782203531; x=1782808331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VXcYChGDCgCZU0HD3bk3aBjI+qRlzASUENGEs3N9t1o=;
 b=C219C2ZFKXL2x8m4kvQd5/E/3d+HCJEcVFrIxseklMiC1VMZPc7QWx23XzkIDuMlQN
 SYyTd+SoNV80yxeMWzH+vj5v0OtlUZjYtDQ9ubl6pzMDGryv0VkYDn3FwViNVL1Fh6b/
 YMjcKWa1Mgt42QljpXVIo2IX/yyPf2YI9EFbyNOTXO/4m6E44AWLqTSgK1SiiZ3XhmAz
 +DwKttJpqw3fY358CcErzdMQ2Dx6EF1E6SYsyeXbyp609MW9PnTQGyIXEzPkb1UG95NL
 MjL4DCuopQxr+J0LT5ez278FUM6bSceoV/LulHQfAUZEP69QQlOIhoMTVTSKzZxkugGH
 JMqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrIj4Ci331rCbzersD+7+Lm1QQnLnI22KaXCO0RyBwXirtSHYUDEkm3UOLR8oYyGqlk9ybIq0Tw6VMN@nongnu.org
X-Gm-Message-State: AOJu0YxJSLaIXoQyvVMarczhhTtHMJKoWIX6Q1sIN1IFR1iU8utYwDrY
 oIdc1soLjPb1KK9IFWaUggNdWF3wblMaQnK9qz/2oMzF66LgK7Ra+Dgs1g/F+feyfgn5fHLOYlW
 MBdujmhHJbXUs0TB+zd8fyHpgxiz8Tf8GDofkEpnmJrYsa1o5vQJm8yTr
X-Gm-Gg: AfdE7cnQSmcmAXVHjtQ+/NI1NRbCrIAQtS28mHo1h1i2IPkhAzbt9f84E8PhLMjRnCn
 1JSl9W1e76hfx//v6/nbwswWKsDtnSZu2RGDFBQxnwTQIExpuRZCH0XRixzesCQsVAhgdzMoYVU
 78KVIMYYyTHb508t6yJwY9RfenFSgppNfhyf8IUCTPEPFcD/hl9aGLdVa9kO/ejhJtqAO5PwNfF
 hlr6tU/PJjSMKfNEraDiuNxB0nqaYj9U9YYkJG/FTFWjpZGucHZ8X3xq6+xmiLBfVBofDsLHOk2
 kXnRPpZDldRYcDk9Siu2HlVPoXSC+OUGVRMSjINQk4gH4ZWonlsXg9SamjUDHG+Cco0Rac/w1uR
 tqxoA9DSBIE3J4x+JpJJy47sj1jDEA1BYczXFuI/7pf0Ojomd6EWE8zGaP78=
X-Received: by 2002:a05:6000:101:b0:460:2eee:4e2b with SMTP id
 ffacd0b85a97d-46508afacb8mr26703340f8f.28.1782203530917; 
 Tue, 23 Jun 2026 01:32:10 -0700 (PDT)
X-Received: by 2002:a05:6000:101:b0:460:2eee:4e2b with SMTP id
 ffacd0b85a97d-46508afacb8mr26703294f8f.28.1782203530496; 
 Tue, 23 Jun 2026 01:32:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466648c4fd2sm33098696f8f.14.2026.06.23.01.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2026 01:32:09 -0700 (PDT)
Message-ID: <1105dfee-f1bc-4ba0-b8b7-0382c95463c2@redhat.com>
Date: Tue, 23 Jun 2026 10:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/smmuv3-accel: Fix veventq read returning true on
 EAGAIN/EINTR
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, nicolinc@nvidia.com, nathanc@nvidia.com,
 mochs@nvidia.com, jan@nvidia.com
References: <20260623075101.17770-1-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260623075101.17770-1-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/23/26 9:51 AM, Shameer Kolothum wrote:
> smmuv3_accel_event_read_validate() returns true for EAGAIN/EINTR, but
> no data has been read into the buffer. Callers treat true as success and
> proceed to use the uninitialized buffer. Return false instead and guard
> warn_report_err_once() against NULL Error in both callers.
>
> Resolves: Coverity CID 1660057
> Fixes: d4aea0f75b ("hw/arm/smmuv3-accel: Introduce common helper for veventq read")
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c   | 6 ++++--
>  hw/arm/tegra241-cmdqv.c | 4 +++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 80900c2521..6d402d2ba6 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -451,7 +451,7 @@ bool smmuv3_accel_event_read_validate(IOMMUFDVeventq *veventq, uint32_t type,
>      bytes = read(veventq->veventq_fd, buf, size);
>      if (bytes <= 0) {
>          if (errno == EAGAIN || errno == EINTR) {
> -            return true;
> +            return false;
>          }
>          error_setg(errp, "vEVENTQ(type %u id %u): read failed (%m)", type, id);
>          return false;
> @@ -491,7 +491,9 @@ static void smmuv3_accel_event_read(void *opaque)
>      if (!smmuv3_accel_event_read_validate(veventq,
>                                            IOMMU_VEVENTQ_TYPE_ARM_SMMUV3, &buf,
>                                            sizeof(buf), &local_err)) {
> -        warn_report_err_once(local_err);
> +        if (local_err) {
> +            warn_report_err_once(local_err);
> +        }
>          return;
>      }
>      smmuv3_propagate_event(s, (Evt *)&buf.vevent);
> diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
> index 29c488e0e4..bb0b417e90 100644
> --- a/hw/arm/tegra241-cmdqv.c
> +++ b/hw/arm/tegra241-cmdqv.c
> @@ -845,7 +845,9 @@ static void tegra241_cmdqv_event_read(void *opaque)
>      if (!smmuv3_accel_event_read_validate(veventq,
>                                            IOMMU_VEVENTQ_TYPE_TEGRA241_CMDQV,
>                                            &buf, sizeof(buf), &local_err)) {
> -        warn_report_err_once(local_err);
> +        if (local_err) {
This is not aligned with the general policy. If a function taking an
error handle fails (and returns false), it should set errp.
Don't you have a way to initialize buf in smmuv3_accel_event_read() and
only call smmuv3_propagate_event() if the hdr of vevnt is checked valid?

Thanks

Eric
> +            warn_report_err_once(local_err);
> +        }
>          return;
>      }
>  


