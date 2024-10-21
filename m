Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7EA0D15DA0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tXZ-0006O3-Nz; Mon, 21 Oct 2024 10:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2tXR-0006Im-PC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2tXQ-0000BB-3s
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729521458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DGG58MRMoRut+ITE6U9r4TeTOaQN1xJ0tw0yT2adSc8=;
 b=IqB3Kuil3MDF5aQaoqVClVYaucb6g0YbS2lwkjfTBmDylmrBaCGY8qx4tn3fMfSl0jjZ2J
 qR9lqHGasBVotqOIKZRRjiYqNdayXjgAAHhRnJx0pyazSJue/9Ht+xn1f/8Qs8+FdtmDKq
 7CTwJgIeue6mAWRQgrb3qBViTwhWy1s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-kjdNStApP6mzGtn9tvrkUA-1; Mon, 21 Oct 2024 10:37:37 -0400
X-MC-Unique: kjdNStApP6mzGtn9tvrkUA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-460c6731ebeso40333921cf.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729521457; x=1730126257;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGG58MRMoRut+ITE6U9r4TeTOaQN1xJ0tw0yT2adSc8=;
 b=rNLkfHdDWO6MA2rUXqzMZ/qbDf+ggDMRn7TBn5Wz0lkztWPnHtObXdAMnMyNpCcCbo
 BmLN4TL8jRhA9JbLoVgzIS4F27SzS+FMVmsHH1eh74jpVVV8D7p5mVdCuK3VPTwnmP/n
 GfmVa/6jaE3pY5IfhqkJ9Wy5khFG8M0U2yYlErKPxcs0rlp61DAwy/cGGs1EUzg2Uvyv
 6hGjTJtF8i7Tcnxei/cgXu7otvafBcomCiTNelJDoLwOmhtrdihdJvedk9ZdDTsfiWR0
 lQZCqCOLn8fyZhFYTAIlMVudr8XhkzKzFwqc6qKCIGr1m9sFD5GmHz4Bfzd9k4OcdI4k
 GfPw==
X-Gm-Message-State: AOJu0YyphbfdCzvlZODQ2KttfyS+DDissMoxwNrLvmFCoiMZdc/vU/dp
 6YscSHOdf6T+IYge9nGNL8LzcKEiTLZaPUIMop7o9YWCD1BgtAhFjHS19nYA9zs9T4vEHEed7u3
 TCRz2MOixT639TPpXWG2ZV3vGJToPu8B1yqRwLji+3HKUgPVyRmel
X-Received: by 2002:a05:622a:2cb:b0:460:a928:696f with SMTP id
 d75a77b69052e-460aed7c445mr174772911cf.29.1729521457017; 
 Mon, 21 Oct 2024 07:37:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9WA+0P6WjODh6M4w1hwN3w8W/7qKz/1M9xdcMeWi6gqL7odr+Xifxc7nmugg0EkxlAbZnEA==
X-Received: by 2002:a05:622a:2cb:b0:460:a928:696f with SMTP id
 d75a77b69052e-460aed7c445mr174772681cf.29.1729521456709; 
 Mon, 21 Oct 2024 07:37:36 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3afcfsm18205001cf.5.2024.10.21.07.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 07:37:36 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:37:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-stable <qemu-stable@nongnu.org>, Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: Dynamic sized kvm memslots array
Message-ID: <ZxZnLXD4w2HV07gJ@x1n>
References: <20240917163835.194664-1-peterx@redhat.com>
 <20240917163835.194664-2-peterx@redhat.com>
 <52cc6540-b1ff-495e-9b98-98f13ecbf380@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52cc6540-b1ff-495e-9b98-98f13ecbf380@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Michael,

On Fri, Oct 18, 2024 at 06:38:53PM +0300, Michael Tokarev wrote:
> Looking at this from qemu-stable PoV, I'm not 100% sure this change is good
> for stable-7.2 series, because 7.2 lacks v8.1.0-1571-g5b23186a95
> "kvm: Return number of free memslots" commit, which was a preparation for
> for memory devices that consume multiple memslots.
> 
> I did a backport of this change (currently it is at the tip of staging-7.2
> branch of https://gitlab.com/mjt0k/qemu.git) - I had to tweak context and
> also to remove now-unused local variable in kvm-all.c.  It builds and the
> tests run fine, but I'm not really sure it does what it is intended to do.
> 
> Should anything else be picked up for 7.2 for all this to work, or should
> this change not be back-ported to 7.2 ?
> 
> (for more recent releases, everything looks ok).

I don't remember anything this series logically depends on (besides any
context-wise change).

If there's uncertainty / challenge from backporting to some stable branches
from your POV, we can still keep things simple and skip the series, as it's
only a perf regression and only happens during live migrations (which can
enlarge the downtime, for example) but not daily VM use.

Thanks,

-- 
Peter Xu


