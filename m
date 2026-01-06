Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5C0CEFD03
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 19:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdD9f-0001BZ-Bv; Tue, 06 Jan 2026 14:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD9d-00018j-L2
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:55:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vdD9c-00046X-3D
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 14:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767729343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2o9tmIZUPGnLS1+H9lDDrt02FNhPiT0PhaNHubm1iLo=;
 b=Ij82RU/7ArBxbQOLSxgX4o9nkCefOS8UY36nHwadTVRl8ve5IiLv4oTSKR807eQyKcrdnE
 Vd82YIfGk3ADlWIrgjENTQpEKxzIH1pyYKq4keaZJVdlGwqAbN+MEZeo29eI9D72vwYJ/I
 fdidiaPw4y01tEmyMXrQDEPcciiKU1M=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-YM6SXmSePXWkMaLIEIg1-w-1; Tue, 06 Jan 2026 14:55:42 -0500
X-MC-Unique: YM6SXmSePXWkMaLIEIg1-w-1
X-Mimecast-MFC-AGG-ID: YM6SXmSePXWkMaLIEIg1-w_1767729341
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ae56205588so721451eec.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jan 2026 11:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767729340; x=1768334140; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2o9tmIZUPGnLS1+H9lDDrt02FNhPiT0PhaNHubm1iLo=;
 b=p2rSZHFSGrpk9Ijay4gQg3yZwJ8mQA0zqeQXkgcsddZ5hSbZX/+XmFmqloZhNFmSeK
 vcbJt3NOsp/FmmKUXzBh2FmY4VPTfvxbBN9qMJ+arcBeaPy5+5aacPbkhEGxILCiVQOs
 lfqTwrJV6//UJ71+pILsGr4ztniVTUnH0yDYE4ATk+U6CutQohQNBEswi6eYQTl6q/9y
 s0gn7Pr03B70aq8ovzCq+qphqtWG+MD+nqb0LONhQN7NAkRTKUApfj5xMyIxmAxOCnjE
 5NgMxKo2u/KWDzALGF7zGna9aKkg7Dx1ReE7shxrLb/BTF0z2n7Fh7rTwXsXpDA8j7sO
 UUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767729340; x=1768334140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2o9tmIZUPGnLS1+H9lDDrt02FNhPiT0PhaNHubm1iLo=;
 b=t/PR8ihi8o8NGMb9p7y8ZfLu1cDHEtTF1YDvQhzISc1XX+CLf14KgOed25R9mTh+dV
 rm7r0zluIiUqJR5vRG/yXRjY7t5GthZrqjPOLTB8NRFZanKm2snmrAnaZ/zFX/Q1BIGo
 frJZVuUDEE5w7vVI9TPTmVyKNFOub5oUaAlvGApNeC0EHejE3ie1kmCQWm03b+g5HkRB
 EoNim68O+wbe12ZzSITFy5Jz/BSEWJKdaJqBTFOH3tOYJTUmraIvyrwxQIQCHUJ0GLnP
 PC1l8CIWx2FSAMGbHR88hu9mTizPSQEwZDMjYiDaHJ6oo0dEe+M2VMqa6XIalt0d0K2Y
 M/RA==
X-Gm-Message-State: AOJu0YzZ+jOC8K1Au+ulpvnPVJF42rMnf56EZm5mUsUzgOd8qpU1WWHt
 Xq9c7r+BJ0c0XwfDv/JE8OjHjFwqc0FPdtKHODV5pRSzKUMWStKvY3qfjNWF52RxpwkN+1N0hzP
 pGkoZ0kGlrT/MezRtlZWbR/5ym/OYeInUlIW0iMEqkz0T9fcn4tgzoi0P
