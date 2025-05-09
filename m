Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6874C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 05:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDGLF-0001NF-CZ; Fri, 09 May 2025 01:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGLC-0001Mw-SW
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1uDGLB-00080q-CX
 for qemu-devel@nongnu.org; Fri, 09 May 2025 01:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746768728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cgm4+6mfagSbZEGsOoEnD3/mRH0fX2phbF9Gd1OZwoA=;
 b=T81DDIQrQkzQRIx7/BwZb3W8opPxsOMT67z4/TnHq5ZWJpM2a+4z/6Uxt9ohvo2AxF41EX
 xNT7NW+1o2QvnjQSYnHuPeDxExwOP+SCBrfzcyqNkG3npivI74lPefHts822Y8J6Lcqms4
 EKTyeU7kMAYYvJleda+EFOQE7w6fPy0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-mjlkifl-PhKiJoYpZzwBuQ-1; Fri, 09 May 2025 01:32:06 -0400
X-MC-Unique: mjlkifl-PhKiJoYpZzwBuQ-1
X-Mimecast-MFC-AGG-ID: mjlkifl-PhKiJoYpZzwBuQ_1746768725
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so9174365e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 22:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746768725; x=1747373525;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgm4+6mfagSbZEGsOoEnD3/mRH0fX2phbF9Gd1OZwoA=;
 b=BoctHnh6BIZgN9ShD5VVICyGW/BOV5ItxEGbPYlUFcK20grn+MPSHLxTxAUXwn6+1w
 tzu3s9CDtvU5VEocBvtptUWqMsFVMRNayLEhsRnGQdRaGwR77DZkFKjJvccv3+Ol4CKI
 GEk7u26CbOfr+dT+bfttW+E+g9DUpucO1tGdWhzmJnBCNEuu4A4fWWzbkoyd/6n5fZKa
 HcE+QIPXOEv7mDPRlx0Zd7TA7Dzqp0hfd72yspvsMoxVdqGyXWvI0FrdqA9v4/shpU3K
 0MjrwqVNS8rsaq7i31QTDdIG98+pZuWj1V4uMCEIQ4tSDRohdE6R63e5teNSm/CKXMNf
 0yhA==
X-Gm-Message-State: AOJu0YzYKI++NXmotrnRmblqmTrL8ycchc6TtykGl343IftaywH51vuo
 OmiCvdAaP0cyPiH+igubf5lU0XE4Q32FRcwpGL6cffViGCpqB8idV/sIZPqg/r0MQvFSG7Mu8B4
 rb4v8I0/XboDvurfJMGSH45vTsCWeopENfpqrFybLfUpHxNmUdActY2NBd/BDHvTAlCU0acJCyZ
 OGXD7V6talutdHfHqzzCzjUz3dJRA=
X-Gm-Gg: ASbGncvM399w7wEdbOdDAxmdmPaE+BbB1gRswiNZWCG7tZKF/20E3jc8+xfWwcVMOed
 7WK2KzodIX/OkInO4qb96tcWK4mL7w49wDPQiqssOcN2mTuXKDvANNgmSmumuIiFe0ytwNEQ=
X-Received: by 2002:a05:600c:4694:b0:442:ccf9:e6f2 with SMTP id
 5b1f17b1804b1-442d6d5d923mr12018625e9.16.1746768725065; 
 Thu, 08 May 2025 22:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjS0VGz0QvEFjx+xUrzO0ROSTAh04cp8H+0RSrt7ewTmFZSaT0I7S98L/Et6fmpOAWJxsrl5V8ARogw0CYMik=
X-Received: by 2002:a05:600c:4694:b0:442:ccf9:e6f2 with SMTP id
 5b1f17b1804b1-442d6d5d923mr12018435e9.16.1746768724735; Thu, 08 May 2025
 22:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250508122849.207213-1-ppandit@redhat.com>
 <20250508122849.207213-4-ppandit@redhat.com>
 <87ecwzfbnk.fsf@suse.de>
In-Reply-To: <87ecwzfbnk.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Fri, 9 May 2025 11:01:48 +0530
X-Gm-Features: AX0GCFvSfLp9dhWLOUmq5hQ1bz6nz40X1w5_z-O4UXU6vKmCBqqlUp4DIbH4xY0
Message-ID: <CAE8KmOzwP8HUUWnd5eN+GWXyYmEmUA5rT6GdG66+zqyF2SC-bg@mail.gmail.com>
Subject: Re: [PATCH v10 3/3] migration: write zero pages when postcopy enabled
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

On Thu, 8 May 2025 at 19:27, Fabiano Rosas <farosas@suse.de> wrote:
> > During multifd migration, zero pages are are written if
> > they are migrated more than ones.
>
> s/ones/once/
> s/ones/once/
> extra blank line here^
>
> nit: Inconsistent use of capitalization for the feature names. I'd keep
> it all lowercase.

* Okay.

> This patch should come before 1/3, otherwise it'll break bisect.
===
0001-migration-write-zero-pages-when-postcopy-enabled.patch
0002-migration-enable-multifd-and-postcopy-together.patch
0003-tests-qtest-migration-add-postcopy-tests-with-multif.patch
===

* Okay, like above?

Thank you.
---
  - Prasad


