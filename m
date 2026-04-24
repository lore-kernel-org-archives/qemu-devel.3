Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C016AFB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 07:48:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBG6-0004gu-Fk; Fri, 24 Apr 2026 03:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wGBG3-0004eE-HY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wGBFz-0007Tk-7G
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 03:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777016840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SOwLaWDCVs+3j+gIDuUzrmI6kxLJLvKN/XYmc8SlN44=;
 b=RYz/EyPYY4K/J2FOwVTV+rrkposLMG91Sy6qZvI0wJ/l9l93GnPpjhHbUkE/kFMukp0NZV
 ubk2tgOBkouNZK1AnU1gpQRlwpTnf+1sS3lhfALyU1RtH612NvQak4NVmMN64OnChNOrJs
 J1OMGjcFGNjwfzPx39ooMlsUPMqe+v8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-oClGuDUNNhCNF4Aj8vRDgg-1; Fri,
 24 Apr 2026 03:47:12 -0400
X-MC-Unique: oClGuDUNNhCNF4Aj8vRDgg-1
X-Mimecast-MFC-AGG-ID: oClGuDUNNhCNF4Aj8vRDgg_1777016831
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29671180036E; Fri, 24 Apr 2026 07:47:11 +0000 (UTC)
Received: from localhost (unknown [10.44.33.91])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2995F3007572; Fri, 24 Apr 2026 07:47:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, Stefan Hajnoczi
 <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Subject: Re: [PULL 00/11] 11.1 compat machines and s390x updates
In-Reply-To: <9ff8cb74-8abc-4c9a-8f25-044cd4b9d921@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260423094856.270215-1-cohuck@redhat.com>
 <CAJSP0QWFK9noq+CRRG4E1DM4HSyaHxHqmZytqzUHnu-_VsRjUA@mail.gmail.com>
 <9ff8cb74-8abc-4c9a-8f25-044cd4b9d921@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 24 Apr 2026 09:47:07 +0200
Message-ID: <87se8kssuc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23 2026, Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 4/23/26 7:20 PM, Stefan Hajnoczi wrote:
>> On Thu, Apr 23, 2026 at 5:50=E2=80=AFAM Cornelia Huck <cohuck@redhat.com=
> wrote:
>>=20
>>> The following changes since commit
>>> 98b060da3a4f92b2a994ead5b16a87e783baf77c:
>>>
>>>   Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>>   https://gitlab.com/cohuck/qemu tags/s390x-20260423
>>>
>>> for you to fetch changes up to 83f5164d25634f9104b5fb4a6772766ae646ad59:
>>>
>>>   hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+) (2026-04-=
22
>>> 11:28:03 +0200)
>>>
>>> ----------------------------------------------------------------
>>> First batch of updates for 11.1:
>>> - compat machines for 11.1
>>> - s390x: simplifications, cleanups, and a new test
>>>
>>=20
>> Hi Cornelia,
>> There is an s390x timeout regression in this pull request that reproduces
>> both in the CI and locally:
>>=20
>> $ make check-functional-s390x
>> 13/13 qemu:func-thorough+func-s390x-thorough+thorough /
>> func-s390x-ccw_virtio         TIMEOUT        420.07s   killed by signal =
15
>> SIGTERM
>
>
> Hi Connie, it looks to me like the failure is due to disabling legacy
> virtio-pci by default for s390x starting with 11.1.

Duh, I thought I did run all tests, but apparently not.

>
> I was able to get the test to pass again with the diff below.  But
> wasn't sure, do we only care about the default/latest machine version
> for functional tests?=20
>
> diff --git a/tests/functional/s390x/test_ccw_virtio.py b/tests/functional=
/s390x/test_ccw_virtio.py
> index 0455337856..1d4958bbe2 100755
> --- a/tests/functional/s390x/test_ccw_virtio.py
> +++ b/tests/functional/s390x/test_ccw_virtio.py
> @@ -136,7 +136,7 @@ def test_s390x_devices(self):
>                      r'0x1af4')
>          exec_command_and_wait_for_pattern(self,
>                      r'cat /sys/bus/pci/devices/0005\:00\:00.0/subsystem_=
device',
> -                    r'0x0001')
> +                    r'0x1100')
>          # check fid propagation
>          exec_command_and_wait_for_pattern(self,
>                      r'cat /sys/bus/pci/devices/000a\:00\:00.0/function_i=
d',
> @@ -203,7 +203,7 @@ def test_s390x_fedora(self):
>                          'while ! (dmesg | grep enP7p0s0) ; do sleep 1 ; =
done',
>                          'virtio_net virtio0 enP7p0s0: renamed')
>          exec_command_and_wait_for_pattern(self, 'lspci',
> -                             '0007:00:00.0 Class 0200: Device 1af4:1000')
> +                             '0007:00:00.0 Class 0200: Device 1af4:1041')
>          exec_command_and_wait_for_pattern(self,
>                               'cat /sys/class/net/enP7p0s0/address',
>                               '02:ca:fe:fa:ce:12')

AFAICS we always run with the default (latest) machine, so adapting to
any changed output there is probably the way to go -- unless we want to
test various permutations of older machines, but I think that would get
out of hand pretty quickly.

Can you send this with proper tags, I'll just go ahead and merge it.


