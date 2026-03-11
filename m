Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B327A1125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NZt-0002Nq-Ij; Wed, 11 Mar 2026 13:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NZs-0002Ni-0d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:42:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0NZp-000474-R5
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 13:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773250952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQJr28BJpP2nMtmyh8K/EA1kmEo8Yp9rojFfWvBYRrk=;
 b=C0vDnnU7xPEf76rtztZjEUCDzsw4Bt5L7mMxqeIwarlJ+tEu+jeuYjVlnZ2GFMBo4XHZB5
 h+tLkHTvcS6IiHlqSiOjXb/w8pDEcj0gsnRLnHDcrF2JDMPZhYZ7zqnm8i43LTHTICFkVC
 4FFp7W2AyMFeo2pDrdP0d0/TQcnChsU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-eGGHjLtFOlOifUK6XI2d6g-1; Wed, 11 Mar 2026 13:42:31 -0400
X-MC-Unique: eGGHjLtFOlOifUK6XI2d6g-1
X-Mimecast-MFC-AGG-ID: eGGHjLtFOlOifUK6XI2d6g_1773250951
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd849cd562so55102485a.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773250950; x=1773855750; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JQJr28BJpP2nMtmyh8K/EA1kmEo8Yp9rojFfWvBYRrk=;
 b=sCnRWpWnpwlZGwlnbhwpmxjAT4hgvCFA4JUrVSD4i7BbfFKzziDEXZ6zxhQnRugq2V
 Dq8Wp9gYcjvv2yd1RRRwDv7urqgSkiV67FFjeWpJh7g9otL547B0U/CVgI8wHbA4Hzgc
 u+n4GvE9VuTcMTpGqS25rTDowZS/E2kOLbXuevrSUxwPM5LFE63eESi9D/K3hPmxxdnM
 ubEJI2mfZ4Q8ZKCOlKVMuwihTUZygf34rkwsGUsm7BhVJmDPM/jcaVk+rj7S9fyenjZo
 zE2Cj/EynkZdL3u4y5H+pD1KOZQ3t+yLssuJy1lcXNrdnd0KKA/4cJKZcYoOeXLLRpm3
 wbGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773250950; x=1773855750;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JQJr28BJpP2nMtmyh8K/EA1kmEo8Yp9rojFfWvBYRrk=;
 b=Sc8TZbnEhyyt85Rw1SG95CPJV/482G+isiQeRYkcL+9W92+jIUxkabwiGL7xmREkal
 RWB+w37GR5/ms7SHXabKdJZg8B5nY9WG2IvpDp0ATjJuV2ASZGjvypEg+KMpWPrjTbwk
 Cj6ealRFgyulbUk4JGRsuvPiYE75bXFyF2NGfHqL6oyuOPhBhR3ssKTXBzQ5pnpz1cNA
 8xiqFRnsSNd3SHRDXG0gguurLbOC9AxfOP6/sYfAirpXJcKTFaackKOli/JCiwkMWgp4
 fGosBytO1HONKxPxdFUiExATNMEc6QjPIuGAiQc/ST2maLyuKpW8XpHdNutABjio0/BU
 YSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbITYiY1h6X6A42i7XOWpGHghkYvf2wwZdwKZXy7gFtIF9nsPrdLYSASn5ziciKQMFOMvalUpKekho@nongnu.org
X-Gm-Message-State: AOJu0YxeJLhSK/HD17qdSQMN76VFgD5SY0J9rTS6+/bdo9TJgK9EnG/v
 L0m4KgDrz4Hs9p95OIGsvm1oOeDsFSrbyEQ5+UdI9RlHNiIsjOGb65CMw3W/c1zdiiwom4A0+WA
 CJrkstAyeIyCPIVKi5zvGez8pJJ3FAmm3HdkOlUNqSpBc6uXUE6D6lxUNXURrBsPj
X-Gm-Gg: ATEYQzx8aBcr1pfkUtINZtbcOuI9ndj3H5g0hoZpM9R2+kyl9QJWz8eMd3MFBaXWzXF
 dYq2Ug8XdvskLsiR62xDfGIBbar7XjITf+Iq7uwiGlsLgg1hf7vBMfsnAONtbrD5WysMaWRSrZf
 vuYF89gy6Wi0BFSweWM6TdJ9a3mBqjYp9rVEervNSFZYP044othLc+yHy+D5gwBAalJGpf/NuMU
 vfSUItfV5EFXON+IcInhH80SkebAH4/+FvMAV8xueiCNLVrG2zha1kb5ZfJ3/JUGXGaM3JN+Gam
 potyY/HVAhGUQaVKsa2w0AQWNSPONDkQll5mKTbhIaV2QAo3AUAqn6av4yDV7mM3xpcahp4J7AT
 I7jaubgPQQfVoxg==
X-Received: by 2002:a05:620a:4629:b0:8cd:8f18:d1fa with SMTP id
 af79cd13be357-8cda196c76bmr439350885a.22.1773250949996; 
 Wed, 11 Mar 2026 10:42:29 -0700 (PDT)
X-Received: by 2002:a05:620a:4629:b0:8cd:8f18:d1fa with SMTP id
 af79cd13be357-8cda196c76bmr439346185a.22.1773250949526; 
 Wed, 11 Mar 2026 10:42:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cda210da83sm192865185a.30.2026.03.11.10.42.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 10:42:28 -0700 (PDT)
Date: Wed, 11 Mar 2026 13:42:26 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: luzhipeng <luzhipeng@cestc.cn>, qemu-devel@nongnu.org,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] qmp: Add ram-block-set/get-migratable commands
Message-ID: <abGpguGG4EjMdu0W@x1.local>
References: <20260311100116.984-1-luzhipeng@cestc.cn> <87ldfyzg66.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ldfyzg66.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 09:47:29AM -0300, Fabiano Rosas wrote:
> luzhipeng <luzhipeng@cestc.cn> writes:
> 
> > Introduce two new QMP commands to manage RAMBlock migratable state:
> > 1. ram-block-set-migratable: Dynamically set a RAMBlock's migratable state
> > 2. ram-block-get-migratable: Query a RAMBlock's migratable state
> >
> 
> Hi! Could you provide more information on what are the use-cases for the
> new commands?
> 
> In particular, what is the condition that can cause a ramblock to become
> migratable/unmigratable at runtime that cannot be detected by QEMU
> itself?

Or instead of saying "detected" maybe it's "decided" by QEMU.

The QEMU cmdline and rest (e.g. a set of QMP commands to create the devices
that needs to happen on both sides, or migration caps/params like
x-ignore-shared) normally decides whether a ramblock should be migrated,
and AFAIU that's part of the guest ABI.

I think it may make more sense if we want to avoid migrating some ramblocks
then we provide some similar way (e.g. a object property of the memory
backend) rather than allowing it to be flipped anytime, causing more
unpredictable guest ABI.

Thanks,

-- 
Peter Xu


