Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD4B3C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 06:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcJbh-0003XU-21; Tue, 20 Feb 2024 01:27:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJbf-0003XI-Fo
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcJbd-0001TZ-MI
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 01:27:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708410470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7dckX/uLjNXgexKKGJTBNoA0kx09ZG53+9QRSEc2Yns=;
 b=U93Q2so19oJHrd9R7MZdMLU6HrS9Tx5mksycnnOvViL9YLbNRrH0J3WM5EtQXQF+qy+pyk
 3HfySE3D/fBOqKWoghQkksegqNs/JlLy8qfK7GabyGYMGwCIZJYF7+V8XzENgTYHfW3hhN
 LYFRdZyN/6pZFZDv+wGh8OY299quhVM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-90nisfoSNee0nUa45fz54Q-1; Tue, 20 Feb 2024 01:27:48 -0500
X-MC-Unique: 90nisfoSNee0nUa45fz54Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so847993a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 22:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708410467; x=1709015267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dckX/uLjNXgexKKGJTBNoA0kx09ZG53+9QRSEc2Yns=;
 b=wHFsqoX6vjSAA9yOQVk4Tmuvly/pQncbDK02SYaubS9EHNsGKSYKH2YbqUqwQ3o0iS
 FDpuzVE0mB30r6DTkBJ4qOmQocAPBx+FxUtpl+UE9/Jy3uDQin5Xt+5ExOBpb0NywLne
 wv+asnc/BtZcy3/0oBJbl11HnbPsKY0HTWEr2ArXR0F+L7E0PAE+jTsKVgHlMFWqcxKa
 U7NtEY1PKLYfR4hQDGTZ+AuLnc8vKCaWZhkXiI7qQ0oNa69r/TUEyI5FG5/pyiJl2hr+
 Pd/obhOab0przmPg0Uf5xZGXysFkzBWukMKdLIQdb16YOcPLty7wbw72emoYsGOKZIQe
 sSgg==
X-Gm-Message-State: AOJu0Ywg2Rpk0nwJDx9sycThAvVx4C9L2g+hUmo7wbLgvfYs4Wp5+i3n
 htAqd3DjD2BCfyBvlFzOJnCXAMCHFywJw/v5WDV5RoxryZpWxI3zfcHKwLWAdeEPBtTNx7Q5KyA
 y3z4wpt5HiT63BAyjxleUIM5vUhyLRlvLn+mSHBrPWH4/aNn/R+hm
X-Received: by 2002:a17:90b:116:b0:299:4a1:ca9a with SMTP id
 p22-20020a17090b011600b0029904a1ca9amr11705820pjz.0.1708410467481; 
 Mon, 19 Feb 2024 22:27:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExenQjvBaP4AAZv+ePwczJe0kEiIDZAPyLdpjB2yf4el6joJfqWQEi7yYPw9NahJZogdYw3w==
X-Received: by 2002:a17:90b:116:b0:299:4a1:ca9a with SMTP id
 p22-20020a17090b011600b0029904a1ca9amr11705810pjz.0.1708410467043; 
 Mon, 19 Feb 2024 22:27:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 q69-20020a17090a17cb00b0029954a48c38sm6701744pja.38.2024.02.19.22.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 22:27:46 -0800 (PST)
Date: Tue, 20 Feb 2024 14:27:36 +0800
From: Peter Xu <peterx@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, berrange@redhat.com,
 farosas@suse.de
Subject: Re: [PATCH 3/3] qtest: migration: Add negative validation test for
 'uri' and 'channels' both set
Message-ID: <ZdRGWE6JOwILipSu@x1n>
References: <20240216090624.75445-1-het.gala@nutanix.com>
 <20240216090624.75445-4-het.gala@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240216090624.75445-4-het.gala@nutanix.com>
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

