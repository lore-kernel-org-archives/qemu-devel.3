Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4D3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 16:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2D8e-0004rY-P0; Wed, 01 May 2024 12:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2D8c-0004rG-3a
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2D8a-0002xW-2p
 for qemu-devel@nongnu.org; Wed, 01 May 2024 12:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714582135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ohNGIUj4BzMtbo59hT8sI2kZRGTTjj2YaBysqXDsOI=;
 b=Vdch5PfKQLTX7O08VXD0WkOuu7yOaOgR6GighvkMXZy/b3vf34ZRLYESrqZN7ZUmB4B137
 yb/Jz+tGygct7oZ5N4xWCGBkLnsS+W6C7WK8mxBMKcaAzBs6pRfCxEpYzTRmMohCwkfpv0
 Y4L40pD1egkFdAkJZITxhhh9Z/iDfqU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-UGaZDI3GOfOUpiminVM--g-1; Wed, 01 May 2024 12:48:54 -0400
X-MC-Unique: UGaZDI3GOfOUpiminVM--g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-69b37bbded3so18134666d6.0
 for <qemu-devel@nongnu.org>; Wed, 01 May 2024 09:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714582134; x=1715186934;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ohNGIUj4BzMtbo59hT8sI2kZRGTTjj2YaBysqXDsOI=;
 b=Ll3rbRp2FO7VQY7zvi3rBwu06piGFI1KSUEsZlTmLlOYgZit08K3HqpVVtneBic6Wn
 jg6ywlMUVtqj1QNWNzzM7wb6wrbNIHKopLE2SIp9JywU3ddGwWjwSifoEpjbV8rkHzRc
 luLEyZD/S7ZaBSfKe6o3T2yc+tves5NSMKQkOtKxNrrhH7O4GudY0ceULx4W6+ogOHSY
 DYQW/Q8jSzSWR5yWedqWgGfYD9S4TLiSxmawy49w+XWFgaWpXyZxQt1+50QKPBEJ3V22
 9QtpFcL4mM3IplWbsuFQdsyHb0cpsA5kE0Iyzg+ECW/l2639//Y2dxwKho7/uAfyuPKN
 e6Iw==
X-Gm-Message-State: AOJu0YwaSZeAoIqYva/f4Q5U2bN3TF4iQN7R7gUXOjaGsZak8QtfAP5N
 Q/MVOMq92Jp2zTSzrjWo6Vw1ihA1DVSKWb8tfd54cV6eFfkq3HJ3rJ6V36/H9w3wOS5Xz55RxrC
 mkTJrMUY6DtmtRkqYwALuYWwSl4pRsojPaWONVsbbRxqwtLBrmdqm
X-Received: by 2002:a05:620a:1a83:b0:790:e856:7cc9 with SMTP id
 bl3-20020a05620a1a8300b00790e8567cc9mr3254828qkb.1.1714582133476; 
 Wed, 01 May 2024 09:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEj2on9s0wynIY3ZWohtmwo2ehBk2NmeS1RYGS7nP58MDlYJZhQos/YRzc6iPzwvnQJDqdIgA==
X-Received: by 2002:a05:620a:1a83:b0:790:e856:7cc9 with SMTP id
 bl3-20020a05620a1a8300b00790e8567cc9mr3254804qkb.1.1714582132699; 
 Wed, 01 May 2024 09:48:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 wh13-20020a05620a56cd00b007906ab7b0b5sm9964736qkn.11.2024.05.01.09.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 09:48:52 -0700 (PDT)
Date: Wed, 1 May 2024 12:48:50 -0400
From: Peter Xu <peterx@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, sstabellini@kernel.org, jgross@suse.com,
 Vikram Garhwal <vikram.garhwal@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 01/17] softmmu: let qemu_map_ram_ptr() use
 qemu_ram_ptr_length()
Message-ID: <ZjJycn-MfBIpK5fT@x1n>
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-2-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430164939.925307-2-edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Apr 30, 2024 at 06:49:23PM +0200, Edgar E. Iglesias wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> qemu_map_ram_ptr() and qemu_ram_ptr_length() share quite some code, so
> modify qemu_ram_ptr_length() a little bit and use it for
> qemu_map_ram_ptr(), too.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Vikram Garhwal <vikram.garhwal@amd.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


