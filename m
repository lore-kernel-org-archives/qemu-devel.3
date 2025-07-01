Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C551C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcH9-0000xI-Po; Tue, 01 Jul 2025 10:48:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcGn-0008PR-0r
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWcGd-0007aU-T4
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751381247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/c/srl17oRApwdvBOlvqlrt8CwS2CkaxhXAPyzmOrPw=;
 b=dZ9ir/YplAWsRVV5OtN8p/0exuePPVXnxX+gy6f2/skeMKrZZZ0jv7DFWTkStBm+CW/5Ub
 CnIg21IVMxjsvaFEQJ8Ot1YtFeZdbEgYx8YWfR5g10Puuob6gcYp8euZSa1P5hlopnPXiq
 s4M6F5+HHlJj0EUw5n9LtBIV4w4rlA4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-_ks_52ogPJmF6OWxfh15lA-1; Tue, 01 Jul 2025 10:47:25 -0400
X-MC-Unique: _ks_52ogPJmF6OWxfh15lA-1
X-Mimecast-MFC-AGG-ID: _ks_52ogPJmF6OWxfh15lA_1751381245
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45311704d22so24281575e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381244; x=1751986044;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/c/srl17oRApwdvBOlvqlrt8CwS2CkaxhXAPyzmOrPw=;
 b=wHeOKswSKl5vrk2aNBoHjjWioUTHKhH4QQBOpV315OeTMAcF6VPhifkB0didZkpdAZ
 gxjg65Tc9ourM1xscFlb4omE8BBNSlvdImGaTHKb+3Ov3vKQNyypE4Y60DRvZ2P13ILL
 hJR1XpMErO1ay5XvacvwfVUas1xtq2C37DOGptfWIS2VjO+wot0U3BxUQ8fDpdG8HGms
 QavqROJ/UBanu6TyzGGILgGAdvQBogcd/5inbzFDN7SmYWh7FsaRS95BfVY1rmKmv4fT
 HDyqlHKvN8EURoX1wjbCbfu/fZp88xGSXJ87mgIfS/BDemynaDSsPGcMjkWr9/LzAkIi
 qxfA==
X-Gm-Message-State: AOJu0YxmRG39/se2w8Bf6LAWqTMcEv3nW4i1vMtTc9TVsEEOYqlToj4F
 sJBzgoHq6z4jC/6Sb4GX8aV/V7l8/j7cRzLvp5V0BT8U05d1UlDhKUDEtOsByq7tIVoXYrx0ziv
 Zim+pOmPIn9AvMmi3cIJ8ngVoBC92U3Nu6DhbXrz6A+hcHdvUB/Mtuwip
X-Gm-Gg: ASbGncs/pkWl9I1SHXbZs+KOlTp1r3pJBZz6PFSphtM2ws9uTz+rlZfLoa7Bw1+cwpZ
 v17cUrvgGdCU9o5Nn2t5ksadC0KiD36wIPBx6N7eX/iL/2SrzeDskSzodlEnIFlxuUafk3Kgjmq
 E75SPO2j9xh252Ry7a5r2awhq+7MwRWWM5zt0XCBcBfYCUIo5u6XArqUvP7eJsZKuT+MIMtW/sr
 FJ2hW7TIbZOmhzKbR5THo+tjjHSUlkRxzL5s3S92Yn1vOtnkNih+esNXgcyUNsubu8f49CBEGu6
 ZV94+PeWgneIPMOCQqFYRDtAT+Zheo5Pna2i/gf64BnKFJZvWLTzwV7kEkJQlHqEMr0D8Y56Tba
 rAruvBNBKWlOgquBlDJkKQP9kxqSxp5ZSk2eFZki1vo5Afz7cDg8=
X-Received: by 2002:a05:600c:3b86:b0:453:6183:c443 with SMTP id
 5b1f17b1804b1-454a07e5a49mr17584435e9.5.1751381244418; 
 Tue, 01 Jul 2025 07:47:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvBy5dLlc+B4YJd3bKEFEt8GHqtU3VTs5webIVkc7wNSvR4s/8EMRJjZKIiZR2eFHEWZnI/w==
X-Received: by 2002:a05:600c:3b86:b0:453:6183:c443 with SMTP id
 5b1f17b1804b1-454a07e5a49mr17584245e9.5.1751381244026; 
 Tue, 01 Jul 2025 07:47:24 -0700 (PDT)
Received: from ?IPV6:2003:cf:d700:f3aa:cbe1:b363:ae39:fc99?
 (p200300cfd700f3aacbe1b363ae39fc99.dip0.t-ipconnect.de.
 [2003:cf:d700:f3aa:cbe1:b363:ae39:fc99])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fa884sm13158667f8f.29.2025.07.01.07.47.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jul 2025 07:47:23 -0700 (PDT)
Message-ID: <e1393191-9a17-4d5f-8249-e81209932b9b@redhat.com>
Date: Tue, 1 Jul 2025 16:47:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] block: make bdrv_co_parent_cb_resize() a proper IO
 API function
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, stefanha@redhat.com,
 fam@euphon.net
References: <20250630113035.820557-1-f.ebner@proxmox.com>
 <20250630113035.820557-3-f.ebner@proxmox.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250630113035.820557-3-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 30.06.25 13:27, Fiona Ebner wrote:
> In preparation for calling it via the bdrv_child_cb_resize() callback
> that will be added by the next commit. Rename it to include the "_co_"
> part while at it.
>
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   block/io.c                   | 9 +++------
>   include/block/block_int-io.h | 6 ++++++
>   2 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


