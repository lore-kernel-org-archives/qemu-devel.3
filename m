Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C674DE81BD3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 17:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpUj5-00009C-3d; Mon, 09 Feb 2026 12:07:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUj3-00008f-30
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:07:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vpUj1-0003Uc-JN
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 12:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770656822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O6bUGLPtUhjWHmqSlDx0H8pYT8xRIflvdhDporgHtlU=;
 b=NE9fFsd6U4nSvOOi0nRVypzxeb3Td8NEH58ZE4Zdvq7Ne76VGv+bGHSddT7iJJIVM8pQot
 RXjS+uJf2qKOsFMSJ9T/srWRO8Jz4OYm82OU8AgWjzL/y/D52Nofl8yrmCpzOYSxPyBFQw
 /BDSwzrYFnu2Kq2GHtsxjND0MhhLVXo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-m75KqmXoMYOxQ-GUMq6-yQ-1; Mon, 09 Feb 2026 12:07:01 -0500
X-MC-Unique: m75KqmXoMYOxQ-GUMq6-yQ-1
X-Mimecast-MFC-AGG-ID: m75KqmXoMYOxQ-GUMq6-yQ_1770656821
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c70a62ca32so1379991285a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 09:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770656821; x=1771261621; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O6bUGLPtUhjWHmqSlDx0H8pYT8xRIflvdhDporgHtlU=;
 b=J37ZYwRSEuIgUiZY3CnGW017DLrklUiaQABCUQYtbSclPqDnn2hCMP7+nKH8BYrvwX
 oiZlEDBqDA1Dw/AeCgzIetP5cnUb+ucgO5tKwRxw5GgIFPA+cOkE+SGyosGWnaAAO6yK
 mzc0TRWZjbhFDAU+GEThz+jXaimkD3zBljzFKgo4KvRAZGKyp46o9QmaoA+FGrV+/9O1
 uxbYl6IzE0ai/ABjV4HvnQOvFKDKwiGD2rF4FSjXTxk7Zkg6Cmvcn37nJnl9mqsdXTGE
 SsA6z5xkk1Hdp3P0cQ3M7gW3rKTxj1dj7MQm583aqxqgMFkhQmdg8NIza+rAqABeO11u
 v4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770656821; x=1771261621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O6bUGLPtUhjWHmqSlDx0H8pYT8xRIflvdhDporgHtlU=;
 b=ogK4VfXtrYJInLKVUbEQgOoP6YZ5qrR4RRQLTkzCmMAtqOGeFqraABYf8q5glVvOZg
 z+RSGfwpLuzMoPFntYsRotX8B9w83NHAt6lwkv4ZzrBN7b5FN4MaTF+GzfUID2yOG0j8
 tr6ovzrgRbGXH/ETdwXEj0VFlf/ZvTdQC8rnsBZTFdn2JxuZtTodfim0K0Ka/5UAGnrc
 Frtxoz4992/jfj/yuOdoL4gfEDCursaU05Joh5YuhuRL9rQ6u+WyOL33seyxBs5I+M+n
 bBZd7EWWVvAydS2Cxr3S1hgTpwYtQ51AAWVKiivjNR6bKg99NfKluk3LvfBb6RDCl+uw
 ynpQ==
X-Gm-Message-State: AOJu0YwnlxgA7lKZs/C6txd3n3rni0hrtIubr/oJYPBNk75477C+ucvJ
 tpAgMtgMvoAow8YDXXKF+6HklEHe8CoZ8Ozj6WWZKR3srw1iz1dnAC14CHLNceVw3bY7BWpxB5m
 hCmXBVIhpl1ez7TQ2aSSXSxbcQA3TtaelWwwWi91OsW15ZZ2iCOCDAeMH
X-Gm-Gg: AZuq6aJ13rglJepCbuiNr2QSR382LqJ7I6M3dNIlew7EC0Gw3QYEsXCj2+tB9N5zNXu
 /S5jah+JQw+M6PtI+5LCREsMziYH+hXuSi2DxEIulm03u+oZPH8ZjmK99TKjeehonCuxc08AVsc
 RKPZW+BImDSE/s/D38eXN96b4B6EDn94U8UhzF4DYGmkyie5vinSyvvpo6nm+Rszv9k2h9KsGl3
 ocy6N5VYXojyUQsi+AB/SLr+A4Hk1rSzLsAXEBSfyuQtSK1sqXndDqs1/GXXeQen70XAvg8gRu2
 Xrwyp4wMkXelNcM7RFlU0sa59szWQRx51QTKRuEOm+aqj7Xj4mc2NiksqQENGLNLNNmj62aDu7f
 xuRI=
X-Received: by 2002:a05:620a:700d:b0:8be:6733:92ab with SMTP id
 af79cd13be357-8caec1bf257mr1680955685a.0.1770656820535; 
 Mon, 09 Feb 2026 09:07:00 -0800 (PST)
X-Received: by 2002:a05:620a:700d:b0:8be:6733:92ab with SMTP id
 af79cd13be357-8caec1bf257mr1680949485a.0.1770656819978; 
 Mon, 09 Feb 2026 09:06:59 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9fdf739sm836124485a.41.2026.02.09.09.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:06:59 -0800 (PST)
Date: Mon, 9 Feb 2026 12:06:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v6 14/18] migration-test: Add COLO migration unit test
Message-ID: <aYoUMo68YX2ry_At@x1.local>
References: <20260206-colo_unit_test_multifd-v6-0-27779dda139d@web.de>
 <20260206-colo_unit_test_multifd-v6-14-27779dda139d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260206-colo_unit_test_multifd-v6-14-27779dda139d@web.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Feb 06, 2026 at 09:03:12PM +0100, Lukas Straub wrote:
> Add a COLO migration test for COLO migration and failover.
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Tested-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


