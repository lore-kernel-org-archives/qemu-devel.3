Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF6C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJw0-0001yQ-Cl; Tue, 20 Feb 2024 01:48:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJvz-0001yB-BF
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJvy-0004ap-2x
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708411732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=icz0i9sKCklOW5t+PMgS4m8sJRFR4hM075lFeg1j2b0=;
 b=IxuD5w7JCflVWZsLldMZrPLF7RjXmiUtl3YltrNPCl/vD0zVNUA32lFoSJshsSD+RNCkHw
 yb1PbE8LKQsU35PEsdQmq53Bb7lXHea9xu+YogwywI5ulT26UDNizrK7dk3yj8fZxJit3c
 MKaFQdAC3M0SJFkcfW/2tCY+cxJXrZQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-IHWZe883OZKPWSb7zMJYbA-1; Tue, 20 Feb 2024 01:48:50 -0500
X-MC-Unique: IHWZe883OZKPWSb7zMJYbA-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e482286cf7so4761b3a.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708411730; x=1709016530;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=icz0i9sKCklOW5t+PMgS4m8sJRFR4hM075lFeg1j2b0=;
 b=XKp13vHyTn3F3kG3ealcQSJHEer6+rPo9m1/kFK5CHzTu+9B5XSOdd/qqOK/OEL8dI
 9wZddKR0Mzusdla61A/8xSvx0xPirpYiC6AsfHun+80QKymnWyJZK2S9JoVZkQFnQMHY
 8I9cDVYNey9kMosyW0GCU5tu6AcCOQcMc+t9acQBG0zE1vJK5X87eRACuRWyuUebl0vu
 Ysz3415BTCH4j1yDF1GDyVUCwykHCSK6fSpRGmIiIEzPGyzgVtXmEYhxMC9sRYTOadEQ
 pzRhF0Gxzh5TzYP0zSrYnLNP+gG2PXhRzgQE6yHKRwsTFdkzkQ3p5vPJaXPOx2lUt/n9
 y0XQ==
X-Gm-Message-State: AOJu0YzC7XOsfYcqNDU52sDDvrsGqnZU99RACkrsYl5CDoZtFqHjSnWY
 t/Zxp0xUDjth1ZHT2zUj9Z9r/SazqdF8sJWOIdr8yXWiu0G3Hlt/3g1VI5j2GQaNrere/+CcAtc
 IYrfmLLtNSfbbI5qwGDqAtWZJJGsr0QSPkh0c8bj6fEL5tCDayM4D
X-Received: by 2002:a05:6a00:189c:b0:6e4:7148:508d with SMTP id
 x28-20020a056a00189c00b006e47148508dmr3081095pfh.3.1708411729888; 
 Mon, 19 Feb 2024 22:48:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlguyxonrf2CLF7IkET0XiDlinm13YFJTopxsfwuiRf7+w2gyeitU6T+hXIIm7QTYOL80VoQ==
X-Received: by 2002:a05:6a00:189c:b0:6e4:7148:508d with SMTP id
 x28-20020a056a00189c00b006e47148508dmr3081082pfh.3.1708411729613; 
 Mon, 19 Feb 2024 22:48:49 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 v13-20020aa7808d000000b006e46df9f1b1sm2263352pff.9.2024.02.19.22.48.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:48:49 -0800 (PST)
Date: Tue, 20 Feb 2024 14:48:39 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 06/13] migration: MigrationNotifyFunc
Message-ID: <ZdRLR02vtUL6X-cp@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-7-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-7-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On Thu, Feb 08, 2024 at 10:53:59AM -0800, Steve Sistare wrote:
> Define MigrationNotifyFunc to improve type safety and simplify migration
> notifiers.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


