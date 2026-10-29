Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5464606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 11:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UvsZNSqr;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HhZIVGMg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMOmp-0008Mk-MY; Thu, 29 Oct 2026 07:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMMyS-0001Qs-28
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <seott@redhat.com>) id 1xMMyQ-00018p-OV
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 06:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793268186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lgon1Y0wjM4ESolQGuvJRA7H9Oh0UjareY777hr+/cc=;
 b=UvsZNSqrYOldjGPBw+FEUGonvKqRLlZgR7LZs2mvDErUIyQUlsJ+bnKztLYx8Zl5a73GfG
 LYeUO9+HXocr2DX5AcFqoCg76LLG8bz6avaydN2YEZVDu8tcGU4cQ/M0I2jD+4xTangbgL
 kZ9KW4lKOFKFjYkSlmc3kvmvc8KiUbU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-rsvMeiYpMsOYWGDevHUZdw-1; Thu, 29 Oct 2026 06:02:58 -0400
X-MC-Unique: rsvMeiYpMsOYWGDevHUZdw-1
X-Mimecast-MFC-AGG-ID: rsvMeiYpMsOYWGDevHUZdw_1793268177
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-c25edb54d22so232488766b.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 03:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793268177; x=1793872977; darn=nongnu.org;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lgon1Y0wjM4ESolQGuvJRA7H9Oh0UjareY777hr+/cc=;
 b=HhZIVGMgtgDDFFdHFA8kAEMKNKhyYnhPuFDh6HWd5Iy6/4wZeh1nR8g7BA+6QYQv8d
 0rlqW6P55nKa275w8CoAmXB/ZVdRgxeHtPYUEMooFRfA7aERwDiXR6OcEgGYA++WhOPB
 bDSDSgdKUHnq9nmitbVxiSsW8v07IiFk6T8mHBePGyQFH4eJqjK0vgiE+8lGk6t/Lqng
 xWpXw15NiMwj8Cx5VO+tx9iFdaUvyI3NDuPi9VwtVSkV9KHwOcwtXdDyU+YrN/9KlWNW
 pl1G+vamXaBLta0vSce+ZMpIrz0qtw6OjjGWQWbWrJ/u2IExqFQHQF+G23DLesAqB1WH
 tGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793268177; x=1793872977;
 h=content-type:mime-version:references:message-id:in-reply-to:subject
 :cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lgon1Y0wjM4ESolQGuvJRA7H9Oh0UjareY777hr+/cc=;
 b=FkWpD/eaoxcx7/M0tzGy3cj1dpoAeliQ1CHCGxJyuqgg+HFWuBnTD/Do7O1RRwxeg+
 8U0CVEglm4VMbfDN+kw1uVsbP77cb/WPEXk1BVjwejucGfvIHNCyecva05UGlScyySvm
 qk8I+zVfpWc1V1LF/GJteIiDeF2FHXYVwOjRQVnTfmU+Ppvp/MRIP4L9nGGlVJ8ZQ81y
 x44KbuId8z+v/+iMvfZjt9Y2KKLUP7jIqh59dRzHN/Aqoqn7PdUyeDzDEoLcwhH93C9X
 y2skysI0uGdIYosnxCTX9Q1ThWbh1UUxoBECOE7zumUPtnyVEM6+PwjyXHCmYPtH4rTL
 tMZQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCYL5/YfVNnIKIuUYYdetp/Jo2Ku00/bGqLEiRu4afY9JEv9+6ktjhAo2zr5PSzBDr9fHx0R4r5Dub@nongnu.org
X-Gm-Message-State: AFq9FYL74mySsHdL+IAxfldxRydyFYORz6L5FhbTE3ZMA9c2S+p5tlf0
 AKtBIP0dR9s3eu+CQRM1noZxvFj3PBiY9STINzoGcR2gtjtBARqPMRWQTyYys7kbBk9WftJWQSf
 E0vZss6RgS9A1tP5pcPzid36oK6Oitw4Nt7sqaza1Hi98UslOhLiqE3hA
X-Gm-Gg: AYBFou3Xy+iwukzfCVi2xDcdXgLpuGdaT1Vk1kMPkP4BDv9KUQcHsRDqX9L9TmQ63hh
 pWZah7fans99KSbNUlF8YTz13nZxhAppmlatO3xDb29y9UVB2zExQOmQ2V7MLVgCLQrQATr+5po
 x5mhfYe0TvmzgUDDUBhvRcn6niTtsSe3AU1/kgFkuS6MV0dbXGdNY0kTjRk82z5fdo/wNCFU8Oj
 wYly0DCWch+ATjNw9aSu1phnlS+PT1Kib0tou4U5Ahz68++4H3y6LJZkm2XBeuQjzwSgiwJ/WDF
 yHKX3PsEfkQs2ifxlYu7RaEewz8xZsswS8Up2pHrl64+HRtHw3l8oGztwZemb0P4bEHQ5pyPKGf
 atFuv8qik6j2/YeFIwR7Rh7hOPqe4VHOOm4AnIUzd6B4LtYnhJ09MTSUcpyEp3yFeoXtVilwzQI
 CHXJVnrcoH1T+Uzws8oUvhhD6dc3C8iEhIQGW+dbs=
X-Received: by 2002:a17:907:d26:b0:c48:9228:bdcb with SMTP id
 a640c23a62f3a-c49bddadefbmr468806866b.3.1793268177286; 
 Thu, 29 Oct 2026 03:02:57 -0700 (PDT)
X-Received: by 2002:a17:907:d26:b0:c48:9228:bdcb with SMTP id
 a640c23a62f3a-c49bddadefbmr468801466b.3.1793268176814; 
 Thu, 29 Oct 2026 03:02:56 -0700 (PDT)
Received: from seott-rh (p200300f6af1574019b2c5947d8ec139e.dip0.t-ipconnect.de.
 [2003:f6:af15:7401:9b2c:5947:d8ec:139e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm33912683f8f.16.2026.10.29.03.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 03:02:56 -0700 (PDT)
Date: Thu, 29 Oct 2026 11:02:54 +0100 (CET)
From: Sebastian Ott <seott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, shaju.abraham@nutanix.com, 
 khushit.shah@nutanix.com, richard.henderson@linaro.org, 
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com, 
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com, 
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com, 
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com, 
 armbru@redhat.com, mbawa@redhat.com
Subject: Re: [PATCH for-11.2 3/9] target/arm: Move MIDR into isar.idregs[]
 storage
In-Reply-To: <20261029092307.281287-4-eric.auger@redhat.com>
Message-ID: <e743a8c0-a2da-570c-2ffa-6d45863f4996@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
 <20261029092307.281287-4-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.129.124; envelope-from=seott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:59:09 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 29 Oct 2026, Eric Auger wrote:

> Move MIDR into the isar.idregs[] array as other ID registers.
> This will allow to overwrite it as others.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


