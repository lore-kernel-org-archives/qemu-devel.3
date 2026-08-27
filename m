Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56466C61DC6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:49:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZXW-0008FH-5o; Thu, 27 Aug 2026 08:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzZXU-0008F1-FG
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzZXS-0008Lq-IF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 08:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787834941;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WH0QvqPLyEeCA79Uprp3ZTXX4P31Vupg5rjY/PNkcTc=;
 b=behg1lZSWUKAEbmWw1aIJd46dSVuOH/vmZWEeTD7Qo50cWSyXClVivbNeYGYsTIA94OJRY
 Xd42ZwZFcmRngF0bOwCndgG+3JiwS7ObBPV+LEzVwYGHK4T2iGxruwouiPmTrlgGKEO9PS
 sPoaUWY1JI+4bDykxbZgrH9yaz+a7zs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-ISyv-eKOOouWhZ0gTtpSgg-1; Thu,
 27 Aug 2026 08:47:46 -0400
X-MC-Unique: ISyv-eKOOouWhZ0gTtpSgg-1
X-Mimecast-MFC-AGG-ID: ISyv-eKOOouWhZ0gTtpSgg_1787834864
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E74F1802142; Thu, 27 Aug 2026 12:47:44 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41BD21955F05; Thu, 27 Aug 2026 12:47:40 +0000 (UTC)
Date: Thu, 27 Aug 2026 13:47:37 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Jamin Lin <jamin_lin@aspeedtech.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2 9/9] tests/qtest: Add ASPEED SBC ECDSA engine test
Message-ID: <apAx6ZY2uXW5rhDr@redhat.com>
References: <20260821032036.1829294-1-jamin_lin@aspeedtech.com>
 <20260821032036.1829294-10-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260821032036.1829294-10-jamin_lin@aspeedtech.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Aug 21, 2026 at 03:20:49AM +0000, Jamin Lin wrote:
> Add a qtest for the ASPEED secure boot controller ECDSA engine. It stages
> the public key, signature and SHA-384 digest of a secp384r1 known-answer
> vector (from the Linux kernel crypto self-test manager,
> ecdsa_nist_p384_tv_template) into the SEC SRAM, triggers the engine's
> verify command and checks the status register: a valid signature reports
> done + pass, and a tampered signature reports done without pass.
> 
> The test is skipped when the crypto backend does not support ECDSA, via
> qcrypto_akcipher_supports().
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>  tests/qtest/aspeed-sbc-test.c | 193 ++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build       |   2 +
>  2 files changed, 195 insertions(+)
>  create mode 100644 tests/qtest/aspeed-sbc-test.c
> 

> +static void aspeed_add_sbc_ecdsa_tests(const char *prefix, const char *machine,
> +                                       uint32_t sec_addr, uint64_t sram_addr)
> +{
> +    int i;
> +
> +    for (i = 0; i < ARRAY_SIZE(sbc_ecdsa_tests); i++) {
> +        QCryptoAkCipherOptions opts = {
> +            .alg = QCRYPTO_AK_CIPHER_ALGO_ECDSA,
> +            .u.ecdsa.curve_id = sbc_ecdsa_tests[i].curve_id,
> +        };
> +        g_autofree char *path = NULL;
> +        AspeedSBCTest *t;
> +
> +        if (!qcrypto_akcipher_supports(&opts)) {
> +            g_printerr("# skip SBC ECDSA %s test: not supported by the crypto "
> +                       "backend\n", sbc_ecdsa_tests[i].name);

We ought to use  g_test_skip(...) instead of g_printerr("# skip....)
so we don't assume use of TAP format.

> +            continue;
> +        }
> +
> +        path = g_strdup_printf("%s/sbc/ecdsa/%s", prefix,
> +                               sbc_ecdsa_tests[i].name);
> +        t = g_new0(AspeedSBCTest, 1);
> +        t->machine = machine;
> +        t->sec_addr = sec_addr;
> +        t->sram_addr = sram_addr;
> +        t->index = i;
> +        qtest_add_data_func_full(path, t, test_ecdsa_verify, g_free);
> +    }
> +}

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


