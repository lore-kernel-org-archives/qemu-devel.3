Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A46103E2EA
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 22:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0SRP-0003aW-LF; Wed, 11 Mar 2026 18:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0SRJ-0003Zx-I8
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w0SRG-0004Qx-HZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 18:54:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773269640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J6Wfl0dzMb/0zWwoylO2C3CHxECDz88E0lJeNxLooa4=;
 b=SslCkYmq08y9mTIwxtlpD8yBfndDr+mXtmql1nWG/lr8uSbnDRHd327xbhAOFfdub/TWFM
 OVr+kuA6bhQB0jU9V3JVoZI85E89Cf7v1BDqF/cPmWYgGD46eR0dtjbwdOmS0dMN5WXuYC
 WWqsmQmszWLo6TKwNax80FrIoKAWANg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-LA3tI6kuMNOZacXLcE4hhw-1; Wed, 11 Mar 2026 18:53:58 -0400
X-MC-Unique: LA3tI6kuMNOZacXLcE4hhw-1
X-Mimecast-MFC-AGG-ID: LA3tI6kuMNOZacXLcE4hhw_1773269638
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35a02f3b8e2so1553841a91.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 15:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773269638; x=1773874438; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J6Wfl0dzMb/0zWwoylO2C3CHxECDz88E0lJeNxLooa4=;
 b=Si2M+rpng39BzyktGOlol6TPsGtpHjswznpYLUAXHnGDUbo4M81QDcEiQZVWZucBgv
 zuJpirUboBCVxbYZdKeKQOtxNSJmGNPvogccwqa3jdwzIf6Gi+s5wttBVD1nS29izX9h
 PMzLOTOiNe6MrXNFPgbTPNTtPp+TU8ND2pPhu2h1PH77S75GzZyvM+7F8ETfbStM3EEm
 ekMMkgVtVEk7GveQGd1quM7Vzg3qvL9p07+mjgKaY6PTFMIIs+X619ZGRGEze5pIlUc3
 8SMwt04JRBnhGJA97neSsO8SUdkMkTzE1yAnNLxHhd8pBlRjZUiZ+v3BzDukBd/SrVNw
 Rw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773269638; x=1773874438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J6Wfl0dzMb/0zWwoylO2C3CHxECDz88E0lJeNxLooa4=;
 b=Kc2hAspATLiCKpiHmqxXvBlBGUnJKG4QzkA1ZBmAZ2t2zQsvs6i1LhhHIiC4c1zMwN
 Jv4hfMLZGGsHxCOVPQKp1VZRYKODpDMzqK8pA/Yk0QGOjXj3N38DGD9+fWeLPWWk/oNM
 CsiecggToSBmnGHXmzA66DGNSFPEhDBu3HDiocBJHTzQmHjGOMnOlXQNr3ur2QRm25SG
 gD2Hct9+yv8uTZtM7mYOyFXFQAaf4gZAvHwgeK/eOp7+H22Qbub990iwt2L1yEz2V2bb
 BOtQ93EoV4T8GanOvGpT9Qdbvh8cNGav4NfjB7JaMjMgckJ0IsGb3JKG+0igLHk6PxbW
 Tukg==
X-Gm-Message-State: AOJu0YzT/2QXjlN65whZaI7d42z8neJtVe9TkUIecBbFEcx2CQt/9jzx
 bRvXtkMyXW/AHME60R6ngfY0/GwFr2tOj9hUgCeTpWhfhm/2HFwYLWMXmZsYvtQm2x4ZF4nFyqA
 +0EjPTcA+l6+tCSijtmCauQKCwgoJ1TSbMSh5oZZkcV85pDR2/yWVvmlN
X-Gm-Gg: ATEYQzy+4TuEtAZqi4J8V1MaXdchP+Nl2lnwST0ILLtDyAsqkcLEas5JjW+6mOtJLUX
 bcZvIqW4HTuXbmJmlH2sTtUonFZBth5S80dJ3OCs7kFmF2p7FM8zO40L16QIcuz/tWxhUELOb5b
 c3YGEspAFLuZrp+8GM2EcI+pk2TZ0v7Kz4FSGTg4d684S+l6++vB8pzTAu+xeoasdeE+7T6hr7f
 /Q93BkIIMuZWmuRESTtS35YDkPtK+3OH9xhP2WMz1g0PmN1lxe+UQTOI4osENhS3lyOxH56ePLG
 lKN09PyG82c0T9D74S3LS+Obtxi/oMm1R4yw+5LrkmDpv7eff1p6sWZ3jhHx6ajEtPZkUxoP+7t
 6oUjzsqC9hZEs5g==
