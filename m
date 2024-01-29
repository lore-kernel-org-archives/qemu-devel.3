Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7762AC47DDF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 06:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rULAD-0004Zb-P9; Mon, 29 Jan 2024 01:30:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rULA4-0004XG-Cd
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 01:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rUL9x-0006Pm-Tu
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 01:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706509783;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jxAewBphiJIQDFeBOWYyiq35YfYIFCvoAwymHp2htBI=;
 b=HfzgZ7xE8MnrjkQPdS8/gxTt4vtQCZem4TuMAH8j39e26K1DVGmoQ3/ufThniuE2V56adC
 W+3VyWXhdcA/6cX5dip1YVjFYqKoZ0aNufUcWa/dlG9Y3km7u7mx8yutSthiPtrDZFbgf9
 5DnaiTJLlhppDS1zSNOCE304/v9Q+mQ=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-6XMSOEQiNs-R_-J4pCOQ6A-1; Mon, 29 Jan 2024 01:29:41 -0500
X-MC-Unique: 6XMSOEQiNs-R_-J4pCOQ6A-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-59a10a15904so795007eaf.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jan 2024 22:29:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706509781; x=1707114581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jxAewBphiJIQDFeBOWYyiq35YfYIFCvoAwymHp2htBI=;
 b=Nd99gg+0HCeOrb9mMbFzQYCRdnwlXzSLe28OjwqOqgx0/5vczH/DrP6FAmA6GSmA5s
 7PaQxF0/W86ZIDrYVXggEn4ob97zwkqgK4DP6DtFPTEbNI8nsF9PaewRe3PH7fb3uWZ0
 k6q1UnKSQhKB9RDs/NosE8CQ2MahomW+ryC7Jea7GLJiR9r8tW0yiDoSdEAvUeUocbF6
 7rB2WKk4YL+tixSDBYDb9iOC2AjUnRbhxUqhFNJAuwA9X1MFO2C9Dte0es6emK1kU2Bj
 ZeUY+zK17WP5f2aGhE0Va8LU8Ii2Jrw8StKvbI8vCZ5sMeMxsaZdBHfyi9UlCNfT2PMz
 dfVg==
X-Gm-Message-State: AOJu0YyR6rDBiV0WfQwsnA+OuWglMyBJimrjphNhMrehpod540uFqT0C
 NDFHLPTVC47h677CHIz9qWTE9KsRfk1czxOLf7LhFvaydUI8oJ9hG7eWruKLouVy/VsX+QuR6pi
 4o6Dn+weQ3GNdOAvIrQYF/da8t2kL0iQ4PA7jZJLJqDk9MaZudqEg
X-Received: by 2002:a05:6358:890:b0:176:c4fd:8f80 with SMTP id
 m16-20020a056358089000b00176c4fd8f80mr4745618rwj.3.1706509780892; 
 Sun, 28 Jan 2024 22:29:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrPVT2CfNPk7ZkPfqf1ACwN3G8w+dqNN+8Alg5PeaX8m47daknRAHI+z0jyN1IIVzP7lSlpA==
X-Received: by 2002:a05:6358:890:b0:176:c4fd:8f80 with SMTP id
 m16-20020a056358089000b00176c4fd8f80mr4745607rwj.3.1706509780413; 
 Sun, 28 Jan 2024 22:29:40 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 bz11-20020a056a02060b00b005cdad153d84sm4287944pgb.90.2024.01.28.22.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jan 2024 22:29:40 -0800 (PST)
Date: Mon, 29 Jan 2024 14:29:32 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>,
 Yuan Liu <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
Message-ID: <ZbdFzFxysMg274Rw@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <20240126221943.26628-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240126221943.26628-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Jan 26, 2024 at 07:19:39PM -0300, Fabiano Rosas wrote:
> +static MultiFDMethods multifd_socket_ops = {
> +    .send_setup = multifd_socket_send_setup,
> +    .send_cleanup = multifd_socket_send_cleanup,
> +    .send_prepare = multifd_socket_send_prepare,

Here it's named with "socket", however not all socket-based multifd
migrations will go into this route, e.g., when zstd compression enabled it
will not go via this route, even if zstd also uses sockets as transport.
From that pov, this may be slightly confusing.  Maybe it suites more to be
called "socket_plain" / "socket_no_comp"?

One step back, I had a feeling that the current proposal tried to provide a
single ->ops to cover a model where we may need more than one layer of
abstraction.

Since it might be helpful to allow multifd send arbitrary data (e.g. for
VFIO?  Avihai might have an answer there..), I'll try to even consider that
into the picture.

Let's consider the ultimate goal of multifd, where the simplest model could
look like this in my mind (I'm only discussing sender side, but it'll be
similar on recv side):

               prepare()           send()
  Input   ----------------> IOVs ------------> iochannels

[I used prepare/send, but please think them as generic terms, not 100%
 aligned with what we have with existing multifd_ops, or what you proposed
 later]

Here what are sure, IMHO, is:

  - We always can have some input data to dump; I didn't use "guest pages"
    just to say we may allow arbitrary data.  For any multifd user that
    would like to dump arbitrary data, they can already provide IOVs, so
    here input can be either "MultiFDPages_t" or "IOVs".

  - We may always want to have IOVs to represent the buffers at some point,
    no matter what the input it

  - We always flush the IOVs to iochannels; basically I want to say we can
    always assume the last layer is connecting to QIOChannel APIs, while I
    don't think there's outliers here so far, even if the send() may differ.

Then _maybe_ it's clearer that we can have two layers of OPs?

  - prepare(): it tells how the "input" will be converted into a scatter
    gatter list of buffers.  All compression methods fall into this afaiu.
    This has _nothing_ to do on how the buffers will be sent.  For
    arbitrary-typed input, this can already be a no-op since the IOVs
    provided can already be passed over to send().

  - send(): how to dump the IOVs to the iochannels.  AFAIU this is motly
    only useful for fixed-ram migrations.

Would this be clearer, rather than keep using a single multifd_ops?

-- 
Peter Xu


