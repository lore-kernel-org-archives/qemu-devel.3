Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F7AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 20:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjmk6-0004BD-91; Mon, 11 Mar 2024 16:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmk4-0004An-08
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rjmk0-0002H3-9R
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 16:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710190763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/K3C8TuRfpDeOBNpL4v8l7VTrDgv3xinfvZHdaQszlI=;
 b=V8SOTDc0UpWBdpFFUG1mg6pj6JqyOw9V22+QLRKXeg18x5MI7aDRfQE/kl5X0rZCytCuhF
 gIrGQwsEVVLkbFkfTjR0siZ1s9FuWbcWwX/4u7LSY/h+v87d9mH7rbcr8qsfoVVdQYbh40
 NIrbxEJWWznXLO3Pn359KOgjRWQ22bw=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-HBY2SzHKNgWzvnFf78uxSw-1; Mon, 11 Mar 2024 16:59:21 -0400
X-MC-Unique: HBY2SzHKNgWzvnFf78uxSw-1
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-5a18efe7905so1188966eaf.1
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 13:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710190761; x=1710795561;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/K3C8TuRfpDeOBNpL4v8l7VTrDgv3xinfvZHdaQszlI=;
 b=emDg5vwyx7dBjXkd34+0K1b+gpJ9DTJA70ZOjem4BscoaJvEsKU0XcjZeyZzbrN9jh
 TZrkHuP3RYaxpdVScRDQ+Om0twkJ38sKzaBGiKTJ+OGC0BdP0oC5aqvIZXMwlps9XaNb
 Q6eRoW0cX5teRd2u4x9GoSzlOhOD69KEoQcl3XmiOc4GmvX+Psk3mKg9oVa79SvXAX10
 upqQVhTLeSKuBWyvGHXJyQzaejtF+ULdMgdc94099gWCKl1OT8xjJMQF4Iq85hiBidTH
 tfaP0UJo56p9gZnpNUI03Ug6F1RzzEY/2tdWt6xBmTK158F2DSCduiJ0YBuyc7cXYFEJ
 Rgkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm1FEelx8Bo1xwY6qAa43Ra+ojOgSAG+DwpapYkF2B6fUxolSV2DH1R91Q0nM+Q5c9lrYXatraY1eFRr8MyV0EmsIRF+4=
X-Gm-Message-State: AOJu0Yxgo7Ks3oc81+BugS2QIVKX8YEfkRrh/lQm4IrE79n0eP/rl769
 AKgww0Bcue6KP+lPdTfr3B0XIErPF6xaIXV8eLv53kkzS4TMGDWvI28ZYde8mFySfNLzeTyqtBQ
 IGKtc1IO/vsVgagBgWojsD9EAjaXZEbjqF4LdSIpPMjqnWifpu+Jw
X-Received: by 2002:a05:6358:528f:b0:178:8c44:aa8b with SMTP id
 g15-20020a056358528f00b001788c44aa8bmr8101210rwa.3.1710190761184; 
 Mon, 11 Mar 2024 13:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNl9R2w9Ws2Rjd0Vhh0UEoFXi64UnHKaTcbHNtuanls51Tm9rvXf/HGMrxCteW5yPSXZCYFQ==
X-Received: by 2002:a05:6358:528f:b0:178:8c44:aa8b with SMTP id
 g15-20020a056358528f00b001788c44aa8bmr8101183rwa.3.1710190760872; 
 Mon, 11 Mar 2024 13:59:20 -0700 (PDT)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 j29-20020ac84c9d000000b0042dfa55a3d5sm3029773qtv.25.2024.03.11.13.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 13:59:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:59:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@linux.dev>
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@bytedance.com>
Subject: Re: [PATCH v6 7/7] migration/multifd: Add new migration test cases
 for legacy zero page checking.
Message-ID: <Ze9wphQ7HMyAjuJT@x1n>
References: <20240311180015.3359271-1-hao.xiang@linux.dev>
 <20240311180015.3359271-8-hao.xiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311180015.3359271-8-hao.xiang@linux.dev>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, Mar 11, 2024 at 06:00:15PM +0000, Hao Xiang wrote:
> From: Hao Xiang <hao.xiang@bytedance.com>
> 
> Now that zero page checking is done on the multifd sender threads by
> default, we still provide an option for backward compatibility. This
> change adds a qtest migration test case to set the zero-page-detection
> option to "legacy" and run multifd migration with zero page checking on the
> migration main thread.
> 
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Message-Id: <20240301022829.3390548-6-hao.xiang@bytedance.com>

We don't need to attach message-id when posting patches.  I'll attach them
when queuing patches to make sure the link points to the exact version that
we merged.

I'll drop this line and the other one (in patch 3).  No action needed from
your side; just a heads-up for the future.

-- 
Peter Xu


