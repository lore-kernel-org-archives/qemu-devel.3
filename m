Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2883FEE57CE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soSXw-0004rf-0i; Wed, 11 Sep 2024 14:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soSXu-0004r7-OE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1soSXt-0005HU-8W
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:58:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726081106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vfa3kbnlzQStc5sVV8TNOhEMIfyHp+YyqWBkA/IhNEw=;
 b=i5speplcOdH2JJXd7FZwOf5ljv+lSl9/T+/sfV+nsSDnzJz07PH8KLSQj6jWhFlOWyrzE6
 4MLpBl1oBHmlwtt/EoIZ5YLVQ0LwGYK77YraKamI8XQ9qweQx7DyNtgtXAn2PKn8OrIZFp
 Gw83T5H8r0zccwR6+8teGKPdJZu5NDc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-v5Foaw07OXyNITUpYydObw-1; Wed, 11 Sep 2024 14:58:24 -0400
X-MC-Unique: v5Foaw07OXyNITUpYydObw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c3554020afso1620806d6.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 11:58:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726081103; x=1726685903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vfa3kbnlzQStc5sVV8TNOhEMIfyHp+YyqWBkA/IhNEw=;
 b=hQCp/EPQP+kEhzx6EVocPYrq5qbgx2AsWMXbO0+K/VXIv6it475NEv6SoGpuWML5V1
 wRG7L57YVp4XJNPwjMH6uVRtHvQYhAGUgwdowqTiNrbGuPT3+dqi3iSljxhUgB0Dv7va
 3Y8PKHr8iFf9joXx2CVJNa5GHjfMfU1VZKDjVoD891gV5gh3Rsvf+ENkIbLtvG17T71F
 5O6gWZMFdax8aD7YgWoO2vqrfmPe7KgjgwsippOoK39J8tcHqGLf5o5S56fm6LeH3oBh
 RV7p9IOIcbASX91ScBlDEQqNCpl4jIMMeQHqmOdy6oiXB9EuqXWnh/rOyu7YwcH2iGUp
 Lwiw==
X-Gm-Message-State: AOJu0YyitA0hKf16Ad/z/dynjaa0sy3B0bn1YfxC2DKOgx4d1QHZXhni
 7Jeze3KpoxgfIUdTraJf09BtzN5ueNBUWgRWukIZ1qvIbjuawAwx8RY4AUxSORBPv30qE3fnDOl
 eL2K761KBHLEozhi8ZykxvfDAvc2iAFWzYbqxB4OJ1oyb18CF+mxK
X-Received: by 2002:a05:6214:3d13:b0:6c5:64b2:f4d5 with SMTP id
 6a1803df08f44-6c573532d57mr7730866d6.22.1726081103540; 
 Wed, 11 Sep 2024 11:58:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEo2uSI5Et1lynQpd7EcidHhSd6rh79Cj9JVNIU0jprE8UktciqN+/3+MkkZWd0Bt+X2OQjvg==
X-Received: by 2002:a05:6214:3d13:b0:6c5:64b2:f4d5 with SMTP id
 6a1803df08f44-6c573532d57mr7730746d6.22.1726081103268; 
 Wed, 11 Sep 2024 11:58:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c534339992sm44970076d6.45.2024.09.11.11.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 11:58:22 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:58:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH] softmmu: Expand comments describing max_bounce_buffer_size
Message-ID: <ZuHoTOes7__1yUPl@x1n>
References: <20240910213512.843130-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240910213512.843130-1-mnissler@rivosinc.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Sep 10, 2024 at 02:35:12PM -0700, Mattias Nissler wrote:
> Clarify how the parameter gets configured and how it is used when
> servicing DMA mapping requests targeting indirect memory regions.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


