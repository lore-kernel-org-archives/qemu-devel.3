Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B46ECA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urGsd-0003kh-9a; Wed, 27 Aug 2025 10:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urGsb-0003jV-6E
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1urGsZ-0004ky-4S
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756303916;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtyU3ksn/cFoKwfq5+iZApP2yNxG2ql8D8rDH+UN4lU=;
 b=e7pKZpP2MaykEOhYKLf3thqJOM+oIkU8uv78GFLVJ45b5rEANw2X4uwqSHq1ukQDKGWvun
 CryjUWLKg0UzMfgI8bzTyYE1Jg+2RN6jn8BJAs+4kOz7lN6Du/FtjlqOEH3YVGq9sgeLsE
 Qr56t3bJtFB5Fus/qAa+hHOR/U4d8wg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-O95ulrUHM7qwPyJ4yKef2g-1; Wed,
 27 Aug 2025 10:11:52 -0400
X-MC-Unique: O95ulrUHM7qwPyJ4yKef2g-1
X-Mimecast-MFC-AGG-ID: O95ulrUHM7qwPyJ4yKef2g_1756303910
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3895518002B1; Wed, 27 Aug 2025 14:11:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.195])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9F6530001A6; Wed, 27 Aug 2025 14:11:46 +0000 (UTC)
Date: Wed, 27 Aug 2025 15:11:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 8/8] qapi: switch to use QEMU_TEST_REGENERATE env var
Message-ID: <aK8SHqwffuVIOEjk@redhat.com>
References: <20250806164832.1382919-1-berrange@redhat.com>
 <20250806164832.1382919-9-berrange@redhat.com>
 <87cy96mhu5.fsf@pond.sub.org> <aKNCMR9N85AVsyMT@redhat.com>
 <87tt1vsj8g.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tt1vsj8g.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Aug 25, 2025 at 02:01:35PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Aug 08, 2025 at 08:46:10AM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > The QAPI_TEST_UPDATE env var can be set when running the QAPI
> >> > schema tests to regenerate the reference output. For consistent
> >> > naming with the tracetool test, change the env var name to
> >> > QEMU_TEST_REGENERATE.
> >> >
> >> > The test is modified to provide a hint about use of the new
> >> > env var and it is also added to the developer documentation.document its usage.
> >> >
> >> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> [...]
> 
> >> > index 4be930228c..cf7fb8a6df 100755
> >> > --- a/tests/qapi-schema/test-qapi.py
> >> > +++ b/tests/qapi-schema/test-qapi.py
> >> > @@ -165,7 +165,7 @@ def test_and_diff(test_name, dir_name, update):
> >> >      if actual_out == expected_out and actual_err == expected_err:
> >> >          return 0
> >> >  
> >> > -    print("%s %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> >> > +    print("%s: %s" % (test_name, 'UPDATE' if update else 'FAIL'),
> >> 
> >> Is there a need for this, or is it just drive-by polishing?
> >
> > Just making it more consistent in style with other error print()
> > statements we have in the file, as well as this new one I'm
> > adding.
> 
> Which existing print()s do you mean?

I was referring to the ones in this method

    except OSError as err:
        print("%s: can't open '%s': %s"
              % (sys.argv[0], err.filename, err.strerror),
              file=sys.stderr)
        return 2

..

    except OSError as err:
        print("%s: can't write '%s': %s"
              % (sys.argv[0], err.filename, err.strerror),
              file=sys.stderr)


though I notice now they are using 'sys.argv[0]' which is not the
same as 'test_name', as well as using stderr. So the consistency
isn't actually helped

> 
> >
> >> 
> >> >            file=sys.stderr)
> >> >      out_diff = difflib.unified_diff(expected_out, actual_out, outfp.name)
> >> >      err_diff = difflib.unified_diff(expected_err, actual_err, errfp.name)
> >> > @@ -173,6 +173,9 @@ def test_and_diff(test_name, dir_name, update):
> >> >      sys.stdout.writelines(err_diff)
> >> >  
> >> >      if not update:
> >> > +        print(("\n%s: set QEMU_TEST_REGENERATE=1 to recreate reference output" +
> >> > +               "if the QAPI schema generator was intentionally changed") % test_name,
> >> > +              file=sys.stderr)
> >> >          return 1
> >> >  
> >> >      try:
> >> > @@ -197,7 +200,7 @@ def main(argv):
> >> >      parser.add_argument('-d', '--dir', action='store', default='',
> >> >                          help="directory containing tests")
> >> >      parser.add_argument('-u', '--update', action='store_true',
> >> > -                        default='QAPI_TEST_UPDATE' in os.environ,
> >> > +                        default='QEMU_TEST_REGENERATE' in os.environ,
> >> >                          help="update expected test results")
> >> >      parser.add_argument('tests', nargs='*', metavar='TEST', action='store')
> >> >      args = parser.parse_args()
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


