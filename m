Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC16CCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 18:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stX9W-0002Ux-KX; Wed, 25 Sep 2024 14:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stX9T-0002TK-16
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 14:54:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1stX9M-0004eI-RV
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 14:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727290448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4H3cw9GB783tNwmDnZ2S++mvZzqxgZyqfHTbLELk6o=;
 b=NpG3rzzzOgqV+MGOqBje861pxQx1q0OrMB5zRqYwK4qlGAiitywCrpJE3YXbIxrpNKQeZa
 dQ5fIXFGXJhOqOkmqEjvM+seFCiwvpsqWk1ihNwRGmnbrHTVBSPMsi0bBb5i3DTcNuX1gw
 trRrpIz3s1LsOGVyV0OtCthAuStOWdY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-g4TJWOmKPGWpnCApjDtqpA-1; Wed, 25 Sep 2024 14:54:06 -0400
X-MC-Unique: g4TJWOmKPGWpnCApjDtqpA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5e4df21f22dso167508a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 11:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727290445; x=1727895245;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4H3cw9GB783tNwmDnZ2S++mvZzqxgZyqfHTbLELk6o=;
 b=NxXER8DsnDifaOFA0ThJEJspxpkt2Eqv0uDE/lw4SgzkXSSmOH7vTf7mTczpXxbr5y
 o14bvPD7FLqtrCCRKeX4mzCZDi+e5FGdrLUvIr91qEYH1HlfmLLP3Bnu6Vy7Q6efBjc9
 8KdCvIenRO/lvNHfDwdZLff0AVz/N40Fzw/TvxnIMqzUFw5lp0BCgqZBTmu3Utne3YrN
 QxNhztcYfgjEtuxRwH3LVltCa/a4jG7nCdHTuRdIwVbKVGH1vphMtD2ohqwWlFwGJ83J
 mMeMK0YU28zP/zO6rGrdlvFmQYFIXlScn1vZVvbP0eKm2O9AIt01g160HXGp/gmN2Dfk
 AGBg==
X-Gm-Message-State: AOJu0YwyVNjU1KR8aFN/MmkepMDce2l1QLD6bTYwWH6skhjxzHD4L5+I
 z7wyp//m+h3nUQf+LULBjp1ylhKT+WYe0y0DXgovs8HhsIcYr2Hi67ae9o8MPB14A16xqPt/YWM
 4hjSxtcQpupRNZWYAWlZnkwAZj66Qt5OHS7TcSDkd/oZ2hFGElG4t
X-Received: by 2002:a05:6a20:ac43:b0:1d2:eaea:39d7 with SMTP id
 adf61e73a8af0-1d4ebe34daamr931394637.9.1727290445658; 
 Wed, 25 Sep 2024 11:54:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHscT7xLGL+Mdsqslt5gabiJfAB0m7sfBzAb48ZpJ6ymGAmEoA/eWwjKKRGGXMfyU9pHtJVVg==
X-Received: by 2002:a05:6a20:ac43:b0:1d2:eaea:39d7 with SMTP id
 adf61e73a8af0-1d4ebe34daamr931373637.9.1727290445372; 
 Wed, 25 Sep 2024 11:54:05 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc97c202sm3041050b3a.167.2024.09.25.11.54.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2024 11:54:04 -0700 (PDT)
Date: Wed, 25 Sep 2024 14:54:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/2] target/i386/kvm: Report which action failed in
 kvm_arch_put/get_registers
Message-ID: <ZvRcSBGY4yiw84Sk@x1n>
References: <20240925153625.183600-1-jusual@redhat.com>
 <20240925153625.183600-3-jusual@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240925153625.183600-3-jusual@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Sep 25, 2024 at 05:36:23PM +0200, Julia Suvorova wrote:
> To help debug and triage future failure reports (akin to [1,2]) that
> may occur during kvm_arch_put/get_registers, the error path of each
> action is accompanied by unique error message.
> 
> [1] https://issues.redhat.com/browse/RHEL-7558
> [2] https://issues.redhat.com/browse/RHEL-21761
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


