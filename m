Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F0DC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCSr-0005Cz-8V; Wed, 15 Jan 2025 18:06:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYCSp-0005Cq-Mw
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:06:19 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tYCSn-00023U-07
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=sT5p+HUm1zYtakqWA7QSFA/Q/EwBpEaRf/f200yme1s=; b=VKDcdHb1U1Kiw0SNMeCF6e6qlt
 WmEW1ID2RsMiBccOcEWA21/ezxsBssnmsDT++Uq3N1+oRj94h5ZMhbMxeNpOR9VMeiZoVllkGvVM1
 F8OUndaDMFk2q5+MTclcH1Cq2F24GzdkXKrtiyFEPUn38UTk6xiuNnW9+NYbhbGuYwPJNmyQik8ZD
 vTNtmyg24BBI/8xFREpSymbLInwlpHtyRgpFb6p3vBUL/vlb0up8/+oZOnHQE+wJAFOLobVrux+mG
 /VQ3oFjlWGu5RJH1PjoUL+/3ctYcB4bmsU6NVXpPzsfAArdC43GIRxaQeh2ZG6/gM49cMOEix7Ctr
 i3VNjMKQ==;
Received: from [104.151.0.194] (helo=[127.0.0.1])
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYCSW-0000000Axei-0qV1; Wed, 15 Jan 2025 23:06:09 +0000
Date: Thu, 16 Jan 2025 00:05:59 +0100
From: David Woodhouse <dwmw2@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/48] virtio,pc,pci: features, fixes, cleanups
User-Agent: K-9 Mail for Android
In-Reply-To: <20250115174130-mutt-send-email-mst@kernel.org>
References: <cover.1736964487.git.mst@redhat.com>
 <4f0312153b3232dc25afbb3901f00a3c53465074.camel@infradead.org>
 <20250115174130-mutt-send-email-mst@kernel.org>
Message-ID: <E43462B5-CFB5-433F-BB70-BEDC8D2FD4F2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+7322ae3fcc6f32da564c+7815+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 15 January 2025 23:42:41 CET, "Michael S=2E Tsirkin" <mst@redhat=2Ecom> =
wrote:
>On Wed, Jan 15, 2025 at 07:15:18PM +0100, David Woodhouse wrote:
>> On Wed, 2025-01-15 at 13:08 -0500, Michael S=2E Tsirkin wrote:
>> > The following changes since commit 7433709a147706ad7d1956b15669279933=
d0f82b:
>> >=20
>> > =C2=A0 Merge tag 'hw-misc-20250113' of https://github=2Ecom/philmd/qe=
mu=C2=A0into staging (2025-01-14 12:46:56 -0500)
>> >=20
>> > are available in the Git repository at:
>> >=20
>> > =C2=A0 https://git=2Ekernel=2Eorg/pub/scm/virt/kvm/mst/qemu=2Egit=C2=
=A0tags/for_upstream
>> >=20
>> > for you to fetch changes up to 60f543ad917fad731e39ff8ce2ca83b9a9cc9d=
90:
>> >=20
>> > =C2=A0 virtio-net: vhost-user: Implement internal migration (2025-01-=
15 13:07:34 -0500)
>> >=20
>> > ----------------------------------------------------------------
>> > virtio,pc,pci: features, fixes, cleanups
>> >=20
>> > The big thing here are:
>> > stage-1 translation in vtd
>> > internal migration in vhost-user
>> > ghes driver preparation for error injection
>> > new resource uuid feature in virtio gpu
>> >=20
>> > And as usual, fixes and cleanups=2E
>> >=20
>> > Signed-off-by: Michael S=2E Tsirkin <mst@redhat=2Ecom>
>>=20
>> Should I be concerned that the vmclock device isn't in this PR?
>>=20
>> https://lore=2Ekernel=2Eorg/qemu-devel/20250109080033-mutt-send-email-m=
st@kernel=2Eorg/
>>=20
>
>Oops=2E=2E it was there :( Dropped by mistake in a rebase=2E
>I'll redo the pull, thanks!
>

If it's easier, I could just round it up with the pull request I need to s=
end tomorro^W later today anyway?

