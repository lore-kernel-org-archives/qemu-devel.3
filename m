Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD97C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI71L-0004QA-TH; Thu, 22 May 2025 10:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI71K-0004Pw-8R
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:35:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI71H-0001OD-Mh
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:35:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747924536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K9YNMTNKKzz+IS0PTnjzUfsbEal0Jr6ur54DcL6HiBI=;
 b=GwknCo4IoopAMoppIFeEwe2uQAJ0IOtyj7ESd7/vnAAptQd8J07t5QlpZyY3Tv1bJBU8On
 sPSKP0UEYu8OWbix72X0FdujdZMdTac5lQ12N4mHe5KD1IqsQy9TgiWu5UHk/mp/oOeAcT
 j2xHqtmqzZ25qo2fY+5sDoW7gELI6kM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-SkP-U0DIOeSycACMwSxXFA-1; Thu, 22 May 2025 10:35:35 -0400
X-MC-Unique: SkP-U0DIOeSycACMwSxXFA-1
X-Mimecast-MFC-AGG-ID: SkP-U0DIOeSycACMwSxXFA_1747924534
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-47ae8b206a4so147279091cf.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 07:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924534; x=1748529334;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K9YNMTNKKzz+IS0PTnjzUfsbEal0Jr6ur54DcL6HiBI=;
 b=dn9xQ/03cuGxqEvxmMUisFq8t/x4/rbNR0Iq/T/6jLLPPB5U+7/z9GY0CWYVAzhSMg
 Ku/3fmFRylyuvEw+Uq7DUJjLEhk6hCGNruiRK95FCDKqr1hB57qdHd3bF1vL4Ko/IFeh
 +/tjmsKgMT83yqHucpoAb4i5igVkGGsWBft8McF0uT0Rrxfun77jEw+A1o6wzaHtD0fQ
 CPz5wxR+KHrrJqQ4m5uV85+LuhUTqpgae1XvzxGoXvsKG+a4vaiwztfFF+bPXTjMqBrU
 RG5sVOf8yc38bauOqPULIf2swg5TYhzL/qP8ON3Sgy3tYnZ1PHk1cTqakJF4b/+q+tNd
 3KHA==
X-Gm-Message-State: AOJu0Yw6RwlivmommD/5HNwp9oQUld3E0Powj2n4+D2E0VZEyEzEK+hS
 Jh+x3OkXdG6Yv1MCQXdslgcEG9bBM/nxR2GAEBmwRgQQK+VW69/Qe3STFptwfXPbmy9QPQh5Ht3
 hg+LQjsx+w78Cy3Qn7kZfXFgQOiLppBU33c0b7fzjsYLfVnJhmlpl1p9E
X-Gm-Gg: ASbGnctAnce5KHlUTAbFtKAUXtqoihGet8O8FCR1e/8meZb1Fosm1PYwUGEjXEeYh8P
 ieSkLtKcxi0VWz6XI9Q/5aaRLte1qtsAutyH+W5EY5dP0SAosHSohug19NjxvLtv0ZxG0Hil95+
 D68gAxhjSI95oxE4YYlVPlZ77SCP7oHjA0CMv3Cb2Vl0WIC4+3xGUQcYUo8//YjrKACG8A9HKb1
 LeCcP2isyIffUU/1LVFwWHB1VcYET+hDQK072T8TZCkaIenTYzaE4X5xCdAMTQCkkePC+8gtNex
 CoQ=
X-Received: by 2002:a05:622a:410e:b0:476:95dd:520e with SMTP id
 d75a77b69052e-494ae393fdfmr478642161cf.16.1747924533957; 
 Thu, 22 May 2025 07:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDLV+qhy3p/5Z/Kb10t+P+b08fZD+bsGd6eBOHS0U5UdZns6ct40m49S8z6SCGAr57UoROTQ==
X-Received: by 2002:a05:622a:410e:b0:476:95dd:520e with SMTP id
 d75a77b69052e-494ae393fdfmr478641861cf.16.1747924533663; 
 Thu, 22 May 2025 07:35:33 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae4fdb4fsm98559051cf.64.2025.05.22.07.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:35:33 -0700 (PDT)
Date: Thu, 22 May 2025 10:35:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/4] tests: Move the old vmstate-static-checker files
 to tests/data/
Message-ID: <aC82MlggWfQStTfn@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-2-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522133756.259194-2-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, May 22, 2025 at 03:37:53PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> All other test data resides in tests/data/, so let's move the dump
> files here, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


