Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A45C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 15:10:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXN5Z-00033r-Qg; Tue, 06 Feb 2024 10:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN5X-00031L-Sl
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1rXN5V-0003zr-PR
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 10:10:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707232216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ELqxkH6OfpG3Zxod9BPcYfN11cdazxR4YFVrCE7rSVc=;
 b=YKzBqQFnB9dDo/ToMunjh+n6ORwwic4sOgagYHDgnteZla+R+l8aqREXu5BAoMkgREftW3
 7VceMqlgQfEvuuz2jDSUpxaOGKVR8KsifkHBgjsrLNBkMdTxRYzzz0Oy7fYvm/G8uVKT1e
 Xm1l/rlrJ3mAda37MvUW9sdO4R9iRSY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-tSxAoPf8OWGKG8NTbXe8lA-1; Tue, 06 Feb 2024 10:10:15 -0500
X-MC-Unique: tSxAoPf8OWGKG8NTbXe8lA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33b248e7cf0so1829391f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 07:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707232214; x=1707837014;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ELqxkH6OfpG3Zxod9BPcYfN11cdazxR4YFVrCE7rSVc=;
 b=Q53JN6SxEhV1thKIS1K2RrlOIlrviLmVKAXAhCApXxP5xMIOUaJlYTpMJhfOnTvDvr
 mRVu1FoKukxcPOf6NLQ3HRkNlsxIOq6wIg8Lkfw5F9eQj+eJab0LjoV4fezqTRaMWh+h
 OAZvJx6nMO7u/3gWGIhoSK2hYsgpIGTQe8yBEym1E1HYrzobfQ/KmVRmQ1LCjWmcLfNb
 wcIi2ZCs0/k2qksMAWzYdLhzFuwtD0fUFbhFqCtB1+Fo9qA3xsLb+4l4badpVYu+Esh7
 oZFfBs8VBqQN5GNLOFnYMU3gIlmj1TKeeXlkNE+jVs3cJyejAU7RrdGv6A1mTIXstgxz
 P/aA==
X-Gm-Message-State: AOJu0Yzd6ycy9HQKVYWR2WmgnCnUpGdmr+YLjTBOoEVQ0eBaw1PtW6Uk
 qbLaKWNR/Vz0S1qADxIhKq/jIRgwxynFP84DFF/nzIX7Li4nj+WfdRViG7dJcT0iMIdqNG79RiP
 nIwtp4OL5xaXroQrbbhWTbJdxwVVnhXazw4IJXcS7dCLdAQGyQFJGWSj/W0es
X-Received: by 2002:a5d:4288:0:b0:33b:401f:bd53 with SMTP id
 k8-20020a5d4288000000b0033b401fbd53mr1465215wrq.45.1707232213933; 
 Tue, 06 Feb 2024 07:10:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF+LDbhHwJBSHXBqCo5/xt1PkK+sHa3j1Ij0vdFWZf0RnKTOLHRVbqENDLzT6vAa0pUQsSiAw==
X-Received: by 2002:a5d:4288:0:b0:33b:401f:bd53 with SMTP id
 k8-20020a5d4288000000b0033b401fbd53mr1465203wrq.45.1707232213758; 
 Tue, 06 Feb 2024 07:10:13 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCVeUW7fyLnBylsdGCKCyRPgKEaC/gElT0/1QgMy8JwbgqE6I2lWvgjzJ4CqZuwzfdUIp8ytiEjjUAQwXttbZ5CsIaClbgTQrLkXaXqzt7TDZ8mGhnmQhJ1GvAa4mx0LaXEVJF5fpzYkgXY0FM/TJ/8trwRjnIXf9bIgHv9jVjkFf2F7Qot+Ed8lHTiikr46ss23fthKmw==
Received: from ?IPV6:2003:cf:d740:65ef:7c9f:a118:b826:ff5f?
 (p200300cfd74065ef7c9fa118b826ff5f.dip0.t-ipconnect.de.
 [2003:cf:d740:65ef:7c9f:a118:b826:ff5f])
 by smtp.gmail.com with ESMTPSA id
 cp10-20020a056000400a00b0033b4a2f13e6sm969398wrb.72.2024.02.06.07.10.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 07:10:13 -0800 (PST)
Message-ID: <86852f4f-eea4-4b4b-a1fa-775da0f5d5e1@redhat.com>
Date: Tue, 6 Feb 2024 16:10:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] virtio-blk: declare VirtIOBlock::rq with a type
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20240205172659.476970-1-stefanha@redhat.com>
 <20240205172659.476970-5-stefanha@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20240205172659.476970-5-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 05.02.24 18:26, Stefan Hajnoczi wrote:
> The VirtIOBlock::rq field has had the type void * since its introduction
> in commit 869a5c6df19a ("Stop VM on error in virtio-blk. (Gleb
> Natapov)").
>
> Perhaps this was done to avoid the forward declaration of
> VirtIOBlockReq.
>
> Hanna Czenczek <hreitz@redhat.com> pointed out the missing type. Specify
> the actual type because there is no need to use void * here.
>
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   include/hw/virtio/virtio-blk.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


