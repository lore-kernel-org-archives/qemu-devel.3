Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE10C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 16:29:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmDKS-0001kP-QW; Tue, 21 Jul 2026 12:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmDKM-0001jd-Gl
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wmDKF-0000en-8b
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784651280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=peKFTWHWFOH2wI/x2JGjvWU2w+n3RfJucxy4ZWT+h4g=;
 b=VXf8KsaMxkD9mbqFWf223iuBB0BYwmlGJuXVOza6pMRZjeNf4T3NTC98UykJOmMgBQCcpW
 fWRkSglWSrKbDy3fZ5R85hzlVXSxpBHzCJS3vdO4yPgLwLypkGBhUr7lCVOdQnIF8kWIQr
 J/UIK/4lKcK9k8QQzePcWsyoEM8eJ5c=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-nFgao_FFNcGu4az5ejwqSg-1; Tue, 21 Jul 2026 12:27:58 -0400
X-MC-Unique: nFgao_FFNcGu4az5ejwqSg-1
X-Mimecast-MFC-AGG-ID: nFgao_FFNcGu4az5ejwqSg_1784651278
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5c0fd51869dso2175599e0c.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784651278; x=1785256078; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=peKFTWHWFOH2wI/x2JGjvWU2w+n3RfJucxy4ZWT+h4g=;
 b=OrWLdepXBOn6C5KpbiAyKB2/MpTk0O0E7+i27sfiVQLjR+grsOQMaHVIyVe1YrczK6
 wA11A7gWp+90f43iFS6+wvL4SL7wnSz+/J7vdVRu+GLzPN5Om1awUa0zNkeJcNQe1CTP
 Y8fHtDZyOIdzG990hjT+doY/PAT4VaN436tiH4pVhwWVKBABO5LrdIL8IprfSeXageAf
 uGwspoW09AxnJrbS1kHi/JY9QgAo6zCuUwCJaH+xCBHadJr7Yn5LXFwEhBQSOaSOqhk9
 BR3jXPqApAhoyBid4wFVq98ODbebmG9a9ErYdUgrMUZrkpjgE3Td8fBUBH/t8f4pgcQo
 cUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784651278; x=1785256078;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=peKFTWHWFOH2wI/x2JGjvWU2w+n3RfJucxy4ZWT+h4g=;
 b=fgu2/u4RVAvMThMJ90K+qxws2qTU4gl4Ks/lnM3Q82BpMnnNbjJbTlKA2q+j9zmflS
 A/DF8BsIspNMlNb14jFyxw0IQuEVIhoNfxSfks+CsuBOk9Pknuyg0UHWFlr1H82rpKAr
 frYoKF8dQaPKLKne/KxY2ZUoeAkunuqPTYhHXX7TE3YmpefkWUGMRVEiKvc0jD7hyhct
 DfkiP6+pc+2tpUohp1kJscOnUVx/hr4or1apx6WbnnNApSbib9hbILhc5aBIAMspqlwq
 tiYwkAhtuUOxQqejfRvEXZD2/m+6wxf4834YzKtpk46SwvdTv/j2M1VER8TJfm7qlt0B
 +7+w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNaHdjSNra2TnDOhlDKOhi3KgC961KcUxUsbYcgQtyjAUlfwz4jLNacj1ILNo74kyTPUxs1ebftQP0@nongnu.org
X-Gm-Message-State: AOJu0Yw1ybu0B6pck5VW8R3oYyNS5jNElCHG1OpWV2W/TG84yOIbQFHG
 hjxeoBE5o6OXdgeNLsd8NnLSbLm2UhzLou312dS5hg8wx3DufDHzvTyyzEd///XXRlyti8+wIPZ
 BH4aRDX8IK2bD1nIaHGJmLh1dkzhQrHOnqhzUo4SLuwbV3fq8quwsEaP0
