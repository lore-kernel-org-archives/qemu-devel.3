Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5121D2F326
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 15:30:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfgLW-0007TQ-Pi; Tue, 13 Jan 2026 10:30:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfgLU-0007TD-Sr
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:30:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vfgLS-0007VU-Nn
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 10:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768318207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz3VmyYWi3AhF6/Je/tiOgzVdeSqGzdCIhZvINzrSEc=;
 b=gbolqtDYSB+8VlkjrUgFIuPB37oF2iYS0E+vmTvbLLLFg5idyn0v2wdcAXUXRFOzxVwl89
 bTU7PymxIIJfuNWEpwXQ1jQG8Vl4PjftRSdKI3nvuRoIPhKGtLOLS32446acXnyox7b/QB
 wBB8S5jy721tqXwUHQF0ST9UxsJDzxE=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-dJqZLLFcMcqfJCgE4Hbsjg-1; Tue, 13 Jan 2026 10:30:06 -0500
X-MC-Unique: dJqZLLFcMcqfJCgE4Hbsjg-1
X-Mimecast-MFC-AGG-ID: dJqZLLFcMcqfJCgE4Hbsjg_1768318206
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-93f57cdeb11so9760120241.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 07:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768318206; x=1768923006; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Qz3VmyYWi3AhF6/Je/tiOgzVdeSqGzdCIhZvINzrSEc=;
 b=MGfo47HxhL/t1S+owDCcJvf/n7wCmvdL/m2JE9QcgUMzOfKjzM6sh2drZ5J0vWB8Uf
 xjtVAdWWlwAak1AU5hzyfOQI06Se0u5c79r57E8ps1SjHhVFpA7mrZAC6YmmdoieIVVK
 giOxgrFXn3mifOiAxJlyx2z/gwqJI2spCcbAHG9jae1/Leud9ERJgJgQqckzaea0ROi1
 2WHNyEvq+Io2VOOk0jbucsmhMKYOoFc5tD9foWOnkZf2iIEftrqBJPGVFc+5UyHmJuon
 sH87oBgAfpgLbZA1KFnXqfoFULWNWUxl5N5DWLjC7DNRVcOgbEJQFfSYP+tz3/IjMj7x
 Fo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768318206; x=1768923006;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qz3VmyYWi3AhF6/Je/tiOgzVdeSqGzdCIhZvINzrSEc=;
 b=vFCZNKHT9Fhg/LHWnYLw8UXeyZOc/gwrGUCYtFWy4XqppLKvIsKVnKwWw35mrnPurT
 3F0NlVYWrRAi1lqwbERJU5/j2pB+Gsc4LYnXElSMRzJJZUT8U3O8MLY7oNQDBl+t4OCT
 1zhuscoJ9GjRFtvnsLnEQO0/2AU41FnnLzKAWNOE4t7GaLUHkAQNLLf2C3s39GEyHvFm
 Se1mLoTxYR+8Um/76yCscW8N7jGEfOaTIqxJZKW5XnxGs9q3gWH3yxVfH8VgRHGrjtnh
 iQnc66lKkfzt0UEcYQlvz1ru4T9Qkr8p9H9V8YwMWc+m8TMGnl+ofQAw+M3htj/QBD80
 RJ9g==
X-Gm-Message-State: AOJu0Yx27+HIMXAZ0JSWZfRVdgXHXGcNift3Dho5+N8h9wcQPDXF3jeF
 zXrh6jd7oj0I5vzyEd6gCT5PnMuWFKTR3RmukOIiIRxtEZOHldV/i5Toe96NV6qEGi+OsRESA6r
 c9+yMDeKmbfXYuiPEEGVBYnO2YyG3npnIiUu62kIkd/oEouc0khQB43dT
