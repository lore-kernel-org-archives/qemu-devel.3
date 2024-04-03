Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720C6CD1294
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrx4L-0001wT-RG; Wed, 03 Apr 2024 05:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx4J-0001v5-QQ
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:38:07 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrx4F-0006eg-UQ
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:38:07 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-513e25afabaso6825476e87.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 02:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712137081; x=1712741881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDBIKVGsz+hPbNLeLIYbVhky9As1Jm/lz6KvIQ0Fz4Q=;
 b=BsNJkyqDzT7C+Bdi90PLyWl2s8uBNrqbTLx9tOAk3JraqylmTvs6Bcf4eYWT28ScMC
 7wOmXdT23g6V4GTpN8x8ntVc1jUFDfSFJqeTR2Rh2yjlXK2Vz/fIuSR8g3qYrGYxcRt5
 TTGdA6eqZyxWqubNiNvyZxMjI7FyTloeh1mIrOVsu8mqmx6chTh6EXhHGBCL1yM4ATOO
 LGy1A8LWEHEIeV35q0PYZz/CLUCC29EMqe4AGhWzFU2WCkILlQYC+j9He3EDdUQu9zav
 CYkmbzDcU0BU/g387YhoPNxKworFm7ZZpmu6XgLh3Bp+QOPpgm/T1kSz/8Ra1jdM0A26
 frAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712137081; x=1712741881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDBIKVGsz+hPbNLeLIYbVhky9As1Jm/lz6KvIQ0Fz4Q=;
 b=b7I6u8h8lMg+KBPp4OVUkH/DoNnuWNQqq9mMAkkeMbiciP3iLkalvUedLFkzRUGDHj
 MsJKZ9GY4ny1l15F2psXGRgxgsLrEEUU3FPqX0hEXGXjIwElgZiDIsKL0cG4DEDP2nv5
 3FeVcn57bvf8uGMsjSQPFtKb6mL3G1L3nN7qWQ9Q0lJWHdcUYf3qIvGowlv+fg9rN4QT
 fRVZcBhWZO/Qdlt1W/LTugPcUKVoP3M9aP4jI1xFPthwIsn/TVs0iKV/SJExMoTD5UoB
 xtIDTWRajbWHIsTF++eCGXYaKZ2XBr+Revp6+tTEtlnq5YaGe7CihphQo13GBTahy9Jz
 +Nkw==
X-Gm-Message-State: AOJu0YzB4AdDY5bxtjhRGORMny8k670fiSq0tPpGDj27piCGK/6717Nt
 nLOwKFDBZRVNoR8NWPIR/x4JYR8+goopHDZ/pkOI94medA+CbqUNqt3JTFhKqWg7Ax/7jFU4kHp
 h
X-Google-Smtp-Source: AGHT+IH+zyWbUg6yww6kzmmHyJqwXeRIzNMG/Unnsa8d5vze5owulzbk/cAuKJfDPljJ7wLjwqG8vw==
X-Received: by 2002:a05:6512:a95:b0:516:9fdc:2621 with SMTP id
 m21-20020a0565120a9500b005169fdc2621mr9981946lfu.0.1712137081378; 
 Wed, 03 Apr 2024 02:38:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.223.215])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a05600c190600b004161eba16b3sm3511690wmq.29.2024.04.03.02.37.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 02:38:00 -0700 (PDT)
Message-ID: <d8ec079b-f7f9-48e3-ba9b-44c926416210@linaro.org>
Date: Wed, 3 Apr 2024 11:37:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/3] rdma: Remove RDMA subsystem and pvrdma
 device
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, Peter Xu
 <peterx@redhat.com>, integration@gluster.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 devel@lists.libvirt.org, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>
References: <20240328130255.52257-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240328130255.52257-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 28/3/24 14:02, Philippe Mathieu-Daudé wrote:
> Since v1:
> - split in 3 (Thomas)
> - justify gluster removal
> 
> Philippe Mathieu-Daudé (3):
>    hw/rdma: Remove pvrdma device and rdmacm-mux helper
>    migration: Remove RDMA protocol handling
>    block/gluster: Remove RDMA protocol handling

Patch 2 superseded by 
https://lore.kernel.org/qemu-devel/20240401035947.3310834-1-lizhijian@fujitsu.com/,
queuing patches 1 and 3 for 9.1, thanks.

