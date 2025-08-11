Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA30CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 15:56:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulUsw-0003Hd-QB; Mon, 11 Aug 2025 11:56:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUss-0003HF-P0
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulUso-0005d3-Gf
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 11:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754927779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnUX4zT8RC8IuEkMjhNgAhmmUKIJkbduq5jYYnBF1wk=;
 b=Y4QAMHIGNlHKErTGXmMhWZg7bXK5Ywqcne73xAC5Sknnd5pPSZJB+mN0HHY0353AQSnqj5
 H5M1xbG4ZDGiy6KFGPz1KorkuHpv1yamCn5h5fvJviKEbG1O7B7BvrAdiWiFhnVZFPhXKg
 RwxyShbvSnbWhJSSU9VKzkhPjcU9p48=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-bkeNWXC9Nky1JkVD5yygZg-1; Mon, 11 Aug 2025 11:56:17 -0400
X-MC-Unique: bkeNWXC9Nky1JkVD5yygZg-1
X-Mimecast-MFC-AGG-ID: bkeNWXC9Nky1JkVD5yygZg_1754927777
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7e667b614ecso975670985a.2
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 08:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754927777; x=1755532577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QnUX4zT8RC8IuEkMjhNgAhmmUKIJkbduq5jYYnBF1wk=;
 b=JNaFTXFamn0ZxNfQrHH879/pOBsAB4zR3pUGHl6ni+ZcHqrgdXqe1SX9GFbqngxCAz
 tEhQ2E6tu4EoM6odg61xyzCerzEAoFTJzWgwcLnFPqZ3wBf7w6ei0X8MPdSDux3n+Mny
 rn0ODcGGvIva76h4yBsiNOHtbLy93pzx2U/kLrsDWYmW/rezaGNe08Y1b4C1hMsbqbdp
 F1ULKZ28UoaPM4/GF98fd66be/drYmm2i1utfKHmL5WIKkWEyrkdiNuYH3qRwc/OAhcq
 jstQArPsYOpGDhbig8BjmCpC1OG6ER7dyXd9OqmAJsqPcj9HRrpNTecpc2fLQ1pFBfcN
 e0UA==
X-Gm-Message-State: AOJu0Yz7IqM1d/rz9of2BKNkgH9hTXzI1mEEzPo9zJJcej3ehBe+bhVX
 oIKTIo4JdLdsnGi4RkFXMjYC6higLtZYr3DafASOq93HbSW9jNBMAWlfFMN09hajzV1JodfPv6U
 Eo9mSp98Q9PsSP6bz3+jTLIXwKy90WeanT4s4rj0NqLIfqXCTNfs7/bOb
X-Gm-Gg: ASbGncuSA5XOOVvBQsqrlfKHLqvhfp0hSbwvsmwJA3UEkMrcZVDMG4Ngdc7cq/zGOic
 XoTwEnMdD8UbkHO1lJc9BlsqkYZISgu2rdF7fPB5xi458UunDVPxcK375UV9esQ9OGu7+lWdbFA
 zJWdSQdLe045dVC4T/1ssbmXpXQlujMhjtORDIJQk3x8Kfmn2NgSQ5v9HuyJkTrUkina7yfm2rT
 yBA2obFMoDjr+ee/9nr//FPoD9NkSAitdfNlJsZmzJwz0fKBEb5aN4goxQwtliL9PxRchrraoGB
 Bhali5/O617cP3QUL/KTgvbbGxllQgYQ
X-Received: by 2002:a05:6214:3007:b0:709:6b30:355a with SMTP id
 6a1803df08f44-709d5e65ce1mr3766526d6.47.1754927777374; 
 Mon, 11 Aug 2025 08:56:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfJklpQPPJSzslzqMFTL2aEN0y7s0/j/dHB3VnJNyfmmzfjER3kNgc1T63cCSCmp1rYekBOA==
X-Received: by 2002:a05:6214:3007:b0:709:6b30:355a with SMTP id
 6a1803df08f44-709d5e65ce1mr3766216d6.47.1754927776796; 
 Mon, 11 Aug 2025 08:56:16 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce39fb3sm156948796d6.82.2025.08.11.08.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 08:56:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:56:04 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 03/10] hpet: switch to fain-grained device locking
Message-ID: <aJoSlCDCy5IEZgko@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-4-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-4-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Aug 08, 2025 at 02:01:30PM +0200, Igor Mammedov wrote:
> as a step towards lock-less HPET counter read,
> use per device locking instead of BQL.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


