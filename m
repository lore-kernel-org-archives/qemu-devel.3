Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6206CD37B9
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6jK-0004Rj-27; Sun, 10 May 2026 12:10:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM6jH-0004Pt-Ry
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wM6jD-0001k8-Co
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778429399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wCVoF57DmLFbijeLjFcPhA0Q4tYJoByuDNn5uU58sLU=;
 b=Rp8JCa+fHmBcawPUi58XB6rMJrb0muFnM6WXk7Vo71EFSBelrHvERg7dSl5njVajmErgHj
 O5OQ6Rq6lvIqD1ZIj1v6mFwv2Wih8ZWgLMfLW4Ial27qIiCzztmPqJTzfVyhmCEz/LYjsB
 DgkIYdMVh2v97YTIzcv3WatZWYOjw3Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-PiQu2nb2OB6fEkOoStbchQ-1; Sun, 10 May 2026 12:09:58 -0400
X-MC-Unique: PiQu2nb2OB6fEkOoStbchQ-1
X-Mimecast-MFC-AGG-ID: PiQu2nb2OB6fEkOoStbchQ_1778429397
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-488ba2f4094so26288895e9.1
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778429397; x=1779034197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=wCVoF57DmLFbijeLjFcPhA0Q4tYJoByuDNn5uU58sLU=;
 b=Un8asNTlAzu89ziq4vRZ0BC5qduAFuTeGN9S8f8ggXgorCkjVevL/XZLzYULshAsYE
 oHXgxQz30h1e93pbJPjO/PQ148uVXh3lwJx7pabSr0w6nvgY6vwwMjh79Z0uEC11JfMX
 8LaM8gjDrEX8wZfp2lIu4gYwgUKKP7xyJsI/cX0BEHVgsrYQtf5tLFxE60kmROU06rDk
 mWAXrlTPaCq3/MIt2Y3a1CumW3coDzHyl/0csjT17Smro7X16EqDJiWKgLuCxO3Y1KBB
 7CrPk/bas7fXq0nOWCm/LqmUcVXeXg535YejiHlJOEnxNN9Rjy+23muZo2Qi6z6xyfV1
 U43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429397; x=1779034197;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCVoF57DmLFbijeLjFcPhA0Q4tYJoByuDNn5uU58sLU=;
 b=X8NSTCOuTGDtRHaw1AH4Ye7/qw3XPA6bQErbJffmSgPItI2XjB4vWyqBRhSywFERIR
 t9ZtoXQ5FQ51dalFGf0Gf0WTt3b076EXLO1K6xE1qUwvC/PGMTuYuzvUZ+6+CrGDtK22
 0bw2HpcDPykGz8wjFHhcyD9C9Tb6UvjIgHplEWf9OHjh//mZjbSOJ6/ZQN3v8r2Eezm9
 4hwBz0skghDQqZ5j/Dat4IRhyVzuEIsormjVvYsk903m3i/bOgnzGhJ4HRSICPtITslp
 Mu2nMo0DGq25XkMiQyVpxi4Zznlty5bJOiIghsbAVu09Yi6kV0OP85h8WbpJT6fE/RQk
 ZlgQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MuAV2+itpFm9UW3XSkV3PpCsgcPEbEbfnV532SUFRAmSJ7k2LHI4JHeg9DyuB3Im8Wjl/V11g5bSk@nongnu.org
X-Gm-Message-State: AOJu0YwyOGWaL+S21fjRyqspEd8LlHA6kk0rUV1RnEUEF8smyC/uWYNM
 nIV+Uo0ulV3OuyAbq6pRbsZh/ohyUjlbAxXKkfYAUkAjCNdY7nF1C3FibnM29BSAXYN3A1OgwgR
 cvpj0OPM0keVDP0rJ/UEJiCEgY113ZYxUV6h8qK6EiYaPH81etAESiI9Y
X-Gm-Gg: Acq92OGWd7oDICDuSTqyuGnU8OJJFiFv83+3/fW8qMm+0xyDdu20QLBZBkX/CIi29Cv
 cuSb8NRj4Pp+79389Mn2bsvXr2QbkpgYqFqyzb1c3Q4LbHpn6JwLrSwS0pYQkY/OygHGNgerGgA
 RqY4U1naz5aOwTUyQfT4FuOuvc9fKEoxsxdoKuDCOU8MfUNe4dx3codL2eDsghtcdabBi0NyTND
 SCmq5tUuIEUWdBpR/mCPL8G5falPP+8ZfrEtCxDfmRmDLy6BuwYELlAYe7X9YrmZwQPoRwx4SC9
 g1Ms36GneVoaWSqIgef1hYVKZ14Dofip58x/lV48pgGBXxMsZ6n4kmlPjDpIOfMRyswRq5es+WP
 /DkC0czbs0tR0HmQV3nZCfNEmBC31i+3yyStTt/Ub55bYgAvzC0WiY8sK+TfHsanzLMVWkE4=
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48e521e6085mr340952285e9.16.1778429397157; 
 Sun, 10 May 2026 09:09:57 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:489:1f08:91b with SMTP id
 5b1f17b1804b1-48e521e6085mr340951855e9.16.1778429396610; 
 Sun, 10 May 2026 09:09:56 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e702e5630sm114958585e9.8.2026.05.10.09.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:09:56 -0700 (PDT)
Message-ID: <6373a75e-eee5-421f-b178-3c82696a8149@redhat.com>
Date: Sun, 10 May 2026 18:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] vfio: propagate IRQ notifier registration failure
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/10/26 10:43, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() clean
> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
> fails, but still return true to their callers.
> 
> Return false after cleanup so callers can handle the failed registration
> path instead of treating it as a successful notifier setup.
> 
> Please ignore the previous version.
> 
> GuoHan Zhao (2):
>    vfio/ap: Return false when IRQ notifier setup fails
>    vfio/ccw: Return false when IRQ notifier setup fails
> 
>   hw/vfio/ap.c  | 1 +
>   hw/vfio/ccw.c | 1 +
>   2 files changed, 2 insertions(+)
> 


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


