Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542EDCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuGN-0001gb-OS; Tue, 12 May 2026 17:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMuDW-0006ew-J5
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wMuDS-0006Fi-NE
 for qemu-devel@nongnu.org; Tue, 12 May 2026 17:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778619632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cl5GtVkuCm028wcNBDcoYqLwcdXWof7um/uVpwFVugI=;
 b=LIK5YZBBhrjw/mTQYg67xiRcfF2mf0K7ff+eP8PO5MfvxBS+krCh2qzJs2euDnwYrY835F
 HyRff+cHa6XEEzlyelFm/hqmPVn2/s+IBVNswwJxfSKJAknHvwauA+hfaBoz+Q+3P5N35V
 /u0GW3jFd6hEBbecpKgn4RWg9+lq2L8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-wJtmMloqP1-HMQ91zMvu_Q-1; Tue, 12 May 2026 17:00:30 -0400
X-MC-Unique: wJtmMloqP1-HMQ91zMvu_Q-1
X-Mimecast-MFC-AGG-ID: wJtmMloqP1-HMQ91zMvu_Q_1778619629
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8b1f4478ca7so43065546d6.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 14:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778619629; x=1779224429; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cl5GtVkuCm028wcNBDcoYqLwcdXWof7um/uVpwFVugI=;
 b=YYJdNARVoaUECcKYj3NU3YgZ8rQba5tjqktLrqHebvkg8NHlj3oMDp0NkL9K1X4JR4
 4F5KcRDIi/p0oY6KrAXzQym6aFw5vdVInMrYgrqzeZNiaL07jjSp1oWAAC/3XBBGRqkf
 ZpF7htOvZmQLm+IyEPQYorPsuHj29U6hRhtqMhXLun+l+kEV+0rE+LyJ7bJx6b6zN1ON
 P1qrVjy2Di37ClOjtTnH43bDBzuDCHM1O1jriqfVfVSR8MvDJTNNV2Ozd+3/jsbPKsw9
 4zlGKyWpA3gLBzPRqcMT64LbcJbVwka7C2Mn4+n6Pv8dWbSHwfeD2KZxxyTSagYsK5x0
 HCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778619629; x=1779224429;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cl5GtVkuCm028wcNBDcoYqLwcdXWof7um/uVpwFVugI=;
 b=OLgHn8MJLoTGBrbka3YjpzCNkJ+yh/qjQgmtuapP8nnkga6fuTh0wxM7tc2ZNSahLu
 /Wy94cMIucIiNwpbTt7BthK63/lnNeLc51KRTzZNzok3s1Y7n3+1vHTCVuEB2goFUZWh
 nSrNbQfwoO0ecsMaf7vP4MQwBwp1AVhAWavSxCZ/ToKFYDKv/mPHuzCjYeEfzv9ml+11
 lA6IBoAFgPbWWkU4WXJXO9GgYe8Zy05VVpU8HHXZdy/kL8MuQ8+Gg1CPSet2OxcPC5lD
 snu8pVSKSQDcvZ6I1x2qgSr+/e0yosSTkZrN3jbjWSIPxIiU7i54X+0+AZNFSszBhBwm
 G36w==
X-Gm-Message-State: AOJu0YwmzFVvOe1u89Rq0VAgFO/qZJHahqzy7MKzlZF9Vu4Ks8oPK+5k
 1WPLWNy/L1ycHPzV81uxOFp+pAbCGY6kypmakxHKWX5+IGckKub/sj+0qg5BLoODBnSkddaM+F7
 o5F2Wn8p6m4kiA9/7QgJvNm5eROOkkibtKPhYeph/d2c/J0Fy7s1nmO1K3S4DImX/
X-Gm-Gg: Acq92OEs+ZuUIzZmv3c9InawdsMb8GcXIHIKQZUtde6eSE57zMWmtbsDOy3hWGPQVSE
 7i9sK0S2kwuFT29qga1QHvab5QgT5SJOPdhy5ML8+jAKa4kEAjsSZGogyhUeTgFynIf/OvXVOZH
 eHhtXBha8bmEo3a3lb8BKCAOkYcndPFEGrt+lFY5rKf8S4zoxref8RSLQlGkMQquOYIDHwwyKDi
 +RlZJmtw0RNi9h4O/5YXdaU4GZOgpuap6xQSF4Fk08k80NWb/lPUSu5ja7Soo27wNBqASFqUFmB
 EjXdj15Tyv+sUjNeez3/cUwGo18JvkTRv9pDAVKCBYjp5R+CDTyIKvfIk2nUNG1Bi6NTnj5Q+Cq
 ndrY6WBQc4jxzVcuqbIAQltvI6AzpZ9tyvmbiXP6NQ1OxcsU=
X-Received: by 2002:a05:6214:76d:b0:8a0:d08c:a720 with SMTP id
 6a1803df08f44-8c7ddcafaa2mr1213306d6.17.1778619628255; 
 Tue, 12 May 2026 14:00:28 -0700 (PDT)
X-Received: by 2002:a05:6214:76d:b0:8a0:d08c:a720 with SMTP id
 6a1803df08f44-8c7ddcafaa2mr1211836d6.17.1778619627600; 
 Tue, 12 May 2026 14:00:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8bf39c7e2e5sm134017706d6.34.2026.05.12.14.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 14:00:27 -0700 (PDT)
Date: Tue, 12 May 2026 17:00:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v1] tests/qtest/migration: Fix auto-converge test
Message-ID: <agOU6ZZ3k95TtCIG@x1.local>
References: <20260512141338.10089-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260512141338.10089-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, May 12, 2026 at 11:13:38AM -0300, Fabiano Rosas wrote:
> We fixed the cpu throttling sync thread affecting the
> dirty-sync-count, but the test still relies on it to gauge for
> progress. Remove that block from the test with no replacement.
> 
> While here remove several incorrect or redundant comments.
> 
> Fixes: 9519d3667a ("migration: Move iteration counter out of RAM")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Oops, thanks for fixing this.  Queued.

-- 
Peter Xu


