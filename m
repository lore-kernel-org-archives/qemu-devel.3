Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C87CA600E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEkfh-0004fd-EA; Thu, 08 Oct 2026 05:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkfe-0004fJ-Gb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xEkfc-00055H-QL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 05:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791452652;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jN9dPYeZk56zo5yuRass1boK2D3nRJgdF/ynH0McFLM=;
 b=ZRTKAKOCRZ526LeOoK6EoMQkTg+QoQGLJlp5zYazD6EMuDzfXpw/5VQKy8e7f+RYOb48/j
 lYHGJZLmMQy/fukQmoag6UFJiyHeICiPQJXpPWEuBEd7rtWKbife1R+Y75phrUPe2mY+hj
 rVWYPkrjW6wyL3eUYN5NacG332miX4k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-139-7rT915UpO3GjbNljWG180A-1; Thu,
 8 Oct 2026 09:44:08 +0000
X-MC-Unique: 7rT915UpO3GjbNljWG180A-1
X-Mimecast-MFC-AGG-ID: 7rT915UpO3GjbNljWG180A_1791452647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAFB719540DF; Thu,  8 Oct 2026 09:44:06 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B5D830001BB; Thu,  8 Oct 2026 09:44:04 +0000 (UTC)
Date: Thu, 8 Oct 2026 10:44:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v2 3/3] tests/qtest: check query-target architecture
Message-ID: <asdl4QXXhbg83nob@redhat.com>
References: <20261007184612.24073-1-pierrick.bouvier@oss.qualcomm.com>
 <20261007184612.24073-4-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261007184612.24073-4-pierrick.bouvier@oss.qualcomm.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Oct 07, 2026 at 06:46:12PM +0000, Pierrick Bouvier wrote:
> From: Yonggang Luo <luoyonggang@gmail.com>
> 
> Check that query-target reports the target identity selected by the qtest
> binary, including softmmu variants.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/qtest/qmp-test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> index 927ab053f8a..c70f6a681c1 100644
> --- a/tests/qtest/qmp-test.c
> +++ b/tests/qtest/qmp-test.c
> @@ -164,6 +164,18 @@ static void test_qmp_protocol(void)
>      qtest_quit(qts);
>  }
>  
> +static void test_query_target(void)
> +{
> +    QTestState *qts = qtest_init(common_args);
> +    QDict *target;
> +
> +    target = qtest_qmp_assert_success_ref(qts,
> +                                          "{ 'execute': 'query-target' }");
> +    g_assert_cmpstr(qdict_get_try_str(target, "arch"), ==, qtest_get_arch());
> +    qobject_unref(target);
> +    qtest_quit(qts);
> +}
> +
>  #ifndef _WIN32
>  
>  /* Out-of-band tests */
> @@ -517,6 +529,7 @@ int main(int argc, char *argv[])
>      g_test_init(&argc, &argv, NULL);
>  
>      qtest_add_func("qmp/protocol", test_qmp_protocol);
> +    qtest_add_func("qmp/query-target", test_query_target);
>  #ifndef _WIN32
>      /* This case calls mkfifo() which does not exist on win32 */
>      qtest_add_func("qmp/oob", test_qmp_oob);
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


