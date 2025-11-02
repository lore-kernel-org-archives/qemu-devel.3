Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3E3CCFA02
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Nov 2025 16:18:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFals-00042j-10; Sun, 02 Nov 2025 11:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vFalp-00042V-I6
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 11:17:34 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yvyas1991@gmail.com>)
 id 1vFaln-00059F-3g
 for qemu-devel@nongnu.org; Sun, 02 Nov 2025 11:17:33 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-33bb66c96a1so1139064a91.1
 for <qemu-devel@nongnu.org>; Sun, 02 Nov 2025 08:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762100248; x=1762705048; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NhmVVl4c6vVMPGZOdEwoC5c72Kb6gzTmKumGKhlmOew=;
 b=Y7o+ouF3PSJFKcRCwV+TAm6FH5722p4o++ZNWznynXzXQhk+WQIzBolyOLooOG2DjX
 1BERvCwjDcpo3VIlNdoOYWgcn3T+G98pNSBxt5iAAdqThQZrHUhTk0HN16U9nibrtt4l
 aYuvbU6a+kD1umiyO6FNkUWlMHO6nNGsFc98YwJ7jfAMkUY4jCizxLtDtWi2+0kLZi1g
 /xH6CSm7WOZAXMvNKbKCTXW2XnQT/jmt2uvBDEJPQswfUYyRqaruDE1Snph9YD3rPLuQ
 TUxcZqqkezcOF8gpaNDF7N5O9+ligzXQ+Xh5sVjZlLEd4fBST2OGJ98ZAmE6itdzo5EJ
 w6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762100248; x=1762705048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhmVVl4c6vVMPGZOdEwoC5c72Kb6gzTmKumGKhlmOew=;
 b=Zr0/rDs794U4J0JlWxcuYfiFFhPjuwTmUjziESaiAPCuoWk/uO8taG9pea1LsCkBwa
 VKaCM+Q9UQVsM8n6R2er1JpsUcjrIi/o+9HI5RoYVRPAVc5DK4wuX6MS6gWtNWcv989Q
 LiUIJWX2psnNV8U2FJN0ja1fefsABpRGERpikFFSECucxzBNBdXkEc+GhDGLmlnaP47d
 tG6hatVKzoNEiciBsoFgxlNDuzlWZFO46ElS7vamjMbLSLnrT+5aTv1DYAsbpGXRZXJr
 tvsOHL+EfQhLug8veUDU4cRJzQPr2ErGhqd9XaOK0itjmylYlP8RmHVAJxi7wZArHUuV
 SdwA==
X-Gm-Message-State: AOJu0YwnRjWxToz7yaIG1jAZXi2OwMQBnIA4dInLaWOrYWkFoTwIpWD2
 AT+VJoXo2gSO35AdKQD2rlZMwgSS4bdOTWFNR1SobgS5JkXzMfpTYKKD
X-Gm-Gg: ASbGncsxnqwguLb07DOVpSsWHMaO80VM9iXEnj31G13Fl9FbV0dEgYle0IpOr6zFXdM
 o9AI9wZ34inQk1hF28S+sTHtsZ9mk9qGGARUHRXJEIGzeeuFZbxmhb23J0h1BM90xYpdLz2jiwX
 gs3PJlgcpWSJu6EEA/De3N+R2stdC/Ms8e+NetbRR+cLAqEgHSDmoVWwyQ3xDMLNTAn2OiP0y31
 +4+L+I5/JXt+bUl7Ty7mVnLgjgrtJlcKn9m9ETeDof4M9AmtJoC9yDybydDNQm7MpUw/mzVgNQ3
 xZlp50TH57J4NAB+SwbfPHH9e4Eco4JESPk2/f7J/uoH5qDxEEnS99QTe2reqHFCtusHPQh9I9I
 s6r6rlgZ3QAed4FZJ3l4PbvX39uoasktjANJkPN+HsfE2d04j00vQ+ek7OJkGaYleNuMCRvWbR6
 UD6D5sIARw2zNHR5kOs/A/HZmlDoZ45PQnomaSUY/qyHXJ8Uuujnq9iehj
