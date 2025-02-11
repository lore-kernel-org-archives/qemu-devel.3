Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBEBC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 19:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thwHj-0001Iy-Ug; Tue, 11 Feb 2025 14:51:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwHh-0001IW-Um
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:51:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thwHf-0007V2-C9
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 14:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739303461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FGGQZiI/+QX1IiGDicvIlHZ2msH3PaXToiABEXGO4E4=;
 b=NaF5IQhHmOCign0j1EUa3+bKgHfIxjdbelsLOw9OZWez4k+tFxr2INa95RHq/CscKTaj+6
 2x9wNBtdigcwksIQwbrWHLBSXn/VgCQufB2PRYqW0zARvViIAU4amaoMz1gK/kfwJP4Y8l
 V6gKoyDes+iJenL17uggf9cr7wbzAIU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-QKO8i908MIWI-a7adGlJrg-1; Tue, 11 Feb 2025 14:51:00 -0500
X-MC-Unique: QKO8i908MIWI-a7adGlJrg-1
X-Mimecast-MFC-AGG-ID: QKO8i908MIWI-a7adGlJrg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7c05f4f174cso21907885a.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 11:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739303460; x=1739908260;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGGQZiI/+QX1IiGDicvIlHZ2msH3PaXToiABEXGO4E4=;
 b=IKntYM0qmP2WAQ0fS/vDHIHDNm5LY9VKxWFFFbsF5iIb3W3uodtIblnZZtyyGhKYnY
 g9Q2YmZC1fx2Fkimrs04LCi+ajV0ogAdPeBXZryX6WoILsXYZC///wOWzZsfrAXsxS3Q
 nDb0S2nHU3w5P3UaUxHiaumBlbtPjPXy4F3rjuvNt1o/JKjRpF5GDnVJxA1g/mWqzhkJ
 T3HI90imtECDyEPYdMCihB5fj5mqzc6xTagSa5l/g/YEDgIELx/2R76suVcEPfU43cln
 lExN4E9/k0hcXZaYESLanqHECw5wfWkgNzWmo6xQHMbLgejN/G+StFylV/S8Okb4Xplu
 jLAA==
X-Gm-Message-State: AOJu0YyBiWYuwnzK1DyebqFVJH3da43SGH9O0FzcLqGVhFQaFZGsr50b
 uWI1wWoabv3GA7UhRuYUlE1FM9a6TYswfQ7bi617dlm761SM3/LkRZiXsTSWn8ienjIUQNRab++
 e9EeClChCmDltL4p9LMTfOQ9wIDRUpoNCzHM2uE99I8bp7kDUyR59RfzZmC+w
X-Gm-Gg: ASbGncsR4rFMbVPPXqi34LIkZzkevoORAFNgSfL3hnlHG8N0o/OCHlPdFKQMVoCSEWF
 x7VTCw5Gdezp3FJh2MhEcle9a+o4NoQhVpgImI/ITKqtNbt0yhCJMINoCXKKF5pNOLJinn3ni7o
 LSpr+OYYs/TBzG6BCXJSYS/Jt65j6iiGIjMV8DY6hgWTvij2zCkY7AfgcYd35XayZgDn3wbvTzX
 7LU1W83dedLWKIBJLmUX2I/IvFPcf/zPqvDGgyCxlv15mxNqtETDuB3Who=
X-Received: by 2002:a05:620a:1708:b0:7a8:554:c368 with SMTP id
 af79cd13be357-7c068f8a167mr725833285a.6.1739303460151; 
 Tue, 11 Feb 2025 11:51:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZy5dYKCnVGYZypzV/7vwdkMejAVxJkFIA4lhvW70CymGWRGXUFee7Wts9oEEgHU89z48H/Q==
X-Received: by 2002:a05:620a:1708:b0:7a8:554:c368 with SMTP id
 af79cd13be357-7c068f8a167mr725831085a.6.1739303459916; 
 Tue, 11 Feb 2025 11:50:59 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c056b42b89sm422191485a.69.2025.02.11.11.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 11:50:59 -0800 (PST)
Date: Tue, 11 Feb 2025 14:50:56 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/9] tests/qtest/migration: Introduce
 migration_test_add_suffix
Message-ID: <Z6uqIEinMqNISPuN@x1.local>
References: <20250211150136.6781-1-farosas@suse.de>
 <20250211150136.6781-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250211150136.6781-8-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Tue, Feb 11, 2025 at 12:01:34PM -0300, Fabiano Rosas wrote:
> Introduce a new migration_test_add_suffix to allow programmatic
> creation of tests based on a suffix. Pass the test name into the test
> so it can know which variant to run.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


