Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1349CFD315
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 06:18:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNmNV-0006Wi-RL; Tue, 25 Nov 2025 01:18:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmNT-0006Uu-Vg
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:18:16 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNmNS-0002KO-AI
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 01:18:15 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so53524845e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 22:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764051492; x=1764656292; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DGzD1fnYIa6B4Wk/+xHq8vM1YIpJLnhM/vaTxvSqse0=;
 b=luFiztEhAmtaqU3X7tF4k/4yQWO4f3aXIO5zrlIcdg9xwF0yjt4JvhHjYG54MXQyy0
 LWYPnBWh4P3SdVyhoVYgF2uB7YDqDqvFNXt34NHJJs9bGUYlBkTw5tgUYRP0QFg81JVb
 Gvlt7n70uhB3plJT6UQLw7zq6S4oGfIJRrrve8p36asEaI9NZx6SFcvHIY236lOcmKd4
 meeDtnlLqT2ZWLGYftvLXfYIcjBxS/lOocqv6N8vB+M8rMAyyOUZaoxVNDFXfwPk2OGu
 KAh1O7z/gXfytrGoeAmYER7RAz+RwfhQwATptRxmZBcCn1RvgZXiM+JGsIvw8FOMWHZ6
 lwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764051492; x=1764656292;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DGzD1fnYIa6B4Wk/+xHq8vM1YIpJLnhM/vaTxvSqse0=;
 b=oM/nvklcmgHr3QBEUroIdXc8lduYcJ/RTWNcKEpA/AhgrCm4aucfNTjlUAa6+v2qoK
 uuR90D2bw8YdYJEQvxpEeUlWJFX/sYBm8tZzMsU0RV/3Ut52o++9dbOLSw6IcMOkeblz
 ZmVSFF6yl78Ja9RqO9N+K9P7JgJn76bZWErBwUkQi/YeQbRcAKEVdDblh8ixGsNXbL8/
 jEG7Y+8QVtWFduAb1095xzFYvUfkkaLtwMJpH9HsxPzOobqqEuBdh7ACnf0srN2zIy0A
 8yqqQxEA+IeR5TEYTHcPglus0nupXeCrqLwMEHjMzIgM9nP6YkX9owzYN8HgF3QGlDbt
 Fs/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsVRUqIZmcgYPJqepxslr20EsbV2Y7E1WcTGme+9/CX/hSi+rGPDw0/SOEpA0D7WBCDNlA76YMjACv@nongnu.org
X-Gm-Message-State: AOJu0Yxvw/txW70r4yWnN6dXe15S13Q8plvWgmuwlx/T/JmY2/W+7pIm
 vIdWLsOIeF4jWyI9MwCGeZZDDxAikjMMQrjKeoXLKuuv2z7bslpuVM8NDfJ6Z1zr6+w=
X-Gm-Gg: ASbGncsDXRPe2GJoIrwB0G7ol3vfcy4sNVjqjvGgrhiuNW7S0065KMs9Bgfc8T0+Dtk
 tzC1t8GNF11hYTLayVV/vSGD+0SxnbGD+ioI/4H/s6Y6Hf/PoSHsh7d5O3D+ONjlwqbKKA138HV
 qrMr+k8D5ym6S58e16ZINZSnkh7NwBy42JS3LZYwO0okK3ByqNqaCKZcNkUpTu6KOdEgmi/YxMt
 tnbiEK3fQJ8bqop1FGD/fD1nWh7Ec36zg3KTAEFTlrwk7s42RLtuIC9MER/cjHqa2lD7a6iEdwQ
 hZ2cL9+oi+llP9odpN0wW65f3n2mX6+YJuxr6TsN6s5P0ZwxFugjg/vRLNJLv/tbzI3pVnte5o2
 y5DKd+PHHtv3VQrRCIPPu+zH5jXopMU4YdH+fEMgzQNH6g1/Ges14kpEtqNfa2PoCX5JrSGn7bN
 5uJOGLBy/NJvoscj0Ca337ux0dWif34XBRXNkklrGEN82HzQbj5tN5WTsvO1ntY3q/
X-Google-Smtp-Source: AGHT+IFEapOZrwVKXPqkXWl1ucGf2xeCrDksHj/tDIzv3GC9v5QhNc1aLWWWmC76do8k0bUg496w7A==
X-Received: by 2002:a05:600c:1c87:b0:477:98f7:2aec with SMTP id
 5b1f17b1804b1-47904acef12mr14113255e9.3.1764051492559; 
 Mon, 24 Nov 2025 22:18:12 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf22dfc1sm231064705e9.12.2025.11.24.22.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 22:18:12 -0800 (PST)
Message-ID: <37f651b9-06b5-4264-966d-f8c766df6be8@linaro.org>
Date: Tue, 25 Nov 2025 07:18:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] hw/scsi: Use error_setg_file_open() for a better
 error message
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
 <20251121121438.1249498-7-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-7-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/11/25 13:14, Markus Armbruster wrote:
> The error message changes from
> 
>      vhost-scsi: open vhost char device failed: REASON
> 
> to
> 
>      Could not open '/dev/vhost-scsi': REASON
> 
> I think the exact file name is more useful to know than the file's
> purpose.
> 
> We could put back the "vhost-scsi: " prefix with error_prepend().  Not
> worth the bother.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/scsi/vhost-scsi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


