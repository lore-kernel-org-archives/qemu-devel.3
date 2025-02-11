Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B1BC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thsg8-0006ha-D9; Tue, 11 Feb 2025 11:00:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1thsg2-0006gE-S8
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:59:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1thsg0-0004vz-Mf
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739289593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uHqEqj6NWeXOkEn85KlhI1uqzpQbTdRlxeIaAna9uRQ=;
 b=G8sWN5C8Vxtzkw/4x/NllPq8hKt7OQz8Xw4rLjDxntrkZqNxkoqdTDxtdtNRZVvZihSExW
 fC3uTKMieinTKAcURjiD6OEaBx5JHvoxeSSl/uzhtVhGKjI/uFQ/hr5s/pbOO7IZ5/BhA0
 QCsqDXm6+AX9N7odMb9JqKOvil8d0OU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-DobkKVNBPxyuPeMyhB5ZyQ-1; Tue, 11 Feb 2025 10:59:51 -0500
X-MC-Unique: DobkKVNBPxyuPeMyhB5ZyQ-1
X-Mimecast-MFC-AGG-ID: DobkKVNBPxyuPeMyhB5ZyQ
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-47183115890so53984021cf.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 07:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739289590; x=1739894390;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uHqEqj6NWeXOkEn85KlhI1uqzpQbTdRlxeIaAna9uRQ=;
 b=xAixf9LsxfEZfqxtB0GXMcRes/EA+hBgGWAGrrfy/y/eWRcI6MlYPDGQSZ77O7KTYV
 v5BJslf9Tj7ZIuwQ00vgpqocFF4toZbOpK3PquUlQVJhJvZyVDR6Gtz+icTGOwpF9eZt
 MA8mUEEgaCMvz3SZec/lHM4bVoxaBlmaNkajAVCWd9Fng7nNetcONVQh6S7PsWKd4Nlk
 VtUPZXV3Dn+1cX0kY2qM+czvITp/Y8tb7VXPehhhXXmnUGW4t1JW3iU393sQFOznBzWR
 3auhcZM+BgBNipxgMFmgki4OL53orazcQ4LiHQFCH+XFqKOWuQ3Z6LfLkwNBGXGVn/Tf
 G4zg==
X-Gm-Message-State: AOJu0YyZUh0+9wyYCnGEPFBbTPtAlwFcCK342O9H23vUHfkzhfT0nL1c
 x2mo0zP6ejqd3wvIcksUqMLhnxgrcbeSM2E8S/dXQ+WPWL8n82R4QNHycY/qAqwX6vrixvV/hDM
 lnIPn7+xBf2gwBPirQ2X5Z5E2TnkD8Fmtq9cKA11ozozafpHue2O65D4CM9leu8W2cDzt9M9UNu
 2NHoRiY56cd5NGcfjA5ZlURx+5H9LfAs9jYdJRNQ==
X-Gm-Gg: ASbGnctZkVgOCRDcfvXSxlcw+vUHqAUS1TajMDCcKfu+XmT4jWX0sBmG7xyEles0/9Z
 /5Pq0DoABkFWkcHv8emN6e2B/dLiCgReWnrNEoFTgPVY6nhnkbucBUswOlXNmgQ==
X-Received: by 2002:ac8:7f95:0:b0:467:5f2f:4a9f with SMTP id
 d75a77b69052e-471a1267348mr47555991cf.3.1739289590525; 
 Tue, 11 Feb 2025 07:59:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF++mF8fS5Rri8AM4QxwqNAz4qEfov4h1/38VHwvGFyV3NOfJH77GZpd5pzY0gmqJhf2L3mrdlYgylHXe3jqZw=
X-Received: by 2002:ac8:7f95:0:b0:467:5f2f:4a9f with SMTP id
 d75a77b69052e-471a1267348mr47555821cf.3.1739289590272; Tue, 11 Feb 2025
 07:59:50 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:59:49 -0800
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Feb 2025 07:59:49 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20250127182924.103510-1-abologna@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20250127182924.103510-1-abologna@redhat.com>
Date: Tue, 11 Feb 2025 07:59:49 -0800
X-Gm-Features: AWEUYZkj6oNVCsNATRJQeISEkJqxsYsAYWh50lc-FO8sChcRhKAEZCAIo4u5NKw
Message-ID: <CABJz62Ni0Mdb_xB2z5um8PkvKxGMPnY3bs-M48XdZO6pkh+MCQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] binfmt: Add --ignore-family option
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair23@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 David Abdurachmanov <davidlt@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

On Mon, Jan 27, 2025 at 07:29:21PM +0100, Andrea Bolognani wrote:
> Changes from [v1]:
>
>   * adopt a completely different, more general approach.
>
> [v1] https://mail.gnu.org/archive/html/qemu-devel/2024-12/msg00459.html
>
> Andrea Bolognani (3):
>   binfmt: Shuffle things around
>   binfmt: Normalize host CPU architecture
>   binfmt: Add --ignore-family option
>
>  scripts/qemu-binfmt-conf.sh | 78 ++++++++++++++++++++++++-------------
>  1 file changed, 50 insertions(+), 28 deletions(-)

ping

-- 
Andrea Bolognani / Red Hat / Virtualization


