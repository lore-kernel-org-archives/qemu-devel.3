Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F13D10384
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 07:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAFW-0006PF-1i; Wed, 26 Nov 2025 02:47:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAFJ-0005rf-3B
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:47:25 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vOAFH-0002sf-Hi
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 02:47:24 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42b3b0d76fcso3943188f8f.3
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 23:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764143242; x=1764748042; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zsieY7w1fxjIpAfjZ3y4sG5vS6LVcOFLLmGd+GcbgpU=;
 b=wheSTT/YQOI2MirZq4lvJHZtjve20xwd/HJZBGdWc7/NHzy7jGE6JGIsX9+1CY1FIM
 ySM9uuS6uN6iZLN+3cTVPDP0OdJSn7ANAlaYi/BKyDOfvN0wGMsIjhCTUhqESghU5/Ba
 7vhauNI0ZSManAE98isbkPQozlX93Jeig6lcNFUl7vpqng/w0WRPBfMg7BVOyb7IrwAL
 BxPZC4Y/OmVQis4wosjLuKuV5BM5VdojfvAwi/FI+6FGcdQLCCljkNVNp/nViN5/B/yU
 5OEPRR6BtAUX5WAVUOa4wzvQsEPyxNG6IpRK87amjIvK/2R9reHqHvuT8OPXUF67kafc
 2N2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764143242; x=1764748042;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zsieY7w1fxjIpAfjZ3y4sG5vS6LVcOFLLmGd+GcbgpU=;
 b=E+hj2Dv5UJOdOoCdPiMc9+iUSB6VG6w35x/wlIxKABodSqBXaPQIehJitWmVOcGfdA
 IkUONOOC6pXjDT64axPxXM6udnfKk3/W+eFfcHqIqJ5URWQrKIYrxCrlmg9GIuur2edP
 2tXZELfXdRHsyoYXYg0LzMO9yUTzizDBIljK4hd03G/Y7izUj2Y3PhexKact2kTIpJVI
 4zMJPq1XyaS/dkoF8E8eXlGB9SeGeWtNkSiGIKLCCQHojGE2Oc8rdQLyrnvMexhXJ7XP
 OH8PA7XLbsBQ4K3GGZvJ+fW1PJQKIrYrwGQ9JLiuLy128v4KlHL/XZWmE+t4dFsjLf3P
 tqjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmNbGOay7Qts0WgVUlPIuNWz4UW7d7MwRtVM3S+U/vKU7j8Eam9rFibqZv34efx2xdwxB/ngWiK/3h@nongnu.org
X-Gm-Message-State: AOJu0Ywnkf9FNivw2wBbJFSMwUPm4ETwGIys9ruVp5yAqu4ONzNBtlzX
 5G5vgvuBQGqVrSX6nZgniNv2NkO7YmompvGIqPYW6C/CXqzjAOsb1as5qg/DknWgQ4hZaW2dvQK
 zy/kM23azWg==
X-Gm-Gg: ASbGncs/4FTT5jbE5meRQ1cHNUKZ5+CNMki+QiW/LjKBNcFTRhdnZnQWfGiuc6P5yl5
 j1/Lv6/W20lH+Y+yQGDKhbIwW1i1PwKXifcW3FQuOePb7P6JPPrLIZXkwwFTXLDuUtDeUchrtA3
 LL74+hF48NWioQj9PLBbqE3lSDUHQXOkauHdLNm6sO1Xcao8u1/n9zRkPGkds7ldSuv5mH7ctKf
 mXq8+dJUwL8uO0ef+P8JPX8VCP1OTGxY+DS4pinUddf2LgAj2IdBsyuO2VmwFKKaIL4INijHGtl
 RPie7KKUFSk6aWBHheRHvRMG56RlfdJhm6+/+ORF8deK2MhqdS/QsyT6Yuel8Hayz5yNy6kyH62
 ORK5vdIWFBdAfv0+JUjqGS/IK0UF0RdA/6tHZ7uLgZiTBOp5soqlMr0YRNE7WPErlCGT0kUF4ao
 jqIRMukppUqXqUVoP0rXPG3bVRz6bObWuYVTsmqOQ2dvw7DYLxW9j6Iw==
X-Google-Smtp-Source: AGHT+IH2GXe3uOHdS28Ob+Jmg5+KHh4tMhOG/Rv+GpKOzuevWPWxYjVQGr2hWKaJgLZVaJdz6qu+XA==
X-Received: by 2002:a05:6000:2681:b0:429:c8e4:b691 with SMTP id
 ffacd0b85a97d-42cc1d5239amr18461831f8f.55.1764143241928; 
 Tue, 25 Nov 2025 23:47:21 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm38740426f8f.2.2025.11.25.23.47.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 23:47:21 -0800 (PST)
Message-ID: <2bed91d0-8574-42ee-8d7d-e85f3ae40c1f@linaro.org>
Date: Wed, 26 Nov 2025 08:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/15] Error message improvements
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
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251121121438.1249498-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

> Markus Armbruster (15):

>    hw/usb: Convert to qemu_create() for a better error message

>    hw/scsi: Use error_setg_file_open() for a better error message
>    hw/virtio: Use error_setg_file_open() for a better error message

Queued these 3, thanks.

