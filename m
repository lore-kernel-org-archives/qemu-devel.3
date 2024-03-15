Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EDC0C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7MS-0005gz-3S; Fri, 15 Mar 2024 09:12:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl7ME-0005KQ-HX
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl7M2-0000MK-5h
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710508328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t3QzGecZxkqmeAovbFozqqZfealShnKvYvbZaHfAxm8=;
 b=OCuWVs9onmrKyLvUkyNPGJ1nX+LrEKpODFO5Vq+NoYpE6SB3Vb+vXOJlyc2rv58LnCNh2A
 fMMpOtItyRNpsoxhxPHVvqh0GNec4H5ke4D5pFbckEkYoTZO7yJRX4m6Srtqxa8WOLfMqJ
 IqbjMSwoCsI9E5inz65azYToH/m+ZEQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-GWmCuXgoOnKWmIW0fSrtYw-1; Fri, 15 Mar 2024 09:12:04 -0400
X-MC-Unique: GWmCuXgoOnKWmIW0fSrtYw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830635331bso53818885a.1
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508324; x=1711113124;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3QzGecZxkqmeAovbFozqqZfealShnKvYvbZaHfAxm8=;
 b=xE5ECsFm3wFOyWY4Z3wqCnyaVm+t7+vzwyK4wqfXYmsvUrW7rBorUJv6RzKbWeb7CK
 Xfi6HZjzLtejkyxSBcogYML5Ua602c2c0hNmUApav+u0Lkv5It/Xjh26gSWrTH80pUig
 DCJYWxUy+jvRwhYy6iYE5CraHnkGEhUnXG4Cp3qT6YYC053WEjjawOo1FWSlczrUGpVz
 HUR51iKQ46j2EnKsvtUCStdrXXCfpB9dtZJSgbHOtp4+/a4OvSlGvP9z4as3tyPOSHXf
 YQ8E1QsSoSR2HYMmduohqJojSwnB1NWh9Cf7B6r3Z6d6he4PLFJalSn6NtyM098eAypx
 AJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZy+jr2HJG4Opotl+Rcsk+MVksDj0We9OLu8qyG5BZY/lK4munhafzWIoPSZ+HBQJqtxuvVmR8HtOB145UDVhYUbDEko4=
X-Gm-Message-State: AOJu0Yz5b1RM0wVRMVZ/z6baX3jHBdkVbpaUUBVsxRyyCQk06iLL9SML
 cyrAU58Gxu3pvKTSFBrUPP8wAJdTZ5CdGMpbqAY1tWjFIpRb6y7rKRgzfIG9nC8T8aPAJZCp1fB
 qC4d3wsB0K3LhmoPA9tCAdTgU1zDAOj3W+QNky12toNJt9kReh5Wt
X-Received: by 2002:a05:622a:1803:b0:430:ace8:980c with SMTP id
 t3-20020a05622a180300b00430ace8980cmr2762410qtc.1.1710508324393; 
 Fri, 15 Mar 2024 06:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlSkM10vaTojpFVCisS8VCJleQrPXNXLv5wBOUyUmxzN/Chyqk7/kQvlCBCel3tTYOe39hMQ==
X-Received: by 2002:a05:622a:1803:b0:430:ace8:980c with SMTP id
 t3-20020a05622a180300b00430ace8980cmr2762379qtc.1.1710508323996; 
 Fri, 15 Mar 2024 06:12:03 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 k17-20020ac81411000000b0042c7d11e280sm1960849qtj.90.2024.03.15.06.12.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:12:03 -0700 (PDT)
Date: Fri, 15 Mar 2024 09:11:56 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfRJHEya_kPaXWbU@x1n>
References: <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de> <ZfByYiL3Gl9d9u7h@x1n>
 <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
 <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Mar 15, 2024 at 01:20:49PM +0100, Cédric Le Goater wrote:
> +static void qemu_savevm_wait_unplug(MigrationState *s, int state)

One more trivial comment: I'd even consider dropping "state" altogether, as
this should be the only state this function should be invoked.  So we can
perhaps assert it instead of passing it over?

-- 
Peter Xu


