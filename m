Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C89AC3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 13:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE6bK-0004to-1x; Sun, 11 May 2025 09:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6bH-0004rp-MJ
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:20:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uE6bF-00089V-V3
 for qemu-devel@nongnu.org; Sun, 11 May 2025 09:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746969613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DQgsqkTOIyZhN/qlgqF78+C8tcllmzO5ZDG7Hijf0JM=;
 b=ASPn4WoB/US/HoaRfZ+czT5Ayr0jbcfMB9UAKn7mMjb31k+yXZlc7aXNuOJ4Ctwtk3L69J
 kausAkb8YirvN2MzokIoQguZAQqwwtOiPJilUWp+DdXmwezz057Gqz/Ea1T5C2HnYGOmN1
 ZnOmODS1xTSoXtN4XA0FYal4kFDKSOo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-HoFsZypvPcunOgI9aFiXUQ-1; Sun, 11 May 2025 09:20:11 -0400
X-MC-Unique: HoFsZypvPcunOgI9aFiXUQ-1
X-Mimecast-MFC-AGG-ID: HoFsZypvPcunOgI9aFiXUQ_1746969610
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43f251dc364so21999765e9.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 06:20:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746969610; x=1747574410;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DQgsqkTOIyZhN/qlgqF78+C8tcllmzO5ZDG7Hijf0JM=;
 b=eMcFmge/9Z2NVawMPf+04RQfcNt3m5Csh77ZTV1lXkOY8XtY9GYuMCW5ICwPTTSxcT
 BntwwSvtuq3N9au6J97oEOWy/jPQLVdAXEGhxNJDYR3LZcBtHqwKFN8iqzPguToO6CgX
 0Nq0DQ2RHYwm2Bp9B/yogF3dndhFiU+KXmA40mQsavtTRVldYZ4d0nkzaaxoaxqcRXNb
 Zo8aZRFXYH1D98r29ElbCaSMa+P+nYQE8qAbeOFK2wODQt32thHkkePBgelZ9li8IOtG
 6yPG90KqdjHIoFQVT/G1HOSnMZLyftHKRFerS5fjHmd2LDo+rvzF1d+hDCVoRzcP4J7T
 IzFg==
X-Gm-Message-State: AOJu0Yx5edkTN0tzKRZdl4XPioTZq9wJSpkoBoHIa4a5k2unky/wcmfj
 fjMZC87KYtCR4bd9QqDF6D6lj5PV60Nh1yjBr/vcL3LVuJY3fJQmPmL91C3BwmxSJ6TsRhUFmAQ
 8R1h3v33BALV1ihzLX8vWrDjuztrDHfEiJOUeydeMVWxNEZBn7Rlt
X-Gm-Gg: ASbGncv104/W8+VqEEN+8wbONPMFCVwHAfNPGqvLuyLgqnjm2ma+KWQeO902tFOO9Ib
 UeMPmU1ZidXD4a4B5UGYWh8vW9XMrFufHGESCPHvvgt6/oZX8bDjQAnRvzXRhhw1pS7jaC2acwk
 3IZrzVLYC6Nq1cJKkzIR7sTAOFCC2yuR0ZHSt+7p+QtlP5+tEhUCitm497jiMf6rugs1FYSVQ5v
 l9f+Kgm+UdNCeT5NrErJKJiAFgbo/g0GlA9aCWbp4Zil0f+i4edP8HybJ2Ut6nehooqwgPU6/Mw
 UkjQ7Q==
X-Received: by 2002:a5d:64ab:0:b0:3a0:b65b:78ff with SMTP id
 ffacd0b85a97d-3a1f6487d6amr7788833f8f.40.1746969610296; 
 Sun, 11 May 2025 06:20:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKBMWzClzGKTnM4TtETLrZC6iFV/0P/Ho/Ky4KWUVatV7orHTQ7ZEnn5JlGPDQpj3de52nXw==
X-Received: by 2002:a5d:64ab:0:b0:3a0:b65b:78ff with SMTP id
 ffacd0b85a97d-3a1f6487d6amr7788813f8f.40.1746969609924; 
 Sun, 11 May 2025 06:20:09 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2d96csm9329134f8f.69.2025.05.11.06.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 06:20:09 -0700 (PDT)
Date: Sun, 11 May 2025 09:20:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 devel@lists.libvirt.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 0/5] docs: automated info about machine
 deprecation/removal info
Message-ID: <20250511091938-mutt-send-email-mst@kernel.org>
References: <20250506160024.2380244-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506160024.2380244-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
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

On Tue, May 06, 2025 at 05:00:19PM +0100, Daniel P. Berrangé wrote:
> Since we deprecate and remove versioned machine types on a fixed
> schedule, we can automatically ensure that the docs reflect the
> latest version info, rather than requiring manual updates on each
> dev cycle.
> 
> The first patch in this series removes the hack which postponed
> automatic removal of versioned machine types to the 10.1.0 release,
> since we're now in the 10.1.0 dev cycle.
> 
> The second patch in this series fixes the logic to ensure dev snapshots
> and release candidates don't have an off-by-1 error in setting
> deprecation and removal thresholds - they must predict the next formal
> release version number.
> 
> The following three patches deal with the docs stuff.


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> Changed in v3:
> 
>  - Remove mistaken mention of 'ppc', only 'ppc64' has versioned
>    machine types
> 
> Changed in v2:
> 
>  - Remove hack that temporarily postponed automatic deletion
>    of machine types
>  - Fix docs version info for stable bugfix releases
> 
> Daniel P. Berrangé (5):
>   Revert "include/hw: temporarily disable deletion of versioned machine
>     types"
>   include/hw/boards: cope with dev/rc versions in deprecation checks
>   docs/about/deprecated: auto-generate a note for versioned machine
>     types
>   docs/about/removed-features: auto-generate a note for versioned
>     machine types
>   include/hw/boards: add warning about changing deprecation logic
> 
>  docs/about/deprecated.rst       |  7 ++++
>  docs/about/removed-features.rst | 10 +++---
>  docs/conf.py                    | 39 +++++++++++++++++++++-
>  include/hw/boards.h             | 58 +++++++++++++++++++++------------
>  4 files changed, 89 insertions(+), 25 deletions(-)
> 
> -- 
> 2.49.0


