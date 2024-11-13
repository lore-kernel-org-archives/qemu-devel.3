Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A56D637D0
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 22:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBMFP-0008Uj-Lx; Wed, 13 Nov 2024 17:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBMFO-0008UY-D4
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:54:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBMFN-0000aO-1k
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 17:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731538438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S6JDfi+am/Xmwmcw/2Q8dsiIs+doOnufRht5QuqhghA=;
 b=ON8doUgIPn1Z3oPi/KVoUIuXHN9AO+6WK3c5/0KI9hBv/7/G84CgLSPOpoUXyYk6NbfqpW
 nn5CD3UWzp1tLFySOq8GSw0g22OytjG89J4Bjqxab9rgr8BJ+zz9G/3/1x43UgNHgxhk5s
 HIZmkLmAuHiq07WIzKPOf/V1qvN5R1M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-NrKaTTHFPZKq6Xzajv6SRw-1; Wed, 13 Nov 2024 17:53:56 -0500
X-MC-Unique: NrKaTTHFPZKq6Xzajv6SRw-1
X-Mimecast-MFC-AGG-ID: NrKaTTHFPZKq6Xzajv6SRw
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d3be9fbe69so55257336d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 14:53:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731538436; x=1732143236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S6JDfi+am/Xmwmcw/2Q8dsiIs+doOnufRht5QuqhghA=;
 b=BCWAsSQC2JFzPQkGKu14ms162EdD/FXw9+fNY7fzEV5oWpTp3VmzbImIl1mMBla1vZ
 STE/h21nt2n2cw0BosmLKJrxPi8wjJ3NAHJQc7LhjcJdrOZti5RgDK2vmxJPOGLXIUDo
 VlkDMmmcYjMuqBEo5tNgh3QCS+zLd6CvGu2bKeg/W7YTgSuRaog6jDVmjWV1wQcFOr7p
 yIA9mCyjx7ZWAzDYqs2Qh92LyoDkJk0z0cBUQbbXBbPmXSWd1OCSjkFyonK3PCxHYNjw
 dQFnE68NtoyqSZrhwEMr6jEFGGeLDGg6bwrMtGSV38L/2ghrfzQZNFIyV5EvdLSivOoE
 NIiA==
X-Gm-Message-State: AOJu0YwcqFVwHn9rcmAlNHwu+0s8xpb3MlbHx8n6oJ5o3Ilc9czJmLAS
 LOTl2ffXm2CW4vcE1iDL02Bwk7hlkw/WPeQr4oX0B095qbnHZUAWLtPqMySq/7304AvczASkdDZ
 ti66K7jgP1rWTlzoMSivaYTFnYBd7nMhhN2LXDO8PbFr/KAy4ozjA
X-Received: by 2002:a05:6214:5c42:b0:6cc:2c28:2ab3 with SMTP id
 6a1803df08f44-6d39e1bac1dmr277038526d6.41.1731538435979; 
 Wed, 13 Nov 2024 14:53:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdanPebgPn5aq9ZaKRotWO3mOXqPUwyNDbqHZjovOAN1pAkV/tUJcG/hf2Cn1VoVQ1GOLuoQ==
X-Received: by 2002:a05:6214:5c42:b0:6cc:2c28:2ab3 with SMTP id
 6a1803df08f44-6d39e1bac1dmr277038386d6.41.1731538435695; 
 Wed, 13 Nov 2024 14:53:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d39643c6a3sm89708976d6.81.2024.11.13.14.53.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 14:53:55 -0800 (PST)
Date: Wed, 13 Nov 2024 17:53:52 -0500
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
Subject: Re: [PATCH V3 13/16] tests/qtest: defer connection
Message-ID: <ZzUuACXDVbhubRqo@x1n>
References: <1730468875-249970-1-git-send-email-steven.sistare@oracle.com>
 <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1730468875-249970-14-git-send-email-steven.sistare@oracle.com>
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

On Fri, Nov 01, 2024 at 06:47:52AM -0700, Steve Sistare wrote:
> +void qtest_connect_deferred(QTestState *s)
> +{
> +    g_autofree gchar *socket_path = NULL;
> +    g_autofree gchar *qmp_socket_path = NULL;
> +
> +    socket_path = g_strdup_printf("%s/qtest-%d.sock",
> +                                  g_get_tmp_dir(), getpid());
> +    qmp_socket_path = g_strdup_printf("%s/qtest-%d.qmp",
> +                                      g_get_tmp_dir(), getpid());
> +
> +    s->fd = socket_accept(s->sock);
> +    if (s->fd >= 0) {
> +        s->qmp_fd = socket_accept(s->qmpsock);
> +    }
> +    unlink(socket_path);
> +    unlink(qmp_socket_path);

Why need to unlink again here if both sock/qmpsock are cached?  I assume we
could remove these lines together with above g_strdup_printf()s.

Otherwise two paths are leaked anyway (and we may also want to have some
macros to represent the paths used in two places).

Maybe we could also clear sock/qmpsock too after use, then check at the
entrance to skip qtest_connect_deferred() if already connected.

> +    g_assert(s->fd >= 0 && s->qmp_fd >= 0);
>      /* ask endianness of the target */
> -
>      s->big_endian = qtest_query_target_endianness(s);
> -
> -   return s;
>  }

-- 
Peter Xu


