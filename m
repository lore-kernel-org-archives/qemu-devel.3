Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F59FC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 14:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treF7-0001xW-4T; Mon, 10 Mar 2025 10:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1treF4-0001ws-LL
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1treF2-0001Zn-AL
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 10:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741617384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kBUVVzxflqG8IGxEo2SMLzAMjkJZtoMZMcBBqCyS9o=;
 b=TDzZIqjK3JU7pT1T93S23i1H077LINk7BRaL17cCs4aIH+gQ40qnj//bXmThoIckhYKy5M
 7qmzpfr02NoaboUJ/J6KGjFCsy465ZU/u9eFfGLd6L1B6vwq5W6EbazJWDeR7oeTo4Acuu
 tu7NloOgSwo5dJfUXjtD4MJtUPxeC08=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-28vTvQntPVmFRzOlTZTulw-1; Mon, 10 Mar 2025 10:36:23 -0400
X-MC-Unique: 28vTvQntPVmFRzOlTZTulw-1
X-Mimecast-MFC-AGG-ID: 28vTvQntPVmFRzOlTZTulw_1741617383
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c0a8583e60so866025985a.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 07:36:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741617383; x=1742222183;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9kBUVVzxflqG8IGxEo2SMLzAMjkJZtoMZMcBBqCyS9o=;
 b=RbnuXhfsedsaBVC17VTysMSxJL4d3HDp7keADvy7kjLbVyIOA04WLcfFVvBZ8nAkFF
 ZOTb4D+lcnqSbcxs8AMQkT6hXRb9I6qX6+u4jFjy1e0ah8YnqTtNyAq86keoTu5PA7YU
 /Iih/w3dEIIFM5ZORRMTwYhk2W3jtfM8vbCaPBd414vx8SfwiRrOjvajdZmMbE0BjBHB
 mu5pR/DjE6SfpSgvO80+G3kBXfNYYww/qgBL9vWMcJLRQ9vRW/ZrJwJhEUOOpJBXlLiq
 Eh1BYOTW/F+a3t4XofVMqyd3ShpnVwpMQKRO59Bd8wTUMXYQSdxo1X9Iy8hsmSg+sZsk
 Xu8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsBQxOzK7ezQFPHTqM765NAp6mJkejLXaanMO8YdYRIVqeWKcLDk8idtgzxjjbxApg43c9igkxzCmE@nongnu.org
X-Gm-Message-State: AOJu0YwdbzMy5ez5Lg4c0O4G/I6pOAZGvO/lMGTmQP8Ny/aQ2OJlJiQE
 G+elHHlx7PuTv8Eb4PIh30sLwAa70OmGmyv2CbUCqOmlo7a2P5bIowGGEs7tLfq8xeOSCfy5HGv
 KDt7d7rDHWOmkZQDP96/+pkCKR59kQtrdkuQl7kqeRkHcE9gsAquB
X-Gm-Gg: ASbGncuiBBkhVfrqXPEH/bBxS+wnRUcjA8XOwSW07fERcr6lbxevru8gY407Z82dq1J
 nxE9BxaqyrszefPgr76a33yt635P57f+4akxaoZd7o7oZ3qWvf28p7kelF88hhr/lg4L6IuHZ8Y
 Vr2INvmiNuxFavEz63QBrMfMgm0SHT/nXKszKVJtg0ZFG2X8hw+LDI00ippMtnX2Pv3hiAgBNAW
 srtKyFdp43EcJBCsJY8vNoTh9LoCUBUAUtsFgLzbYdnik+upSO2gCpdcvZwRUw12LuVyEMDIisX
 OdJxFfI=
X-Received: by 2002:a05:620a:8812:b0:7c5:4454:6b04 with SMTP id
 af79cd13be357-7c544546c50mr1279828885a.55.1741617382861; 
 Mon, 10 Mar 2025 07:36:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdziwtfB6YK7PPexQ5KWkopqTc/zkwmQ58DVbxXHGSWTllcSoAq9MVJ9kZpU04TgrdOtY+jA==
X-Received: by 2002:a05:620a:8812:b0:7c5:4454:6b04 with SMTP id
 af79cd13be357-7c544546c50mr1279825185a.55.1741617382554; 
 Mon, 10 Mar 2025 07:36:22 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c54af077a2sm276617885a.114.2025.03.10.07.36.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Mar 2025 07:36:21 -0700 (PDT)