X-Google-Smtp-Source: AGHT+IFr4DgyHSINIPb1JGgr8jhHvi8OrjnfqDXaYFAfZV721IBQV22zpZW2E/Qz3DJuMtyRHYRj8Q==
X-Received: by 2002:a17:902:f393:b0:295:54cd:d2e2 with SMTP id
 d9443c01a7336-29554cdd55fmr27337435ad.0.1762100248289; 
 Sun, 02 Nov 2025 08:17:28 -0800 (PST)
Received: from ?IPV6:2402:e280:2177:35:a77f:15f7:4845:1af9?
 ([2402:e280:2177:35:a77f:15f7:4845:1af9])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29554cba950sm59474555ad.97.2025.11.02.08.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Nov 2025 08:17:28 -0800 (PST)
Message-ID: <5250e103-4dd1-44e4-9dcf-7c2df033ae10@gmail.com>
Date: Sun, 2 Nov 2025 21:47:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] Pegasos2 clean up and pegasos1 emulation
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1760798392.git.balaton@eik.bme.hu>
 <CAJOT6qN-n7LpVnLO-5CpOUF8z-j1Ogi=6cJBvvKZc-Eh5tHVzA@mail.gmail.com>
 <a410ac54-d1dc-aa67-d1d7-690b2495e9df@eik.bme.hu>
 <CAJOT6qN4QYRdNR-oQV8JSv_074umiHB==_dyemX01+FsNiqPOQ@mail.gmail.com>
 <c7daf4e7-50d3-263c-4fa2-35947e2d3267@eik.bme.hu>
 <26f74e6c-a89f-4be0-aa6c-78ad88e2cba3@gmail.com>
 <993819c9-cf87-ec91-31ac-f8988c8d3d67@eik.bme.hu>
 <38673ed9-4690-472b-9e0f-c8a736247097@gmail.com>
 <fd804cb4-d987-5e3d-24e8-0a4fb88e092e@eik.bme.hu>
Content-Language: en-US
From: Yogesh Vyas <yvyas1991@gmail.com>
In-Reply-To: <fd804cb4-d987-5e3d-24e8-0a4fb88e092e@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yvyas1991@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 10/28/25 1:48 AM, BALATON Zoltan wrote:
> Trying to read invalid spr 1012 (0x3f4) at 00000000c0013f48
> [    0.000000] Using CHRP machine description
> [    0.000000] Total memory = 512MB; using 1024kB for hash table (at 
> cff00000)
> [    0.000000] Initializing cgroup subsys cpuset
> [    0.000000] Initializing cgroup subsys cpu
> [    0.000000] Initializing cgroup subsys cpuacct
> [    0.000000] Linux version 3.16.0-6-powerpc (debian- 
> kernel@lists.debian.org) (gcc version 4.8.4 (Debian 4.8.4-1) ) #1 Debian 
> 3.16.56-1+deb8u1 (2018-05-08)
> [    0.000000] Found initrd at 0xc15a2000:0xc1b0b90d
> [    0.000000] chrp type = 6 [Genesi Pegasos]
> 
> Are you using this same vmlinuz-chrp.initrd?
> 
> $ md5sum vmlinuz-chrp.initrd
> a440d76c1d2ccfa86bdff6dba017cf39  vmlinuz-chrp.initrd

Yes, md5sum is same as you mentioned:
yogi@fedora:~/work/images$ md5sum vmlinuz-chrp.initrd
a440d76c1d2ccfa86bdff6dba017cf39  vmlinuz-chrp.initrd

Could you please share your Qemu configure command line?
I can try one more time if that's different than mine.
I used below configure command line:
'../configure' '--target-list=ppc64-softmmu,ppc-softmmu' '--enable-virtfs'

Regards,
Yogesh Vyas

> 
> If so then probably there's something with your QEMU installation.


