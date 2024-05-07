Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09108C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4R1J-0000AM-9p; Tue, 07 May 2024 16:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R1C-00008G-23
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:02:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s4R19-0006u9-FA
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715112146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u8LmkKztR/usfpOFoEBc359ghd6Du5/5DLJmmMdkS1A=;
 b=Hca68YjpYc64nWSKEWkh6q2uTaCFHmY0yAHsO/yASv/2js4oLRF4d1vU9dI8LaCL9arxng
 Qnyzj/ztc6eE2J/NU5RlNtSDK1XjRGgxoKrOPoPhgd0DkkAMTdncsnTTXMDEXWsF8nLEfG
 xd/jE3ldwo2Xwm7tUWZr/4ts4TPIDGU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-sS_V_M1eOcOlHYKfVv2ILw-1; Tue, 07 May 2024 16:02:25 -0400
X-MC-Unique: sS_V_M1eOcOlHYKfVv2ILw-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-43a3632d56aso5366001cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 13:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715112144; x=1715716944;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8LmkKztR/usfpOFoEBc359ghd6Du5/5DLJmmMdkS1A=;
 b=QY3D+qvIhLxYrfbpRuvxz9SsgAk2MbM2X7i+iN5Hh9PnyjKmBbechKA4cGhEKymPQu
 pjqtOBtzFYfB/GUIeODCSGHJF5u/9DfViiEIvxSD5q2gYDMt8XxelbGDywdq8n6QDLse
 w6pkO9Z4rcDpQelHGKif/E5ImsVPFytr1r63MwB8/hVDGL6UF2+wIpK8PmVStNcjmXhg
 0KU93xJdyzm0RIGf9e5doMgduuhtwfaGdbFdqcLoSaxn0vlhFThEbuzOm1QD8IoBsu4w
 TaxUTWYCQ2qe0vFtvYIEI6nMWxIqo8foaR45GL096GLfcKZ2LFOvT6E0jNVLgLd4buTZ
 +6dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTQvtc3gZDIQyRNRt+97hpocxxZW/QZa2cfTfb7DHoQUzkDlF2qym5aPPD/w5WwT5rYEfCUy9jtx9Tnff6gSHsx7RPiqY=
X-Gm-Message-State: AOJu0Yy4ciV185U73z2o4kWN+S/wUIPNs3Lo4VC7oi2GJgtuRS3+o+PD
 sTJ/C2VxyVA/B6eMeUhcSKu8frWRgqxJm+1NU/igxcr/nqKNuxtRDrCMoz5ZMFQ7bilvfBTlZE6
 JoPYjnnLZE4TwtRPNeCMlkao9BfQh3CPK/SX1Uus4F74sQuuK1EWt
X-Received: by 2002:a05:620a:4010:b0:790:c7f9:e919 with SMTP id
 af79cd13be357-792b279af23mr87393685a.1.1715112143997; 
 Tue, 07 May 2024 13:02:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb1vr+NEzajjyfNANQPtCD/uzInDl+OBR/TxANTIXQdKM5+CAL9QXysAXTkAMqH4jydg/4NQ==
X-Received: by 2002:a05:620a:4010:b0:790:c7f9:e919 with SMTP id
 af79cd13be357-792b279af23mr87387685a.1.1715112143311; 
 Tue, 07 May 2024 13:02:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 pi30-20020a05620a379e00b0079264acccd7sm5208497qkn.9.2024.05.07.13.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 13:02:22 -0700 (PDT)
Date: Tue, 7 May 2024 16:02:21 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: jag.raman@oracle.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v10 4/7] softmmu: Support concurrent bounce buffers
Message-ID: <ZjqIzRLF_oy2Jmvk@x1n>
References: <20240507143431.464382-1-mnissler@rivosinc.com>
 <20240507143431.464382-5-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240507143431.464382-5-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

On Tue, May 07, 2024 at 07:34:28AM -0700, Mattias Nissler wrote:
> When DMA memory can't be directly accessed, as is the case when
> running the device model in a separate process without shareable DMA
> file descriptors, bounce buffering is used.
> 
> It is not uncommon for device models to request mapping of several DMA
> regions at the same time. Examples include:
>  * net devices, e.g. when transmitting a packet that is split across
>    several TX descriptors (observed with igb)
>  * USB host controllers, when handling a packet with multiple data TRBs
>    (observed with xhci)
> 
> Previously, qemu only provided a single bounce buffer per AddressSpace
> and would fail DMA map requests while the buffer was already in use. In
> turn, this would cause DMA failures that ultimately manifest as hardware
> errors from the guest perspective.
> 
> This change allocates DMA bounce buffers dynamically instead of
> supporting only a single buffer. Thus, multiple DMA mappings work
> correctly also when RAM can't be mmap()-ed.
> 
> The total bounce buffer allocation size is limited individually for each
> AddressSpace. The default limit is 4096 bytes, matching the previous
> maximum buffer size. A new x-max-bounce-buffer-size parameter is
> provided to configure the limit for PCI devices.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


