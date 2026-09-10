Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFF4C88E41
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 20:20:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4lEu-0000Ig-A9; Thu, 10 Sep 2026 16:19:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kpt-0002Xs-9K
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:53:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kpY-0001Lq-Em
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:53:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789069926;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73L37DsJrLyfH85BQAp+z43/Bi6wd6yPjxK31q/ynRc=;
 b=YPFn3o0msdDoQGBFbo1YbUgmReH+4MhiMGPmjUyREXAmJCU5cdWXqSydiwiHt973FU8mhU
 XhEaPruVReRVJ78VlPVydnn9IkdXNq9g331FpXGjfzEUS+1vpkBB/aJWbJBiF+nIXS0JVi
 jtSNK7hS/GoqaSgqS2hRUA/bySlVQvo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-jDsORh6OOSy3_F7Yk-WD3Q-1; Thu, 10 Sep 2026 15:52:05 -0400
X-MC-Unique: jDsORh6OOSy3_F7Yk-WD3Q-1
X-Mimecast-MFC-AGG-ID: jDsORh6OOSy3_F7Yk-WD3Q_1789069925
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9399b66e0e7so14037185a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789069925; x=1789674725; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=73L37DsJrLyfH85BQAp+z43/Bi6wd6yPjxK31q/ynRc=;
 b=fOddZ2KURBqwYYkQQf8Vbq4J5AKfwBQ/PHMFxuL2Vz6WZcHGWBjMl6eqSqH0BG5X1j
 W7Oq2nTwvDZo8dizV5hohbMmke7Gm+5V6diH2nLmxQnN08I+woKlRH8JCefRvDPeds9O
 bJncWXD/SFi1LplVscpizSaF3hZr8JNPt0eNacvZH2ReztYESZLj5iLh+Z3jt9Ya06mH
 hHBzsXuoMwg8cZJyibtrv86RjTuoz9tHRim77JvZrfbIjfPu8CC8mJBAgk2W5QOq5zfM
 g62VTYp7YzdIh+uSt+CjvW6Xrs/j2Es7Mznndmc0Hw5PjlTf8TWLtJSLju2pP3aZM9IU
 rDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789069925; x=1789674725;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=73L37DsJrLyfH85BQAp+z43/Bi6wd6yPjxK31q/ynRc=;
 b=kTnrHucF6ev3DvUMn8I+2xbJVgX9IXHKuSSSVZZhO6h5W0h5u06fz+2eEgd74p5rUH
 qANxZAXQSFOdLUHsN3cH1aXXts6Yc3abn/y9mFKqf3LSWqAYdo3nwSGr+f29q9uQGp/E
 ca8cb0DlOf5Bsk/3Q1pN8Ew2ekr+HXdAlxp+rQ0jF8sRm+FDCfPRyc4eIpkmFnYPBbe3
 sq70VLZv9M4zqq/WdH2vFhbF0oHJ238Scs5b/g6Ne6fUxp04c8q18N9bDau4wjVLxdfs
 qRyatzODrfg8weTnwnZXUBhY//+8jiEPEbb1tTw6QjUXk/sajkucDUsYA69Esiv0YU26
 vcqQ==
X-Gm-Message-State: AFuF++nljzYtmSZfGhZuaE5SC4kXmFuIqt0OP+mdJIjUlX84tbySbS6Y
 7QIiKHb/jzukfo8xBN9xnZJF3KGzZyxK2c4wgjui5PWL9GR5xFSbOPQOb41wquPvBSqjJIs8leJ
 H4qIK6FoYbYunP06vUxmyRY7AcwpPkaTYFB3qqledxeY3nthAIYonk0H8
X-Gm-Gg: AYBFou2DGV1MOYgswQPZo8//6FJlrtYQR19jEtV/Tb5DMyuC9bFmvAWOvigARvIXP1q
 LWsnnyZ6iInhfvO4s8+UcJrnq4ljgFwgMm4xVTEuA65chO2Uk+zSCPQ6AFOePGDvqJZVIAc//oV
 GERpxt+JPg4rU/436spUihk5FXy3+8QBizWL+wpPsbzCg4qyBXHsoaLhb7I3FVmF27vx2xsPfq0
 Zxnt2Bh5yn2RQvPH9DtdG6w8bA5AI5FtETOpsB9wqe1bpGIbo0i4Tk+ZD+DtROFIxRT8AIgjc/h
 C5vvCJ8pntHEWxIAAsdJdncl4zi/BUKpS7y2cTmv1+kbJtF2VUZsugHgtS94hKOgGJ1XAfyUcQT
 OqHDU/i4KfHlEZHVDypHPWj9T6aVI7aS/np6PRcocPwLHrF9ZOK37BR/vZuc=
X-Received: by 2002:a05:620a:708a:b0:937:50b6:4a5b with SMTP id
 af79cd13be357-939ea0b15fcmr61604985a.23.1789069924928; 
 Thu, 10 Sep 2026 12:52:04 -0700 (PDT)
X-Received: by 2002:a05:620a:708a:b0:937:50b6:4a5b with SMTP id
 af79cd13be357-939ea0b15fcmr61594285a.23.1789069923907; 
 Thu, 10 Sep 2026 12:52:03 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d35a9sm3566296d6.41.2026.09.10.12.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:52:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:51:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Yanfei Xu <yanfei.xu@bytedance.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, lizhijian@fujitsu.com,
 jinpu.wang@cloud.ionos.com, isyanfei.xu@gmail.com
Subject: Re: [PATCH v2 1/4] migration/ram: Add RAM round synchronization
 notifiers
Message-ID: <aqMKXKsG_arqpiSR@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
 <20260830012750.1567524-2-yanfei.xu@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830012750.1567524-2-yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Aug 30, 2026 at 09:27:47AM +0800, Yanfei Xu wrote:
> find_dirty_block() directly invokes multifd's per-round synchronization
> when the RAM scan wraps.  Other transports need the same boundary to
> order page versions.
> 
> Add a return-valued notifier for RAM round completion and register
> multifd's existing synchronization through it.  This keeps the current
> behavior while allowing other transports to synchronize at the same
> boundary.
> 
> Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick only,

[...]

> @@ -95,6 +96,17 @@ void ram_handle_zero(void *host, uint64_t size);
>  void ram_transferred_add(uint64_t bytes);
>  void ram_release_page(const char *rbname, uint64_t offset);
>  
> +/*
> + * Round notifiers must complete writes from the previous RAM scan before
> + * returning, so a newer version of a page cannot overtake an older version.

This is fine, but IMHO the better way to describe this notifier is as
simple as:

  The RAM round notifier kicks off whenever the migration RAM core finishes
  scanning one full round of guest memories.

We can further provide examples of multifd/rdma use case of it to use it as
a hook to flush old pages, but just to say maybe it can be used for other
things in the future, hence we can make the document more generic.

> + */
> +typedef struct RAMRoundNotifyData {
> +    QEMUFile *file;
> +} RAMRoundNotifyData;
> +
> +void ram_round_add_notifier(NotifierWithReturn *n);
> +void ram_round_remove_notifier(NotifierWithReturn *n);
> +
>  int ramblock_recv_bitmap_test(RAMBlock *rb, void *host_addr);
>  bool ramblock_recv_bitmap_test_byte_offset(RAMBlock *rb, uint64_t byte_offset);
>  void ramblock_recv_bitmap_set(RAMBlock *rb, void *host_addr);
> -- 
> 2.20.1
> 

-- 
Peter Xu


