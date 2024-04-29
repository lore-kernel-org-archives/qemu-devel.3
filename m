Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B57C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 20:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Xsn-0007cj-DW; Mon, 29 Apr 2024 16:45:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s1Xsi-0007cF-Et
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:45:49 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yu.zhang@ionos.com>)
 id 1s1Xsf-000421-0O
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 16:45:47 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a55b3d57277so595962366b.2
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 13:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ionos.com; s=google; t=1714423541; x=1715028341; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OK7xQsmFQ0ahkCoEubxqDk3woSt4EgOjhGhHTegqqsk=;
 b=XCvYVbdb1KVw9KYRW+zCtAhmol7tC2od+Mji6T/ew6/4keyqQ1/g1MfJty7gihXCXM
 Qu9d8Jck2jDD1bRCeQtJ4vzPkvzk/mWvJDaE3wDsmhgCcyTcyUXyFmNaGQFw6Z7FQq2j
 NJ7Mvxx8aOj1JAimQpC1N2U6viwvwRRWYGdr9+WElGGVl3RN3r+ngeKrPm7jtlq+PRtK
 8scMwKcGzUZInwhHyEMAtGw7S8SnOfhoDXgNuhxtWH97jRBC55W+ey21GHDktYfKBMp8
 985sj8DJmIWPVTaRooVqIkeDMHzt8RF21JgNfoEkISvP+TcuC1fjXCVO2zD1DYY0XoH4
 PvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714423541; x=1715028341;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OK7xQsmFQ0ahkCoEubxqDk3woSt4EgOjhGhHTegqqsk=;
 b=jEk7wQnOgE5zXlic1Mm5heXJNSaqjQCuDm9x2XRpybdtDEaNcSJ/4YQpz0upZUR9rl
 eVGJDq0P9YgDN2OWo5gt4hhxajPCPcACg9+oEx43JZmyki1cwc0CwlWnsgh5hRKDLP4F
 AD/ZDZEzHZ4t95avPhG+mfQSn5zKjUKC/20yvUL345KslcJzYohSjLRbbq6RMqEAJHPy
 G69CmyA6sN4IfyG4VuYicuokkf4ZHSeXewi9OlBFJRlv4Q52eqZALNd08Sfvh49JyTTf
 vdFbVcgeZ5bUqpZ7RGmKy+Fsb9y+ODlPo0hMz2GHgkLqYDXVA7mitBFXcfM/39A6tWe1
 ybXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5FOIu0QCId5v+itBcFHImgovBqmeMo4Xpy5qWvs8Sm00z5zAvkZ2RHB5+DLkDp5Hsy3GYp5kih3bBA65HtmT4RPXqRCs=
X-Gm-Message-State: AOJu0Yz3eKxuCJHsOrZm5KRe+V2pQnnwa8VEgLmC1TP1wB43X/MZ6Cgs
 N4VX2/avDstRi0GXseekb6IG36MR+mOUDi4Q4I8H67zJ3RW52aLFheeMpCbWBC4VXiANUEOjZER
 ezDhO62Cdax5EJd049+B6PIfMFB5UcxJ3zXY+lQ==
