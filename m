Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FABC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 09:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMNyv-000498-Gl; Tue, 03 Jun 2025 05:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNyn-00048X-7t
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uMNyj-0008MS-QK
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 05:30:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748943039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tbtc/iv882fW3l8Igxs/hIcCdKYDVRdv+YF5ZRs8V+c=;
 b=JD0jriTDObufb3V/mf8Q8MeXzDyR9zBqDdYXL5Oe4NpInp/+grJARyvRyKq2TReA+0ku+0
 PsV7ScqW+aiQqK47uNlaJpQoRrGWExMhRVCM59lI+/C4MrYhvqQ2D+VLo1nyhRZ631jIV2
 CWZYnKZLx2tfzMWvNxs/0TW/1ncB13E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-SOMxTNMeOkSGY3i7CNoWkQ-1; Tue, 03 Jun 2025 05:27:08 -0400
X-MC-Unique: SOMxTNMeOkSGY3i7CNoWkQ-1
X-Mimecast-MFC-AGG-ID: SOMxTNMeOkSGY3i7CNoWkQ_1748942827
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eb9c80deso2284980f8f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 02:27:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748942827; x=1749547627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tbtc/iv882fW3l8Igxs/hIcCdKYDVRdv+YF5ZRs8V+c=;
 b=e6jjPpmB88RVW43Jd3sV9LkiZcdOn1L6EmxWgMjmqIDItnEjxvXOFgeduaQAtUmgOO
 cKmPBJD0QXZe5zXzWtftMzJ1ALPfFqIPHVTdEdPBgqmvAk6D1wTj4sz05Wkei4Tob9Pi
 HXovVJEqXoglUrsLYjd4lU22fbUJ8H6W0ZsH4ktFreQ0A+GDcTbWgdStZ3qucvzSPl0C
 MZXx5cUPUNfWp6rivvXlR3jW/AjJAziq3l6apOK7q5LYj0U+8NnWstpgSkzX8KN/G0iH
 qCPJjX9PuCkZDzDS3jeMzheFP5c7/ohhb+MtdsBpYQlLlEz3LgmUlxg4tdACkd7ZyLIG
 srLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdPzQaYkftOLldUoxlbeST/UHCw4WK6Fn1BG3GdYaB+KiF5odRqb2gyDBUlPC4UDS6ee8kWLZCOTfZ@nongnu.org
X-Gm-Message-State: AOJu0YzpRwahya8zFAY7iKD4AxmRXFcc+GZwoXoOl70iSXLZbuTjLZI0
 LC3SEtH4YwyaszSixHlxBvp3cu4eGuEOe6/xrSGpwqWqnRQQo/YWmN9r6OkwOq8ThvJt5kEXnYU
 cCTOZ9isTxovrIN5erwQWia5ODJJPj8YKyL55i+7y93nIL7iB7rdxiyb0yWrUCi1H6Eo=
X-Gm-Gg: ASbGnctHK6KYiHSWmQ/fgMi04mH/mdcoPv8PfSKSucDJ9CunusfjV7+5CFaeGznm8tg
 9Lnls43ukFaHC0ohiUjsFldi00Joode+ZOlPQkdLtiyXb8ORjDg0Qbn2/VRDI4iU/SsxpMVtTcu
 ODIhtwyZhO60C6+x9hMzzkBsRBgXZdArN82I7F7xbYxiA+Z8GpblFCWfLcBQP//p3kK7yxeuyNV
 rj1rMa0igr4PDvA5JRAcElX111+OAEqW5R52ukq8LGYHBEpIz+o56tkP7Rx+DwxxEx+UrdM44E0
 bp+Jvsk5KeBkiz9dMuuYuGU39EBSWzpw
X-Received: by 2002:a05:6000:2c12:b0:3a4:eeeb:7e76 with SMTP id
 ffacd0b85a97d-3a4f89a5bb4mr12473229f8f.9.1748942826767; 
 Tue, 03 Jun 2025 02:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbS0gZmJFElwCgvBGogMqSaMT9C31n8ib/NtrsryU1x8BYa18KGjPQvNkQGiJEAzrEMNcRLQ==
X-Received: by 2002:a05:6000:2c12:b0:3a4:eeeb:7e76 with SMTP id
 ffacd0b85a97d-3a4f89a5bb4mr12473193f8f.9.1748942826342; 
 Tue, 03 Jun 2025 02:27:06 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f1basm156633825e9.6.2025.06.03.02.27.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 02:27:05 -0700 (PDT)
Date: Tue, 3 Jun 2025 11:27:05 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFu?=
 =?UTF-8?B?Z8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] i386/tdx: Clarify the error message of
 mrconfigid/mrowner/mrownerconfig
Message-ID: <20250603112705.58ca139a@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250603050305.1704586-4-xiaoyao.li@intel.com>
References: <20250603050305.1704586-1-xiaoyao.li@intel.com>
 <20250603050305.1704586-4-xiaoyao.li@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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

On Tue,  3 Jun 2025 01:03:05 -0400
Xiaoyao Li <xiaoyao.li@intel.com> wrote:

> The error message is misleading - we successfully decoded the data,
> the decoded data was simply with the wrong length.
>=20
> Change the error message to show it is an length check failure with both
> the received and expected values.
>=20
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> Suggested by Daniel at https://lore.kernel.org/qemu-devel/aBzT3TrdldaN-uq=
x@redhat.com/
> ---
>  target/i386/kvm/tdx.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
> index 17e671f1710f..4172bbd23340 100644
> --- a/target/i386/kvm/tdx.c
> +++ b/target/i386/kvm/tdx.c
> @@ -1026,7 +1026,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>              return -1;
>          }
>          if (data_len !=3D QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> -            error_setg(errp, "TDX: failed to decode mrconfigid");
> +            error_setg(errp, "TDX 'mrconfigid' sha384 digest was %ld byt=
es, "
> +                             "expected %d bytes", data_len,
> +                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
>              return -1;
>          }
>          memcpy(init_vm->mrconfigid, data, data_len);
> @@ -1039,7 +1041,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>              return -1;
>          }
>          if (data_len !=3D QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> -            error_setg(errp, "TDX: failed to decode mrowner");
> +            error_setg(errp, "TDX 'mrowner' sha384 digest was %ld bytes,=
 "
> +                             "expected %d bytes", data_len,
> +                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
>              return -1;
>          }
>          memcpy(init_vm->mrowner, data, data_len);
> @@ -1052,7 +1056,9 @@ int tdx_pre_create_vcpu(CPUState *cpu, Error **errp)
>              return -1;
>          }
>          if (data_len !=3D QCRYPTO_HASH_DIGEST_LEN_SHA384) {
> -            error_setg(errp, "TDX: failed to decode mrownerconfig");
> +            error_setg(errp, "TDX 'mrownerconfig' sha384 digest was %ld =
bytes, "
> +                             "expected %d bytes", data_len,
> +                             QCRYPTO_HASH_DIGEST_LEN_SHA384);
>              return -1;
>          }
>          memcpy(init_vm->mrownerconfig, data, data_len);


