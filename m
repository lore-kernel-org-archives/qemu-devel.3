Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D860C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 09:47:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trZib-00022v-D9; Mon, 10 Mar 2025 05:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trZiW-00021K-C4
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1trZiU-0002B5-P6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 05:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741599993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9bKY9gbISl1zTFslzwTe/WQxafVqO4xFL75DKPnRyIg=;
 b=i8UlLmNqLLrxKj02U/YchHqi7Up4zUW9kWk/UK+4ESx0ptSstpsPOf9Cz0h/jmP6M1xoSY
 6zLbZqUNqecND4XTumFuDLDS84g9rTvuOcW+aFadWZX9x6W1e/D3HP9kBN2SxdGGMNiP8z
 VUjrA6aiqy2CAP1gOoyN3W9Ci6HNYyg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-NzQ0TdpCPQ6ncRflpCuZ9g-1; Mon, 10 Mar 2025 05:46:31 -0400
X-MC-Unique: NzQ0TdpCPQ6ncRflpCuZ9g-1
X-Mimecast-MFC-AGG-ID: NzQ0TdpCPQ6ncRflpCuZ9g_1741599988
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ac2aa3513ccso38077866b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 02:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741599988; x=1742204788;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9bKY9gbISl1zTFslzwTe/WQxafVqO4xFL75DKPnRyIg=;
 b=uuALu3v2OQVLPkZiH6AULTzOYTic4m9E/a6y6SKXje4Bdoebbagcxm5I+1LUVmpV//
 hYMNNxDGuw/Nwnvf0fCY0YPzEDzCFWjj+FjKx53EECaHtB4fGEOmXDlJu8AsGbcrQas2
 KMDUk7rHKHu7WHU13eZeTM1WZX9VP4iC+BH9jq6dQAwKkz7r6QTF6fq7oXTNcZ09LhKf
 GJiwcQ339NAXqfGgk3cW7bkqqDPqoNi2+tjI3y08/O1j4skaolkl4zE4EpJ8t+Z2u0aS
 ND2TmsN/9H4QsvO8g9y3njeGKgcMRvsXOjAaZlfFF8Io0EHkgyZ1zry4Fo4FFoUmDgdQ
 Zw5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5+EzMlV2v1PPwXok7xwzYTROS1kaSZakefPjjGoPJWxIzI50dh9IyWcWSOzNRbvRiTHHPvfR25u6A@nongnu.org
X-Gm-Message-State: AOJu0Yw+OQldy18pnylf0fFwvcEPwWRt/omw5XirkuFLupnyAeuHHYOX
 OGFLcP201LC0up5qacOw7dwcSejHQTGNqsFMKQ+8YwN5hOgWacO7ZK36yTu7yopN5CwEczA9jEI
 k1NHKcCJZz6PHbXGmGG5ty3acGQ4HX8dNc2a2hkIiGeblXcKvZdDO
X-Gm-Gg: ASbGnctavw7/UwrvGKKbVgjjpFnwwvZdCobm/Cp/5ZYCENVK8PyhfzuVYO+AWqFTfx3
 YDPVb5b27/v72Ks6SUy96Xj0hofU+dXWwFLIAz1iBlboRcwdWYteZxvDoBwSNqFOzCPvkY99YoU
 5FTRE9s3yTGW2a9AGzXZmTqrzFVOsY0KWErz4O8Htulr+6VObG1ffHOsUY+SaeeHEms9sVsfpp/
 0JgfYpIOAv0x3yuOdY7ilgLJ+L5wWnP7XVbfBKSOJHpNhMEXlLXXYc/VmDOhTx6ckQkvRIWBCp/
 NjUd/l3atNu5WtMki3RoZxSTBBXFOXDY/gzpgBDJqNPdQuM=
X-Received: by 2002:a17:906:b385:b0:ac1:daba:c6c with SMTP id
 a640c23a62f3a-ac2526df221mr1241868066b.24.1741599988284; 
 Mon, 10 Mar 2025 02:46:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVFnRATvoUCEWL1bgnhbXKYhSFEWhRKdNg458gLt/caOe8TAjQs0Rw4oaFejHdPn21cxTXTQ==
X-Received: by 2002:a17:906:b385:b0:ac1:daba:c6c with SMTP id
 a640c23a62f3a-ac2526df221mr1241865366b.24.1741599987929; 
 Mon, 10 Mar 2025 02:46:27 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac297b723ecsm212753766b.77.2025.03.10.02.46.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 02:46:27 -0700 (PDT)
Message-ID: <73697685-e70b-4308-8384-e0b55ecfcb72@redhat.com>
Date: Mon, 10 Mar 2025 10:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iotests: Limit qsd-migrate to working formats
From: Thomas Huth <thuth@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
References: <20250224214058.205889-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224214058.205889-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/02/2025 22.40, Thomas Huth wrote:
> qsd-migrate is currently only working for raw, qcow2 and qed.
> Other formats are failing, e.g. because they don't support migration.
> Thus let's limit this test to the three usable formats now.
> 
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qemu-iotests/tests/qsd-migrate | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
> index de17562cb06..a4c6592420c 100755
> --- a/tests/qemu-iotests/tests/qsd-migrate
> +++ b/tests/qemu-iotests/tests/qsd-migrate
> @@ -22,7 +22,7 @@ import iotests
>   
>   from iotests import filter_qemu_io, filter_qtest
>   
> -iotests.script_initialize(supported_fmts=['generic'],
> +iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
>                             supported_protocols=['file'],
>                             supported_platforms=['linux'])
>   

Ping? (for soft-freeze?)

  Thomas


