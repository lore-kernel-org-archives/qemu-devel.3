Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4FDD34081
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 15:26:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkkxp-0002h4-A5; Tue, 27 Jan 2026 10:26:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkkxZ-0002cV-WD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:26:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkkxW-00088t-Tu
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 10:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769527583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXyCerddt2jwwueHn9OWFBWF1t3sRr0fokj+xj7ybwo=;
 b=S2DAUxQ+hph0EIJqHgVLyTIG0cryt0aLsJURUZ4oUjW6MDYZPa5RsFHkfJypR7KI+XHyOm
 TVEDnQA9OoppjkbFFWNAvansTT9lmFTICQ/r5lH/UPI7HoliZLyTZvB+z9cpZVLpU1V9I9
 QVLdG/01kVILOomBxrw/4jpWNAwy1I0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-cMvsdMq8OMuBBaIWCd4Jcg-1; Tue, 27 Jan 2026 10:26:21 -0500
X-MC-Unique: cMvsdMq8OMuBBaIWCd4Jcg-1
X-Mimecast-MFC-AGG-ID: cMvsdMq8OMuBBaIWCd4Jcg_1769527581
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8947d47793fso304375896d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 07:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769527581; x=1770132381; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gXyCerddt2jwwueHn9OWFBWF1t3sRr0fokj+xj7ybwo=;
 b=WglMGJn525jK6q8BzhCXr4Zp7jR7UVnr7EYmzCAxAhjdJkXLAHnwIWcdpFhv2QX+30
 +bs0k0LOXGaE9Gxa+8EqPhub2E5PCKkVBUEn/AlPS4q9pLFHrUFxCEKRf8zlCGjt6Jzx
 RqxHeWcDYDvI3wAD1SILwHT1p00xKwUx5b6WepXzZkKRz79AEj31LbGpfTmkMkG6lwJ3
 qG3wBZG1REy9VCWxQKVVwRcUbx38fSzrks2+ktkEkX7KIKUvbwBVgJlLbUdPxT03szrg
 QW7fShQ/wQIMVj8Ix4jYqo1upJxjDtr3qLlqCm/WzWC5Qcoizv4SLPgTxGgDSAg1BlOk
 eqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769527581; x=1770132381;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gXyCerddt2jwwueHn9OWFBWF1t3sRr0fokj+xj7ybwo=;
 b=sHxbHaf+GtQLZKmt1rQQ24XVLqZs1IW2TExfTVxGLF2TdddyMc/gSAkekQIFH6qO38
 woacMN+c+ZWTAqXkNiojjLhSYtx9rbJUTfpV81kS1LYNUOqdkWHe+qJh4jJa782e2eJl
 KHr1Eo4sPiIa6UPxiXWGXSc+RGWhNcwZO+evuevrU105OlFfvy7VvmmQfVLJvfdkmgFE
 ubAf3NiR5EcLjbhYiu3VPvWypCn9qvoeq6g9gaLYxK1bRdG3ccmk/BPstC/hgrHcU0yn
 9ywgwlhnccWL9MZr3dDM7AJyjxkxUMZ+m+r53XcZuyo5S4ADxDBumI4QFsnZwIf4aMPU
 71DQ==
X-Gm-Message-State: AOJu0YxOxLK+fvHWkIVm5l1gMHA7ui6S60TTTbfn41bq4oGJpwudx/2z
 SFKM3xM/FbSktkDZz+yDjqUzHg6/UaU8TAckaELCPzggf1bWgDxjM8x2UdmMaXQU90VisTbAjPB
 Ais9MevRoK4bgb056erLBnD4jS4SLGZtxuzTFxNOkQsXlXEXxOLt5aLOL
X-Gm-Gg: AZuq6aK1RLI+NbuoSiyrSX96kq2VGPKA/vzqoAfcxJ9TLIfMi+RdHEc7dJrQaF/YSjO
 ru9HxXDMP2KkZ4ftHbuhlDpp6HWnXi++jyuB8Uz+KRLDr7WKqkRXgyqmAo/vTf/EemtOspKeKJo
 sA3/fUb5Deh5XcMrx/ZO/H9ofkBFCe956laKrj7F6zCIn2uZ3/0c8IcCdXZKdRLxDOIzVvQKRnf
 KGUu+8ahtWpFJ6/MvFHuJP16rAmUsvGLizxY9Mv2hQe5S1GN3tj1J3E4Z+WgxrzvPneFTfYNs/T
 WfR09Zy4JtWPcK/V5P4QIrvamCuDnfIrXdIhGJ53WGQokeLhr4mJOVYvfI/A1pxkyMU21ixk5Ar
 6UgQ=
X-Received: by 2002:a05:620a:390f:b0:8c6:a84e:2a2d with SMTP id
 af79cd13be357-8c70b873f8emr251177685a.31.1769527581082; 
 Tue, 27 Jan 2026 07:26:21 -0800 (PST)
X-Received: by 2002:a05:620a:390f:b0:8c6:a84e:2a2d with SMTP id
 af79cd13be357-8c70b873f8emr251173985a.31.1769527580642; 
 Tue, 27 Jan 2026 07:26:20 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c70a8e55d5sm144504785a.20.2026.01.27.07.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 07:26:20 -0800 (PST)
Date: Tue, 27 Jan 2026 10:26:18 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, ppandit@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2] migration/options: Fix leaks in StrOrNull qdev
 accessors
Message-ID: <aXjZGkvWaGeyQCwt@x1.local>
References: <20260127150916.23329-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260127150916.23329-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 27, 2026 at 12:09:16PM -0300, Fabiano Rosas wrote:
> Fix a couple of leaks detected by Coverity. Both are currently
> harmless.
> 
> - set_StrOrNull: the visitor should never fail unless there's a
> programming error and a property of different type has been passed in.
> 
> Change it to only allocate memory after the visit call has returned
> successfully.
> 
> - get_StrOrNull: the whole of the getter is unused, it's only purpose at
> the moment is to provide a complete implementation of the StrOrNull
> property. If it were used, it would always receive a non-NULL pointer
> because this property is part of s->parameters and always initialized
> by the setter.
> 
> Assert non-NULL instead of allocating a new object.
> 
> Fixes: CID 1643919
> Fixes: CID 1643920
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


