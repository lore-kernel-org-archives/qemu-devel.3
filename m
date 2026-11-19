Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195F606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BkC4TAwC;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=r0vUA0Vu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3KT-0003Ob-6A; Thu, 19 Nov 2026 09:41:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU3KO-0003M4-QO
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:41:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xU3KM-0002pL-Ma
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 09:41:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795099288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDVyGqDcN07p0+cR635/NxPXlpNdTMZHjjfRW2xZ6lM=;
 b=BkC4TAwCJYuFRjSyKs7UbFvxKv3Ag4FaEpzKYt+CKPoYKwCJvIrCKdKvht3o2VwyeokGdB
 uL4F/4R8Iw2xQqT6xYjbIHXQ+ul06MC1xEoD3AayvNNKOK+pVlOrnW/p5MAxDa1Ep538cO
 rJz5b9TC392UovbGnNhty2uCx4nr5UU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-2wp_fIYiMqeHks8Z24V_Qg-1; Thu, 19 Nov 2026 09:41:26 -0500
X-MC-Unique: 2wp_fIYiMqeHks8Z24V_Qg-1
X-Mimecast-MFC-AGG-ID: 2wp_fIYiMqeHks8Z24V_Qg_1795099284
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55d62b80650so7066191cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795099284; x=1795704084; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gDVyGqDcN07p0+cR635/NxPXlpNdTMZHjjfRW2xZ6lM=;
 b=r0vUA0Vu8O1wZDqx7oGNHv8mAhTN7FnkSWYUaM/JpTcy34UCz2ppIeB7HI2yBXxMjA
 0WzEQS2vXQxQU+2p2wvIDPWs2N/9kF0ec4NQcl5nz90HDscLYZPbNqZgpYdCPbyaQFHP
 8tBVKUTxVEp8iVtLcVx7ApJ3Ljrrd2SHAd45Y7eqNDj0vZIHNRI8P+FPOYqGjd3w3Msg
 otwNefA/diAP0mEsjSNJ6ZK69z7g9vxI+K/RdZcTaf2o2p1GvaGUsd59DuexElfYVHED
 GREh/0H79md5mBSQ10rj3ZduGaGXVkCOuCZQ3VgKaScYw7uY5jGLD7ClPBR0WM8mP9jR
 XXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795099284; x=1795704084;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gDVyGqDcN07p0+cR635/NxPXlpNdTMZHjjfRW2xZ6lM=;
 b=EPNeCwHkE9MF1i6cGYo7yNJUzYroiRD6deK+01whpAqkHdQWdGXHRRUIJx7rVOlL6T
 Tu/oSuJI5ekcN3A8nA0mWRHMPVThDg2OjbQt0cixIPZlsi+b9sq9nuocbd5uQ/M+GFtq
 1xZMU+hC6PyD9detgZTCl1QVsadzf8Z6U28cpQ8oLeqIY7/CurQUTru2jw3gUiKP9JRK
 86XeiVskglrsIXLocRO4cewXJwh3WZjtA65uxKPQiB918tW1m4fwjvsXRhu8jqLGgUfM
 wSuQIilS65X8rcImgvUuVz513WDCdmaP2DmN6UODN51Bhba9bBdM4jSMxGLM58cL4WCT
 tTig==
X-Gm-Message-State: APuU4Z8g3fXzgYrqYVwtbK6Y6bF1WsyBigP62/dMhu/MjUd8/cr/nY1J
 RL+WeF6gKp8frvZCS8vla2mUVmabx67+QwbLCQeMJJ14ccQytamOmA/76A3ve64eAgvKcSXUPBC
 QCoOpbBWGALM7BtRT3AgrOrDx7BkN5MAOMLErMIbUbWIGVHo+4GSjsh6R
X-Gm-Gg: AYBFou0CitUEf/yw2pXQr/xtGusS69PnYQfYkrumqeqaQDyfzmudfd0x6vCBsfivHTT
 SwpX+C/7927VFFMqFGYrZNuyvZTJJ9eK9W8cjV5xSG0F/Koh9QjAs2tU9BVEXaprGq1h/bKHiYa
 qcdA9NsLQoOrtwHzquLpKlhu+stuGb7moRfA/CaSO3rqkKL2+wCmklABIqB/Wwrs3eO9ERKfzv7
 dZDnpkhfzxC/5PxQGh+fvRM9QDIE00pUvlo1X6Rr5ZfMVpLiP5ZVaXQvYaK/BqwwjN5AXVF05FF
 m1p4HtZpFdsAiheibPK2NDWjSWMjzwyNCzHEKItzZnbGyhrvK0lukVnA7I/DDknYUEzqWEPSvIU
 kkYRMG5WpreAV4/smJvfFyNE7DudvRD4forUI5sVYNudE
X-Received: by 2002:a05:622a:5c06:b0:536:6701:213b with SMTP id
 d75a77b69052e-55d76aea6ffmr515441cf.75.1795099284325; 
 Thu, 19 Nov 2026 06:41:24 -0800 (PST)
X-Received: by 2002:a05:622a:5c06:b0:536:6701:213b with SMTP id
 d75a77b69052e-55d76aea6ffmr514651cf.75.1795099283573; 
 Thu, 19 Nov 2026 06:41:23 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d66b24b0asm24912881cf.9.2026.11.19.06.41.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 06:41:22 -0800 (PST)
Date: Thu, 19 Nov 2026 09:41:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH] migration/rdma: remove the dangling fd handler
 before re-entering loadvm
Message-ID: <av8KkWKUQP0LAtWr@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260904033130.276-1-getshell@seu.edu.cn>
 <179474329361.103840.4072531561797843442@seu.edu.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <179474329361.103840.4072531561797843442@seu.edu.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, Nov 15, 2026 at 07:48:13PM +0800, Hongyan Xu wrote:
> Hi Peter,
> 
> Thanks for confirming the problem and for the simpler suggestion.
> 
> I tried your version of the fix (remove the fd handler after
> qemu_coroutine_yield() returns, instead of inside fd_coroutine_enter())
> on top of qemu master e9fa1f66f0d4 and ran the existing tests:
> 
>   - tests/unit/test-coroutine: 13/13 passed
>   - tests/unit/test-aio:      27/27 passed
> 
> Both the normal fd path and the re-entry path remove the handler exactly
> once, and the stack-allocated FDYieldUntilData is no longer referenced by
> a stale handler.
> 
> The analysis that led here (fd handler registered on a stack object and
> re-entered through a path that bypasses fd_coroutine_enter()) came from
> our in-house static analysis tool, so I am glad it matches a real issue
> you had already seen.

I see, thanks for the follow up, Hongyan.  Will send a formal patch.

-- 
Peter Xu