On Fri, Feb 16, 2024 at 09:06:24AM +0000, Het Gala wrote:
> Ideally QAPI 'migrate' and 'migrate-incoming' does not allow 'uri' and
> 'channels' both arguments to be present in the arguments list as they
> are mutually exhaustive.
> 
> Add a negative test case to validate the same. Even before the migration
> connection is established, qmp command will error out with
> MIG_TEST_QMP_ERROR.
> 
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  tests/qtest/migration-test.c | 83 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 0bc69b1943..9b9395307f 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -26,6 +26,7 @@
>  #include "qapi/qobject-output-visitor.h"
>  #include "crypto/tlscredspsk.h"
>  #include "qapi/qmp/qlist.h"
> +#include "qemu/cutils.h"
>  
>  #include "migration-helpers.h"
>  #include "tests/migration/migration-test.h"
> @@ -2516,6 +2517,86 @@ static void test_validate_uuid_dst_not_set(void)
>      do_test_validate_uuid(&args, false);
>  }
>  
> +static MigrationChannelList *uri_to_channels(const char *uri)
> +{
> +    MigrationChannelList *channels = g_new0(MigrationChannelList, 1);
> +    MigrationChannel *val = g_new0(MigrationChannel, 1);
> +    MigrationAddress *addr = g_new0(MigrationAddress, 1);
> +    char **saddr;
> +
> +    addr->transport = MIGRATION_ADDRESS_TYPE_SOCKET;
> +
> +    saddr = g_strsplit((char *)uri, ":", 3);
> +    if (!saddr[0] || saddr[0] != g_strdup("tcp")) {
> +        fprintf(stderr, "%s: Invalid URI: %s\n", __func__, uri);

Can use g_assert() in such a test; stderr can be easily ignored and
forgotten when it hits.

I'd think parsing it from URI is a slight overkill, as we can pass in
rubbish in the "channels" parameter, but it's still okay.

> +    }
> +    addr->u.socket.type = SOCKET_ADDRESS_TYPE_INET;
> +    addr->u.socket.u.inet.host = g_strdup(saddr[1]);
> +    addr->u.socket.u.inet.port = g_strdup(saddr[2]);
> +    g_strfreev(saddr);
> +
> +    val->channel_type = MIGRATION_CHANNEL_TYPE_MAIN;
> +    val->addr = addr;
> +    channels->value = val;
> +
> +    return channels;
> +}
> +
> +static void do_test_validate_uri_channel(MigrateCommon *args, bool should_fail)
> +{
> +    QTestState *from, *to;
> +
> +    if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
> +        return;
> +    }
> +
> +    /* Wait for the first serial output from the source */
> +    wait_for_serial("src_serial");
> +
> +    /*
> +     * 'uri' and 'channels' validation is checked even before the migration
> +     * starts.
> +     */
> +    if (args->result == MIG_TEST_QMP_ERROR) {
> +        migrate_qmp_fail(from, 
> +                args->connect_uri ? args->connect_uri : NULL,
> +                args->connect_channels ? args->connect_channels : NULL, "{}");
> +        goto finish;
> +    }

IIUC below are dead code.  We can drop them.

> +
> +    migrate_qmp(from,
> +                args->connect_uri ? args->connect_uri : NULL,
> +                args->connect_channels ? args->connect_channels : NULL, "{}");
> +
> +    if (should_fail) {
> +        qtest_set_expected_status(to, EXIT_FAILURE);
> +        wait_for_migration_fail(from, false);
> +    } else {
> +        wait_for_migration_complete(from);
> +    }
> +
> +finish:
> +    test_migrate_end(from, to, args->result == MIG_TEST_SUCCEED);
> +}
> +
> +static void
> +test_validate_uri_channels_both_set(void)
> +{
> +    g_autofree char *uri = g_strdup("tcp:127.0.0.1:0");
> +
> +    MigrateCommon args = {
> +        .start = {
> +            .hide_stderr = true,
> +        },
> +        .connect_uri = uri,
> +        .connect_channels = uri_to_channels(uri),
> +        .listen_uri = "defer",
> +        .result = MIG_TEST_QMP_ERROR,
> +    };

Instead of using MigrateCommon/MIG_TEST_QMP_ERROR, IMHO you can unwrap the
whole do_test_validate_uri_channel() here, invoke migrate_qmp_fail()
directly with the wrong parameter set.

See, for excample, test_baddest().

PS: please scratch my previous comment on patch 1 over the assertion; I
just read that all wrongly.. sorry.

> +
> +    do_test_validate_uri_channel(&args, true);
> +}
> +
>  /*
>   * The way auto_converge works, we need to do too many passes to
>   * run this test.  Auto_converge logic is only run once every
> @@ -3544,6 +3625,8 @@ int main(int argc, char **argv)
>                         test_validate_uuid_src_not_set);
>      migration_test_add("/migration/validate_uuid_dst_not_set",
>                         test_validate_uuid_dst_not_set);
> +    migration_test_add("/migration/validate_uri/channels/both_set",
> +                       test_validate_uri_channels_both_set);
>      /*
>       * See explanation why this test is slow on function definition
>       */
> -- 
> 2.22.3
> 

-- 
Peter Xu


