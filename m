Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4CDC02194
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 17:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgS3H-000230-Fp; Fri, 07 Feb 2025 12:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgS3C-00022e-M8
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:21:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tgS3A-0000K0-Oa
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 12:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738948916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LzxGtKjlz9BgguS+WPVnTlXNzYMpKJ+pd/iHBb7vB+o=;
 b=VacDd3p/sGwyGsY7pwUrbpVJqFdq29Cz1u2wMkwDerzWECTzqUWZIHwzEchdpmvxJ4Rh5U
 lzH6QbQAZmgQQnN4wWjvJrBE+Y3+LZpUQ9h+ynWRe+L/LHwEpL0YpG/BUYxbQku0CiPKzO
 Q2ap9YGFjqyxb7Pjd+MErX9bOpXCFQ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412--u9Bm8nNMcKB5tbhND54XA-1; Fri, 07 Feb 2025 12:21:54 -0500
X-MC-Unique: -u9Bm8nNMcKB5tbhND54XA-1
X-Mimecast-MFC-AGG-ID: -u9Bm8nNMcKB5tbhND54XA
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7bf4704255dso366780285a.0
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 09:21:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738948912; x=1739553712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LzxGtKjlz9BgguS+WPVnTlXNzYMpKJ+pd/iHBb7vB+o=;
 b=tXzXNrwO48THCZwlkm9FjLo8eHrZq5xPJ/hAoWhU5DqPzo57i7EQyYWnkkXYh8EYv2
 KdzXQc4WVITzmgI0PtAW6+ZHlF8sxUWAXMQIkR/0u1gMb+f4+xtoeuu+jCB/QkQ0UOit
 ZmL/CPKbJpycvsoI+Nyo4ucH5fKsGd5908toq0xM4uKNJblED6GZ+MRlVa6djR1ihRzS
 cXOImcRVeZmaQDPl9wMjLw5fma8zVhMMGZHFMoEZa8+ku1gjLytnXAkGc6VPHEq/oJFa
 X/avQl4vNyyteGLmVfa6cXaxeJElPTf9GutIzLwIHowhA2gOKFSflasaTT1q1yA2Y0th
 Rldg==
X-Gm-Message-State: AOJu0Yzp4zI/K4ibt+ONaeazDTDz27MSUu8AjOqQESxCdK4F+yUOZ6RJ
 NAJcHmkgj0yyg5bZxx7ZkfmjZkaGtelHdh2fosItvE/9WduYqILkL9ppvPAhgjSASG0U5+xIwyM
 5oYk0QpNcEM4vsUyLnDpXi69RD6+6aOiunEedyPyduzCoZVFkQLh4
X-Gm-Gg: ASbGncuMBJs6cJvl0bItCjRPOaQk+/BR0mTOthSnlNKOlqIPxtY5pIdoS2T4EiPomkK
 Ps62b1ogNLcSG7ztIgzyvwKrw2lXmqb5VDWU0+uKFli/F+nZ+Cv9Zq0+rlmgDSNL/7G01V9VKT9
 2D3LZBvVaI1z1X9u71LPkeGjAlHTXoUdwyxZEEP8/w1a8NtNf7J/Xq/UvIR5GAeFxMBfD7Q44gW
 NhRuN9hEmx3Zh1Le5Jyg5OOavBkUzA626fI69pD53Me6xwDmeYuOGVRsXTHYo6GHXF2DUIO1nvC
 HE+4VhzNwSxyoTbxR2npuE71KBbVXxbPaWf3ORQ6z07icYAQ
X-Received: by 2002:ad4:5f4a:0:b0:6d8:d84d:d938 with SMTP id
 6a1803df08f44-6e4456c5c4emr49289616d6.28.1738948912456; 
 Fri, 07 Feb 2025 09:21:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQn+RCYg6Z4FmtYLAo7csT9gAhsbNq+WPOq/bOBrsmq+oIHWIdMtIHDQaOtBT1aNUdk/RXFA==
X-Received: by 2002:ad4:5f4a:0:b0:6d8:d84d:d938 with SMTP id
 6a1803df08f44-6e4456c5c4emr49289386d6.28.1738948912132; 
 Fri, 07 Feb 2025 09:21:52 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e444b5ad24sm11461836d6.103.2025.02.07.09.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 09:21:51 -0800 (PST)
Date: Fri, 7 Feb 2025 12:21:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH v2 1/8] crypto: Allow gracefully ending the TLS session
Message-ID: <Z6ZBLjToT9bRoyhI@x1.local>
References: <20250207142758.6936-1-farosas@suse.de>
 <20250207142758.6936-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250207142758.6936-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Feb 07, 2025 at 11:27:51AM -0300, Fabiano Rosas wrote:
> QEMU's TLS session code provides no way to call gnutls_bye() to
> terminate a TLS session. Callers of qcrypto_tls_session_read() can
> choose to ignore a GNUTLS_E_PREMATURE_TERMINATION error by setting the
> gracefulTermination argument.
> 
> The QIOChannelTLS ignores the premature termination error whenever
> shutdown() has already been issued. This is not enough anymore for the
> migration code due to changes [1] in the synchronization between
> migration source and destination.

This sentence seems to say commit [1] changed something on the tls
condition, but IMHO fundamentally the issue is multifd recv thread model
that relies on blocking readv() rather than request-based (like what src
multifd does).

Now src uses either shutdown() or close() to kick dest multifd recv threads
out from readv().  That has nothing to do with what we do during complete()
with those sync messages.. referencing it is ok, but we'll need to
reference also the other commit to be clear pre-9.0 can also be prone to
this.  To me, it's more important to mention the root cause on the multifd
recv thread model, which requires explicit tls terminations.

> 
> Add support for calling gnutls_bye() in the tlssession layer so users
> of QIOChannelTLS can clearly identify the end of a TLS session.
> 
> 1- 1d457daf86 ("migration/multifd: Further remove the SYNC on complete")
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

-- 
Peter Xu


