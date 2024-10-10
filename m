Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE55D2444F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:48:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz118-0006TL-BP; Thu, 10 Oct 2024 17:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz110-0006T1-TS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz10y-0004MS-Ue
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728596888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MGwbJOf62A8hZORjm8ir0dIkgzjBn+WAP2ZIByACa8=;
 b=T1KX2ooAlPk9bac5fvPHrkr2JZsRnWbAaqItmo6CLTHyT2xxlZiPyLcqOIu6+3ssSJInJ3
 4plta2QYFDr4WdG6fdRkYFzDN79Tjf7FPvxqYQ8gxQYq8OVhwcD7QiaGo7/e8PqYAjMquH
 rOcC9j0asGx5BGdbTbAGrv5Fvtg5gAo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Zp2ST932PBKLB9WJwDczwg-1; Thu, 10 Oct 2024 17:48:06 -0400
X-MC-Unique: Zp2ST932PBKLB9WJwDczwg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7ac9b08cb77so239851185a.1
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728596886; x=1729201686;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0MGwbJOf62A8hZORjm8ir0dIkgzjBn+WAP2ZIByACa8=;
 b=bCWXLSA8+m6kafKU3DmTrKSUwzWVd/3EdkYGXeGCXXw0ZuU4JbXF+UgmeFAi1jFtcT
 lE+iGqNkOW1IvHGBoHiGS/jqPx/uN4tbB3MVcCoMkTn+5ic+EQE9zcpJ38hohNIA7wqr
 sdPUw0uHmUqwS4U/LGVSMTq+U0VZ/hWRbCep1enCsFkjCMbwFcQt5pCQ0r/46uPv/6P0
 t3pAhw6eMXziEAlTTCltKpgJfc4tdvFjGj+11yPcII7Wcae8MjFlfoGVVHh21UBVdpjR
 iRraiRNYbDe1qhRYbgnZiOubrl7LEbzfFd49ag1l1vQ/norD3EtfKCrzex8iVZn1oAtp
 pOyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhrNH/hVnWhO6Dl0+JBmV/Ug61bBrFawV98n8jUkBCzPGhn3MduEnmTk1b5PnX/6B875wQXLwPeLHn@nongnu.org
X-Gm-Message-State: AOJu0YwL2go8FAc7Nk8JgexS1T7IDBM/p8TY0NDltSpgOlV1Ezq5ACXz
 pGuUmMP+qeqk0gBC1vc/6STY+EwyGc8eNOfG1fd33fAh/GAaYDJzMIFwFrR0CU5Ys3VPrY8JixN
 Cl8NmhE/seoW0FGMBEQqofja4YbzWSR9cwpI0BdFTuoKIlgnhKXRk
X-Received: by 2002:a05:620a:4105:b0:7a9:c04a:f5a with SMTP id
 af79cd13be357-7b11a36d503mr73596885a.31.1728596886098; 
 Thu, 10 Oct 2024 14:48:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzyn6II4uk4Vl5GirKWPdzKaaSOD4HGBDsBZuwr9a6vuH01Jt9g4JJmUb/wj9aQA/FqpVmxQ==
X-Received: by 2002:a05:620a:4105:b0:7a9:c04a:f5a with SMTP id
 af79cd13be357-7b11a36d503mr73594985a.31.1728596885737; 
 Thu, 10 Oct 2024 14:48:05 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b11497ae39sm78903085a.109.2024.10.10.14.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:48:04 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:48:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: precreate phase
Message-ID: <ZwhLkiGZZNypGb3P@x1n>
References: <b57f8eda-d0ec-469f-8ac2-635f3c8d238b@oracle.com>
 <670f63b6-529d-42ca-9a9f-acc6f3f07c18@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <670f63b6-529d-42ca-9a9f-acc6f3f07c18@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Oct 10, 2024 at 11:19:15PM +0200, Paolo Bonzini wrote:
> Moving migration_object_init() earlier sounds like a good idea anyway!

I take the last sentence back of my other reply - I believe I
underestimated the potential reviewers of the upcoming precreate
patchset.. :)

-- 
Peter Xu


