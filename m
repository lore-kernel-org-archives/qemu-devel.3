Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C6FCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 15:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVA5I-0007Wd-2i; Thu, 04 Jun 2026 11:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVA5H-0007WO-Ez
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:34:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVA5F-0006Rj-Kk
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 11:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780587251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LXuw1R4fWhgfkdPROp692WbisqAyHIQXKwa05SltI1w=;
 b=jLu9LWnR39UN2eDpF91fDWM5umV/rJZv0fD3MrhnJcNDFhQ2a5ijVUtHrwLIPzNcaOt7Eb
 sv0dMcnfw76XfY9IrgO66jIs61QBWScFZ/nYGuz1bq1WhpY/QRR9slvFkB3SkIwBgd6Qpy
 eMJ9v0gNLkf6CR5pwUpz8qX9QFf4yJA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-DzwWj20BPcC8rA40iKHjCQ-1; Thu, 04 Jun 2026 11:34:08 -0400
X-MC-Unique: DzwWj20BPcC8rA40iKHjCQ-1
X-Mimecast-MFC-AGG-ID: DzwWj20BPcC8rA40iKHjCQ_1780587248
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91571300242so454717285a.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 08:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780587247; x=1781192047; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LXuw1R4fWhgfkdPROp692WbisqAyHIQXKwa05SltI1w=;
 b=gy5sT7rDnP8Pj4n8mucc/TnTMEEaCNI5sxzXsOfAXqrt1WipCO4iuWuoByAK4MtlIp
 srD0TkYEcndg36FSc+MO2SVZP6yOSTFjbcZnfEf/K4yrs44/qnWi+gRmUt10YEAGxdyS
 N6r9P09LMCCaOboClqSQFFrp7UyR8N4W1JdPu2RiVDMInNY7ATGcjPFGWNf+Jvz0FBWQ
 cPd32Sm/b2HDhqpE38XD2qT+zD7dh2H/pSCc+KGyjyvx1vX5T0cDtWuxWDXgJ/TGiJ0d
 wqFfbuoy95521yj9a/JEtEUD8u97cjWVbMAbAFLv/YhulHJTSgMJIGeNvq1WuryLc0V+
 SLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587247; x=1781192047;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LXuw1R4fWhgfkdPROp692WbisqAyHIQXKwa05SltI1w=;
 b=bwQeq7RtB0dmnjVaAyvMGICq+hCmR0F6gEmUn5ODLsaO2TE8Ps/KC0aGir4IbgYRiF
 TvnN5RETJFAs/kI3F4bSTTin8jx7jaDg19eH0cIulfu6IByE4D69OVXwGXIfCvVKIwA4
 H3zF80FX/9xrW5HN9eBMLBCM1U0Vh1tqzlqCF9CEY6pJlB4IeFwyiGslQRsxRKwWZSX0
 3nUoG029o/GyOWHEQ4jY5bnbzE8cdf1DwbyqMT4yYZgorOXJ7ycahKLw/OlAggssa9yA
 Fvp+zR9FJF9CflqqXCszi2bCiN8lVur0xp5a6Ho5sfHj38001qBMuBF+kE3ivNbZHPU2
 TWAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9EAeBzZi3a5Ico1uqb9qIncikegpyxovlkWUzz6vqegSOIit/4LrszKc9kByKNPNH57j49lvrGfPg5@nongnu.org
X-Gm-Message-State: AOJu0YxB7/pqRrOrC/eS+Nus4usLkeu3Z9rbsc54OiMZP6KtqyMv5tzs
 jwXayf+Xud0kKbe2q88upX8S/8+hM36EDdJxehqffkalbG21f1Ck8ZWAPi1zV2RCJeyQdYAFjwS
 hujcmTQFr9S4HRE9Da50kWQ/0uxe+r6hBWcG27mH6BdffICkaIjiSZinG
