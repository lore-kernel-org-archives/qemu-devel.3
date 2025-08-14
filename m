Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FA4CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 19:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umdHS-0005ot-Es; Thu, 14 Aug 2025 15:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdHP-0005ns-0T
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1umdHM-0004jN-Of
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 15:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755198382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uUL1Eo9mLwPqwkgmqo5zZ4C3h62UuS5naws4XvSgNGI=;
 b=KF8h++2utZz+OqCxPWuxXyfOhJRai3Eq6CHjc3xUR1lcDWiCLCF0svyP1I2yYUztXeXoat
 4bcbPN/CR55G9LFJmoPPfmAQbEmo0K7LRu9SexszP+hQ+89BNvn07MyuYbBlFsaNbip9pX
 YGkePls/vegdh3/QH0Gntqq5+TD9Ryg=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-wri46Wp0MVaK9L5ZWJWa6g-1; Thu, 14 Aug 2025 15:06:16 -0400
X-MC-Unique: wri46Wp0MVaK9L5ZWJWa6g-1
X-Mimecast-MFC-AGG-ID: wri46Wp0MVaK9L5ZWJWa6g_1755198375
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e9321ed5e3eso1192942276.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 12:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755198375; x=1755803175;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUL1Eo9mLwPqwkgmqo5zZ4C3h62UuS5naws4XvSgNGI=;
 b=Zcj9mXaKOe1l0f0Dcv7I72YwHSILkiN97MvTwUvP6Z65ZKFwNLQ+HrJME9+bgylYOp
 RNyI61IYKUldyEGdh9uIdXxD3rPpjsmEMN408ECJFNv92hkJPcQU2tCFZ+aHJ+q2p3PN
 9Y1vgi36DUZ6U5Ptf3StJTqPb7UgExupW/VEtPe3kfqxqooPCZ8rYLQyAHz6B0tu0i1A
 WtlAEV7uiErkwh0BnCGCRrpde0HmaV1oXpGQnoMLRosNvYa2j/0SaoXQv0emhC6irjB9
 jlBjJAVk6RJJ5dYW8QLamhp9RRArx0G5/8E0nnYySVWssIwJloSziPxxwJ2fsI47GMAZ
 h9UA==
X-Gm-Message-State: AOJu0YwIKaWsDb9uZfdc5PPz5/5TOfPNJLyvAYuGaSM7KPozv+dhebww
 LPoydWa3+6YosUT4Z/32cNqwGizmt4ot8zH9JQCFyA7kbePgOLceDMGzLtRiVPEUnzPASLCpvg4
 Pm22a6gjLKAbVHau6j4RSVdqjbEHXcg08wy7xtZAC7MHCNA7Z24XFbNDZ
X-Gm-Gg: ASbGncvuEfPRvqSQIReL7Q0Ch+pGmdeVznwhlOwkwVVUK6hmViBPs3IDMH3vpXUUjcu
 6cai7rKBfrZIFAnC8CvKYfP+iMroy6bT/Zfykb4xEtTbjpqhoFiH8EJtEsfdEmJF8Jw9LgrYXvG
 gu/eN3pwyjP5xeD3+e3crQ51Saeus0Dgwf9Qcdk9D744V+Z1oFme1/6VUlPlVmn+cXN6PrkUEv1
 K0XiEUt5mEuja/rvhhfwv5R89zIsEkvQrKMzSs/O6yO6nyCvuX8vmvtaHB4PqZLwGMU0b0rEIqm
 SROeH38tqNxGYSb648J8Ydps310NLekC
X-Received: by 2002:a05:6902:5401:b0:e93:1316:449f with SMTP id
 3f1490d57ef6-e931e620294mr5175088276.24.1755198375531; 
 Thu, 14 Aug 2025 12:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFWSylGlXB+4yX0jjnA5ldgXe6qTeXZTpRlSX1jx3VBlDy8OLCSinQsVjTQDRvFTbzBghOOA==
X-Received: by 2002:a05:6902:5401:b0:e93:1316:449f with SMTP id
 3f1490d57ef6-e931e620294mr5175050276.24.1755198375140; 
 Thu, 14 Aug 2025 12:06:15 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71d60fe17e2sm7960967b3.40.2025.08.14.12.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 12:06:14 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:05:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, mtosatti@redhat.com,
 richard.henderson@linaro.org, riku.voipio@iki.fi, thuth@redhat.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, david@redhat.com,
 jjherne@linux.ibm.com, shorne@gmail.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com,
 peter.maydell@linaro.org, agraf@csgraf.de, mads@ynddal.dk,
 mrolnik@gmail.com, deller@gmx.de, dirty@apple.com,
 rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org,
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, aurelien@aurel32.net,
 jiaxun.yang@flygoat.com, arikalo@gmail.com, chenhuacai@kernel.org,
 npiggin@gmail.com, rathc@linux.ibm.com, harshpb@linux.ibm.com,
 yoshinori.sato@nifty.com, iii@linux.ibm.com,
 mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v4 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
Message-ID: <aJ4zl2-wSq8pm-Q6@x1.local>
References: <20250814160600.2327672-1-imammedo@redhat.com>
 <20250814160600.2327672-7-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250814160600.2327672-7-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 14, 2025 at 06:05:58PM +0200, Igor Mammedov wrote:
> the helpers form load-acquire/store-release pair and use them to replace
> open-coded checkers/setters consistently across the code, which
> ensures that appropriate barriers are in place in case checks happen
> outside of BQL.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


