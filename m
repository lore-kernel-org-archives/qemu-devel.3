Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B064C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:13:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYR0-0008HY-RT; Thu, 18 Jul 2024 17:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUYQy-00087j-FT
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sUYQv-00086l-3d
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721337177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yEC48ODV+CZltHsyClzCtBrc28fn3t34ae1RFstPWBc=;
 b=c8OEx0sRhJIcXs+rY1SYdeqka9w5V9W3d/vOm5iz9UyaMmSUDROyDtoOJRGle0zP1hFgll
 g1FR3jR4Jw1hfsVrI9vozpu0xKd7iVmVN5huCviNqLHmxMLZEeXLDlD0QRgX03fKTLcz13
 YE+tyGXmaJyDnghE8D6XZhHGZLsQCEM=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-TpveYFI2Oj2R2GL5dkPfEQ-1; Thu, 18 Jul 2024 17:12:54 -0400
X-MC-Unique: TpveYFI2Oj2R2GL5dkPfEQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-25e6630f94fso309369fac.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 14:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721337173; x=1721941973;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yEC48ODV+CZltHsyClzCtBrc28fn3t34ae1RFstPWBc=;
 b=KQVPSWZDTXkNb+8KCF0bruXrtSm88pK15hwGDt7GhxGTyPJy5AhjgQukm5cfM1YQO3
 sN4A+3WsIZcHrQsb6DdKkxbUODA+PDMGaMNmXWQi6M88zk3bana6Ny9BlF/gdaEQ0zOD
 nV9BTTWwriNpZrgky1Ab66wQEaWSP1I5rPZu3zPZh2xONfgVUF4YDEz4K5GMaL/wQqVF
 R2FijdYuNcQo1X4EV0l9tVnqxzvrxpc6ti3UjHxRskRzxDpb1Cpv5Gtigjty68E2RHJp
 R0V5m4ZvSTAT9nIRMaEH4YFH9kujI1glDnSoPHkVz3uU6/LgZgD4lVHatafMoZW/PeBq
 6ZfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzDgt7QAMKlsTHPKEA/FEPYqZlAP1PhpGzaoPN5/5vRt4M1CwRmCF5N8nd8M5sQXgWMFCPLpxwKAho+fbQULSJ3aTbOAw=
X-Gm-Message-State: AOJu0Yx361vdEU8yWTw41tFDYR3Sc1IQXraBzYF2d4vigFEteEsDzECH
 IlAtuclH1Cv4gp2T2L6BdMPscNh9eTW+cMqq14BiRelq5AWks16U07pjElryffXyPURS7m+xyeH
 R2AE89H52atnEFe7/pImCm+u5WwnMHr82ePnyoJEnttwBcGnRVkpK
X-Received: by 2002:a05:6358:281f:b0:1ac:a26c:a07b with SMTP id
 e5c5f4694b2df-1acb9eb4e63mr32968155d.5.1721337173168; 
 Thu, 18 Jul 2024 14:12:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKGNR7ghUDYBVDkIJEq+x4HssnLmLzsBQL7STyKFp6UhXyRF/XItOLDBuSIVXKlQz+MCrWwA==
X-Received: by 2002:a05:6358:281f:b0:1ac:a26c:a07b with SMTP id
 e5c5f4694b2df-1acb9eb4e63mr32966855d.5.1721337172771; 
 Thu, 18 Jul 2024 14:12:52 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7ac7f15c6sm70926d6.68.2024.07.18.14.12.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 14:12:52 -0700 (PDT)
Date: Thu, 18 Jul 2024 17:12:47 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: "Wang, Lei" <lei4.wang@intel.com>, qemu-devel@nongnu.org,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [RFC PATCH 6/7] migration/multifd: Move payload storage out of
 the channel parameters
Message-ID: <ZpmFT9O-UN30i1F1@x1n>
References: <20240620212111.29319-7-farosas@suse.de>
 <e60bc0c7-dc49-400e-88f1-a30c32943f25@intel.com>
 <Zn15y693g0AkDbYD@x1n> <877cdtfcsi.fsf@suse.de>
 <Zo7cncqkxB89AUBe@x1n> <87y169dmu3.fsf@suse.de>
 <Zo8DaHbWlrNe3RXL@x1n> <87msmodnly.fsf@suse.de>
 <ZpAEIvbNr-ANuASV@x1n> <87jzhi1odn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzhi1odn.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 18, 2024 at 04:39:00PM -0300, Fabiano Rosas wrote:
> v2 is ready, but unfortunately this approach doesn't work. When client A
> takes the payload, it fills it with it's data, which may include
> allocating memory. MultiFDPages_t does that for the offset. This means
> we need a round of free/malloc at every packet sent. For every client
> and every allocation they decide to do.

Shouldn't be a blocker?  E.g. one option is:

    /* Allocate both the pages + offset[] */
    MultiFDPages_t *pages = g_malloc0(sizeof(MultiFDPages_t) +
                                      sizeof(ram_addr_t) * n, 1);
    pages->allocated = n;
    pages->offset = &pages[1];

Or.. we can also make offset[] dynamic size, if that looks less tricky:

typedef struct {
    /* number of used pages */
    uint32_t num;
    /* number of normal pages */
    uint32_t normal_num;
    /* number of allocated pages */
    uint32_t allocated;
    RAMBlock *block;
    /* offset of each page */
    ram_addr_t offset[0];
} MultiFDPages_t;

-- 
Peter Xu


