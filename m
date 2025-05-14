Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8838AC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAjN-000065-Hp; Wed, 14 May 2025 07:57:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFAjJ-0008Tf-66
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:56:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uFAjC-0008Vt-Ck
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:56:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223806;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+2E+IpGhfF4EjUiNldbZbgyHpfYMc9BGroFl4B6tBjc=;
 b=cIvR2OIyUvEqcTadGxq//HSPy95eKDJ1VNJfefuAuTeApTC52ItgZeVZYZJ1ukilerDi1Y
 VWrFsA0u4prQNDHiyGR+JR18y6Bg47pyKxa5vbLTDMPFPw5u8w27KL83JeZOpxz7y/o82v
 iqi2Dq6HVjNME4NKeCOo/TxSkQzwcPE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-152-SpBRwElMPOm2F_o8q_Cobg-1; Wed,
 14 May 2025 07:56:43 -0400
X-MC-Unique: SpBRwElMPOm2F_o8q_Cobg-1
X-Mimecast-MFC-AGG-ID: SpBRwElMPOm2F_o8q_Cobg_1747223802
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EB71956052; Wed, 14 May 2025 11:56:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.147])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83B93180049D; Wed, 14 May 2025 11:56:41 +0000 (UTC)
Date: Wed, 14 May 2025 12:56:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 6/7] scripts/checkpatch: use new hook for MAINTAINERS
 update check
Message-ID: <aCSE9uGxFqnrrVSu@redhat.com>
References: <20250512182447.1139105-1-berrange@redhat.com>
 <20250512182447.1139105-7-berrange@redhat.com>
 <c0e68194-6aa4-4ca8-bee3-ebd67cd96489@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0e68194-6aa4-4ca8-bee3-ebd67cd96489@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, May 14, 2025 at 01:51:52PM +0200, Cédric Le Goater wrote:
> On 5/12/25 20:24, Daniel P. Berrangé wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > When seeing a new/deleted/renamed file we check to see if MAINTAINERS
> > is updated, but we don't give the user a list of files affected, as
> > we don't want to repeat the same warning many times over.
> > 
> > Using the new file list hook, we can give a single warning at the
> > end with a list of filenames included.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   scripts/checkpatch.pl | 37 +++++++++++++++++++------------------
> >   1 file changed, 19 insertions(+), 18 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 4a18daa384..d416a6dcf9 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1442,6 +1442,25 @@ sub process_file_list {
> >   		      join("\n  ", @acpi_nontestexpected) .
> >   		      "\n\nfound in the same patch\n");
> >   	}
> > +
> > +	my $sawmaintainers = 0;
> > +	my @maybemaintainers;
> > +	foreach my $fileinfo (@fileinfos) {
> > +		if ($fileinfo->{action} ne "modified" &&
> > +		    $fileinfo->{filenew} !~ m#^tests/data/acpi/#) {
> > +			push @maybemaintainers, $fileinfo->{filenew};
> > +		}
> > +		if ($fileinfo->{filenew} eq "MAINTAINEfRS") {
> 
> MAINTAINEfRS ? looks like a typo.

Opps, an intentional typo when I was testing logic that
I accidentally committed.

> 
> 
> With that fixed,
> 
> 
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


