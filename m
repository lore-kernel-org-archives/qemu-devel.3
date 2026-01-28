Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E52FD46BF8
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBM3-0008OF-5n; Wed, 28 Jan 2026 14:37:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlBLt-00089t-SF
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlBLr-00052h-Pf
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769629038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5hzHkdO8f5IBVK787jS+Vs60EEEKpakL54jXmFY2ug=;
 b=G8+RbL+FZfIVbcotYSO8oRQ7NpPQ19hmtakIbjBQnrwSne+eJeRpYOAdc3EyWfh3f96Pnz
 P2pU9HLObKgeSZoIMs3no5bdSEj99HGvKY+Gq2Ve7lJR20AakW0NSGIJFx+cXsP/m9BQuQ
 r44ek/nQ5oDHeAJVxeITn3C4n1cPwRE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-oRzeKiToPAa0OCgo3pyNFA-1; Wed, 28 Jan 2026 14:37:17 -0500
X-MC-Unique: oRzeKiToPAa0OCgo3pyNFA-1
X-Mimecast-MFC-AGG-ID: oRzeKiToPAa0OCgo3pyNFA_1769629037
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8946f1b8691so5449856d6.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 11:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769629037; x=1770233837; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y5hzHkdO8f5IBVK787jS+Vs60EEEKpakL54jXmFY2ug=;
 b=YsxpfLplp8rPzQbFdZp91ZtEE8yHaLFgqaWXfdp82Y3wWux7NKI5tvAwKc1vWsQV0h
 8kNEgJY8bIrT4C3CyW5B2DI//8VsmDf6sBQH5VaZlPFZgexAmJSHEgVUGx9EL8EcFSsr
 HTiu/vUMQYa9TuKfTNoEb2IfK+PRWKDRWZGD6ARAsnz+r7mXn6MX0MbhYtGBepRylzfy
 /LLK1y4jc6NhvkG1zhr+7cKsYJbc72GvMP0m+6jE1u8BoT3nxujuixxRgnwUJdex6z5Q
 If4gxVQYTHZF8Bt/pFcr9d3o5HGMy5ZUwJvRbowpGHcZwS4S8RuLaGl1+QwfIdxIC6tz
 nWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769629037; x=1770233837;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5hzHkdO8f5IBVK787jS+Vs60EEEKpakL54jXmFY2ug=;
 b=k3kzCTPd77JGrPRugSl3gVKY/NUdRT1VNcdWel02qJWccklil30nOTJPTTnLYhAe//
 K2dd1vPgh4lPvDhA+yEDpoQV40QtVzgrBxEUVBErwiqb0s2AEZ6qiJ7O88rn2j22rfcR
 8Xx/MZoyW36mw5wMeihtbiutij+/0MLXSkDK9OJbY0z043vWt9Wt90fKU6NVczdJ6Zut
 +EcuEkyj8TB9mhgXaWev4WXbkXZSSQ+oLL2eN7q8idhxCMX8nzqNmV+jYoA+taczI99D
 nJBMq9Y/IqwzSw5VPWcoXqthK+vsv1WQpzyzO5HNbHPBnwnixMjf58nGQOxHP/Pn+QC0
 sMLQ==
X-Gm-Message-State: AOJu0YxNaMmKBOjVQvaL5pfW+bR1ig79lcKjSsMFavX8ZPUDwS/ORsW/
 qMGxWN/anxSROc/h9EalgJkbnEwHzt9fGAKpbQ7aCJBUUWMPrvMezcl4jbKKWnVvHYxPZi746h0
 LSQeT/SeLejMYvGCFoB6zJdMD+hogDgO/cewC1hBG+nuSbwEakz324sMI
X-Gm-Gg: AZuq6aIL+eWPSvXICQ+raQAGb3z2N2EALv+3ligKAgi7vyl5rONBzaSIlssoDUnOEq+
 dXcwiwWXDaXNcCTqWNEgSeSih9CnEVw3eYycyUjeKBsWfw47q4VvBWqWTRl4QomBjXxO5ZXJnz7
 Jv5TFqxJ9o8CWbqYdUndEsWAp+Qma6vciXi/RvnEE5lPidHB3zM9IljLtqdjCwQ2u7KjDgNIiMe
 YH36n12ZY/gZyjzWeo2KCe7SaViA0wzx8EjPZ1OFp0MEp/dMt8eCULawihiy/4lY4wPfvTXl557
 OmHJrwPdNc9mbx8N7viOQk5l2HMWdJX9nGVn9vsGweQJq30WQXLVin2QGOsHziwRjgRMd0B4Qqe
 HRz0=
X-Received: by 2002:ac8:7d51:0:b0:4ec:ef62:8c81 with SMTP id
 d75a77b69052e-5032fa0306amr87141441cf.47.1769629036926; 
 Wed, 28 Jan 2026 11:37:16 -0800 (PST)
X-Received: by 2002:ac8:7d51:0:b0:4ec:ef62:8c81 with SMTP id
 d75a77b69052e-5032fa0306amr87141061cf.47.1769629036564; 
 Wed, 28 Jan 2026 11:37:16 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337ba39cbsm21898231cf.19.2026.01.28.11.37.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:37:16 -0800 (PST)
Date: Wed, 28 Jan 2026 14:37:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 1/3] tests/functional/migration: Use socket_dir
Message-ID: <aXplaxf8LF7CHvMk@x1.local>
References: <20260128142829.25326-1-farosas@suse.de>
 <20260128142829.25326-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260128142829.25326-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Jan 28, 2026 at 11:28:27AM -0300, Fabiano Rosas wrote:
> Use QemuBaseTest.socket_dir instead of calling tempfile directly so
> all tests have consistent directory prefixes.
> 
> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


