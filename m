Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2150C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJYFO-0002LP-Ri; Mon, 26 May 2025 09:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJYFN-0002L1-HK
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJYFL-00044L-T8
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748267527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jU1pPQJIISNWMRhHnJ3cVHgdqW5TSEcB01tiZUkxClU=;
 b=cHba9Q7nGhLw9hnMsHNs8yC9d8FiDZdxs61dcfmxOcHeBVmu47dlheLNqrE78YoZAAr+tF
 puLnNCmUjE6i0lESvVcOojlmDpOn+FfpfAyOt27UhbMTpcCU+waCLjq2ENKyQvYyDb9JlD
 3MfD8TGTyAdYt4kYUWYN8NFb51ael7Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-jis5M2PuOv6TEyWSVYGUMQ-1; Mon, 26 May 2025 09:52:05 -0400
X-MC-Unique: jis5M2PuOv6TEyWSVYGUMQ-1
X-Mimecast-MFC-AGG-ID: jis5M2PuOv6TEyWSVYGUMQ_1748267525
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f2b50a75d8so28691446d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748267525; x=1748872325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jU1pPQJIISNWMRhHnJ3cVHgdqW5TSEcB01tiZUkxClU=;
 b=EvU4sP99NVhJ9eQNMWRwAgnGH7MdQ0k1laj6wJDkWoP+yxzXUkfd3tdEud9S5VnMr4
 xbQtQmGAoMFyT7NgF/4QCj1pCuBLzKK7UCURz+zykk2tSEBU9xukfbCwEfWiC2l3vIv9
 5DUy68HCEoCS6v7p46kaXmpZ5xgJ57WnsK6N+itl5E+VU3Oo3JmmSzvHnwOpMZ5VddX6
 c6qN3n4pxZwU29DXNxoCEIuya0q9P+BflMpOzUnxI+CkWEh37r04BPGyFrsPnMNpidZm
 g8X+mHIA0gKyX3T/OwxUdbacuKbWv7ZTnjt7UaOhB9rxqLddP6XpNSlPeDZdxOJ018gh
 SHDg==
X-Gm-Message-State: AOJu0YyYHizP79Zhfe6JpsRtwhrxIdvM+OjkWeDWRimIBuIeWxijls8C
 sFZlcPTw5hd8135bGV4BDdlp7F0EWgv741jrN7HKEA1aNRgEyxIsPK9Zz2wCS6clAkQ1Gabg8YJ
 PKmvRh9gPTxeL4mila4IN6GfzFEFC1RwHqDP2/oyVhlBKvo1nvLJb/1HA
X-Gm-Gg: ASbGnctSo37F+Acrdxl4ZcOYRqL9KpWHgw8CaqFlkFbN75Z8hus4Ivnrvd4SpMek9jY
 pKyYtmPi0YKkO2shiSm3uhjA2pz9l7Zi8SuexIUkN6Rhc3GT0qsj3CbQ6EMzgnqDYWjvUdYAqha
 L2fOsoAjfOmzeoUdlquldQIu4oBoPMStcQmj81wUsnzlbHqB3qaoj7eq8N5BfcrEBGIfHlJMHcc
 N/I3gd5i+BnZs/WrnKb6kR1M4eXcWbNuk9/DY6NsPDK/YqYD5JSXFsbZzX9nE8CIP2B+o3kH6wi
 7sE=
X-Received: by 2002:ad4:5c8f:0:b0:6fa:9c1d:91d4 with SMTP id
 6a1803df08f44-6fa9d152c62mr144694016d6.10.1748267524985; 
 Mon, 26 May 2025 06:52:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOC9K/Ss/p5xlZVn6mEnsANzmV0K3nZTWHV9KEqyNCjLEw5thjJ4Bq5Euwsg+YRcEiW4nZew==
X-Received: by 2002:ad4:5c8f:0:b0:6fa:9c1d:91d4 with SMTP id
 6a1803df08f44-6fa9d152c62mr144693686d6.10.1748267524634; 
 Mon, 26 May 2025 06:52:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fa9e29af4fsm34130636d6.3.2025.05.26.06.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 06:52:04 -0700 (PDT)
Date: Mon, 26 May 2025 09:52:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 3/4] tests/functional: Test with
 scripts/vmstate-static-checker.py
Message-ID: <aDRyAal_jXSrsNjO@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-4-thuth@redhat.com>
 <aC820hzwtrFBV9oq@x1.local>
 <2f83dee7-6bfc-435e-8392-2236b98cbcfe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2f83dee7-6bfc-435e-8392-2236b98cbcfe@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 22, 2025 at 08:08:44PM +0200, Thomas Huth wrote:
> On 22/05/2025 16.38, Peter Xu wrote:
> > On Thu, May 22, 2025 at 03:37:55PM +0200, Thomas Huth wrote:
> > 
> > [...]
> > 
> > > +    def test_vmstate(self):
> > > +        target_machine = {
> > > +            'aarch64': 'virt-7.2',
> > > +            'm68k': 'virt-7.2',
> > > +            'ppc64': 'pseries-7.2',
> > > +            's390x': 's390-ccw-virtio-7.2',
> > > +            'x86_64': 'pc-q35-7.2',
> > > +        }
> > > +        self.set_machine(target_machine[self.arch])
> > > +
> > > +        # Run QEMU to get the current vmstate json file:
> > > +        dst_json = self.scratch_file('dest.json')
> > > +        self.log.info('Dumping vmstate from ' + self.qemu_bin)
> > > +        cp = subprocess.run([self.qemu_bin, '-nodefaults',
> > > +                             '-M', target_machine[self.arch],
> > > +                             '-dump-vmstate', dst_json],
> > > +                            stdout=subprocess.PIPE,
> > > +                            stderr=subprocess.STDOUT,
> > > +                            text=True)
> > > +        if cp.returncode != 0:
> > > +            self.fail('Running QEMU failed:\n' + cp.stdout)
> > > +        if cp.stdout:
> > > +            self.log.info('QEMU output: ' + cp.stdout)
> > > +
> > > +        # Check whether the old vmstate json file is still compatible:
> > > +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> > > +                                  self.arch,
> > > +                                  target_machine[self.arch] + '.json')
> > > +        self.log.info('Comparing vmstate with ' + src_json)
> > > +        cp = self.run_vmstate_checker(src_json, dst_json)
> > > +        if cp.returncode != 0:
> > > +            self.fail('Running vmstate-static-checker failed:\n' + cp.stdout)
> > 
> > Would false positives happen here?  Would it fail "make check" and CI, even
> > if the change was intended?
> 
> Yes. In that case, the quick fix is to remove the problematic piece from the
> 7.2 json files. Or we could try to improve the vmstate-static-checker
> script. At least we now notice it immediately, not only after a long delay
> until someone runs the script manually again.

Yes, the thing is I worry it'll almost always be false positives (from
statistical POV.. unfortunately).  Then in that case it's actually better
to be found later because otherwise it means we're adding overhead to every
developer who might cause the false positive and each of them doing this
work with no real gain.. :(

> 
> But yes, this can be confusing for the who runs into this problem for the
> first time. I guess I should at least add some friendly words here with
> instructions what has to be done?

Some instructions would be helpful for sure.  Though do we have easy way to
whitelist any false positives?  As this test compares the dumps so there's
no diff to fix or work around.

-- 
Peter Xu


