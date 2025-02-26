Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21337C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 15:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnJct-0006Vs-C9; Wed, 26 Feb 2025 10:47:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJch-0006O8-JE
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:47:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tnJcf-0003Uf-7G
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 10:46:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740584813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qja5XUy7Ku3p76xys8B9HD2fV/xcrx9EdrdvB+PZTqw=;
 b=P0xvVmd7LPXmbkiEJAyounGuDFYoFhtE5Yzlcx50yZBCxn5sV0I2viCbqVd49WkHN3ZOYn
 2ocqrXj9m2w6EqM4lXbK3QTlhpUv2CZcXGsqtdrYxnBbEyg+aCyoLbx9WknoLDmtFnnE5D
 S+PSseTSlc0C1QeuJf5j3M2Cgfxsltk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-7Ob2K898NTW-Z8PTTqlp6g-1; Wed, 26 Feb 2025 10:46:52 -0500
X-MC-Unique: 7Ob2K898NTW-Z8PTTqlp6g-1
X-Mimecast-MFC-AGG-ID: 7Ob2K898NTW-Z8PTTqlp6g_1740584812
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-471f205010cso110296461cf.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 07:46:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740584812; x=1741189612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qja5XUy7Ku3p76xys8B9HD2fV/xcrx9EdrdvB+PZTqw=;
 b=sf6akUM/6ucManCoEhuMH1gVG/8oJf1B6XG7EamaLgOcGHEcpm19CaUxbddjq3EEFa
 BVVOXIFluTuqhD+UVNpsC1EsWiWNNAkENNaqwOVCqbxq8x/UGeAnG+x7+9aFq67ey9v5
 PHi/Ms+Qh9c0OWIX7HjMwWbv3eZPIhAuboKBQH0g6szZo59Ull/6iPmf8WvDdcoU7iMl
 UZ0Wy7MqGt5FsByohf8AHx1LNLZm46j/54IriYaT8jjrlbixLyGrLCMaHOyPj6+BhW7f
 VrXPDzn69Us4HmRlFdptEOXbYl7Us08MT7occjA8r+9huyBGFmyaaBAc4g1MwD+ngYed
 7N3w==
X-Gm-Message-State: AOJu0YwhOVpyy8XtxSQnY5OfNQqKuULuH865mAQUOFoiy4CsC1S/98my
 rR1Ca5+cA/FwqViN+uUChHXT7gT5CJt0RVa28q2bqWAd5s6Z627GGN0UkgRHF0Zk/3fzzVGhdBN
 fo4GU2zLYrbZAbOrWnF4fO4urhDSfk3or19dGbKJy0i8RgttI+MlC
X-Gm-Gg: ASbGncst/ggEK4TAoZbbpnNm0fnEjU5eQ8YvXRTFP2fe71v2cYnN8WI54Hjjil3WOeU
 wZ2W/QhrQEpdcLc6iXFx25FSHmuAfclhgyr5EKXCQiNOk3Fx8SiCHM6XwjgKrE2clznyr4HiCbb
 Oc12k+3CM8fyMjSSVIY2zGp+h3iDaL7JiiUhfeDV5U921LC61Kl4jTzpHe2UY+RbWxXcOPVUlAa
 mRmJbh4Sio5hES21FaClCYBm6SrAcSgSk/e/rmH0/+3XkQ5o0bc77qfKoiGTNphN9oAbg==
X-Received: by 2002:a05:622a:250e:b0:472:8fd:90f1 with SMTP id
 d75a77b69052e-472249085femr260002751cf.51.1740584811998; 
 Wed, 26 Feb 2025 07:46:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH2B6nGAOFq7KONLeBpk+3LwyonC8HIpIi5Ln/1Rtudx9vn1L8tFCS2KyPMrxgQ0LejTekJA==
X-Received: by 2002:a05:622a:250e:b0:472:8fd:90f1 with SMTP id
 d75a77b69052e-472249085femr260002491cf.51.1740584811721; 
 Wed, 26 Feb 2025 07:46:51 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1001])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4737806a6e2sm25163051cf.56.2025.02.26.07.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 07:46:50 -0800 (PST)
Date: Wed, 26 Feb 2025 10:46:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 2/6] migration: check RDMA and capabilities are
 compatible on both sides
Message-ID: <Z783aPBdOKGB7Bgj@x1.local>
References: <20250226063043.732455-1-lizhijian@fujitsu.com>
 <20250226063043.732455-3-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250226063043.732455-3-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 26, 2025 at 02:30:39PM +0800, Li Zhijian wrote:
> Depending on the order of starting RDMA and setting capability,
> the following scenarios can be categorized into the following scenarios:
> Source:
>  S1: [set capabilities] -> [Start RDMA outgoing]
> Destination:
>  D1: [set capabilities] -> [Start RDMA incoming]
>  D2: [Start RDMA incoming] -> [set capabilities]
> 
> Previously, compatibility between RDMA and capabilities was verified only
> in scenario D1, potentially causing migration failures in other situations.
> 
> For scenarios S1 and D1, we can seamlessly incorporate
> migration_transport_compatible() to address compatibility between
> channels and capabilities vs transport.
> 
> For scenario D2, ensure compatibility within migrate_caps_check().
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


