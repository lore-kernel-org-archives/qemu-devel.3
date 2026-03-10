Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A8BFD4F3F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 20:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w03yU-00046u-C0; Tue, 10 Mar 2026 16:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03yS-00046X-90
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w03yP-00077d-Hj
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 16:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773175595;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfACbLUAuDYIC02beVs8D0Dh349UbdqXkuE9qkV9Olg=;
 b=dc3iqQItdZj5sBU6SIMcIR6bpOqQ/YnRLF1BIkrMNT5E6Nsr+B1nbCmvS7Pz2tW0fBfysL
 ugen/hO1aiuHHXhuPMhBZeYcXLIdrn7bzH07EZ3pKlr4jpfu/yNoyRSYXDy5/NNnkFPi4F
 pIbGro5/S+htACoh8e67cqV129GSTgE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-ONKjYYe0O-27CIfuosD7fg-1; Tue, 10 Mar 2026 16:46:34 -0400
X-MC-Unique: ONKjYYe0O-27CIfuosD7fg-1
X-Mimecast-MFC-AGG-ID: ONKjYYe0O-27CIfuosD7fg_1773175594
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-509044f54aaso227038391cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 13:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773175594; x=1773780394; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dfACbLUAuDYIC02beVs8D0Dh349UbdqXkuE9qkV9Olg=;
 b=ip5/mDVoHAcp86S3U5wtpEdMpoRRVXCscJsuyFlX+tgD9JBP22Z1vQdrjXQ/Z/oxrp
 hDWIyzOjKQXPcBh3YyQx29zWk35yC43NAeFpdcBoZywKT+nw2/xvZh3yD+izwmkIgEMb
 NtllThwm0k8xlfKEEcho5QepErnCodEXHIn/VSAVdGafF1I5huiN4s6RNVLuy9seQfx2
 +NTd3Vi8ZxCMRJz3O4RtOoA1SxEzOb1JAlGVJpVE1UJLgCbHDzoBs5hK7tKqxdAH5IWA
 hXrHbARk/ZMsiPfgU92O9My6UjlYjE5jubakCRAo7jTA7lWd8zfmm2djz/0Q7RrlGpPc
 tW6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773175594; x=1773780394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfACbLUAuDYIC02beVs8D0Dh349UbdqXkuE9qkV9Olg=;
 b=Fghr09zrUeNuJqCM18BrVun//RhkVbqqiJrven4hYRuO7pHPmubHDG6nEGXE0bTDue
 7/vwJ1CprIB1yowyZkdOJbMsbJzYnoDU8y5GsP6iC2WfabhEk5Bg9FNgX7rdYEYxPnJU
 hm/V1ha1hfen04/jGmAoOjivhXClVlHfwAT+415zzjWHDwzWDGgiDiLg2AV/FCSrzpAM
 MyP60JX9BE9AqL2iJ3k55VqRVUrURH3/NprfXLJVSdzSL20OUghEJOdxovOF0z4/3u+1
 HCytKAgj6s6jq/BKPQ+qcpSn9kio6NF6+flITYOdxffusdYerJJVx5dwhmyjRIU1FJK1
 llxg==
X-Gm-Message-State: AOJu0YwwvCm2Uc3l2vWHbnFcTk4gaeVv8+7LAcGrnyMm3z10EEQ3Gxk4
 bZzXmSHCxyZqf/pbLZE4Q4iOoxj437Wo9ipvg3WDTd5N8mITY+UvqeLLjCpnMtWCK9VgkEF2f3Y
 vtx05Qx696krMDTtf+Fw8Y2kg1w3Ouk0CB7d27VpZB9XAN9k7ZM3o7hu5
