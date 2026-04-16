Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C33FF8D765
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDRPs-0001by-HK; Thu, 16 Apr 2026 14:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRPq-0001bp-Ur
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDRPp-00051R-8m
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776363972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v/oTPfGKn72f9nJSh5ErLKq5DjMdjrXJP55c6PY3dCc=;
 b=eXlRKqLVl9IJQu3U4LkJaOQ8FbpcbModaS8S/Jf5cvhCuzjnIF7exd1yQ1/0/FjzCj5yu6
 wLpB5vEj56O71EQNiKM+a7FlTY5Jfk3mspZfy6QHbyEXN27TE8Fd1IKtLakbnHOWmZsn6B
 R3fQQeS+3d2XFyWJ2lqpmYsVRCeee/k=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-dQvtoNshOVuOXlsoC1CqEQ-1; Thu, 16 Apr 2026 14:26:09 -0400
X-MC-Unique: dQvtoNshOVuOXlsoC1CqEQ-1
X-Mimecast-MFC-AGG-ID: dQvtoNshOVuOXlsoC1CqEQ_1776363969
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d3ea68b9cdso1719399585a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776363969; x=1776968769; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=v/oTPfGKn72f9nJSh5ErLKq5DjMdjrXJP55c6PY3dCc=;
 b=l+lr+GSYg82XFT9DPSyFcBp2ieC0p2iq8PhZqsR1GsalDEb9tSS9Nc+ln/C01D4THu
 UNQGF4fPalIcHNgokV2P716LzFlKJ6hwrs1QUOfB4Xuzrqf4Mv9c38YIx9j8cxQcgtO7
 XkjLHf33bTAovw3PAgXQYBqqNRAfZ2gDe8nOP2sJ4C/5DmC2WkobcqFATNIe+NHu3LeF
 foiNd1F/K+Wdf+XnkBo93SAyp5XWX5/7LRmij4tIo3wUQ90t2S0H0tR4qupF3jutPumt
 eoNMCBOkymIkjiIx2GLkQSKrKPEf7Tk76NxLZ/y3eNj1+Y1X5CTujaXf9D35r3hmUzg+
 tvZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363969; x=1776968769;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v/oTPfGKn72f9nJSh5ErLKq5DjMdjrXJP55c6PY3dCc=;
 b=Of5pXPZ9VqjbUUyWw8TwGbwp2MzDz6aaTH/3Hv8BoP+U8RTNkLRFIH0T+Rtf5F39lh
 F4fiYWNW2igxysO0rBRtCNJKIXkyzH2kR6ruOi+5rr7G2UQLyTZ3XEDTsx3U/vaVqqHf
 Xt+8HvnCCAvusxdDWTKG6i1YwHe5bcBXnN4p0CwCLVocVgkPh6hjWQpX3uER8Opi/wh8
 cNDOV1dPKGrhvy1CNef7qHW1yb7dG6KgJ7LMBitwB2aPHJPaIrMbZlQ8BgTY6F1KUll4
 VbgQmu7l778NQ5weYzakZ/JgaShGlrrnt3NXe4tozqOaxa9DoaN0oMaqvCDD7JqFXnTc
 qomw==
X-Gm-Message-State: AOJu0YxYRAHMXQ+2ThWfj8vXXDdJlF/pP0y2uQxWOsc+taDi73fXUhng
 V90deYjfU33XJ1BV4uaKADfH2/+flwSoqJHpg5Mi/42WZ0pFWM9dd9Bc+PuuT73tUfe8mL+WQlh
 YQjhCWkbOkeyra0JBM4dYdLeW2Pcre1PtVqSkcdM4U8Kt1y5g4WGokozT
X-Gm-Gg: AeBDiesckqVSAh9JCQCSgPU1PlwCNaNfRN+ro3XPmau8joJ+Pg+2lKfrBvOiFYFVr0p
 1EPV8R3zuLW4lqI5+ZLFQ4RA2s8fMuwOWmxStW8a0UAu7ququvpCrblm70GB/3B/eH6YRQbjN8X
 pa8Iy1SPxQO82QUIMdH3kdDHoK23wGUZkcPZ4r1FpOdEgVlEeNeEYIAuywUpQVr16A7JGZQcepU
 o1hqBcDCQhE4xHPwycj7x0YuN9p8Oax2VC/g16QRBFsUeNUa+lh++Pi4BdBf/3j5Axzhbzrw30s
 5kRW24q1VVu/b/9FemWv9tl3Xs0grOhPvoNSpRRyjv5HBbkPsdyzD1oJIurpuQdahyVGhY5lxad
 cA+/Z6GMxOK4XQ0RqJXAUj92FSh31VZnoMhcyx83kn4EoG+lKcrHM/ihxlA==
X-Received: by 2002:a05:620a:4802:b0:8cf:db04:8a31 with SMTP id
 af79cd13be357-8e74c0a249emr69374685a.55.1776363968604; 
 Thu, 16 Apr 2026 11:26:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4802:b0:8cf:db04:8a31 with SMTP id
 af79cd13be357-8e74c0a249emr69368385a.55.1776363968027; 
 Thu, 16 Apr 2026 11:26:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4eed6ee5esm423212385a.3.2026.04.16.11.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:26:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:26:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
Message-ID: <aeEpvTcwEuZsfjRd@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-14-peterx@redhat.com>
 <87v7dz4vx9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87v7dz4vx9.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Apr 09, 2026 at 07:21:22PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Currently, mgmt can only query for remaining RAM, not system-wise remaining
> > data.  It was not a problem before, because for a very long time RAM was
> > the only part that matters.
> >
> > After VFIO migrations landed upstream, it may not be true anymore
> > especially considering that there can be GPU devices that contain GBs of
> > device states.
> >
> > Add a new "remaining" field in query-migrate results, reflecting
> > system-wise remaining data, which will include everything (e.g. VFIO).
> >
> > This information will be useful for mgmt to implement generic way of stall
> > detection that covers all system resources.  Say, when system remaining
> > data does not decrease anymore for a relatively long period of time, then
> > it may mean that there is a challenge of converging, so mgmt can act based
> > on how this value changes over time (especially if sampled after each
> > migration iteration).
> >
> > Before this patch, "expected_downtime" almost played this role. For
> > example, by monitoring "expected_downtime" at the beginning of each
> > iteration can in most cases also reflect the progress of migration
> > system-wise.  Said that, "expected_downtime" was always calculated based on
> > a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
> > not used. This new "remaining" field will remove that part of uncertainty
> > for mgmt.
> >
> > With the new field, HMP "info migrate" now reports this:
> >
> > (qemu) info migrate
> > Status:                 active
> > Time (ms):              total=12080, setup=14, exp_down=300
> > Remaining (bytes):      1.36 GiB        <------------------- newline
> 
> Either bytes or GiB. Better to simply remove the "(bytes)" string.

Yeah, I was referring to above line but then I found we have unit for this
line, so "(bytes)" is not needed.  I'll drop.

-- 
Peter Xu


