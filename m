Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73F7C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 16:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCiQl-0005cH-KR; Thu, 30 May 2024 12:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiQj-0005bw-Vg
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:15:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCiQi-00010A-7S
 for qemu-devel@nongnu.org; Thu, 30 May 2024 12:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717085702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wuTxd4CIcPOa4KW8bIPFGRGkoyM49ozxglLMZt68z0U=;
 b=cnXIcQXLBUaPoLzy5E2znYUx0/KSXX2dIYPMRSa5SFclTzWMfyeouBrNiTmYdEqenIEcpd
 dznVuPzQmnOjJcSv/Ic2ee5T9CIeKEXu+r7Rt4x1jteSR5CTLJSUFmq/dYG2u6zpxDS20r
 VAvsftvQHPiFcNRoXnFuKYzP0XFoJks=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-ztUZF_DBObCrfljVs6Ukiw-1; Thu, 30 May 2024 12:15:01 -0400
X-MC-Unique: ztUZF_DBObCrfljVs6Ukiw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6ad949c9d31so547616d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 09:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717085700; x=1717690500;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wuTxd4CIcPOa4KW8bIPFGRGkoyM49ozxglLMZt68z0U=;
 b=oWmAJpmUJN9Oqgom3e4wKdbEjUvLLQN+38klVq+d7mDOOJV+xv2b56YGk1vBu+Vagv
 DXGYqaDGyxVVGjkW13urEkR2afXIjBJzXbaIcsRLTyH2v2yT6QKnt22Kg8qWSTLqVGAJ
 IRRHcTFLrsQ2t+aOke9Jl7f4aNmXTMOxS7PCdgBhagCVjKU0o53gwfmqX09XT3pn+wEb
 PtmqBHTrlptzCZNCk4AEzUma/nIuZp2fDL4vLDLoQu9rSPVOC4Hj978zyA4ZMaMu8VkU
 3HAtV84vW30ehSGN1FmMLISzhR5UkFVT4bZ5DaAzvOQY1VEsoI4jP3G0eUHJPdtL4hm2
 I9kQ==
X-Gm-Message-State: AOJu0Yy8nMjYjvLILdPLfUNQLUPytYRg3GgqxoK1FHCI2cT5ZKSbdEZF
 BsnkEUDVnQnF1hEg+FTK8M/0qWBVQZQhG2ZWTqPCemoJmS7j3egt/IaDx+wY1sBof4YbWXLe3Ne
 /fu8u95LwcuASZhTYvQv2LRp6TSo+OBF85+nflb06WsruZxCiiUmI
X-Received: by 2002:a05:620a:2949:b0:794:ed66:ae74 with SMTP id
 af79cd13be357-794ed66b6c3mr171695885a.7.1717085700267; 
 Thu, 30 May 2024 09:15:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGehrMY+lXlvrq1u8ZLD7xYmXhZAl7SsA8lpffLgoriHkE6zm6ovxQhqzoDSA7PJ1Sgqu8bsA==
X-Received: by 2002:a05:620a:2949:b0:794:ed66:ae74 with SMTP id
 af79cd13be357-794ed66b6c3mr171689885a.7.1717085699493; 
 Thu, 30 May 2024 09:14:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abd063a2sm565212685a.98.2024.05.30.09.14.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 09:14:58 -0700 (PDT)
Date: Thu, 30 May 2024 12:14:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/18] tests/qtest/migration: Fix file migration
 offset check
Message-ID: <ZlimAZPr75g3hlqF@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:32PM -0300, Fabiano Rosas wrote:
> When doing file migration, QEMU accepts an offset that should be
> skipped when writing the migration stream to the file. The purpose of
> the offset is to allow the management layer to put its own metadata at
> the start of the file.
> 
> We have tests for this in migration-test, but only testing that the
> migration stream starts at the correct offset and not that it actually
> leaves the data intact. Unsurprisingly, there's been a bug in that
> area that the tests didn't catch.
> 
> Fix the tests to write some data to the offset region and check that
> it's actually there after the migration.
> 
> While here, switch to using g_get_file_contents() which is more
> portable than mmap().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


