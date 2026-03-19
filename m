Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24B31090233
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3E8w-0006JB-IO; Thu, 19 Mar 2026 10:14:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3E8u-0006Hk-Vp
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w3E8q-0000UC-Sc
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 10:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773929667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7X/ovv4RTbRghr2x9WwG2mKKQj9lhx2Qb45jP6hZZ5I=;
 b=X11GA80O1iolEq/g6mrJOz56N1BF3bGS7vYGpEYvSEa7fWzUzoVcI9+Pyb47qBBw8kR5cA
 PSi2Gl4Flh+1cn20CPs0IEVtsh+wPAgz36AbK52yEw7K2APXnmf0U1BIJhh8XdWMRIHKGK
 +t7tnTDbHO7/QMYjT8ZTr5WHsccxLvw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ys5VIe0SMRCzGytibgwl1g-1; Thu, 19 Mar 2026 10:14:25 -0400
X-MC-Unique: ys5VIe0SMRCzGytibgwl1g-1
X-Mimecast-MFC-AGG-ID: ys5VIe0SMRCzGytibgwl1g_1773929665
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8297d261a67so576775b3a.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 07:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773929664; x=1774534464; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7X/ovv4RTbRghr2x9WwG2mKKQj9lhx2Qb45jP6hZZ5I=;
 b=jiCj6LACYUub1FiwpATmLsWRq5dFZvFbdTLdkr6y+5ADq8Xf5mKLJzwYK55ovGG4Yx
 fTcLHLVSPde+VXN0Ln8+hlpMQPB4qxQXVMDBGLI0YdEoySIhPMehLM//vpBnJK6riUOi
 zQ6JW6+cNGuxHh0ci7R1JpWi044wnwGP1r1kNYSxyidd84KyxXH4JiZjcIyMyr73GK3H
 6XARIytwUqrYXsVHkIgTS1907Qm64ASqncJS33RDHMAM0wXqsuYcIES/1ubY9gEKRRP1
 od8ybKOJTH7Jd7BMUKv1EZzA+xZLPzXVqtRDCgZ9pjpiMsnc10k8GWDuBxZCjS1THmYu
 U4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773929664; x=1774534464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7X/ovv4RTbRghr2x9WwG2mKKQj9lhx2Qb45jP6hZZ5I=;
 b=Kh9MWwEyMhKRXSrkJQNHFUqJOIa0xq8zKE/zpfCYk5+Re+03YRqS72B+fBeQYupWyY
 c+vW+b5+buvfLBKe29JSI1ijASl9QiBYntFt1A6k7b+z8G0NBrVsN5tMkj0veqSfcbe0
 XZ9gKyG0YtbTru1aU9c+1xXMHim3lj81/E63KWRSv/rT+z+lPhfHPUvpnwziB6jjVE4S
 +EXlvdYZHG5C866dpv5QRyl4uN4kEspxqRbS2epgMhg84PIiiLTFWGJvFVFMHykci6QU
 4f7x6OjwkOLON5B2dDRsrNMHnuSIUsqLi3aDQ+Flvo2aHbZfLIlOqUJGf6j7kSWnS561
 w5qg==
X-Gm-Message-State: AOJu0Yz9aK3PF1xs96F8M9KdTCXQL/6EDkF0lCRAiGtXHS9DoFT6mXCh
 8eOk3iRpgcR/dRDpd7UitgcKPSmBgK9JhUsVnvOjQN0Gc3jlpYK1pIBQ6g5pxQT8aQBJe3+RTS6
 Cl62kwYWrNAwrkO06pDGdg9V+zy8DXKkggi65+nCNizB1nWAxW2Z//Aue
X-Gm-Gg: ATEYQzweS7uwUuO1JLiFmOdNX+zp/wpMBUyzVguwzn8VGWvPAnPNZNM8kzBMRdK6/KE
 JJe+8UYBDiwY2WQKLZK/yzABuT6GquGhwi1NGbqm3G93r32Fykp3sOj0zWlu5TL2Z4VYJIb55vH
 zDhtP891EGB1uZf6jsWzY5seHGaJwLaEuq/+/F48Ox2uv1dXGmP5eogoWMZ2nyGUU5iPrxyca0j
 Lu03UH/sTyfOLTBQvIxMHxJFkp3HWN3sPieqzvwfA11aOnRshijt37kCpmX5UXHxMMX/7F2htu6
 G2/VoHNNQQU2XAS1zdEswpfo9ij/qVjuiM3yOGLZ5KpobvVgfWoVqTFaW2hUUx/eiTLyXl5vfqx
 n3sDYhYQE1yA=
