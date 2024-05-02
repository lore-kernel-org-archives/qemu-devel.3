Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F7FC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ccx-000750-9V; Thu, 02 May 2024 16:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2cct-00074V-L5
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:01:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2ccs-0007ZH-1P
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714680112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iq86I6Zpgq5z02RQk0gVk5ibp9DveB4uEcp8h44tmyo=;
 b=emYegWuzmagdn5WInu28PL+i1z9HQxd2pWnsfcgoeWHab5VSYAPqwEpsmvRxGcizBSe7kt
 mXIYEYHl6lyAXLaJOC20MyTJ2QSZfnUYNLOZJ8648VuEErDaKrgj2E+e/4A+nVVrP1SpBn
 0x5yoGVIj4VhH4H0Nd/Vio0tWwTEHhU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-jccEm2vHOYmRU_UZE80JNQ-1; Thu, 02 May 2024 16:01:51 -0400
X-MC-Unique: jccEm2vHOYmRU_UZE80JNQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4379bbdc9b4so30532641cf.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714680111; x=1715284911;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iq86I6Zpgq5z02RQk0gVk5ibp9DveB4uEcp8h44tmyo=;
 b=tVul7KtFb8z8ngmJcBocsXbdj6WSthNetE1Tu3FhSS8uTPT6+hqv1o3lk9kwLGHr9w
 7UAYuT+LITEkNg0Th4bPDlvCAdcnvU+vQFaFOHnFWtvCv7v8XDR9HODsjUgErYSRRwoo
 yWikj3arfCpPKKvs9xDmXPKd7U0tk3Qz/2TaXSw3kQiBnA2b4PwYg5d+1k58DvuP7yn1
 KmVhiL8ced8ye00IGU1vtp1P6ITshflxTnTkhT0ISZd6UGwVNzyb/ROK8mnspncQ271W
 h4XBhPQlHW5oG4yDjihLiHH6C0V9eGWTGUj20kYIqrx6AuLdYj5Wihd5P63BMUMwMjeK
 zqMQ==
X-Gm-Message-State: AOJu0YzXfNPXMGpS0BsjLS5YxMUsXJOwjXW1nTdbNw4a63DIsbiKgs1B
 kvsUBxu8iZV2cPelCDl0ewPmLbHn7x12sXqQiHIT94sMhrWupPwCmTxiFrC0PzNIh+/ShuFbvvq
 /kyTDSNoOVSDwY2ntjV8UqH7xLlBEBZ6RauIqej8vfFQ+VrnpikPP
X-Received: by 2002:ad4:5765:0:b0:6a0:cd65:599a with SMTP id
 r5-20020ad45765000000b006a0cd65599amr700490qvx.2.1714680110500; 
 Thu, 02 May 2024 13:01:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5eM2VaP9vW3zsANzt6yQkGfX2wGmcnlUWMN9UzvvfvMhZk+n2NwOZO68+4r11g7b7oM+nQg==
X-Received: by 2002:ad4:5765:0:b0:6a0:cd65:599a with SMTP id
 r5-20020ad45765000000b006a0cd65599amr700449qvx.2.1714680109882; 
 Thu, 02 May 2024 13:01:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 b17-20020ad45191000000b006a0d7565fbdsm602372qvp.87.2024.05.02.13.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 13:01:49 -0700 (PDT)
Date: Thu, 2 May 2024 16:01:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 0/9] migration/mapped-ram: Add direct-io support
Message-ID: <ZjPxLLwtJL3ATUML@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

On Fri, Apr 26, 2024 at 11:20:33AM -0300, Fabiano Rosas wrote:
> If the user is not passing in a file name which QEMU can open at will,
> we must then require that the user pass the two file descriptors with
> the flags already properly set. We'll use the already existing fdset +
> QMP add-fd infrastructure for this.

Yes I remember such requirement that one extra fd is needed for direct-io,
however today when I looked closer at the man page it looks like F_SETFL
works with O_DIRECT too?

       F_SETFL (int)
              Set the file status flags to the value specified by arg.
              File access mode (O_RDONLY, O_WRONLY, O_RDWR) and file
              creation flags (i.e., O_CREAT, O_EXCL, O_NOCTTY, O_TRUNC) in
              arg are ignored.  On Linux, this command can change only the
              O_APPEND, O_ASYNC, O_DIRECT, O_NOATIME, and O_NONBLOCK flags.
              It is not possible to change the O_DSYNC and O_SYNC flags;
              see BUGS, below.

====8<====
$ cat fcntl.c
#define _GNU_SOURCE
#include <stdio.h>
#include <fcntl.h>
#include <assert.h>
#include <unistd.h>

int main(void)
{
    int fd, newfd, ret, flags;

    fd = open("test.txt", O_RDWR | O_CREAT, 0660);
    assert(fd != -1);

    flags = fcntl(fd, F_GETFL);
    printf("old fd flags: 0x%x\n", flags);

    newfd = dup(fd);
    assert(newfd != -1);

    flags = fcntl(newfd, F_GETFL);
    printf("new fd flags: 0x%x\n", flags);

    flags |= O_DIRECT;
    ret = fcntl(newfd, F_SETFL, flags);

    flags = fcntl(fd, F_GETFL);
    printf("updated new flags: 0x%x\n", flags);
    
    return 0;
}
$ make fcntl
cc     fcntl.c   -o fcntl
$ ./fcntl 
old fd flags: 0x8002
new fd flags: 0x8002
updated new flags: 0xc002
====8<====

Perhaps I missed something important?

-- 
Peter Xu


