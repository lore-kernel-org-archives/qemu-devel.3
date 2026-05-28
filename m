Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C96D5CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSag0-0000Vb-Aq; Thu, 28 May 2026 09:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSafv-0000VH-Tp
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wSafu-0000gr-4l
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:21:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779974484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xZqG++Ij89AWvIFOLGP8qragGJGYt2xvFj7kIkiZc6Y=;
 b=SMp6IjFdRj7jlV04sj9hVAGn/2wre04/HfaqMWR9cjfRhHzWyIyUETb1T26QKYko2VgAFK
 6OQeKCHwjLaPrmaZkhrKTUzD5WpXQV9IYOKSEZSf3+2TBJ2ZuQlWMfW+GNAmQCZ5O33INd
 M0DN0RJWU9OTCXl/jLHuCL41cdiS1WY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-UrEKODt5PIyddY9fiXHhMw-1; Thu, 28 May 2026 09:21:22 -0400
X-MC-Unique: UrEKODt5PIyddY9fiXHhMw-1
X-Mimecast-MFC-AGG-ID: UrEKODt5PIyddY9fiXHhMw_1779974482
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8cc616cd846so104841316d6.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779974482; x=1780579282; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xZqG++Ij89AWvIFOLGP8qragGJGYt2xvFj7kIkiZc6Y=;
 b=hL0EicxQDT9Ma1uGcGaIxD04IwVB8NDq7rQa1gBdYhn+y3/vz85IpV/BgjBbJbP701
 uyYwEvsI04kCyNoBBlDEjg+uocOvaQwkCHbXA1TCBP7oar3AK5fX3sBf9wL1qHmfFbQq
 EcEr6iIBUQF3Cu8/FlUINoow9+qwyyOzJVCKM+6TpRRQN036Gb9RjnSv/DFoorchmJ/e
 0Hab2zaonJembkwDt1qfhi06r1SugG1OyQzxzTWucenR2E6GcrKV4owzNwZfSFv/4/MD
 kCI+cJnaJo/b7jzLRiB2xgyp8lrMvSXBJj8PhFlVw1f5H1SfyuuGcywmBl7f659GTqRR
 aFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779974482; x=1780579282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xZqG++Ij89AWvIFOLGP8qragGJGYt2xvFj7kIkiZc6Y=;
 b=rTt6pacfKJLABxXqNd5yQ08Axt1LJoYhJ09oFw2LaaSLaThWInEUkJAjbRvabpOh9S
 Qz7uqx/Qfh8eHvzC7t01HKwrZEpsIHy/GsD3A9oa5WSCH35vyE5fwYgg7t8xRbXMv8jy
 Jnki77r5Sq8tMPAsg69MoiNlxMkr+U/J8o29IvpmRYdTeeY+mjpuEoCwG/4EfvHkccKj
 s6bawnSs6ZggdsA89fKZnXCWJ6N2jEIpQL0djs0QOciX2cu4zbb5Drd31UyOUQDMD0aj
 PIxbV/LN8Jj6i5VRn8EJboP848ZeXvXFW45HBVi7EWXzEVnVtb0bAIyQIB+EZhUuxmpo
 13ZQ==
X-Gm-Message-State: AOJu0YyRllaYuj29yJcjfU5dZ3p+dGBtBmhs8bNbl9ffTiqdpjHlHsz/
 YL3lqWQLdgK2sr0oTBrJ2ALZR0qwznxO3POoUHtzWQXmYAZdYjkCXYa7GJusRKiIAJhg6Q8lSuf
 Jv+0BkcywvB3Tz5hS9GPSu8eINnTUTVgjy3FeVxCDEPMU7fnl+2OFzG+i
X-Gm-Gg: Acq92OH9cyvj3f9MKTNxcWXdY99ylp742G3lkUVvF/PnPLwaj0tyOeksDb0+wbv5L0k
 nQ6luLctIyTH07teZbAdVFl3Zy0NGS/Ak/eVABKcbzEcxbW+VXJzXdspQ5mMwAD9K/ZWW2iUdKB
 jX/frSWaMC++eXBzBw0glvEXtsz74zU6DcKaV1wCsvPv8TA9pGMj8L2gl7x/Z3pOP2N5zZlDe/L
 izim2ksS10NstikOQENHmB1lGHl/jJr/P0jAusDDwKlxfdsVfDZzV8qV2LIy+3Sd+PHZyK413zX
 XzCQ5vO5tLM5YM7q/1XCI24sjp1Ro/asKPGzraC5QwIOqLsomaIqQcL7kLvoG2ybDWOv1vg+pgE
 o8kjTXpZvvbcdk7mvn00ull+FRlwfdP0I+9dICCaZU1IVOQ5DEhrftBpcrw==
X-Received: by 2002:a05:620a:a189:10b0:8ef:12de:1337 with SMTP id
 af79cd13be357-914b49a1854mr2786415985a.38.1779974481664; 
 Thu, 28 May 2026 06:21:21 -0700 (PDT)
X-Received: by 2002:a05:620a:a189:10b0:8ef:12de:1337 with SMTP id
 af79cd13be357-914b49a1854mr2786411685a.38.1779974481178; 
 Thu, 28 May 2026 06:21:21 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm792595085a.12.2026.05.28.06.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:21:20 -0700 (PDT)
Date: Thu, 28 May 2026 09:21:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH 07/14] migration: Make switchover-ack re-usable
Message-ID: <ahhBT-2aDDZIno2d@x1.local>
References: <agy-q-MTVboGUY_G@x1.local>
 <9631bd0e-5c56-490d-a341-4ad4d5ae91a6@nvidia.com>
 <ag8cqIGtAfe80lKW@x1.local>
 <53cca60e-67b0-4ed2-bdae-6ddbaefc1390@nvidia.com>
 <ahRkT19AVwi4SQA9@x1.local>
 <f2c43343-d286-47a7-9596-8de2d5a6e5c5@nvidia.com>
 <ahXJD6QkXccf60Cn@x1.local>
 <c450e363-22f5-4bf8-9c04-896ccb02938b@nvidia.com>
 <ahcP9dtUqSAc-LAq@x1.local>
 <ac47e206-5832-449a-b46c-0e07527abf22@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac47e206-5832-449a-b46c-0e07527abf22@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 28, 2026 at 12:10:28PM +0300, Avihai Horon wrote:
> I understand.
> This could be a good direction, however, I'd still prefer to leave this for
> later to not mix things up, if that's fine.

Sure.

-- 
Peter Xu


