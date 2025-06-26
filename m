Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C74C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 06:35:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUgCY-0007DC-Tf; Thu, 26 Jun 2025 02:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUgCT-0007Ca-5F
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUgCR-0002aq-0V
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 02:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750919704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HlalzFrkdxqIR0nWaTZ8uacUQbYuEOK6zli0aE/uWlo=;
 b=i+VCe/E7zrCWlvTCZzHItDx66yMK4wEYses33z8iedUimsCC/uhz747BdDn6QVkirg5PS9
 hTqN32AUroqGdfWtJzQ1AU1z+xxo/eLTpR8pjXjj9T6jD7hMhsmfIsWgnT4IZ6cwJGQikE
 XBMvuDrbJJ26xxE2A6sykUFknpOKiE4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-_5Tkam7GNPybWUI0__ljwQ-1; Thu, 26 Jun 2025 02:35:02 -0400
X-MC-Unique: _5Tkam7GNPybWUI0__ljwQ-1
X-Mimecast-MFC-AGG-ID: _5Tkam7GNPybWUI0__ljwQ_1750919701
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so844548f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 23:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750919701; x=1751524501;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlalzFrkdxqIR0nWaTZ8uacUQbYuEOK6zli0aE/uWlo=;
 b=D0JYLbz5TukzyPHboHhmn0SYcWBw9sWxL4RLouczNq4BnTDfgzAEaJe7W+hPJfch8L
 7bWkAbHzJGFYkc1oSJeCtD/x9dlL97xJNig1ppxn3idRg7GjhoAA7Fbt63sq3eA1tNI2
 BB/JxMrAtpTJ1F8JmgDESS7aIwjQc5n1nCs7RPbmeuyCz31Mj3MRJ69W04yiTAOejwPL
 3Tr/fK9dqDDfS+JPdKoxX7zsGpMwqJmITUfEC/pflo/WemI9nWWDW8gvVDTYcZL+i/JQ
 Qvf1WhU/nstMapnlm0DVzWGlPILhTh/GOtto8APOXzZFKC03ONIOrvfj4MJrjct55iBg
 FjXg==
X-Gm-Message-State: AOJu0Ywy3fElD9a/v58VPGIuwlvDcYkcDLT+owpERxpsjpSOWpAaPkaZ
 k8QaPB5ZaNXzjN7PS7DIj2lThjWUN3Gl+iTt6n/ZlpFYUIJ8EgpjgXbGz/lfaHWn7pVTbgdw1Ww
 hSK6ZJyx9DNP82sQB6AqVF9O9RirR4ZtZ2EyBuzKj5334zM6KL/O0/3Xs
X-Gm-Gg: ASbGnctoQWCqv0GmuihnUhwksgh38ybk5fZ92Ww1p8Uh0pdTSVBDG6l3uFZpX9BE1Z8
 G6m8XIWl6i9A51lHDd2h/i8Cb4HY5FCjUlKICR8GRp/Ut33F5TpQisizHmENwTuyFgW19m8fSJr
 gOsJq8v8kSI20jOc/KX+XKm4vH4WDqwIXHVON5uFtLkFQuvJd1spcsTUYHqk3Sdtn6uBb9jg6Ng
 +4YSJZeA5uhm5VY8eGYagAkb5uUFWY90gr0ajZj47Pa/u+YcaN47AAKvqqdJV8PziN8dcUShRwV
 Qw/FAmXgeF8eLI0r
X-Received: by 2002:a05:6000:480f:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a6f30ffc7bmr2062242f8f.1.1750919700885; 
 Wed, 25 Jun 2025 23:35:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl30FE5tkTjqP/1JqHx9oWPCSKASOwx45TDBmPdfv0i0yL3oBg10/pw4hbs8kC32qT2IKZVg==
X-Received: by 2002:a05:6000:480f:b0:3a0:b565:a2cb with SMTP id
 ffacd0b85a97d-3a6f30ffc7bmr2062222f8f.1.1750919700500; 
 Wed, 25 Jun 2025 23:35:00 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8050e09sm6570187f8f.19.2025.06.25.23.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 23:35:00 -0700 (PDT)
Date: Thu, 26 Jun 2025 02:34:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <20250626023413-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616092241.212898-4-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> +The QEMU project thus requires that contributors refrain from using AI content
> +generators on patches intended to be submitted to the project, and will
> +decline any contribution if use of AI is either known or suspected.

What is this suspected thing by the way? Suspected by whom? You do not
think this is draconian?

-- 
MST


