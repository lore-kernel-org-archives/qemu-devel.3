Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50301CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCNva-00035w-Ui; Thu, 01 Oct 2026 17:02:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCNvX-00033Q-Li
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xCNvV-0004AW-1P
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 17:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790888567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0ptN0M2cXZD1gUZtlL/pe/IV8XzJqDkdXmfX1kg/cHs=;
 b=KjiXsaiVYVv5dFgUfutuj2azrFujBex6/NpDnROdfxXxNCG7dEWh+bN7UbEhiUaPjMJICJ
 FIlps9k+X+b6Sdcmdv38T2IT7zuPxMf4VP6uKY8iFhvD2U5dDtWrhEu6VB8P49Y5H3qJum
 lvJF+Pbv+1k5ItDk922iKZ5KHNsvlps=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-1TUttpGuPkWB9asRL6Nk0w-1; Thu, 01 Oct 2026 17:02:45 -0400
X-MC-Unique: 1TUttpGuPkWB9asRL6Nk0w-1
X-Mimecast-MFC-AGG-ID: 1TUttpGuPkWB9asRL6Nk0w_1790888565
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93ca4a2b9c4so450794785a.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 14:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790888565; x=1791493365; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0ptN0M2cXZD1gUZtlL/pe/IV8XzJqDkdXmfX1kg/cHs=;
 b=sBOkEGqrcRFeQiVHvSgq6wi/EqoluCRoW+cDZUTgU9HOK/XbtfBhagduckiGuojNhq
 xzhVN0HhXM7ot0wkqcWhGsbVgFMwnv0LSAVdXBlnSnx2L9j37I+RZYahcaZL0+bJf8jM
 qLSW1t48MBYNzyo5PtqiwxknUvXhl1WQ/ljhH6qEq6BMEVaoqTb0a49Ai51P49yENuWP
 kyoshVyJN2t2HCAieiwJDVtKwXiqlJxZjggChQZDTq7fhoZjRDyKFVH+gVnrykOLpqn9
 I2SO50hWOIVZKMPV5JmGp7M4KwA6P1QVyCTRbKkQXZF/RxlKnsWp7r4vj4OgNvG+w8sB
 k2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790888565; x=1791493365;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ptN0M2cXZD1gUZtlL/pe/IV8XzJqDkdXmfX1kg/cHs=;
 b=xJC2sFuDi7kKy9zdPJIWcEFJ8MhMeSQBDksxreR/C1B7PYRsei0QykZkmlXUXeqX0e
 +JkNb8yCUBpXRmWQNJE+KvvoQ3YA3tr2KrRwzEFdBow+E1yD8SpEbFt/VunnMdgYKf36
 zV5jQuuB7B6i8xJY5b9koYKqBYwZjDfuypQ4jhSjwJQX9KdgYQTlpDdb4MQ/6Q5tCq64
 gTdUORmc/ab1XMu7teITS3LR9t/RrGlEKcnqJlfEdClYALxgZhRN71E5p6go49V2d+xW
 Foh1opT7q1JSRZ+TVIopvmLVJKf8P8oOyAtDL3Fd869CgIHYXtl9o2Vi7nMtFhdA1zXZ
 nP2A==
X-Forwarded-Encrypted: i=1;
 AKwUvByigVRxRGRnNzBQyR60/0c3AWT88JSOR36HkeVSm+Oby9nGXvxFpl5Q3b8wUkvZ9zS6ypnVibMQc7d4@nongnu.org
X-Gm-Message-State: AFuF++m+TbFpYAOlC92hsuwXlxtzMvpUvQ+MQEtjI/WUGIxPQWXIiznS
 p8reU6QGyUnV/+aAYbWV7wdNbrSzyvJqvOGZx24rWdiWYBBWucKyJHJnK0UXIyQ3BcBraK6651P
 NZ1RGdi5mNyJAQ5yXRB9IZ2N2ssigRxlJKA3xHvb8D62C9Zt6PH5xV+2H
X-Gm-Gg: AYBFou2FtFO5nMtK4KsrQPlzmXaaDt3ytkcr08+LCweXqAa1Hdud3JXGICaKWC3Eur8
 vY7agSH40FQ2343Ek+UGE9ocPoUc0KFc7l3haii79hUuIWE48iC0yV64vbulolAeh7dKe4xL1YD
 x7IG3Uk6SpwVUI4mWShSJL/fzQUw6KOuWcHFUXKViXdmWIMWDYNHkdEerWCq+8kkMTSX29WVAZQ
 KN79gI+O3QrSOVYl4AObDr5aeN2f9BXw0/MRNTiY7jLuaYxhqKW/LKsvPTKY+80HslWrY35gyku
 od7zqiC9/4Bb0cJJRYIO22I7nGSKcAVwuw5eWZWgunQqC6ob0CJ4U54QDWo+0s+1ew7flOc=
X-Received: by 2002:a05:620a:2585:b0:93c:6e96:5380 with SMTP id
 af79cd13be357-93cf18c0f46mr79462385a.61.1790888564839; 
 Thu, 01 Oct 2026 14:02:44 -0700 (PDT)
X-Received: by 2002:a05:620a:2585:b0:93c:6e96:5380 with SMTP id
 af79cd13be357-93cf18c0f46mr79458985a.61.1790888564382; 
 Thu, 01 Oct 2026 14:02:44 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93cca280e59sm47112885a.35.2026.10.01.14.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 14:02:43 -0700 (PDT)
Date: Thu, 1 Oct 2026 17:02:42 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH 0/2] migration: defer a post_load which only rearranges
 memory
Message-ID: <ar7KcuM6mEpvqdM5@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260911142345.3999518-1-den@openvz.org>
 <ar64sJucQdmgu7mB@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <52ae1c53-5c97-45eb-b183-7dfea81e8ecb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52ae1c53-5c97-45eb-b183-7dfea81e8ecb@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
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

On Thu, Oct 01, 2026 at 10:14:20PM +0200, Denis V. Lunev wrote:
> Right now I have series staying at 32 ms with boost to ordinary
> QEMU startup, that is why I have said that I'll send follow up.
> This patch will be included along as flatview rebuild on startup.
> 
> Anyway, right now I need to understand and eat your notes to
> send v2. This just intersects with upcoming release of downstream,
> but this change is in my priority list and I hope to finish
> v2 early next week.

Ah I didn't notice the other email when replying...  Take your time, feel
free to take whatever comments still makes sense to you, thanks.

-- 
Peter Xu


