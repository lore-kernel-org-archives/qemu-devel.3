Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F473E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:23:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF5T-0004Di-T4; Mon, 29 Dec 2025 10:23:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaF5S-0004DZ-Sq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:23:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaF5M-0005Gj-Na
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767021780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M2exg5rLLyCD9sA0mNQ4cIKkHCkihxxzdA087LGVgFk=;
 b=CIP1kERY2t2P0Rw9qETW6wpOlGWVn3f0/cH5D42lOPIDOeLOvx+pMBnX9jx8VgLMlCRwzz
 LfsOu0jgcxik5lfAtZ8bNw0S4Q8dmprwC0zdUUpiW52bCuTtnPA8e7jjVhzLKFNUi/wNL+
 sbxWNLSjdtmM4e7TOgkJnqpzVOl78l8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-CF4-_sgIP2q2Wi5YNg3S2A-1; Mon, 29 Dec 2025 10:22:58 -0500
X-MC-Unique: CF4-_sgIP2q2Wi5YNg3S2A-1
X-Mimecast-MFC-AGG-ID: CF4-_sgIP2q2Wi5YNg3S2A_1767021778
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee3dfe072dso243276301cf.2
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767021778; x=1767626578; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M2exg5rLLyCD9sA0mNQ4cIKkHCkihxxzdA087LGVgFk=;
 b=DoTr4mLQLth7EX9LWLoUgmk9qpNZWm0ICCYBkoD764QP3mfWeGPlz1W9BpxdvLczE+
 F5CZYwqeDErMAsX8Q94woWWrAJkRXEwUxPqKO3WylXngBx98QdMfTpqolySDKQ1p1vlp
 eo3eWnGYR4Jkrbdwn3xSpBVsgm5v4Gqh0JIzP/auryrGzRTkqoUkcD29bwFtGBhcn4CJ
 n2VYoUJxF0ZohftugYG2DtlUN8w8XNiA1H+1qTRzeUVGP9+l7KM8dPylFWkmY4hq4OnH
 li6e6vMcfrEFixLZOMu+JeQhW9zbWG3jrgsAPBMp+NosNq9w1jAY5/sKRmndB38qtuP/
 tWyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767021778; x=1767626578;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M2exg5rLLyCD9sA0mNQ4cIKkHCkihxxzdA087LGVgFk=;
 b=IPa7aLr6ECb5u/SCCJxV4rf669Am9/sEVBBGdTah09AjBajwRz5PIOHyLqoKaCyrml
 sbcoiX4u5MUfjkYD1gGA7fwx7YFOFvywrSu2YMICKq5Vj2m4iclda1XkDdjxMxzTWC74
 Uys/vSRImh67cU2TCebvGULDAvDnRWR5+UWJXIR9K7pY1hIn74Llc8L11YxRMJDYwV8J
 afYDf7l3T9P706Hoa/QyLqQSN7kREyE566rXsVlE3+5p0yI7J+E8HZr0Fa24igzOvU3n
 zlJbaPhQQksDEeLTf2V9Sm40Gbi0f8qowZ/66IklkgIa7exmMgkHHkYFrzl4eK96eJAh
 ZNQg==
X-Gm-Message-State: AOJu0YxMP0GWseaun2W4AMIi8GS9yi0TVP0tgrir0GxMttYvUnJgLk4O
 f9VO5hfO9Lqdm43v6ys8ye1t1VLsNqSrKo5bQ9lmhgUajo6MrH1FhJpBgjMN9saH/YrU9m13JAR
 UYyMkAj20WKsRurcVDMxs1zE1Vag8gCmELRDVfewOkDknY29EHcqlMDPE
X-Gm-Gg: AY/fxX7exn9gT2QFAmtTxlzUvwqk1vYBKg7pyovjHQfHQrzV8zrRPcEJZfQTe4XlZzr
 mYGBykcslDPlef7t1BwGuQRCAHcWslnqrwxB+mwR0MtQUjh4roh543ZGY9gFCbzdzvB6HjsHR2q
 v7Tol4eCVEkI2tbHcRml52RM986jxTUVWGeXwWf8C0VR+ezoxtMW2dw7n/DMkI4k7lItpFlZNgf
 IfU0F6hn+HGQ5oOF1HcofK8Qh5GgCSTFPfaKrnGj0N50zqS2F3wjw2Qwg/BZRoopGZ8XJJUoGs0
 6/UZb4xOKjUCngPao2SmRItUSQkMAFS+Ng9vxCXPluwu6VaMswW8YefcPy4tgictTkY2VUZQI2A
 7gEA=
X-Received: by 2002:ac8:5a4c:0:b0:4ed:6782:12c4 with SMTP id
 d75a77b69052e-4f4abcf8dc8mr485360201cf.33.1767021777648; 
 Mon, 29 Dec 2025 07:22:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2mqos8U7PcC9Nz/aaDgObY7BBwzML+ORQrwFD0kS8cJX7+dxitGN5dOAsd+BJJIa662mdaQ==
X-Received: by 2002:ac8:5a4c:0:b0:4ed:6782:12c4 with SMTP id
 d75a77b69052e-4f4abcf8dc8mr485359701cf.33.1767021777059; 
 Mon, 29 Dec 2025 07:22:57 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f4ac5649c9sm212851921cf.14.2025.12.29.07.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 07:22:56 -0800 (PST)
Date: Mon, 29 Dec 2025 10:22:55 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 01/25] migration: Remove redundant state change
Message-ID: <aVKcz4Kf57_KIsJc@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 26, 2025 at 06:19:03PM -0300, Fabiano Rosas wrote:
> If local_err is set, migration_connect_error_propagate() will be
> called and that function already has a state transtion from SETUP to
> FAILED.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


