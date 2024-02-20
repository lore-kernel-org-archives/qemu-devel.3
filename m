Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69BA7C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJFk-0007jE-8y; Tue, 20 Feb 2024 01:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJFi-0007j2-NV
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:05:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJFh-000636-Cr
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:05:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708409112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A2yt10IBctzhFDq1L7QMYkvCFbT5+k5GL2IFUM4ZcHw=;
 b=HpN5IMm4GHHVXEtyWwtnpw/wakFHSciD9dShhRmcvJOEGWDzZDMRMn5JdXswiBRmojW7W6
 kBAbckxMqsRDQIti8G6AGxKnPEtjwjhX9mq1sJJGFdaHnDtsKl7r4ueuytrGL2UQmCxG/k
 5rIkWKnoOB5eG7v4mq+ED2y66nzS20s=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-aT8NXYN_PrSSE9032-FaeQ-1; Tue, 20 Feb 2024 01:05:08 -0500
X-MC-Unique: aT8NXYN_PrSSE9032-FaeQ-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so842023a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:05:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708409107; x=1709013907;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2yt10IBctzhFDq1L7QMYkvCFbT5+k5GL2IFUM4ZcHw=;
 b=OZl4j2l0PQTggRlUHENvfklhOg0l760fTMEj8IcKFfPx1jUDULxas1MAI670AstBv7
 3PxjA8xpg66ghqGLl6SyQcZJDnGLDghCqaZ7AcDS9zjDGzJ1X/7e7sE4oKnyZwP+oJk6
 9mWLdbJT9xna/5hXkM9xVXsBceVf7Q71hpMkKtTbVVfrwOupivAbKSJoHoJNFXSXaz4k
 yBjgHYHqP63i+0FbmtAHz69+p3QdDYQfPIUOO9OUTPAbC+QDjXcLUgamTjM1A4IiUPoa
 lYhqPn4ChrhMdsUzFsu0SaNAJF+9bsqMXWfspNODFNTKpBNat0dnGcgAjHkyX+OjzxZA
 h9DA==
X-Gm-Message-State: AOJu0Yx4N0JXAib9rj4uHYdRXLcW/2FlsUsRxaZ6T150ydzCfFTd+yp2
 H+/fsglV3DYN8gJHPMuM+iZBXFSw7xcxEf+TD3b5xBvvSs0b+D0ZmJ8v8k9ji8HfZo2tjC79psx
 KdSUUDaF0vr+yN7LGmdftV5AxEJLBjSyGnnlTSk819zRxmxXrIARq
X-Received: by 2002:a17:90b:116:b0:299:4a1:ca9a with SMTP id
 p22-20020a17090b011600b0029904a1ca9amr11675875pjz.0.1708409107583; 
 Mon, 19 Feb 2024 22:05:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2LFA8BvrrOh2SHwshsOOs0brqn66vJPag3PuK/cKlMeMT/wB6+QuZG/a0nNhbRtfnkd77xw==
X-Received: by 2002:a17:90b:116:b0:299:4a1:ca9a with SMTP id
 p22-20020a17090b011600b0029904a1ca9amr11675860pjz.0.1708409107262; 
 Mon, 19 Feb 2024 22:05:07 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 qn11-20020a17090b3d4b00b00298f88c3e48sm6330695pjb.11.2024.02.19.22.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:05:06 -0800 (PST)
Date: Tue, 20 Feb 2024 14:04:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH 2/3] qtest: migration: Introduce 'connect_channels' in
 MigrateCommon struct
Message-ID: <ZdRBCYIOiOV39i2x@x1n>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-3-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216090624.75445-3-het.gala@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

On Fri, Feb 16, 2024 at 09:06:23AM +0000, Het Gala wrote:
> migration QAPIs can now work with either 'channels' or 'uri' as their
> argument.
> 
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-test.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index e7f2719dcf..0bc69b1943 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -704,6 +704,13 @@ typedef struct {
>       */
>      const char *connect_uri;
>  
> +    /*
> +     * Optional: list of migration stream channels, each connected
> +     * to a dst QEMU. It can be used instead of URI to carry out
> +     * the same task as listen_uri or connect_uri.
> +     */
> +    MigrationChannelList *connect_channels;
> +
>      /* Optional: callback to run at start to set migration parameters */
>      TestMigrateStartHook start_hook;
>      /* Optional: callback to run at finish to cleanup */

Please squash this patch into the follow up patch that uses it.  Thanks,

-- 
Peter Xu


