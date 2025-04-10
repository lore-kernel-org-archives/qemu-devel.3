Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C31C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 12:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2qvw-0004Oo-Gh; Thu, 10 Apr 2025 08:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u2qvi-0004La-Py
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:22:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1u2qve-0008Qc-3j
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 08:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744287763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0I+37ipVD2CW1eHUA4I8HkVTfdPHdavKC9UaPF4KOU8=;
 b=L6US/VMskp3LrjeXSHrXmB6HlSYegKOnpJDsjV2aRu1vLnQnrq+gwaRdzOkoVRmOrIjj0a
 +xssaWad4KfWnTGjh50q+g6/vS+xHKPck0rf/f5V9kx0+Nuu90c1PrJPRDgNMu6kcpHgMo
 6XTjwFvtN6VirTYa8JyOQ78xp2LwdZs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-IQG8lnl_NG2no5OBJT8rDg-1; Thu, 10 Apr 2025 08:22:40 -0400
X-MC-Unique: IQG8lnl_NG2no5OBJT8rDg-1
X-Mimecast-MFC-AGG-ID: IQG8lnl_NG2no5OBJT8rDg_1744287758
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-391492acb59so406349f8f.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 05:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744287758; x=1744892558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0I+37ipVD2CW1eHUA4I8HkVTfdPHdavKC9UaPF4KOU8=;
 b=LDCM9zehWFRLvBVKl9YKgKpCZ+s9EumTum4PcdWa5Is2w9QzH7irY41suc9SMdvkdm
 BS7FuJ1MgtCNN47jJ8YArAaZkt3u5YFziWSzsQE3mYjGRIA6AtpQYDEpdveS/8BSDUKK
 Do3kxdzJKdYyW9Hw+T0ZP9RG8bTNyM1hN2Q4sgrHtCAiLroDYdVbqTmWI3IQfPVkB3J+
 Sfv3I6YGCBOqTjzlvvUN77n2J3NHqSbFUCPlQ+8fqkAzQmc+R4Qp0T0UGPAtxYF1oKCF
 Fi3CZE3jJUeFaOOc1KdAT7OfFBqDyFjF+nezevUx1YgKTbuoM8vjtTToOu31ybKUAvUx
 lxPw==
X-Gm-Message-State: AOJu0YwFC++/LuqRsL8GnlDF1wFt+dpeZKwrjP3rh46jdvAHGvNFeonS
 T9cRqUeT0KxGuf+cESpso48WaPvnQAknxRXvuhPlYqiGLLEBky7uqFjCTjd+0Yd93WAVg3ELjk0
 1bCY0l+Z8qFCY82qJ3nhIiOmoFiCnyFfJExjJ/Bt0LG3To9UEnH3qhiXjWucf/sWaJ7V5qTrNxr
 P72RPg8ZnJhFAySkyoVTEYvmZmiZw=
X-Gm-Gg: ASbGncvN1GbWVkKIxrt0WOIZo5kCSLJWSsmxAa/kfGeGDGOD7kYG6jGHMNz2dQfu83v
 Jo3m+9fWRN1wJ6cYzywzHQ7BSme6X1VB1OKfuHBw6zp5urXngovRwZ0+w3vOqwdhhEQuTPjI=
X-Received: by 2002:a05:6000:250d:b0:39c:310f:f70a with SMTP id
 ffacd0b85a97d-39d8fd63e8amr2121546f8f.7.1744287758019; 
 Thu, 10 Apr 2025 05:22:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4WrMkgmctEvD7eH7TCrEp5R3jps3b2venej9FZJWNZ05l0eI3zjNBFteUgW5u+dTeZBi6fTelI7vwQh6ra4s=
X-Received: by 2002:a05:6000:250d:b0:39c:310f:f70a with SMTP id
 ffacd0b85a97d-39d8fd63e8amr2121517f8f.7.1744287757608; Thu, 10 Apr 2025
 05:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250318123846.1370312-1-ppandit@redhat.com>
 <87plhwgbu6.fsf@suse.de>
 <CAE8KmOyS+nPexU_NbF0yhK_=ubnGgKs5Lv+j7bH=xowgqQ2zkA@mail.gmail.com>
 <87zfgxjspn.fsf@suse.de>
