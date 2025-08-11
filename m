Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0241CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUsO-0002oZ-UU; Mon, 11 Aug 2025 11:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUsN-0002oA-JM
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:55:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUsE-0005aK-KJ
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754927743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7sR3GB6/Hiz8o4RPLLWcEmgPWUsWJ8UMocbuLxgkzVI=;
 b=Ai/82x4dnZmtBj7c9FsmWVLqYVww3iCJLXzUpRy2buTMath5phnDJQvg2z+9pxpkgisrK/
 Dh7yJ3w7WOhLEnPM+5mcxQXTRsu7a8/n1rlQUOERWNttx92RoQDeZZSJpHo95tUrsdyt+W
 vhhc6rZ7sEGo4w0zwR6hdQkLHhZaHT0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-_sWEyXSQNZ-2IodrxDI0Uw-1; Mon, 11 Aug 2025 11:55:42 -0400
X-MC-Unique: _sWEyXSQNZ-2IodrxDI0Uw-1
X-Mimecast-MFC-AGG-ID: _sWEyXSQNZ-2IodrxDI0Uw_1754927741
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4af14c04e5fso171928001cf.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927741; x=1755532541;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sR3GB6/Hiz8o4RPLLWcEmgPWUsWJ8UMocbuLxgkzVI=;
 b=AVlfftxDKTgwhbwQc3wd1B1RKO6CDcW0vkrh98JbpuicLO0WFXXqmalXXLvmH3bigm
 lzvPnoGKmlEiJWh2hiqi6PzKBJGKhtWAc2Doociiyv6yuUddfRoAPfqQRx8TZHMZ1yMc
 rZMLYES6DkmoY8/vkwEqFaWyWp62dtmrBDOUkkqEZaflzgs3kFpRAfM9v9+a1lWVmFEJ
 7SZnpPOgM+I04kBi7WWGLHKBGtpWgEL0KtocTlgWXVSFdcc2ZNSSsbONBM+R+I9e4D30
 BoLBOqcZjZ1XAyL/EIOe4g2LVjnDvYXVxlKIcvKCIu7/12adoarGCKHLlPPHCvxd8uDr
 DsgQ==
X-Gm-Message-State: AOJu0YwcwnpCVWebTk73CwFzSbstUH4Lh088Q0jA4ImRcCzOJxRI4zoz
 lox3zho8CT+iA31T93VGIg59CxNr/brOsX5qX4xsCPc3gARwr6Y1TISbtQ+9nRa1YhY7J1JO7oP
 IDvK/KEoqJPYS1fQSPYMN0y8TGoAvZqrPMEOUlVDwv3st8g0SrXJggdho
X-Gm-Gg: ASbGncsFPSauM1uCnVAIFC9IUpodcpZ7AjTPhqYX0KdYUgX5Yioz23BJ+hGo5gCELlI
 Lneyi5yLBOq9o5KFbhGisoEIanhZwWnSynbO/0FZO9okaFPdOAoFqrcmhc967vXc9RkOxpWt3Wq
 Sw1GcvnyYalPhWV7To1G9aut1DguqLG8WUNBWVYJwvfQVswpB8N8QNmaYr/53Oaq70igY5PIvcJ
 0ejEFvflGcFs+9Qne1XO5E+IytfzUd1HWv6ze3ZOUCQvRXFwINaLxyF+8KIL9RQF11iRyYeR4pG
 qCPBgcUmnizG5Q1IEI7dj9R+YbtdQg4Z
X-Received: by 2002:a05:622a:24a:b0:4b0:9814:e225 with SMTP id
 d75a77b69052e-4b0ecae2b94mr960371cf.0.1754927741357; 
 Mon, 11 Aug 2025 08:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdVRZByxt08WQfY8kxEQlFn5x+ocg9nriQOeynwHRd+LppBJIMyXY6kHwZHuAi9A4AW9Ks2g==
X-Received: by 2002:a05:622a:24a:b0:4b0:9814:e225 with SMTP id
 d75a77b69052e-4b0ecae2b94mr959891cf.0.1754927740852; 
 Mon, 11 Aug 2025 08:55:40 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b069ca56e5sm104104381cf.40.2025.08.11.08.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:55:40 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:55:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 02/10] acpi: mark PMTIMER as unlocked
Message-ID: <aJoScE8-LraMm3TQ@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-3-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-3-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 02:01:29PM +0200, Igor Mammedov wrote:
> Reading QEMU_CLOCK_VIRTUAL is thread-safe, write access is NOP.
> 
> This makes possible to boot Windows with large vCPUs count when
> hv-time is not used.
> 
> Reproducer:
>   -M q35,hpet=off -cpu host -enable-kvm -smp 240,sockets=4 -m 8G WS2025.img
> fails to boot within 30min.
> 
> With this fix it boots within 2-1min.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


