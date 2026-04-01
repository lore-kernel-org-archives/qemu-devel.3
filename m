Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E395E10F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xo7-0006uL-Qj; Wed, 01 Apr 2026 11:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7xo4-0006s8-Qu
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w7xo2-0004On-Q4
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775058513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+sRgn2+j+uaaLVeSL/GdSpvYYsrj5wTaDzPNRh56gCY=;
 b=eTTj/lvx6NG92LfscJmKrqQvJxxIVz1RJa0rMa5l7uLlVFqbA4uKGAd+m4qORHwBHBZuzo
 jNAU26yfC09XKtHsgE+cbspXtTFV0vvJBoYHg45OJloFp3iXTx1vdWyRwcqFQWPb0GLZm5
 qgG9OJt3TrU45jiTOCijvDi7r+ZGP1E=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-J2B377HGPkSYzaDPXLv9pQ-1; Wed, 01 Apr 2026 11:48:32 -0400
X-MC-Unique: J2B377HGPkSYzaDPXLv9pQ-1
X-Mimecast-MFC-AGG-ID: J2B377HGPkSYzaDPXLv9pQ_1775058511
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8cfd8067379so1773774085a.3
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775058511; x=1775663311; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+sRgn2+j+uaaLVeSL/GdSpvYYsrj5wTaDzPNRh56gCY=;
 b=iUuZ1SCag3sBc6f1gn/L4kZlVJp3nXwX8V3DvBqgshSqoWM6tu5sDTxFdibH3VaXOK
 nVrJs1car2JyDxD7CSW4RFPPhwCVEGYZkHrGBQPDxOabrsFgvNCeKD3ceBp00kwExjjp
 JFV1aoU+pfwepfYJXgAchyoqU1Xw6TZztFrpuWljKi3Y/Tti3pJ+sDxwUROcHrccaSHs
 fzdEKGxwH1gkfgFc6KJE1sGA1jaEc98TJ12wduxyg0L5QJMTkrw4MaC/1xdjV/yxKMio
 2hzx60i8+4e5zZmBr6GMDgDoMGcl1x9RKtnhFcyxy0HjmGHwuQDRtCwKF/yJC/5Je3vt
 Nutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775058511; x=1775663311;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+sRgn2+j+uaaLVeSL/GdSpvYYsrj5wTaDzPNRh56gCY=;
 b=kfMpPaM0ZDPNlJLdSY7jL5rxvKST/jEe8n9Gt6YeT4u9ks8HgvMBOmggJKZ1UJDFCT
 UGddQe0LeySvbdxhvxFXrcPLqTalm6xeoKZ35/gmEeccieWlsePIx1+VRZxTTlgIzVXX
 C+wHf6+gFWuwmhca4+Qa4IA2pJQTd7dxPO9Z3rMP7B9XMa7AExnEtP6ek8glmT9XVqEQ
 NE3JYAa9/8j1p6RIICTDQ59x74K49mmAG6YQrHDy2umDPXjhVeA+zva1fbYyo+ncTwKM
 iRtBD262rDD7E0t98VtlsjqUtb/Swroh6VpQa9z9t+ZXvQNhMqGtxsfITra+1WARQ+fn
 YgBw==
X-Gm-Message-State: AOJu0Yx8jq8KlRvNl7sOxMAmiDjlSCaiilnIXniA9oYks7ARem8ffkM7
 kucRJKjNBSp18GyU+XnRBK9zyTcLjMIUqqqZFWIGrurfrZPVbjtkQUZcaaWAdg99pcillxTH9OK
 CdWr8W3QN1L2BhLJHiZPlRcglZpdlch3beWbJB4UZzcKT4ZK07LccEMqW
X-Gm-Gg: ATEYQzxTQRGvtxjShkjd6tOdb+0iNKlDFVYPPl5YnH01R7OL5fzB+yw0rA2PVnGNj1k
 7fnCsklbfYUd+lkDkUCgDR4em75/d1O+ng0mo7UnAa6u1lgwVz3oWXwQ1ZjEbtBVES8Zx6yP1uc
 6FTrewQug56j9rJsPcpt4K0vNr4zsvlaKnoPG445Xukhj9R5T/yx0x+2+RC8Fxdbg7XnqGcK+pQ
 puSk6baC79esxMR+ttbOAThk4xOQq6UwaeRs4FSaHv4u4uK4xOK35dMatyPT9V13QS7S5aQ/d8a
 r3r1QhZKdab8HEggpwi++sFArqacBgI8eUA24prLbQueeoRwncC7Yb0l/S8Ye0C1ABYbhiaroQy
 wa6jwK6KAcbihzdJARV8SQKLK7t2HpZ8i8kQe6VutgBffnQ==
X-Received: by 2002:a05:620a:1a1b:b0:8c6:ca70:68ac with SMTP id
 af79cd13be357-8d1b5bfa953mr625038285a.46.1775058511384; 
 Wed, 01 Apr 2026 08:48:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1a1b:b0:8c6:ca70:68ac with SMTP id
 af79cd13be357-8d1b5bfa953mr624981585a.46.1775058506088; 
 Wed, 01 Apr 2026 08:48:26 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8d2a5392ce8sm8756285a.7.2026.04.01.08.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:48:25 -0700 (PDT)
Date: Wed, 1 Apr 2026 11:48:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Bin Guo <guobin@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 pbonzini@redhat.com
Subject: Re: [PATCH] physmem: Simplify dirty memory type checks with loop
Message-ID: <ac0-SLb8uWJP2VHn@x1.local>
References: <20260401100005.20651-1-guobin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401100005.20651-1-guobin@linux.alibaba.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Apr 01, 2026 at 06:00:05PM +0800, Bin Guo wrote:
> In physical_memory_range_includes_clean(), we have three nearly identical
> if-statements checking different DIRTY_MEMORY types (VGA, CODE, MIGRATION).
> This code duplication makes maintenance harder and increases the risk of
> inconsistencies when adding new dirty memory types.
> 
> Replace the repetitive checks with a simple loop that iterates through
> all DIRTY_MEMORY_NUM types, checking only those specified in the mask.
> This reduces code size and makes it easier to add new dirty memory types
> in the future.
> 
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


