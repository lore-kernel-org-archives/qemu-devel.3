Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422C8C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 07:02:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh2Kd-0006mp-02; Mon, 04 Mar 2024 02:01:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2KX-0006mX-LA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:01:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rh2KW-0004gY-Bi
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 02:01:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709535703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mtiZU1AtijGtjW2vJas1UhhaqPj5BF3e7xkqFJbTNz0=;
 b=FuvNqex26VTSVtMfxzrr8pmJDRGiG1vczjqbTDcfGVsFfee0VbURY4N+BVXl0xbxMRWJIV
 p2s7Nsr0BriIEq8gQbPYGznGfw5/bdj0Vby29u5lyRudrpSabyBlY8bK1lWPX7Sty7VneD
 xoUxdQvIg5dPesvMupFrW+UExOUxmOk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-KZfkkRrNMG6i5x7Jvw1wCQ-1; Mon, 04 Mar 2024 02:01:40 -0500
X-MC-Unique: KZfkkRrNMG6i5x7Jvw1wCQ-1
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3654e457a72so11650165ab.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 23:01:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709535699; x=1710140499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mtiZU1AtijGtjW2vJas1UhhaqPj5BF3e7xkqFJbTNz0=;
 b=LeQEh/gYFV8Z2Jl3jlaj/Sz8Btlm/Daj18rLT7s3zKSwaemyMM9DTKhKIO5arVNBDz
 u8MFydw9kNKpdHKB/PB7TUkcPBbytDrihXeLoa2cgk5pFyc23kQLsa8zmdFgWb+ngRo3
 mqBpT7F08HdY4EO+QIvUIRGemjvbU8RECdtT9r8mKPT0b2h6BeONFNbPtbPSGe/nqZQV
 AyvDu6iUZXgiJxf7qORFogkwQ/0k/MgMBM/PhABQp2aPujQHP+aiL3YHJ70MdqT5lJzJ
 EDt7YnRLgxvTio7zYmjQVU/HjohAaUiJyCZ4X8bkPqO4fJHi+iR1TBy/6UvUnItQpIIV
 /n2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmu24Fw/xbs4EFhBiQO5bVk+JFlk3JSSU7V0XEXxGhMY27GEb3XMLHwMG0+sw5dUPP1AyrnAN3TWm28RzYe/raOOXwHek=
X-Gm-Message-State: AOJu0Yy254Ed4rGdRMfg3KuUNihbVRvI5VJz6P5J8w8KbBypYbW8ykT+
 rLehB6+phapcTgFTZC7F+879F4s4kS12J7Czjb0cHvc59d9zx0/LkkriOmwFXIy2hEeph2xicmV
 m9HoSbkzIpyOegL/shijdPl6ndp2bfM0lwyBbfjTI9ru+CN/qyETv
X-Received: by 2002:a6b:c805:0:b0:7c8:3715:4d64 with SMTP id
 y5-20020a6bc805000000b007c837154d64mr3474814iof.1.1709535699760; 
 Sun, 03 Mar 2024 23:01:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEomXZDXBr3SJOQZjHUKZoBuZ1pvrCRJ4qb/TzYdfJKrPUM2oebvFhfksiFWpXprr5URWggdw==
X-Received: by 2002:a6b:c805:0:b0:7c8:3715:4d64 with SMTP id
 y5-20020a6bc805000000b007c837154d64mr3474799iof.1.1709535699509; 
 Sun, 03 Mar 2024 23:01:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b22-20020a63cf56000000b005dc884e9f5bsm6896612pgj.38.2024.03.03.23.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 23:01:39 -0800 (PST)
Date: Mon, 4 Mar 2024 15:01:28 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 1/7] migration/multifd: Add new migration option
 zero-page-detection.
Message-ID: <ZeVxyNKLoHqoodYM@x1n>
References: <20240301022829.3390548-1-hao.xiang@bytedance.com>
 <20240301022829.3390548-2-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240301022829.3390548-2-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Mar 01, 2024 at 02:28:23AM +0000, Hao Xiang wrote:
> This new parameter controls where the zero page checking is running.
> 1. If this parameter is set to 'legacy', zero page checking is
> done in the migration main thread.
> 2. If this parameter is set to 'none', zero page checking is disabled.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


