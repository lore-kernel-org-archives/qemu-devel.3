Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0895CCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 05:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDbwp-0006Oz-KK; Tue, 28 Oct 2025 01:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDbwn-0006OW-30
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1vDbwi-0005gG-Aa
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 01:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761628113;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=VGW1/Zk/bvozkpRgLkqGOHGHcGKL5In8js7WQYsRL5Y=;
 b=BgXcwToHfYzye3swsX9cdu2LZ/j0JKoNiXrIh8kdfvB4oyXCnyuwMVOn1wBOJxPll2L7N4
 HTecNRioBGjyWjTWQxASOL5GuZSuyPUstI11hTqBuk7NvtKX1Ql3QH3llPxBaQJtAjC5ze
 AC0VyPcCtfL8ebGzF2zGNXBWwaxzUCk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-vEyAYCUCPB-rIMnzUzPUjg-1; Tue, 28 Oct 2025 01:08:32 -0400
X-MC-Unique: vEyAYCUCPB-rIMnzUzPUjg-1
X-Mimecast-MFC-AGG-ID: vEyAYCUCPB-rIMnzUzPUjg_1761628111
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6ceba8968dso4009570a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 22:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761628111; x=1762232911;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VGW1/Zk/bvozkpRgLkqGOHGHcGKL5In8js7WQYsRL5Y=;
 b=CdwX4Kp7cMsWyHjRg4by6sMpC2UKGC2J/0mbFmeBWjlssG2W/Ol+gWY67UDWsnPLLK
 kEH5+at0lxdEaMLCmAnzHLsugaonnT2J/OGrmNs8FOS2HKoMFyji+b2IpGIcba8XWIKE
 /KeP+ScrDRKHOoHoG+5LMbFy7v/6JfRMSjVJ8FJvw6YQwkEDSaPTOqRwOiVf5iGnUnQu
 Z6ykVHBygdKJhvQWGR+w3gdlcdmOjVXMfAW42z58nzjneTQuNcH6kjR3oQObprFdd5nd
 DVw2Vo7Aw/tmJ4VqMAju0OVItZknnX8+8oh31VLLhDS0WawDIDB2mzOcfx6q4cUoX3gD
 x3TA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIs2GBoKLYzOP9afbw9K/L35onYefAGzabqLCjmXGGeDcvHtDQSaaGrCPTOgDObjjOBi4vuJDQyb8u@nongnu.org
X-Gm-Message-State: AOJu0YzI2YWA5onyCwrxszk9TNbMaqjMVWoXJRDai0b3UFrwZpRr7l9p
 tKtwsQXnVYy5KVMn5wAxAOmW8Y3vmjaBvGJA3bmI39OOOc175wLLFUIrdCYzbE93mla8NkRTsAL
 kaTkD5K6HE2cHDAjs7OuZZXaJBgYh6FajbDK6TdNUJl2pH/Aath81tGWS
X-Gm-Gg: ASbGnctWWX3SQMPuYpTGQBkZpsToTpi9YZM9dDYKisHELmh/KYfCsB+7RZRFkZDZi3J
 N9iZrpTUKy2K66p4P1lh/kmA47Bguq1sLoG7lcFSswYatfpCldZWP/O6AfyzJbFx48ngbL8Zwrt
 2PBKjLVF5p+gxNPQAGs74FzEjYITYcZ4i+gwTUhv36e3NgcRVPaytDmVB6krhhp2d1TXwUZ5PGT
 pVXG1C96qWtTrexMh/wkftvSiDuT9ISGz/Hd+2OGqhuwlnneeNZNO2GLW/3aVSw1STUJMquDcKS
 OFbQ+zQM/azvrOVhBla4Ge31+8sIzZMPD4hhWy8n1hUbxaocrhKC4139M+XkvWsbseSmfBjpMvB
 zRkhDmnC8nhUS
X-Received: by 2002:a05:6a21:3291:b0:342:d58b:560b with SMTP id
 adf61e73a8af0-344d4036346mr2996460637.52.1761628111042; 
 Mon, 27 Oct 2025 22:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJbcg4wwvI9URqDDFgNFYsVlVvPgjhyQfz2iBps+iZbhILSlZBIBd8G8tVyNhmOnwzYE02mw==
X-Received: by 2002:a05:6a21:3291:b0:342:d58b:560b with SMTP id
 adf61e73a8af0-344d4036346mr2996440637.52.1761628110659; 
 Mon, 27 Oct 2025 22:08:30 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.108.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b8087fac6d5sm3683589a12.15.2025.10.27.22.08.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 22:08:30 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:38:23 +0530
From: Arun Menon <armenon@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, peterx@redhat.com,
 stefanb@linux.vnet.ibm.com, farosas@suse.de, qemu-devel@nongnu.org,
 berrange@redhat.com
Subject: Re: [PATCH v3 4/4] migration: vmsd errp handlers: return bool
Message-ID: <aQBPx3B4ynruu5Qn@armenon-kvm.bengluru.csb>
References: <20251025202649.1122420-1-vsementsov@yandex-team.ru>
 <20251025202649.1122420-5-vsementsov@yandex-team.ru>
 <87o6psocib.fsf@pond.sub.org>
 <9f5ba3d7-3103-4d2a-b50f-f8883a18c812@yandex-team.ru>
 <aP-eHzbAtvNp3N3d@armenon-kvm.bengluru.csb>
 <2699d795-25b0-41ce-b884-ce1a357a1417@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2699d795-25b0-41ce-b884-ce1a357a1417@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Vladimir,

On Mon, Oct 27, 2025 at 11:33:22PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 27.10.25 19:30, Arun Menon wrote:
> > We wanted the new errp variants to be structurally as close to the old
> > ones as possible so that we can perform a bulk change later.
> 
> Still, could you clarify, are you plan to do this bulk change? Or it was
> a theoretical possibility?

Yes I want to, when time permits. Most of the post_load() calls,
just like post_save, do not fail. That is the reason why post_save does not have
an errp variant. They always return 0.
But there are a few of them that can fail and return an error code. I need to figure out
what would be the appropriate messages to set in errp in those cases so we
can propagate it back to the caller.

> 
> -- 
> Best regards,
> Vladimir
> 

Regards,
Arun Menon


