Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE420CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 16:16:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSGvc-0004lv-4Y; Wed, 27 May 2026 12:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSGva-0004lh-5C
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:16:18 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSGvX-0002b2-4y
 for qemu-devel@nongnu.org; Wed, 27 May 2026 12:16:17 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4906869f0cbso35627875e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779898573; x=1780503373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EmnQlskSFbUayPnXES27TjvQJiLhb+0TJv8CgBvElFc=;
 b=s2cmxv3sEUL9oQEgHqWcgxzuXtCp2Aa+Lx69LFrJINORx+5dssxqlUKv60pq7WuOQA
 4V7zd4AmPHBR9Lk7LKF5k8zMgH15sDWQRIBxhj+lus1Lb45yliT/32q+kQcRPwOvN5Na
 cPJ3lzRYvgaRr3MUC4TztEiXcA3QBVsbvUf7dRlRTO4raU3b46kj9gd6GcG3HvQv2i7+
 NdjQJTTtmNx7c4WHsvl6fNqTUSmSZrFIEpPm5yYGrTe9jYU+0v9jsn+1Hjo1gHX52Icn
 y+hpL8Fh5eW+lOQHIo5uaVINTLcJWQxihVWKb+RLkgavp7yNOsech+sNLaGcU2Onq+Go
 Nvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898573; x=1780503373;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EmnQlskSFbUayPnXES27TjvQJiLhb+0TJv8CgBvElFc=;
 b=gNZQo4TKuKB7HlHsgaCPyDnJI9kS/ohBd1nN/46gjXUtPZFjHjVLpvxzaauo7u5xAZ
 briDYl7NMeXSwwCB0YCfALIKEyx5YqPz9m0vYIdjYZt7/5nZ55RCIf27LvBl37/7AiHz
 K9dAix8ocr4bksjY9XYJhwhXfMQrmfTTrSdUmcYFPJRZx+xq6CLu6BngsOnHcpvggEsO
 1peTPhhu2dMORsqQBEL8K5FYX8sS/8MqoOg4eDU/HN9rXyZlu7gYX20OCyGietY79ium
 82gy+7gY07bU6KqaVBTmvs598AVGEQdksSjSp6XgEfdsjc+xBmaxDNR6JrRElZSe7J+x
 6vnQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PrLneZZDSwEI6bJIvV4LL13YslRYbUFHGBzKIEtZxK1ZX4TQftQnkp+Zf+Yp7CdLFGuGro1Y1ROti@nongnu.org
X-Gm-Message-State: AOJu0Yy2QQfr2Kwbg8Fj7JVKwLNfxJjw2pjjXA6LF/VI+N16snfoDd6D
 9YUw12xvhze2FkE3esT8lTuvwCMhLHBsphW3QhjdwRxppUeD2Nz7K41i98iSN3++cx0=
X-Gm-Gg: Acq92OHYutYfQo9e7GEDifyah9zg53Y8SIdTKSrk7V64ubUBC1vJbzK6VpIicA8169z
 PSG6jPPSW0gXFYfr83nUgAgOYgt5PjE0N39NQZMmON7MnTtPivqzC0Pyv6cnp06W6Rclvnuu/A1
 1mOyZvHw5NVeUfD33jBSHGsOQig9NDIL7nTOzCtNsnw5xnLzqmaK8NYxyD6P16UQOftX6MapY3a
 Ac6Qvj6WvAdYg1lz9MTgid7ZyvdyCOYQa4aL/cyjIgey9TxDr+jdA0NbIrzV0Tv3+p35cPB2jeZ
 EoaYY4M7VQXwTa5GnZAXi9w/uIbIAtkjFe+ef2/ALYqCGnC3qr0P7UBUeRy+zfmGj+EGEHQ+6vg
 lxuWVC5SsMhFrsacNMgIevMk/mXUaAixJ4TmGCdv/vLyf4d8j6P0Gw629CffoN5IUJJ5I0sTZgl
 4QlotKmperpZ9/utGEnVXvFFMRqqiE16bZGry+QSZwo9lb0mk/8cd/S6HYZpshYJUGDQ==
X-Received: by 2002:a05:600c:310c:b0:490:53d3:4753 with SMTP id
 5b1f17b1804b1-49053d34968mr314736015e9.31.1779898573160; 
 Wed, 27 May 2026 09:16:13 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a3c3sm6928600f8f.8.2026.05.27.09.16.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 09:16:11 -0700 (PDT)
Message-ID: <2f0e04c0-9f29-4b84-baf2-c7d236f17d9f@linaro.org>
Date: Wed, 27 May 2026 18:16:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/vhost-scsi: fix build with older kernel headers
Content-Language: en-US
To: Quan.Sun@windriver.com, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, mst@redhat.com, sgarzare@redhat.com
References: <20260525182730.4098543-1-Quan.Sun@windriver.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260525182730.4098543-1-Quan.Sun@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 25/5/26 20:27, Quan.Sun@windriver.com wrote:
> From: Quan Sun <Quan.Sun@windriver.com>
> 
> On build hosts with kernel headers older than 6.0, the system's
> <linux/vhost_types.h> does not define struct vhost_vring_worker or
> struct vhost_worker_state, causing compilation of vhost-scsi.c to
> fail:
> 
>    error: storage size of 'vq_worker' isn't known
> 
> Fix by including standard-headers/linux/vhost_types.h before the
> system's <linux/vhost.h>, matching the existing pattern used in
> hw/virtio/vhost-backend.c. QEMU's bundled header provides the
> struct definitions, and its include guard prevents redefinition
> when the system header pulls in its own vhost_types.h.
> 
> Signed-off-by: Quan Sun <Quan.Sun@windriver.com>
> ---
>   hw/scsi/vhost-scsi.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

