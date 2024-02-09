Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 674C4C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 17:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYUPp-0004pQ-5o; Fri, 09 Feb 2024 12:11:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rYUPo-0004ox-5l
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:11:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rYUPm-0004yq-T2
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 12:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707498709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Id1D474oIjs8r3tjtOWP1sCxxBnDXcDv1k1wpGiOP58=;
 b=QogugWKExp33mcICs/5qFpUBebZQBE7tHCSPsvSgNI/bEYZOalo57xpoAWusDpOkKNIi+q
 /tARSLVSngpq6VtZdWZQd/6gdJ8WOgaREaEEZZJpaGTw/94a7dvSHIl3zbYgKZ7IurbIH6
 ekiJ8dQ0/6nGPQtvbC+FvUR0Jg81zW8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-FIVkK-1aMVqvue6NBE_gPA-1; Fri, 09 Feb 2024 12:11:46 -0500
X-MC-Unique: FIVkK-1aMVqvue6NBE_gPA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-511535180b4so1012645e87.2
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 09:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707498705; x=1708103505;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Id1D474oIjs8r3tjtOWP1sCxxBnDXcDv1k1wpGiOP58=;
 b=DaP50Q0UXloRWqQaHu5tGznyQ3lOzBIRruk9wj3ZW0KVG3vHbUP5cH2RIl4ocN7LJi
 jgNthKfomAjVYUJjt93NBYfL9MG9yTrj/7rhULdbIjBXl/tvLpQOM3zOszrMby7vNRam
 hLNPmqdN4n5REAmT+YALwcQibnUiodaXVaqMXEbk1hMJRr/nOr3H/FgDaMSiyxzao0zi
 cbcDk3z6P3EEIP65pPRWuF3lc/bxOAcOtfK5RPGV9wvX8CBgyOCZjnaB4WbARpP2Z1Mv
 FXAjdTvcp/Xw7kl3oC9A6ZtOSTua1hODU44fiXQGPpws3cuzt/wDKyPoBOI22OV7ZGWd
 BsLg==
X-Gm-Message-State: AOJu0Ywgwh4RD7y/D3jtd4fkmwtzAjfcgDulxZWdYDppItCc7QlC1ZvH
 FIAeVbaL4tfn1qUccGStdfYLRcISoBIg7tLAKpWhENKMR8wjLOqH/nxWkpVUBSP86ZZDcTn9MVk
 OgElIVCWD/bD+XUfBJKvlI+GfLAS4GfPPs36xNmBWiv9OdmBssp+7
X-Received: by 2002:ac2:44d2:0:b0:511:531e:6b61 with SMTP id
 d18-20020ac244d2000000b00511531e6b61mr1550807lfm.59.1707498705352; 
 Fri, 09 Feb 2024 09:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMqoiHf0LYu+AYHmXgpUDXxF4q7z5OMFgF+UMXGyDrxT/0wgUK+1m8No9PmXkefQh3ik3nPg==
X-Received: by 2002:ac2:44d2:0:b0:511:531e:6b61 with SMTP id
 d18-20020ac244d2000000b00511531e6b61mr1550786lfm.59.1707498704970; 
 Fri, 09 Feb 2024 09:11:44 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWBmHXlmt8xTxnu+JoUL42AlYA6IL6e98vsTw3RZWtYBZ1y+kh45/Y38smQcXpUz1Jywmod+kxIxHbgdOfYuwq7+XIP4tUhmFrwX+pHmjCUU/osgjNmo2jokAMB0/qxVh2K90jLK7cNUHwTgmyQmMhxYFzRqQrVpAkKLcldGLDjYcP21o7QSGXETOQSoQdtWUvEqvGAde0edaRGe1QhwOfYYiG9HCX2/KzVv0s439jPop/diYcWu6LRJgNbK8AZh/MzDahfRsClpjRfPr9ECw==
Received: from ?IPV6:2003:cf:d740:65dc:b9e8:48d5:8408:b27?
 (p200300cfd74065dcb9e848d584080b27.dip0.t-ipconnect.de.
 [2003:cf:d740:65dc:b9e8:48d5:8408:b27])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a05600c458b00b00410504b582csm1214995wmo.11.2024.02.09.09.11.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 09:11:44 -0800 (PST)
Message-ID: <da2cc849-65dc-4ace-bdd1-e0eb02c41bcc@redhat.com>
Date: Fri, 9 Feb 2024 18:11:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] virtio-blk: Use ioeventfd_attach in start_ioeventfd
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Fiona Ebner <f.ebner@proxmox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Fam Zheng <fam@euphon.net>
References: <20240202153158.788922-1-hreitz@redhat.com>
 <20240202153158.788922-4-hreitz@redhat.com>
 <566223d4-514a-4282-ab51-1abc688654e2@tls.msk.ru>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <566223d4-514a-4282-ab51-1abc688654e2@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.269,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09.02.24 15:38, Michael Tokarev wrote:
> 02.02.2024 18:31, Hanna Czenczek :
>> Commit d3f6f294aeadd5f88caf0155e4360808c95b3146 ("virtio-blk: always set
>> ioeventfd during startup") has made virtio_blk_start_ioeventfd() always
>> kick the virtqueue (set the ioeventfd), regardless of whether the BB is
>> drained.  That is no longer necessary, because attaching the host
>> notifier will now set the ioeventfd, too; this happens either
>> immediately right here in virtio_blk_start_ioeventfd(), or later when
>> the drain ends, in virtio_blk_ioeventfd_attach().
>>
>> With event_notifier_set() removed, the code becomes the same as the one
>> in virtio_blk_ioeventfd_attach(), so we can reuse that function.
>
> The mentioned comit is v8.2.0-812-gd3f6f294ae, - ie, past 8.2.
> Is this new change still relevant for stable?

Sorry again. :/  This patch is a clean-up patch that won’t apply to 
8.2.  Now, 8.2 does have basically the same logic as described in the 
patch message (d3f6f294aea restored it after it was broken), so a 
similar patch could be made for it (removing the event_notifier_set() 
from virtio_blk_data_plane_start()), but whether we kick the virtqueues 
once or twice on start-up probably won’t make a difference, certainly 
not in terms of correctness.

Hanna


