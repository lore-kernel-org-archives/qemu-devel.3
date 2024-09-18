Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E630DCDD548
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 16:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqxjt-0006OA-7P; Wed, 18 Sep 2024 12:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxjr-0006NV-Lm
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:41:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqxjp-0006lU-30
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 12:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726677667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4fNzDuIBR3mBDzLw+09G0u5YY5JJ3MQQFTtBb/L9uVU=;
 b=ZWLOVUxKxJQvrqeKQSPRSyQo1mE/bGd0VsgRJhu45QRvuOsRyx0U6PJ6ZSbFx+agTmUQ8a
 9chSEzJbsM8vwb8i5g1bkixuJPxl6zR7bCCl2E5KLkpDysuDrA+nzS3IkeVvjsyRuMmIcp
 sc317SOX5+y5Hkw7EKHZ+ZIOX8WrqxQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-115-IoM6WgCAPUSVY8Yjk_gCSQ-1; Wed, 18 Sep 2024 12:41:06 -0400
X-MC-Unique: IoM6WgCAPUSVY8Yjk_gCSQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6c5bd369336so13364116d6.2
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 09:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726677666; x=1727282466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4fNzDuIBR3mBDzLw+09G0u5YY5JJ3MQQFTtBb/L9uVU=;
 b=m4q9QS1YfJaQfhVqPj/BiaS4vlfX2UQP7j2LTCdDx9WPnfDBzjKhT4m9ooHSA11ym2
 bTfdqKicCJFpBTC4ITAapjWt/SrBJrV2aeWZPd+wm/aotkV1CkeyvUy3odLyfpdjbpkE
 XmSw+aeOyzJ+EHU3yiD10Qq73N3L+e5SJ/HUjrwgdqIBrXwFxAhRzZ3HXl8XM0Fm+WOW
 Pk65yfK6r+XT9FMDq0zVqCTOu1fZLQN8pNsAsOLXfpRQLtIB8puyBjvg/+x+RJXCr9vG
 AM1WbF2KkZ0f4S1xk5J/9eRLjnYsQqKkWFHryBCd1uCr7XZDsP4g09NILo2gPs4YFV7L
 BfiQ==
X-Gm-Message-State: AOJu0YzhhfZWujRM041niSzWlaXGKRXz3+fRI8yEFDYhcEEFympzT6yk
 KIXgKy6qnuCbRolxiTUibJsfMzcuXON/pkNfrXZb+C9WyGSnonyVyaW1t6FpR/WhxKfFJZCo9Ws
 FaKia8T8Eh8sxDQqvfyauN1/yA6++dfaG7fEmOtWNXN4QygRTgoWe
X-Received: by 2002:a05:6214:5c41:b0:6c5:72a3:655b with SMTP id
 6a1803df08f44-6c57351be8fmr263015856d6.16.1726677665938; 
 Wed, 18 Sep 2024 09:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSAlywboP5wZJl4eGZN0ZBNJaWKaWLiU4VduoRRDc1WtvVTnwmo82Tn13I4tamRUq4j39Cuw==
X-Received: by 2002:a05:6214:5c41:b0:6c5:72a3:655b with SMTP id
 6a1803df08f44-6c57351be8fmr263015696d6.16.1726677665607; 
 Wed, 18 Sep 2024 09:41:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c628d6esm45510066d6.4.2024.09.18.09.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 09:41:05 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:41:02 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] util/iova-tree: Remove deadcode
Message-ID: <ZusCntgJHaIsBlpD@x1n>
References: <20240918142515.153074-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240918142515.153074-1-dave@treblig.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 18, 2024 at 03:25:15PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> iova_tree_find_address, and iova_tree_foreach have never been
> used since the code was originally added by:
>   eecf5eedbd ("util: implement simple iova tree")
> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

Michael, Jason,

It seems iova now has its own entry in MAINTAINERS, however this is
currently used either by VT-d or vhost.  Maybe it makes more sense that you
maintain this small file together with vt-d/vhost (considering I dropped
myself from VT-d development)?

Please feel free to pick up this patch if you want, or let me know if you
want me to do that.

PS: if you agree on above, I can move on with a MAINTAINERS file change to
drop myself from IOVA tree maintainers, then I'll add both of you in, if
that sounds good to you.

Thanks!

> ---
>  include/qemu/iova-tree.h | 25 -------------------------
>  util/iova-tree.c         | 23 -----------------------
>  2 files changed, 48 deletions(-)
> 
> diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
> index 2a10a7052e..44a45931d5 100644
> --- a/include/qemu/iova-tree.h
> +++ b/include/qemu/iova-tree.h
> @@ -111,31 +111,6 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
>   */
>  const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map);
>  
> -/**
> - * iova_tree_find_address:
> - *
> - * @tree: the iova tree to search from
> - * @iova: the iova address to find
> - *
> - * Similar to iova_tree_find(), but it tries to find mapping with
> - * range iova=iova & size=0.
> - *
> - * Return: same as iova_tree_find().
> - */
> -const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
> -
> -/**
> - * iova_tree_foreach:
> - *
> - * @tree: the iova tree to iterate on
> - * @iterator: the iterator for the mappings, return true to stop
> - *
> - * Iterate over the iova tree.
> - *
> - * Return: 1 if found any overlap, 0 if not, <0 if error.
> - */
> -void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator);
> -
>  /**
>   * iova_tree_alloc_map:
>   *
> diff --git a/util/iova-tree.c b/util/iova-tree.c
> index 536789797e..06295e2755 100644
> --- a/util/iova-tree.c
> +++ b/util/iova-tree.c
> @@ -115,13 +115,6 @@ const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map)
>      return args.result;
>  }
>  
> -const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova)
> -{
> -    const DMAMap map = { .iova = iova, .size = 0 };
> -
> -    return iova_tree_find(tree, &map);
> -}
> -
>  static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
>  {
>      /* Key and value are sharing the same range data */
> @@ -148,22 +141,6 @@ int iova_tree_insert(IOVATree *tree, const DMAMap *map)
>      return IOVA_OK;
>  }
>  
> -static gboolean iova_tree_traverse(gpointer key, gpointer value,
> -                                gpointer data)
> -{
> -    iova_tree_iterator iterator = data;
> -    DMAMap *map = key;
> -
> -    g_assert(key == value);
> -
> -    return iterator(map);
> -}
> -
> -void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator)
> -{
> -    g_tree_foreach(tree->tree, iova_tree_traverse, iterator);
> -}
> -
>  void iova_tree_remove(IOVATree *tree, DMAMap map)
>  {
>      const DMAMap *overlap;
> -- 
> 2.46.0
> 

-- 
Peter Xu


