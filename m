Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37869C61CE7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 19:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNcKD-00045h-P7; Fri, 06 Jun 2025 15:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcK6-00045I-B1
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:01:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uNcK4-0002ZO-UK
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 15:01:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749236507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v3DU7KNu20eiEgpIc6DCItvrQfs6kbjNefFjWIYkii0=;
 b=BrhXB5//Yes6HXeUCLMIcd6RygAVgak9veL3XRQCqCZdeX1eyKETHslTANLXJgW6Adaru2
 pI1Es5QG7GZmsmxISXfRqd/uCiCve+pRKwsHlDLJGs+N0Z1CmNgIGxaR1PAaXT+FRTIwBs
 Qr/+/QsilfJUyvH3qPtaC9wTkmmi584=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-dp7O1cE7Nfm929r2SxL54w-1; Fri, 06 Jun 2025 15:01:46 -0400
X-MC-Unique: dp7O1cE7Nfm929r2SxL54w-1
X-Mimecast-MFC-AGG-ID: dp7O1cE7Nfm929r2SxL54w_1749236506
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a6e9182fbaso13457001cf.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 12:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749236506; x=1749841306;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v3DU7KNu20eiEgpIc6DCItvrQfs6kbjNefFjWIYkii0=;
 b=SXpuwC59HQeGEUom8lr3i9/pXHpNMsFxMc0L9SZwcBqUhn+U8xzqRh2svvgfwJtWki
 YIF7+IV8rEOg9m4FjKF561FjqexBNLSJsPEguNqgNG3g6uH48FT8ONiDFY3HVE3I51pz
 E+eMg/9j/EdsdVQ0oXPMu8fL3r34vX48rktl15/zJmni7NErdKR793Pn0NAF1C/KALlp
 Qo48004uBALonQ1e62cjrq+xuuTAv5w5UL9kZevgfbnzgG2H/57ITWr+SMT+SHKeHUoV
 Yh6+i0BcB7pnOkr2XLO9xq7I+XB3X+wBE76xLCxg2kwfa3k5kBlAMhnb3u6UnfZLJRc9
 EM6g==
X-Gm-Message-State: AOJu0YxbrxNctWRtF5kv7aXqSWmkzkplklZTlZMp6ULZp1bUuWuM9KIq
 CpYdQxIzm5xie/eggAXSZ9blbi21yImjunMH3DVlTsOMhDVa2JPNOmDgXeetAvXNL1s+hLh6OTX
 mNfIbIikLuyOCPB6wCjAVkS1+djRshNfUxxvoJaRnReK9OUwCcInXG38B
X-Gm-Gg: ASbGncs+/3O//+QmgaUFKAMV2itu2xMaVjib/ZqtNLD4q5fBGh0uaLD47IhDvWx0lwp
 c1TZKOR315DB2/7clHBG7pYY0ebR3V780GJMPgkCYfLd10pz9O8Agx7phNbaMHZLmHzk6L1c8Lh
 zulNpOmhHadTvGbId7FOAipQkfF5DsGjh7ykRT+sS7R+zu3v3z4KmZ053OxgJns2tHjn9ICKHBh
 h+Un63yRX1do5ufgMledGT7rsEzEC8kzavV8mdy91QbkLhU3vEN552IBY5xQclskB2tbJDmDeBE
 l/8=
X-Received: by 2002:a05:622a:4d87:b0:494:731c:8746 with SMTP id
 d75a77b69052e-4a6efccb015mr3483501cf.23.1749236505770; 
 Fri, 06 Jun 2025 12:01:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9aoBRqS1GxI4jYqWWFmX2Hbp82+vVcCoLBIlw4c8u3OFmzaizjp2j49yOng9U+YmuDC6VuA==
X-Received: by 2002:a05:622a:4d87:b0:494:731c:8746 with SMTP id
 d75a77b69052e-4a6efccb015mr3483161cf.23.1749236505401; 
 Fri, 06 Jun 2025 12:01:45 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a61116be2dsm16842441cf.29.2025.06.06.12.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 12:01:44 -0700 (PDT)
Date: Fri, 6 Jun 2025 15:01:42 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 15/21] migration: Add capabilities into MigrationParameters
Message-ID: <aEM7Fk_GeK5n8Dsc@x1.local>
References: <20250603013810.4772-1-farosas@suse.de>
 <20250603013810.4772-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250603013810.4772-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 02, 2025 at 10:38:04PM -0300, Fabiano Rosas wrote:
> Add capabilities to MigrationParameters. This structure will hold all
> migration options. Capabilities will go away in the next patch.
> 
> Also add capabilities to MigrationParameter as the enum needs to be
> kept in sync with MigrationParameters. This affects the parsing of
> migration HMP commands so make the necessary additions there too.
> 
> From this point on, both QMP and HMP versions of
> migrate-set-parameters and query-migrate-parameters gain the ability
> to work with capabilities.
> 
> With MigrationParameters now having members for each capability, the
> migration capabilities commands (query-migrate-capabilities,
> migrate-set-capabilities) will soon be deprecated. Add a set of
> helpers to convert between the old MigrationCapability representation
> and the new representation as members of MigrationParameters.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


