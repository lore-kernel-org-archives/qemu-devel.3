Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF576C48291
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 05:53:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWruU-0003wE-3l; Mon, 05 Feb 2024 00:52:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWruS-0003w6-Rl
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:52:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rWruR-0001d7-1z
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 00:52:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707112366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Hv+G+kIb2ny5tdvCXp4P28L6GTubDxqqGRlCPeCduKs=;
 b=eQf1Is39TKh8OpuCQUbS+Drp94zR0X5+//GBmwwDd+fkDH1hidp/mTCWAK3KFsKZYs6nFX
 e+cRWlMAnzDc6IeoWU38vr82tJJNQonzvH6rqWvf5X3P8LMUS/9FwYZeviUuLbbEKxVSUt
 1DiJtQpDryyp2Mayjm+q5PtTdaTNMl0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-MtleM8fANjq1oM_F_e1tmQ-1; Mon, 05 Feb 2024 00:52:44 -0500
X-MC-Unique: MtleM8fANjq1oM_F_e1tmQ-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-5cf8663f2d6so1286042a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 21:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707112363; x=1707717163;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hv+G+kIb2ny5tdvCXp4P28L6GTubDxqqGRlCPeCduKs=;
 b=FnQZhSI5cFp0k73XPsFaNk6+MuV0IPD1U+yG/2bNKyee0KYkW6h6KKoeA61e8XyIgl
 3RUP0ZgWucvKZyn5eYrYlQ6MfXt8cNynf9ioqgdJfeinnAtJ9Qvm2ysDd/kvVc/jK5DB
 Xflg2iDMj8OeorcBHqbFOEAKD5rS/8d0O2a7ozSfWxEexfPbBFaj8RVVeo42E5KRIXSq
 h77JmYyYpBcngRrnyHNCHOL9fssEGyZjbd4afbNZfCDdxwl/1tezvv35bHOq0zl1CjTN
 CZGmguq2gYUHPyWVV6Yywj1bMP+7eKrd0JNAAbtX78lpgWijTrXTYTdhuqzfFG7B79Zo
 OPcg==
X-Gm-Message-State: AOJu0YxuxiLrO7GcjHQ9Qwn8VEemvS+GVuDjoMH9BK4Zr2cocH2h48PR
 LRnmR42aKDuogLDSx6TSy0eLA1BK2uUPshyUvFDiUuu7pYnf/biYGKHp51wriPXkqixTv5YgdMj
 MyMmP9GK2YJgLzBGH7CikHfb63zG2+HA33p/3hGEqeU7/wDC5D33K
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3390:4a42 with SMTP id
 v12-20020a056a207d8c00b0019e33904a42mr14737592pzj.3.1707112363495; 
 Sun, 04 Feb 2024 21:52:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqsQfrIFMWPvCd2cEhVuXrytyT7XfU17od5OAZcM3Z9tOAsMF7IRPs4BV42ifwGJqLWo5tgg==
X-Received: by 2002:a05:6a20:7d8c:b0:19e:3390:4a42 with SMTP id
 v12-20020a056a207d8c00b0019e33904a42mr14737585pzj.3.1707112363172; 
 Sun, 04 Feb 2024 21:52:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXe8ge3OtgrmkspEqYNM3SeBjr8th87TI5QGq3/+ku53lLaBua0zQk0nF8vMAPtt4G+tz98qyS8KK1FV7GlCKbFT7M=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 c9-20020a170902d48900b001d9557f6c04sm5328208plg.267.2024.02.04.21.52.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 21:52:42 -0800 (PST)
Date: Mon, 5 Feb 2024 13:52:30 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 3/5] migration/multifd: Move multifd_save_setup error
 handling in to the function
Message-ID: <ZcB3nobOqOIjvDu7@x1n>
References: <20240202191128.1901-1-farosas@suse.de>
 <20240202191128.1901-4-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240202191128.1901-4-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Feb 02, 2024 at 04:11:26PM -0300, Fabiano Rosas wrote:
> Hide the error handling inside multifd_save_setup to make it cleaner
> for the next patch to move the function around.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


