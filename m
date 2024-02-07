Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DCFC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 04:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXZUp-0006Ls-JA; Tue, 06 Feb 2024 23:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZUn-0006LS-Uy
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXZUm-0002IJ-KO
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 23:25:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707279910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UKo2MUjQpc7UsBQTgO4yTvFrzKDUqeIb3yvTS0diUfc=;
 b=bsIAOXlErlEXoBBTMyEzoGPjCPERooP2vukD4lKzLsHTS6dh2ZMtNEhLKyp7IrbVPbubRi
 Oder3qRFNI/ugdaFTl75U4LLbhG8pIceDmYjN4HcJuiSj9XTiag2wzEANQALbjCzwTIpPF
 McFAVVDZDRj64jKEss0alEg7xKapOl8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-hJhbLReCPuKmXZSQXJx5Ew-1; Tue, 06 Feb 2024 23:25:08 -0500
X-MC-Unique: hJhbLReCPuKmXZSQXJx5Ew-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5dc1aeb6a58so99489a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 20:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707279907; x=1707884707;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UKo2MUjQpc7UsBQTgO4yTvFrzKDUqeIb3yvTS0diUfc=;
 b=DIDrfmlVlzB3ntrcooq8mUE2/FoRKKHxHd0S5ZEfl2m8hEZd56s624JOIqDkcIVEpL
 wVk5LZWHKD8qzaIhLR77epYmUuzU7BE6M3dKhycvFF9otBjGFBPpILJqnCpFhYrvla60
 7+/v7Gytqje+haolneWABIcG4VprG9/D5cEokek+V/1nqXliop/ndkVX5NpJRKGwxcJ0
 vXzfwF89ts1bG8k6L4AIVKrE5h9Wuo8dwlWG3tXRleO+BQWFDWPZPPnMpA8GC6LbIz+j
 nh6TV4H+GuyXTclyIeXUIg7um3X+D+bFN+iVaCLgicHf42+FQfGvpqFcjEpn+1VpIr5e
 toCA==
X-Gm-Message-State: AOJu0Yxh4iS9uwU6FdXYQQ1pNYVVViRDkk5WwgzSN3ppMPqBNXjni8yL
 15bjcp7KYjvR1pfjkSQ9TuFJlqHDDC76YuRYYJcVlRiBikjvoAXq7I5iyZfgyziyGw/px5bJt0u
 HEO71jRv2BMsGntcPRmf83j0rZForQ6iFo7OXIX+aHWVeJFWhv+Rs
X-Received: by 2002:a17:90b:1052:b0:296:db75:c240 with SMTP id
 gq18-20020a17090b105200b00296db75c240mr1932092pjb.1.1707279907550; 
 Tue, 06 Feb 2024 20:25:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6cet7EKxPZe7hNPLeFxG0X/Am/7ncEXoszSpuhy88jLblLWKZ5rg15HT1P5WAAlgK9Gy3Hw==
X-Received: by 2002:a17:90b:1052:b0:296:db75:c240 with SMTP id
 gq18-20020a17090b105200b00296db75c240mr1932082pjb.1.1707279907231; 
 Tue, 06 Feb 2024 20:25:07 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUl0Y31FpaH44iLoTQLwR+dzInd09j+9+5YUnH5wlPofkBZVO0Yh45/+9YE5l6NMAv5EHSyDs9ku4RCOQLVoHY=
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 a13-20020a17090abe0d00b00296740b4cb5sm2645924pjs.17.2024.02.06.20.25.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 20:25:06 -0800 (PST)
Date: Wed, 7 Feb 2024 12:25:01 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH 3/6] migration/multifd: Support for zero pages
 transmission in multifd format.
Message-ID: <ZcMGHeXkV-079vVX@x1n>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
 <20240206231908.1792529-4-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240206231908.1792529-4-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 06, 2024 at 11:19:05PM +0000, Hao Xiang wrote:
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 25cbc6dc6b..a20d0ed10e 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -264,6 +264,7 @@ static void multifd_send_fill_packet(MultiFDSendParams *p)
>      packet->flags = cpu_to_be32(p->flags);
>      packet->pages_alloc = cpu_to_be32(p->pages->allocated);
>      packet->normal_pages = cpu_to_be32(p->normal_num);
> +    packet->zero_pages = cpu_to_be32(p->zero_num);

This doesn't look right..

If to fill up the zero accounting only, we shouldn't be touching multifd
packet at all since multifd zero page detection is not yet supported.

We should only reference mig_stats.zero_pages.

>      packet->next_packet_size = cpu_to_be32(p->next_packet_size);
>      packet->packet_num = cpu_to_be64(p->packet_num);

-- 
Peter Xu


