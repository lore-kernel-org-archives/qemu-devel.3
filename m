Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2631C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 07:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trXgu-00015D-Pw; Mon, 10 Mar 2025 03:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trXgl-00013d-4g
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:36:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1trXgi-0004wi-Q6
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 03:36:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741592194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=m5RgaAK7QRrxZCnsgD8iYG+8kOn5DjukBLX0S/Ik8KY=;
 b=BzPAt0WyKwh3dPmQNk7RUYe6dgNG1lUfSZId12LBYRqa/ScJLATrgoayst15p9tBavZC56
 +ZWdHozPyY01icuHzmYy9s65fw+PCHLXeY3WxPIaxtvwopwp81kPzLZBSZIkXi/1BW65MF
 McFSXvV6kUWa1rzAeukw5ziH5k+Z9/8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-P05PoZ3iO760dukxLqwAWQ-1; Mon, 10 Mar 2025 03:36:33 -0400
X-MC-Unique: P05PoZ3iO760dukxLqwAWQ-1
X-Mimecast-MFC-AGG-ID: P05PoZ3iO760dukxLqwAWQ_1741592192
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43bd8fd03a2so17022235e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 00:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741592192; x=1742196992;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5RgaAK7QRrxZCnsgD8iYG+8kOn5DjukBLX0S/Ik8KY=;
 b=bIydc3/h+w9ZZaOlq5xVDhgwnh9ndT0olmaU7D8lvWl7O4zCxQfbVQONyC8j+VYmqr
 PKZg3diye4qHY/89p7WXfADiwpXCayQvvadZ7sqfnBsdAzdZXAhL2sCJGfkXMwz/EgG7
 Ubqj9j+KsyijRC1T/FcSru4CGJ/1yzb9VimjQLii68K1afV9JAzVpNO6IhXSj7Injvuw
 yVQgsYSd3CnDAGG+6RjuEzNzeIY4qAQXU3a/aICOxRElYsJTemf/7xLv4jizkOqzugH6
 rEQ3PeYwUBzsvz2ET6a8holtg+l9muxL017tdym8XLrGW0sNqIKb0ipxFEFYOq/0R38n
 k+kA==
X-Gm-Message-State: AOJu0YzfkGa4gEwm/DezCqTcE2G9on9SAUxpoCHom2tj7JJK2/8wPnVY
 7UkqPL9RR+URs1Tspz1v5NyrYBVkpUDAbSrbertuH3dmKxZ+6mAZXf2DR2RFWxCC3jKXmoZ89Vr
 4Xu/3uBIRuhDY257G6ypo5wGzOmFxIIIezWxIVwWCECYR2o02SXOOROzYx3VtgkNnWGArjMJRtn
 PEoTm+ALq9fd+yzfZf12f1Yhe+Q2s=
X-Gm-Gg: ASbGncsJenTIxONBIlkQr7KDKxa4i2C8zwWwWQNgOsCBIVjh7RgVoobEJYpswtp6CvL
 Ggb9Fl+z8XREdjE4pUN4IhMntfwlzn+jDPDjKpwn03rL3P1x7oY9PnGnlZwQYVuavmNTnbU12ZH
 c=
X-Received: by 2002:a05:600c:4447:b0:43b:d0fe:b8be with SMTP id
 5b1f17b1804b1-43c68718900mr82596585e9.30.1741592191949; 
 Mon, 10 Mar 2025 00:36:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk6jhiJPU1RoIndfbkErP1juph8Fm2ADvKWv9IAoL8mJbsmc6kzo4qDZm+9kgxj92fKg5X50Z7HwXuEMEJjmQ=
X-Received: by 2002:a05:600c:4447:b0:43b:d0fe:b8be with SMTP id
 5b1f17b1804b1-43c68718900mr82596375e9.30.1741592191587; Mon, 10 Mar 2025
 00:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <20250228121749.553184-6-ppandit@redhat.com>
 <Z8G9Wj3DWSgdLkNQ@x1.local>
 <CAE8KmOxenqyqOxEFozgP1gBZPtneEqcbop9F_f+VW3ukPfw37A@mail.gmail.com>
 <Z8XBowkG72G-l3L4@x1.local>
 <CAE8KmOyssf_2RYBw2LLpxP2Z5bmtyU==Qs+4HWp=mOVb9o82-g@mail.gmail.com>
 <Z8cPnxqOvp1hFpx8@x1.local>
 <CAE8KmOw1CCQUt0wyELVhy5j-CfwVuA2XNsecW=y6rwJv7dempw@mail.gmail.com>
 <Z8hJeneeuKqD1i8Q@x1.local>
 <CAE8KmOyKiEt9t0vUwVyqD7tx01vkm+NHA1p1tmQnJ9mKY0Za7w@mail.gmail.com>
 <Z8t3uKo54T_Xls_O@x1.local>
In-Reply-To: <Z8t3uKo54T_Xls_O@x1.local>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 10 Mar 2025 13:06:15 +0530
X-Gm-Features: AQ5f1JqlBslLEyeUI5A8sIQiJQD1n4rG-JA8YITXKsZlHJtzrKS-3pictqieihQ
Message-ID: <CAE8KmOw9-F7Yx=j=xfaLCUkF-Yvxv8cSGqrkyYz2Zn-UA1cBAQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] migration: add MULTIFD_RECV_SYNC migration command
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi,

On Sat, 8 Mar 2025 at 04:18, Peter Xu <peterx@redhat.com> wrote:
> Please move all of them at the entry of postcopy_start().

* Okay.

> [1]
>
> > +int qemu_savevm_state_complete_multifd(QEMUFile *f)
> I still like the name I provided because it's more generic, above [1].

===
>  Maybe the easiest as of now is one more hook like
> qemu_savevm_state_complete_precopy_prepare(),
===

* ie. use  ->  'qemu_savevm_state_complete_precopy_prepare'  name?
Should it be  _postcopy_prepare?

>> +        if (strcmp(se->idstr, "ram")) {
>> +            continue;
>> +        }
>> +        save_section_header(f, se, QEMU_VM_SECTION_END);
>
> Maybe it should be SECTION_PART.

* Will try with SECTION_PART.

>  So we provide all iterator a chance to
> do something right before switching to postcopy but before VM stop.  RAM
> can register.

* ...all iterators a chance to do something? Above function only
processes "ram" entries -> strcmp(se->idstr, "ram").

* ...RAM can register?

> > +
> > +        ret = se->ops->save_live_complete_precopy(f, se->opaque);
>
> Maybe we don't want to run the whole iteration but only flush.  I think for
> simplicity we can make a new hook.

* ..new hook? I tried calling multifd_ram_flush_and_sync() in place of
->save_live_complete_precopy(),  but it crashes QEMU.

> > +        end_ts_each = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
> > +        trace_vmstate_downtime_save("iterable", se->idstr, se->instance_id,
> > +                                    end_ts_each - start_ts_each);
>
> We do not need to account
> If you do flush and sync, IMHO we can keep the threads there and remove
> this shutdown, as long as we are sure it'll be properly shutdown when
> cleanup. With the assertion in dest threads, I think it should be OK.

* Okay.

Thank you.
---
  - Prasad


