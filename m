Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505ACC54798
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 03:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reRPQ-0004ie-A6; Sun, 25 Feb 2024 22:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRPP-0004iU-7f
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:12:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reRPN-0002NU-Te
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 22:12:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708917121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J/SUvStaLwiIjDXSAWtiu59vdUUy7r/A3xmqtXywyvk=;
 b=O1d32q+Pr21MD5bwgkdjdkJwjX+GIiwPIe7N1icJ/fg+iZ/yvRzJansNWp/0x/Zn6cGIJT
 xspsd46bxYwuRnXpBLJu/CdbbvkToF0wqdO+ZYFu6JeNPCWpzlYXX/v6Ym5hevOFeJsQ5Z
 YaxkaF7OSRXiuGuuhhAe/oZ9/K4pPlA=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-jTErviAAMm6Yf3Mz1af1hQ-1; Sun, 25 Feb 2024 22:11:58 -0500
X-MC-Unique: jTErviAAMm6Yf3Mz1af1hQ-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a09744e5d3so6168eaf.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 19:11:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708917117; x=1709521917;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J/SUvStaLwiIjDXSAWtiu59vdUUy7r/A3xmqtXywyvk=;
 b=biKkzlIQ1Y7Occ5fotB0pSjsWMpcPZGNsaHKQDr/sbhMVr6ZZgD9yKD3FiCvf66Wtq
 iQ50nHTCccTG9UuYiUal7ELjJLq0ITjLtZE4ECqQgerob/VtffVahzKGxBwVGQWWXMz5
 dLrUhnIlV9nhK5mLlRXVoo5lwrMbIrijFxCsLZgaGCGa4rrRST4i64DFmksczIcEl/K+
 1qJbQ3gygA1Lgd/4XjGQMuFeblLhN6KzcRU+Pe7FLQEgVsmm+Tbomanqa2AfryOB97A3
 OGNDucwmHRHQsnL3NYvdk93yJjoV6HRd1dSh33ZYhgiQyWiZ4EOpVHhgEyvGtaH/+oIX
 N6kQ==
X-Gm-Message-State: AOJu0YwLYCvKLoPnxZuhjR3bmx2jSDbhZJOrClcf15wIMjsjpUvxwAmK
 Jm3+5BByg+JrJobrATb6jpO8X52sN58jJQB0uMccUh3Emvk8jftdQpPhDQvuvhQuYA4SByMFFPc
 QSAA6Q3Dh3TdRGPnDuqvP7OQnBPyTl8iyborF3ewrl1AdzIWtU/fp
X-Received: by 2002:a05:6358:5920:b0:17b:7e8a:cb6b with SMTP id
 g32-20020a056358592000b0017b7e8acb6bmr3636627rwf.2.1708917117633; 
 Sun, 25 Feb 2024 19:11:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEE1WstG3+2Ql9HKjoeiojgAtgXkdVQ4Fohi9PC1vWud8HQlczMMU3JfB8rwYo8FvShpC1XGQ==
X-Received: by 2002:a05:6358:5920:b0:17b:7e8a:cb6b with SMTP id
 g32-20020a056358592000b0017b7e8acb6bmr3636616rwf.2.1708917117276; 
 Sun, 25 Feb 2024 19:11:57 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 hq18-20020a056a00681200b006e465504e14sm2929124pfb.2.2024.02.25.19.11.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 19:11:56 -0800 (PST)
Date: Mon, 26 Feb 2024 11:11:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v4 12/34] migration: Add fixed-ram URI compatibility check
Message-ID: <ZdwBdll3EO_Oil66@x1n>
References: <20240220224138.24759-1-farosas@suse.de>
 <20240220224138.24759-13-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220224138.24759-13-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 07:41:16PM -0300, Fabiano Rosas wrote:
> The fixed-ram migration format needs a channel that supports seeking
> to be able to write each page to an arbitrary offset in the migration
> stream.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


