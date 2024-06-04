Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3867C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 14:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEUjk-0008CZ-5t; Tue, 04 Jun 2024 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEUjh-0008C5-GO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sEUjg-0008RJ-0b
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 10:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717509712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=V1HiMJVZKeLJ34xIsQNw2KBua11As1yeTY2iuJA/sU0=;
 b=K0B9ApL3psNw8eJ0rKZ2zh41hgcvbQoLo9YrbbyIFTuAxhhlvcdnZihx9w1QEQXRxXz81S
 eZ4N6CB+zFRjrsexEEKDMD47USiaiH4sKS5CZaVqxmQIV8CSaDvIuim81jzXNotpgFwrNd
 PICDEIWRcG0NQUXe4U9zMH1FrKXEJIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-IJ-z9ySqNpeNGWhRb2EdWg-1; Tue, 04 Jun 2024 10:01:50 -0400
X-MC-Unique: IJ-z9ySqNpeNGWhRb2EdWg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42133728a50so33063395e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 07:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717509709; x=1718114509;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=V1HiMJVZKeLJ34xIsQNw2KBua11As1yeTY2iuJA/sU0=;
 b=tK2tXommSxSDeAELD8uTPtKq+F2WT529C/OruYpoz5C3ljDvgDNXfbAzZi/MtL7Kdn
 P8rmpc+t70ccVLh/JYYOto2hHcl6dIPvOFy4F4cT04L3Np3Q7KdxpIcI0tMXK53N9b6M
 mtcOEvZJAYESIXHWOaAyQoXiwLJtadu6AZ24LvloSIorbkEibDUlF/9Hrt3hPPW/Z+DH
 mnJADYhOxoz0JsjUetgIwKFALBASfzOY+wxBUqXfs5L8myG2gOP2rRu7wQ2HAq0cDeJ4
 1MwcLP9T0uf1xwkqTiY6TFkmwCfbykr9Pw2nT3RXUjg+nQDqMyT/tLDSPg5499kUjdxD
 G6mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmAkMj6dBECdWpb4e0K7QP8genJaBx3F52V4NAWIFrFmG9fItBEth3Gq+Z5GDnHoMaZwUc/YzpUvct3NxF6y+D8xzNAEE=
X-Gm-Message-State: AOJu0YwZrJrwu1wClKV6HuWKBhR7hFcOGicOqlLnNal1EH6dZOgltuib
 X3rar0O8cbgt3v0XWd/imMsTHE66njNEwqRsnxs57fRJlC0RU46Jth3ur0wF0Kw6dIwz1NYrPw5
 eQBLG/hs3ygrIajNQz510Ym0ZsxXCcSylRYK8c6UGKFdMzW3ujoi9
X-Received: by 2002:a05:600c:34d2:b0:421:10ce:8aff with SMTP id
 5b1f17b1804b1-4212e075629mr132627605e9.19.1717509709368; 
 Tue, 04 Jun 2024 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3tWPgJcoE45F7MGvr4dXYk5T6TU/GGE6NzwHluA1EiTYAb9UJYSUpPF8NK6vLJsw2R8vH7Q==
X-Received: by 2002:a05:600c:34d2:b0:421:10ce:8aff with SMTP id
 5b1f17b1804b1-4212e075629mr132627225e9.19.1717509708899; 
 Tue, 04 Jun 2024 07:01:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c73a:3a00:a025:9b06:549e:c16b?
 (p200300cbc73a3a00a0259b06549ec16b.dip0.t-ipconnect.de.
 [2003:cb:c73a:3a00:a025:9b06:549e:c16b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212c0fb7c2sm152943105e9.26.2024.06.04.07.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:01:48 -0700 (PDT)
Message-ID: <11017c4b-e0db-4f2e-af1d-54bc2c416e5e@redhat.com>
Date: Tue, 4 Jun 2024 16:01:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] migration: remove RDMA live migration temporarily
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, yu.zhang@ionos.com, mgalaxy@akamai.com,
 elmar.gerdes@ionos.com, zhengchuan@huawei.com, berrange@redhat.com,
 armbru@redhat.com, lizhijian@fujitsu.com, pbonzini@redhat.com,
 mst@redhat.com, xiexiangyou@huawei.com, linux-rdma@vger.kernel.org,
 lixiao91@huawei.com, jinpu.wang@ionos.com,
 Jialin Wang <wangjialin23@huawei.com>
References: <1717503252-51884-1-git-send-email-arei.gonglei@huawei.com>
 <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1717503252-51884-2-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 04.06.24 14:14, Gonglei via wrote:
> From: Jialin Wang <wangjialin23@huawei.com>
> 
> The new RDMA live migration will be introduced in the upcoming
> few commits.
> 
> Signed-off-by: Jialin Wang <wangjialin23@huawei.com>
> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> ---

[...]

> -
> -    /* Avoid ram_block_discard_disable(), cannot change during migration. */
> -    if (ram_block_discard_is_required()) {
> -        error_setg(errp, "RDMA: cannot disable RAM discard");
> -        return;
> -    }

I'm particularly interested in the interaction with 
virtio-balloon/virtio-mem.

Do we still have to disable discarding of RAM, and where would you do 
that in the rewrite?

-- 
Cheers,

David / dhildenb


