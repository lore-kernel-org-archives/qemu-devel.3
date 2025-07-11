Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A688C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCS1-0006gm-7i; Fri, 11 Jul 2025 08:02:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaCQk-0004xe-5a
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:00:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uaCQc-0007Ce-AU
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:00:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752235227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VsfQbPAGizSu+f3WzVMQ6BzNeUSikFmDQ7COYP4hWWQ=;
 b=eCety0Ci/iWXKPNH+6yBseKFfOiWifGTH9qyx+GTNnB0wNgeTl00w61kMsWowxSdrBuAy4
 v1hdcccs7GuPmH8ZsfRgsgTF2UcRlcyNCTUgmVnHwOdQ6FBZ7mzKKOTf5jsGE64+zR5262
 KreDQdFVF62aDt2FryJek6j4/N9YhIQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-93T3XzcPOfOE4qHKcDE1lA-1; Fri, 11 Jul 2025 08:00:21 -0400
X-MC-Unique: 93T3XzcPOfOE4qHKcDE1lA-1
X-Mimecast-MFC-AGG-ID: 93T3XzcPOfOE4qHKcDE1lA_1752235220
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a579058758so966567f8f.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752235220; x=1752840020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VsfQbPAGizSu+f3WzVMQ6BzNeUSikFmDQ7COYP4hWWQ=;
 b=xIvlb4m64G8izNtmKgEitK+aQYxqLYcwsk1VXiR4cFcht6W+FBhb4DVEkOxD07/w0l
 vgG5QZVZ2mRMWbFiBIGlL1r2GovGd9fOdA45hzEhGPJKX8fLL3Q3RjvtegWmmO0q+K9x
 IGzBXo8MAnVjPxEv8fBPZjHOYfmM3JdVJkazl+qhm0jWIXFOemHR4gwmW2C+xvJikfRu
 dWBKP/t3D2I0TfLxpGwBM2gCrUTyeHQRV6AUGujc9ZkuqmwUe7Fsuwf3Q/SBXsWmhJhr
 h3x5TsqunqtWL9slz6k7y+e+5FRQ9+Jhgknr2q8HOqD+fBHJ9/n1u/oXxSwJPupx6QRu
 HoyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXg874dvgneRFAAJ3jqzcJM2YFljmFRCsGiJzfRHMDCgl4w5tT+yDk4hJIXU0I9BLeIHXt9xRSwVDB0@nongnu.org
X-Gm-Message-State: AOJu0Ywjo3K5wodQ754u+fl7pkDvOIuDxZlEE6j2iAn0bDIZ5ISk8FYf
 T8wg3pn43jd99D/g3jcVX7GkC/4N5hrGOCzkRqLlyTQTP9fqTN3NMq24MdcEc0puQtXgpXZg9OK
 guWTl0P6pLAKK2Op/R94mAvPIXQeZGgOi5nttR1Bvt3MH3+odsTNTO+k2
X-Gm-Gg: ASbGnctuGoUoImSz2gu60CUiIPzAL6w+TFfx+azLKxZXV7zhjdEx2ZbG4rLXJ412jDA
 /qvQYRHFbpkbaF6Jx8mxl3yCJEUEsh1cwrcIyLkz2lxvlz2Pmqw1UkDf3IUX12JFtBGNS02H3+m
 DiKEuATgkvVV4w/CqzHOh9PgtPcxzAkS0CW9RM87W7BOHzs5JkJ8t/GvA//iFBPDB6asgTvbfkv
 qxgniUS8PvTv2UwUSnO2l3yONTvqzDRg6fFkPRiZRORNX7WkW5pOmDWleO00+b8JrjKGJAqEi81
 7ecXOzgO1WHMI0UZiE+RVuwoXnA3XA==
X-Received: by 2002:a05:6000:2a89:b0:3b3:9c56:b834 with SMTP id
 ffacd0b85a97d-3b5f187ec4bmr2727862f8f.1.1752235219780; 
 Fri, 11 Jul 2025 05:00:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJJK0ie71UYI5qToJl8lYWXHiuIjgju37kVlpvrhjiuE8A31z6BPQBTkzi48xoH0dhmFXwcg==
X-Received: by 2002:a05:6000:2a89:b0:3b3:9c56:b834 with SMTP id
 ffacd0b85a97d-3b5f187ec4bmr2727831f8f.1.1752235219348; 
 Fri, 11 Jul 2025 05:00:19 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d727sm4323185f8f.51.2025.07.11.05.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 05:00:18 -0700 (PDT)
Date: Fri, 11 Jul 2025 14:00:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, Jonathan.Cameron@huawei.com,
 gustavo.romero@linaro.org, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com, pbonzini@redhat.com, philmd@linaro.org,
 alex.bennee@linaro.org
Subject: Re: [PATCH v6 18/36] qtest/bios-tables-test: Add a variant to the
 aarch64 viot test
Message-ID: <20250711140014.0d79c004@fedora>
In-Reply-To: <20250708142437.1344644-19-eric.auger@redhat.com>
References: <20250708142437.1344644-1-eric.auger@redhat.com>
 <20250708142437.1344644-19-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue,  8 Jul 2025 16:23:00 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

I'd merge this with previous patch


> ---
>  tests/qtest/bios-tables-test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 4dbc07ec5e..357bcefd37 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2237,6 +2237,7 @@ static void test_acpi_aarch64_virt_viot(void)
>      test_data data = {
>          .machine = "virt",
>          .arch = "aarch64",
> +        .variant = ".viot",
>          .tcg_only = true,
>          .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
>          .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",


