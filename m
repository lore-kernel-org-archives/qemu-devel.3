Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD13D19510
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 19:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkSBU-0003Qx-Qk; Mon, 26 Jan 2026 14:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSBT-0003Qi-ET
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:23:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkSBR-0002fG-GX
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 14:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769455411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uDCgSSQncJgxji9Lm0k2KwMYflOiR+RKmWdIkVj62Zo=;
 b=PK3hd3C2si9xdcUT44QPFMRJsOpwthZ1/KRJ4R3QuFy+UL6iph3Rujj3x9uhgvdXfioC08
 VGmHNuVGrVVBxDFamRmuhuhpd7+tmsq7Y30pobbEKquR7Un63VIMxYdOzI3FDLkjg0moqP
 dZFU2Po1yP4Ps7mZLPlywKkxbmwhIWc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-l-9CmtROMO24hr_km8T3wg-1; Mon, 26 Jan 2026 14:23:29 -0500
X-MC-Unique: l-9CmtROMO24hr_km8T3wg-1
X-Mimecast-MFC-AGG-ID: l-9CmtROMO24hr_km8T3wg_1769455409
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-894878d9b91so112083476d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769455409; x=1770060209; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uDCgSSQncJgxji9Lm0k2KwMYflOiR+RKmWdIkVj62Zo=;
 b=XQJhtf6TrWjz/wf4S/GPLynLfOAwcJ6V10VwfUIqsfjxDM/NmRfH5QkEM5069ruIZf
 Pj8pIDHJ1VNFo5Anv0Xx5rDr1svgWQaIhQxTj8a4W6qYJLjokz1orJoycTKvBvXxnM2a
 VNhnQDyY6J4GyUpwQ4OMDmkoXGOy7nQCdEOAE5N4U6Qs90fykLhzc3t8jvPG2aZ5kJ/u
 fKDzWL0hRvywEGQ7rHq2XYVvT+qcD4C1Ctiv6rPy5nBJpph6RZ6X8oymCj+e0Li5AcW+
 o3NZRz/p0bnTP8HgaiaO258HLPh4d1mA2YTFld8vYYf0QrMRhQpTjPLuJV7C2zxKIFNx
 qsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769455409; x=1770060209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uDCgSSQncJgxji9Lm0k2KwMYflOiR+RKmWdIkVj62Zo=;
 b=fKaBOqjcwYT7vIBqFKifZkwvgEALzl2cMIACykLAYPNLLaIsFaQf8JJPfyLEU9OJ3a
 s5Nj047sCHIZ122g2k5q4z7X6TCu+Rol9+eXSM8NV/AoGx2mxC6FHJMH+KMaEBo5tD5N
 7EEoe2N378AhNYFqj73NpSLaxao8vW3VsUPT8CI6ttFMn6TZxYDgEAVCSh8XRr+M+jBj
 Y8HumnXjNNPxdnH5OxoQMeN+XAawHrioqd7p3XZAz22Ogd52k7yGHR/rOKY0g3tzoz2I
 PbSYGb6UyDr7tqYhzyeIzRRwv/V68ABB/ZrajmKbIs6rO5KOFUHGaTEVjqhglW2Uq6yx
 6wKg==
X-Gm-Message-State: AOJu0YzT6D0aULs7vwQITe1xvAZQvXYjoqb3QnGfgG8BCNRuyzhxeamY
 ZZQWFv8d2s/zEnFN+ECahxawbPXQa2CtooLZ2V4iNCTYepSMfbnBoMmRmZVeWvVI9MJX7R3NrJq
 Q/+8M4PBmNU7b9gDc3kHruS0HFUHWnYIBLczxVA84CIkWf0csOtK1YEGr
X-Gm-Gg: AZuq6aIyRiyNWuMWMwctfd7SnM0BGNKfWUfY2K8yhpuJK8zilqLAL+ZeAoe6ElNuqIH
 eFnZ84BFnZbvhIsqLLX4j3avrIH4ysKgEwcGZd0JsWAyBAnBb5wdGOdURNVDzVcYYWBXuH1xJ0I
 zgXNs0sQHVWg93Fx/wst3tiKuE/k3GMWRbGA4gi8IzkgJMqKS0H6yILcHc6nKgaRhzxyYXAJ43n
 ygQ/31wpJ0wadglscPrqojDcMKH0tAdbUETCEyJvd20bBE46+kF2VZrstCiCmpCOGOkx+T4tiKJ
 MtupPqtE8Dfakd0liJn+7JKF1BoDq49o2u96W1jm2T9zf6FrbHxMVXOl9bAbYCo6vC0KCLMZiyd
 mWk4=
X-Received: by 2002:ad4:5fca:0:b0:894:7fbd:87a6 with SMTP id
 6a1803df08f44-894b070b1d5mr77522216d6.13.1769455409208; 
 Mon, 26 Jan 2026 11:23:29 -0800 (PST)
X-Received: by 2002:ad4:5fca:0:b0:894:7fbd:87a6 with SMTP id
 6a1803df08f44-894b070b1d5mr77521906d6.13.1769455408787; 
 Mon, 26 Jan 2026 11:23:28 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894982efc39sm110254966d6.30.2026.01.26.11.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 11:23:28 -0800 (PST)
Date: Mon, 26 Jan 2026 14:23:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 03/10] migration: Remove one migration_in_colo_state()
 occurance
Message-ID: <aXe_LsP4mgeyjXVE@x1.local>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-4-peterx@redhat.com>
 <87ikcsihec.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ikcsihec.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 23, 2026 at 10:32:27AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Move the send header operation directly into Xen's QMP command, as COLO
> > doesn't need it.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Thanks!

> 
> We should make an effort to unify qemu_save_device_state and
> qemu_savevm_state_complete_precopy_non_iterable, they're almost the
> same.

Let me give it a shot.

-- 
Peter Xu