X-Received: by 2002:a17:90b:4a08:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-35a011d351bmr4220436a91.13.1773269637753; 
 Wed, 11 Mar 2026 15:53:57 -0700 (PDT)
X-Received: by 2002:a17:90b:4a08:b0:32e:a5ae:d00 with SMTP id
 98e67ed59e1d1-35a011d351bmr4220411a91.13.1773269637263; 
 Wed, 11 Mar 2026 15:53:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-359ffdb6e53sm1367185a91.0.2026.03.11.15.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 15:53:56 -0700 (PDT)
Date: Wed, 11 Mar 2026 18:53:54 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Prasad Pandit <ppandit@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 5/5] tests/qtest/migration: Force exit-on-error=false
Message-ID: <abHygq03y43ubjsn@x1.local>
References: <20260311213418.16951-1-farosas@suse.de>
 <20260311213418.16951-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311213418.16951-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Mar 11, 2026 at 06:34:18PM -0300, Fabiano Rosas wrote:
> Some tests can cause QEMU to exit(1) too early while the incoming
> coroutine has not yielded for a first time yet. This trips ASAN
> because resources related to dispatching the incoming process will
> still be allocated in the io/channel.c layer without a
> straight-forward way for the migration code to clean them up.
> 
> As an example of one such issue, the UUID validation happens early
> enough that the temporary socket from qio_net_listener_channel_func()
> still has an elevated refcount. If it fails, the listener dispatch
> code never gets to free the resource:
> 
> Direct leak of 400 byte(s) in 1 object(s) allocated from:
>     #0 0x55e668890a07 in malloc asan_malloc_linux.cpp:68:3
>     #1 0x7f3c7e2b6648 in g_malloc ../glib/gmem.c:130
>     #2 0x55e66a8ef05f in object_new_with_type ../qom/object.c:767:15
>     #3 0x55e66a8ef178 in object_new ../qom/object.c:789:12
>     #4 0x55e66a93bcc6 in qio_channel_socket_new ../io/channel-socket.c:70:31
>     #5 0x55e66a93f34f in qio_channel_socket_accept ../io/channel-socket.c:401:12
>     #6 0x55e66a96752a in qio_net_listener_channel_func ../io/net-listener.c:64:12
>     #7 0x55e66a94bdac in qio_channel_fd_source_dispatch ../io/channel-watch.c:84:12
>     #8 0x7f3c7e2adf4b in g_main_dispatch ../glib/gmain.c:3476
>     #9 0x7f3c7e2adf4b in g_main_context_dispatch_unlocked ../glib/gmain.c:4284
>     #10 0x7f3c7e2b00c8 in g_main_context_dispatch ../glib/gmain.c:4272
> 
> The exit(1) also requires some tests to setup qtest to expect a return
> code of 1 from the QEMU process. Although we can check migration
> status changes to be fairly certain where the failure happened, there
> is always the possibility of QEMU exiting for another reason and the
> test passing. This happens frequently with sanitizers enabled, but
> also risks masking issues in the regular build.
> 
> Stop allowing the incoming migration to exit and instead require the
> tests to wait for the FAILED state and end QEMU gracefully with
> qtest_quit.
> 
> In practice this means setting exit-on-error=false for every incoming
> migration, changing MIG_TEST_FAIL_DEST_QUIT_ERR to MIG_TEST_FAIL and
> waiting for a change of state where necessary.
> 
> With this, the MIG_TEST_FAIL_DEST_QUIT_ERR error result is now unused,
> remove it.
> 
> The affected tests are:
> validate_uuid_error
> multifd_tcp_cancel
> dirty_limit
> precopy_unix_tls_x509_default_host
> precopy_tcp_tls_no_hostname
> tcp_tls_x509_mismatch_host
> dbus_vmstate_missing_src
> dbus_vmstate_missing_dst
> 
> Also add a comment to QEMU source explaining that the incoming
> coroutine might block for a while until it yields as this is the
> actual root cause of the issue.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

Only one optional comment:

[...]

> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 8279504db1..61cd7db6cc 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -173,6 +173,12 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
>      /* This function relies on the event to work, make sure it's enabled */
>      migrate_set_capability(to, "events", true);
>  
> +    /*
> +     * Set the incoming migration to never exit QEMU abruptly during
> +     * the tests. It causes issues when running sanitizers and
> +     * expecting a failure exit code can mask other issues.
> +     */
> +    qdict_put_bool(args, "exit-on-error", false);

We could assert that the key isn't already there in case the caller thought
it was still valid to set.. can be done when queue if you like that.

>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>                      args);

-- 
Peter Xu