X-Gm-Gg: Acq92OEugzHFMiaEyDFYApM4mCYe/94JbL8XR4t+8AhH52HmJc7IfP8Pkll0FSkpYGx
 jSdAavArBXr/zeyXOHY55aC/fn34ks6+8Kq5aNQ0B61xCBC7dJM2fMHtzO4BKjZ9Tq8Vr+lCGTx
 iwtChVF30CDCKXdSjs+DCrYpSx2yzh1dpdAGdMItW1UeLAOBJWf0BRFa58kJD793a9ooAjbPhbV
 r/ES9oMb9h1eG0h2L33EMW/3E0DYGvWNLbw4mRBlWfNN+G0Tscp+5xbya0TuqtrRAib/Aq8ONWq
 ge6Vy8Zsx5POJgUI1yjSXNqUZ8x4FcqCJ8haRSPuDuEbhivVJ5H+AalFs3Gacq/RWTzVo+SUDvQ
 9ALHAOftY06Gt8wIEvuq/Kalokg==
X-Received: by 2002:a05:620a:3195:b0:911:dfb6:d89f with SMTP id
 af79cd13be357-9159ae66cdbmr645004585a.4.1780587247497; 
 Thu, 04 Jun 2026 08:34:07 -0700 (PDT)
X-Received: by 2002:a05:620a:3195:b0:911:dfb6:d89f with SMTP id
 af79cd13be357-9159ae66cdbmr645000385a.4.1780587246976; 
 Thu, 04 Jun 2026 08:34:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a40d566sm600669385a.47.2026.06.04.08.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:34:05 -0700 (PDT)
Date: Thu, 4 Jun 2026 11:34:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH RFC 1/2] migration/vl: Allow set parameters with
 -incoming config:*
Message-ID: <aiGa7D2s7VlVowFO@x1.local>
References: <20260528212947.368132-1-peterx@redhat.com>
 <20260528212947.368132-2-peterx@redhat.com>
 <87pl2ftc12.fsf@suse.de> <ahmrcVkOWW5iwozk@x1.local>
 <87cxyetbc4.fsf@suse.de> <ah36ZhBP2TweYhg0@x1.local>
 <87zf1d6p24.fsf@suse.de>
 <12cf9760-831a-410c-b8dd-a9bc6befbae3@nutanix.com>
 <aiBOg66Txxwv6w3I@x1.local>
 <0ec66128-d2f0-49e8-b1e7-5602b3cd662f@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ec66128-d2f0-49e8-b1e7-5602b3cd662f@nutanix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 04, 2026 at 10:21:45AM +0100, Mark Cave-Ayland wrote:
> On 03/06/2026 16:55, Peter Xu wrote:
> 
> > On Wed, Jun 03, 2026 at 04:36:37PM +0100, Mark Cave-Ayland wrote:
> > > Is the longer-term goal here to allow machine-versioned usage of all
> > > migration parameters supplied via -incoming via -global?
> > 
> > Nop.
> > 
> > Machine compat properties sticks with machines, they'll be applied properly
> > to migration objects at some point (needs to happen after machine object is
> > initialized).  It'll keep working, no plan to change that.
> 
> What are the machine compat properties currently being used for in this
> case? Presumably something that isn't expressed through a capability?

Please refer to:

https://lore.kernel.org/qemu-devel/ahmiKxc0swrIJQVB@x1.local/

> 
> > This series is only about exposing a new API to setup migration parameters
> > so that modules (like TAP as backends) can query at very early stage of
> > QEMU boot.
> 
> So shouldn't we just QOMify MigrationParameters so that our existing parser
> can be used without coming up with a custom solution? I feel I'm missing
> something obvious here since this was Fabiano's suggestion.

IIUC this series almost does it, qobject_input_visitor_new_str() and then
visit with a follow up visit_type_MigrationParameters().

Do we explicitly need to make it a separate TYPE_OBJECT?  Is there any
benefit of it, and how that proposal differs from the current?

Thanks,

-- 
Peter Xu


