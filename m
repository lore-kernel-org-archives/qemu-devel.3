Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585B0CAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 10:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy6fZ-0005eq-O5; Mon, 15 Sep 2025 06:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy6fW-0005eb-UN
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uy6f5-00022f-SM
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 06:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757932929;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xA0VgpfxlZyHkKd289F843B+aGIjnha6/zx/UpKXwhY=;
 b=fZoTG3t1zkBzsSXA6wY2KGw4ff2WLFvD/DZLNAarE3Qyy+tp/n78/qCyjH0FWmYnjGUsEW
 q1BCjonP3kt7WmnhM/5EH+zJHNCQvpQbEXQ4dopyZl9phOAjwP3Ns4YX6zuNr/A2uJjwtX
 G0SosWbpd2IYbrUzXQkbNw0b6uEkDNI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-2LyP4_mRM8OAANKb9yemEw-1; Mon,
 15 Sep 2025 06:42:08 -0400
X-MC-Unique: 2LyP4_mRM8OAANKb9yemEw-1
X-Mimecast-MFC-AGG-ID: 2LyP4_mRM8OAANKb9yemEw_1757932927
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CDC91800292; Mon, 15 Sep 2025 10:42:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 103C2180035E; Mon, 15 Sep 2025 10:42:05 +0000 (UTC)
Date: Mon, 15 Sep 2025 11:42:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/6] tests/functional: remove last use of avocado.utils
Message-ID: <aMftegnnIUMFST6x@redhat.com>
References: <20250912182200.643909-1-berrange@redhat.com>
 <87qzw8qahi.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzw8qahi.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 11:24:41AM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > This simply imports the GDB code from avocado.utils to the QEMU
> > functional test suite, and drops the other redundant avocado
> > usage.
> 
> Missing patches include dropping the:
> 
>   @skipIfMissingImports('avocado.utils')
> 
> from the reverse tests.
> 
> With this done can we remove the remaining references to avocado?
> 
>   python/Makefile                                                   
>   110:	@avocado --config avocado.cfg run tests/                     
>   118:	@coverage run -m avocado --config avocado.cfg run tests/*.py 
>   python/README.rst
>   73:- ``avocado.cfg`` Configuration for the Avocado test-runner.          
>   python/qemu/machine/README.rst
>   5:QEMU. It is used by the iotests, vm tests, avocado tests, and several  
>   python/qemu/utils/README.rst
>   5:debugging QEMU. It is used primarily by the vm and avocado tests.      
>   python/setup.cfg
>   37:    avocado-framework >= 90.0                                         
>   python/tests/minreqs.txt
>   35:avocado-framework==90.0                                               
>   python/tests/protocol.py
>   7:import avocado                                                         
>   160:class Smoke(avocado.Test):                                           
>   208:class TestBase(avocado.Test):

IIUC, John Snow plans to drop the 'python' directory during this
release cycle, so I think we can ignore that for now. I've also
suggested that python-qemu-qmp would be better off switching to
use pytest instead of avocado, as the latter is what python devs
are commonly familiar with and is sufficient for our needs.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


