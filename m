Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32722D637A1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 20:27:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVbdK-0003QY-6t; Tue, 16 Dec 2025 15:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbdI-0003QM-Le
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:26:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vVbdH-0007ol-8d
 for qemu-devel@nongnu.org; Tue, 16 Dec 2025 15:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765916814;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jZj1I8nOzjmoVDHZyvdDRdx1xL+2UHNsvnexGg34QqE=;
 b=JsyQRtAge1XuLtbFpOoHbAFbOK/aWDIhaSD9V0x3dZ/AhFqviJUlOkQ+Ro034R51ZT3Eyn
 QiVgqmpwucqHkg1Y0tMtc3A73umdeUyu0p98pws1oVcNmvTq+OpjN2Tq+r0mzT7tg3H+3V
 v/Zp3uIcAHhjVQFDEpTutvxn9w6SFhs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-CHXr9BD5OZaTcExu3YPHbA-1; Tue, 16 Dec 2025 15:26:52 -0500
X-MC-Unique: CHXr9BD5OZaTcExu3YPHbA-1
X-Mimecast-MFC-AGG-ID: CHXr9BD5OZaTcExu3YPHbA_1765916812
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-88a2e9e09e6so96318996d6.2
 for <qemu-devel@nongnu.org>; Tue, 16 Dec 2025 12:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765916812; x=1766521612; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jZj1I8nOzjmoVDHZyvdDRdx1xL+2UHNsvnexGg34QqE=;
 b=gHDMV2YusToS6CBii1hTjv5zsn+TJ4r5APS2eBv4ND8Weau23aFs+c+CLzQJ5Rszux
 pPJ3d3iuWzzm4AGWTdo0hORxo0CGUfSpamuI7mcNoHhePwgLY3phEN24h/PxjqDt2Mes
 O++85X4wz/v1RfqwwgREUtILWNz3WovJA4NK7RC+DbVSqff0mfQVqV5l/TrFY4bZxJWB
 +u+toIQXCj0f4/+uf25uB0DJQ02dfVzzydy8PjMunAr0ajoqLH8HV/f83S5EbGoXw59e
 yF9jZu8NVkvKTFen2C8bNl6nX6U3ebl62hRIWPWONzXY3leIPb5Niyo94gOotdh4XgOr
 naqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765916812; x=1766521612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jZj1I8nOzjmoVDHZyvdDRdx1xL+2UHNsvnexGg34QqE=;
 b=eKLgdkK4Act93jgX4c21lfgQpDxv2yCoFt0tCsGp5J9oHJjmgPpLhXXLyUegyknO7g
 SsrQwH8kPvoVS/OMKWIg2ZZJM4H6TmOkNIuVMmZt90J3PCjFlXz1pBpb0bHvLR3xQGwe
 bAUy70L7vNIsIHL8lH2DmLWpdgicJgXEn26Yz22N34tcBggxzGvok/HJer1qZIAR8MAC
 zyVhCDYGmvp7jW3sKT1+5OSWzBs/SzoMpVfH9uajpapEKX88XW6DWbEcha6pfIr294xV
 N/p0+iNnh1JzBiXnnellB0f0nzQy/MiCsaqP+PNDcdabvXZ2iNonNO8qJ09grpGsS+d6
 PBNw==
X-Gm-Message-State: AOJu0YyxU6oyWhabpl+eymmnK9Oc0HaBk2kRcDby31e0meZtz2kIF2Iq
 Thooht0y7WmgVGeUKptHBVYCa/fFliN9EdkSTgWSpIEy7UpGa6tp8DstTZOZeUeqLKzHChpVTnY
 Rb4EDh/zulUYsEfVyeoC0+jEOrAwM+3mldoorBOfArR5dyHxCytZ71w72
X-Gm-Gg: AY/fxX5ct2cEdN7rrG8Qo2EevIdJHATqsDXVZLLEradPPsT7y+RERIJS09Lfg685EnO
 eGnEhtX6G0uum1s03qWFbkghqfu8aULaqL3lwkCetYa/f9o8nYYlAYMhhP1KgldSmM6liSHNS89
 88RuHKsUwR9mH5g6GAkbHTDu77JpTomp7hwDLg2kpmZg9euoDZMFlNU5B20xLS3rrCf4aop8seD
 OPZ0HJfvttlm3gH8W01poedKjjm77e4p+GvwhqvPwaycbWje2CwVTdRPboh1iw/nTel9rAbNK8R
 6eyOeEMXQlyJ6NIDSDiGnXJIcF0WLyIHXnexNuFcYw1QjAOK7bLoWKgye/2Ec/8eue9quId37cl
 ua00=
X-Received: by 2002:a05:6214:3f8d:b0:88a:4ab2:5f52 with SMTP id
 6a1803df08f44-88a4ab26055mr41555326d6.51.1765916812126; 
 Tue, 16 Dec 2025 12:26:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkW+SfqW5P2ZGLuWYx14ReuCMe2e8SGG17EOVxrNM9pVu1kE1cvCvHByXuH24k/2GqQfD1Cw==
X-Received: by 2002:a05:6214:3f8d:b0:88a:4ab2:5f52 with SMTP id
 6a1803df08f44-88a4ab26055mr41555056d6.51.1765916811671; 
 Tue, 16 Dec 2025 12:26:51 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88993b5c015sm81188856d6.15.2025.12.16.12.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 12:26:51 -0800 (PST)
Date: Tue, 16 Dec 2025 15:26:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com
Subject: Re: [PATCH v3 15/51] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
Message-ID: <aUHAiqMr7k21qGFu@x1.local>
References: <20251215220041.12657-1-farosas@suse.de>
 <20251215220041.12657-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215220041.12657-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 15, 2025 at 07:00:01PM -0300, Fabiano Rosas wrote:
> Instead of setting parameters one by one, use the temporary object,
> which already contains the current migration parameters plus the new
> ones and was just validated by migration_params_check(). Use cloning
> to overwrite it.
> 
> This avoids the need to alter this function every time a new parameter
> is added.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


