Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A967EC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 18:51:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRFvX-0001tv-4Q; Tue, 09 Jul 2024 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRFvT-0001tB-IE
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:50:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRFvR-0001iw-Tl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:50:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720551051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3JxZLxMw/GkJ4i6hT2OjVbAWKAWo3u6jfd63AUHib7g=;
 b=JiTu+sRygExRxpo5F1Zsml9ntgibRE2oqLbxPw6b3gzWXLFvUsHNyR59epFTru+7rgtRoP
 Mdg1Se8plH7gNhO1l4YsuZs//pSW8E+uckZmtCGpeirM24JEOvL91XEJQY/Fm9MRljFEQu
 q224d6bEzi9Y3+lGTO+LiQcVFUKatDw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-BDszQ8u4PouNFT7ouu6AtA-1; Tue, 09 Jul 2024 14:50:50 -0400
X-MC-Unique: BDszQ8u4PouNFT7ouu6AtA-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4401522c6bdso16625061cf.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 11:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720551049; x=1721155849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3JxZLxMw/GkJ4i6hT2OjVbAWKAWo3u6jfd63AUHib7g=;
 b=mYD/M5SARNTG9mw5RINEolgkD91ADwHS8qR/EUEx3VtyFgYH2nHHc5m4WRFNBP0D8l
 XlRMG4WEZglMdaspYlOwFMXX/5898sFm3OOrUKwN3E8R3qISbaAPCg4KnFQrPkrVJaku
 x6xq51bAkU18O/QZaUANhUvmQCH+YqKAmToUQml0zrCFZxR29u8V4ls0giRLYQ9ySMnq
 fnYUUkjqWYEL5keKpWnu7BXNt4Iij088wgaS08g/s95dXm7yVMR8m3zDRU89+1gCxZzw
 YR5eJsgG8/GDdEpq+Hh2CDDKRgiBkY7DT2IuyXLQxk/Bz5LDHFxf1AXZtP3cGLPAGM3S
 x+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1fgSWFjTUH1R/rNK+5HosaGk2MDI4hcJg9DYG5yxZtbsov5MTCySNMJ2dWNSCQkZvY0ATr39e+8cT0dKEgT9qmpozD4k=
X-Gm-Message-State: AOJu0YweL7oSr4XlAxK+XlNjPy0Pzf2QOwxX834yFKlP8pvAI9xm6a8I
 2p0SsczM3jgAJ3txQ2AUVddTkUqvh7QfbRSsJAHKzI7p0AJWrxKD/F1kjY8cMnZrjP08Xp4oyys
 qjUkppfSiXPu1k2rcdhX2mQ8Fq70crrPHP1EwjM0R2HXRs/CqHVLD
X-Received: by 2002:a0c:ef52:0:b0:6b2:b621:559c with SMTP id
 6a1803df08f44-6b61c237532mr36552296d6.4.1720551049681; 
 Tue, 09 Jul 2024 11:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8YTHQcwCZXXlZq1OSdgPziU0h9XZ4gyBJKwR7OFufxG0x0wYQ+xKq3dD8NQ8RLaNz1BTn4Q==
X-Received: by 2002:a0c:ef52:0:b0:6b2:b621:559c with SMTP id
 6a1803df08f44-6b61c237532mr36552176d6.4.1720551049364; 
 Tue, 09 Jul 2024 11:50:49 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b61baa036asm11069936d6.137.2024.07.09.11.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 11:50:48 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:50:46 -0400
From: Peter Xu <peterx@redhat.com>
To: Yuan Liu <yuan1.liu@intel.com>
Cc: yichen.wang@bytedance.com, farosas@suse.de, qemu-devel@nongnu.org,
 nanhai.zou@intel.com
Subject: Re: [PATCH] docs/migration: add qatzip compression feature
Message-ID: <Zo2GhvAlpbt2ajKd@x1n>
References: <20240708175359.1104493-1-yuan1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708175359.1104493-1-yuan1.liu@intel.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 09, 2024 at 01:53:59AM +0800, Yuan Liu wrote:
> add Intel QATzip compression method introduction
> 
> Signed-off-by: Yuan Liu <yuan1.liu@intel.com>
> Reviewed-by: Nanhai Zou <nanhai.zou@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks.

-- 
Peter Xu


