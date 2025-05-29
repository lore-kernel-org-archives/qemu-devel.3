Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D9EC5AD49
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 14:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKeFa-0000cZ-DG; Thu, 29 May 2025 10:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKeFX-0000bt-8h
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:28:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uKeFU-0004o3-Gg
 for qemu-devel@nongnu.org; Thu, 29 May 2025 10:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748528925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zooyG7taXTufAlGcwa8i5BOeInAVo1Ql/g3ANNj0AOg=;
 b=JrATXa3ClB4H6EuDHOe3fseu4yzJiIvY4KSWe87hoJ5W/UDOT0AhXu3GwIZjDK7syCdBlj
 aZ7XU+HmAkFE/+OL3ZPMBGklET6lBInUr1k+LIJzHb+9nTtd64jUyhTDpPHIzplbsOgEpJ
 6k/qz/8/XomGpPyF/6zY2gboLImuQVI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-cKQaRfpqOW6HKZV-jiqKtg-1; Thu, 29 May 2025 10:28:44 -0400
X-MC-Unique: cKQaRfpqOW6HKZV-jiqKtg-1
X-Mimecast-MFC-AGG-ID: cKQaRfpqOW6HKZV-jiqKtg_1748528924
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6f2b0a75decso23371016d6.2
 for <qemu-devel@nongnu.org>; Thu, 29 May 2025 07:28:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748528924; x=1749133724;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zooyG7taXTufAlGcwa8i5BOeInAVo1Ql/g3ANNj0AOg=;
 b=n8nRzddRMda6G4pzP9uBvCSY9WQWORdQGotkU5ZML6dpfhlvEsX3huHvhoUnryl7YN
 yl2BJjDP8lbb78Y5WYjy2TpjNZPFRf4zPGlcKcEEZ1UaFnPtOt3wFEbxUoeA+mm4MDgp
 wCKL2XSS3k9z/MsMRiGLqwkGssSxfb7f3dCSVprjsMcnblXJqs7JQDLnOAOqciEzyAJe
 nxkBlgPHA5elVbg9XPW2JQyPl+4ngLWzCtUuev3Lv0KztNn3keCIfqZY194zXD/HRWBb
 V7VUK1juh62RLCCqaLXZnC2Fywd1wXKAnTYo6W7pw1opMGp4bK0o8vvWqt28XJIBM2s1
 7BVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0hODb7iQFBYTt/kM2crmiA7IPjAWQAU5eWBv2fQDzaBMkI+tb+LdrpVol8Ym+W/O9R1yD+rrLbCVY@nongnu.org
X-Gm-Message-State: AOJu0YyZl7IF+6bdM88J7QEghdXqFZntdndw05iy89DPExnGhJfmgnnh
 wco6EVX9+BX6aMvE7EHrXHuB1ga/nsOaUf3zePsesVpJrDZO0hSXnKMk2glelmpUzgRGPNtZWsV
 42mBegA+d2/FC9urIgpppSxc/NIdIBGdepMgGzo/i0InrNCPGVT3+iOfM
X-Gm-Gg: ASbGnctVDEdlPi3QwNuIvO1n4C6zDj9gFgx3VZZiKWWk4x8464kI3g7eC6XXU+tPQnY
 mH6GX+MKa1luWkWVH8Ak/nz5RIyiSxf+ofqDtCuGYX1GtR1YH1Gv6LiHhIfEbocvJDTJNpgkBL5
 XtT8D47DlQoBrfjyRRdOYtOMgDou4nk6gXVx/Fk/DB4KCkpjLYSpiuP+IY1x8e6XviriZBqoB5P
 W6s4w4ebYckhugnBKCJa4eL/JfCwtpaJ0Ar5ki1w+89chGVLqH+Ob50waZEiyHnZTvHIQMvVdjh
 6hQ=
X-Received: by 2002:a05:622a:550d:b0:4a4:3963:1e0d with SMTP id
 d75a77b69052e-4a439632314mr34390321cf.11.1748528923775; 
 Thu, 29 May 2025 07:28:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeuEmDvAxrS93abBIqkgFEiKp7JYOKEWm9lKks3EupKWGZ8iwZiYGmsomonc2Un8wAU6u70A==
X-Received: by 2002:a05:622a:550d:b0:4a4:3963:1e0d with SMTP id
 d75a77b69052e-4a439632314mr34389831cf.11.1748528923285; 
 Thu, 29 May 2025 07:28:43 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a435772abcsm8513361cf.5.2025.05.29.07.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 07:28:42 -0700 (PDT)
Date: Thu, 29 May 2025 10:28:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 07/13] migration: Replace QemuSemaphore with QemuEvent
Message-ID: <aDhvFiwjB3GgMsw8@x1.local>
References: <20250529-event-v5-0-53b285203794@daynix.com>
 <20250529-event-v5-7-53b285203794@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250529-event-v5-7-53b285203794@daynix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 29, 2025 at 02:45:56PM +0900, Akihiko Odaki wrote:
> pause_event can utilize qemu_event_reset() to discard events.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


