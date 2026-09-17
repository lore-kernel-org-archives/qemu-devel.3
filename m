Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72282C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 06:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x75Mh-0001is-RZ; Thu, 17 Sep 2026 02:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x75Mf-0001i8-Vt; Thu, 17 Sep 2026 02:12:58 -0400
Received: from mail.hetzner.company ([2a01:4f8:d0a:203a::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tim.foerster@hetzner.com>)
 id 1x75Md-0000bA-68; Thu, 17 Sep 2026 02:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hetzner.com
 ; s=lms2212;
 h=In-Reply-To:References:To:From:Subject:Cc:Message-Id:Date:
 Content-Type:Content-Transfer-Encoding:Mime-Version:Sender:Reply-To:
 Content-ID:Content-Description;
 bh=FAxydslWyJ2kLeuYwrytewDnxcJHNPEt2z1Azc9MzJw=; b=QOLTjEgAci0fb/S80jWpi5ra+d
 /g3aP0uQoouGvps5A8Vh50NDOiiBlIW9i0lbTT3GsapTIO2Iv8lw1aQSuYJ2izvClHF/WQkXBiCGs
 3g+3xoy/Ks9ms77Z3vILopNH+E95Hm30vFcvOW4NZAgYqh0qcOJlIW5JP5Go/Bvbxj1c/Vcn9tFae
 3WFvtAeCiD8jngqRkypm2BBWRYQlt6K+gMKbnnoxw6Ujqvsr5nj3i6DxD+LbTo/2turjKRTYgBvxU
 3RfIp0XKZJxlsHQtGU2LN/VPok7X6UhI7DRSbUOFpePwFQQGfqk2nAl2MbGpr0VbaJhgMkumrIU6h
 t64Bc7aQ==;
Received: from [2a01:4f8:0:a105::1003] (helo=localhost)
 by mail.hetzner.company with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.94.2) (envelope-from <tim.foerster@hetzner.com>)
 id 1x75MY-009DYl-At; Thu, 17 Sep 2026 08:12:50 +0200
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 08:12:49 +0200
Message-Id: <DLHDBGTBWCIV.1U1MGIZCXMASZ@hetzner.com>
Cc: <qemu-devel@nongnu.org>, "Jason Wang" <jasowangio@gmail.com>, "Markus
 Armbruster" <armbru@redhat.com>,
 <qemu-devel-bounces+tim.foerster=hetzner.com@nongnu.org>
Subject: Re: QMP: exposing the host TAP interface name
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, "Tim
 Foerster" <tim.foerster@hetzner.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <DLGIW2X7905Z.1AXV42Q0QG1CM@hetzner.com>
 <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CLxsqfT302SGcq9vx5pgjrY3OiibmTpZHVtx1d-rXroVQ@mail.gmail.com>
X-Authenticated-Sender: tim.foerster@hetzner.com
Received-SPF: pass client-ip=2a01:4f8:d0a:203a::1;
 envelope-from=tim.foerster@hetzner.com; helo=mail.hetzner.company
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_HI=-5,
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
Reply-to:  "Tim Foerster" <tim.foerster@hetzner.com>
From:  "Tim Foerster" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

On Wed Sep 16, 2026 at 3:18 PM CEST, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Sep 16, 2026 at 10:22=E2=80=AFAM Tim Foerster via qemu developmen=
t
> <qemu-devel@nongnu.org> wrote:
>>
>> Hi,
>>
>> I'd like to query the host TAP interface name of a network backend via Q=
MP, especially when the TAP FD is passed to QEMU using SCM_RIGHTS
>> and then assigned to a backend through fd=3D.
>>
>> In my current setup, retrieving this information externally requires CAP=
_SYS_PTRACE. This gives the management process far more access
>> than needed and conflicts with the Landlock sandboxing I want to apply, =
due to Landlock's ptrace restrictions [1].
>>
>> QEMU already owns the FD, and tap_fd_get_ifname() can retrieve the name =
using TUNGETIFF on Linux. For a TAP passed through fd=3D, x-query-
>> network currently reports the following (simplified):
>>
>> {
>>   "name": "hostnet0",
>>   "type": "tap",
>>   "info-str": "fd=3D42"
>> }
>>
>> I'd like to obtain the actual interface name in a structured field, rega=
rdless of how the TAP was created or passed to QEMU. For example:
>>
>> {
>>   "name": "hostnet0",
>>   "type": "tap",
>>   "info-str": "fd=3D42",
>>   "data": {
>>     "ifname": "vnet7"
>>   }
>> }
>>
>> Would extending x-query-network be the preferred approach? If so, would =
you prefer a dedicated ifname field or a type-specific data object
>> selected by the existing type field?
>
> x- QMP commands are not meant for any other usage than debugging and
> testing (in fact, we should probably exclude them in production
> builds!). In particular, this command is currently only meant to be a
> HMP "info network" substitute for test/debugging only atm.

Well, I know about this concern, I was mainly trying to open a door there.
Not sure how flexible we will end up being here. I also did not get into wh=
ich
patterns should be part of the HMP and which should only be exposed to the =
QMP
layer.

>>
>> Personally, I'd prefer an approach that is reasonably easy to backport d=
ownstream to older QEMU releases. Since x-query-network is
>> relatively new, extending it would also require bringing that command to=
 releases which don't have it yet, potentially increasing the
>> backporting effort.
>>
>> A type-specific data object could also accommodate additional TAP proper=
ties later, such as multiqueue mode or vnet_hdr. However, those
>> are outside my current scope, I only need the interface name.
>
> I'd suggest a new query-network-tap(name: hostnet0) -> TAPInfo command
> for your specific case. Eventually, later, NetworkClientInfo could
> later embed that data.

I like the idea of having a `query-network-tap(name: hostnet0)`. I can
also try to send a patch, but wanted to collect your opinions first.
Once we agree on an API layout, I'll give it a try.

>
> Let see what other people & maintainers think
>
> thanks



