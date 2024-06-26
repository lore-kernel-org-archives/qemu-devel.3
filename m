Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DBCC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 13:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSm3-0002Ot-CT; Wed, 26 Jun 2024 09:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMSlp-0002Lm-Ct
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:33:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sMSlm-000451-Kv
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 09:33:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719408785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ixiwLmAYC7HzVK4ZUin4nb4V3nFfeubVxRAmo6WKGic=;
 b=XB3HmSHYXg7SwoMxFm5k6Wv60NA6fzciges0fvQ8E5vGTOI4KCehS9LcMbvHvYKmASQ6Mr
 Z7rqh1IhgVGbqWACPMZVciYWy6tUp3HsihFa/8n4iq16O2mEau2h5/9zVNgzK0ANPQ6CGm
 ShjQipIw47k+5RTPKfhEb5AQs2cDJGg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-7XI7Q6EFOMa10hBAbSrE6Q-1; Wed, 26 Jun 2024 09:33:03 -0400
X-MC-Unique: 7XI7Q6EFOMa10hBAbSrE6Q-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b4fc5c2ee5so16019196d6.3
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 06:33:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719408783; x=1720013583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ixiwLmAYC7HzVK4ZUin4nb4V3nFfeubVxRAmo6WKGic=;
 b=lfkwwkPsNxXTrATC+h7DTQ5zV9IqOisE6tJVatckkJ22uz/qAPzWIBBmBZZmEwtgV9
 4jIxHsppigH9uPoQ1bX21i2Zhgw0mlduxy0tNKCXX8pB6jREmGMp6KLFvgJx9bB5RF4d
 ZV1jFowIRT/Tko/SSu3nODHqME2zTdpBdcfuLV/oleP98HWWdGFX232CelUWIAeNutlF
 Z9CoMPZ1rdMPmmSWoc+2vQkH3ukYlT+oH8UB+7a8LEdsQq+s47BpI/L9DikaLs5Pkgl3
 pd8/hTakF7/ARicvaM42/s2/7KfyByw2Np3knC3Yer8aPFvC2g8mjNQ9dwnq2K/t3M5K
 kxWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTUgbN3t3RZ5kR5G9M8I2y1+N+97fICzdHnOG3SIUVT9Y34MGqfWf0SCfbhsTTH2SnCS6mhZbdXJL0sbwWr/V/mwyg/JU=
X-Gm-Message-State: AOJu0YxwglLFwr6CEs2OBI+YVhjyqqlyx+KpwHHfuGcXJOIDbRU4Wd9M
 PGCfvWqi3rOqkb3d39dhKQPfnv6FRVpDy6v+NWHfVT0FzK7z35Y+yFCd7NfoQzjKxuRxK/4WqrJ
 l1Aeo7yVceZ7452/nehGrjQFysekho2pFcHi55AM3uvErHk8Xzlof
X-Received: by 2002:a05:620a:45a2:b0:798:cea5:7b54 with SMTP id
 af79cd13be357-79bdd8c211amr1291982185a.6.1719408782849; 
 Wed, 26 Jun 2024 06:33:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuGb10ilP3C5z0TmsNWRaNXDsIYO4cT9btutk/FFaMDLNY5AYWHSykfiLEXPTwqM+GwKP8wg==
X-Received: by 2002:a05:620a:45a2:b0:798:cea5:7b54 with SMTP id
 af79cd13be357-79bdd8c211amr1291977385a.6.1719408782282; 
 Wed, 26 Jun 2024 06:33:02 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79d58fe5e2asm4711785a.79.2024.06.26.06.33.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 06:33:01 -0700 (PDT)
Date: Wed, 26 Jun 2024 09:32:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH 07/14] migration: Free removed SaveStateEntry
Message-ID: <ZnwYipRkxIromzf-@x1n>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
 <20240626-san-v1-7-f3cc42302189@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626-san-v1-7-f3cc42302189@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 26, 2024 at 08:06:30PM +0900, Akihiko Odaki wrote:
> This suppresses LeakSanitizer warnings.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


