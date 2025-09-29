Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965BACAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 19:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3J9t-00069P-Cs; Mon, 29 Sep 2025 15:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3J9r-00069B-PR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3J9g-0003YU-Ls
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 15:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759172602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dzVduiv11jNq+bbRyBXccImOPJV2Mp6W3x2rQ69EkKI=;
 b=aXQMuyULgQhcSil8GtruEdP2dOAYEdyiCnw/dad6oUj5/yv9z20lqbZOKg4sK1qTopope0
 Xqnl78IYzIKRdCJB+HuDfNEALFcx1iYPqBM0xkHqhZICoOlXiDZ2tkPZQxvallc4n34NGK
 Mm44cZhJDPkC9yF911gdJPe2FGO11K0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-AGv55quhMdWP9KL5AJxSGw-1; Mon, 29 Sep 2025 15:03:19 -0400
X-MC-Unique: AGv55quhMdWP9KL5AJxSGw-1
X-Mimecast-MFC-AGG-ID: AGv55quhMdWP9KL5AJxSGw_1759172599
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-827061b4ca9so881177385a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 12:03:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759172599; x=1759777399;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dzVduiv11jNq+bbRyBXccImOPJV2Mp6W3x2rQ69EkKI=;
 b=qlWKpFlQ9vq+d3loTdtrZqdXrW5Q0/Mu3xq+wmU1XMuvp9bXiRVxS1B+h2Xb0pRnqT
 BZ9g5VKzg1LP40PjYWx/rZMVnUOSlBmCvpmtkfdjMBf9exVUEkDfbUkslMN5eHaEJeWf
 J4giMfcxqaYGeTU7ltxaOI+MFQ5fYCZSTfl4CS/zkdwX6yMlut9hIc3YcshoSgFylUXj
 49Oaqan5OJjZUFRwjPoswln2MZczJwykvXCUjsALY/r1uJ0le62RIaQSUKKzD7wRMbpy
 C8hEzqQhY6nVx1pdhxGC15ruwdn9N8PBS1nF4qolX87Y2XM9rRI3z0G2vYqr/d/C7oZX
 YHgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWBC4FfcrMhzyr6JfTgWLWJn3EXjnBvEUEnWjmFLPJUqkN7Znnb2bGDEp+9xUMLNyOcIhPs6oi9FyV@nongnu.org
X-Gm-Message-State: AOJu0YyPi32Eghcb/SO2UBMrret89theQaW5UKwAH/ZPkG7G+BTx/yC/
 I/PCMDuXIWLOSFFrwnTiWP2fnGzyLQ9LQVBU2g3JtlNVi5Ko9nId1ODEYeiKxzeEvwC6kgMLspZ
 zr+vmw/eQPBqGnAogOR6mgpS4PtQyeUwBG/q+L8l+voqwqNt2ybWa7Qjp1FzUSMzu
X-Gm-Gg: ASbGncsGJKYRQTEBEjzMBB3QHhOM1JFteQTdp6z9H6ozezm6gQslOnTmLtcuaWAfLaN
 61DxMEV3EYuUJC7+dA7j5ykgnBuNeQJ46mqD1H8PkOwr4z7y1njzggSfFA3MUZEzUFYKYdF5J6K
 yIwo0evxIsif7m1tUzmQrBmmP99P7Uv06AMG8IIudbPeysGEp7fkI20MjS2MV8vs+B9sZrva7Ng
 0HQqf6kiBoV2bd9jRf67w59FAnSEU3e7EnTjDup9/ETbO/qV8doX8zvktB1rGxtIY63oghXCMjk
 LWg3wHYMb/0xByQddZVY7SkdK5YHh1iw
X-Received: by 2002:a05:6214:1d23:b0:787:5934:689 with SMTP id
 6a1803df08f44-7fc19a78ceemr196072156d6.0.1759172599063; 
 Mon, 29 Sep 2025 12:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeWCaV8Z5Ze3vjOpdnQa61l9kVreYKN3lPOkPc7jVLZipbVndJGgfGVt1kNCMBdDQb8bvGfA==
X-Received: by 2002:a05:6214:1d23:b0:787:5934:689 with SMTP id
 6a1803df08f44-7fc19a78ceemr196071736d6.0.1759172598552; 
 Mon, 29 Sep 2025 12:03:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-80135b54636sm81127186d6.6.2025.09.29.12.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 12:03:17 -0700 (PDT)
Date: Mon, 29 Sep 2025 15:03:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Salil Mehta <salil.mehta@huawei.com>
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
Message-ID: <aNrX9AnoCY2uJStJ@x1.local>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <e6d4526c-6b3e-4b95-9d6b-54823a219a47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6d4526c-6b3e-4b95-9d6b-54823a219a47@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Sep 29, 2025 at 05:02:40PM +0200, Philippe Mathieu-Daudé wrote:
> Cc'ing Salil for previous discussions on
> https://lore.kernel.org/qemu-devel/20230918160257.30127-1-philmd@linaro.org/

Thanks.

While waiting for more comments, I pre-queued this series.

Regarding to patch 1: I still think it's almost impossible to use it
correctly on address_space_destroy(), even with the doc.. but I agree
that's the best we can have right now.

The problem is, afaiu we don't even have a way to know when a rcu callback
is processed, unlike the grace period (which corresponds to synchronize_rcu()).

I think it means there's almost no existing way for the user to properly
release the AddressSpace memory if it is e.g. embeded inside a Device
object.  Here, we will need to rcu-free the Device object too (which I
don't think we do at all..), making sure it's called after ASes' rcu
callback.

Even if we'll do so, we'll have yet another problem of having the Device
free() rcu callback to happen after the AddressSpace's destroy rcu
callback, we could rely on what Paolo mentioned on FIFO behavior of rcu
queues, but it looks unwanted.

For the long term, IMHO we may need to convert all embeded AddressSpaces
into using dynamically allocated AddressSpaces (for CPUs, we can stick with
cpu's address space API, but we have other places using ASes too that may
also need to be converted to heap allocations).  Then after all users
switching to that we may be able to drop address_space_destroy().

Thanks,

-- 
Peter Xu