X-Gm-Gg: AY/fxX5J5FRzXTfU3ezO8333p6sYJE3lpDXigTCurKdsvsCYcjWrMGaHyKhtWaDsuqI
 URCo9o2XDVgdP/fVDZZB4t6tua5a3MdUAQsMuerdUOjXZ2nY/ECPrqfuv8Ql7W34ELXknLLq3jN
 eQm8Mb1I9+wCpPWDlbynly4spzEbXSgfaESz/cPEl3Nzz0EW2Ov8i7Nq0ek3G+/97USX7Urijgt
 Ln/cweJ33eDOXj+qsqc0Nh4HKJwp6i6DV9qfDjy0qQQuSM3At+bWnU2SFofIdXc8+wsVbChmQyZ
 4E+5xytpxsDpsxaYdQDbWO0LGySahPwL4zc55DJfU6ghXqooyqlLKbbitEI/Z7BJmLWQ1My2YQd
 0mRI=
X-Received: by 2002:a05:6102:2ac3:b0:5ef:7220:bca6 with SMTP id
 ada2fe7eead31-5ef7220c52dmr5778859137.33.1768318204243; 
 Tue, 13 Jan 2026 07:30:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGb21i8wbXldhw9xlGcMduETSeDqTwoLzXJxR0H8CmAOHE8xGD0URpboYFAQJNeOmYUoC8R0A==
X-Received: by 2002:a05:6102:2ac3:b0:5ef:7220:bca6 with SMTP id
 ada2fe7eead31-5ef7220c52dmr5778814137.33.1768318202381; 
 Tue, 13 Jan 2026 07:30:02 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ecdaf1bab4sm20087598137.2.2026.01.13.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 07:30:01 -0800 (PST)
Date: Tue, 13 Jan 2026 10:29:50 -0500
From: Peter Xu <peterx@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, danpb@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>, Fabiano Rosas <farosas@suse.de>
Subject: Re: Call for GSoC internship project ideas
Message-ID: <aWZk7udMufaXPw-E@x1.local>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jan 05, 2026 at 04:47:22PM -0500, Stefan Hajnoczi wrote:
> Dear QEMU and KVM communities,
> QEMU will apply for the Google Summer of Code internship
> program again this year. Regular contributors can submit project
> ideas that they'd like to mentor by replying to this email by
> January 30th.

There's one idea from migration side that should be self-contained, please
evaluate if this suites for the application.

I copied Marco who might be interested on such project too at least from an
user perspective on fuzzing [1].

[1] https://lore.kernel.org/all/193e5a-681dfa80-3af-701c0f80@227192887/

Thanks,

=== Fast Snapshot Load ===

'''Summary:''' Fast loadvm process based on postcopy approach

We have two common ways to load snapshots: (1) QMP "snapshot-load", or QMP
"migrate_incoming" with a "file:" URI. The idea to be discussed here should
apply to either form of loadvm, however here we will focus on "file:"
migration only, because it should be the modern and suggested way of using
snapshots nowadays.

Load snapshot currently requires all VM data (RAM states and the rest
device states) to be loaded into the QEMU instance before VM starts.

It is not required, though, to load guest memory to start the VM. For
example, in a postcopy live migration process, QEMU uses userfaultfd to
allow VM run without all of the guest memory migrated. A similar technique
can also be used in a loadvm process to make loadvm very fast, starting the
VM almost immediately right after the loadvm command.

The idea is simple: we can start the VM right after loading device states
(but without loading the guest memory), then QEMU can start the VM. In the
background, the loadvm process should keep loading all the VM data in an
atomically way. Meanwhile, the vCPUs may from time to time access a missing
guest page. QEMU needs to trap these accesses with userfaultfd, and resolve
the page faults.

After loading all the RAM state, the whole loadvm procedure is completed.

This feature needs to depend on mapped-ram feature, which allows offsetting
into the snapshots to find whatever page being asked by the guest vCPUs at
any point in time.

This feature may not be very help in VM suspend / resume use cases, because
in those cases the VM was down previously, normally it's fine waiting for
the VM to be fully loaded. However, it might be useful in some other cases
(like, frequently loading snapshots).

'''Links:'''
* https://wiki.qemu.org/ToDo/LiveMigration#Fast_load_snapshot

'''Details:'''
* Skill level: advanced
* Language: C
* Mentor: Peter Xu <peterx@redhat.com>, peterx (on #qemu IRC)

-- 
Peter Xu


