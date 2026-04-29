Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450C1FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 11:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI38H-0003aZ-Tv; Wed, 29 Apr 2026 07:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI38E-0003ZC-Cs
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:31:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI38C-0008RG-Qr
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 07:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777462262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/tSnpiDZlon3B1DFu9pPsHM6OQFqiSZzXuOtVwKLuKg=;
 b=J26CtpqPr2oMgvXLkrmq4KCFBSkYGBAOaluYiu20cIx6gHycMz5ivE1iUQG+sY33Td6jeB
 pLhC0lB6Cx7LNP7hbcsPfZ+0MKeZNVYYva/Us0IAFW2ajjAC7o1PiERitjPksRKF7WHyt+
 dXImVkay2WE/6/tFJVse+abCDJ7yRQ8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-AUlwrD7BN1CmK6sh6I2ZTQ-1; Wed, 29 Apr 2026 07:31:01 -0400
X-MC-Unique: AUlwrD7BN1CmK6sh6I2ZTQ-1
X-Mimecast-MFC-AGG-ID: AUlwrD7BN1CmK6sh6I2ZTQ_1777462260
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24308165dso178874325ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 04:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777462260; x=1778067060; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/tSnpiDZlon3B1DFu9pPsHM6OQFqiSZzXuOtVwKLuKg=;
 b=VAak3WmyKYaRKftaIegLmJ+J9EzQpZEzEzirkPYEkpvYinAisLAL6LKlTxyOpkQPUI
 GgV6PZbLNIpJAuA41p2TPhBFEC1Hp5FMSlPlqpiYeNzeXaeC1cuSKwlBhLhYD6hxblen
 EHzE5ek6P3dJ7gVhk473pZ8C3a3met3cp0ge8wLv4yIuytVGtXzyR6DRX3HcAC/4Vyo6
 ZF8Z7o69Tvo4nWjyt+GcgvAAnF+g9a5Inx5zbBl3HkAqAc2v0G/lmWzy+r8wr1Eh7Hi2
 0MPxfdHALAzBxTmhHRe0UvoE9oUwtIGDJxR0pnZ8dfyJq+KJFdu5rq8xyprsM4PxhAoF
 4qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777462260; x=1778067060;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/tSnpiDZlon3B1DFu9pPsHM6OQFqiSZzXuOtVwKLuKg=;
 b=lQFuhSXwaLVrnZUw+TBCN6WELtrwaX9sT/VNNFH1RfdPtFSYw+7TkJf33kNNU4cNNK
 3NJ/OqsQehChQDRU2ckrklNwcGdADI2I4H2JJn8NeQT7rHylpev7g4m10rnr0h7CSExX
 JnlA6rBYSN0luo66u15dkbxcnJ/k7D3Pbkv4YH0QhdhuOdvQGof8XvlSNKVLIJCBNGqD
 /2+jjeId5RorAMGg+IeyDBZbQXE8AABuOMDgbchwua/oBCC70cZrb3T9Ae26myz0L8fP
 SbxgOFUqD553sgVGk5xeloMZ4Ii72wD4Ochaug5pwU7WiznJ77f8nQo/66eDhTmjPgdM
 fMBA==
X-Gm-Message-State: AOJu0YwV90VRoV83q+rs10CBeP6/rttpzsDmywQq/SM1CsHY0FCiD92v
 tRHNgdCazQO4Bnf0cXUnpT53kzsSqAYt4ns1ozpAfWwEIJFEkRX10GQwcZkknTI4OvgtdGXS4fm
 dt6zTToLOrryVL562QYWd8mp7mGzBvEQu4xb+iibuCVPLFFvUOZPKeirL17usoTzo
