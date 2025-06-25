Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB69BC7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 13:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUQLt-0003eg-TJ; Wed, 25 Jun 2025 09:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQLs-0003bF-Nf
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uUQLp-0000aZ-Qu
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 09:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750858784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1yN9f6UdEw46dyjo2Z925ByTPXsKffJ4FAZFOK5snj4=;
 b=IQYjne5zw+966iW6i+YgLnWck5xydj5LeuqwYJ6bum3+S2P3dMeFj3K14DtfH8yenjs9Z6
 TMrzNzzA4e9XCpGy0NlDbSYQvGDFzPCpkHPmYAIUkUgM3PSUTTe40luuMHCzLUO2M6/wS6
 MRX0HFrN4qZqXg6zMLvGYy7afMLnRE0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-Oja1gwTzPuukQTQwammedQ-1; Wed, 25 Jun 2025 09:39:43 -0400
X-MC-Unique: Oja1gwTzPuukQTQwammedQ-1
X-Mimecast-MFC-AGG-ID: Oja1gwTzPuukQTQwammedQ_1750858782
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2356ce55d33so26364295ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 06:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750858781; x=1751463581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1yN9f6UdEw46dyjo2Z925ByTPXsKffJ4FAZFOK5snj4=;
 b=mvRA071iId+rUN8UOrbP0cCcQYjoqN+agxhfxkpS+OK5TR2M2DNus5e8ByhySASTIl
 P7qMzbRNZQu+Omhcj9qp0zWBHfvINMMamNtlrZai9X+uOl18r0rbRKOkztrTb1lWdftZ
 pSU7/t12ICdyEUTFhvD5+whI19PWtkf/Vwt59ghblgbg9PSfL3T6sCMaH9pYP/k6DxkS
 5rMIiUHx8BXfeXxZLU/vn9pRzLsiORW76zTdQP3eOEDaqfqjzPsrgKGa+U8Q5UCCx4Hr
 5pcI5osSkBO5Lqons4HjgltsJRoofaTSMFv4VauVdeOSGVcYbpE1fCd0ChJ3sjxuflkN
 dMnA==
X-Gm-Message-State: AOJu0Yy0PxvAjX+5tzy7LTDoxmZ9dLZmhdH6mdGe3L60LZpJOry//Dhn
 21NQG8xID3K4nh2tsu5crIP7NWzQThW/pR+PkADHsuukzZIbOK1CjophxW7uBnPlMcOwDHLXtoH
 UkDxhP8PnRgJBNg3Fx5AIFNewXD+07phnfHX3JuhvqeWALgkxK4ku+az2xoFmD3+UopPZ3aE9XL
 XdLpk8L+BpfkOaT0JeeQFpH5FRPK2AlE+6eInv9Q==
X-Gm-Gg: ASbGncuTYKZdlvdwJMRPL0NVXMMM9l7Y7fyZ8YAJf/2FRDLrYeY6VilwCjfaz9dScBC
 hbEWac5rHvyEfH6bXH3Jqa/2iOpEt1sZTdDOrzDJHq79WVhJt67/SjspqogicmnMUfxUt5zv5PR
 YabkJq9hfCRLVNCegaEty89EIi6HlcS+9+9q74ewBvxzXQobxDFBAWgTjYAVQvhqBUkeMOB1S0G
 mxZMqEtgAC8Ex0qcHQPcCdG347QeiePT1aYjz8ZZNeERbUd9jLWYC8Tf9J4ld75uMct71epqM9k
 AWDyFOLMNSlLOQ==
X-Received: by 2002:a17:902:cec6:b0:234:f1ac:c036 with SMTP id
 d9443c01a7336-23824087cccmr57185775ad.50.1750858781643; 
 Wed, 25 Jun 2025 06:39:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO0Z/zPOLHMm5egVupo+M0OBhzZM7e5d/Rw1czbSnrbcyKRRI4YUHbnHmJUiWnfvvbfatfXA==
X-Received: by 2002:a17:902:cec6:b0:234:f1ac:c036 with SMTP id
 d9443c01a7336-23824087cccmr57185325ad.50.1750858781164; 
 Wed, 25 Jun 2025 06:39:41 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d860b496sm131827585ad.91.2025.06.25.06.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 06:39:40 -0700 (PDT)
Date: Wed, 25 Jun 2025 09:39:36 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mario Casquero <mcasquer@redhat.com>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 00/14] migration/postcopy: Blocktime tracking overhaul
Message-ID: <aFv8GMpS5QkQxiTD@x1.local>
References: <20250613141217.474825-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250613141217.474825-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jun 13, 2025 at 10:12:03AM -0400, Peter Xu wrote:
> This series is based on the other series I posted here:

queued.

-- 
Peter Xu


