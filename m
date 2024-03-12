Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0E8C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 11:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk0CC-00086R-9p; Tue, 12 Mar 2024 07:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rk0CA-00086E-KF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1rk0C8-0008Aj-TO
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 07:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710242478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+56Z/v58ptjGyVlgscR0n+1rf2NxlRty0fJft+CwIQ=;
 b=CjzKPYVwZLpbKgW2QG2wLIsJzdSiCYplRHxDBRbNR0gGiZszuZ1qEsVZrQHCHe0ZIhPmp+
 Yefvvjox+8j5YEK03QkNXiwtz/ZD+nseortj40uY0Tzz9V6UPgIK8T5kxcWJFM4B9ArkIB
 LY+RMWZBcxa3f26OVYwtFDWYzWlQbF8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DaREVtPWOL-mLcHT9XLPsA-1; Tue, 12 Mar 2024 07:21:16 -0400
X-MC-Unique: DaREVtPWOL-mLcHT9XLPsA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-413185181f6so20777665e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 04:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710242475; x=1710847275;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=P+56Z/v58ptjGyVlgscR0n+1rf2NxlRty0fJft+CwIQ=;
 b=RGAXUGdeEdB27ermnzTzD22lQqeigdBp92hWKycR7QRHo/VjYAlfoGuTssc1fTDhzh
 5sjixaT3iq3hMNkgq5LoL45heFkYOTS2YbjX28BVhwU8TTaXD0Bcmucq0wnP2oWjl4I4
 LP1+5bIbDbkZ6nhCPSEiueYC1bC2vWOSQS5h6sTT92geSw3rhqjV4rW6JNTdCMeCzkj4
 VRB4osqCumsoParsWycGXOycUqNskyK+DwSC/lytGbOQ3NzNmWWB+RFU7vckX0weMqRu
 Ul4Sf0DMao0Vw2KBR21N7kgboIp/4nuU3VPXLKFriqk/qDVLkM+BYnAIP5uyXJw1lOOS
 VG+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4oUsgy7NlfDUL2EtHo4uHraDG444P+eD5xaDHdQZ+Gmwnx/SSvsnjJBookYRp542me4U2NPU83r6GGn69Ucit6he5V5k=
X-Gm-Message-State: AOJu0YzWfO6RJ1K4EO88cKL7lkyTLB7twpqKfvSag3WfwxSv0WYVmL02
 7sDumqCgLtpXXcHlJALR8gRGPcUXgyTxqrvUBwn3XrS4rMXXA6u23YMPeMRMiYYs/gKqLH+53ZI
 usQIHDuCh37TVmqFCjcSFFfrKZX7HTLub4O9GmTuzJTXXuM2adcDQ
X-Received: by 2002:a05:600c:4991:b0:413:194d:12c6 with SMTP id
 h17-20020a05600c499100b00413194d12c6mr6767911wmp.23.1710242475658; 
 Tue, 12 Mar 2024 04:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rTxR4XTeHF3tikwfUyycd8Y82V7CjJAGinySfGLNQkgeLxgzK4QkeY1zzSvthCmeIGW0pg==
X-Received: by 2002:a05:600c:4991:b0:413:194d:12c6 with SMTP id
 h17-20020a05600c499100b00413194d12c6mr6767895wmp.23.1710242475248; 
 Tue, 12 Mar 2024 04:21:15 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c19cc00b004126afe04f6sm18558749wmq.32.2024.03.12.04.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 04:21:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 12:21:14 +0100
Message-Id: <CZRQCYCXNTF2.1I5CNECSOB6IL@fedora>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <qemu-devel@nongnu.org>,
 <vchundur@redhat.com>
Subject: Re: [PATCH v3 3/3] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?b?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
X-Mailer: aerc/0.15.2-111-g39195000e213
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-4-aharivel@redhat.com> <ZbjDtytv-_-Bz4-S@redhat.com>
In-Reply-To: <ZbjDtytv-_-Bz4-S@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Hi Daniel, Paolo,

Here my last questions before wrapping up and send v4, or maybe call off
my attempt to add RAPL interface in QEMU.


