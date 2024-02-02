Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF84EC47258
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 08:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVowb-0005S2-HZ; Fri, 02 Feb 2024 03:30:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rVowZ-0005Rm-AS
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:30:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcasquer@redhat.com>)
 id 1rVowX-0003ZJ-B3
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 03:30:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706862634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nc+fHgu4ExcPiZpmYM/u8j5r8o2X7Fes0z77jxmi1+8=;
 b=WUU6XxncLZj4ylv1QJmWmjCT6jDSVYlogaJvfIxkFJ0nQ13IgBDGJrdz3Fn+/wKAPkqUKD
 /AW2puVBCZ51fjxpIDRFDEcosCW3rukpRxWDgAFni70bhd9R0xhuPyOJlv5Ycab102GvoG
 1giOBm30TVC+7RY/jk6xN0HKF3fgw20=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-ZY4jP57ePjmfOWdBBvzPig-1; Fri, 02 Feb 2024 03:30:33 -0500
X-MC-Unique: ZY4jP57ePjmfOWdBBvzPig-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d088368024so2699581fa.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 00:30:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706862631; x=1707467431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nc+fHgu4ExcPiZpmYM/u8j5r8o2X7Fes0z77jxmi1+8=;
 b=hp3qOWFjMD/Y4+o3D0+pMFRyUFwY7WU4d8nLcSI4RK8gENHsztO495JSX4hPXWn6jB
 tiAM0knVr9Fr+cay/x3ZTeW1KG9/a+CusK92Xcu2BgBuKqm54iYe5u7MlL2ItUYXnKvZ
 Rto9Gov7ML5QXQcOodqeaUL6QLTbgZ1jN6OUNjT2ZCjgFtNaVUkDPOwFzMb/s/gyQdV7
 /bt6UvybrA+JkbkQ/NLA6EmJg4PI11LDS93NPLZAXlp+bZ63nu8jMycwVLda/VreCkam
 ijqYLtdPLJCxBbEVNqkzI1xzP5yerl+VeslVvn9LPYudOJ0voqDpgiIs6xFhoC/CmLDb
 rl6A==
X-Gm-Message-State: AOJu0Yx+X0Q6KnpmWZvKWDtAul71V4zNgHKluI5X96pPa2K/mjIzOvG2
 jNjEMNOUBTO0eKX53/K4ecVNhIkwW1nr+sTRAu57xF/DAmS1UgYg775aVxq7sDzzh1ugGgUBzrf
 vjbBJY4uHyQCp8HsxieAS2vDG+lAS4v/lhhwKyIdUWM8d1EwRDD2ckogdiW7ARewCIzQk2467JR
 mypQSFBlsaOkYcIvPUIbTNfOhj5MU=
X-Received: by 2002:a2e:9d41:0:b0:2cd:5cfd:b19 with SMTP id
 y1-20020a2e9d41000000b002cd5cfd0b19mr4880345ljj.19.1706862631743; 
 Fri, 02 Feb 2024 00:30:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCT7PY6A3HbZv6skkD+OyfG4ffsd2fTDE/lvxkZY906TpNxoEYlX7wqvqGJrEHYhgPrkvfW9UTZw9rZgFmS98=
X-Received: by 2002:a2e:9d41:0:b0:2cd:5cfd:b19 with SMTP id
 y1-20020a2e9d41000000b002cd5cfd0b19mr4880331ljj.19.1706862631409; Fri, 02 Feb
 2024 00:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20240131165327.3154970-1-mark.kanda@oracle.com>
 <20240131165327.3154970-2-mark.kanda@oracle.com>
 <243002e8-7647-4638-98a4-520edf52802a@redhat.com>
In-Reply-To: <243002e8-7647-4638-98a4-520edf52802a@redhat.com>
From: Mario Casquero <mcasquer@redhat.com>
Date: Fri, 2 Feb 2024 09:30:20 +0100
Message-ID: <CAMXpfWtwkzJ3AO+L4F7XAirv8NJX_YPXk9bV9wp7SrEAvUEmqw@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] oslib-posix: initialize backend memory objects in
 parallel
To: David Hildenbrand <david@redhat.com>
Cc: Mark Kanda <mark.kanda@oracle.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mcasquer@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This patch has been successfully tested by QE. After configuring two
memory-backends with preallocation context objects, binded to two host
nodes; the result is QEMU being at least three times faster than
before.

# time /usr/libexec/qemu-kvm -M q35 -m 16G,maxmem=3D32G -numa
node,memdev=3Dmem0,nodeid=3D0 -numa node,memdev=3Dmem1,nodeid=3D1 -object
thread-context,id=3Dtc1,node-affinity=3D0 -object
thread-context,id=3Dtc2,node-affinity=3D1 -object
memory-backend-ram,id=3Dmem0,size=3D8G,policy=3Dbind,host-nodes=3D0 -object
memory-backend-ram,id=3Dmem1,size=3D8G,policy=3Dbind,host-nodes=3D1 -nograp=
hic
-monitor stdio
QEMU 8.2.0 monitor - type 'help' for more information
qemu-kvm: cannot use stdio by multiple character devices
qemu-kvm: could not connect serial device to character backend 'stdio'

real 0m0.038s
user 0m0.013s
sys 0m0.005s

# time /home/qemu/build/qemu-system-x86_64 -M q35 -m 16G,maxmem=3D32G
-numa node,memdev=3Dmem0,nodeid=3D0 -numa node,memdev=3Dmem1,nodeid=3D1
-object thread-context,id=3Dtc1,node-affinity=3D0 -object
thread-context,id=3Dtc2,node-affinity=3D1 -object
memory-backend-ram,id=3Dmem0,size=3D8G,policy=3Dbind,host-nodes=3D0 -object
memory-backend-ram,id=3Dmem1,size=3D8G,policy=3Dbind,host-nodes=3D1 -nograp=
hic
-monitor stdio
QEMU 8.2.50 monitor - type 'help' for more information
qemu-system-x86_64: cannot use stdio by multiple character devices
qemu-system-x86_64: could not connect serial device to character backend 's=
tdio'

real 0m0.012s
user 0m0.006s
sys 0m0.007s

Tested-by: Mario Casquero <mcasquer@redhat.com>


On Wed, Jan 31, 2024 at 7:24=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 31.01.24 17:53, Mark Kanda wrote:
> > QEMU initializes preallocated backend memory as the objects are parsed =
from
> > the command line. This is not optimal in some cases (e.g. memory spanni=
ng
> > multiple NUMA nodes) because the memory objects are initialized in seri=
es.
> >
> > Allow the initialization to occur in parallel (asynchronously). In orde=
r to
> > ensure optimal thread placement, asynchronous initialization requires p=
realloc
> > context threads to be in use.
> >
> > Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
> > Signed-off-by: David Hildenbrand <david@redhat.com>
> > ---
>
> So, this LGTM. There might be ways to not rely on phases to achieve what
> we want to achieve (e.g., let the machine set an internal property on
> memory backends we create from the cmdline), but this should do as well.
>
> I'll wait a bit for more feedback. If there is none, I'll route this
> through my tree (after doing a quick sanity test).
>
> Thanks!
>
> --
> Cheers,
>
> David / dhildenb
>
>