X-Google-Smtp-Source: AGHT+IEhImoZlwKpbOgmaWtTmgahUdccGQqo3N2uKbbd5hpfwdbxzJ1Uwq+rI8wyQ2M1LTsCeZ5dge1mVOMf8Aa9iCc=
X-Received: by 2002:a17:906:fb86:b0:a58:c80e:edd9 with SMTP id
 lr6-20020a170906fb8600b00a58c80eedd9mr5804733ejb.77.1714423540702; Mon, 29
 Apr 2024 13:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <Zgx3brrz8m0V7HS4@x1n>
 <CAMGffE=i+hVCNaX_31h1D1VW7JGJBqoa9T0qEJe2CDcb9BPiAA@mail.gmail.com>
 <ZhQYu3ZnsIGv2qUZ@x1n>
 <CAMGffEm2TWJxOPcNQTQ1Sjytf5395dBzTCMYiKRqfxDzJwSN6A@mail.gmail.com>
 <ZhWa0YeAb9ySVKD1@x1n> <082a21b0-d4d1-9f6c-24b5-bee56263008e@fujitsu.com>
 <ZhaY2_cO6CrQFCt3@x1n> <Zhfxoaz9yNTx8Btd@x1n>
 <CAHEcVy7POArt+CmY8dyNTzLJp3XxXgjh3k8=C=9K+_cw1CSJFA@mail.gmail.com>
 <46f5e323-632d-7bda-f2c5-3cfa7b1c6b68@akamai.com> <Zi-1OvxA5MIHjklU@x1n>
In-Reply-To: <Zi-1OvxA5MIHjklU@x1n>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 29 Apr 2024 22:45:29 +0200
Message-ID: <CAHEcVy7fr9x22DnGnoE93w1w0O0y3bW2fBxg=4F8==W_6P09_A@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
To: Michael Galaxy <mgalaxy@akamai.com>, Peter Xu <peterx@redhat.com>
Cc: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>,
 Jinpu Wang <jinpu.wang@ionos.com>, Elmar Gerdes <elmar.gerdes@ionos.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Prasanna Kumar Kalever <prasanna4324@gmail.com>, 
 "integration@gluster.org" <integration@gluster.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "devel@lists.libvirt.org" <devel@lists.libvirt.org>,
 Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, arei.gonglei@huawei.com, 
 pannengyuan@huawei.com
Content-Type: multipart/mixed; boundary="00000000000023b68d0617425666"
Received-SPF: permerror client-ip=2a00:1450:4864:20::634;
 envelope-from=yu.zhang@ionos.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--00000000000023b68d0617425666
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Michael and Peter,

We are very glad at your quick and kind reply about our plan to take
over the maintenance of your code. The message is for presenting our
plan and working together.
If we were able to obtain the maintainer's role, our plan is:

1. Create the necessary unit-test cases and get them integrated into
the current QEMU GitLab-CI pipeline
2. Review and test the code changes by other developers to ensure that
nothing is broken in the changed code before being merged by the
community
3. Based on our current practice and application scenario, look for
possible improvements when necessary

Besides that, a patch is attached to announce this change in the community.

With your generous support, we hope that the development community
will make a positive decision for us.

Kind regards,
Yu Zhang@ IONOS Cloud

On Mon, Apr 29, 2024 at 4:57=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Apr 29, 2024 at 08:08:10AM -0500, Michael Galaxy wrote:
> > Hi All (and Peter),
>
> Hi, Michael,
>
> >
> > My name is Michael Galaxy (formerly Hines). Yes, I changed my last name
> > (highly irregular for a male) and yes, that's my real last name:
> > https://www.linkedin.com/in/mrgalaxy/)
> >
> > I'm the original author of the RDMA implementation. I've been discussin=
g
> > with Yu Zhang for a little bit about potentially handing over maintaine=
rship
> > of the codebase to his team.
> >
> > I simply have zero access to RoCE or Infiniband hardware at all,
> > unfortunately. so I've never been able to run tests or use what I wrote=
 at
