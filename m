Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCBEEFCE3B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 19:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxrc6-0000Mi-Bg; Wed, 04 Mar 2026 14:10:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrc3-0000Kv-Gs
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxrc1-00005x-CX
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 14:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772651422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D0fD55fcz8KZ4PtgIiEuNTP5Fw4Mwe9/ywY1K2zb/Kg=;
 b=Mcs7K6eSl8NqmMgN0kc4AFD8Xk9fogUDrFYoykk3bzwpIOTHV+HDC1OYCCFRNikQZd5FXV
 fzRdlw9YSQ/JAwncZXWrp9M1/+oPXC1gj767Qs1i0wyk8KU8c/Ujbo413qY+zRS99GIO3J
 LLgSvjEKikGhL5tgt0MiWKqS8eUtZ6A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-9XAJPJjTNIShfAG0uX_O0A-1; Wed, 04 Mar 2026 14:10:21 -0500
X-MC-Unique: 9XAJPJjTNIShfAG0uX_O0A-1
X-Mimecast-MFC-AGG-ID: 9XAJPJjTNIShfAG0uX_O0A_1772651421
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a178d7270so44330436d6.3
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772651421; x=1773256221; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=D0fD55fcz8KZ4PtgIiEuNTP5Fw4Mwe9/ywY1K2zb/Kg=;
 b=JVjHT8cN+ExJ9HP3Zhb3KWAgHTYWxds+IB+ZRF8nEk+54LHLhlEi3g3y8aqzYlVZVp
 q/9GmGnCgBRyZvbppqjjRrtgsZ0I++cBsqeGt44LCDrXwHBIfQ9xhB7akDsVJ6xBnYS6
 +oPTqnBxolQASNXWeSpqZQofDRx6mr9uu8mSHieoivc7tERcmsK1n/mPmJ9tSX3VO+IT
 xsaCjKBZdD2QPOFNlbJvlvMP4vwBcuUhsCJ3ZBtOfpMjksigNyxTN9lB8a0d2988CP3d
 LNySQMCPKajf/CxCw4Ljcf3mL6potcgM/53nhhKrukKxQ7cKR059Oskf5jpFWuhbNurY
 4NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772651421; x=1773256221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D0fD55fcz8KZ4PtgIiEuNTP5Fw4Mwe9/ywY1K2zb/Kg=;
 b=tIcXdScroSBVJE/Hw8KDtUjzcvlvNPyQOhEJhnLYuKX+4uQFeH4xUe7QJvXEzGeGvW
 Fjl+TPduvQHuhDcCKyZzTPrnGPihsp8+xk+AmQV71FwtMXtkmBZJfuSM5o0UhJGw5ofy
 an88Dj7XUnAXxUrdlBPnh18fqWIwm3l+PV+A/nXfkJXEWrtSeB5RO+dEpGYCrlW6pFwu
 q+6uAAWzWuaC6bJnUxUY2mdzPoCBA+ajdaqABEHukp+54nvxq9SEod8mwX75CrguyJBv
 /oiAqssfLk2PDCP6NkEmkFB1AKoCgX0yz3t8jsxs551ZPWytyUba10bNR0bVh9dvlKOB
 T8Uw==
X-Gm-Message-State: AOJu0YyFT7O8B2nNDF46Zvboa4XD1rQpqGG62ZCtS7+ahxnzPvnON8yz
 8VXfOrTpQ1SKem6EMeidSjZ/Y7lLQikaHWldFbKAX+avUAAkyB53KyrgKNDG7TNwBhqGYNshGyp
 hd6hPdAPimCF1FIITnXuW9shxQIxI4/wdf1urmy6hEnwi9eZz8FxmLs9e
X-Gm-Gg: ATEYQzy1KdwHpOaBNSEC9ZWIEJOR4FFWMeoYjgkWYr7YtLR/xkxMjP7gfVcfFCsddnZ
 Tn+USD7hahH6VoVP4G9EQkapsaaeCMN2AnbXThofGI0NMLB6X8rsANjcZ96OvwPI3r3Y/iQ7+kj
 eHNJNLlJm3GnYygLEBCX3PRMxjBj9Hxl3DUIRRyDObj7FcItOUYQdI5j2lTzS3CCG3WNQsU39rz
 I/hGWnz80DeQhxyoPe3g00eAUj8c0r7SPK7XRVyaMw6+ZYbPlVC+MLEnKUlGlodDbraK61HjTp4
 Ru1nzqd21lDhBj5/PqPbZ3sfZUJv/9EyD7dsQ+mVKa5BtdQJylwuBypr2lCvNy4NGBc8vpKGwo3
 VxCgVYyu+LkVZbQ==
X-Received: by 2002:a05:6214:dcb:b0:89a:1116:b55f with SMTP id
 6a1803df08f44-89a1998b398mr41124696d6.7.1772651420612; 
 Wed, 04 Mar 2026 11:10:20 -0800 (PST)
X-Received: by 2002:a05:6214:dcb:b0:89a:1116:b55f with SMTP id
 6a1803df08f44-89a1998b398mr41124166d6.7.1772651419928; 
 Wed, 04 Mar 2026 11:10:19 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-899ff659b75sm73282246d6.34.2026.03.04.11.10.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 11:10:19 -0800 (PST)
Date: Wed, 4 Mar 2026 14:10:08 -0500
From: Peter Xu <peterx@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 sstabellini@kernel.org, anthony@xenproject.org,
 edgar.iglesias@amd.com, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 3/5] physmem: xen: Conditionalize use of the mapcache
Message-ID: <aaiDkBwlttHoWRAR@x1.local>
References: <20260304015222.979224-1-edgar.iglesias@gmail.com>
 <20260304015222.979224-4-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260304015222.979224-4-edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
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

On Wed, Mar 04, 2026 at 02:52:19AM +0100, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Conditionalize use of the mapcache. This is in preparation
> to optionally disable the mapcache at runtime.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


