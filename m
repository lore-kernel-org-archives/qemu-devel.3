Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4528C5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 15:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sibcS-0002qi-7i; Mon, 26 Aug 2024 11:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibcL-0002Zq-Sc
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:26:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sibcJ-0003Ex-BK
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 11:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724686010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nt+JH/c8RtA/YdR7bd688QxFsy6ppQfInZ3vgxnRoyw=;
 b=ggkiTelPv/R2gMVz4GICuI3fTcgsdK8K3UpBm8QwzSxPW+CxUd4NgWe5kbUkZnMKrD4xZQ
 8EF0Ckj4df9tQsbwpEOX/Gjug/xzyMVnj73MLx/vGNQ5IYmMLTZ4eP2qYQUdVc8hvH6aKF
 BbFyRwT9+tQFNu6oPBNZcrdMp+o/Rcg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-36sboKaeP9m5pugS8f6-5g-1; Mon, 26 Aug 2024 11:26:44 -0400
X-MC-Unique: 36sboKaeP9m5pugS8f6-5g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6bf788e4692so53081606d6.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 08:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724686004; x=1725290804;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nt+JH/c8RtA/YdR7bd688QxFsy6ppQfInZ3vgxnRoyw=;
 b=tCBN7vIAJk8Oc+DxgAQxq2h8lpOazgCDkTX7BB198BlGNFsnr+ggr5o4JVwVZkhW9M
 QDrYP5uU7tWg/mFbdsBV+22ntISrxlYfihtETaVobIhEhSkocb4WOMC5e+zjTAexF44a
 rVmixvKFNqB+0SQd60FUrg+ShQytijajMrtNwWvj1auHHyeHp9qLLei+4VtL4CTwKgOr
 nxgdghliibKtL6jbDRAWdKp3WMiQXHmxXYwjKu+2cFkaZavQi5gMc/M2vjNRyjc05aB7
 BPcsFY419Owu5t/OAF07n2SjrhfctY22yQXj3UK3YRbJRModjgla7I/BOfIDUQKFd1aD
 cI/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh+FeVcfDc1dsyAkD4v2t9vhsOjKiL43hI0DVD3arSgdRyPsj4gKmCM14WN7JtYoP9+CVSgRutemyb@nongnu.org
X-Gm-Message-State: AOJu0Yzitt1NKhfajptoW4ZZMmi9DPNqM0Jb8dvbNDoPvwPPxrsdu03i
 MwVIzBbkYrlXs9ZKsnyTcNYobPITSmdrj+SU1b4JcdlV6Dci84Ih9Dik/HjhoOz/aBa7Ke8UmW0
 ucM3x7mMEqU935PXMDG21Q60/PmZY2V3wadeCO6avrROqdL2/VBhT
X-Received: by 2002:a05:6214:54c6:b0:6c1:6f9b:619a with SMTP id
 6a1803df08f44-6c16f9b63admr126396796d6.30.1724686004477; 
 Mon, 26 Aug 2024 08:26:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFA0749l/+hX4usq9XMmatXxPrWAF9HzAoLVW180ET+FDQ3QSJdRSCWR4B4zV7KT+rL/ZOpQ==
X-Received: by 2002:a05:6214:54c6:b0:6c1:6f9b:619a with SMTP id
 6a1803df08f44-6c16f9b63admr126396516d6.30.1724686004112; 
 Mon, 26 Aug 2024 08:26:44 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162db0acdsm47673136d6.85.2024.08.26.08.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Aug 2024 08:26:43 -0700 (PDT)
Date: Mon, 26 Aug 2024 11:26:41 -0400
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
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 7/7] tests/qtest: Delete previous boot file
Message-ID: <Zsyesfaf02ktFU1A@x1n>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
 <20240823-san-v4-7-a24c6dfa4ceb@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823-san-v4-7-a24c6dfa4ceb@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 23, 2024 at 03:13:12PM +0900, Akihiko Odaki wrote:
> A test run may create boot files several times. Delete the previous boot
> file before creating a new one.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Acked-by: Thomas Huth <thuth@redhat.com>

I didn't track which came early, but I think Fabiano has queued the other
one here:

https://lore.kernel.org/r/20240820144912.320744-2-peter.maydell@linaro.org
https://gitlab.com/farosas/qemu/-/commits/migration-staging/

So we should be good.

-- 
Peter Xu


