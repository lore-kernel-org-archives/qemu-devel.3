Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5186AC5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 06:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhl5Q-0006bi-NA; Wed, 06 Mar 2024 01:49:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhl57-0006Xm-5L
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:48:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhl55-0004dq-5N
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 01:48:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709707726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=amopS3vJStku62EOwJeUGTXSrh+CQIsD9NEthLDq1bc=;
 b=K+A3wyhYl+7Xe8211Tjg+srJMuaAHFJWTk0Km6tF1Kl2BzWL1V4TkZvhjK/HirQEQB/fH8
 S7tCNJpxwJTsF3RBb6S39axuHB2fVA20CTDTffIdB3d0NsmOWSOvH3W0G9lUgfK9VGJyYw
 8y7jLk6sK8FzziVh/mIL/YKahVi2NGs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-CBr1cl7PO9SIKX3X1vXg_g-1; Wed, 06 Mar 2024 01:48:44 -0500
X-MC-Unique: CBr1cl7PO9SIKX3X1vXg_g-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-607e8e8c2f1so110770737b3.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 22:48:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709707724; x=1710312524;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=amopS3vJStku62EOwJeUGTXSrh+CQIsD9NEthLDq1bc=;
 b=Q10L2eTv5WkYtN2MlfaKjEbu9QRE6qwvozWfv1ypwRJeriwoSh1tSclPvrzQkeH36l
 +7s27oDodvsftLhCvwNK9rpp+3kohhHccZuloH35d8P9sh8eii0PD9r0JrPltGwYLniV
 /DJmMtZvNHo/FHpJhgRNPn/u8Egepxrp4YClg0KVv+fL4NkF+Ocmuhf1BPbyyXAqPy1N
 s68waukGXIXpiGX03jK+yuR8MA1ORLKpnZBfbCSMLW2aXOf4RaiMoSmcmIFMbFoJUctv
 c3ERMu/YZfTZaiKxgwuvgfwxmLR7uNTt7qlnfW+PPUq6c2KAApdq+2XhB1L9VBaGnwtz
 gwcg==
X-Gm-Message-State: AOJu0YzBtrEt7nCkysI/apUiN76C4uM6NnngR4k+rlhAe5oVCZGoUQ+I
 vcqDV6KJoadZIRYGr1N17cHc5+LHSRaeusgf7R4RAzw/pnupis6/nBRJp+GTZ/sghpHTtSyFcaN
 sS51i6itbS6eDwopKlsmA5PiKAMPebXcMYQnW97KZ7fwYU2/2PDLM
X-Received: by 2002:a0d:d341:0:b0:609:7354:6b11 with SMTP id
 v62-20020a0dd341000000b0060973546b11mr13962732ywd.52.1709707724058; 
 Tue, 05 Mar 2024 22:48:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFBt/nymVjHOH7AnoHwYCbMt1qvEeo+bVaPumBgyvdAW1mWijF/87GzpGn9zFSLsySe/sb8Xw==
X-Received: by 2002:a0d:d341:0:b0:609:7354:6b11 with SMTP id
 v62-20020a0dd341000000b0060973546b11mr13962707ywd.52.1709707723721; 
 Tue, 05 Mar 2024 22:48:43 -0800 (PST)
Received: from smtpclient.apple ([115.96.30.47])
 by smtp.gmail.com with ESMTPSA id
 lo12-20020a056a003d0c00b006e627d0e97bsm4081536pfb.181.2024.03.05.22.48.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 05 Mar 2024 22:48:43 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.400.31\))
Subject: Re: [PATCH v2 09/20] smbios: add smbios_add_usr_blob_size() helper
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20240305155724.2047069-10-imammedo@redhat.com>
Date: Wed, 6 Mar 2024 12:18:24 +0530
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <66FCEF16-5EC6-44CD-9EFF-595CF58A5C3A@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-10-imammedo@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
X-Mailer: Apple Mail (2.3774.400.31)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> On 05-Mar-2024, at 21:27, Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> it will be used by follow up patch when legacy handling
> is moved out into a separate file.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
> hw/smbios/smbios.c | 18 ++++++++++++++----
> 1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 97cf762228..01180bd82c 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -1287,6 +1287,14 @@ static bool save_opt_list(size_t *ndest, char =
***dest, QemuOpts *opts,
>     return true;
> }
>=20
> +static void smbios_add_usr_blob_size(size_t size)
> +{
> +    if (!usr_blobs_sizes) {
> +        usr_blobs_sizes =3D g_array_new(false, false, =
sizeof(size_t));
> +    }
> +    g_array_append_val(usr_blobs_sizes, size);
> +}
> +
> void smbios_entry_add(QemuOpts *opts, Error **errp)
> {
>     const char *val;
> @@ -1334,10 +1342,12 @@ void smbios_entry_add(QemuOpts *opts, Error =
**errp)
>             smbios_type4_count++;
>         }
>=20
> -        if (!usr_blobs_sizes) {
> -            usr_blobs_sizes =3D g_array_new(false, false, =
sizeof(size_t));
> -        }
> -        g_array_append_val(usr_blobs_sizes, size);
> +        /*
> +         * preserve blob size for legacy mode so it could build its
> +         * blobs flavor from 'usr_blobs'
> +         */
> +        smbios_add_usr_blob_size(size);
> +
>         usr_blobs_len +=3D size;
>         if (size > usr_table_max) {
>             usr_table_max =3D size;
> --=20
> 2.39.3
>=20


