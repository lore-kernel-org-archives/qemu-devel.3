Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3411C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 06:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW957-0004Bw-GH; Tue, 23 Jul 2024 02:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sW954-0004BM-KZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:33:03 -0400
Received: from galois.linutronix.de ([193.142.43.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <t-8ch@linutronix.de>)
 id 1sW952-0003mn-Ee
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 02:33:02 -0400
Date: Tue, 23 Jul 2024 08:32:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1721716363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXqan0tb6MQ+wTC7mfNkEitlRIBF60hu07WK8wxDxJg=;
 b=dm8ObF0o1V2K4uWtzij3B3awXCPqU+rFk/Cd0CW+B9sGRTmu4DWrBX6QpqlEbLdA4vQWRQ
 PV6wozra6tnIiq1meoYejdKJhaFJ1jvCgRw/BEin9Ax8XYSyL8/WGlthg+tiwEacIjXlTs
 nzkLNrxDGlz4IoytoqxDZBDAz0bdaAbyaQ2ky8o+g0i+YR9wYOoAzefaIxaq1BH3P6DH2S
 SukAIbLRsLn/CdADJJRi0O14BImUrW9lzISOuY+lNjLz2/cT74E14QRfcitXDtRVcu8ldK
 p2D8tRaJzx3mlEwWGntK0nSqVlcO4BdL1UqS0q3VWy59nGN8f0YjJkH/A/MFIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1721716363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXqan0tb6MQ+wTC7mfNkEitlRIBF60hu07WK8wxDxJg=;
 b=Jf92PZpEMXuLl5liLzOFmRnUYIqQxpCe4Fom9FCDN3cw9F4P7nwPKUv6hFHD9dWZCb08k4
 DPhl8OOj5BMKHCDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>
Subject: Re: [PATCH v6 4/4] docs: add test for firmware.json QAPI
Message-ID: <20240723080952-f0b6b263-d99b-4cf9-8943-32b627db0cfd@linutronix.de>
References: <20240719-qapi-firmware-json-v6-0-c2e3de390b58@linutronix.de>
 <20240719-qapi-firmware-json-v6-4-c2e3de390b58@linutronix.de>
 <20247471-ba88-4757-b522-5d750e378fc4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20247471-ba88-4757-b522-5d750e378fc4@linaro.org>
Received-SPF: pass client-ip=193.142.43.55; envelope-from=t-8ch@linutronix.de;
 helo=galois.linutronix.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Philippe,

On Tue, Jul 23, 2024 at 12:15:24AM GMT, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 19/7/24 09:37, Thomas Weißschuh wrote:
> > To make sure that the QAPI description stays valid, add a testcase.
> > 
> > Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > Link: https://lore.kernel.org/qemu-devel/d9ce0234-4beb-4b90-b14c-76810d3b81d7@linaro.org/
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   docs/meson.build | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/docs/meson.build b/docs/meson.build
> > index 9040f860ae1a..bcca45a342a3 100644
> > --- a/docs/meson.build
> > +++ b/docs/meson.build
> > @@ -99,3 +99,8 @@ if build_docs
> >     alias_target('html', sphinxdocs)
> >     alias_target('man', sphinxmans)
> >   endif
> > +
> > +test('QAPI firmware.json regression tests', python,
> > +     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
> > +            meson.current_source_dir() / 'interop/firmware.json'],
> > +     env: test_env, suite: ['qapi-schema', 'qapi-interop'])
> 
> Did you test this on GitLab CI? Many jobs are failing as:
> 
> Program /builds/qemu/build/pyvenv/bin/sphinx-build skipped: feature docs
> disabled
> ../docs/meson.build:106:10: ERROR: Unknown variable "test_env".
> 
> See https://gitlab.com/philmd/qemu/-/pipelines/1383618475/failures

No, I only tested it locally. It works there.
I'll try to setup a personal GitLab CI.

To fix the issue, I think "test_env" can be removed.
The other calls to "qapi_gen", which 

As a fix for this issue, I think "test_env" can be removed,
and apparently "qapi_gen" can also be executed without the explicit
python reference:


diff --git a/docs/meson.build b/docs/meson.build
index bcca45a342a3..322452c87787 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -100,7 +100,7 @@ if build_docs
   alias_target('man', sphinxmans)
 endif

-test('QAPI firmware.json regression tests', python,
-     args: [qapi_gen.full_path(), '-o', meson.current_build_dir() / 'qapi',
+test('QAPI firmware.json regression tests', qapi_gen,
+     args: ['-o', meson.current_build_dir() / 'qapi',
             meson.current_source_dir() / 'interop/firmware.json'],
-     env: test_env, suite: ['qapi-schema', 'qapi-interop'])
+     suite: ['qapi-schema', 'qapi-interop'])

