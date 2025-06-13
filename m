Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481C3C61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 12:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ3c7-0000b4-QA; Fri, 13 Jun 2025 08:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3bv-0000Z6-Jr
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:34:25 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ3bk-00054P-48
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 08:34:12 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-70e1d8c2dc2so17982707b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749818043; x=1750422843; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=71Ya53HdH2POf52rkfKFn+Nol6pKowztsbWwDe3T4og=;
 b=CZO7vLyFWF3w145HpvqKhxveTQi+UfsTuWrVEB7rEsZcIwe0ZdYFILADUqSjnAICVg
 w880FEMMcuunJB5SpTKm7f9U8Myu0h8A668Z9AmK8Ni47dXhsYoosUw7BHTvYGX4WI1z
 aIjaXbbF/gRsXPnLyGhwxa0ZYwWiTYz9vqEvnaW4cuGweXTBXgsvgM0lhwvysXkHU2LE
 24HAZoGkGz2/5+LG6DqxeMlEWgbHS16MoY5CjCN38mfgmcs+JyVEr/aJqivVlfszsjxS
 xKRJQiyF+u29lV3IND9o7bNgdOseGS9ou0PgVQjAfPGctXYAd+4qyZZBK4Lr45bMs9I2
 yjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749818043; x=1750422843;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=71Ya53HdH2POf52rkfKFn+Nol6pKowztsbWwDe3T4og=;
 b=iv/Yzb4w8oHvESepSCAS5KCgw0Wm5vDEDBc//21888G4LpZHagBPHB2359djTdiieF
 d4aeOxj4uyksw0tMTfNEq57R/Coipl5k0PNNsPgn5+NF3bnfoRoU130tMFYcjTKgBr/b
 hxfB62gAyCVszDZ2nY0/o9+EZoKyGdlszfinACY3HDewOeL6L6HUwzD1gr0LiU3+cv+E
 ZOcCbxqdVMjBSWhv15da3WnUISjTO5OwCNBAMHnepIeJ/aFZWhKzsixVOjs4tfwjJriH
 uV2k3s7H2371NJrQvucgGLM/hXZDD89Oq5yqgWns1HSPnPB+SU7jVKXiIjSNecb/2Qdo
 JaaA==
X-Gm-Message-State: AOJu0YyNJrKeIt41/A5Xgse0JU+vOij529BfzG+LTmD72cKZ51fItp8S
 vbcHrSZ2xc1b2rKJKqBAn3eH48ZeHZsvdp9neIBdu6UEy4xS7vQ6eD/e2o/ecoj0aHshWBos04U
 PmWzz99od7+r16S6vFaNWwW/i6c4IFlteQ8HYYKZAbg==
X-Gm-Gg: ASbGncsgkOzypkXJzI5mA3f+OhF6DAQQON2bXuK712Fi4X3lGZRJpZkWCDKKtBiQ9Xb
 OOQzM7Cc4mBMaUt4kFYz3Fa3CBoFt2gZYNXy6T6uqaUVInCSWqaBPnF2sfXTpeMPF3e5gWZC3ju
 fYFArTsKH+oBgnYS+i1iNSfZtjuNILRXAzfqiT+TI4iyDRNwFStVR1hso=
X-Google-Smtp-Source: AGHT+IEPb3qsJDLQBTC8O9rNw2LMABjdnqOth3sas+F6r3fDBdPhv+i9c4Uol0fLbXfZFpDJZmkdztNRwKzE2noXcvo=
X-Received: by 2002:a05:690c:6f08:b0:70e:7663:8bb4 with SMTP id
 00721157ae682-7116374f3b7mr43623757b3.25.1749818043502; Fri, 13 Jun 2025
 05:34:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250612134338.1871023-1-Jonathan.Cameron@huawei.com>
 <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
In-Reply-To: <20250612134338.1871023-3-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 13:33:51 +0100
X-Gm-Features: AX0GCFvpyAy_J3mza-WH8ODBb8J0cb17KuCFxq0_mXVNO-YpQTCeuWxKD6udl4Q
Message-ID: <CAFEAcA8eC9TpGyrMARRUWs4q1o7LACD03zLAwPnTRU+m98LrWQ@mail.gmail.com>
Subject: Re: [PATCH v15 2/4] hw/cxl: Make the CXL fixed memory windows devices.
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>, mst@redhat.com, 
 Zhijian Li <lizhijian@fujitsu.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org, qemu-arm@nongnu.org, 
 Yuquan Wang <wangyuquan1236@phytium.com.cn>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 12 Jun 2025 at 14:44, Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> Previously these somewhat device like structures were tracked using a list
> in the CXLState in each machine. This is proving restrictive in a few
> cases where we need to iterate through these without being aware of the
> machine type. Just make them sysbus devices.


> +static void cxl_fmw_realize(DeviceState *dev, Error **errp)
> +{
> +    CXLFixedWindow *fw = CXL_FMW(dev);
> +
> +    memory_region_init_io(&fw->mr, OBJECT(dev), &cfmws_ops, fw,
> +                          "cxl-fixed-memory-region", fw->size);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &fw->mr);
> +}
> +
> +static void cxl_fmw_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    dc->desc = "CXL Fixed Memory Window";
> +    dc->realize = cxl_fmw_realize;
> +    /* Reason - created by machines as tightly coupled to machine memory map */
> +    dc->user_creatable = false;
> +}

Do these things have any state that needs migrating or resetting?
If they do, they need a reset function and a vmstate. If not,
it's helpful to have a comment explaining that the device
has no state to be reset or migrated, so future readers of
the code know this wasn't just accidentally forgotten.

thanks
-- PMM