X-Received: by 2002:a05:6a00:a51a:10b0:82a:6e57:154f with SMTP id
 d2e1a72fcca58-82a6e571b4cmr4401735b3a.42.1773929664274; 
 Thu, 19 Mar 2026 07:14:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:a51a:10b0:82a:6e57:154f with SMTP id
 d2e1a72fcca58-82a6e571b4cmr4401710b3a.42.1773929663667; 
 Thu, 19 Mar 2026 07:14:23 -0700 (PDT)
Received: from fedora ([49.36.104.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a6b5308fcsm7379141b3a.9.2026.03.19.07.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 07:14:17 -0700 (PDT)
Date: Thu, 19 Mar 2026 19:44:00 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [RFC 0/5] hw/tpm: CRB chunking capability to handle PQC
Message-ID: <abwEqKWZF_z0aAeZ@fedora>
References: <20260312041650.181411-1-armenon@redhat.com>
 <c4ccc082-2c52-4698-9538-cbf4fffa9318@linux.ibm.com>
 <abRnHkaXQT-o8y3d@fedora>
 <7f46fd67-c5c0-43ab-9872-f9b83b47cdca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f46fd67-c5c0-43ab-9872-f9b83b47cdca@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Stefan,

Sorry for the late response.

On Fri, Mar 13, 2026 at 05:06:16PM -0400, Stefan Berger wrote:
> 
> 
> On 3/13/26 3:35 PM, Arun Menon wrote:
> > Hi Stefan,
> > Thank you for taking a look into this.
> > 
> > On Thu, Mar 12, 2026 at 10:36:29AM -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 3/12/26 12:16 AM, Arun Menon wrote:
> > > > The move to Post Quantum Cryptography (PQC) changes how we manage
> > > > memory buffers. Unlike classic crypto algorithms like RSA or ECC which
> > > > used small keys and signatures, PQC algorithms require larger buffers.
> > > > 
> > > > The new version of TCG TPM v185 (currently under review [1]) supports
> > > > sending data/commands in chunks for the CRB (Command Response Buffer)
> > > > interface. This is in line with the initiative to support PQC algorithms.
> > > > 
> > > > This series implements the logic to send and receive data from the
> > > > linux guest to the TPM backend in chunks, thereby allowing the
> > > > guest to send larger data buffers. We introduce 2 new control registers
> > > > called nextChunk and crbRspRetry that will control the START. We also
> > > > add the CRB Interface Identifier called CapCRBChunk that is set to 1
> > > > indicating that the device supports chunking. The default maximum
> > > > chunk/buffer size is 3968 (4096 - 128) bytes.
> > > > 
> > > > During a send operation, the guest driver places data in the CRB buffer
> > > > and signals nextChunk for each segment until the final chunk is reached.
> > > > Upon receiving the START signal, QEMU appends the final chunk to its
> > > > internal buffer and dispatches the complete command to the TPM backend.
> > > > 
> > > > For responses, the backend's output is buffered. The guest consumes the
> > > > first chunk once the START bit is cleared. Subsequent chunks are
> > > > retrieved by the guest toggling the nextChunk bit, which advances the
> > > > internal buffer offset and populates the CRB data window.
> > > > 
> > > > For this to work, the linux guest tpm driver will also have to
> > > > a) probe if CRB chunking is supported
> > > > b) send data in chunks if the command length exceeds the chunk size.
> > > > c) receive data in chunks by sending a nextChunk signal and accumulate.
> > > > > At present, VM live migration during a tpm command execution in chunks
> > > > is not supported. We intend to add support for TIS interface in
> > > 
> > > .. and also VM suspend/resume. Do you intend to support these? The problem
> > > will be state incompatibility with previous QEMU versions then since we now
> > > need to save the additional (bytes in the new) byte buffer(s) and possibly
> > > the new control registers' contents.
> > 
> > Yes I would like to support suspend/resume along with migration.
> > And yes, I will start by saving those buffer information in the VMstate
> > subsection.
> 
> If we bump up the version from state v0 to v1, can v0 capable devices still
> read the state and discard data that are for v1?
> 
> I am not sure whether the following is possible - the is maintaining
> backwards compatibility as much as possible:
> - if the CRB OS driver never touched the chunking during the transaction,
> write v0 state
> - if the CRB OS driver touched the chunking feature during the transaction,
> write v1 state
> 
> I was looking whether we can still use qemu_put_byte() etc. but was missing
> the .save interface from DeviceClass for example.

In v2 of this series, I have added support for migration. I was not able
to test it thoroughly because of the nature of the case we are aiming to
incorporate. I think backwards compatibility is maintained by adding an
entry to the hw_compat array. I am no expert, therefore I feel its best
to ask someone who understands migration well. @peterx@redhat.com ?
https://www.qemu.org/docs/master/devel/migration/compatibility.html#how-backwards-compatibility-works

