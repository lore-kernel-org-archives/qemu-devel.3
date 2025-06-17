Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84CAC71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 09:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRSQk-0000lg-ML; Tue, 17 Jun 2025 05:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uRSQj-0000kZ-5x
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:16:33 -0400
Received: from p-east3-cluster1-host10-snip4-2.eps.apple.com ([57.103.87.95]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uRSQf-0005Z1-4R
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 05:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=F2Lk87g/ffbwU6AtjA/WqgttL7/b0yIw5RLWx7pPGH8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=t/ebtiKWDY2QkbdzHbQ8JHAQfW1irYE31MIXq5FeLuQBVi2srySC4AW71wet8gKuQ
 NlCtlcJtugl2N8OExL2XPUcYb01vz9cJeaP4XAHUNki1VR/W0mWuIgJx8RWVrvaWRH
 Byaa4t7oX7MCpWsgwXdEpyufTUl6xr1VGUemjO2LowKLdrX8vshUlah0LMXLG0/Otn
 DqAICXcAFc5hhPAYSdZkfGlEh+oBwZSg/5iGUd51B84db5dd/YZZ76xa8b442qkjH0
 ayL40utni9I3IDatF919KJrglGL7z8PuqtzAFeSjhXkTD/GNBcY1MXtOOq2jDTx/F/
 PhTKUTD3kuRQA==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by outbound.qs.icloud.com (Postfix) with ESMTPS id 23F3C18000A9;
 Tue, 17 Jun 2025 09:16:15 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by outbound.qs.icloud.com (Postfix) with ESMTPSA id 9338118011E4;
 Tue, 17 Jun 2025 09:16:04 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2 06/12] python: upgrade to python3.9+ syntax
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250612205451.1177751-7-jsnow@redhat.com>
Date: Tue, 17 Jun 2025 11:15:53 +0200
Cc: qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Yi Liu <yi.l.liu@intel.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Fabiano Rosas <farosas@suse.de>, Alexander Bulekov <alxndr@bu.edu>,
 Darren Kenny <darren.kenny@oracle.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Ed Maste <emaste@freebsd.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Kevin Wolf <kwolf@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>, Eric Blake <eblake@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Troy Lee <leetroy@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Michael Roth <michael.roth@amd.com>, Laurent Vivier <laurent@vivier.eu>,
 Ani Sinha <anisinha@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-s390x@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 =?utf-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 =?utf-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paul Durrant <paul@xen.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-arm@nongnu.org, Hao Wu <wuhaotsh@google.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Michael Rolnik <mrolnik@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Alessandro Di Federico <ale@rev.ng>,
 Thomas Huth <thuth@redhat.com>, Antony Pavlov <antonynpavlov@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Hyman Huang <yong.huang@smartx.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, qemu-rust@nongnu.org,
 Bandan Das <bsd@redhat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Fam Zheng <fam@euphon.net>,
 Jia Liu <proljc@gmail.com>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Kyle Evans <kevans@freebsd.org>, Song Gao <gaosong@loongson.cn>,
 Alexandre Iooss <erdnaxe@crans.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Peter Xu <peterx@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?utf-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9C057F25-8BE4-45FC-9332-99F24440DB92@ynddal.dk>
References: <20250612205451.1177751-1-jsnow@redhat.com>
 <20250612205451.1177751-7-jsnow@redhat.com>
To: John Snow <jsnow@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA3NCBTYWx0ZWRfX6flXK9bQW94b
 pJhRZhBGKFxj3lG2g7w6QCE8uC9WUg0wn7rn9PJHRTtq39uGPdo5LGU1xE8xS/wePJaPs7EYL08
 Iwa/wui04kYrGFU98n3t8cxxZLiZtwcvvytg6FniPlo16ksCYxaWNCfIdZVCFfh/QSGD/YHzSPH
 yNIm7mrdH8tjzyzwJ7IjP9/VduRn8rZqm1T1DMbZQzXPEA0o54pUX+8rvDDWgOqMoyGDw5oYnBs
 xbCyKO5AHXZRA91yQKp41W64scRkgTTEl7Mq+rov+XdHXzu7exdDWFHhAvRtW8XuqB4EgCUm8=
X-Proofpoint-GUID: wKgdYrb_CFsT9g0pbMc6pxf-vBqLxnwg
X-Proofpoint-ORIG-GUID: wKgdYrb_CFsT9g0pbMc6pxf-vBqLxnwg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=964
 mlxscore=0 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506060001 definitions=main-2506170074
Received-SPF: pass client-ip=57.103.87.95; envelope-from=mads@ynddal.dk;
 helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


> diff --git a/scripts/simpletrace.py b/scripts/simpletrace.py
> index cef81b0707f..a013e4402de 100755
> --- a/scripts/simpletrace.py
> +++ b/scripts/simpletrace.py
> @@ -9,13 +9,15 @@
> #
> # For help see docs/devel/tracing.rst
>=20
> -import sys
> -import struct
> import inspect
> +import struct
> +import sys
> import warnings
> -from tracetool import read_events, Event
> +
> +from tracetool import Event, read_events
> from tracetool.backend.simple import is_string
>=20
> +
> __all__ =3D ['Analyzer', 'Analyzer2', 'process', 'run']
>=20
> # This is the binary format that the QEMU "simple" trace backend
> @@ -166,11 +168,9 @@ def runstate_set(self, timestamp, pid, =
new_state):
>=20
>     def begin(self):
>         """Called at the start of the trace."""
> -        pass
>=20
>     def catchall(self, event, rec):
>         """Called if no specific method for processing a trace event =
has been found."""
> -        pass
>=20
>     def _build_fn(self, event):
>         fn =3D getattr(self, event.name, None)
> @@ -208,7 +208,6 @@ def _process_event(self, rec_args, *, event, =
event_id, timestamp_ns, pid, **kwar
>=20
>     def end(self):
>         """Called at the end of the trace."""
> -        pass
>=20
>     def __enter__(self):
>         self.begin()
> @@ -263,7 +262,6 @@ def runstate_set(self, new_state, *, timestamp_ns, =
pid, **kwargs):
>=20
>     def catchall(self, *rec_args, event, timestamp_ns, pid, event_id, =
**kwargs):
>         """Called if no specific method for processing a trace event =
has been found."""
> -        pass
>=20
>     def _process_event(self, rec_args, *, event, **kwargs):
>         fn =3D getattr(self, event.name, self.catchall)
> @@ -279,7 +277,7 @@ def process(events, log, analyzer, =
read_header=3DTrue):
>     """
>=20
>     if isinstance(events, str):
> -        with open(events, 'r') as f:
> +        with open(events) as f:
>             events_list =3D read_events(f, events)
>     elif isinstance(events, list):
>         # Treat as a list of events already produced by =
tracetool.read_events
> @@ -332,7 +330,7 @@ def run(analyzer):
>     except (AssertionError, ValueError):
>         raise SimpleException(f'usage: {sys.argv[0]} [--no-header] =
<trace-events> <trace-file>\n')
>=20
> -    with open(trace_event_path, 'r') as events_fobj, =
open(trace_file_path, 'rb') as log_fobj:
> +    with open(trace_event_path) as events_fobj, open(trace_file_path, =
'rb') as log_fobj:
>         process(events_fobj, log_fobj, analyzer, read_header=3Dnot =
no_header)
>=20
> if __name__ =3D=3D '__main__':

I'm not really a fan of the implicit default arguments, but I guess the =
rest is fine. If this is the way everyone else wants to go, I won't =
stand in the way.

=E2=80=94
Mads Ynddal


