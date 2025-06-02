Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71611C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 10:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uM27K-0003Ll-4K; Mon, 02 Jun 2025 06:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uM27G-0003LR-Db; Mon, 02 Jun 2025 06:10:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <i.maximets.ovn@gmail.com>)
 id 1uM27D-0003yQ-AZ; Mon, 02 Jun 2025 06:10:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id
 5b1f17b1804b1-442f9043f56so24522175e9.0; 
 Mon, 02 Jun 2025 03:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748858996; x=1749463796;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:cc:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xIwIhGF8WaCbT8s5GQ71cTxTuIurkxymYME+Y16Dxy4=;
 b=imxvOyqTbZHhBQP3SYpdxvKm1DwYKsTmEVwqDCjNNU72OF0FFQZ3eIj1PjE84s9ikE
 tR0evLRCfIK0V23j6uzce0fRHNEwdKRFNUPGEtKwfWj9r1J0tot0zMAmp2wqsPAyE7+W
 rxAAtSPFZylSf1otWrfznUMZIxLPedNsGe4KP++J5b3QZVZPYDMoog4gZ7jHOlvz6zDH
 WFi+MKfugeMutwQ3s/vHWkmEmyBEU2BQ1uhj20EqkzvxMR3GEe9efDU7v7CkUYYYUtHk
 wGjAEwDKyCWN6qQaAzhL4OAj/qnXuL0fvb11wGRsOqJSQPHQvQsfYC+etYrtDFVDy/Bm
 XANw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqqbnxnsnBOqj+BeorbiHfzxeQ9dFL4rLKLK1iC/nO/3CwHT+4vvEl7itcYAXNmeBCVGxKtIYCOVQMSsI=@nongnu.org,
 AJvYcCVN9KS6m5wiyFtCeNbseBPvMEUMT3N1MKkK+jGyhn1Pd7VJX41tg92a1Q+j4Ey32hQ+0ap5sMfuDxLg@nongnu.org
X-Gm-Message-State: AOJu0YwcBCgOCFAdk5+Hagr3LbjtBvd2CnDxEUX5XeXGARM0I9/kVYQB
 nyH+J+ys7IDv8aAUpSn9mZzNYdNC68o+F05AmZQL4tvTZCSjdujTpuM5
X-Gm-Gg: ASbGncsyNlh4HoTPcSTWb4Hug46XOCan1uoh2Sy6X+BLCjBETMycfzwOg+vmrknRe94
 wGeoje///11ddXdWq5OAl6KqhmIhN81ZJn37o3C7j5xADpvCVILq00KkgkyNill5kLgWDy+etNW
 6ohJoGcXn60H/LJxYsfjV2B8pZXSEWbP4BkkNQ0HJmidVUvMEEul0iHaa8i4KoBVgjYqSkVvJjP
 zbS/U3t1pQoQKzZe+ICGCkzxV7klIAlL7CtEkdoJi/1pwkVshLwOwTrADalMX8Y4Nk+ZYMCnR+y
 +X7LYS40rJQ5i6gIkWlEJedtn7q8YNsZYVTSL/urywV8vxCsPt8WiRPf2iaoAzZdsKVOHAUyLjS
 gSYM9/98pdyqC+dE=
X-Google-Smtp-Source: AGHT+IFaPL5Ha3O9hvzrWcaGZBwsn9WI/eMq3EHc24cqUOVWXokZfqBvbUNv7nk5PHUkFcLzob8PZQ==
X-Received: by 2002:a05:600c:3504:b0:450:d30e:ff96 with SMTP id
 5b1f17b1804b1-451171dc1eamr77532085e9.0.1748858995531; 
 Mon, 02 Jun 2025 03:09:55 -0700 (PDT)
Received: from [192.168.88.252] (37-48-2-229.nat.epc.tmcz.cz. [37.48.2.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f1adsm118072025e9.7.2025.06.02.03.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jun 2025 03:09:55 -0700 (PDT)
Message-ID: <0d212c9a-aea3-4728-9f57-d11f55e4d810@ovn.org>
Date: Mon, 2 Jun 2025 12:09:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: i.maximets@ovn.org, qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org,
 qemu-stable@nongnu.org, Anastasia Belova <nabelova31@gmail.com>
Subject: Re: [PATCH] net: fix buffer overflow in af_xdp_umem_create()
To: Jason Wang <jasowang@redhat.com>
References: <20250602085719.5058-1-nabelova31@gmail.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <20250602085719.5058-1-nabelova31@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.128.67;
 envelope-from=i.maximets.ovn@gmail.com; helo=mail-wm1-f67.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 6/2/25 10:57 AM, Anastasia Belova wrote:
> s->pool has n_descs elements so maximum i should be
> n_descs - 1. Fix the upper bound.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: cb039ef3d9 ("net: add initial support for AF_XDP network backend")
> Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
> ---
>  net/af-xdp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/af-xdp.c b/net/af-xdp.c
> index 01c5fb914e..d022534d76 100644
> --- a/net/af-xdp.c
> +++ b/net/af-xdp.c
> @@ -323,7 +323,7 @@ static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
>  
>      s->pool = g_new(uint64_t, n_descs);
>      /* Fill the pool in the opposite order, because it's a LIFO queue. */
> -    for (i = n_descs; i >= 0; i--) {
> +    for (i = n_descs - 1; i >= 0; i--) {
>          s->pool[i] = i * XSK_UMEM__DEFAULT_FRAME_SIZE;
>      }
>      s->n_pool = n_descs;

As far as the fix goes:

Reviewed-by: Ilya Maximets <i.maximets@ovn.org>


The loop itself though doesn't do what the comment says it should be doing,
but it's not related to this fix.  I'll send a separate patch for that.

