Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3DCA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBCQH-0003se-41; Mon, 28 Sep 2026 10:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCQF-0003rb-7x
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:33:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xBCQD-0006Pq-Cw
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790606016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ax9/rvtNXZfmI2GMEXwbLcj/lSr0/nxAbJD0T3pQwaM=;
 b=QghrHpvOJATX2ZrN6pIhcblpndUOuLHpFiEFjkRFOgvSBlRO76bN2dwSKZQKtYLTQi9oCp
 sFkNTfSQL0z368k93AmUpdfGWPpbif8nIXv94cDQhOumZXs7peS3hStoGIxsZ2fQRhhgC4
 9wqi3iSTXeTSNCT3FcNXRaTLpSzFBB8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-bajDAYzcMwWbgGluyr_EBw-1; Mon, 28 Sep 2026 10:33:31 -0400
X-MC-Unique: bajDAYzcMwWbgGluyr_EBw-1
X-Mimecast-MFC-AGG-ID: bajDAYzcMwWbgGluyr_EBw_1790606011
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so797306585a.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790606011; x=1791210811; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ax9/rvtNXZfmI2GMEXwbLcj/lSr0/nxAbJD0T3pQwaM=;
 b=J0t+7Kobzbas8rRI2MROjJu22wBMHQ5mgH7L8zm6EdjugGXHZKN5Plz87ZBe6QL/Os
 AwZezQZNgY6yXh4/kATUPuh1evzexWD0ujWPCHoDDZb6DyL9HNYOVfDfwPi7GvvW+RVQ
 E6H5nEwGklIWy9kYmXJdnnLF3BjRhBITir9GJkEFebThsltw1SlwNwwsvN3KEdnsuj7/
 IC222FQZRGY3B+aQ0I2xc16Q4zb7dqWyivoHrhDyoVowzs/XFpH4ZE05y9JPDn5dofca
 wMMNFZJYJLTyTO8dKDoTxmX/4HveuUX86/zoGfsJpcuyoJWJma+jsdK3tyxkHuCFshiT
 zC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790606011; x=1791210811;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ax9/rvtNXZfmI2GMEXwbLcj/lSr0/nxAbJD0T3pQwaM=;
 b=dj2jbetBACUdJVqscNQF/aRW+zzTMq8cWDhmfgHlm1LO0mDQ3dhDqwa4sZZyD1d/+G
 5vgMjG39B7U0fvNYrPCpmWFVBCRK8WnwwD1dqcDGnPLmR/9HaCPl3c22XHmBULKumiVT
 Hh36iO3QaNTwwR+oEqqU9g1fHqNknNm7ejI8wxLTJ8q5Yrv5SJqZG6qZttkcDFQSGf3v
 /cK/2TAZt3vNEOV4tzkcP52YmkKkdRE48QzsaHIiI/qmTr30ENdWk3xfLVrLMCnXh3b4
 sLzi6L3cc+AKyeFz/3NF/ITL6cUFjlzmk4/VlXoSWGZunEvlgEGS1RN8OHZTVPooEJQr
 L8qQ==
X-Gm-Message-State: AFuF++lWyjqCR9q+oUjKfiVTPCDby7QWiDmW3A8w3AVbie8O5sye/kT5
 6vkkfAGlteMmmgRxUCG79jk7r/abqjjYkkk4UdxJDIT5DaEjwVdY22+ECC0wdlYFA+g5AzoasD4
 KG5EJtp+74o1NlWpYqisTcoKVcvcah6RHtLxQcUfAA2n5I7vTIsuwybK7
X-Gm-Gg: AYBFou3XaUTKRYnHvHZ2+m7TYupoxTEiVtLNjXQIxKt8VjPg8cE+B0W2kQ/+0CwKYVU
 l/PkoqsJY7/WFT4A/5BA8EcGU4wiR0jwK6ryF/Yf4NPEGyYxO6D9UnlTbBkcqgJuD9TF16ZVGOp
 iYN6qSE1/bq4k5TYs3RebVl0PkGyiXHIce4xvH0Z/jlI51zAFdl0MrOFH08MQzGJl5AhmZWEjeA
 j6Rk7mXpBOkoMgKzbpaZi4rpb8xIz8mJxi7irYCD61pziR0UhOoCY4+WThc/NPV4Erdees4jeF0
 svq/Q/deSREyodtE6N2c0iLNrbcufuXeNJ3Y0SvSGaJcdng8y1cu0Hm8oQPGHlIbqc/yGSM=
