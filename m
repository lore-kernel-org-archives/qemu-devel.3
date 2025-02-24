Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FCCC021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmeb4-00038s-JM; Mon, 24 Feb 2025 14:58:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmeb3-00037I-K0
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:58:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tmeb2-0007DG-3y
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740427111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X7t66MBcngOHJGQ4soKTk2Q+VBEN1o/1ZXgBQcPYFg=;
 b=EH0BWxzKR2pgI9KhWD6BNejMFb2Vl9vh6H7ho0RT3SixWyDjMc1p1nm001fVaZtD2BWAuS
 uwEUjaab8sYhkR25HY5Cig0Yt9DqEAaw7/xBqBkkGImiNjtPsEsJHVnoRlp6Q0bYjfgWfX
 NbZBMX/mGr2m6wV+5RZBGoAzY6TLrBQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-7T2rw6CRMRORmKqNdlI-eQ-1; Mon, 24 Feb 2025 14:58:29 -0500
X-MC-Unique: 7T2rw6CRMRORmKqNdlI-eQ-1
X-Mimecast-MFC-AGG-ID: 7T2rw6CRMRORmKqNdlI-eQ_1740427109
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4721e6dd15eso115358301cf.3
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 11:58:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740427109; x=1741031909;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7X7t66MBcngOHJGQ4soKTk2Q+VBEN1o/1ZXgBQcPYFg=;
 b=q7IDe8kMJY8BD8uK+fm+WL8vwXrL6uZtEPacy0ATQbmXCyualNSvg1iju/zRPuYoyv
 ArVaUbhJb8r4l7oDbCeFY4fBidFaolroEDdlLTl+ki9s3J9stCCrlasRqDlrsXHMTo7t
 CE84LGe23z93r+5m1HWgqjIAIBFzyYhrJ4QGFIon3QzeGcTMPa6u8xibkcg1zRfLYPso
 Vz89ZILaBvLSowV67qEJDibbPtKLVN1gEhnWfC/PB0FD+KySw6A0HGlhGKa66JMplEu/
 xwDnu3iHKsp2Gl7BIc1hMWFF+janGCg6Wi3FQ9OOoH0if+TMnuYgf54dyZLcbTaphgvf
 EJTw==
X-Gm-Message-State: AOJu0YwI3pjDe1q1m+XkyXH+zFgPHJ9f0ElVJWtZVPezO3A0jKssWw+R
 N+V1MiA9iAWskiULphMXR1mnm+jj7Yev/I87blZOBToymyBi8U2p82j2HbllfKlvw5miP3YhJhb
 d6hklWfQGQJ6kggKGhNc/J4NC9mdhQKyBB2HGC7MIDLGfESnV2Nyw
X-Gm-Gg: ASbGncsH/D80nNQGPpelpJW8fvpzskRjoUFHdEhXQm+5+ESzWHXMwzlvmLWa3xj+vtM
 yGb/isx4A8kVVbmm73l1joB2U6sOQYnWu4hiRyLFCKWnopZuF2v6cvSb3eb/tyzMoaF32F3ys/W
 Gr6wu1RRJQY6XdqdpLog6pWoxEoLAPiWc34SFhlZCtiVlRavVrTE9M/oGdEtkap9l2mWD9pdAic
 qETpFiIpM7IkXANvi9uzLYI5gVvr/hrlwMizBLKCqRJcOD1QSEsKmSLuTk2Qhxblv9Vsw==
X-Received: by 2002:a05:622a:649:b0:472:957:dfa8 with SMTP id
 d75a77b69052e-4737721a893mr9821911cf.18.1740427109061; 
 Mon, 24 Feb 2025 11:58:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsfOmSrdpeuvRjlz0cgTqYBXHoZRl43uHsn62Ere63eA7HJ4IzsVENUk40MQRGLcoXTLV88Q==
X-Received: by 2002:a05:622a:649:b0:472:957:dfa8 with SMTP id
 d75a77b69052e-4737721a893mr9821631cf.18.1740427108716; 
 Mon, 24 Feb 2025 11:58:28 -0800 (PST)
Received: from x1.local ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47378072dc9sm229871cf.63.2025.02.24.11.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 11:58:28 -0800 (PST)
Date: Mon, 24 Feb 2025 14:58:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/8] migration: Add
 migration_capabilities_and_transport_compatible() helper
Message-ID: <Z7zPYfWp2fLRB63W@x1.local>
References: <20250221063612.695909-1-lizhijian@fujitsu.com>
 <20250221063612.695909-6-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221063612.695909-6-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Fri, Feb 21, 2025 at 02:36:09PM +0800, Li Zhijian wrote:
> Similar to migration_channels_and_transport_compatible(), introduce a
> new helper migration_capabilities_and_transport_compatible() to check if
> the capabilites is compatible with the transport.
> 
> Currently, only move the capabilities vs RDMA transport to this
> function.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Yeah this is even better, thanks.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


