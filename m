Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DAFDCD6E79
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:03:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVW4g-0006t2-8B; Fri, 05 Jun 2026 11:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVW4f-0006ru-1K
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:03:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wVW4O-0007f9-Di
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780671766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1fqerfuyomsVjlxvszMD3UGgLWv8i47s8BdIXBHk9f8=;
 b=DEFThgk/mabnEmXBreQIWrSRpAFR+1OjsepYIwxlanyXS6IT5UYDFsKcHkEn8rNFD1+Sny
 rTug7c0edqgmz5fMG5yVbUhSasa1v2MlQbYbCCCDWyKXIV7ercEfyYkwWVybSqsMJj8zHA
 P+4BsMHs8kVKu39nKjbxUITIsbNaIeU=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-LKoLyR1INPud1a2WysZkDg-1; Fri, 05 Jun 2026 11:02:44 -0400
X-MC-Unique: LKoLyR1INPud1a2WysZkDg-1
X-Mimecast-MFC-AGG-ID: LKoLyR1INPud1a2WysZkDg_1780671763
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51775f7b2afso59145851cf.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 08:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780671763; x=1781276563; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1fqerfuyomsVjlxvszMD3UGgLWv8i47s8BdIXBHk9f8=;
 b=sOF7AZ9+GASnJsovUWZDGGv7tl0ut6UhFwXMGRk0HGgfEMapKEo3phyBGDoxBura3K
 stXEOvXV24xxfCOoZI5lPKC2NoiuIzAH6pXKrXPaPm6RxQVoxIjUbXT2FZOAvgZin9Fj
 M1VqBbRkfreM82Z1a5CxHWPQh1/T3nAqakNo+S/AmuUBxVBb1Xg9GUvPD8912urRo8zh
 txHKtnCL4m5//TFGnajNoxbzf/hdT0YjeNYn7/tmlH67myhu/Jr4lgo7v4g+SCht1uum
 QKRfrqDH/mHzRnhXBzAU4HjpJ7H1DWn+RcIqnTsIgF7HZQXGHh4QzIxt7KdKft4+XD4J
 1EjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671763; x=1781276563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1fqerfuyomsVjlxvszMD3UGgLWv8i47s8BdIXBHk9f8=;
 b=lUpg0wpO1lrwV5S0c85MS6EmCticBITBnUNDzdL+dtc+q+IM2bfN+iXXuQaBkCp3CC
 FKcU3OsUysCGCJafeeeHKFsTTEjBvL0Ayq9upD+Dq3EaLU/Z1SBpOCjVI9ZmtJxe3tyz
 yF5uFYQL+Wp6GT02FojUp6QE+LZmtNjFrLKOaAuQVxzKLbgmmdCjDrm668GpSBmU4CPk
 9te+Naj4r2I25QEjQ+H6w7N1KM4e330fRECq6abXxiNK6knfF4wrL7McVjOWeFY1gnf/
 imH1NyY6Ziz8BePhmS7/1lA/+wE9fQ15ns6pBcAOLBAtezCYZbjAYZ9MCPpT3TYhCEzS
 hhkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hq2jKPYmxxd6HMEVdwQT4zzWG38cBIRSzC4PHJVvV2BMnZFFap+NMDYHitiN/z3pUFyc7yyIp0bJh@nongnu.org
X-Gm-Message-State: AOJu0YwrnFLD3jH8qdsX304CHBW4nTaLGWn2sgYBkv6i0RQ9GrQgtD3t
 Y4k9dOC65R9XJicMFZ+1KA+bH2hwJI6C+kWsAo+gR9yD9db9CcvdkuD4U8WUHDFkUbaMBp9yKnb
 zkoQpsfxoH66JkMYD7oYrW4FVfcyJj3M7qfhHVi25CfXh+fNE9WtlPnpV
X-Gm-Gg: Acq92OF6dLAA+Pc1Y97HP4sfgAfhm78Aa4neM0yMnFqWVZnq+PVCwqKPXfkz3v4Gd0O
 /4XfhHtqxpzAfCtV1qKSIiu+vrGc4JZhG1l4pmuQHIknmcPjEa4wSAhVyE3Wt/yCkIpz6lv7Mqx
 WMKWMqVsGGZmLA3kCMvboEGkWDUYy2HkQLRXIa7nBOOX6cjrekL6689qjx7IK+8SZSMGBQziWGZ
 g+WW9YEelBaZvfjCEADECUrLUeFwyrTp44biEYuv339e6016gOqlmlMPV1nfyw097PzDhNSRw6x
 hPl2q55FWPWDmACkCmK7GsK0CsnjGa9VMzTmBrG5jkFTaBlbGwzVR2IgW97MKQR80ZZ8WKEZ6kV
 Spkig4XtVvmdgZ/xGgo7n2YHXiQ==
X-Received: by 2002:a05:620a:2a0e:b0:912:5d2a:4bd1 with SMTP id
 af79cd13be357-915ad37f751mr374301985a.40.1780671763362; 
 Fri, 05 Jun 2026 08:02:43 -0700 (PDT)
X-Received: by 2002:a05:620a:2a0e:b0:912:5d2a:4bd1 with SMTP id
 af79cd13be357-915ad37f751mr374296185a.40.1780671762693; 
 Fri, 05 Jun 2026 08:02:42 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a3eea49sm903062585a.44.2026.06.05.08.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 08:02:41 -0700 (PDT)
Date: Fri, 5 Jun 2026 11:02:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Mark Kanda <mark.kanda@oracle.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Jason Wang <jasowang@redhat.com>, Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH RFC 0/2] migration/vl: new -incoming config:* for early
 migration parameters
Message-ID: <aiLlDtW1APCCcQwY@x1.local>
References: <aiBNXUU0xcT_UbKO@x1.local> <aiBhTTqSctU9lFsS@redhat.com>
 <87o6hr7brx.fsf@suse.de> <aiBrp1UJZjmC1aI1@redhat.com>
 <aiB2nA5bmtBRWras@x1.local>
 <21a05595-0266-4755-8a99-29a85b9da2db@yandex-team.ru>
 <aiG9Yn5My8LoTraZ@x1.local>
 <fde9e6a3-9aef-4c9b-8458-6b135cd60598@yandex-team.ru>
 <aiLYTYTb6TGY2Fgm@x1.local>
 <05261ed1-0b81-4099-8286-0ac727287a05@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05261ed1-0b81-4099-8286-0ac727287a05@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 05, 2026 at 05:37:03PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hmm, so, may be, I just go this way for my series? It will just work with
> these two restrictions above, which is OK for me. And no conflict with
> new "-incoming" design.

Sounds good.  IIUC that's also our original plan to make it experimental
and see if that can lands earlier, so no worry on whatever happens with
this series so far, feel free to go ahead.

Thanks,

-- 
Peter Xu