X-Received: by 2002:a05:620a:254f:b0:93c:2faf:e1e6 with SMTP id
 af79cd13be357-93c43c90958mr2124005885a.25.1790606011005; 
 Mon, 28 Sep 2026 07:33:31 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:93c:2faf:e1e6 with SMTP id
 af79cd13be357-93c43c90958mr2124000285a.25.1790606010378; 
 Mon, 28 Sep 2026 07:33:30 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c813d04f1sm166307085a.18.2026.09.28.07.33.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:33:28 -0700 (PDT)
Date: Mon, 28 Sep 2026 10:33:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, bchaney@akamai.com,
 mark.kanda@oracle.com, philmd@oss.qualcomm.com,
 vsementsov@yandex-team.ru, maciej.szmigiero@oracle.com,
 dongli.zhang@oracle.com, mst@redhat.com, clg@redhat.com,
 den@openvz.org, sgarzare@redhat.com
Subject: Re: [PATCH v7 04/16] tests/qtest/migration: add test for snapshot
 rejection in CPR modes
Message-ID: <arp6uJrL_XnWofFW@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260918-up-vsock-vhost-v5-v7-0-6ef9ef033c35@virtuozzo.com>
 <20260918-up-vsock-vhost-v5-v7-4-6ef9ef033c35@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260918-up-vsock-vhost-v5-v7-4-6ef9ef033c35@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 18, 2026 at 04:46:55PM +0300, Andrey Drobyshev wrote:
> Snapshots are refused whenever a CPR migration mode is set.  Add a test
> which sets each of the CPR modes in turn and checks that 'savevm' and
> 'loadvm' fail with the corresponding error, then switches back to
> 'normal' mode and checks that the error is gone.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qtest/migration/cpr-tests.c | 36 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/migration/cpr-tests.c b/tests/qtest/migration/cpr-tests.c
> index 0bec753b4ab..a5255193101 100644
> --- a/tests/qtest/migration/cpr-tests.c
> +++ b/tests/qtest/migration/cpr-tests.c
> @@ -290,11 +290,45 @@ static void test_mode_exec(char *name, MigrateCommon *args)
>      test_cpr_exec(args);
>  }
>  
> +/* Snapshots must be refused while a CPR migration mode is set */
> +static void test_mode_no_snapshot(char *name, MigrateCommon *args)
> +{
> +    static const char *const modes[] = {
> +        "cpr-reboot", "cpr-transfer", "cpr-exec",
> +    };
> +    QTestState *vm = qtest_init("-nodefaults");
> +    char *out;
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(modes); i++) {
> +        g_autofree char *expected = g_strdup_printf(
> +            "Snapshots are not compatible with migration mode %s", modes[i]);
> +
> +        migrate_set_parameter_str(vm, "mode", modes[i]);
> +
> +        out = qtest_hmp(vm, "savevm snap");
> +        g_assert_nonnull(strstr(out, expected));
> +        g_free(out);
> +
> +        out = qtest_hmp(vm, "loadvm snap");
> +        g_assert_nonnull(strstr(out, expected));
> +        g_free(out);
> +    }
> +
> +    /* Back in normal mode the mode check no longer fires */
> +    migrate_set_parameter_str(vm, "mode", "normal");
> +    out = qtest_hmp(vm, "savevm snap");
> +    g_assert_null(strstr(out, "not compatible with migration mode"));
> +    g_free(out);
> +
> +    qtest_quit(vm);
> +}
> +
>  void migration_test_add_cpr(MigrationTestEnv *env)
>  {
>      tmpfs = env->tmpfs;
>  
> -    /* no tests in the smoke set for now */
> +    migration_test_add("/migration/mode/no-snapshot", test_mode_no_snapshot);

We should justify each test to be added into default set because it bloats
the test matrix.

This is a negative test, I think it should be only for --full.  Note that
this will be covered by each PULL as long as when KVM enabled (IIUC when
top maintainers collect PRs these will be covered), and we also run --full
at least when preparing migration pulls.

Thanks,

>  
>      if (!env->full_set) {
>          return;
> 
> -- 
> 2.47.1
> 

-- 
Peter Xu


