Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C9EC5472C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 12:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siYTO-00050C-Og; Mon, 26 Aug 2024 08:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siYTB-0004yX-Qo
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 08:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1siYT9-0001sR-PB
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 08:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724673909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hqPMXleWAws97ZnyeA/9QK7rJcg8vV6V4F4Kr5KgBeM=;
 b=B0yO39MU21FM7GkVkDbpnoPvKRJEjnbXOfg8E0ifjaJ/CG8Nxn2Uug8IAJzcq5jZKXxlsq
 lax1nFF/7UTSsxEospERebf1C/rJBpXtp48nuoStucXMZ7JxR0ORU06tJ0gM3USK9Y+6ko
 NxbTV8iDhKYipS3ctygDNq3eGko1tXM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-Cy-wjy6gNYmuCW1c6Wapxw-1; Mon, 26 Aug 2024 08:05:08 -0400
X-MC-Unique: Cy-wjy6gNYmuCW1c6Wapxw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-428fb72245bso22356165e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 05:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724673907; x=1725278707;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hqPMXleWAws97ZnyeA/9QK7rJcg8vV6V4F4Kr5KgBeM=;
 b=Syj38E7PYItCTtCnyjyrUW870ZFPBJh4VVsD7ucedKVl6yeUXcfvObGOifLI0qVh3n
 mpNUQ6otNefohtV6ugrz+3MDIqyDLAzXGIRnI/TpCbqyVbjYxxGPZYBdfYvctN3ySSlR
 7ceggUC2XL61GzDdABDbaJtc7EjO0y8jo9C8PuZewIv7dcIjQVfusCSIiFQ7nz6SHtLh
 epzRRnG5w0eJP0PwbwsdnWeU47+GAvPcqHso2T8BtC87FQVaWQEeh7EyD5lEr06hWqlR
 2daS0H1QQgywkQWOfS8QciV7iBCGXJbcJYKAQL4Eu4lbCYLKERXYA+zDO6QdR3A0rLXk
 Ws4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSjf0VqXW98lGqju0u7Ju0cdy9aF5Mx9d2eLA3SO6F1aONyoZprzgJNoydYxV8mAP0OGxCodgzxlUY@nongnu.org
X-Gm-Message-State: AOJu0Yy0ESfUB1sRBKRlJcTSg+UmPvUPKERk17yr6s36fuv8GdPbTQ1z
 fXiQJVauEtoFprEAqypO/3DwKhLhwGK53CnKCI3aMo/zA7jXPfjTinYuvJ2+0SLP5l0/ilEqKJD
 08rnGAlZKv8jiP64lFkM8mU/GtpK3rGxQgb77kHL50DIaVmAOAGwYMCGD3Vy5hublIQPDDJn4/M
 TlskEk2VkiuKAfeP6TSis4iOKwt88=
X-Received: by 2002:a05:600c:4f03:b0:428:9a1:f226 with SMTP id
 5b1f17b1804b1-42ac388e6d5mr73619495e9.1.1724673907054; 
 Mon, 26 Aug 2024 05:05:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJWp0C3OvKIEZddwYqMK7s47Q06KLB4eolWAyTjGJKHlVrskwjxr6QoLJ8bpr0PIhKr81vySgbWf71hE+C9ZY=
X-Received: by 2002:a05:600c:4f03:b0:428:9a1:f226 with SMTP id
 5b1f17b1804b1-42ac388e6d5mr73619125e9.1.1724673906620; Mon, 26 Aug 2024
 05:05:06 -0700 (PDT)
MIME-Version: 1.0
References: <1ABDAA2B-8582-4B98-81D3-8F71DE62718C@akamai.com>
 <874j7e0yjt.fsf@suse.de> <ACB0E3E9-BA69-4EC7-A4EB-3AF2F21D4C8A@akamai.com>
 <874j7czn33.fsf@suse.de> <3587C969-9BDB-4BBD-8A79-3679C3F3801A@akamai.com>
 <A658D108-2EC3-4BA1-900C-4FE9FB498B03@akamai.com> <87ed6fxpv0.fsf@suse.de>
 <5DBD942C-E192-46F8-9E73-20DD0A5D6983@akamai.com>
In-Reply-To: <5DBD942C-E192-46F8-9E73-20DD0A5D6983@akamai.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 26 Aug 2024 17:34:49 +0530
Message-ID: <CAE8KmOzMFtw0oMQP2=EeiVic5TaK6dc2Fvy2=kcfp_nRg1bn9w@mail.gmail.com>
Subject: Re: Issue with QEMU Live Migration
To: "Arisetty, Chakri" <carisett@akamai.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Peter Xu <peterx@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Blew III, Will" <wblewiii@akamai.com>, 
 "Massry, Abraham" <amassry@akamai.com>, "Tottenham, Max" <mtottenh@akamai.com>,
 "Greve, Mark" <mgreve@akamai.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, 25 Aug 2024 at 22:40, Arisetty, Chakri <carisett@akamai.com> wrote:
> > - start the mirror job
> > - qmp_migrate
> > - once PRE_SWITCHOVER is reached, issue block-job-cancel
> > - qmp_migrate_continue
>
> We use exact same steps to do live migration. I repeated the test now
>
> Sure, as you suggested to rule out any incorrect usage, I repeated the test with above steps.
> once RAM migration state moved to pre-switchover, issued block-job-cancel. There are no more dirty blocks.
> But all the disk writes from 'pre-switchover' state to 'complete' state are lost.
> Thus, it is creating loss of customer data.
>

* How is 'issue block-job-cancel' command issued exactly at the
PRE_SWITCHOVER stage? virsh blockjob --abort?

* Recently a postcopy issue, wherein the migrated guest on the
destination machine hangs sometimes with migrate-postcopy but not with
virsh ---postcopy-after-precopy. It seems virsh(1) handles the switch
better. Wondering if it's similar with 'block-job-cancel'.

Thank you.
---
  - Prasad


