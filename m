Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83579C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5WJ-0006y6-Lt; Mon, 04 Mar 2024 05:26:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh5WC-0006xf-F1
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh5W6-00011B-DI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709547952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nLBw5DI+HkOc61np9eEZ+ycggiS+V8GDHcnTnLml3HM=;
 b=gbitv/uajGQyScd/vfFFJZFy8s8mDzy4nZUw/kyiYfDIyonnM7b99a4ymEI8K8qa8zLMRQ
 6d6RzgwB+0Ibnn9mWp7nD1DXYxgvYQxUEdid5W5f7ZWRdaK2CPwLq9lXy6ef0y/Fq0NCL1
 9Dwg9ejR8VYYTCKB/NfiUguvajD5O7w=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-mhSUS1j3MHCXRrqGhFmn1w-1; Mon, 04 Mar 2024 05:25:51 -0500
X-MC-Unique: mhSUS1j3MHCXRrqGhFmn1w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so1638086a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709547950; x=1710152750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLBw5DI+HkOc61np9eEZ+ycggiS+V8GDHcnTnLml3HM=;
 b=sLY+/C7bQYbMutKiUQxBZyk+d16fiGv8VYaMQu+B5mxYFWiZvHzCV+CHn5Uuk4egUa
 uh+l6TFOWOJqFFVdf3Kti97ReTpIKBR/BxoE7P4U/s/YdvixxCdR4mhpjSf07j9/10Nf
 mQPPHy90AcJsASqbyUwkDEztHUmqQKtYgOzBdEKHK7cfo3CvLnKyWcCcCqZYwdFq8lZH
 V2jCg+gMt1X8idQly+H8aq6emzABhkTKb2pmWBQf2myHZI+3gHuJIWEt4c0T91aZhaX3
 XET0PjsAbeH6ao+TRm3jIgpoGkIrZs31F00ApdNnnRUGW1C1Xrf0TSEVyGdVT/MsQGwy
 xOBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxF6ZVl7jAaM1fvmzCkQbMr8K2Y+cQny+Q1P1XGL5hG51VLMWN3EqJX53MYw+SJeGF3Fp86VoZRPhteNBiw1Bn2WwCFks=
X-Gm-Message-State: AOJu0YwlstFWznxb7q7A0YWjV/b3CB95THR5cezp8ezH3ubv3GNkpNuD
 fjMY1xWYnvI2YsrjxT6kURGdtDG9U9orvtjubsW31XBWCvdGnBKMTo1hJo6Gs/ORh0f3t7l2r+w
 G6vq/jbPSAlgohstuv6WYFdVG9QkTk74NUAWyl01RegM250T7rQ+L
X-Received: by 2002:a17:902:a517:b0:1dc:3c:fb67 with SMTP id
 s23-20020a170902a51700b001dc003cfb67mr9227392plq.5.1709547950251; 
 Mon, 04 Mar 2024 02:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMs82vokDnnqBxgAHN8/LUylqcKlptZA80vfHYxhR7rocJJai+p8R+d8hrFH0PBWzTakB2mg==
X-Received: by 2002:a17:902:a517:b0:1dc:3c:fb67 with SMTP id
 s23-20020a170902a51700b001dc003cfb67mr9227376plq.5.1709547949923; 
 Mon, 04 Mar 2024 02:25:49 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 jv11-20020a170903058b00b001dc96c5fa13sm8124354plb.295.2024.03.04.02.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:25:49 -0800 (PST)
Date: Mon, 4 Mar 2024 18:25:39 +0800
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: stefanha@redhat.com, jag.raman@oracle.com, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
Message-ID: <ZeWho6ZW41tg0rob@x1n>
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240304100554.1143763-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 04, 2024 at 02:05:49AM -0800, Mattias Nissler wrote:
> This series adds basic support for message-based DMA in qemu's vfio-user
> server. This is useful for cases where the client does not provide file
> descriptors for accessing system memory via memory mappings. My motivating use
> case is to hook up device models as PCIe endpoints to a hardware design. This
> works by bridging the PCIe transaction layer to vfio-user, and the endpoint
> does not access memory directly, but sends memory requests TLPs to the hardware
> design in order to perform DMA.
> 
> Note that more work is needed to make message-based DMA work well: qemu
> currently breaks down DMA accesses into chunks of size 8 bytes at maximum, each
> of which will be handled in a separate vfio-user DMA request message. This is
> quite terrible for large DMA accesses, such as when nvme reads and writes
> page-sized blocks for example. Thus, I would like to improve qemu to be able to
> perform larger accesses, at least for indirect memory regions. I have something
> working locally, but since this will likely result in more involved surgery and
> discussion, I am leaving this to be addressed in a separate patch.

No objection from my side memory-wise.  It'll be good to get some words
from Paolo if possible.

Copy Peter Maydell due to the other relevant discussion.

https://lore.kernel.org/qemu-devel/20240228125939.56925-1-heinrich.schuchardt@canonical.com/

-- 
Peter Xu


