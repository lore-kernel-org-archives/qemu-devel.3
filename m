Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F9ACA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 16:25:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up86C-0001Nz-QY; Thu, 21 Aug 2025 12:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up867-0001JI-0g
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1up862-0003Uu-1I
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 12:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755793497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GVNsLAu6pcdADycfA6me1z2A/M36f2wYFZjDnEn7nuM=;
 b=GmYQMju/ofIUzYpBPFfRqygJTEcEvu3aRs5sw5NV3D8HVKA5cZy2gWr4wzy8IDwAcGkEn4
 F0JHNaNV3eRwRRhIMMqmNBI65QcCTfFx+poe9Mwv+02w7bM5gr9hWwG5VGVCLO6Cv8qI+k
 nIgfUxM9eoZn7xxPrJI2ZREkeAAH8DM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-BqZN6bv8PCy9j58Ha-AY0g-1; Thu, 21 Aug 2025 12:24:56 -0400
X-MC-Unique: BqZN6bv8PCy9j58Ha-AY0g-1
X-Mimecast-MFC-AGG-ID: BqZN6bv8PCy9j58Ha-AY0g_1755793495
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71e8366e9c6so13870967b3.2
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 09:24:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755793495; x=1756398295;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVNsLAu6pcdADycfA6me1z2A/M36f2wYFZjDnEn7nuM=;
 b=Bvf3h/SUsPsFx8srIf/iQfEbzy29oV1E3AcqybivlRfL/BpDy6R621MKQCNz55Fn1x
 raJ+0QmJd98khn8f/6yWvEcjRFUpobrIvufckM5o72FtdKldNXkGqrDT5LEGPC5sryhf
 1ft7zGvP9Dzc7yFncRxcJc26pWVeBaX9w9wx0ru6FemWK0HpPpvwDDe8zvicAvqC8Clr
 6srzRh+YwlIIAhvtF7YSvKUYmiCcrusrmCusKb7bxytPn8mnIhyJoOpv3u48k9ShYoeV
 FuikxFbZjMWcuWAt1E5VGkmzC7Ua71ls3tHCW6xpIPU38dmeoxk2HjP+IY7VP/ipPUHv
 ms+w==
X-Gm-Message-State: AOJu0YzECYIk5Nczh7l4qlq0yEBAnP42Au354GHYtI9J1xzVZQ+nDZaG
 VvpzhSlWMnxlUiY4p4yGEi9kz4EBUY/nERf33RP5DKfs39tOpD+oVQuJLlSAS1jR5nyN5zflAAT
 Hd6Lfw3PahxJMiIoO5DcDJ4DbBfGUCHowJ4X+l2yp/IyVqdFs4z9L1Uls
X-Gm-Gg: ASbGncvVTLb09p1VDxmXqMNP/ppFUydZKjKh5cRiIQ5ftQo7FaMLIiUFB3znhhojQyw
 D6UA6sxI8i+JBatudnnHE+7VYROFa7ekIATj/k7Luq423w1809fP8/OaukryLDzUk+FJlBU+iDI
 VmFsPcEQSkxpUl/6fHpvxv3HFwtzKusmMvR7sE5c94DFgAP8EY8r9iTvbwl17Zn0GzUTak/6hM8
 T5EXDC1Ic7D8j7A09eG0mjzuUsCOvTNHH3AUzz5Pl15iFxkJtywy1lRov/6ngeQHNkDGN1764zu
 xW9WCHjNh/+nJq+2egS24+pVMEV258Us
X-Received: by 2002:a81:fa0f:0:b0:71b:9482:d53d with SMTP id
 00721157ae682-71fc8cc4c3dmr30976447b3.35.1755793495395; 
 Thu, 21 Aug 2025 09:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD3CXuXl7+XdEHwSdDCsRytvf3KivWKRt7AMenQ6/5IV+wNoXZSfOR9kdSp4DW84gjYKC02g==
X-Received: by 2002:a81:fa0f:0:b0:71b:9482:d53d with SMTP id
 00721157ae682-71fc8cc4c3dmr30976107b3.35.1755793494883; 
 Thu, 21 Aug 2025 09:24:54 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71e6e05bf0asm44950177b3.54.2025.08.21.09.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 09:24:54 -0700 (PDT)
Date: Thu, 21 Aug 2025 12:24:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH RFC] bql: Fix bql_locked status with condvar APIs
Message-ID: <aKdISSf7G0_irzNw@x1.local>
References: <20250820205051.24424-1-peterx@redhat.com>
 <20250821142445.GB7010@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821142445.GB7010@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Aug 21, 2025 at 10:24:45AM -0400, Stefan Hajnoczi wrote:
> > +/**
> > + * set_bql_locked:
> 
> This does not match the actual function name (bql_update_status()).

Ah yes.. will fix, thanks.

-- 
Peter Xu


