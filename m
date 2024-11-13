Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598F7D637BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBKNe-0001Lt-Ck; Wed, 13 Nov 2024 15:54:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKNb-0001Lk-Vc
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBKNa-00020o-Hj
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731531261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HsD2O8Yuv4PMO1WKqguMiS6ul2lMFcYGOZVeJRnXvTc=;
 b=Y5B8sH+AibfchqAHsFHvOUXixTM8Z0wxlPkTK+1wpDYl7D2NgIVA8qYzyr1fNgAS0fHiNe
 kYX3KMpv0tIYBpww8drOJ9jhjgkdOEzhJ2Hm+t0HT2wiHEOjRH4JaRpELtBlDp+qML5/Sw
 4JPOkO9z+3RI4xLthC+Uv/No0MnlBuw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-167-zuMBpNdDPnqUp4C0HdnDvA-1; Wed, 13 Nov 2024 15:54:19 -0500
X-MC-Unique: zuMBpNdDPnqUp4C0HdnDvA-1
X-Mimecast-MFC-AGG-ID: zuMBpNdDPnqUp4C0HdnDvA
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b14f5ca413so1057452585a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:54:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731531259; x=1732136059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HsD2O8Yuv4PMO1WKqguMiS6ul2lMFcYGOZVeJRnXvTc=;
 b=GegfqcsALGryOLjAWiiKBxnuwwViAnQmtbKEcLAxefCUMJT376Km9V4CetNIx0zOu4
 5fh0EyPFeKYBfwS4ACsc3kSdIDPZ9KdEkD9bfaju1NhHJh/Md4H1e334k485vusqt7ik
 bm2/BWBVMpJOBtDR+Iq5ElOVKZcNmcEUaEPfn7zQ0dS7N751Ins2FqBl7+IDGPyVykco
 K28xJheI2Zo1Cgk7ImRKYtPda3P++O9qjgeoDP+xsXYWwBFfEblkepTPpbGWJc/CfGmD
 iYf+ZNlMm2ITjKw7jQgvizaCEvmOeveMiaYH10SpsgI8EHoM2bW0M75PPg3/TK7JEaZE
 /5Rg==
X-Gm-Message-State: AOJu0YwLZNd2c57psVIAuj8WZM563AZ0V7lvDFOzRa5s62WuZ5PQd0JW
 XBo1Gdww4FDINE+ZfIZNdsGdch+74LsQ1KS6m+YMG8DndOn6iWwuJ89+fHRv1hva/nh5NEUViW7
 uH1KpkOfe/Y3HsDyYuWrKBhYVEpD/henU0w3TuKR5ZHI1sRe3hVyS
X-Received: by 2002:a05:620a:2688:b0:7b1:54e5:6183 with SMTP id
 af79cd13be357-7b331f2e9dfmr3028023085a.53.1731531259195; 
 Wed, 13 Nov 2024 12:54:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYrWBWVRYX0f04He61S+HD1nPZaesPRLdW+kKuwxmLNR7PUjn1tELKTWcrJvNWz51plGti4w==
X-Received: by 2002:a05:620a:2688:b0:7b1:54e5:6183 with SMTP id
 af79cd13be357-7b331f2e9dfmr3028021385a.53.1731531258913; 
 Wed, 13 Nov 2024 12:54:18 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b32ac44629sm731561985a.40.2024.11.13.12.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:54:18 -0800 (PST)
Date: Wed, 13 Nov 2024 15:54:15 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V3 05/16] migration: SCM_RIGHTS for QEMUFile
Message-ID: <ZzUR92pCcSn2U5Pj@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-6-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-6-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On Fri, Nov 01, 2024 at 06:47:44AM -0700, Steve Sistare wrote:
> Define functions to put/get file descriptors to/from a QEMUFile, for qio
> channels that support SCM_RIGHTS.  Maintain ordering such that
>   put(A), put(fd), put(B)
> followed by
>   get(A), get(fd), get(B)
> always succeeds.  Other get orderings may succeed but are not guaranteed.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

>  struct QEMUFile {
>      QIOChannel *ioc;
>      bool is_writable;
> @@ -51,6 +56,9 @@ struct QEMUFile {
>  
>      int last_error;
>      Error *last_error_obj;
> +
> +    bool fd_pass;

One nitpick: I'd rename this to allow_fd_pass, or any name clearly shows
that it's a capability.

> +    QTAILQ_HEAD(, FdEntry) fds;
>  };

-- 
Peter Xu


