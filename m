Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 159F0D1AD54
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 12:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t13a4-0001tb-PV; Wed, 16 Oct 2024 08:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t13a3-0001tL-TX
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 08:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1t13a1-0007Ok-Dx
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 08:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729083403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lc/CL0J4ZYnE5bWUtvOJEwOjLlwUVQqqv/a33QCLhEI=;
 b=XrpntUrPxiyowmyE+X9Z64y/5UV5MqhB6AZJ8dUWYaWUzYRmfk2KvtDxM9VMwIuJgDJVlm
 24uyzwwy4elRg+s6kI3rqImiK+A0neL0FQNx0TxfhuCof6ouIVtdWABqlQVYFflUEPDJrj
 kOSFL8idsGNqB56Gn4AEkUMbDYgIH0A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-NT6OwS1uOyCqlzUCqDJocA-1; Wed, 16 Oct 2024 08:56:42 -0400
X-MC-Unique: NT6OwS1uOyCqlzUCqDJocA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4314f1e0f2bso5925145e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 05:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729083401; x=1729688201;
 h=in-reply-to:references:user-agent:subject:cc:to:from:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lc/CL0J4ZYnE5bWUtvOJEwOjLlwUVQqqv/a33QCLhEI=;
 b=JDHHIzbLXqsffRkdVE6m3TZxPloNSLEq4bfuKEqS/5RREBp2T4P+K7pms3upiLYpxQ
 8XBU5W0zU/W+m79pIH84V4vo502KCTyml4boQgRtvnlRddRPnORIK5MB8RcwqlOVqZev
 g+Nz7lxXDp4yBPBrgd9nMp1JtOUZfhQcUEbcfDjeTNBsxbWpWPPz0j/T4A2YnZ0KWAdd
 Y7ncCal7cnz2MtbiCSSTEpnjzPqIy9+jgzSwlSaq06bVaZkY+3Cb32OtP4RmntkdDRTP
 7mMLYFHnv7eonXAZyZtLzICDT9L6WxyTWUz6PbgE/ZhslpliMCDoU7B7CrbSFNNM071J
 32mQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBrWK3JaYCsajEJf8mAdVTO1iZ4UliiaDgLpqWm/YxRWTwetKrtv74GD3WJgkCfo0g9IIxcLM2iEMo@nongnu.org
X-Gm-Message-State: AOJu0YwwkRpnfTJfIyoach5JJBiEYIFbFqOvfgyVQutnQckTERSLiypu
 bEIR5JquYcMwieRaZXwBVmMU39md2VBUps6dP1baa/FaJP8KPsunAMbANSOHpykGTVO/GVZCaCF
 orLxygnkoU93jbOeLrJ3ZyAz1w1OcvfbsvlIs8fhTRzhS1JSnuhnE
X-Received: by 2002:a05:600c:3551:b0:42f:7717:ac04 with SMTP id
 5b1f17b1804b1-431255e2ca4mr141002535e9.16.1729083400580; 
 Wed, 16 Oct 2024 05:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLLGz5j1AXkPtVVCPbtxHFa8HMBm8TBMbfDttjX/Nd40wDLFwXq503M/e9qYLG2JsUQVZEIw==
X-Received: by 2002:a05:600c:3551:b0:42f:7717:ac04 with SMTP id
 5b1f17b1804b1-431255e2ca4mr141002275e9.16.1729083400033; 
 Wed, 16 Oct 2024 05:56:40 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:2827:8723:3c60:c84a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56ea10sm50081135e9.24.2024.10.16.05.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Oct 2024 05:56:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Oct 2024 14:56:39 +0200
Message-Id: <D4X8WRR5F2GP.2MCBI9HDM3UHM@redhat.com>
From: "Anthony Harivel" <aharivel@redhat.com>
To: "Igor Mammedov" <imammedo@redhat.com>
Cc: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <berrange@redhat.com>,
 <qemu-devel@nongnu.org>, <vchundur@redhat.com>, <rjarry@redhat.com>
Subject: Re: [PATCH v6 0/3] Add support for the RAPL MSRs series
User-Agent: aerc/0.18.2-69-g1c54bb3a9d11
References: <20240522153453.1230389-1-aharivel@redhat.com>
 <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241016135259.49021bca@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.038,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Igor,

Igor Mammedov, Oct 16, 2024 at 13:52:
> On Wed, 22 May 2024 17:34:49 +0200
> Anthony Harivel <aharivel@redhat.com> wrote:
>
>> Dear maintainers,=20
>>=20
>> First of all, thank you very much for your review of my patch=20
>> [1].
>
> I've tried to play with this feature and have a few questions about it
>

