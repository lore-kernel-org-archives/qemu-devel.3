Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C25CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 08:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCDQR-0005Yj-MF; Tue, 06 May 2025 04:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQP-0005SL-9c
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:13:13 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCDQM-0002Rh-HN
 for qemu-devel@nongnu.org; Tue, 06 May 2025 04:13:12 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so731694366b.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 01:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746519189; x=1747123989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rk5+JOkVI1Iae0WJiXrXiJp9Lx0r149VWjePrxsAQFU=;
 b=jEfBwEFYE1DhybvVHIqLPHQ8nnC7LGlkC1kMmaYhY4bwB3on8+EB/BRcWWAwxHcEf3
 dAld5onqNAkIc7rdnRUQW9kGHTnUdd+Ce7J/nixB30TJJ3yTRM89t3+Xd5GHf2DAJ3wL
 4p5QeKPi5XxshJv7z0TX6C2Zdmfjiy0jf8AbB7A+HMQEcxxHSWU50msBDs4YsGvPKl9Z
 3gu06ZrrQHGBojTkGqBscfpffD0+q3nUMqPDeSHpy1iYr2QBaFwWZDaNM/EecRb84Z5b
 KTXsHkHn5Q+4iPa30+vmGZYJAt4Eeb4bd6gLgf26D5NcnZz+Z7BcSTSFfrp4+9CqEhfr
 n5qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746519189; x=1747123989;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Rk5+JOkVI1Iae0WJiXrXiJp9Lx0r149VWjePrxsAQFU=;
 b=HiVWAuelTbtbCslXIzruYQQsJ3D7Rmyal152e/5b/TlPkky9ulOCyHcvPZtTdegt97
 H9RBo3WtGzMBj/bFM74CNP4+t5JvzHWWWDjHWcX/lYq+m6H+DkKsukNPxPwzL+Ie3U5k
 9GOEQQ1+lxIH5K5TLfnA4MqbP04uD8Y+3M4D2CesIN73qCuvIbdmKCExS3DWFyFEm7wp
 ygbvRFfuomaYiUFWDpAb2fI0tz4WumfB6pqDclCPbaRsOdklgp9HTG4LJ3JA8v8HYVOt
 4uJ2k3P9nrIR2wWCy7Z2osNeHChX4/pRDrWaZVNJSEFew2gCbDzpm1gmAchG8QYt1yAc
 QVcg==
X-Gm-Message-State: AOJu0Yw4Bd61QpL7zAFaVA4Oge/4w+u605WUfMTq4/1Cez4aX3CQkb+U
 6+wqy2hp/4eBSrMzIxy0aOefgwe8gMMXn4xIepWdMHOiG9C+Nkbs+WTgl2nDlmc=
X-Gm-Gg: ASbGncvXaY68du5cib0EoolYgCVDpq1b3juETZJ6WtWPhvrYqnvkEtlTOvfW7Xzcd0H
 xrr3IIpVDQHqZ0lcaOTFV62fhUzg6zxhRF8bcDHggw7dZzrCFjpqRcR7XGJ+R1bN2pw1DqZ7rc2
 1Ak47Tyl47VBvnLu2c2/WrlqJ9ZPVgV/H8PHKeNxbxo9m0WOlPwU5cQGaVckMA4uEeMSho8RbYp
 KIG/tKdYK9OkIELmcBtbV2/L3axXB0XlRm27EpD14BmV5Z+5dSSrlBN6RoG+X3OV70OfjZNjVUN
 gqqNesO1YVUmecLg82v9Nyfbder0yg+REvKxxq5x8+ts8dPrMlfrV+kzpt+DwrrPOGJsOTb7iXq
 AlTI=
X-Google-Smtp-Source: AGHT+IHg8xFxtwSPB1jX1Qmk1F2i4yvIXSdXrmRyUA7xTk3ZnWfERdHGIocU0l+UZ42KP4rS/gWq6g==
X-Received: by 2002:a17:907:2d12:b0:ace:f53b:ff4a with SMTP id
 a640c23a62f3a-ad1d46ea512mr185086166b.50.1746519188972; 
 Tue, 06 May 2025 01:13:08 -0700 (PDT)
Received: from [10.194.152.213] (238.21.205.77.rev.sfr.net. [77.205.21.238])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa7775ca09sm7272174a12.11.2025.05.06.01.13.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 01:13:08 -0700 (PDT)
Message-ID: <a1b6d9ac-68b4-48f9-955f-d7d999b04fdd@linaro.org>
Date: Tue, 6 May 2025 10:13:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] hw/s390x/s390-virtio-ccw: Remove the deprecated
 2.12 machine type
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20250506062148.306084-1-thuth@redhat.com>
 <20250506062148.306084-6-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250506062148.306084-6-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/5/25 08:21, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The s390-ccw-virtio-2.12 machine is older than 6 years, so according to
> our machine support policy, it can be removed now.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/s390x/s390-virtio-ccw.c | 14 --------------
>   1 file changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