> > work, and as all of you know, if you don't have a way to test something=
,
> > then you can't maintain it.
> >
> > Yu Zhang put a (very kind) proposal forward to me to ask the community =
if
> > they feel comfortable training his team to maintain the codebase (and r=
un
> > tests) while they learn about it.
>
> The "while learning" part is fine at least to me.  IMHO the "ownership" t=
o
> the code, or say, taking over the responsibility, may or may not need 100=
%
> mastering the code base first.  There should still be some fundamental
> confidence to work on the code though as a starting point, then it's abou=
t
> serious use case to back this up, and careful testings while getting more
> familiar with it.
>
> >
> > If you don't mind, I'd like to let him send over his (very detailed)
> > proposal,
>
> Yes please, it's exactly the time to share the plan.  The hope is we try =
to
> reach a consensus before or around the middle of this release (9.1).
> Normally QEMU has a 3~4 months window for each release and 9.1 schedule i=
s
> not yet out, but I think it means we make a decision before or around
> middle of June.
>
> Thanks,
>
> >
> > - Michael
> >
> > On 4/11/24 11:36, Yu Zhang wrote:
> > > > 1) Either a CI test covering at least the major RDMA paths, or at l=
east
> > > >      periodically tests for each QEMU release will be needed.
> > > We use a batch of regression test cases for the stack, which covers t=
he
> > > test for QEMU. I did such test for most of the QEMU releases planned =
as
> > > candidates for rollout.
> > >
> > > The migration test needs a pair of (either physical or virtual) serve=
rs with
> > > InfiniBand network, which makes it difficult to do on a single server=
. The
> > > nested VM could be a possible approach, for which we may need virtual
> > > InfiniBand network. Is SoftRoCE [1] a choice? I will try it and let y=
ou know.
> > >
> > > [1]  https://urldefense.com/v3/__https://enterprise-support.nvidia.co=
m/s/article/howto-configure-soft-roce__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDL=
fvUXZXPwMTaXizuIQeIgJiywPzuwbqx8wM0KUsyopw_EYQxWvGHE3ig$
> > >
> > > Thanks and best regards!
> > >
> > > On Thu, Apr 11, 2024 at 4:20=E2=80=AFPM Peter Xu <peterx@redhat.com> =
wrote:
> > > > On Wed, Apr 10, 2024 at 09:49:15AM -0400, Peter Xu wrote:
> > > > > On Wed, Apr 10, 2024 at 02:28:59AM +0000, Zhijian Li (Fujitsu) vi=
a wrote:
> > > > > >
> > > > > > on 4/10/2024 3:46 AM, Peter Xu wrote:
> > > > > >
> > > > > > > > Is there document/link about the unittest/CI for migration =
tests, Why
> > > > > > > > are those tests missing?
> > > > > > > > Is it hard or very special to set up an environment for tha=
t? maybe we
> > > > > > > > can help in this regards.
> > > > > > > See tests/qtest/migration-test.c.  We put most of our migrati=
on tests
> > > > > > > there and that's covered in CI.
> > > > > > >
> > > > > > > I think one major issue is CI systems don't normally have rdm=
a devices.
> > > > > > > Can rdma migration test be carried out without a real hardwar=
e?
> > > > > > Yeah,  RXE aka. SOFT-RoCE is able to emulate the RDMA, for exam=
ple
> > > > > > $ sudo rdma link add rxe_eth0 type rxe netdev eth0  # on host
> > > > > > then we can get a new RDMA interface "rxe_eth0".
> > > > > > This new RDMA interface is able to do the QEMU RDMA migration.
> > > > > >
> > > > > > Also, the loopback(lo) device is able to emulate the RDMA inter=
face
> > > > > > "rxe_lo", however when
> > > > > > I tried(years ago) to do RDMA migration over this
> > > > > > interface(rdma:127.0.0.1:3333) , it got something wrong.
> > > > > > So i gave up enabling the RDMA migration qtest at that time.
> > > > > Thanks, Zhijian.
> > > > >
> > > > > I'm not sure adding an emu-link for rdma is doable for CI systems=
, though.
> > > > > Maybe someone more familiar with how CI works can chim in.
> > > > Some people got dropped on the cc list for unknown reason, I'm addi=
ng them
> > > > back (Fabiano, Peter Maydell, Phil).  Let's make sure nobody is dro=
pped by
> > > > accident.
> > > >
> > > > I'll try to summarize what is still missing, and I think these will=
 be
