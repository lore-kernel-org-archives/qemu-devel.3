Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D14ACC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp2Bt-0000VR-C3; Mon, 03 Mar 2025 04:34:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp2B9-0000SO-6p
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:33:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tp2B7-0008As-AS
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:33:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740994405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f0HVYT6CIPpKz4cCcQ80eg/9rgHlY2VoG2hnAxNBX+I=;
 b=bsPBv/Qz31bsmo9VKWJao4hHQMaSh3V08aYov0W1Zp5s21mo9uY5VrE/AsAmLOfrmbKJZ1
 3xyTB7OMtKizNeJsC/H6vJpWmCkp17C/aharoaXGnJYmh0N0MKZVVrwNvEVFnYqlrA3dot
 Hg/9ZVcS5fiEWCk7jcjMtrGfr0dBBmI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-438-0zJ8PQ9NOC-wLlEQzRFpwQ-1; Mon, 03 Mar 2025 04:33:22 -0500
X-MC-Unique: 0zJ8PQ9NOC-wLlEQzRFpwQ-1
X-Mimecast-MFC-AGG-ID: 0zJ8PQ9NOC-wLlEQzRFpwQ_1740994401
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4399d2a1331so20320235e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 01:33:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740994400; x=1741599200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f0HVYT6CIPpKz4cCcQ80eg/9rgHlY2VoG2hnAxNBX+I=;
 b=W/NhGkZe16ylyynIiOAsKWwAYsEme8t+2n3uZyQ7QiP2uT0cW/teaVGMyN0zxB1dxu
 EaMHRSnGqoGxb9x/+8zlI5tmAsVJJ9M4o1//DwGn3+HS8FcvYnMq9WblZPkeaonkd3dq
 zp5Rhw4Rtf7x0detNkIbcHYk9iMEuVnN++2lGKlHbW+HVfQ0mHjlAGSDi8prCG12B+e3
 vIfTJjKQ3yXqcWmDZOMYcNWOkUkZO0cUnlKWnrV3KJj4x1JP3Twy90a59CjX+J7o8NoZ
 pMj8UyvDubiDVFQ4Awv7MCt2kOYmt01OX1b3mnue7V0PUfkekS6AtflvqWpbdGmQXolv
 kuog==
X-Gm-Message-State: AOJu0YyTrrPVaCT5VHg2nZpUP6LVonhxS5yYxt+kMPJ/A8qoGC/9Puo+
 OUVIdpHl94akpceI0Pz1TFLqw2hVXrbZtj66Vzq5VU52SAI7aq0jGZhAkNQfso41aSn74aZZ+XJ
 XAbMUDBSC2zBjh5glLpOzR787aQWMBnA1f4cJs56pkTxxDqYtSkc2q+JhWegeWKv2iAD2QaHLaL
 gHBgEXbitiaOHcnoRI7f8G3XyiptKIQjX+x7U=
X-Gm-Gg: ASbGncto0gjuYuA2ZRhVUsXtqLtxokG01O0AzO4Tj1/2CFBFgX9PQudAE6cTBH+ZS2v
 9PjhHd8qP5v6aB2jFArlMxp8b+OYfT/xRY6k5iUv/z+JBdk0IvcefxLPqhgdyLPruErs+wqDJVL
 I=
X-Received: by 2002:a05:600c:6010:b0:43b:c824:97fa with SMTP id
 5b1f17b1804b1-43bc8249a06mr5023915e9.14.1740994400125; 
 Mon, 03 Mar 2025 01:33:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8hBuhFQnELDd7xXl5iy0RXpQxR49j+6MvGxRm4SDswofix5aq3tlgiO16k8JUBs/6K9xWi/qH1s8bPy+YXts=
X-Received: by 2002:a05:600c:6010:b0:43b:c824:97fa with SMTP id
 5b1f17b1804b1-43bc8249a06mr5023635e9.14.1740994399836; Mon, 03 Mar 2025
 01:33:19 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-5-ppandit@redhat.com>
 <87cyf22jf1.fsf@suse.de>
In-Reply-To: <87cyf22jf1.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 3 Mar 2025 15:03:02 +0530
X-Gm-Features: AQ5f1Jr-NzQINyyxz7CN3ipqeZMEHxwKD8tIzF7u_JVyvKSrLM9D1IAhnrGShT8
Message-ID: <CAE8KmOwRufeksJWZdde6NLRa0EqKkWFGku2sui9cQ77G_xLs9w@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] tests/qtest/migration: add postcopy tests with
 multifd
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Fri, 28 Feb 2025 at 20:41, Fabiano Rosas <farosas@suse.de> wrote:
> > +static void test_multifd_postcopy_tcp_tls_psk_match(void)
> > +{
> > +    MigrateCommon args = {
> > +        .start = {
> > +            .caps[MIGRATION_CAPABILITY_MULTIFD] = true,
>
> Missing POSTCOPY_RAM here, no?

Yes, will fix it.

Thank you.
---
  - Prasad


