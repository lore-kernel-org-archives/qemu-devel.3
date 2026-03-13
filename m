Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD64A107BCD9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 19:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w18Iz-0005ZW-Rb; Fri, 13 Mar 2026 15:36:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w18Ix-0005YH-IK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:36:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w18Iu-00049m-MK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 15:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773430570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3YlH0iaEreZfsWxDaIXEgHaR8sifG26Rf1QgBaAdMfg=;
 b=Z75pgTcVvNucrA9m8g2iVzQlrGX1qHRgJAhz8k0TlPyBzfQcWjZ97+SYwoYQ6H4J20UGa9
 jFN9riNGlUpwAljJkKd1AgBrewz+3u69Tv8fns6Q5Gv1quCrd5YdCwmdGyY+H8286e/Nnr
 JOjWeZ0PzkpQIT9C/flcqKtEqlKkd10=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-wrRaD_NqPK28LlsTHpKsWg-1; Fri, 13 Mar 2026 15:36:06 -0400
X-MC-Unique: wrRaD_NqPK28LlsTHpKsWg-1
X-Mimecast-MFC-AGG-ID: wrRaD_NqPK28LlsTHpKsWg_1773430565
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c739120475fso1355681a12.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773430565; x=1774035365; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3YlH0iaEreZfsWxDaIXEgHaR8sifG26Rf1QgBaAdMfg=;
 b=oVPq1L9HD4JBXh21T9ewK7l8pT4BF/sRocusdc529D78EH2SFAkmkVkhWn8RFMAsJJ
 7Ym0YrnOBn37n71xPgGj1Le6Ptknkqo8cRhplZ8VUJeHUeYYjIhgzeDsSZy3jsGP1oGH
 wQ1YTVdcoGA+ITqM7zts1geioQeQdssy2lNChb+FD87s2lHCR4QT3aYsWGiYqYGlzgz8
 FwV54mmfQbDHokU4ZEUCadD1BtoTXED1kPj7p2G0hxxsfaMH50ygB/XRK3LDRPkRhbr1
 QDI/GJ4EzBakWuqwJ4Qxh64qnChxvv/Bq5l1hirojQJIk1WB3jhE3W5EkhYloRcvYUil
 ERDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773430565; x=1774035365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3YlH0iaEreZfsWxDaIXEgHaR8sifG26Rf1QgBaAdMfg=;
 b=M80iYGj/0lZuF7PCgPqePQnx5XNtsGl1MVjU9yCMRN82Jx5KYtU+Uu9qsM/NConR/l
 9C4OuVVM2LyCWQPuXMf+QXmOv/FWLQXGdcYbNVAh1ZNzUnIo6OU3UcFfC+fbrHXOOS/J
 qqQ9PGNRmBluAgRv9scfSiTphkkpfSPgj7cDmjyH4/5qtcUVVgs/HbBYX6gOhWTVoJTE
 4LVh9RU05JW0WixC6B6q0n5VTgi/TcyVVNb51TzJ1+gbsedH6ijwmZkfRFwplRN6RWcV
 lMbQFVZF9AqARHtbLs1O8zouWVD4532FYnLu6+8BuclXcopXi60YkA2VNy1tldzAOnRO
 RwvA==
X-Gm-Message-State: AOJu0Yzz1s1l4wNw4xIa5y115AotpsPe+DqrjY/vfAQLPj3E/FRl+/1I
 nE8ZNk8U6SA//LhtqVpUJBNHiCJSVpKhXCbiHl8ZXM+t1drCeA9zdg0o2QxvkNsuSVCy4By2wqI
 7VYm9Bj6WxaH/Qvmfs/5moJz4pp4DWteaSa01xURIR5iyoXFNv4fyosTV
X-Gm-Gg: ATEYQzwFSzEBsvZTDsupIIsdwBCi37D0S6JdLegM1JMzR3RVcKKtQsC2HDOBUZA3mVY
 pEZdHAtKGR5tbDVQI8agefiM0fJ80s0Et7OgSpXiK+7JP2yY0ng3AE1tzqPdJqka46gz5b3e/au
 2iITeQqC5fm8iWRBJSCLQClypJwrWIJcx31+0dmH5BcrjxTXjNCQ8R792EU9FdN8pm+AqYMSGjm
 qQ9jkRF22KajTHCvaWu17bS2MlQM28jVW7q/o0H+69qso9wvUDOU0HiRInj5krYZQcPlHwV2DCl
 1W6SHKJXf3AzBtXTWq6hEGcFn23GhXgTaoke0jGg6rFI/koM/8ZuTVh4I5wHSCWpDb0DK150alp
 sjJWEHH2KlkE=
X-Received: by 2002:a05:6a00:3c8a:b0:829:822e:cdce with SMTP id
 d2e1a72fcca58-82a197041damr4151382b3a.6.1773430565447; 
 Fri, 13 Mar 2026 12:36:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:3c8a:b0:829:822e:cdce with SMTP id
 d2e1a72fcca58-82a197041damr4151355b3a.6.1773430564963; 
 Fri, 13 Mar 2026 12:36:04 -0700 (PDT)