Date: Mon, 10 Mar 2025 10:36:18 -0400
From: Peter Xu <peterx@redhat.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PULL 8/8] migration: Add qtest for migration over RDMA
Message-ID: <Z8744mFfVRP6Dq1q@x1.local>
References: <20250307181551.19887-1-farosas@suse.de>
 <20250307181551.19887-9-farosas@suse.de>
 <4ce8e8e0-3aee-41dd-b1fb-ac9398b0c1d6@linaro.org>
 <CAJSP0QVYqkPhWPYRQUbD0VbiKYsV_AGJnYU+3yaD-4AhKT5p_A@mail.gmail.com>
 <76a26937-f257-47c2-9f67-66488206bbb5@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76a26937-f257-47c2-9f67-66488206bbb5@fujitsu.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Mar 10, 2025 at 08:33:14AM +0000, Zhijian Li (Fujitsu) wrote:
> Hi Stefan,
> 
> Copied to gitlab CI,
> 
> On 08/03/2025 16:42, Stefan Hajnoczi wrote:
> > On Sat, Mar 8, 2025 at 2:01 PM Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> On 7/3/25 19:15, Fabiano Rosas wrote:
> >>> From: Li Zhijian <lizhijian@fujitsu.com>
> >>>
> >>> This qtest requires there is a RDMA(RoCE) link in the host.
> >>> In order to make the test work smoothly, introduce a
> >>> scripts/rdma-migration-helper.sh to
> >>> - setup a new Soft-RoCE(aka RXE) if it's root
> >>> - detect existing RoCE link
> >>>
> >>> Test will be skipped if there is no available RoCE link.
> >>
> >> Is it? Runing as user I'm getting:
> >>
> >>     RDMA ERROR: RDMA host is not set!
> > 
> > The CI is failing too:
> > https://gitlab.com/qemu-project/qemu/-/jobs/9350004599#L5590
> 
> Thanks for this info, unfortunately, there is no 'testlog.txt' in this gitlab-ci.

It has it.  Try look for "Job artifacts", then there're "Download" or
"Browse" for testlog.txt.  But there isn't much info.

# Start of rdma tests
# Running /aarch64/migration/precopy/rdma/plain
# Using machine type: virt-10.0
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-1127030.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1127030.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine virt-10.0,gic-version=3 -name source,debug-threads=on -m 150M  -serial file:/tmp/migration-test-R1OX22/src_serial -cpu max -kernel /tmp/migration-test-R1OX22/bootsect    -accel qtest
# starting QEMU: exec ./qemu-system-aarch64 -qtest unix:/tmp/qtest-1127030.sock -qtest-log /dev/null -chardev socket,path=/tmp/qtest-1127030.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -accel kvm -accel tcg -machine virt-10.0,gic-version=3 -name target,debug-threads=on -m 150M  -serial file:/tmp/migration-test-R1OX22/dest_serial -incoming rdma::29200  -cpu max -kernel /tmp/migration-test-R1OX22/bootsect    -accel qtest
----------------------------------- stderr -----------------------------------
qemu-system-aarch64: -incoming rdma::29200: RDMA ERROR: RDMA host is not set!
Broken pipe
../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)

> 
> I learned that x86 runner worked well
> https://gitlab.com/qemu-project/qemu/-/jobs/9350004633
> 
> So I doubt this is aarch64 specific, but I don't have an aarch64 in hand.

I think it means it'll exit 0 even without ipv4 address in the script.  I
doubt whether we used to rely on:

  command -v rdma

But maybe that's available on the reproduced hosts, so it'll pass there.
OTOH, the script should fail the script if no avail ipv4 addr found.

To be explicit, the script does this:

  has_soft_rdma "$i" || return

So even if it failed to see the soft rdma and returned, IIUC
rdma_rxe_setup_detect() will still success.

Maybe it should be this instead?

  has_soft_rdma "$i" || exit -1

We could also sanity check the ipv4 address, e.g.:

  rdma_rxe_setup_detect | grep -Eo '^[0-9]{1,3}(\.[0-9]{1,3}){3}$'

-- 
Peter Xu


