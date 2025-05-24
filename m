Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A468FC54EDA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 11:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uImj4-0002Oj-9M; Sat, 24 May 2025 07:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImiv-0002OO-VH
 for qemu-devel@nongnu.org; Sat, 24 May 2025 07:07:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uImiu-0006vB-C2
 for qemu-devel@nongnu.org; Sat, 24 May 2025 07:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748084847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxux+cQznw+yXgLhUltPmceByWr9BOkwRx5pPAy7P1U=;
 b=IT3zjuOui9Tol9UoxkfkvnVmUEjyesbPEkFcG2MK++wUCkEr1e+QJuL5my3diPNsq3G/OD
 ZXBMgDpSbuM+HedQY4a9oMqMl4nJlRSsQ+PoskHKLeOJaC8ejpt/EJv7wgQXAL5YgZFhFL
 9bOhf6HCzbhB4/CioMSFNzrVhWlZcE0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-rRKvDz4WMgqDmT5_VCe1xw-1; Sat, 24 May 2025 07:07:25 -0400
X-MC-Unique: rRKvDz4WMgqDmT5_VCe1xw-1
X-Mimecast-MFC-AGG-ID: rRKvDz4WMgqDmT5_VCe1xw_1748084844
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d007b2c79so4970715e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 04:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748084844; x=1748689644;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rxux+cQznw+yXgLhUltPmceByWr9BOkwRx5pPAy7P1U=;
 b=SXG6yrXI9TkuNvUMtK+MEfMJA0KXOaxKOI3+2BO/JA+0c6II7pgR6ol2uQq5xUp8zm
 WKIn8Jsgg0GQY9MiZ41RcuijJGKNET9zxuur6lkAKeSXfytyPgked/xweNuLOX0/4MPp
 b7TMTHQTMXaqJWokgYJdZrF3JbR3489NmdrrHDzyK7v93q9tP4e2VGsDWR8ArrzrFK8Q
 XblN3G3ZKD7pw5+asDw4WllGxr4MT0Sfq+iFKWAGUy4/aofhHe2d0RFk7Ad4+043zj01
 Y7QHJbFSVJwMH8NtOlgWiiH7vzrX+8NxSux88c0X1e3Bp40KTyCGkQbJiTwmxy/g9p2q
 2qTw==
X-Gm-Message-State: AOJu0Ywvaz1yg8EzHFAnkphkuGWgKWC/AG54m7dgNAgazS7/OpC5auAi
 XyrZNHWT3XybkxR3kYm0HQv1PSyEVkXOJiES6ZrY2sffPhC4NTJ2FNKuwrkeVCXqERokhXnh6L4
 fEDVjiwrepMOkAUwl6JDG2vWdW0XwSKkb8lpQrci+ES99Y/P5QHZUNFT9
X-Gm-Gg: ASbGncu2bmOv3Il75UvG+VGCHvkJ3ztyV0SUbucDpR/9DE5ipIIt/8wQlJQ02v7o58m
 +wCGZJPq/f5/fI+EEl0Z6Ta1l9zaznCe7Wr02t2iyO3OUsvyyJJGLYEje3NzFocyRqkOy8GevSz
 6s70gMTSdy79bhxRJOSX0HtbDJMRnZMjp6Xdfv7hwBmVbDInkSZm983XTFr9Mr+fCUnkSLgaJML
 9ua+kIWnV4VFoU43nDvURNZ0Vxkr41ve2WUor5UOuEMC9k/Rr/wuJp0QAKV/lI3Z+rR6VZcsB6f
 K257rg==
X-Received: by 2002:a05:6000:4025:b0:3a3:6481:1ca4 with SMTP id
 ffacd0b85a97d-3a4cb4834a6mr2045457f8f.43.1748084844455; 
 Sat, 24 May 2025 04:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIdmZ7+UJ82oRdZxMLzAzUQq5lbxki/nsQRjm6s4zlx+cZ26y6lQ/1WkDkalFqZjVeLSfbjQ==
X-Received: by 2002:a05:6000:4025:b0:3a3:6481:1ca4 with SMTP id
 ffacd0b85a97d-3a4cb4834a6mr2045434f8f.43.1748084844069; 
 Sat, 24 May 2025 04:07:24 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5a841sm29916764f8f.34.2025.05.24.04.07.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 May 2025 04:07:23 -0700 (PDT)
Date: Sat, 24 May 2025 07:07:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH v3 10/20] MAINTAINERS: add Akihiko and Dmitry as reviewers
Message-ID: <20250524070711-mutt-send-email-mst@kernel.org>
References: <20250521164250.135776-1-alex.bennee@linaro.org>
 <20250521164250.135776-11-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250521164250.135776-11-alex.bennee@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.298,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 05:42:40PM +0100, Alex Bennée wrote:
> Thanks for volunteering to help.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>


Great!
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8dfb393c06..a14e2796e0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2674,6 +2674,8 @@ F: include/hw/display/ramfb.h
>  
>  virtio-gpu
>  M: Alex Bennée <alex.bennee@linaro.org>
> +R: Akihiko Odaki <akihiko.odaki@daynix.com>
> +R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>  S: Odd Fixes
>  F: hw/display/virtio-gpu*
>  F: hw/display/virtio-vga.*
> -- 
> 2.39.5


