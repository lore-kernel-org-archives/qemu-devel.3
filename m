Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7599CFD37F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 10:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqIf-0003mc-UF; Tue, 25 Nov 2025 05:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqIH-0003OZ-LU
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:29:15 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqIB-0005lv-KF
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 05:29:06 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b32900c8bso3070203f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 02:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764066541; x=1764671341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOtq6FkTjjV4xqPH8MCZhBCC4A3ygFQQRD95vDYNiQk=;
 b=Y1ThCxNNk+zh3BvwgbqRwh0g3KcWoNqFlG2FguHQ1oy3sDzZMsoXuF3btB5Hr3BEn3
 9yQYXVJb0s/PS//yqdVlJtldxIYtUs5JEi5KfvdYjSe0ZS2+7QjpCp044IXl40uJ+KFr
 inUjcySZSwpytTJd/+R8C04YCIQXd+sHcdX9sronq30B3FhvfrnFWAdOqOZFnG7wgQyD
 JNhIDa2N2GjdsvlDhAo/gwtV9kep4O6KvjCEOy/jmTszqvs6zI7AGAB7wPPbmT/rE2mY
 HnNfv+tlvuAZXBK6wQh4tjBW7oxO8EslbXP6bjBAs7FGpvqEE0xL042yN/9eFgO2No2D
 ZMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764066541; x=1764671341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FOtq6FkTjjV4xqPH8MCZhBCC4A3ygFQQRD95vDYNiQk=;
 b=k2QJkR8atzvbTU1aVLw+UWIRj6iHnuSZMu304fvHI7k/EGOmvkUyYGzxDem0OyBjx3
 vzyxppyP0zFdR8cLR1B6mtwRWdZdqKnJuf4sFNWyfFCqjMzfJmPsttwetMeIhEhsO/fl
 VpsYXNwXKVXAZQcVek040w3d7N+ndJHX7pEmTzhSgAOAhXf94+GaZzK3/FVEHr/2/c+h
 l10WB+Bw5k5ajnw5bbGfcvKglCZO+uUHFCHe99i8AnaSWjVrrbxshRuYN2I4QsBk9d12
 DNufwCVmyDXNqsx0xslSVJqHBSnMmdCjhvqVmViD29lD/wnuCWecN7noJ1GydQVLdK+X
 cefQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkVnQKAIZndnua4hU6kNLO8CTR7VzytHTvJVDqbwTncJE2z6PruSEv7FZlLEl+Xoo9G9G7mfdOn8k2@nongnu.org
X-Gm-Message-State: AOJu0YwJMl/YSDeWYZ2Bvt647Y94Bi6IMmtoacnw4X95Zr/wkXAYIXLL
 9+qKAtokvwYGZVngWYfPuXOT9IEMvHQNinjsSeMVoppOAl6rg0/lBcpDNaRFHJ0i2Zc=
X-Gm-Gg: ASbGncvSDYfzgzcXB2iEM5LrKwNdztyVftHMn66zekVUh3M4wBvHHHHOv1/3Ox6Cxtj
 mWOD3Aw4esVhBTBzQ6c3cc+6ceDcvUbML5akRxKqqPdlVP7r3Q1MR0h2tpupq5qBAqVoY0S8+k1
 OVFEB42pF1exMF/ttCds+X4tDcZjOp2Bus4uij5rUtou6VdgsdC8TU6ltEGj753zb8yuJYGPKOi
 XrS/Cfi6pI2QnHxUBBMerKL8iM1JENUxNXug/K+WUSC5+jy4U35fWfBZUsEVAsUX6ZLA7CPNPEa
 P3yJVe8IBnybD/Xndl2M5JxJ7DaSuUA2QE7FdfbhssS9PiNME8yX5iick0NK72ET7Lw/o0nxa6D
 UjeuZ80OSpl1jFd0/tR2+thWCqbEeSHsbvQBLGU9QdxuRfPPv++ueHg5e/1WR13FHccbWEUGnn2
 QnJi9U50L6se9dIkFvSn+fxTXcbWD3/IzOkmSOECLth+RWF4bNWnlu4A==
X-Google-Smtp-Source: AGHT+IEbJeTrLY46fCznAtjfXdYPHTUtYeQtitUWoI1YXftLHuYFMPldzZFqKU9cjG8M/We/w9d/JA==
X-Received: by 2002:a5d:588b:0:b0:42b:411b:e487 with SMTP id
 ffacd0b85a97d-42cc1cd920amr16516595f8f.2.1764066541445; 
 Tue, 25 Nov 2025 02:29:01 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb9190sm33346517f8f.33.2025.11.25.02.28.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 02:29:00 -0800 (PST)
Message-ID: <9922cb86-5c48-464f-a811-05a7a4b4a9cb@linaro.org>
Date: Tue, 25 Nov 2025 11:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/15] qga: Use error_setg_file_open() for better error
 messages
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, zhenwei.pi@linux.dev, alistair.francis@wdc.com,
 stefanb@linux.vnet.ibm.com, kwolf@redhat.com, hreitz@redhat.com,
 sw@weilnetz.de, qemu_oss@crudebyte.com, groug@kaod.org, mst@redhat.com,
 imammedo@redhat.com, anisinha@redhat.com, kraxel@redhat.com,
 shentey@gmail.com, npiggin@gmail.com, harshpb@linux.ibm.com,
 sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 edgar.iglesias@gmail.com, elena.ufimtseva@oracle.com, jag.raman@oracle.com,
 sgarzare@redhat.com, pbonzini@redhat.com, fam@euphon.net, alex@shazbot.org,
 clg@redhat.com, peterx@redhat.com, farosas@suse.de, lizhijian@fujitsu.com,
 dave@treblig.org, jasowang@redhat.com, samuel.thibault@ens-lyon.org,
 michael.roth@amd.com, kkostiuk@redhat.com, zhao1.liu@intel.com,
 mtosatti@redhat.com, rathc@linux.ibm.com, palmer@dabbelt.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, marcandre.lureau@redhat.com,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org
References: <20251121121438.1249498-1-armbru@redhat.com>
 <20251121121438.1249498-6-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-6-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> Error messages change from
> 
>      open("FNAME"): REASON
> 
> to
> 
>      Could not open 'FNAME': REASON
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> ---
>   qga/commands-linux.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


