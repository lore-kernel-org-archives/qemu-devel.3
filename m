Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFBA0C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 13:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s53l9-0003X5-CG; Thu, 09 May 2024 09:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53l3-0003Wa-JC
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:24:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s53kz-0007bw-0J
 for qemu-devel@nongnu.org; Thu, 09 May 2024 09:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715261060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gN+nQyDatopODvfSymDv7FCngENgrrYpqvpUO7SO4l4=;
 b=YGoEqSr5b3iFnCGlXKakGGeNRrbdVa4UDaHnP3SDBSbSKsOqBDNL9i4fdkDJpa6bXfTNr8
 7a36UswJTs0JM6jYqYoDccd6JvmRphzZgZ/UaXZa03obu9QKFGefP6epl0zqWluHsLCdBV
 mBOVowsaHAI0wTHYF4pp5exNvq3GDvA=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-hAg5-tDRPX6UuNr9oajpXA-1; Thu, 09 May 2024 09:24:18 -0400
X-MC-Unique: hAg5-tDRPX6UuNr9oajpXA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c972a13172so154891b6e.2
 for <qemu-devel@nongnu.org>; Thu, 09 May 2024 06:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715261058; x=1715865858;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gN+nQyDatopODvfSymDv7FCngENgrrYpqvpUO7SO4l4=;
 b=KVtN2H3i0+PK09yi3s+1ewuYr1PwC/Z7PIGkicCK7JWyqr0jZw6hoXpAVzNQnHhw74
 ZwubVxig2CzcRsVs14WgOD1vwcGvLtx7dQQ2RvlbRVuZ6hxOR1iYPmThEOztBdJInoiG
 fQTf7cXT4zU+u6I8MzV29/g8YEUnO8pEYCK+DsniJuK18H5l9o+ETLOJiDZD/xHjt0Nv
 gduVstc//wQsqYqaV4Cw8598GX+SaZyzl3yi5Dy9OpS44Gx8yrDYE8LuY3o/bWe5IqML
 On+zHa9ux+zKx5+sz1Fr2Cb9QLk/z3+PQBTvgr6jQ8krGwJTjVIJH8A5u/acXxnDgvP5
 wB4g==
X-Gm-Message-State: AOJu0Yw6zZumY2yi5f57xIjCx/e+apnKslco4+2Fk8YvNlB+CDLfxz27
 wr37ttNEIBYJVEgXqmSwHjnlWhFxpaB34ryUW5yTHgAeclfm1qBN2u5Dt3BOB0aZ2Kt+No4LNw1
 DtMKGqBZMAtk5aLrZOoWX+ZMfIfA2j6J2+k0DBfNY5KcccFIgF2Z/
X-Received: by 2002:a05:6808:1796:b0:3c8:64c2:73fa with SMTP id
 5614622812f47-3c9851e5985mr5955877b6e.0.1715261057670; 
 Thu, 09 May 2024 06:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpAO3X2Q9Z2MG3aWBcHpIffTi/i9DgVvLIFdLeqRC57nWjWjjStZhEG7TfFoKKM5SOok0/Dw==
X-Received: by 2002:a05:6808:1796:b0:3c8:64c2:73fa with SMTP id
 5614622812f47-3c9851e5985mr5955841b6e.0.1715261057023; 
 Thu, 09 May 2024 06:24:17 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f17a3d6sm6926726d6.18.2024.05.09.06.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 06:24:16 -0700 (PDT)
Date: Thu, 9 May 2024 09:24:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, farosas@suse.de, philmd@linaro.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, maobibo@loongson.cn, zhaotianrui@loongson.cn,
 lixianglai@loongson.cn
Subject: Re: [PATCH v2] target/loongarch/kvm: Fix VM recovery from disk
 failures
Message-ID: <ZjzOf4kl4SLstkKA@x1n>
References: <20240508024732.3127792-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240508024732.3127792-1-gaosong@loongson.cn>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 08, 2024 at 10:47:32AM +0800, Song Gao wrote:
> vmstate does not save kvm_state_conter,
> which can cause VM recovery from disk to fail.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