X-Gm-Gg: ATEYQzyhyqHI+JrR4S6teL9qQ/CxXm9+04xOZvD1KSxyNd1tMy5OosBkJOp95aFr6Lc
 fLEhzTyqzy4H6N5OH5yL9EWEolnzXwlTOkfm9Q+M2UtAwMsyo/qIBt2RBTllcFsdsd8AHzmVLsB
 elyL5uVHfk7XUjdkVZ07Tgza2fS+f1yGRIQH1ZVXxqfzgx9fIGyx2WDU0WSB6oU3dr8P8BBAo8y
 p/IvXHzu8n4Imr6zBUOtjaVs8ugwtZ/GAqF9KkFfkLwdBRbFfjpeV9HXOcWs05msSDNKAZT73s5
 PTaATrjrHpMSi8c5+AuJvpJYm4usgjrt8LH2Yjp9ZsZFjOpxMKh/xvt84vXjZ2WJJhgtmIrK0xr
 x3gBGAuVNMoSgOA==
X-Received: by 2002:a05:622a:1448:b0:509:348f:bc15 with SMTP id
 d75a77b69052e-5093a1bb292mr759181cf.69.1773175593783; 
 Tue, 10 Mar 2026 13:46:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1448:b0:509:348f:bc15 with SMTP id
 d75a77b69052e-5093a1bb292mr758911cf.69.1773175593328; 
 Tue, 10 Mar 2026 13:46:33 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50939e8e0ecsm517561cf.5.2026.03.10.13.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 13:46:32 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:46:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/8] tests/qtest/migration: Force exit-on-error=false
 when appropriate
Message-ID: <abCDJyknIzzX8dUy@x1.local>
References: <20260310135540.8679-1-farosas@suse.de>
 <20260310135540.8679-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310135540.8679-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 10:55:37AM -0300, Fabiano Rosas wrote:
> Some tests can cause QEMU to exit(1) too early while the incoming
> coroutine has not yielded for a first time yet. This trips ASAN
> because resources related to dispatching the incoming process will
> still be allocated in the io/channel.c layer without a
> straight-forward way for the migration code to clean them up.
> 
> Since this is an issue only affecting testing and leak detection,
> let's make sure tests only use MIG_TEST_FAIL_DEST_QUIT_ERR when
> strictly necessary.
> 
> To make this process easier, force exit-on-error=false for precopy
> whenever the expected test result is MIG_TEST_FAIL. The distinction
> between the two return codes is exactly that, the latter should never
> cause exit(1).
> 
> The affected tests for now are the TLS tests "no_hostname" and
> "mismatch_host".
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration/framework.c | 5 ++++-
>  tests/qtest/migration/tls-tests.c | 6 ++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
> index 4cc63bba7b..cfb8409d33 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -854,7 +854,10 @@ int test_precopy_common(MigrateCommon *args)
>              in_channels = qobject_from_json(args->connect_channels,
>                                              &error_abort);
>          }
> -        migrate_incoming_qmp(to, args->listen_uri, in_channels, "{}");
> +
> +        migrate_incoming_qmp(to, args->listen_uri, in_channels,
> +                             args->result == MIG_TEST_FAIL ?
> +                             "{ 'exit-on-error': false }" : "{}");

Can we set exit-on-error unconditionally?

In all cases:

Reviewed-by: Peter Xu <peterx@redhat.com>

>      }
>  
>      /* Wait for the first serial output from the source */
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index f636802642..6274906ad9 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -525,7 +525,8 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
>      args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_tls_x509_no_host;
>      args->end_hook = migrate_hook_end_tls_x509;
> -    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
> +    args->result = MIG_TEST_FAIL;
> +    args->start.incoming_defer = true;
>  
>      args->start.hide_stderr = true;
>  
> @@ -559,7 +560,8 @@ static void test_precopy_tcp_tls_x509_mismatch_host(char *name,
>      args->listen_uri = "tcp:127.0.0.1:0";
>      args->start_hook = migrate_hook_start_tls_x509_mismatch_host;
>      args->end_hook = migrate_hook_end_tls_x509;
> -    args->result = MIG_TEST_FAIL_DEST_QUIT_ERR;
> +    args->result = MIG_TEST_FAIL;
> +    args->start.incoming_defer = true;
>  
>      args->start.hide_stderr = true;
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


