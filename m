Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E76606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=chqfgThH;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=syjyXbrC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWJSn-0001sP-7w; Wed, 25 Nov 2026 15:19:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJSl-0001ry-CP
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:19:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWJSj-0008SH-Ee
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 15:19:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795637967;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izEtoT+OZdkDPh5u31/3qnEoz7/vLRDgp5RQGjBrFcg=;
 b=chqfgThH3Fr2DQ1SV3q2rTpr0GdWbmqhN8qCpNp/9CmgvaLOza8PPQADkyK9hTo66AIQS/
 AO6mxGku0kChk75uVSHI4vhDUdpDneJ2W5la4a1iiV1OY2w03f5nZTkEuo1eKI0nCI+OUA
 i3RSt7XBDsRGkG1EIkvT8NIhtLZqnZw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-LcqKSg66PVCqlN_5WaqHRg-1; Wed, 25 Nov 2026 20:19:25 +0000
X-MC-Unique: LcqKSg66PVCqlN_5WaqHRg-1
X-Mimecast-MFC-AGG-ID: LcqKSg66PVCqlN_5WaqHRg_1795637964
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92134f1eb00so87096596d6.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 12:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795637964; x=1796242764; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=izEtoT+OZdkDPh5u31/3qnEoz7/vLRDgp5RQGjBrFcg=;
 b=syjyXbrCF1Whc2eL8B7aspR39IPTtui7PBcBHOI8uSYTvHLEL5I8rK5shtGy0eApjf
 r2NNW18i2Gn7LHiVLyFxt1JNLJP9YLceLt1aai1Xx7FSmQRmziHwXXf3sa1DY36oO6By
 zPxn9wZgwSJFx/uGmXE+MklWWLWhnOl3O/xH80cBQvUNzfC08Lx928tQH2jhegoJ0fds
 NLfqxehjxUfXZpZMCwo03KRJJCUzapsTmL/QjPzVTFxMvF1rWkKRAA/w0tjNSV5AiCaG
 4IuIFMYUB54qhMtnw6btN495rJR7Mac4kfT2BBzuZVSViXY4U3wJQzw+DSW6+LVwaZ16
 21JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795637964; x=1796242764;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=izEtoT+OZdkDPh5u31/3qnEoz7/vLRDgp5RQGjBrFcg=;
 b=utmNSBWRq885Sp0poAzSXUrrCRgwPUlStj+eDIvFTiV2lcIhmytIUNg6dSsotkdBLH
 TkMw6oYGjhc4HW+I7PexPwtvfA9Cv/KTwcJXaYPPtQP2mqH0ijbe6YyVQv5GOnSv87Ci
 rvO7yEU4+GOWjQoKwqWsDHsmw3tQpWFVP1T/35ykDLUkdc9h3taaVh3XsXV5P75ZYgmS
 BFP2ash3ZPMciJdC/LVPOI5rbIqitIwM3g2AkoWiWsH9GY6CZrR9MmBfDb//AVcbdvFy
 WPVpz7S6w62ktE6WcjheGW9qgcqZr/Qfg6HDYwdzn8ahnkR2mc2tdZUqmcbGhlkP1Whu
 VAGQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHOAGFwuee41L2wbadblBRFAI1sEQTkLjFXZt8lNgN5o/A1fJlGkpLX2X0pqWONg3jlJyZ785lWjZJz@nongnu.org
X-Gm-Message-State: APuU4Z9STZ+0ZcJ4VKJqJmczCRUYVJza5S+LgERgx/4qSUXF5TWCwEKM
 uEtHgZDt8JlvRgS3NDe4jcLQfUje0u/cxJhglDHFPGxKUZ67m4XWul70qHZmKxMM7SHIB0xc0wr
 Kzdv8qkb7B3St4dgh00YAQ824b4kRxeAYx67RImY5ku3KPytx+pLeQgzS
X-Gm-Gg: AZFdTZd5K6dKjmlTy+w/wT1DoMQ2Vb11BvEnjME6vQITNfNlcJwI//dhizNhZ2ZWOn1
 zP6BXycsf1ayQ9BjJdJqRVHYlrtF/TSZyx5yZXWwBC9Kb6GUxf3xJAgzs61zwfHCQOuOz1viLTj
 fYFNSX3OMxe5OulI9QApNxp5HThD0Qvrh3ggleiRpRo4Ypb43YPXg66/JFQd85VZ76f8OFMOmWt
 UfA98gNV9SOMhocdO4GvR4So0BI5jGup5sh/+VJIR77yKFQQVuQaeougZIGnMGtHjAkeH2KU32a
 iW/ORPpJmjifoDCIYwBEgPyMl4aAFxATAk0n+GFhfVIgN+DiejJ/FhJcAj9wvxi1gDpyEyGRw/A
 O9y2Ti9+5sXGXlYgb24FpFOg6y40FbZb1amz6dk57okvt
X-Received: by 2002:ad4:5cc7:0:b0:921:e08:1d9d with SMTP id
 6a1803df08f44-92134b93acbmr370597796d6.49.1795637964016; 
 Wed, 25 Nov 2026 12:19:24 -0800 (PST)
X-Received: by 2002:ad4:5cc7:0:b0:921:e08:1d9d with SMTP id
 6a1803df08f44-92134b93acbmr370597186d6.49.1795637963319; 
 Wed, 25 Nov 2026 12:19:23 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134796329sm168896296d6.2.2026.11.25.12.19.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 12:19:22 -0800 (PST)
Date: Wed, 25 Nov 2026 15:19:21 -0500
From: Peter Xu <peterx@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 0/3] rust/migration: Remove vmstate_validate!() and
 VMS_MUST_EXIST
Message-ID: <awdCybZxgVqT0VsE@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261124095814.437738-1-zhao1.liu@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124095814.437738-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 05:58:11PM +0800, Zhao Liu wrote:
> Hi,
> 
> This simple series is based on Peter Xu's series [*] and mainly refines
> patch 5 — removing `vmstate_validate!()` from Rust HPET (while
> maintaining consistency logic with C HPET as much as possible).
> 
> I originally planned to use a single patch, but breaking it up this way
> makes it easier to review. I suppose these three small patches could
> also replace Peter's patch 5 :-).
> 
> There is also some cleanup work left (e.g., support post_load_errp() in
> Rust); I will address this in some separate patch later (without
> blocking the current effort to remove `vmstate_validate!()`).
> 
> [*]: https://lore.kernel.org/qemu-devel/20261120124923.1656220-6-peterx@redhat.com/

I'll carry this series too while reposting mine just to make it complete;
feel free to repost / address comments concurrently from other Rust
developers, we'll figure out how it lands.

Thanks again for sending!

-- 
Peter Xu


