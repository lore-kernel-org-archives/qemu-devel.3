Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18953606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H5k7eqEo;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=SX8jza7V
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUQV1-00074h-Og; Fri, 20 Nov 2026 10:26:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQUv-00074I-75
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:25:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xUQUt-0000zz-IC
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 10:25:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795188353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eed1bkUKNyQob9tPcPW/eTQEEr2MwfbLNtMaSH0LwhY=;
 b=H5k7eqEoxGgCL2qaBKDgsV2XiRbTqVycBggmMQipB5uGc1iPYSK3FhINlSOvlkFisX0MEC
 AVWMiLQxV7wdsu4pmhA8B+3vIWahAz350sjlU32aU5Ae+NjOFL19YDQnfY25pU7kE5dGpf
 kpQ4YikGgFE9Bn582rKZAwXgtnE0dSQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-I5FeWHtrPpay53JQ1VbrSQ-1; Fri, 20 Nov 2026 15:25:51 +0000
X-MC-Unique: I5FeWHtrPpay53JQ1VbrSQ-1
X-Mimecast-MFC-AGG-ID: I5FeWHtrPpay53JQ1VbrSQ_1795188351
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9495dd0f07eso194440585a.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795188351; x=1795793151; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Eed1bkUKNyQob9tPcPW/eTQEEr2MwfbLNtMaSH0LwhY=;
 b=SX8jza7VU8Awl055sNcQ0dPID2lSpGUCdbgQMvwtx/TaoEx2QiTZka4Am0wF3i9cQO
 VW92zHP+rUSr/hGQ/pAcojn3OtDQ/4tW6ig39MkiNt2UTdqkzjr4E2LG17gPs0NwJlob
 ocfvOFSTmdskoiW5ezMN9Hfg/wCIrhN45fvIRir/AGKuNI1sg7UG5QnGUKjutqFWIjUl
 wJGXqwFB8K5K8eTu7q3h7/CXVohQAE/EfmE8yqjw0ZaPaTGC69Gt9Wn6zm3f3h8RlbXm
 fytq3Dvpz/ZoFtpaesJlhWkWQ7QB7QqHaUhJkhZylMafQqwEC8YYH52tW+VJG6xE8e05
 M0xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795188351; x=1795793151;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Eed1bkUKNyQob9tPcPW/eTQEEr2MwfbLNtMaSH0LwhY=;
 b=N5rUHAuobLb+kGKoIUsOg+BNXyWZx2moHg6zHeCOhEBUdEuBFwZuqeBpO7Hf9om82d
 RFUqQ1CzOnRQHE+wwPzu29yeMWG7x/tm9pb3pnbBcV4v0bHvtwg9AZnKx6FixPNy7cux
 G8awuQi3v6YlwbYwBeaB7tg0yO1ICRTBfTx8sdDi5YB6cb99wxWyUbc5m5TBMW0eJTNK
 AHw4v8HqnRkVKbvUSUziW5MnpTVnyQGkAFTtW4Pu8jS14l817xtLN/KSBEtmb4QPMuFC
 fkT2rGe9bnhFtLCpUVe/tboOVDe3o0AIfwmAQX1u5Hu/+VXbHDssWYacbXVFkW/g6E9b
 rxPw==
X-Gm-Message-State: APuU4Z9WK5BH6YTcie2g2Pg5g/hRqXWTrywMjAJZNUi8f2SsIZmJKgG7
 AzrrOHOEETTXBZfrmmi8bHh5bHzO3lL0s4B8n7+SGNi71gAQEpzWayiqfCeKJIPgNseniZBig8X
 zdyUxFZwVT3pd3UpT5LMMQDkxJ7vNz7BlF6ptVhKNWa74jS06oHj09KSb
X-Gm-Gg: AYBFou3WjuPB8S6D7keR26jLDWiMss8ifeT8O+lx4U62pM+WRJQJPARvcyTvEZCFDJ9
 tGq/EXdktvyBUMDKU2fhW1B/JBwHPlGu5VNpDO+zukZAELyoxJ0h47NRa7how6Kmu8Whg36aqVk
 nV74soBr9YjqSPdxQsr/owCmBoL3c5jU2EuDG5FXK+ww6rkXTatNhI/scBzYQEQl0AyBErjrvHh
 ZSCKdEMkPhHmrRuKp5xuZ7E+2FtrKFnKQoM+ZpIfiwHOCRdMPLkynnjpodSECXigz//X9pUj26p
 7ytEb4nAngnPFZuBdOvwFSAGzx5kDt3MQ9f1yfS7aWn0yw7RXS3tSC5uz5KEpC17QGjK3fNbPBj
 8ZlzRuih+qQG/lZagme/n6XCY3/Rs70dkXs26Xt+1oqNKMA==
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id
 af79cd13be357-949ba683204mr565831785a.0.1795188351022; 
 Fri, 20 Nov 2026 07:25:51 -0800 (PST)
X-Received: by 2002:a05:620a:3185:b0:93e:94a4:a97d with SMTP id
 af79cd13be357-949ba683204mr565826685a.0.1795188350451; 
 Fri, 20 Nov 2026 07:25:50 -0800 (PST)
Received: from localhost ([2605:8d80:6d65:87a7:10d7:f219:658f:435a])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb0319fcsm212508085a.4.2026.11.20.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 07:25:49 -0800 (PST)
Date: Fri, 20 Nov 2026 10:25:47 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: Re: [PATCH] docs: migration: Clarify the security posture
Message-ID: <awBme78YdZ5GsKgy@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261120143453.1998949-1-farosas@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120143453.1998949-1-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 11:34:53AM -0300, Fabiano Rosas wrote:
> We have documented[0] the scenarios in which a migration bug is
> considered for a security vulnerability but some ambiguity still
> remains, mostly because of the mention of live migration in the
> untrusted entities list. Remove that mention and expand the "Security
> boundary scope" and "Sensitive configurations" sections with migration
> content.
> 
> 0 - commit 8b6405a493a ("docs: Add security considerations for migration")
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