X-Gm-Gg: AR+sD101W3tIkjzf/tXEDFGfzMCUfwPVHff/RJV3TbgDGlCz8gboTcYHKf+iQG+6E4B
 s8LwZXEyb9snRRQ7ecxFSxcuUYWhrAf9NSlxCjcRThn/gVLngRhsNeM4ouOO6Gpim9S24CjJkBi
 IwZQ9T1nGCzl/ci7iYtz1zTVB7QJYoVqqC1DITJtWkPNN6CUrBN4uXFBkOPUtygIWpMsWYygRu3
 IsSFPkgEOHpGQdDMEgsXsURn2RTuC1vAijbADl7rUYdnoqAsj94g0qktc6ac8Mob+JpMI4dlDWY
 yi1fh2SBfz7qPUdURIPEE0z5z34XS1nGJw2P6abGIBMmxKVEUCFqBUhvSM5EdkAVhz9I9KcxDM8
 LZg7jRPnEfgGAiLKb+XUIacG6y0DG1uooGDuo7hcSL4dDJuISyuhRcUHqer8=
X-Received: by 2002:a05:6102:d8e:b0:729:65e:f08c with SMTP id
 ada2fe7eead31-74753146d97mr5850101137.0.1784651278036; 
 Tue, 21 Jul 2026 09:27:58 -0700 (PDT)
X-Received: by 2002:a05:6102:d8e:b0:729:65e:f08c with SMTP id
 ada2fe7eead31-74753146d97mr5850060137.0.1784651277372; 
 Tue, 21 Jul 2026 09:27:57 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-747581b09absm12522517137.8.2026.07.21.09.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 09:27:56 -0700 (PDT)
Date: Tue, 21 Jul 2026 12:27:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com,
 liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com, qemu-s390x <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <al-eCtxGjG4HHEbl@x1.local>
References: <CAFEAcA8-Un+Q1yBDqLWCLPRwtgTA_VhJqGobgZChrFhAeVfG8A@mail.gmail.com>
 <20260625123119-mutt-send-email-mst@kernel.org>
 <CAFEAcA8UjtXgmPC27fOKMwbaWs2piwGYudtwCNWQHuu3E_7A-A@mail.gmail.com>
 <5faf04b9-d596-4a1d-9fe3-5e9ad5f0a99a@redhat.com>
 <73f79841-8cc7-4ca6-8f6b-fb97b53a6fe8@redhat.com>
 <20260717091756-mutt-send-email-mst@kernel.org>
 <CAFEAcA-O6Z4JrVV0DL_tta6khRyUta_Zz5mJt6OszaW1mu0o6Q@mail.gmail.com>
 <20260717095407-mutt-send-email-mst@kernel.org>
 <9c2ad22a-e768-4a07-85a2-01ce1fc14368@oss.qualcomm.com>
 <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59882c5b-545d-4768-8bf4-723fed97a801@redhat.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
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

On Tue, Jul 21, 2026 at 03:37:53PM +1000, Gavin Shan wrote:
> If Peter is fine with two variants for x86 and non-x86 architectures.
> I can post (v4) for further review. That will be something like below
> and let me know if there are any other improvements are needed.

I have a generic question on the "unaligned access for x86": I think the
question is about the one Michael raised here on unaligned access may break
x86 here:

  https://lore.kernel.org/qemu-devel/20260617022330-mutt-send-email-mst@kernel.org/

  3. (theoretical concern) also on x86, unaligned accesses are
  possible on guest and host, so converting an unaligned access to a
  series of aligned ones can in theory break devices.

Is that a real problem we need to consider, or can we start with unified
approach and leave it for later?

PS: I apologize if I missed important piece of info along the way; I didn't
follow closely on the discussion on this topic in the past few weeks.

One thing to mention is, what we change should only need to affect
ram_device, AFAIU.. so most memcpy()/memmove() shouldn't be changed for any
arch when it's pure RAM.

Thanks,

-- 
Peter Xu


