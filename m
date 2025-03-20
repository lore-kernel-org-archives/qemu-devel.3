Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE560C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 08:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvBQr-0008Ea-Ga; Thu, 20 Mar 2025 04:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvBQp-0008EM-Dy
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:39:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tvBQm-0008Nh-TN
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 04:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742459951;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kawN8ff0naJMwttcxnyWTAaAivkiN3nTKEWRsU0RLs8=;
 b=LUmLGJ8iq7xjwXFE0JckFgkn3NZ2YcXznEn9URoOzoV1Ji+nahtbPaRw+v/pe0doexH5i0
 LMGRNhb6WplnbpjG/Z71XvvGr51MCAnW/GcUJmRSjezAVvdWOWcGCwHBxB0Z9ggUOyQR/A
 GXgLDPxSO3Cu8To+9oWzxkgd7mi5bTc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-WW8X1qZ_O12dZll8RZRekQ-1; Thu, 20 Mar 2025 04:39:09 -0400
X-MC-Unique: WW8X1qZ_O12dZll8RZRekQ-1
X-Mimecast-MFC-AGG-ID: WW8X1qZ_O12dZll8RZRekQ_1742459948
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-438e4e9a53fso2545915e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 01:39:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742459947; x=1743064747;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kawN8ff0naJMwttcxnyWTAaAivkiN3nTKEWRsU0RLs8=;
 b=b+vvwC6AGMJCV3PZDCaIYy+MaXHNmsxRFspm9Hw66NtPbWdlmZn7VN2JwH+IFhVfPQ
 VvVCAEP0UIXq/UncYzuim4YYXWcaVEai3tdGbABcu5gqySD6fcMcpf+1bVKy55vpBDI2
 FimHy0hyGbUezs67QV+dO5zrMiVgbnHd2YXe8HRFYousBvg2LcvTuCwthwOP2JWU5X9R
 LwgSWac8EfBck/cR4FyVJqlsKzafymlRAInf+cMUSvx3fsY56uz7UDk9/02anpyAjvfg
 HsB0AZ0DBeRbTUxfJqVegHOXXABGFxe8EX4Fst2eY3wNRLm4ATnQHLD/kmMUKz5jOMv6
 egMQ==
X-Gm-Message-State: AOJu0YwNbmnpbqSO2LzsJXWEPfUtvveiQ9E4IuyZs9oWgbz86bGIDAZ1
 xNc6cvawcGgzc3qY2qwhOtWKM+aYVP53Ro/8o0WKNKnQ3VGTHus84rVaiPMGPXV03cANi4x/ZVK
 JigRGTsCSdYNq+/nCEwxIhGLinYvTU0OttjBjMAF7HSPHk+Xri11QtchWJrHhSNlveGL4wpPAqa
 CyyUdKmjdMgFr0Ymx4TkNSy4btByyLlZpNWo0=
X-Gm-Gg: ASbGncsx9H4g3AkvXEd87KTmqAc9eOR30gFX8xysF1+w1uC4HhrLhRzS7QaDf07irO0
 9V95uCeIC9ZdYv4B4CMvFy3jbXYyF8hnP0FjX+o2BXVnsfY999BIV+2lC3+OXu21cf8qvZTzdin
 g=
X-Received: by 2002:a05:6000:188b:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-39973b070e6mr5494027f8f.52.1742459947531; 
 Thu, 20 Mar 2025 01:39:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR8wdJMTb+G82qchZ4T8RrSWsRpQE2XnP7C4Q6dEfkjIO+x0rCbblySGD+ogs/MFEHib5an/Tl8B5J2WC6wp8=
X-Received: by 2002:a05:6000:188b:b0:390:f9d0:5df with SMTP id
 ffacd0b85a97d-39973b070e6mr5494007f8f.52.1742459947092; Thu, 20 Mar 2025
 01:39:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
 <20250311155932.1472092-11-marcandre.lureau@redhat.com>
In-Reply-To: <20250311155932.1472092-11-marcandre.lureau@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 20 Mar 2025 14:08:50 +0530
X-Gm-Features: AQ5f1JquoufF5wDxzd3RF6uN1byu0B-AiamQIIpDICV8UVYWVRoib3IOmJ1ZiSs
Message-ID: <CAE8KmOwiL+GNf3d_4W5Womh33UUP1oM7a6tQstDra6v=4rLTnQ@mail.gmail.com>
Subject: Re: [PATCH for-10.1 10/10] ui/vdagent: remove migration blocker
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
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

On Tue, 11 Mar 2025 at 21:44, <marcandre.lureau@redhat.com> wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Fixes: https://issues.redhat.com/browse/RHEL-81894
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

* No commit message? Same for patch 09/10.

---
  - Prasad


