Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDE7FF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 16:24:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHlER-0002Ua-KI; Tue, 28 Apr 2026 12:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHlEC-0002U2-Uj
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:24:06 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHlE9-0007Te-QA
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 12:24:03 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488ba840146so104843045e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 09:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777393440; x=1777998240; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=05EgCJHridX2fRXB0kppii82iwwIPpM2gax1H5yzxJs=;
 b=LkNp3dGuNKVkI7bWE7NZPipPY2OccZTCHjOyVvcZwlMxcvXAUjw7H+AOXuIon5Q0t8
 UpOGzYHy8z48X+KHZEHZQlAIHqZcl2g1Fdl7evyZz4GislcBnkhRGq/Ep2x6+f0cBcFf
 DqIkWfiy3fIY3u2U3Dm16Yuo/Cho0oh9CDYEKzbJ87i7iPlgUQM1cKY8zg4mG+xwxI19
 FsUrFzBhDEJ2gkA3/kMtfgJAvjeIU2Hpe4reG2YGw5/qPgYhbo0Zv+Jc6YSsymUa3Fge
 Ep6eoqu9Fc64kF/tch/AOYIdzTncnaAOWwRV5ZuBBb/jEtCtzneZztScKhNKlnukKGR7
 OIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777393440; x=1777998240;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05EgCJHridX2fRXB0kppii82iwwIPpM2gax1H5yzxJs=;
 b=Vpx+MKdN5AZ8+1l0D/lzTobazeogLuPT+PZxQvh74waIl/TqhTga23hjyZ3q6xQmqe
 Edn2iEgyIyor/C6BPQeE2LK5nL0ws+FEWkZ9F7liCXOV4TM1U70VFc0SqpI4KqZaBuF0
 P4DeqpnD6qzTd/Tek3/iTF8n/BibziEjmjb6h/7DCP1W2sa6m6PpRAIE8YqslhgxAqYr
 r7MJiT2Vo7rqXxS7djeBZNY0scVw81GLRRkLj3PXm10bzJX+SL3wbNdu7Rlw2EZzospj
 h96lzSGEBag8mgqYVmVw3oIVAZ0qog6KK2HahBn+v1qW+0/38zqv6ui0+pSjWVIrPvBs
 ieVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9fyi2jHzC416Be4m2iQ1Iob0fKBnkE5Zv/+s+RBzZzSu4A/WSPPXZTpUsnifTjP8GPaD/DJZXVmQtL@nongnu.org
X-Gm-Message-State: AOJu0Yy/MiDpaiRFQH6WmAUZzRWzrw9uCxECpxobQSNlCW26bOCvkFUf
 4v2qXm/N8WDKu4hGEZDJG1FyzrUHkPmc6wTMEA1enbvxh45ucQTYCVnqhvj1d/cJxDQ=
X-Gm-Gg: AeBDievF8vC9DopEJhw9Zq7p/T+Ff0Vfl3BgJB+OSpnmFhUdZd2+mY94T/Ox5a6Ewk+
 nP/D1jelQjyGzwnES78+pxZQoVtKgnOGmePf8h9Fe8Th0Q3dkw2i2oXZAEyoTunGioJjItHcVCV
 CSD4gdv3JmalWaU/T1Y0LXutIQrygqq/p5pwpGNk+VUJQh0ly2yfHdKNuHcbAOqme5waw0Zj/Ja
 y//Wb+6rvSxjUTVF/+s1yFqr55+YLnEk3XDdOUY6tdD+XiUFD10eOVhKV/pcAidCb3RDdEx/NUu
 bBuMu5Cd7G7Mk3mhsOyr3/ymdyXjCe37oErtQyCqoY+MGT6OW92emA5Nf+iAzvgfONMbj1tOEKn
 DVMh1TYkwtdxKSXuuAuBDgX4jWkSD6K0h8CujVIsPdRDNDu268PoCj6O2QquyEaMV+e72E2Fhnb
 nfdv1v52G7A8Ua0LKuQ919nuBPAtXpQ9lDFBlEqufjZde8YaHg6RxzTEbAGxbVoLiKBHSqXoBZ6
 NVoDP4kT1eDMhg=
X-Received: by 2002:a05:600c:1d1a:b0:489:201c:dc46 with SMTP id
 5b1f17b1804b1-48a77b04774mr57405755e9.12.1777393439955; 
 Tue, 28 Apr 2026 09:23:59 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a775f69cdsm21172115e9.27.2026.04.28.09.23.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Apr 2026 09:23:59 -0700 (PDT)
Message-ID: <88f8f165-ad24-4cd6-aed5-3b2f9200ed5c@linaro.org>
Date: Tue, 28 Apr 2026 18:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/intc/xics: Add a check for an invalid server id
Content-Language: en-US
To: Gautam Menghani <Gautam.Menghani@ibm.com>, npiggin@gmail.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
Cc: kiki <Chan9Yan9@gmail.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Gautam Menghani <gautam@linux.ibm.com>
References: <20260428103645.50617-1-Gautam.Menghani@ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260428103645.50617-1-Gautam.Menghani@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 28/4/26 12:36, Gautam Menghani wrote:
> From: kiki <Chan9Yan9@gmail.com>
> 
> A malformed IVE value can result in an invalid server field being
> passed to icp_irq(). The function assumes the server id is valid and
> may access invalid state otherwise, potentially leading to a crash.
> 
> Fix this by validating the server id before using it and ignoring
> invalid values.
> 
> Reported-by: Zexiang Zhang <chan9yan9@gmail.com>
> Signed-off-by: Zexiang Zhang <chan9yan9@gmail.com>
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v2:
> 1. Fix build error and subject line
> 
>   hw/intc/xics.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

