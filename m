Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADACFC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 07:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXFkj-0001EB-G6; Tue, 06 Feb 2024 02:20:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFkf-0001D4-If
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rXFkd-0006Lv-Av
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 02:20:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707204014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Oyrj+BFGLGn6ojlb2HCZAP2AnKbF7HLlHuZFFxnsje4=;
 b=igDWrExiqc31dlFgVZkbA3oWTw43yg2FINmXTfVuVn67eWtYNeCWxybL8YrQXXf+h6aoSr
 RYtNWxQCId7JMptIQcPz9vYAIdyfQlj+iE5WYFTJfh1WxdR8aVPEJJ3SF0/is7NttltWdM
 y3JQ35zpZo5FiBNWCbhxnsBB0S11oms=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-Fn0td5XmNNO3hPfH7EJZZw-1; Tue, 06 Feb 2024 02:20:12 -0500
X-MC-Unique: Fn0td5XmNNO3hPfH7EJZZw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40f00a86728so28837065e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Feb 2024 23:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707204011; x=1707808811;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :references:cc:to:content-language:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oyrj+BFGLGn6ojlb2HCZAP2AnKbF7HLlHuZFFxnsje4=;
 b=P4GBP9tEwpfJm5zHxMWrvZ5kYvuPupBWz0f41koG3Phrzf+jc8LzwG72HIdhg+Ss7z
 gZ3UxiF/R8w/dskvtokpxP08INeXCAVwL15wD3bZ+Mrg10vlTyGNTiSqkvfMlbukV1N5
 7XS2xk4zuh0AucPExsDjXWL5bwi+Eq9cWpBSabnt8Ki62yWki0C3ZvR/CmKiN2t1uc2Y
 1jDmY2J07OxB39VBCaNQK++/fpEV6P8Ii5AoxjTY4yA/opQYoupSGkz3KKXvREGETTJm
 q/AHGTLXCbKbRuDZ4kAnfXgmQzBJwA9ZQ4R/O+PkgktukERBic6F7sl8dETAbmjqgwab
 vQZw==
X-Gm-Message-State: AOJu0YyI7PUOhewzWmgSiSHgyuqhILZ7tkvyOpYC8mUd1wiTBfZYB3mq
 O9zUGV7gI6XMec8o1ZWLltSjKPLOdUmcwiNXCS8M+DsWC1fj2TYKw8pcrWdGpK8Z+7jJcIgLVGV
 /89kil3AHF22EOr5MUiK0I95TjjHvLzvAPQkv6soTwUDOTfdKscpUPU6W0Gxl0OB/tuR0KxXVz4
 1g0MKXDAN5C+f9bFRT/2xk5OW0W2kZlNRhoXU=
X-Received: by 2002:a05:600c:154a:b0:40e:fbb3:f67c with SMTP id
 f10-20020a05600c154a00b0040efbb3f67cmr1486809wmg.38.1707204011079; 
 Mon, 05 Feb 2024 23:20:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG+jP2z25/tCa4qiv7ldGLenWpeB7kt+ZEZg7vmb2neR6mnQj7E2wfA3JKG0o57jRDO/U03w==
X-Received: by 2002:a05:600c:154a:b0:40e:fbb3:f67c with SMTP id
 f10-20020a05600c154a00b0040efbb3f67cmr1486791wmg.38.1707204010702; 
 Mon, 05 Feb 2024 23:20:10 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXxs0Bz3piQF3iBRYq0HdlYKLjYQq+GLF6jXdRAq0ZGVYQ24HIv4OUhpttOBpWc3j5/PYSvIOm3y9PIzxgXJDXn/l2O
Received: from [192.168.20.184] (ftip006315900.acc1.colindale.21cn-nte.bt.net.
 [81.134.214.249]) by smtp.gmail.com with ESMTPSA id
 l4-20020a05600c1d0400b0040fdd18f6fasm986585wms.39.2024.02.05.23.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 23:20:10 -0800 (PST)
Message-ID: <248cd804-ec3e-46e1-9270-86c82f85b485@redhat.com>
Date: Tue, 6 Feb 2024 08:20:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/3] Host Memory Backends and Memory devices queue
 2024-02-06
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240206071422.18658-1-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240206071422.18658-1-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 06.02.24 08:14, David Hildenbrand wrote:
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
> 
>    Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
> 
> are available in the Git repository at:
> 
>    https://github.com/davidhildenbrand/qemu.git tags/mem-2024-02-06-v2
> 
> for you to fetch changes up to 8eb38ab662e74d618d473a9a52d71c644926c3c0:
> 
>    oslib-posix: initialize backend memory objects in parallel (2024-02-06 08:09:55 +0100)
> 
> ----------------------------------------------------------------
> Hi,
> 
> "Host Memory Backends" and "Memory devices" queue ("mem"):
> - Reintroduce memory region size checks for memory devices; the removal
>    lead to some undesired side effects
> - Preallocate memory of memory backends in selected configurations
>    asynchronously (so we preallocate concurrently), to speed up QEMU
>    startup time.

... and yet another instance of the same mail address is wrong. Gah.

Maybe v3 will do ...

-- 
Cheers,

David / dhildenb


