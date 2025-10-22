Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5278DCCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:34:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBY1R-0003VL-AE; Wed, 22 Oct 2025 08:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBY13-000368-Bo
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:32:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBY0z-0008Ux-46
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/FUIxsSYcMFbBzvpjLyQpgiPPwbJm+w/COxCEVuqcwY=;
 b=fL8URjSr9iMysYmHTTlMttHSybGa3Z2lx2mJtt5fbECONeKrtw74OjTzlxVP4AaG3lQnSt
 n8k23napXPFtVgX2AcJNqtz3Gpi9KZ+NpaliGFee4BFxG2QMRsccGjBZHYgCTqiZ3QRfH6
 uqEjh2gmkq6GCvm1cClLP4uUFutHWoY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-CAh8QTPmPO6pHYhKScEhIw-1; Wed, 22 Oct 2025 08:32:25 -0400
X-MC-Unique: CAh8QTPmPO6pHYhKScEhIw-1
X-Mimecast-MFC-AGG-ID: CAh8QTPmPO6pHYhKScEhIw_1761136344
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-6349af0e766so10334476a12.3
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 05:32:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761136344; x=1761741144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/FUIxsSYcMFbBzvpjLyQpgiPPwbJm+w/COxCEVuqcwY=;
 b=AFSCXmXRF4T0h/hnekhXfKn3k/9RIwQT1DakdDYaEp3D2N6HAdMJ2y82MUp5fhLCfk
 b7nj4Q6A0EA52sZT2UgHTn2rrO5HAqpehk5z4DqHTeHnjUgJNsEdu/ZVa4mb710K49ox
 Swsf1BBM5TrgNwJx5dG9GJYBAPElskD3SZtNrfFH25gSgRJRywZPVByFBYznZzWqJh9B
 VNIWi6kJ0TJZodwLLHMM5Bnvzlb5MToI0WnNxRHOq6Sqpv0hzagp+m38tYIu0oKfwFgM
 1uPDwEcrcyNgUS/LKFpZPx07shsmHLx5zMAx8r1Ks5pUsuHUwvG7JFv2IysgU+yLoAP9
 DPQw==
X-Gm-Message-State: AOJu0Yyln05BiutcLlvTTsEiCsAPVyu678LrsUbSQnGYfSNrKXCP6qnI
 ScX/zX4dUGWZ//ZroBr4Qad5B7PMWHMCnbz95gpEZLD8N5gMj0KMYdIb+nC8GWdsrFA08oViPOF
 IBPT1JRxF3diSIyjxdzjRXlr4vAZXz56r9gGLHqFYK1JehJueB9ShCA+k
X-Gm-Gg: ASbGncvjrWBqGo1gMoogAyiR3mzFOY1iPfMa8yPrtv+50NJPW7uacROuXgW+9GjqD0t
 sMAEClTrpPU63Q5IvAZUfisnl2lUt8uQYuXsWWPPmh3iXX7lfS97KsKR/1aSvCXnA7aJtLX+R8E
 KRThgU4jWIJK9SlMma4U2LcBQwS9/9jYWamP/Gms330AxSqTl6zn56PCpfsfYnkk7AEM4kmX48B
 w5ZbJl82KPJNFJo8CVB9EZdF4S21K6y5J3gj1tymWblIgIWO5P2YYCfJy5eLIyqJSLtDNWQGbv7
 TY3j2BW9IUrtEltYP/8+4+Lu1VVFA/VRqwh9X8e62zMgG3zDO9kE1M0p4VNFhb9Pt5ceypCS/nc
 66KyS+OzbMwPF5pOAWQp3syvD3hUuk+h2j1C+t9w6hbAHJl0CaZw=
X-Received: by 2002:a05:6402:524f:b0:639:db35:62d2 with SMTP id
 4fb4d7f45d1cf-63c1f629bcbmr19675140a12.5.1761136344188; 
 Wed, 22 Oct 2025 05:32:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtPVMPe7kp1P90Di9IF+CJ9i/y+n9mjdA7jsmzXOFHl/2JdbAFCnfoK7JgqC3+W4gdIaVOSQ==
X-Received: by 2002:a05:6402:524f:b0:639:db35:62d2 with SMTP id
 4fb4d7f45d1cf-63c1f629bcbmr19675113a12.5.1761136343716; 
 Wed, 22 Oct 2025 05:32:23 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63c48ab65d6sm11647891a12.14.2025.10.22.05.32.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 05:32:23 -0700 (PDT)
Date: Wed, 22 Oct 2025 14:32:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Luigi Leonardi <leonardi@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 2/5] igvm: fix off by one bug in memmap entry count
 checking
Message-ID: <t53zcquvbnxxx274jtf3q5jd3g6jlawkml3kckd7vp3saajnmy@usbluppi6bzj>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-3-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251022084439.242476-3-kraxel@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

On Wed, Oct 22, 2025 at 10:44:36AM +0200, Gerd Hoffmann wrote:

Should we CC stable and add fixes tag?

Fixes: c1d466d267 ("backends/igvm: Add IGVM loader and configuration")

>Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>---
> backends/igvm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks for fixing it!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 723d45b755a0..055bbba745ad 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -567,7 +567,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
>
>             retval = ctx->cgsc->get_mem_map_entry(entry, &cgmm_entry, errp);
>             while (retval == 0) {
>-                if (entry > max_entry_count) {
>+                if (entry >= max_entry_count) {
>                     error_setg(
>                         errp,
>                         "IGVM: guest memory map size exceeds parameter area defined in IGVM file");
>-- 
>2.51.0
>


