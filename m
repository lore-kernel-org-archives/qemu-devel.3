Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A2AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 05:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfvQQ-0000oJ-6U; Fri, 01 Mar 2024 00:27:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvQM-0000ny-Qo
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfvQL-0003aw-CS
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 00:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709270826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3WNgRLUuiy2vnTmM5kUNlknTkOCRKgj1UogrfFSnwCE=;
 b=G0seoueQME6Ne2bWK+1U2Gbp5PQZEmqUj8mpVePmxuU2nSYbcvFnPI7PoPu0rV6Xc4MAJp
 zGI3TpPkehT1XdmYY69ycdT+aJsTyfPSxBT4S0oAR2iHLK0qy0vyoCUkWCZzbPvQoSVWnl
 DZemBaouiTBzfWBEomRKx6x+nOHTGrU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-uPMFnioUOJCyDsfQdA-F9w-1; Fri, 01 Mar 2024 00:27:02 -0500
X-MC-Unique: uPMFnioUOJCyDsfQdA-F9w-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1dcda4d7cdfso1540685ad.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 21:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709270821; x=1709875621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WNgRLUuiy2vnTmM5kUNlknTkOCRKgj1UogrfFSnwCE=;
 b=BGroae92Rmsxq7Bwq5qVbyDOqe66ljAQM3rqzzuqCcA+kMJhtIww9zM4H1O19E3yhG
 EbzHp0NL00mzUAPZIj4DjlOrEDCDu0dp31J27F3PpG8N4nmZOlPr0wt2dHjtS3fEfOc6
 zZ1QXx5IVAF41dLHiDLtDU8RJwY6mNf1XwaIwlamX4q683LTfCqu+G96CBBvFiF45401
 YDjqNtLnGnWnnabaGwJhRwd5d1AdZwZJ2UDj7oLjy+HLvCay371KmVo8XKnYGNrb66qb
 OIXXrW3hdyiTOKULSh9IcIeIZTOmfhHzh+fHr6bwzn6cwTKELA/Y8eHRHymXHmH+85td
 HN/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfgV+f++SELv6WSbdPNSfygk+i4jdf8GajYeK9m45iUDFJ0yvAi+SeNpRqc/6K1tPDGGqYxqzOQ/8+n5LdrscF2c2u/CE=
X-Gm-Message-State: AOJu0YyElkBeQ6HSdsya7G19Dh/x1+8aZ0+OfFlXsjKDC9S+OSWx7aJp
 VE+v8QPBo+E1V8S6GXDcW2t2Eedo4/aN6kssz3mBvWAst9zClHDLxvLSiKhMm5RxOdX+/Qd9W69
 sKUC8C4pQ45yRgqe1BFYfJR7ZiM/+zyArzDCZy4zVpkgkj+q96lw+
X-Received: by 2002:a05:6a20:8791:b0:1a1:2d3f:c60b with SMTP id
 g17-20020a056a20879100b001a12d3fc60bmr382122pzf.3.1709270821414; 
 Thu, 29 Feb 2024 21:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjbm/CuwRdpIKpVvZYpr0U/eRCBzfg7YbUQ+eujk86XUgwYidcH0AJ8ZQ5YfDNZ7OdyndNyw==
X-Received: by 2002:a05:6a20:8791:b0:1a1:2d3f:c60b with SMTP id
 g17-20020a056a20879100b001a12d3fc60bmr382108pzf.3.1709270821082; 
 Thu, 29 Feb 2024 21:27:01 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 ju17-20020a170903429100b001db499c5c12sm2451092plb.143.2024.02.29.21.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 21:27:00 -0800 (PST)
Date: Fri, 1 Mar 2024 13:26:51 +0800
From: Peter Xu <peterx@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, linuxarm@huawei.com
Subject: Re: [PATCH 1/3] physmem: Reduce local variable scope in
 flatview_read/write_continue()
Message-ID: <ZeFnG2--9Zd6Lv6z@x1n>
References: <20240215142817.1904-1-Jonathan.Cameron@huawei.com>
 <20240215142817.1904-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240215142817.1904-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Thu, Feb 15, 2024 at 02:28:15PM +0000, Jonathan Cameron wrote:
> Precursor to factoring out the inner loops for reuse.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