Thanks for testing this new feature.=20

>  1. trying to start with non accessible or not existent socket
>         -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/socket=20
>     I get:
>       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/=
socks: vmsr socket opening failed
>       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/=
socks: kvm : error RAPL feature requirement not met
>     * is it possible to report actual OS error that happened during open/=
connect,
>       instead of unhelpful 'socket opening failed'?
>
>       What I see in vmsr_open_socket() error is ignored
>       and btw it's error leak as well
>

Shame you missed the 6 iterations of that patch that last for a year.=20
I would have changed that directly !
Anyway I take note on that comment and will send a modification.

>     * 2nd line shouldn't be there if the 1st error already present.
>
>  2.  getting periodic error on console where QEMU has been starter
>       # ./qemu-vmsr-helper -k /tmp/sock
>      ./qemu-system-x86_64 -snapshot -m 4G -accel kvm,rapl=3Don,rapl-helpe=
r-socket=3D/tmp/sock rhel90.img  -vnc :0 -cpu host
>      and let it run
>
>       it appears rdmsr works (well, it returns some values at least)
>       however there are recurring errors in qemu's stderr(or out)
>      =20
>       qemu-system-x86_64: Error opening /proc/2496093/task/2496109/stat
>       qemu-system-x86_64: Error opening /proc/2496093/task/2496095/stat
>
>       My guess it's some temporary threads, that come and go, but still
>       they shouldn't cause errors if it's normal operation.
>

There a patch in WIP that change this into a Tracepoint. Maybe you can=20
SSH to the VM in meanwhile ?

>       Also on daemon side, I a few times got while guest was running:
>         qemu-vmsr-helper: Failed to open /proc at /proc/2496026/task/2496=
044
>         qemu-vmsr-helper: Requested TID not in peer PID: 2496026 2496044
>       though I can't reproduce it reliably

This could happen only when a vCPU thread ID has changed between the=20
call of a rdmsr throught the socket and the hepler that read the msr.
No idea how a vCPU can change TID or shutdown that fast.

>
>  3. when starting daemon not as root, it starts 'fine' but later on compl=
ains
>       qemu-vmsr-helper: Failed to open MSR file at /dev/cpu/0/msr
>     perhaps it would be better to fail at start daemon if it doesn't have
>     access to necessary files.
>

Right taking a note on that as well.


>  4. in case #3, guest also fails to start with errors:
>       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/=
sock: can't read any virtual msr
>       qemu-system-x86_64: -accel kvm,rapl=3Don,rapl-helper-socket=3D/tmp/=
sock: kvm : error RAPL feature requirement not met
>      again line #2 is not useful and probably not needed (maybe make it t=
racepoint)
>      and #1 is unhelpful - it would be better if it directed user to chec=
k qemu-vmsr-helper
>

I will try to see how to improve that part.=20
Thanks for your valuable feedback.

>  5. does AMD have similar MSRs that we could use to make this feature com=
plete?
>

Yes but the address are completely different. However, this in my ToDo=20
list. First I need way more feedback like yours to move on extending=20
this feature.

>  6. What happens to power accounting if host constantly migrates
>     vcpus between sockets, are values we are getting still correct/meanin=
gful?
>     Or do we need to pin vcpus to get 'accurate' values?
>

It's taken into account during the ratio calculation which socket the=20
vCPU has just been scheduled. But yes the value are more 'accurate' when=20
the vCPU is pinned.

>  7. do we have to have a dedicated thread for pooling data from daemon?
>
>     Can we fetch data from vcpu thread that have accessed msr
>     (with some caching and rate limiting access to the daemon)?
>

This feature is revolving around a thread. Please look at the=20
documentation is not already done:

https://www.qemu.org/docs/master/specs/rapl-msr.html#high-level-implementat=
ion

If we only fetch from vCPU thread, we won't have the consumption of the=20
non-vcpu thread. They are taken into account in the total.



Thanks again for your feedback.=20

Anthony