> > > > greatly helpful if we don't want to deprecate rdma migration:
> > > >
> > > >    1) Either a CI test covering at least the major RDMA paths, or a=
t least
> > > >       periodically tests for each QEMU release will be needed.
> > > >
> > > >    2) Some performance tests between modern RDMA and NIC devices ar=
e
> > > >       welcomed.  The current knowledge is modern NIC can work simil=
arly to
> > > >       RDMA in performance, then it's debatable why we still maintai=
n so much
> > > >       rdma specific code.
> > > >
> > > >    3) No need to be soild patchsets for this one, but some plan to =
improve
> > > >       RDMA migration code so that it is not almost isolated from th=
e rest
> > > >       protocols.
> > > >
> > > >    4) Someone to look after this code for real.
> > > >
> > > > For 2) and 3) more info is here:
> > > >
> > > > https://urldefense.com/v3/__https://lore.kernel.org/r/ZhWa0YeAb9ySV=
KD1@x1n__;!!GjvTz_vk!VEqNfg3Kdf58Oh1FkGL6ErDLfvUXZXPwMTaXizuIQeIgJiywPzuwbq=
x8wM0KUsyopw_EYQxWpIWYBhQ$
> > > >
> > > > Here 4) can be the most important as Markus pointed out.  We just d=
idn't
> > > > get there yet on the discussions, but maybe Markus is right that we=
 should
> > > > talk that first.
> > > >
> > > > Thanks,
> > > >
> > > > --
> > > > Peter Xu
> > > >
> >
>
> --
> Peter Xu
>

--00000000000023b68d0617425666
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-MAINTAINERS-Update-the-maintainers-and-reviewers-for.patch"
Content-Disposition: attachment; 
	filename="0001-MAINTAINERS-Update-the-maintainers-and-reviewers-for.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lvlfhndi0>
X-Attachment-Id: f_lvlfhndi0

