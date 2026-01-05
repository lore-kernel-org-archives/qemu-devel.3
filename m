Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81265CD0405
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 21:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcrh5-0006b3-Qg; Mon, 05 Jan 2026 16:00:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrga-0006JV-67
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:00:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcrgY-0002xK-GT
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 16:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767646816;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qQCG3PgWln0kHMVtilGpGOrefYrc5Ej/7IaXT4fDknM=;
 b=MZc82uTWUxdkj1MZIjx8CJvS/eNAVAEHlKL02RBJ/b1oyq9BOO5s9RtpIKmbBjq+Bpfql1
 daGQ2Z/BlJi6whCXbedUKSh/dt1Z8xbMB3qqF13fQoETjoRlcd5cIKWGofDVBWAQHvNsbF
 V/LEcRJicoFr7w+KQTjlBw1RoatppZk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-jWywGg47MUat02BjkG1NeA-1; Mon, 05 Jan 2026 16:00:15 -0500
X-MC-Unique: jWywGg47MUat02BjkG1NeA-1
X-Mimecast-MFC-AGG-ID: jWywGg47MUat02BjkG1NeA_1767646814
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b24a25cff5so75593885a.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 13:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767646814; x=1768251614; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qQCG3PgWln0kHMVtilGpGOrefYrc5Ej/7IaXT4fDknM=;
 b=DFh6pgm0iPYQOvsA6sGEUSqhQlz0gOLK0XQuwdtCw8RrDkE3a7AshR5oDgSyQQ+L5f
 aDz11tvpFGn3VfbP+lFcjV2dRLIdkDqPYSPXk7Wc/7S3/UChal6QNZkXaz/Hg0D9gbd6
 yB3JueyW91pdfTBnFrGDZU6qB5MknuRN919Fj9TuEWJ8QaBohEZnUr4zVOIVj27OZwdA
 PgYasCpID5gkC9hpYvwzOGKiNboJN497rqdt0P4DTj43ne8lBVqfV0hZHeTdpV1ELOCy
 FNVIeokD5VAjVZWcAAXEWKcyuT2umFGc9XiT1qgwB3cNNkQ4h4T709UCG0xQ92CXEjvr
 NtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767646814; x=1768251614;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qQCG3PgWln0kHMVtilGpGOrefYrc5Ej/7IaXT4fDknM=;
 b=rDTZAmz28t3DlZkICyPySxhVPKsvat0gMjbuaMDoFUYIySEniMGtGeVSQbR9+rd1CQ
 YV2X6IGrfNqJa8DAIMMcmWw8fsfMQPsGKPbFITR6OjtHu++JFG4jarIcgvONX08xRwda
 qrD/ROIFB4B0QAetgcQEru49EyF4TBsQGVx93gEf/IoxDs842KeIaNZjNwNqwJzjga4A
 g++EOFR/t2m/HBRgPt4r9TltvjXuJ5l//fnD5dLIGdNEcZW1ZUttmEhNCSE+ks4tWF1s
 352a/Bx4RUFxIrF5lw7qyqzna7g4ueCECAgPYRK6HERySlTlUvOs6GlZr3DSyO0nlmrP
 qhNg==
X-Gm-Message-State: AOJu0YwMkeYhcnzgvo8y5Q3uQ6TokhG+YcNCM5cggDIJFm2/+qmVkjwc
 AcAvwMmhljpCUuZPhIlxwWXWN3xw51dPJFu7QMwQJNGHixInH2Gu95HIh4yJjIM4I8Y5NirF8SG
 PvPDrIs8Kc3bSzfp7lMMgyu5QVrtsnat7IuaqiSM38revAxhwRJle5HOd
X-Gm-Gg: AY/fxX6YFBe0rV39U+7PZN/5cBggAl8lzdj+EZSzQP7OGTC5hIjySnVHkWOxXowHZfx
 1hv1MTwLBo0UenWVWJK77Tru3wLg/GMDzQkvp5f81qlrMv958TA6xZI0LlzMCxt51EOCfOmm4Ix
 c0RjsNkoUG03n6fk5DViNzYRX9som80269Rb3shgoBWHWQg87ci5SxV3XvLQHSFY5X66S1AwZ7u
 M3S7PJDvOfwaHs3b/wsv475iXuiBErfRUcL0TuGoBWqn94N5zBVh0Xt2wGWc8GwkvEhHs7jcNz5
 Rb5igDks8bUiaS7Mm9yC5FLNwZmKbrIbYrzsF2EFlNA1/aP0GPI+Uik+FhN14dnkqVa5yJTMXIA
 7bGM=
X-Received: by 2002:a05:622a:5c98:b0:4ee:15af:b938 with SMTP id
 d75a77b69052e-4ffa7819d0cmr11895131cf.70.1767646814004; 
 Mon, 05 Jan 2026 13:00:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl/RVXTdbSXZzErdtCRiWAnIgyiiTCwjpg0al2IUllkHf/nhsNUoWYl/HDvwsXOFuyQfvn7Q==
X-Received: by 2002:a05:622a:5c98:b0:4ee:15af:b938 with SMTP id
 d75a77b69052e-4ffa7819d0cmr11894651cf.70.1767646813536; 
 Mon, 05 Jan 2026 13:00:13 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ffa8d38e12sm1204481cf.3.2026.01.05.13.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 13:00:13 -0800 (PST)
Date: Mon, 5 Jan 2026 16:00:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 20/25] migration: Move channel parsing to channel.c
Message-ID: <aVwmWkeBhmkbrtNY@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-21-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-21-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Jan 05, 2026 at 04:06:37PM -0300, Fabiano Rosas wrote:
> Encapsulate the MigrationChannelList parsing in a new
> migrate_channels_parse() located at channel.c.
> 
> This also makes the memory management of the MigrationAddress more
> uniform. Previously, half the parsing code (uri parsing) would
> allocate memory for the address while the other half (channel parsing)
> would instead pass the original QAPI object along. After this patch,
> the MigrationAddress is always QAPI_CLONEd, so the callers can use
> g_autoptr(MigrationAddress) in all cases.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


