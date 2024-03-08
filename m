Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D01C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 07:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riUO2-0000jh-S3; Fri, 08 Mar 2024 02:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUO1-0000jX-I4
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:11:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1riUO0-0001Is-3S
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 02:11:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709881878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cbP8QbG5QDja4b5CnoiQMQQ3Uyieffs17o5kJOarEbY=;
 b=EMssHVYmebEIq31Ojv+4o+TpX+zbnw6ggMvMsZHG1ovzheCcw94fXyXHlljbEP7NvsXKPy
 WKRhRJwjJ18gzo2B6nCyaHYTzqmjdRdFIZiGhxAa+HoyIjvMIYY0NDmIXQZRYz5Fn2qmaD
 jRKwokqeKaI6YhCApY3gwHz9ARpkyuE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-B3o6u2pZPbWMv7MTv5a_lQ-1; Fri, 08 Mar 2024 02:11:16 -0500
X-MC-Unique: B3o6u2pZPbWMv7MTv5a_lQ-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-563de65ac5dso568483a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Mar 2024 23:11:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709881875; x=1710486675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cbP8QbG5QDja4b5CnoiQMQQ3Uyieffs17o5kJOarEbY=;
 b=gbUTGUQ4krRJkVh8mmJGrY4MFQD42DbrnVYX+HqtH5BTVuMKbqF24vbAXAEJL66JyZ
 6C60irQYAwdp0TG+TU2mrvEz+8m0QRxR2XALojHqOcMQK0QHz5oi52TIG3tAc3FyOPyh
 GxnsBVidu8o2ZVKUCrxFojzzINLEp1zn14FhG99fEoDbQWttn71gUmeANpMljhF2/9iC
 Rg6vHsz4v6lM6bc5tRdaT8YFZpU0/rbH5tC2uSkg599ls/XFD03Oihjonb0Sq7Ovrqut
 AemVcf7MeBnBEwGEonU7aypSwL1KEnf9N5IHZ4cUmBK8UXHWu9ej+MWOY2r8+xPq8hmy
 hmQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBq2EphCTP9LHwH1Xy4UefnilR007iMePiuF6EPix2/3Z28bPmzpSp8G+xC8ouoEos1nq67Wt0qrSqlG9Ygpl312qe5UQ=
X-Gm-Message-State: AOJu0Yz4slBBK+I9SmyqVileItUjg2OmIXUP7ebK21/WoKKQcblce9fH
 JG8yMgIssaPSGV/+MjB8YKEqGARLpU45PFprIGqnt0KJQ+3vlzLaYVfvaD4QwZA/yeiT+ATqMp2
 fmur3ApZJVt2CBH+MiZp8huquA6UsQTxwi5Z9yFvghQNJOc6MgeEa
X-Received: by 2002:a05:6a21:6d9a:b0:1a1:4de6:dd5b with SMTP id
 wl26-20020a056a216d9a00b001a14de6dd5bmr1617993pzb.2.1709881875363; 
 Thu, 07 Mar 2024 23:11:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVQJcswglDUQj4kpsS7/UaZizplirXBQP7SupxSpI4uvsHGVE6s+rjvcHBVLKLMwnkLuPBAw==
X-Received: by 2002:a05:6a21:6d9a:b0:1a1:4de6:dd5b with SMTP id
 wl26-20020a056a216d9a00b001a14de6dd5bmr1617968pzb.2.1709881875030; 
 Thu, 07 Mar 2024 23:11:15 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 u2-20020a170902e80200b001dca813b07csm15720862plg.62.2024.03.07.23.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 23:11:14 -0800 (PST)
Date: Fri, 8 Mar 2024 15:11:04 +0800
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v4 11/25] migration: Add Error** argument to
 .save_setup() handler
Message-ID: <Zeq6CP5IOxqfoq-r@x1n>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-12-clg@redhat.com>
 <669aaa46-0ed8-46c8-9684-fc4ccc485d4d@yandex-team.ru>
 <38414ab8-7b29-478c-9fc6-09804cc17842@redhat.com>
 <8930276b-c87b-4afd-b4e0-489dcaccc4e8@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8930276b-c87b-4afd-b4e0-489dcaccc4e8@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Mar 07, 2024 at 02:39:31PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > I would be glad to have most of this series merged in QEMU 9.0. So,
> > unless there is something major, I will keep that for followups.

Unfortunately I found this series won't apply to master.. starting from
"migration: Always report an error in ram_save_setup()".  Perhaps forgot to
pull before the repost?

It'll also be nice if we can get an ACK for the s390 patch from a
maintainer.

Cedric, would you prefer a repost before this weekend, or we just wait for
9.1?  IMHO we don't need to rush this in 9.0 if it's still partially done,
so the latter option isn't that bad (I've already queued the initial four
irrelevant of that).

Thanks,

-- 
Peter Xu