X-Gm-Gg: AY/fxX4On3gT2+ozpNAc3zJ4IPz47qzExrp1iKVCsyDaOrCyl+ay02ywasNCY/nDzSj
 1v1pNsmHvGwRIfZE+GCJ8k5BQ3fTf/cY1hPNZBSyWAoijAB0Uwjsr2bpz1tT8iuruLlpn95SQr5
 eLu+fkxCqNTN5uibsM32TyH0JNi8zdrFkK2LZC3GxnUQYQlRM4M6+SyfNxqB8qskAEaY6YFJ0ih
 mZYHMo1Fb5thAV6tmBAporvfyX+VyHII4f90api6+/VR2mve9Ez9E0sl4+0ZCjnzl2wJ98PBT6w
 kInflQA7reB+YXK8lEkWy6kd4EgDvreSZNILdgRkCg62jSshe0A+2UFnnaeiceRNt1gclr9Zvv3
 DQuY=
X-Received: by 2002:a05:693c:60d6:b0:2b0:5412:3ef with SMTP id
 5a478bee46e88-2b17d355897mr61593eec.42.1767729340474; 
 Tue, 06 Jan 2026 11:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrn4TsKicMPyv7wa/mrx9i/AhtYfPQR9uLnsx1Hpg4pr3YXEwIR5Gv/MKDJ7kOIs4pcJbJyw==
X-Received: by 2002:a05:693c:60d6:b0:2b0:5412:3ef with SMTP id
 5a478bee46e88-2b17d355897mr61579eec.42.1767729340012; 
 Tue, 06 Jan 2026 11:55:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707b0b2bsm4677636eec.23.2026.01.06.11.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 11:55:39 -0800 (PST)
Date: Tue, 6 Jan 2026 14:55:34 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>
Subject: Re: [PATCH 2/3] migration-test: Add -snapshot option for COLO
Message-ID: <aV1otmGc76_KzZMv@x1.local>
References: <20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de>
 <20251230-colo_unit_test_multifd-v1-2-f9734bc74c71@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251230-colo_unit_test_multifd-v1-2-f9734bc74c71@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Dec 30, 2025 at 03:05:45PM +0100, Lukas Straub wrote:
> For the COLO test, both VMs will run in parallel. Thus both VMs want to open
> the image read/write at the same time. Using read-only=on is not possible here,
> because ide-hd does not support read-only backing image. And the image
> won't boot with ide-cd.
> 
> As a workaround, use the '-snapshot' option where qemu will internally create
> a writable snapshut while leaving the real image read-only.
> 
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  tests/qtest/migration/framework.c | 4 +++-
>  tests/qtest/migration/framework.h | 1 +
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index e35839c95f51d851a3fed8e8457ed2d7e927f59b..8c1fc6e009f16dc05a47e917167f62e0250ca992 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -322,7 +322,9 @@ int migrate_args(char **from, char **to, const char *uri, MigrateStart *args)
>          }
>          arch_opts = g_strdup_printf(
>              "-drive if=none,id=d0,file=%s,format=raw "
> -            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1", bootpath);
> +            "-device ide-hd,drive=d0,secs=1,cyls=1,heads=1 %s",
> +            bootpath,
> +            args->is_colo ? "-snapshot" : "");

We can use opts_source / opts_target for this.

>          start_address = X86_TEST_MEM_START;
>          end_address = X86_TEST_MEM_END;
>      } else if (g_str_equal(arch, "s390x")) {
> diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
> index ed85ed502dd01aa809892b68d3934b5107bd3442..2ea13e7758697550b5531737e66d6d939dd800d1 100644
> --- a/tests/qtest/migration/framework.h
> +++ b/tests/qtest/migration/framework.h
> @@ -134,6 +134,7 @@ typedef struct {
>      bool suspend_me;
>      /* enable OOB QMP capability */
>      bool oob;
> +    bool is_colo;
>  
>      /* Do not connect to target monitor and qtest sockets in qtest_init */
>      bool defer_target_connect;
> 
> -- 
> 2.39.5
> 

-- 
Peter Xu