In-Reply-To: <87zfgxjspn.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 10 Apr 2025 17:52:21 +0530
X-Gm-Features: ATxdqUEYPi5dW_sy-bwew-pKYl8PJ6SFr176mXxLLvVSdqHBMB_z77h0Rs2re9Y
Message-ID: <CAE8KmOxi3w5sf_sd04qLxkg8Lys=KA0pMPJMcZ-=CJVGZRmivw@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
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

Hello Fabiano,

On Thu, 3 Apr 2025 at 18:41, Fabiano Rosas <farosas@suse.de> wrote:
> Prasad Pandit <ppandit@redhat.com> writes:
> > * Thank you for the reproducer and traces. I'll try to check more and
> > see if I'm able to reproduce it on my side.
>
> Thanks. I cannot merge this series until that issue is resolved. If it
> reproduces on my machine there's a high chance that it will break CI at
> some point and then it'll be a nightmare to debug. This has happened
> many times before with multifd.

===
qemu/build)$ for i in $(seq 1 9999); do echo "$i ====";
QTEST_QEMU_BINARY=./qemu-system-x86_64 ./tests/qtest/migration-test
--full -r '/x86_64/migration/postcopy/multifd/plain' || break; done |
tee /tmp/migration-test.out | awk -e '/====/ { printf ("%s ", $_) };
/slow test/ { printf("%s\n", $_); }'

Host-1]
...
9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.42 secs
9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.56 secs
9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.44 secs
9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.43 secs
9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.53 secs
9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.46 secs
9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.49 secs
9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.41 secs
9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.42 secs
9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.58 secs
9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
--------
Iter: 9999, low: 1.35, high: 1.73, avg: 1.47 secs


Host-2]
...
9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.69 secs
9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.41 secs
9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.54 secs
9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.44 secs
9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.44 secs
9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.37 secs
9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.45 secs
9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.53 secs
9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.47 secs
9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
--------
Iter: 9999, low: 1.34, high: 1.82, avg: 1.48 secs


Host-3]
...
9980 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.50 secs
9981 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.55 secs
9982 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.54 secs
9983 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.49 secs
9984 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.49 secs
9985 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.52 secs
9986 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9987 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.52 secs
9988 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.54 secs
9989 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9990 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.51 secs
9991 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.50 secs
9992 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.53 secs
9993 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.50 secs
9994 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.53 secs
9995 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.49 secs
9996 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.48 secs
9997 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.54 secs
9998 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.44 secs
9999 ==== # slow test /x86_64/migration/postcopy/multifd/plain
executed in 1.54 secs
--------
Iter: 9999, low: 1.31, high: 2.49, avg: 1.48
===

* I tried to reproduce the hang issue with and without -traces across
3 different machines but am unable to reproduce it on my side.

* Going through the source and the back trace you provided, you said
gdb hangs in the postcopy_ram_fault_thread() function at poll()
function to wait for a missing page.
   - But by this time, postcopy_ram_listen thread is already preparing
to cleanup and exit
       - That means postcopy migration is finished/ending
   - ie. postcopy migration is ending without (or before) migrating
all the RAM pages from the source side?

In postcopy mode:
    * Is there a way to log the pages (#numers) that are sent from the
source side?
    * And log the pages (#numbers) that are received on the receive side?

* That way we might be able to check/confirm the pages which were not
received or not processed properly.

* Can we connect the faulting/missing (HVA=0x7fffd68cc000)
address/page in postcopy_ram_fault_thread() with the memcpy that the
main thread seems to be loading via vapic_post_load()? ie. the main
thread and pocyopy_ram_fault_thread() above could be doing unrelated
things.

* Other than this, I've revised the patch-set as suggested. How do we
proceed further?

Thank you.
---
  - Prasad


