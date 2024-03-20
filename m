Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B86C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmxAe-0003by-Bt; Wed, 20 Mar 2024 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxAd-0003bp-9j
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rmxAW-0002ot-Tv
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710945831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mnGXHLQW0SmnZynEwH7qEifXtOwY9SIepUnDbRYN/RM=;
 b=isyOkPptxgeRbtC9YRVVY1PaMCZQXsEkf2ZVMnvizh40Ty9PFBXele7zevMvo96+WmKngp
 x6/jRd3f4uO/51x94ADTC0pgBiIbW0C77MOnhgkTi4vvMQ4QbtTuKWp/iyO0mTRPjl5O2a
 Ae5jga192BIm4Ba1bcDm53Gk0JcY6kI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-Soj_XVXQPAivJ7xMsoVSyA-1; Wed, 20 Mar 2024 10:43:49 -0400
X-MC-Unique: Soj_XVXQPAivJ7xMsoVSyA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-430d45c66acso5294711cf.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 07:43:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945829; x=1711550629;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mnGXHLQW0SmnZynEwH7qEifXtOwY9SIepUnDbRYN/RM=;
 b=pEZ1SO/r5Jt+viAhQM3e0vDOyd0fg924PWVJ7SpLd79hoEx/xuo5pFITNzJ05ePYaS
 DTfAuoQM5c7J39ENDPMp5c3LFcF3rWwuWmyhRbswWZBrY2zT/XIMTMvtlsJpqTSAVog1
 +CURioJ9XGOxDxQcUW7N32VTDl1pzfiNY99QoSY+t0y3m5c/T9PlJJfJ5hJ1FI5WDEFD
 dfOfr9q/HfGMYGdV/xrib1x7fkWwqWsVHjyG19AJ+En1vNkDEpxTwl4gXn4xJOhtQlKK
 9+Ae/pjdTrTA2toXGchiPl5KFw2HiuKtiFMijxTs7OIhZhklyyJoCXgG4lixMwVSlOKh
 Uw3Q==
X-Gm-Message-State: AOJu0YzCADcgodLLxr4rUhGIMwpNTKeDDO2BcDQS6E0XBm3/ze2F0tSS
 HBms1M5YhvBt/OtUtt1lmItPdgXuDEEhZwpHYvhwxduy3OxlLgTFQe5CP2B8X0xCqd7MzxtfhaF
 3bXdSj6LMTmMxnYdT58SbjUkVyMK9wjF4/6epsJe4BER7PIgOBFHu
X-Received: by 2002:ac8:5bc6:0:b0:431:12c:28d1 with SMTP id
 b6-20020ac85bc6000000b00431012c28d1mr2256005qtb.4.1710945829215; 
 Wed, 20 Mar 2024 07:43:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhZzNT5TPVsE8rO8soeS5c8nQh0JqXSn0gA/Okyw7jTIgv3hp8ILlS9up6nQ3hEKexEoA6Sw==
X-Received: by 2002:ac8:5bc6:0:b0:431:12c:28d1 with SMTP id
 b6-20020ac85bc6000000b00431012c28d1mr2255966qtb.4.1710945828449; 
 Wed, 20 Mar 2024 07:43:48 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 cb14-20020a05622a1f8e00b00430cfc6b5dasm3946370qtb.93.2024.03.20.07.43.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:43:47 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:43:46 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH for-9.1 v5 10/14] migration: Introduce
 ram_bitmaps_destroy()
Message-ID: <Zfr2IipOJPRH6wWt@x1n>
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-11-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320064911.545001-11-clg@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 07:49:06AM +0100, Cédric Le Goater wrote:
> We will use it in ram_init_bitmaps() to clear the allocated bitmaps when
> support for error reporting is added to memory_global_dirty_log_start().
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


