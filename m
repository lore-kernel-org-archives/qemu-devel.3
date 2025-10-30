Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69746CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPT1-00059Q-Ca; Thu, 30 Oct 2025 06:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEPSz-000595-0l
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEPSr-0001zo-Bl
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761818461;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oNv5bi6Q/ZjYjDj9bEMBGlwv5BNh5l9uZrhNRgRa2Tg=;
 b=gamtQz22Gnh+r9MC9xxceG/X3B9g574z+fyK6KSOlOxZ3nC8lxijK7thpNqEOH2IVe8/FT
 eeJ5QhcFh/UeURVKr2UgrK7dPGWJknbicpCqmDUbS27qzutGvxxOTVEEk7eC+8qxR50IKS
 kvXeJq0AUD2Z+vtdSmbvGFPLlK7mtUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-zHu_J5_NOiyzTE5L9_jZ6w-1; Thu,
 30 Oct 2025 06:00:58 -0400
X-MC-Unique: zHu_J5_NOiyzTE5L9_jZ6w-1
X-Mimecast-MFC-AGG-ID: zHu_J5_NOiyzTE5L9_jZ6w_1761818456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E6B41955D97; Thu, 30 Oct 2025 10:00:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6F7B719560A2; Thu, 30 Oct 2025 10:00:53 +0000 (UTC)
Date: Thu, 30 Oct 2025 10:00:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Amit Shah <amit@kernel.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] scripts/vmstate-static-checker: Fix deprecation warnings
 with latest argparse
Message-ID: <aQM3UTGm8GnMAAIM@redhat.com>
References: <20251030092638.39505-1-thuth@redhat.com>
 <aQMw-AO720PNFzWW@redhat.com>
 <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e315a0a-5876-4816-8db3-fecbe2b1ebaf@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 10:42:20AM +0100, Thomas Huth wrote:
> On 30/10/2025 10.33, Daniel P. Berrangé wrote:
> > On Thu, Oct 30, 2025 at 10:26:38AM +0100, Thomas Huth wrote:
> > > From: Thomas Huth <thuth@redhat.com>
> > > 
> > > The argparse.FileType() type has been deprecated in the latest argparse
> > > version (e.g. the one from Fedora 43), now causing the test_bad_vmstate
> > > functional test to fail since there are unexpected strings in the output.
> > > Change the script to use pathlib.Path instead to fix the test_bad_vmstate
> > > test and to be prepared for the future when the deprecated FileType gets
> > > removed completely.
> > > 
> > > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > ---
> > >   scripts/vmstate-static-checker.py | 13 +++++++------
> > >   1 file changed, 7 insertions(+), 6 deletions(-)
> > 
> > AFAICT, using pathlib.Path should work going back to any old python
> > versions we would need.
> 
> According to https://docs.python.org/3/library/pathlib.html it has been
> added with Python 3.4, and we require at least 3.9 nowadays, so yes, this
> should be fine.
> 
> > > @@ -393,10 +394,10 @@ def main():
> > >                           help='reverse the direction')
> > >       args = parser.parse_args()
> > > -    src_data = json.load(args.src)
> > > -    dest_data = json.load(args.dest)
> > > -    args.src.close()
> > > -    args.dest.close()
> > > +    with open(args.src, 'r', encoding='utf-8') as src_fh:
> > > +        src_data = json.load(src_fh)
> > > +    with open(args.dest, 'r', encoding='utf-8') as dst_fh:
> > > +        dest_data = json.load(dst_fh)
> > 
> > This could be
> > 
> >   src_data = json.load(args.src.read_text('utf-8'))
> >   dest_data = json.load(args.dest.read_text('utf-8'))
> 
> Does not work, looks like the load() function cannot deal with a string:
> 
> $ scripts/vmstate-static-checker.py -s
> tests/data/vmstate-static-checker/dump1.json -d
> tests/data/vmstate-static-checker/dump2.json
> Traceback (most recent call last):
>   File "../scripts/vmstate-static-checker.py", line 439, in <module>
>     sys.exit(main())
>              ~~~~^^
>   File "../scripts/vmstate-static-checker.py", line 397, in main
>     src_data = json.load(args.src.read_text('utf-8'))
>   File "/usr/lib64/python3.13/json/__init__.py", line 293, in load
>     return loads(fp.read(),
>                  ^^^^^^^
> AttributeError: 'str' object has no attribute 'read'

Sorry, I typod - it should be 'json.loads'  - note the trailing
's' for "string"

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


