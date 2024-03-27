Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60AE1CD1283
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 19:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpYm5-0008RA-Cs; Wed, 27 Mar 2024 15:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rpYm0-0008Qh-MJ; Wed, 27 Mar 2024 15:17:21 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rpYlz-0000xt-9H; Wed, 27 Mar 2024 15:17:20 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-221a4f9557dso132816fac.2; 
 Wed, 27 Mar 2024 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711567037; x=1712171837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RLaPyvMeuB8XO/tNp9txCfZQFaViD+9h1gc66SRHBlQ=;
 b=ThFQXHxST/ogl4haMTkGZ6x/0MUy8+9QgwTx/BGMLwJdqqkShJuTD0XHKXhd1N1thL
 bo/ihsBf3SwYw+eKExD85IqnBmBE19mf5LytXmbrkkaXQ61GSYVftzz73h/iQw6hrGhF
 dWqOqm09Qzwy78ymTiNqQa90UOXLMn3I+1/q3dbA2SqoyuyMtcbPUhoHu4FqJqcFuyTn
 LaO6XNLDqWWFCHOd13enNGqLW5tXC3wBXhT48MBOBS5hIr3DfVgLJGQYUAnc1YhyxOFd
 qjWJMUp23o+2d6Spuoql4q5udC+3L0mr3XVO30+ZYr1IBrqLetUubhkflnoG++GtrObw
 ejBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711567037; x=1712171837;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RLaPyvMeuB8XO/tNp9txCfZQFaViD+9h1gc66SRHBlQ=;
 b=bRhBK7ijNiDywlX9zIAnDirBOkQxNVTloiUSi3m7enHTXP2Zj0Kaad5IbegZ97cwXM
 IIiiAs6daGnefmPzAslMQS2gCpYlOZ5GKC+dfE2VlPXZySWI/JrZFsgLmZd63ha7ktLV
 mha1RR4vCOPWBG70p21AbEEfg56yx3Uysqllwj87YD4/tTic5Tu+6BSlhMF3lUiV6ziZ
 lvBSjJU/tbdHtfgxMhsZU1Pv2FaQXvUcX8K6Y2oaSS3klneBH+DYLV/gDm/Haa5fKPQY
 x+cz7oScaS/xvIXIwNXZMHtjdz4HVBVHACqwDKe0UiNSGrNKPi1QqXgJgeB6qZV66tBE
 55NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUElHteUUObAjMKVsGsOTU09Iv7j9AaLJ5MPXA4hCGyHMfMz93op+eIiNmZkG0+Mizt143pxfW5bUER07pj1+kO4IRUqFAwwxhBVNjCUmHwX2jk4bJJScL0ScUmXw==
X-Gm-Message-State: AOJu0YzLkJyCgn0dPdh4G2pWyrNGCQRhVtMon+rngqpyHscZkJhFncfQ
 e0W76VeClgbHBpM3ELnhJw5FIcmdTkt1xDYGjZKBV9R5kgm7twW8sl8xwEMYtLWr5h6mvk4uXy5
 E/LyZyUcUQ91Xxxn3e8/ucmT9R9sv42Sy3Y8=
X-Google-Smtp-Source: AGHT+IERgbDv1wi9BXb34ddtueHzRaQXWPJ0p7+K+tjI7ZhjWiBA2/XOXeOuT0kZK/fe9+0m0AIQHAwLBDGdD6AJkow=
X-Received: by 2002:a05:6870:40c1:b0:221:793a:3b9a with SMTP id
 l1-20020a05687040c100b00221793a3b9amr649795oal.40.1711567036763; Wed, 27 Mar
 2024 12:17:16 -0700 (PDT)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 27 Mar 2024 15:17:04 -0400
Message-ID: <CAJSP0QXSakg69koXJh8fEJFxNxfWM7UV36u9XW_28Jwy9tPFNA@mail.gmail.com>
Subject: bdrv_pad_request() Coverity report
To: f.ebner@proxmox.com
Cc: Stefan Reiter <s.reiter@proxmox.com>,
 Thomas Lamprecht <t.lamprecht@proxmox.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Hi Fiona,
The Coverity static checker sent a report about commit 3f934817c82c
("block/io: accept NULL qiov in bdrv_pad_request").

Please take a look and send a follow-up patch, if necessary:

*** CID 1542668:  Null pointer dereferences  (REVERSE_INULL)
/builds/qemu-project/qemu/bloc
k/io.c: 1733 in bdrv_pad_request()
1727         }
1728
1729         /*
1730          * For prefetching in stream_populate(), no qiov is
passed along, because
1731          * only copy-on-read matters.
1732          */
>>>     CID 1542668:  Null pointer dereferences  (REVERSE_INULL)
>>>     Null-checking "qiov" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
1733         if (qiov && *qiov) {
1734             sliced_iov = qemu_iovec_slice(*qiov, *qiov_offset, *bytes,
1735                                           &sliced_head, &sliced_tail,
1736                                           &sliced_niov);
1737
1738             /* Guaranteed by bdrv_check_request32() */

Thanks,
Stefan

