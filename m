Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A604FC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqRI-0003Tc-Ju; Mon, 20 Jul 2026 12:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqQt-0003JY-58
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqQp-0005br-Ai
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784563285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ibz8iafZLo56gQNVi1pqV5SSJE2QgQr5rSEQD9+/XUQ=;
 b=IR58bWZsTy+J3/ieaqn7DWD8UUtuWbcT65hSfCO4TAI50EYbjogSjBLN1nWo5Vkxa2Cbgw
 F+wPK7dcL6dT4ZAhcOdOU8CqW1htRYD0qO8vt4F3BfZEVfArD9kx4Gfh8rmxPDkir4Yw5O
 uUhMbBYgUeYf1lFYumnLeC4IDUR6MTQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-dep3--yYO6K-3uHHGzAHZQ-1; Mon, 20 Jul 2026 12:01:24 -0400
X-MC-Unique: dep3--yYO6K-3uHHGzAHZQ-1
X-Mimecast-MFC-AGG-ID: dep3--yYO6K-3uHHGzAHZQ_1784563283
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e538afe65so1646184485a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784563283; x=1785168083; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ibz8iafZLo56gQNVi1pqV5SSJE2QgQr5rSEQD9+/XUQ=;
 b=c6KQqHrwv5Oyct0hMuAKTV3yInnWS2zonmMVyvWYH8WYipZN/SIRwIQO8Q8m1takbW
 U4wmehzg4S1kKRkcrzMwmsT4zYUGPhGEdKNQ7bwnDgYz3nz/Ip5UePQEl4EZ6yPyVZbF
 3ox+a4cEvQ1vQlENryI1W1pKg2ppDiipN7a1gmtocIstsyrIoUbaIZZKcMgQ1DFIHb9J
 uHm0GjVXwGMwgdVEhMMo/NSoByVab5H7w/fGmxWvn038x9VBzze3SuAx9XAoJ/rX8fg3
 uotZ7kDuOsvJhgsDit0TjTxrRyqhy7IQr0Dui05xCtXep2ngIBpILan6Z8f7ZBapgHkW
 HJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784563283; x=1785168083;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ibz8iafZLo56gQNVi1pqV5SSJE2QgQr5rSEQD9+/XUQ=;
 b=abx4k0vp8hYMBdOUGBNwd1LFNZcVzvDXn2quSVTAiWsS6Uuo/yJ8NlskuF5VRJAF93
 dRubQSlgCZcsUem1dzXRb0Iirue8uDSDKGjpmNqzI4JLId7oteapQOfxNNh581ZrbUDY
 SrW02qD/vLW1ywYZSmnm3hk++vyvEEc7NQb5upvS72nfX/5Q3CW5o4EAUjRh5YJ1eG3b
 m9tyXXuJNiFGGc241/o8tVG66nmG2KPwlD8XvMB4nSKP1JmvDJP62dcsmOITSrILpkfY
 kVFbKPgQZLnRuKCMcdL3VBYTRzn3IIiWUl+Mdc/T3b7qDvG6uspFChRf1BhOTjROrL6Z
 FGUg==
X-Gm-Message-State: AOJu0YwPhjd+yaesoua2I/s3Jh9Wa3FPZiu8v5E3kbjiRYvAen8lo3Ro
 l8TezDX44HhnqfQ5FLbo2jD3Lmiai0arfEkAGdkHXc8jfmSn5ZN2Ny6jzxD53Pb8mHdiji3GMOi
 io4WR2X/5kCRyIfuZGRGDnqc3EHE4vSEPVe2g9m0RIJhRnUgc2m2gCtki
X-Gm-Gg: AfdE7ck7riv7EXQXeZYOiDg3gMwRfslRkZh3BgV/rbD0xHSkSXJSDya2i1skvfxOIAs
 rKwvVjA8UAUN6t9StOj/wD/6qdG2tZ414YmgLy7S6dHNM6m4UNpeLESPZzcD5HAuy7Crcmn3e5t
 ZmRJ7/V7fZ5qz1apqjFrYurS9lA+TtUWuejQ7/5jjlpJtwAyOkxpc9u5LjuVqUU/8vXdNFWgUeR
 IP+68V9EhaulOnjCbfHtfaiC5c2FqNfP3W4tAMFZETUIx6YIhypLdg1MZZd7p3xE6WI6Ci0EyDB
 uu9XYO2/eXKF3X0QNGcXWkclFUtlx/zBfHBQGndMJZ6Oe5W6IMpK4fXAEeMZ5L1PlS+95qcazjr
 XfZ6BsPOyHbsGxvE2S9pKfhrlBTS7v/qbqQVBSgZ+fUdKhv9J3msEN80edok=
X-Received: by 2002:a05:620a:46a5:b0:92e:c117:5ed3 with SMTP id
 af79cd13be357-930b434d2aamr1565330585a.83.1784563282557; 
 Mon, 20 Jul 2026 09:01:22 -0700 (PDT)
X-Received: by 2002:a05:620a:46a5:b0:92e:c117:5ed3 with SMTP id
 af79cd13be357-930b434d2aamr1565320885a.83.1784563281818; 
 Mon, 20 Jul 2026 09:01:21 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b542b300sm931422885a.26.2026.07.20.09.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:01:21 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:01:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 03/11] migration: Rename postcopy_listen_thread_bh
Message-ID: <al5GToh6cagQNGg0@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-4-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-4-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:39PM +0530, Aadeshveer Singh wrote:
> Rename postcopy_listen_thread_bh to postcopy_incoming_complete_bh for a
> more robust naming scheme. This will allow fast snapshot load to use
> this bh funciton directly to cleanup the incoming state.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