>> In this version (v6), I have attempted to address all the problems=20
>> addressed by Daniel and Paolo during the last review.=20
>>=20
>> However, two open questions remains unanswered that would require the=20
>> attention of a x86 maintainers:=20
>>=20
>> 1)Should I move from -kvm to -cpu the rapl feature ? [2]
>>=20
>> 2)Should I already rename to "rapl_vmsr_*" in order to anticipate the=20
>>   futur TMPI architecture ? [end of 3]=20
>>=20
>> Thank you again for your continued guidance.=20
>>=20
>> v5 -> v6
>> --------
>> - Better error consistency in qio_channel_get_peerpid()
>> - Memory leak g_strdup_printf/g_build_filename corrected
>> - Renaming several struct with "vmsr_*" for better namespace
>> - Renamed several struct with "guest_*" for better comprehension
>> - Optimization suggerate from Daniel
>> - Crash problem solved [4]
>>=20
>> v4 -> v5
>> --------
>>=20
>> - correct qio_channel_get_peerpid: return pid =3D -1 in case of error
>> - Vmsr_helper: compile only for x86
>> - Vmsr_helper: use qio_channel_read/write_all
>> - Vmsr_helper: abandon user/group
>> - Vmsr_energy.c: correct all error_report
>> - Vmsr thread: compute default socket path only once
>> - Vmsr thread: open socket only once
>> - Pass relevant QEMU CI
>>=20
>> v3 -> v4
>> --------
>>=20
>> - Correct memory leaks with AddressSanitizer =20
>> - Add sanity check for QEMU and qemu-vmsr-helper for checking if host is=
=20
>>   INTEL and if RAPL is activated.
>> - Rename poor variables naming for easier comprehension
>> - Move code that checks Host before creating the VMSR thread
>> - Get rid of libnuma: create function that read sysfs for reading the=20
>>   Host topology instead
>>=20
>> v2 -> v3
>> --------
>>=20
>> - Move all memory allocations from Clib to Glib
>> - Compile on *BSD (working on Linux only)
>> - No more limitation on the virtual package: each vCPU that belongs to=
=20
>>   the same virtual package is giving the same results like expected on=
=20
>>   a real CPU.
>>   This has been tested topology like:
>>      -smp 4,sockets=3D2
>>      -smp 16,sockets=3D4,cores=3D2,threads=3D2
>>=20
>> v1 -> v2
>> --------
>>=20
>> - To overcome the CVE-2020-8694 a socket communication is created
>>   to a priviliged helper
>> - Add the priviliged helper (qemu-vmsr-helper)
>> - Add SO_PEERCRED in qio channel socket
>>=20
>> RFC -> v1
>> ---------
>>=20
>> - Add vmsr_* in front of all vmsr specific function
>> - Change malloc()/calloc()... with all glib equivalent
>> - Pre-allocate all dynamic memories when possible
>> - Add a Documentation of implementation, limitation and usage
>>=20
>> Best regards,
>> Anthony
>>=20
>> [1]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg01570.html
>> [2]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03947.html
>> [3]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02350.html
>> [4]: https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg02481.html
>>=20
>> Anthony Harivel (3):
>>   qio: add support for SO_PEERCRED for socket channel
>>   tools: build qemu-vmsr-helper
>>   Add support for RAPL MSRs in KVM/Qemu
>>=20
>>  accel/kvm/kvm-all.c                      |  27 ++
>>  contrib/systemd/qemu-vmsr-helper.service |  15 +
>>  contrib/systemd/qemu-vmsr-helper.socket  |   9 +
>>  docs/specs/index.rst                     |   1 +
>>  docs/specs/rapl-msr.rst                  | 155 +++++++
>>  docs/tools/index.rst                     |   1 +
>>  docs/tools/qemu-vmsr-helper.rst          |  89 ++++
>>  include/io/channel.h                     |  21 +
>>  include/sysemu/kvm_int.h                 |  32 ++
>>  io/channel-socket.c                      |  28 ++
>>  io/channel.c                             |  13 +
>>  meson.build                              |   7 +
>>  target/i386/cpu.h                        |   8 +
>>  target/i386/kvm/kvm.c                    | 431 +++++++++++++++++-
>>  target/i386/kvm/meson.build              |   1 +
>>  target/i386/kvm/vmsr_energy.c            | 337 ++++++++++++++
>>  target/i386/kvm/vmsr_energy.h            |  99 +++++
>>  tools/i386/qemu-vmsr-helper.c            | 530 +++++++++++++++++++++++
>>  tools/i386/rapl-msr-index.h              |  28 ++
>>  19 files changed, 1831 insertions(+), 1 deletion(-)
>>  create mode 100644 contrib/systemd/qemu-vmsr-helper.service
>>  create mode 100644 contrib/systemd/qemu-vmsr-helper.socket
>>  create mode 100644 docs/specs/rapl-msr.rst
>>  create mode 100644 docs/tools/qemu-vmsr-helper.rst
>>  create mode 100644 target/i386/kvm/vmsr_energy.c
>>  create mode 100644 target/i386/kvm/vmsr_energy.h
>>  create mode 100644 tools/i386/qemu-vmsr-helper.c
>>  create mode 100644 tools/i386/rapl-msr-index.h
>>=20