Received: from fedora ([49.36.104.12]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82a072419efsm7010765b3a.11.2026.03.13.12.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 12:36:04 -0700 (PDT)
Date: Sat, 14 Mar 2026 01:05:58 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, marcandre.lureau@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [RFC 0/5] hw/tpm: CRB chunking capability to handle PQC
Message-ID: <abRnHkaXQT-o8y3d@fedora>
References: <20260312041650.181411-1-armenon@redhat.com>
 <c4ccc082-2c52-4698-9538-cbf4fffa9318@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ccc082-2c52-4698-9538-cbf4fffa9318@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Thank you for taking a look into this.

On Thu, Mar 12, 2026 at 10:36:29AM -0400, Stefan Berger wrote:
> 
> 
> On 3/12/26 12:16 AM, Arun Menon wrote:
> > The move to Post Quantum Cryptography (PQC) changes how we manage
> > memory buffers. Unlike classic crypto algorithms like RSA or ECC which
> > used small keys and signatures, PQC algorithms require larger buffers.
> > 
> > The new version of TCG TPM v185 (currently under review [1]) supports
> > sending data/commands in chunks for the CRB (Command Response Buffer)
> > interface. This is in line with the initiative to support PQC algorithms.
> > 
> > This series implements the logic to send and receive data from the
> > linux guest to the TPM backend in chunks, thereby allowing the
> > guest to send larger data buffers. We introduce 2 new control registers
> > called nextChunk and crbRspRetry that will control the START. We also
> > add the CRB Interface Identifier called CapCRBChunk that is set to 1
> > indicating that the device supports chunking. The default maximum
> > chunk/buffer size is 3968 (4096 - 128) bytes.
> > 
> > During a send operation, the guest driver places data in the CRB buffer
> > and signals nextChunk for each segment until the final chunk is reached.
> > Upon receiving the START signal, QEMU appends the final chunk to its
> > internal buffer and dispatches the complete command to the TPM backend.
> > 
> > For responses, the backend's output is buffered. The guest consumes the
> > first chunk once the START bit is cleared. Subsequent chunks are
> > retrieved by the guest toggling the nextChunk bit, which advances the
> > internal buffer offset and populates the CRB data window.
> > 
> > For this to work, the linux guest tpm driver will also have to
> > a) probe if CRB chunking is supported
> > b) send data in chunks if the command length exceeds the chunk size.
> > c) receive data in chunks by sending a nextChunk signal and accumulate.
> > > At present, VM live migration during a tpm command execution in chunks
> > is not supported. We intend to add support for TIS interface in
> 
> .. and also VM suspend/resume. Do you intend to support these? The problem
> will be state incompatibility with previous QEMU versions then since we now
> need to save the additional (bytes in the new) byte buffer(s) and possibly
> the new control registers' contents.

Yes I would like to support suspend/resume along with migration. 
And yes, I will start by saving those buffer information in the VMstate
subsection.

Also, I am working on the linux driver part. The logic is more
or less the same; 2 buffers, accumulating data, and send/receive based
on the new register bit.

> 
> Thanks for also thinking of the TIS support. I guess we will have the same
> issue there then with state incompatibilities even though with the TIS it
> should just be a matter of just using a bigger buffer. Theoretically we
> could write a 4096 byte buffer to the state if up to 4kb are held there and
> switch to a .version_id = 1 state for bigger buffer size, but then we could
> migrate to an older version of QEMU and find that it cannot do PQC
> transactions (anymore) due to older version of TIS there (I guess migration
> between major versions of QEMU is supported with all kinds of machines).
> Also, nothing will prevent one from running a PQC-enabled swtpm+libtpms with
> an older version of QEMU but one will find out if transactions don't succeed
> (assuming Linux TPM driver can handle it) because the QEMU TIS buffer is too
> small.

Yes the same issue will come with TIS. Although changing the buffer size
TPM_TIS_BUFFER_MAX to 8192 (for now) would be a one liner change, but
handling the state, for migration and other cases will be tricky like
you mentioned for both crb and tis. If I understand correctly,
We need to know whether 
    a) swtpm OR the TPM backend supports chunking
    b) does the underlying machine type of qemu suport chunking.

I am not sure if swtpm can set a capability bit if chunking is
supported. If we can do that, then QEMU can probe the backend and get
that information. But that will not be sufficient. To decide whether
chunking is actually allowed based on the underlying machine type we
might have to add a prop bool for the specific machine type.

If both of them (a and b) are true, only the linux probing will return
true for chunking. Thus linux will not send the huge buffers in the
first place, or even try to copy data in the subsections during
migration with the .needed function.

Please correct me if I am wrong.


> 
> > the future.
> > 
> > The included test demonstrates functional correctness for standard
> > buffer sizes. However, validation of PQC-sized payloads was performed
> > via manual buffer-size overrides.
> > > [1] https://trustedcomputinggroup.org/wp-content/uploads/PC-Client-Specific-Platform-TPM-Profile-for-TPM-2p0-v1p07_rc1_121225.pdf
> > 
> > Arun Menon (5):
> >    hw/tpm: Add TPM CRB chunking fields
> >    hw/tpm: Refactor CRB_CTRL_START register access
> >    hw/tpm: Add internal buffer state for chunking
> >    hw/tpm: Implement TPM CRB chunking logic
> >    test/qtest: Add test for tpm crb chunking
> > 
> >   hw/tpm/tpm_crb.c                 | 167 +++++++++++++++++++++++++++----
> >   include/hw/acpi/tpm.h            |   5 +-
> >   tests/qtest/tpm-crb-swtpm-test.c |  10 ++
> >   tests/qtest/tpm-util.c           | 106 +++++++++++++++++---
> >   tests/qtest/tpm-util.h           |   5 +
> >   5 files changed, 256 insertions(+), 37 deletions(-)
> > 
> 
> 

Regards,
Arun Menon


