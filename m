Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FA22CCD1A0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 13:18:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1squZL-0002Ks-TZ; Wed, 18 Sep 2024 09:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1squZJ-0002Hn-Jy
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:18:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1squZH-0005TA-5c
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 09:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726665481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1JQdaxmY6mADCmhsMSNJTUNrtnjVSE901GvZbZj2qw0=;
 b=htEsQCs1uYlsbUCvgqvX/yKhd7QtbVl+XG2xS1qmLze+pFqLlhSoOR4KV3WqEuR5Xnelt0
 qFPCtyt35M2+hrLnzXxoenLmXMaFKJljCGbg5BIymn0WIZ8mVmUhqBx7TFop2qo8QAlQRM
 USoV5BGIzCNSebm3qpCz+vurtftPWLY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-Apnmtx_BNLWEACQ4PS-Anw-1; Wed, 18 Sep 2024 09:17:59 -0400
X-MC-Unique: Apnmtx_BNLWEACQ4PS-Anw-1
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2058456b864so119822405ad.3
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 06:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726665478; x=1727270278;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JQdaxmY6mADCmhsMSNJTUNrtnjVSE901GvZbZj2qw0=;
 b=DGKE0NDL0UMosneRlgP1kHYtICkGY7SZfpxdEsywTXhZDSGyt/0myISeebCYgeiD8F
 zWkd/t5rEP/rsL1if8sf3+ZnNPF3BZN1Nf48xdRqHl1KNvKHPHVsjs06Pen3T5UlcYy7
 /c92as01VPCRXRLKk7esagPDy0u1brL0VHYbkkM+OPTYr0du3JyB1iyQ4Y4Owta2bKIj
 8iE3xlRMPkBYyPVXOSP7ONxH0QUh3hDGUoxaeMqWguf56lbMO5KqikcVtefx6prH6deq
 sgNoN9VtEhUi4TZtDgQO9P5hBnfdPK+c5J4DXeLa4GaySQrKFUAdO4iGu4PkKQBKuprw
 wNew==
X-Gm-Message-State: AOJu0Yz755knEJAlJ7pcU3fw9F5DIinE0c/lyOTB7r2LHH6LsQTNMS7H
 ePFqtIJlKWUIzQ3/+0MZ8D23xq9ylIinmQUdbu9+vJOXp8PoTq/t8M+1e8MDRjdWS6/AFEuZjP2
 uXtyOLXLws02QGQRIIYr1jlvVGQneRO7Rq9hBFRq0NCmUTrvmEwWU
X-Received: by 2002:a17:902:e5c4:b0:207:4cae:9724 with SMTP id
 d9443c01a7336-2076e3447e7mr344548505ad.18.1726665478689; 
 Wed, 18 Sep 2024 06:17:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIeDcpU4TgvEcc5ihsBtW+sAH+nysEdMUVjLCpDz9RNC25LeXtB7t0vC+rTJEZk22K2pQYUw==
X-Received: by 2002:a17:902:e5c4:b0:207:4cae:9724 with SMTP id
 d9443c01a7336-2076e3447e7mr344548215ad.18.1726665478308; 
 Wed, 18 Sep 2024 06:17:58 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-207945dcbdfsm65248385ad.32.2024.09.18.06.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:17:57 -0700 (PDT)
Date: Wed, 18 Sep 2024 09:17:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 3/6] migration/multifd: Fix loop conditions in
 multifd_zstd_send_prepare and multifd_zstd_recv
Message-ID: <ZurS_kvl2p5DlDqb@x1n>
References: <20240917215506.472181-1-peterx@redhat.com>
 <20240917215506.472181-4-peterx@redhat.com>
 <ee8a9fa5-1cb2-4094-9524-6f7b0d2f947d@weilnetz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee8a9fa5-1cb2-4094-9524-6f7b0d2f947d@weilnetz.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Sep 18, 2024 at 07:47:42AM +0200, Stefan Weil wrote:
> Am 17.09.24 um 23:55 schrieb Peter Xu:
> 
> > From: Stefan Weil via <qemu-devel@nongnu.org>
> 
> 
> How can I avoid that my author name/email is changed so often?
> 
> Will this be fixed automatically before the commit is merged?

Hmm, this is pretty weird, as I actually did see this checkpatch error,
then I should have manually fixed the --author of your commit after queued,
as it was indeed mangled in the original patch:

https://lore.kernel.org/all/20240910054138.1458555-1-sw@weilnetz.de/

However it doesn't seem like working.. I checked again, that checkpatch
uses --no-mailmap so it still shows the mangled email.. I fixed it again
locally, then the error is gone.

Sorry, I don't know what happened, and why I used to fix it the same way
(that is, "git commit --author "XXX" --amend) but it didn't work last time
(but I guess .mailmap made it harder for me to recognize..).

It seems that we already have this:

commit 5204b499a6cae4dfd9fe762d5e6e82224892383b
Author: Philippe Mathieu-Daudé <philmd@linaro.org>
Date:   Thu Dec 8 16:55:35 2022 +0100

    mailmap: Fix Stefan Weil author email
 
So I assume even if Peter applies this PR it'll still show correct.

However if you (or Peter, any of you) prefer me to resend a pull, I can do
that too.  Let me know.

Thanks,

-- 
Peter Xu