Daniel P. Berrang=C3=A9, Jan 30, 2024 at 10:39:
> > +    rcu_register_thread();
> > +
> > +    /* Get QEMU PID*/
> > +    pid =3D getpid();
> > +
> > +    /* Nb of CPUS per packages */
> > +    maxcpus =3D vmsr_get_maxcpus(0);
> > +
> > +    /* Nb of Physical Packages on the system */
> > +    maxpkgs =3D vmsr_get_max_physical_package(maxcpus);
>
> This function can fail so this needs to be checked & reported.
>
> > +
> > +    /* Those MSR values should not change as well */
> > +    vmsr->msr_unit  =3D vmsr_read_msr(MSR_RAPL_POWER_UNIT, 0, pid,
> > +                                    s->msr_energy.socket_path);
> > +    vmsr->msr_limit =3D vmsr_read_msr(MSR_PKG_POWER_LIMIT, 0, pid,
> > +                                    s->msr_energy.socket_path);
> > +    vmsr->msr_info  =3D vmsr_read_msr(MSR_PKG_POWER_INFO, 0, pid,
> > +                                    s->msr_energy.socket_path);
>
> This function can fail for a variety of reasons, most especially if someo=
ne
> gave an incorrect socket path, or if the daemon is not running. This is n=
ot
> getting diagnosed, and even if we try to report it here, we're in a backg=
round
> thread at this point.
>
> I think we need to connect and report errors before even starting this
> thread, so that QEMU startup gets aborted upon configuration error.
>

Fair enough. Would it be ok to do the sanity check before=20
rcu_register_thread() and "return NULL;" in case of error or would you=20
prefer me to check all of this before even calling the=20
qemu_thread_create() ?=20

> > +        /* Populate all the thread stats */
> > +        for (int i =3D 0; i < num_threads; i++) {
> > +            thd_stat[i].utime =3D g_new0(unsigned long long, 2);
> > +            thd_stat[i].stime =3D g_new0(unsigned long long, 2);
> > +            thd_stat[i].thread_id =3D thread_ids[i];
> > +            vmsr_read_thread_stat(&thd_stat[i], pid, 0);
>
> It is non-obvious that the 3rd parameter here is an index into
> the utime & stime array. This function would be saner to review
> if called as:
>
>             vmsr_read_thread_stat(pid,
> 	                          thd_stat[i].thread_id,
> 	                          &thd_stat[i].utime[0],
> 	                          &thd_stat[i].stime[0],
> 	                          &thd_stat[i].cpu_id);
>
> so we see what are input parameters and what are output parameters.
>
> Also this method can fail, eg if the thread has exited already,
> so we need to take that into account and stop trying to get info
> for that thread in later code. eg by setting 'thread_id' to 0
> and then skipping any thread_id =3D=3D 0 later.
>
>

Good point. I'll rework the function and return "thread_id" to 0 in=20
case of failure in order to test it later on.=20

> > +            thd_stat[i].numa_node_id =3D numa_node_of_cpu(thd_stat[i].=
cpu_id);
> > +        }
> > +
> > +        /* Retrieve all packages power plane energy counter */
> > +        for (int i =3D 0; i <=3D maxpkgs; i++) {
> > +            for (int j =3D 0; j < num_threads; j++) {
> > +                /*
> > +                 * Use the first thread we found that ran on the CPU
> > +                 * of the package to read the packages energy counter
> > +                 */
> > +                if (thd_stat[j].numa_node_id =3D=3D i) {
>
> 'i' is a CPU ID value, while 'numa_node_id' is a NUMA node ID value.
> I don't think it is semantically valid to compare them for equality.
>
> I'm not sure the NUMA node is even relevant, since IIUC from the docs
> earlier, the power values are scoped per package, which would mean per
> CPU socket.
>

'i' here is the package number on the host.=20
I'm using functions of libnuma to populate the maxpkgs of the host.=20
I tested this on different Intel CPU with multiple packages and this=20
has always returned the good number of packages. A false positive ?

So here I'm checking if the thread has run on the package number 'i'.=20
I populate 'numa_node_id' with numa_node_of_cpu().

I did not wanted to reinvent the wheel and the only lib that was talking=20
about "node" was libnuma.

Maybe I'm wrong assuming that a "node" (defined as an area where all=20
memory has the same speed as seen from a particular CPU) could lead me=20
to the packages number ?

And this is what I see you wrote below:=20
"A numa node isn't a package AFAICT."


Regards,
Anthony