RnJvbSA0MGRlYTM5MmY5Y2E2MDZjMmEwYzUzOTk5ZDY2MjY3MGViMDhiMmQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBZdSBaaGFuZyA8eXUuemhhbmdAaW9ub3MuY29tPgpEYXRlOiBN
b24sIDI5IEFwciAyMDI0IDE1OjMxOjUzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gTUFJTlRBSU5F
UlM6IFVwZGF0ZSB0aGUgbWFpbnRhaW5lcnMgYW5kIHJldmlld2VycyBmb3IgUkRNQQogbWlncmF0
aW9uCgpBcyB0aGUgbGlua3MgWzFdWzJdIGJlbG93IHN0YXRlZCwgUUVNVSBkZXZlbG9wbWVudCBj
b21tdW5pdHkgaXMgY3VycmVudGx5CmhhdmluZyBzb21lIGRpZmZpY3VsdGllcyBpbiBtYWludGFp
bmluZyB0aGUgUkRNQSBtaWdyYXRpb24gc3Vic3lzdGVtIGR1ZQp0byB0aGUgbGFjayBvZiByZXNv
dXJjZXMgKG1haW50YWluZXJzLCB0ZXN0IGNhc2VzLCB0ZXN0IGVudmlyb25tZW50IGV0Yy4pCmFu
ZCBjb25zaWRlcmluZyB0byBkZXByZWNhdGUgaXQuCgpBY2NvcmRpbmcgdG8gb3VyIHVzZXIgZXhw
ZXJpZW5jZSBpbiB0aGUgcmVjZW50IHR3byB5ZWFycywgd2Ugb2JzZXJ2ZWQgdGhhdApSRE1BIGlz
IGNhcGFibGUgb2YgcHJvdmlkaW5nIGhpZ2hlciBtaWdyYXRpb24gc3BlZWQgYW5kIGxvd2VyIHBl
cmZvcm1hbmNlCmltcGFjdCB0byBhIHJ1bm5pbmcgVk0sIHdoaWNoIGNhbiBzaWduaWZpY2FudGx5
IGltcHJvdmUgdGhlIGVuZC11c2VyJ3MKZXhwZXJpZW5jZSBkdXJpbmcgdGhlIFZNIGxpdmUgbWln
cmF0aW9uLiBXZSBiZWxpZXZlIHRoYXQgUkRNQSBzdGlsbCBwbGF5cwphIGtleSByb2xlIGZvciB0
aGUgUW9TIGFuZCBjYW4ndCB5ZXQgYmUgcmVwbGFjZWQgYnkgVENQL0lQIGZvciBWTSBtaWdyYXRp
b24KYXQgdGhlIG1vbWVudC4KCldpdGggdGhlIGNvbnNlbnQgYW5kIHN1cHBvcnRzIGZyb20gTWlj
aGFlbCBHYWxheHksIHdobyBoYXMgZGV2ZWxvcGVkIHRoaXMKZmVhdHVyZSBmb3IgUUVNVSwgd2Ug
d291bGQgbGlrZSB0byB0YWtlIG92ZXIgdGhlIG1haW50YWluZXIncyByb2xlIGFuZApjcmVhdGUg
dGhlIG5lY2Vzc2FyeSByZXNvdXJjZXMgdG8gbWFpbnRhaW4gaXQgZnVydGhlciBmb3IgdGhlIGNv
bW11bml0eS4KCkppbnB1IFdhbmcgaXMgdGhlIHVwc3RyZWFtIG1haW50YWluZXIgb2YgUk5CRC9S
VFJTLiBIZSBpcyBleHBlcmllbmNlZCBpbgpSRE1BIHByb2dyYW1taW5nLCBhbmQgWXUgWmhhbmcg
bWFpbnRhaW5zIHRoZSBkb3duc3RyZWFtIFFFTVUgZm9yIElPTk9TCmNsb3VkIGluIHByb2R1Y3Rp
b24uCgpbMV0gaHR0cHM6Ly9tYWlsLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAy
NC0wNC9tc2cwMDAwMS5odG1sClsyXSBodHRwczovL21haWwuZ251Lm9yZy9hcmNoaXZlL2h0bWwv
cWVtdS1kZXZlbC8yMDI0LTA0L21zZzAwMjI4Lmh0bWwKClNpZ25lZC1vZmYtYnk6IFl1IFpoYW5n
IDx5dS56aGFuZ0Bpb25vcy5jb20+ClNpZ25lZC1vZmYtYnk6IEphY2sgV2FuZyA8amlucHUud2Fu
Z0Bpb25vcy5jb20+Ci0tLQogTUFJTlRBSU5FUlMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKaW5k
ZXggMzAyYjZmZDAwYy4uNTRkMzJkZmY5NCAxMDA2NDQKLS0tIGEvTUFJTlRBSU5FUlMKKysrIGIv
TUFJTlRBSU5FUlMKQEAgLTM0MTMsNyArMzQxMywxMCBAQCBGOiB1dGlsL3VzZXJmYXVsdGZkLmMK
IFg6IG1pZ3JhdGlvbi9yZG1hKgogCiBSRE1BIE1pZ3JhdGlvbgorTTogWXUgWmhhbmcgPHl1Lnpo
YW5nQGlvbm9zLmNvbT4KK006IEphY2sgV2FuZyA8amFjay53YW5nQGlvbm9zLmNvbT4KIFI6IExp
IFpoaWppYW4gPGxpemhpamlhbkBmdWppdHN1LmNvbT4KK1I6IE1pY2hhZWwgR2FsYXh5IDxtZ2Fs
YXh5QGFrYW1haS5jb20+CiBSOiBQZXRlciBYdSA8cGV0ZXJ4QHJlZGhhdC5jb20+CiBTOiBPZGQg
Rml4ZXMKIEY6IG1pZ3JhdGlvbi9yZG1hKgotLSAKMi4yNS4xCgo=
--00000000000023b68d0617425666--