If the user starts a new qemu instance with an older machine type, then
the new feature will not be enabled at all due to this flag, allowing the
user to migrate to an older qemu binary while keeping the same
machine type. The subsection will not be sent at all.

> 
> > 
> > Also, I am working on the linux driver part. The logic is more
> > or less the same; 2 buffers, accumulating data, and send/receive based
> > on the new register bit.
> > 
> > > 
> > > Thanks for also thinking of the TIS support. I guess we will have the same
> > > issue there then with state incompatibilities even though with the TIS it
> > > should just be a matter of just using a bigger buffer. Theoretically we
> > > could write a 4096 byte buffer to the state if up to 4kb are held there and
> > > switch to a .version_id = 1 state for bigger buffer size, but then we could
> > > migrate to an older version of QEMU and find that it cannot do PQC
> > > transactions (anymore) due to older version of TIS there (I guess migration
> > > between major versions of QEMU is supported with all kinds of machines).
> > > Also, nothing will prevent one from running a PQC-enabled swtpm+libtpms with
> > > an older version of QEMU but one will find out if transactions don't succeed
> > > (assuming Linux TPM driver can handle it) because the QEMU TIS buffer is too
> > > small.
> > 
> > Yes the same issue will come with TIS. Although changing the buffer size
> > TPM_TIS_BUFFER_MAX to 8192 (for now) would be a one liner change, but
> > handling the state, for migration and other cases will be tricky like
> > you mentioned for both crb and tis. If I understand correctly,
> > We need to know whether
> >      a) swtpm OR the TPM backend supports chunking
> 
> I am collecting these buffer-related issue here considering combinations of
> different versions of libtpms, swtpm, and QEMU (not considering Linux
> driver). The table is probably the best for now to see the problematic
> combinations on the lower layers:
> 
> https://github.com/stefanberger/swtpm/issues/1076

Thank you for this nice list.

> 
> >      b) does the underlying machine type of qemu suport chunking.
> > 
> > I am not sure if swtpm can set a capability bit if chunking is
> > supported. If we can do that, then QEMU can probe the backend and get
> 
> swtpm (v0.11 and via backport also v0.10.x) will simply work with a 8kb
> buffer once libtpms (v0.11) tells it that it can support up to 8 kb buffers.
> 
> > that information. But that will not be sufficient. To decide whether
> > chunking is actually allowed based on the underlying machine type we
> > might have to add a prop bool for the specific machine type.
> > 
> 
> Are you referring the CRB capability bit that advertises the chunking
> capability? I think a good sign that chunking should be supported by CRB
> (set the chunking-supported bit CapCRBChunk) is that the buffer queried for
> from swtpm indicates > 4kb (s->be_buffer_size =
> tpm_backend_get_buffer_size(s->tpmbe) ). If the buffer size is still 4kb it
> probably should not advertise the chunking capability -- hadn't thought of
> this while reviewing the patches, but ... you may want to add this in the
> code.
>
At the moment the new qemu binary simply sets the capability to be
true by default. I missed this in v2; I shall add it to tpm_crb_reset()
or tpm_crb_realize() when i post non RFC version.

> > If both of them (a and b) are true, only the linux probing will return
> > true for chunking. Thus linux will not send the huge buffers in the
> > first place, or even try to copy data in the subsections during
> > migration with the .needed function.
> > 
> > Please correct me if I am wrong.
> 
> I am not sure about all the details yet, either.
> 
> > 
> > 
> > > 
> > > > the future.
> > > > 
> > > > The included test demonstrates functional correctness for standard
> > > > buffer sizes. However, validation of PQC-sized payloads was performed
> > > > via manual buffer-size overrides.
> > > > > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > > > 
> > > > Arun Menon (5):
> > > >     hw/tpm: Add TPM CRB chunking fields
> > > >     hw/tpm: Refactor CRB_CTRL_START register access
> > > >     hw/tpm: Add internal buffer state for chunking
> > > >     hw/tpm: Implement TPM CRB chunking logic
> > > >     test/qtest: Add test for tpm crb chunking
> > > > 
> > > >    hw/tpm/tpm_crb.c                 | 167 +++++++++++++++++++++++++++----
> > > >    include/hw/acpi/tpm.h            |   5 +-
> > > >    tests/qtest/tpm-crb-swtpm-test.c |  10 ++
> > > >    tests/qtest/tpm-util.c           | 106 +++++++++++++++++---
> > > >    tests/qtest/tpm-util.h           |   5 +
> > > >    5 files changed, 256 insertions(+), 37 deletions(-)
> > > > 
> > > 
> > > 
> > 
> > Regards,
> > Arun Menon
> > 
> 
> 

Regards,
Arun Menon


