Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324E4C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhWFo-0002uW-0k; Tue, 05 Mar 2024 09:58:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rhWFm-0002ts-6b
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:58:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rhWFj-00046c-W0
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709650726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGmtSnEMvXaAyhbkbKiJuU2VWzcp9cCKce6Umqdl3TM=;
 b=dCKG5foYbal/WEMhf/P1QS6LdVCHGezOTRoeWDEFiosFc19LElvE3PXNyhJ16euK1pCCbx
 pSIQFQtQsy3Pfg+dONi/Lr9LKt2Gr0wIGfsckemP6XzD2wB7T3NagynJvNG6FqU+4xzBqz
 z4Jn1kADnAsU8GRzK4dGT9upJYq/GhM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-cbGxfgUaNSCtOALRYNfvRw-1; Tue, 05 Mar 2024 09:58:45 -0500
X-MC-Unique: cbGxfgUaNSCtOALRYNfvRw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412de861228so15112895e9.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 06:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709650721; x=1710255521;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bGmtSnEMvXaAyhbkbKiJuU2VWzcp9cCKce6Umqdl3TM=;
 b=oq94cb7vA4OW8FimYlGMvCNp+tvAQbpjvu1cFxl/tb0dz9q0+j12ebCbnWlekPe/5T
 wTt6QNrKE5eRg5Cri9yZx17eN+d8I4imrpzkDCnfSCWds6LgsHx8kKN+WzbdIjv0LveH
 7A8bR8JPy1hYd+93lsBiy8/Vhl1T7VN1zmd5C8+P/QMdQZ3NBUYPVcqSVrfOGC9ZJRGq
 h8+9gtXIJ0uyuYcbyh3PP+WrS3UTDE5FBgPbKP0rrffbo0zwIvQ+x2pQh+S6s5WqWaDa
 KdQvVjJSgUKR+sdkU/m+F6mCf+kBxAWWpaLXGDya1Yj85bde/rLBGFyXnhe5XqOqCFMa
 HKrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4ojthjUCHM4BPtkYVR87BGj+F0qXaDouq02dHjllW2HYCmx4S0KGiEWDWkCYqLGhtyxFQBmjElr6I9DOVUgQ+S0mYO5A=
X-Gm-Message-State: AOJu0Yy7EhZANjwCj7MwrY9lH1OEHTcPm/pWKaTwCxqwriawMEK0EPBF
 wX9BpFTFcsLWttWcgJFdJpEexv9EzayaPmcvPT4ww42w0665+icFZUUTs0/Gxj5UQS/JlTvISrd
 IFtNfEpqchIjFZBaZ2GWBoiZRL9OOeZ+iHZNT2N6VD5GvKKbRE34o
X-Received: by 2002:a05:600c:19d1:b0:412:c8cc:d9eb with SMTP id
 u17-20020a05600c19d100b00412c8ccd9ebmr9362330wmq.23.1709650720995; 
 Tue, 05 Mar 2024 06:58:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGslh68IMiARuMA6X5pJzXyv/ICLSgjn14XJRZSs3a4BNTATXN7kfOYg87xEqX1lfeJ48Jo2g==
X-Received: by 2002:a05:600c:19d1:b0:412:c8cc:d9eb with SMTP id
 u17-20020a05600c19d100b00412c8ccd9ebmr9362320wmq.23.1709650720667; 
 Tue, 05 Mar 2024 06:58:40 -0800 (PST)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c444600b00412ed9b621bsm2004581wmn.5.2024.03.05.06.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Mar 2024 06:58:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 15:58:40 +0100
Message-Id: <CZLWLM84EI89.28IAJ5VSI5OEV@fedora>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <Zbf8hradcHeeEXae@redhat.com>
In-Reply-To: <Zbf8hradcHeeEXae@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Daniel,

> > +
> > +        /* Retrieve all packages power plane energy counter */
> > +        for (int i =3D 0; i <=3D maxpkgs; i++) {
> > +            for (int j =3D 0; j < num_threads; j++) {
> > +                /*
> > +                 * Use the first thread we found that ran on the CPU
> > +                 * of the package to read the packages energy counter
> > +                 */
>
> This says we're using a thread ID
>
> > +                if (thd_stat[j].numa_node_id =3D=3D i) {
> > +                    pkg_stat[i].e_start =3D
> > +                    vmsr_read_msr(MSR_PKG_ENERGY_STATUS, i, pid,
>
> but here we're using a pid ID, which is the thread ID of the initial
> thread.
>
> > +                                  s->msr_energy.socket_path);
> > +                    break;
> > +                }
> > +            }
> > +        }
>
> This API design for vmsr_read_msr() is incredibly inefficient.
> We're making (maxpkgs * num_threads) calls to vmsr_read_msr(),
> and every one of those is opening and closing the socket.
>
> Why isn't QEMU opening the socket once and then sending all
> the requests over the same socket ?
>


The usage of pid here is a mistake, thanks for pointing this out.

However, I'm more sceptical about the fact that the loop is inefficient.=20
The confusion could definitely be because of the poor variable naming,=20
and I apologize about that.
Let me try to explain what it's supposed to do:
Imagine we are running on machine that has i packages. QEMU has=20
j threads running on whichever packages. We need to get the current=20
packages energy of each packages that are used by the QEMU threads.=20
(could be all i packages, only 1, 2.. we don't know what we need yet)=20
So it loops first on the packages "0", and look if any thread has run=20
on this packages.=20
If no, test the next thread.=20
if yes, we need the value, we call the vmsr_read_msr() then break and=20
now loop for the next package, i.e package "1". And this until all=20
packages has been tested.

So in the end, we 'only' have maximum "maxpkgs" calls of vmsr_read_msr().

Hope that's ok and that clear up the confusion!

Regards,
Anthony



