Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79552C44512
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmPya-0005j2-Dr; Wed, 22 Jul 2026 01:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmPyT-0005gJ-66
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 01:58:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmPyP-0004Zn-4f
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 01:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784699906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7BkccaR1uokwsOjKCRUwtV+a/1p1EBlXJrKJxvfWhKw=;
 b=Gd15n28oDcbGNelYcrj3UBxqSak/p5u9Pm/+NqvqmrtB0mSc376Bd5bmZM/1CJB0b1N1vm
 M4vcEdqBvB8GhRHQB6ntdWV/NOJxfX9b+XrX3MPWCA8cpeHb59Wd0TXoMwYrwf+WpMGc4W
 W0zaVFRpMaXeryiWhSSlQ63FOLsxOr8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-IS84lbbjMVGUOCjyyxQDoA-1; Wed, 22 Jul 2026 01:58:24 -0400
X-MC-Unique: IS84lbbjMVGUOCjyyxQDoA-1
X-Mimecast-MFC-AGG-ID: IS84lbbjMVGUOCjyyxQDoA_1784699903
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955ecd8a10so21032525e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 22:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784699903; x=1785304703; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7BkccaR1uokwsOjKCRUwtV+a/1p1EBlXJrKJxvfWhKw=;
 b=OJf2H0UEo71Vzy2E7I1CdEslf+XEfWaWi/fsLADC6w6Gfb5up+dWZmIPQqfn9VqVgr
 bDMxglQpjDl2FJMv3S5F1Bj1IkyNwni7S6YQ0vfnXGELadJK3Hm0YBgvfyYPWj+Gusao
 ctPhACoe9qT9vxyFM1KTov3PuPJg/7LkTejxgGoh+w1J+LvXdNipQXxUE+7m9OFHyOTW
 BAMODlfgjr8QGEuvpSrYDDOWGhogd0DN54ufcLMv0SCcdISDMJW1NkxOxCOWG+6lQ3dJ
 z8DKatI891XPIeLiQeXyNuRo61ENfFzP7F93kJETlTsq/6FoUlId1Nq+ZcKOuRuIhS5e
 elpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784699903; x=1785304703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7BkccaR1uokwsOjKCRUwtV+a/1p1EBlXJrKJxvfWhKw=;
 b=KIdnU8fHWZw3lVPVbfedbp1mocL8b2eFsrS43PntcNVqeNyDauald99SEHETYRvRjx
 aam/TiSWG1SubPHsO6oA3t0HplrYTGt0nsebhd3du3UzKIE9wgUwmivsVeaJLn58UcxG
 ZBQRY2ajJ6NdhmUTx2yAGJpD21svykavJhixui5YVrWcUGOB69GGUGwl5Asun4+/C8D9
 dvrRykK8UzbS5jn6zREPBpWyhhL17ZaY/doHXxJvD4mMs8Yi/I1Hcq6AWuDgMd8hoWe+
 EYMl4RxUDmEHat1BUGY6JqLMU2e6ICeWzTphEQG4JFWXoaqytv+BSY1w1r2YubByTYMQ
 yZDQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq4VPW9GMuS0VtojcMWLSz9wCfFg0EhhunUGoq/Gv6D6NTyxq5D1tR/cBIcYFqNHSS5vAeff/IVazIy@nongnu.org
X-Gm-Message-State: AOJu0YxUfs9Km7/gDDPP8NxmiuyUOI4vSbNHDoUuHWh3xQLPfeb4F4xp
 l7BP9ZnWyS00xvAkoRTe/HlguYcu2IsEelLwqjFW27/wYS0QsDBkEncwmdlMJn6w+l2qiqU5A+L
 tOimeEZDJx9bsF3r07oMHWibbhth5B51KyZKmv9G2xJlwdKsy547HkppT
X-Gm-Gg: AR+sD12lu3zSRksHOsX//WDnhb9TB9kqxZeOIpLAXsFfivkrhc08wTH39FFZfWQU1Li
 F05pK5ATHmAONnFs7oHFqq2Q0q9ebU5iXHuu1ffIhoLbjxzMcO155X0NdSkyUa4KUAIJmM2iFME
 c+k+fb4oBAPzd6G3z5sMtTcZJmDH++TukGqhHhTQjzEipaI6nSiXnNLBqknI0eEivwVfdNFyrw5
 e0XaK+u/iAlnby7GE9EANBgl4W166ZEbiI20Yovp9YI7eLSXEZcipeUlIYRhWZP1uSRa+DzI2p8
 DQOhdW30wt8vt4R8ea23kBK7nExl5q8j29xmnCYQs17qQ+OINFwlLlqiGDCufBmogV9aTRPQoNU
 BxLJZKmvhrZoxGWbjG8Z8mw==
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id
 5b1f17b1804b1-49553d85ea0mr194619085e9.14.1784699903269; 
 Tue, 21 Jul 2026 22:58:23 -0700 (PDT)
X-Received: by 2002:a05:600c:b85:b0:495:5365:c0d1 with SMTP id
 5b1f17b1804b1-49553d85ea0mr194618795e9.14.1784699902790; 
 Tue, 21 Jul 2026 22:58:22 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a6354a3sm68290795e9.10.2026.07.21.22.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 22:58:22 -0700 (PDT)
Date: Wed, 22 Jul 2026 01:58:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260722015422-mutt-send-email-mst@kernel.org>
References: <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
 <al-eCtxGjG4HHEbl@x1.local>
 <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6210e178-a93f-4411-810a-41edb1fb656e@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 22, 2026 at 10:53:27AM +1000, Gavin Shan wrote:
> On 7/22/26 2:27 AM, Peter Xu wrote:
> > On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> > > If Peter is fine with two variants for x86 and non-x86 architectures.
> > > I can post (v4) for further review. That will be something like below
> > > and let me know if there are any other improvements are needed.
> > 
> > I have a generic question on the "unaligned access for x86": I think the
> > question is about the one Michael raised here on unaligned access may break
> > x86 here:
> > 
> >    https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/
> > 
> >    3. (theoretical concern) also on x86, unaligned accesses are
> >    possible on guest and host, so converting an unaligned access to a
> >    series of aligned ones can in theory break devices.
> > 
> > Is that a real problem we need to consider, or can we start with unified
> > approach and leave it for later?
> > 
> 
> I'm leaving this question to Michael.

Knowing what I know about hardware designers, it's something someone
somewhere does)
It can be made a separate patch, just to show - it should be all of
~10LOC.


> > PS: I apologize if I missed important piece of info along the way; I didn't
> > follow closely on the discussion on this topic in the past few weeks.
> > 
> > One thing to mention is, what we change should only need to affect
> > ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
> > arch when it's pure RAM.
> > 
> 
> It depends. This patch intends to fix issue [1] in the lower layer by using
> the newly added accessors (qemu_ram_{copy, move}) on all directly accessible
> regions including the regular (pure) RAM region. Otherwise, the newly added
> accessors should be limited to ram_device regions only as you said.
> 
> [1] https://lore.kernel.org/qemu-devel/20260527091711.3901-1-liugang24219@sangfor.com.cn/
> 
> Thanks,
> Gavin

using memcpy()/memmove() to emulate guest's atomics is generally
kinda broken.
but yes there are architectures where doing it to device ram is
more broken than doing it to regular ram.


-- 
MST



