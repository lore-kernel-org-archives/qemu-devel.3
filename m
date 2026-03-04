Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38502EDEC1B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:48:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxgy2-0002w8-0X; Wed, 04 Mar 2026 02:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vxgxy-0002vV-UV
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1vxgxj-00022b-8X
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 02:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772610485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mWPQkYSv9CCOZUAaCEQcCnFWU2jfi+WNj+abG9bHF2U=;
 b=JnlATQOSu4yheW4zve/o999kx2F01Ib18lotr9Cf4UdSWevKKGcsl+3iLZJvjeQgWy5uJM
 K+atMC8bxEQDo8JuyKObBAbLc+74UpzgdKnDuKWR2gUTbE3JE6kb33m8XCHFgjpw9yOYvX
 WlZXI48Xw6zxu8mGwJBqaZVmY9GuaKY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-dEbOaqjjOzabOxv3Q8yMxA-1; Wed, 04 Mar 2026 02:48:04 -0500
X-MC-Unique: dEbOaqjjOzabOxv3Q8yMxA-1
X-Mimecast-MFC-AGG-ID: dEbOaqjjOzabOxv3Q8yMxA_1772610483
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so2619448f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 23:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772610483; x=1773215283; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=mWPQkYSv9CCOZUAaCEQcCnFWU2jfi+WNj+abG9bHF2U=;
 b=XN/fpifo7LrsOZaDkJJgPsI0GmPyU+8+pAqwnHDqExya7cR+NPwrJillwmIscjiQ0O
 iX4WMd6t1ZtAoom6Lk/8UyyfQ/nKrcrmHstA5WvjAe/LjwTYYPdqwYlae/w6q7kV5UWz
 LHub4qdSmKwo0VUN/AMQJj2UZdiO6Dx9c05t6TtMHs/zAVf/Wwq5YR56fvkc3WNhJoG1
 0ys9gQJvH0T2Gaq4Ea1OrFrsRKjgSSfolwKo359WDB+iNSNJKemehAqxRxVUW4AJL59R
 vFTfWqK8bloQc1rqyeSSpgleKescMiAfF5Bqb9TGtt8qnPNBvV8uvUegbbyv/z1Fcdwp
 QGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772610483; x=1773215283;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mWPQkYSv9CCOZUAaCEQcCnFWU2jfi+WNj+abG9bHF2U=;
 b=Vn1jx+vpev+4zUQvBCgo4J9lkQwdY0TufipBmmnLsaSoWegiy8zniXCLgSR3vXHw2W
 cWIwGGEZC/PapbYukmjsZjNu876kRxXYQwlYVDeOGmnA4VHFU32izMVEq0C0p+5BXGOt
 7TXr03Z5NBcaVDrgX7ZgVBR2bTrj4lDV09WLYcwbAhNkRT0XbyGkFul3IF88wlkyqLNj
 Vt+79bZSJ65kHhb6boKKQvRYx+kj6+BsrmIhZrao/ZZFlluUurvqDNbWYGtymR0/+zKt
 EyvhsFathdRHThsTUyTsB2PhRaRotYsUXqfoCJgHt44WUexv+Wz6DlPdM8rb/rg2f3Ol
 xqXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpQ11y4Rk7zjp50qa/uW0fQ031Op1NA3IcZMr9X14ZZSwEX86dtJnZJKtkc/ZqRCLBjMWHedvqdAma@nongnu.org
X-Gm-Message-State: AOJu0YxCJaDVOzzXmthHIwFZHPVtTtIjyY4czfcNkqNIMgJhxpHMFyRO
 ZLXlSFFzYLPIIXYezwHMGJOJtz8yZW9EWVkNxBZSTEUp3NXUnCWMmsjf7IiyqlltXXP1ugPanxk
 vX3qZNfzJKFT1EP6XFVGQJSiOci2p8u28e7r2k8SgqvMzdMH3Vadlst++8VSlmG6q
X-Gm-Gg: ATEYQzyJM9cICkqsJt9kT3+OYxBDw+eiXnN5Lo136GE/Q7K3Ij1Z0blQmcCcxLP4vri
 bbL7tZkfXJcQ9Qpp/XUkQvMqiQt2EnY6jL+0R2E0fAPs0vqancGBOZHZWfAMmY7VKOhsOpMBAzL
 gz/UEr8JhJgUAhG9551Ad1J9BSr8GOtg5E/pBfnbV4mkCL/luVCZAjpzUQFf0hbD7UP3bIlkqLf
 0Z14mYr0JkqukwZaencB/NgNbj54JeHimxqMF7RSdx75WuTuJ+suXuWoHr3NADnFDUlLb/5xHua
 KnxKoX13KX3FNymZMvM+13kq6bo3C/WQdsSp3UEvmSyzo73cKJZTYs+FusvA8jC3yqrTG8QR9kG
 CTVwY2Y6ND131I9TolBkmDoxLl+ROJb9+XTQikVaCQjFH4SsyUy8NIOoVcW7BH+gMbA==
X-Received: by 2002:a05:6000:1447:b0:439:b11e:a5c6 with SMTP id
 ffacd0b85a97d-439c7fb236amr1747410f8f.24.1772610483120; 
 Tue, 03 Mar 2026 23:48:03 -0800 (PST)
X-Received: by 2002:a05:6000:1447:b0:439:b11e:a5c6 with SMTP id
 ffacd0b85a97d-439c7fb236amr1747372f8f.24.1772610482617; 
 Tue, 03 Mar 2026 23:48:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:4326:a36e:a7cb:624b?
 ([2a01:e0a:e10:ef90:4326:a36e:a7cb:624b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b55df68dsm21418882f8f.26.2026.03.03.23.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 23:48:02 -0800 (PST)
Message-ID: <e0651889-1d1d-4308-9e7e-36d1416c7638@redhat.com>
Date: Wed, 4 Mar 2026 08:48:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Only kill passt if it wrote a pidfile
To: Peter Foley <pefoley@google.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>
References: <20260223-passt-v1-0-101c6ba1c88a@google.com>
 <20260223-passt-v1-1-101c6ba1c88a@google.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260223-passt-v1-1-101c6ba1c88a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/23/26 22:52, Peter Foley wrote:
> Avoid killing qemu if passt failed before writing a pidfile.
> 
> pid is initialized to 0, so calling pid in this scenario would kill the
> entire process group.
> 
> Signed-off-by: Peter Foley <pefoley@google.com>
> ---
>   net/passt.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/passt.c b/net/passt.c
> index 9ed811a514..b3d4b71314 100644
> --- a/net/passt.c
> +++ b/net/passt.c
> @@ -102,7 +102,9 @@ static void net_passt_cleanup(NetClientState *nc)
>       }
>   #endif
>   
> -    kill(s->pid, SIGTERM);
> +    if (s->pid > 0) {
> +        kill(s->pid, SIGTERM);
> +    }
>       if (g_remove(s->pidfile) != 0) {
>           warn_report("Failed to remove passt pidfile %s: %s",
>                       s->pidfile, strerror(errno));
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