X-Gm-Gg: AeBDiesBr0qOmC8H6vZTVHFDSqx8IvCxC6jIWRUEfbRg2AXicl1wfgA6lADe77N6T5F
 xwfiOPiBL1T6iuesYiXZTKx+oFG/xE33VehoOG4b3+ryMG/kd3Aav1zYmfRMi9M9vZE9gIol0p0
 EPQLiHRckr3vqxRnXPl6bGyxyo0vDaa8dZKO+p6khCJi3pex10W+TGsHVtDK3GS24IYHlm1Wcvj
 MCfTjXq0i0exAxyWTxh+2ZTKLR5HG3gH8GtR/IKYAVjFTrGWEnpyP+lycrAdSALg+SLTN+JHyKY
 gfqQKMztJcrNGQ1Cijm2ho6fCmowMvJbBfqUGI/qSrkTfsqODGYmuPRfSwVIWtBK7+Pe5FlyW5N
 o3SarzQgmZO/l3yh9998SQhw=
X-Received: by 2002:a17:903:983:b0:2b2:5503:1b8d with SMTP id
 d9443c01a7336-2b97c3d4565mr71330495ad.6.1777462259976; 
 Wed, 29 Apr 2026 04:30:59 -0700 (PDT)
X-Received: by 2002:a17:903:983:b0:2b2:5503:1b8d with SMTP id
 d9443c01a7336-2b97c3d4565mr71330205ad.6.1777462259452; 
 Wed, 29 Apr 2026 04:30:59 -0700 (PDT)
Received: from fedora ([49.36.106.198]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98895dbcesm20962585ad.63.2026.04.29.04.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 04:30:59 -0700 (PDT)
Date: Wed, 29 Apr 2026 17:00:54 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH 4/6] tests: Rename id of tpmdev to tpm0
Message-ID: <afHr7l57qJFyRuLO@fedora>
References: <20260428130718.1325177-1-stefanb@linux.ibm.com>
 <20260428130718.1325177-5-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428130718.1325177-5-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Tue, Apr 28, 2026 at 01:07:16PM +0000, Stefan Berger wrote:
> Rename the id of the tpmdev from dev to tpm0 because this 'dev' cannot
> be used when the tpm-tis-i2c device is used.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/tpm-tests.c | 4 ++--
>  tests/qtest/tpm-util.c  | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index dcbf5457ed..d1fe4a85d4 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -49,8 +49,8 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
>      args = g_strdup_printf(
>          "%s "
>          "-chardev socket,id=chr,path=%s "
> -        "-tpmdev emulator,id=dev,chardev=chr "
> -        "-device %s,tpmdev=dev",
> +        "-tpmdev emulator,id=tpm0,chardev=chr "
> +        "-device %s,tpmdev=tpm0",
>          machine_options ? : "", addr->u.q_unix.path, ifmodel);
>  
>      s = qtest_start(args);
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 1a47099807..35e9d3f32e 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -227,8 +227,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
>      src_qemu_args = g_strdup_printf(
>          "%s "
>          "-chardev socket,id=chr,path=%s "
> -        "-tpmdev emulator,id=dev,chardev=chr "
> -        "-device %s,tpmdev=dev ",
> +        "-tpmdev emulator,id=tpm0,chardev=chr "
> +        "-device %s,tpmdev=tpm0 ",
>          machine_options ? : "", src_tpm_addr->u.q_unix.path, ifmodel);
>  
>      *src_qemu = qtest_init(src_qemu_args);
> @@ -236,8 +236,8 @@ void tpm_util_migration_start_qemu(QTestState **src_qemu,
>      dst_qemu_args = g_strdup_printf(
>          "%s "
>          "-chardev socket,id=chr,path=%s "
> -        "-tpmdev emulator,id=dev,chardev=chr "
> -        "-device %s,tpmdev=dev "
> +        "-tpmdev emulator,id=tpm0,chardev=chr "
> +        "-device %s,tpmdev=tpm0 "
>          "-incoming %s",
>          machine_options ? : "",
>          dst_tpm_addr->u.q_unix.path,
> -- 
> 2.43.0
> 
> 

Reviewed-by: Arun Menon <armenon@redhat.com>


Regards,
Arun Menon


