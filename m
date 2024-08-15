Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB66C52D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 20:47:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sehMw-0001CA-1B; Thu, 15 Aug 2024 16:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sehMu-0001BA-O5
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sehMt-0004kq-5X
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 16:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723754804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO+chinbtuJvWiPKWolaQUontjlgIB9F/Ynr0VHy+Gk=;
 b=azu4lMi5zngfccb7LD+01EFmcLgS8PsFCy1AcXJMAVFSc1WYZAwevlqMDggmjf1FfavDis
 dBNyKzBOMeMhQdmPuYLfyRivqei5k73qWj3lOKfeTMxZfYWjHsgZMtkXrpb9Qavl/19sOT
 GZh0hJDRVXFObPWS6VdbKt1hPqnzwLk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-EP8dDHmCMjSVjL372wIu9w-1; Thu, 15 Aug 2024 16:46:43 -0400
X-MC-Unique: EP8dDHmCMjSVjL372wIu9w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6bba0f9d3efso2228126d6.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 13:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754802; x=1724359602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UO+chinbtuJvWiPKWolaQUontjlgIB9F/Ynr0VHy+Gk=;
 b=mhT0IUe5Rh2Z9xhOrjPNiC9MdnYa4Y/1lCf9aFAemkX75s4LRHh3QjQXYzrwLIw/af
 BpMVcZ/qBGYjtTyaYDWV5OH24mRD+OnCiTUqR21rRyr/DGSx7Wb9w2IOhq8GTVlkbNtM
 bj12xidXXTao80RLSmirrug8Kxx48aW46yRSmeImyayTkf0NrwzO/W1uxy1DsxPTbHXn
 Qp7MUGQ+hJ++vAB8VjeTP5z9MxsDt9K5VqWy1eh4Z/mKkzxoHsO7DaTOuPMALEo5+ymr
 7UQTGe1QH90N3ceE0cVkeSMT0KNEtf0DOw26WEu1NFgc0ZAywavtr4EnhFRVrrzblF3e
 WxZw==
X-Gm-Message-State: AOJu0YyYbsCr2GOy4QVpU55f9Yuy1u3JORzh+JXErpSUfvTuRC7Fq2A+
 EK0ydCCb4xDJCezL55ICBNR4pAigWs7ttI8tY++m5nu4O2DAPBrKl6M5wm08JQMLBPyI0oQZoZW
 h5Wncq0dl6UKwdql8vBbNPqvlkv0tV0g6LWQoviBT5yFnNO+DJUFk
X-Received: by 2002:a05:6214:2a83:b0:6bf:6ef5:4160 with SMTP id
 6a1803df08f44-6bf7cc8e5e0mr4844686d6.0.1723754802603; 
 Thu, 15 Aug 2024 13:46:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTnMNFNWi9L6aAGAN6KW99AN7ZjwY9s+rzbIEKViRPRmq9/T5f5XL7V1f5rAzx4u2JWkQHbg==
X-Received: by 2002:a05:6214:2a83:b0:6bf:6ef5:4160 with SMTP id
 6a1803df08f44-6bf7cc8e5e0mr4844536d6.0.1723754802196; 
 Thu, 15 Aug 2024 13:46:42 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6bf6fe4fc98sm9819306d6.71.2024.08.15.13.46.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 13:46:41 -0700 (PDT)
Date: Thu, 15 Aug 2024 16:46:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 4/6] migration: cpr-uri parameter
Message-ID: <Zr5pL4vPTi0sSFgU@x1n>
References: <1719776648-435073-1-git-send-email-steven.sistare@oracle.com>
 <1719776648-435073-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1719776648-435073-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sun, Jun 30, 2024 at 12:44:06PM -0700, Steve Sistare wrote:
> Define the cpr-uri migration parameter to specify the URI to which
> CPR vmstate is saved for cpr-transfer mode.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

So I left the idea in my reply to the cover letter to reuse "-cpr-uri" in
qemu cmdline on dst node, and I wonder if it'll also save this one on src
with the same idea.

In general, with cpr-transfer we always stick with unix socket, and only
one pair of it.

When migration starts, cpr_state_save() dumps things and cpr_state_load()
loads things.  Then the socket gets reused on both sides to be the
migration channel.

IIUC we can already reuse QMP command URI on src so we don't need anything
new.  On dst, we may need "-incoming-cpr" to tell QEMU we need to kick off
CPR early loads; it's a pity we don't have way to specify migration mode
there, otherwise IIUC we can even save "-incoming-cpr" but reuse "-incoming".

Thanks,

-- 
Peter Xu


