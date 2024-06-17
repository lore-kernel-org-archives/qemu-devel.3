Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E920C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJI1A-000788-DQ; Mon, 17 Jun 2024 15:27:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJI18-00077d-CC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:27:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sJI15-0001vQ-R3
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718652466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tAQb4szCkr+j969gP1feEYSkJObijA/yBRaVr/mzhmg=;
 b=bUkM48k8g4Y2r2PPhcvmKA3v4ggMQO79312u/RLV1RPUAtdiMwmJcGEmbNztSoPXrKWBtz
 Gdmkzn0W5oJlDrzVkRbcQVz9/PxwpSc8dyn0SeoWYQHNPH0LdqCpqzYbPed+rWKrici5Cx
 aYh5nKdIG0jWEMbpk//1Jr5bpqeH4vY=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-8JsfkurUMCi7PNs7AZcKYA-1; Mon, 17 Jun 2024 15:27:44 -0400
X-MC-Unique: 8JsfkurUMCi7PNs7AZcKYA-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-5b970b125fcso815742eaf.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 12:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718652464; x=1719257264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tAQb4szCkr+j969gP1feEYSkJObijA/yBRaVr/mzhmg=;
 b=Ltun5I3kqeeilE/56Vwi/awRDMwGpEgsi4NwUL8/PuoBMBo+9fuiHzrXDphEbzsnRY
 g8hsqYpaTZ/IKOI+l08boISUVDErlqO5CUCbqkBpspvVkgcEY/spRBnUZ6YxxeA+FnDm
 Pr2O+T4TtUieJ7WoiAi/Cqt4zYrSficvUlVNGHLipYaGeBSVowqWVuGjp09uCkjEYkKj
 5j4Sn0PsqFozHbba1gyl5x52M1KXTu3LW2ysMablMNC2dTWlZfh8wSyrJkPtPCXaMXhE
 24wotOtBI8T3FrjKhuerXVcvY8aOFUOkG0KUDgcq4VEqS8evDzkOfKVCtNnDmRvLeDVG
 ycLw==
X-Gm-Message-State: AOJu0Yy4E4TJAGVFj7Fsq2MK2N58uSHBAbhJ2fMA6RYRsPKcianCc3ar
 8WU7hrcqcGJPZutPYRVhf8atMYjtacSa4mPz0VxyXDKLm7k3wEE0dgscs9cHEecdGOwmNkM7XM0
 95n6KZvbZahK+rCi2m4cxQaNVF7bx7W4swsGruSkhyvtDcje+p2hv
X-Received: by 2002:a9d:75d7:0:b0:6f9:dc1b:9fd2 with SMTP id
 46e09a7af769-6fb93b03706mr11211481a34.2.1718652463668; 
 Mon, 17 Jun 2024 12:27:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWVLka+lF2zJzEZIto7KsbBh/gEIC2VRAxc85pIYt0fIoqYBpYI/QrmXzwbNvBx+Yczrcsug==
X-Received: by 2002:a9d:75d7:0:b0:6f9:dc1b:9fd2 with SMTP id
 46e09a7af769-6fb93b03706mr11211458a34.2.1718652463199; 
 Mon, 17 Jun 2024 12:27:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5f08414sm58042956d6.140.2024.06.17.12.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 12:27:42 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:27:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 16/16] tests/qtest/migration: Add a test for
 mapped-ram with passing of fds
Message-ID: <ZnCOLGWajlKxtzfo@x1n>
References: <20240617185731.9725-1-farosas@suse.de>
 <20240617185731.9725-17-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240617185731.9725-17-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jun 17, 2024 at 03:57:31PM -0300, Fabiano Rosas wrote:
> Add a multifd test for mapped-ram with passing of fds into QEMU. This
> is how libvirt will consume the feature.
> 
> There are a couple of details to the fdset mechanism:
> 
> - multifd needs two distinct file descriptors (not duplicated with
>   dup()) so it can enable O_DIRECT only on the channels that do
>   aligned IO. The dup() system call creates file descriptors that
>   share status flags, of which O_DIRECT is one.
> 
> - the open() access mode flags used for the fds passed into QEMU need
>   to match the flags QEMU uses to open the file. Currently O_WRONLY
>   for src and O_RDONLY for dst.
> 
> Note that fdset code goes under _WIN32 because fd passing is not
> supported on Windows.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
> - dropped Peter's r-b
> 
> - stopped removing the fdset at the end of the tests. The migration
> code should always cleanup after itself.

Ah, that looks also ok.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


