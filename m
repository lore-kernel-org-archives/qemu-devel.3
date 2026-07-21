Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B9AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm8js-0006My-49; Tue, 21 Jul 2026 07:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm8jp-0006MU-PI
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:34:17 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wm8jn-0003Qy-VS
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 07:34:17 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81ef8255cccso36504137b3.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 04:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784633653; cv=none;
 d=google.com; s=arc-20260327;
 b=r8NDm8WeX+V+OVNiNh9BL03ODjJVvoAoW/wSPCeyktxYad2Mdv6AWcqGE0z2JKW/zQ
 sSjBwAtLfwuJV45m0l56QI8XDIoVRkRq9EoRxk942BDbP9Qgi0hFPnd8TGN90yjnJo+q
 d9MRTJsBfSQ3l4qm+Q8s9ktur6MmwIvGj9cjqpTNhw6ZS1StVQ76xm+NgZiCqhAqMQLf
 S8rrsjLXnfI8a64PnutDe4I3DobutUQaBf+ZLw5sK/xd/ofYNj+ZiTzDePg+e0W+THdX
 +7Lp+JVGmOgnttDsoFJ5fmnhQh77PAyf4bjxbpBQKsr+BpW8VkybqKUqDpT3B2XMs3uK
 SIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Adw0bfmgzk5Vit31VHrElTAMoIYKWiscNzV4U5ClrVw=;
 fh=lQ2JeqdPLK5m79TkyaIfIjf4mxrp7E3SOgrqek3tz2k=;
 b=QbPT8Iekq9GKMpSbPKVwiSIEvtVmnkapsf5AzU5zZVOIVJgd+VER9hZIiMhPXH9sRR
 kO0mxqUAlYCu3Qkk0LM/UCsZKXE+r9EjhCh2eOshhGX0fGa9OVTjtw7eSHQCUNJZ24R1
 5P6hgm8dlshZoTdAx0zbjz1t1USj3dg3O+XMAYMeDWCVgJq824miHPa3pMqk2OvDNPje
 XTPcIfj5AHtgBKFKkRFyWGM6llRU187GHmS6zfhIIdyEHan+3Hs1OC4aI07cevsYmP48
 miUFXXY/A4YSytbRsgAtWZYaCu9PbODMrNUAUug4r1hcwGf475aG4r4QTqOfI9mBP8Ix
 bvOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784633653; x=1785238453; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Adw0bfmgzk5Vit31VHrElTAMoIYKWiscNzV4U5ClrVw=;
 b=eqbH3oBcNdgkym2Tt82uPSUlEN7M7a+K1aajOYKOikCyTiwFjk2hOfnWPl0v5Sh11b
 khee6RJBhTbLx+P6dCOMmp26WILtpVbelfONdA2Bep9LS6EvHw/iKZcq5MnhwuCQ5JKs
 +CTNkU+BONOJsz6Hfw7TFeeMTFC0cfjWvla86m0icKcYdT9i+gPruGdG08QoL62E7QsK
 7L4qFQzVZf1gx1TuFYokuqxPQAitgEJWR76hq6yRMFP7o8Axg2746xTLdqgfh5QFRs7n
 1xeCIozWW9mJMYoIlztJU7d2WEV2vQ6uf+9++fimD+o4YRTuI/B54mePnZKw5Va7S64f
 FOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784633653; x=1785238453;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Adw0bfmgzk5Vit31VHrElTAMoIYKWiscNzV4U5ClrVw=;
 b=LWLveYZilOjY4crbuyHtA1ckpGQ/vlYADuHD5LZJPttllaV5reYmOjLzdytDXb3NvB
 JHgTZDyIO5sF/ocGL94Db9iiPDGPsyxEc0L8yCAzk3nvh0+XIJCs4Ye8C4Ylvs1D+hO1
 eYAfPLya+HCpaT0hPN/ErsFpVJpbah7nDGgk77ExsaRKW+Zi7ayNFn+DPriWqSDQ2umD
 7fBk1Oe8a30LLEhjrIB8fiNdp6TfzA8+TAWBsQkFSgRRpUVHnsaxMIrD7gWk1f94vF5N
 ZvG7uk2tYXV4roZI0DIiNSBvfLH8hAIE6RQQYclO5nMOsAYUIytjb/Mz1MqTopaptRPu
 wZVA==
X-Gm-Message-State: AOJu0Yw1U+wq8VINv5F+RUfPYdoPS5jn2ylBm+dTgk/htlGgMh3cfvxV
 98+5anhvWHkgpZ9rPWQ/hUtZQ2/s6XjNZp4tckrlO0dnjH/I1qlG9v8B1w1yIzTd7o0V5Pj3uEd
 pnFfxyfH/A3BZFw63RjfwZgDo+t4ukFg=
X-Gm-Gg: AR+sD12xgEKhgUF85qYcklXQDbkLOGIcgKa5Ucu6dl40MTBStNU7HpQS29AXfcAF9A4
 84lx6uSg3WP+TjUEhIW2BfWFVpLxs7oB/Mj7xU7iz+cbTJ60WxYI5K47Q4I+w+KmAsAo/zG+vBQ
 xnpt8liEyotwd4+5uuxaUIMnWDyLBt9dBGvE7cmDLJ1eqm5gFFmB2yUmNoBwU+bl0TxGP95RRYF
 tjkOAKtPYrHsHEtrF5GBYt9FkCpWY6MYhvMGC/HJY0MUP03MugN4SE5DVHHFQ==
X-Received: by 2002:a05:690c:4b0e:b0:7d0:79f:339f with SMTP id
 00721157ae682-81ef26a5ca6mr59606657b3.34.1784633653225; Tue, 21 Jul 2026
 04:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA_UhmCxJc16CHE=4ZR1+PA0=4-29=fEe+d+iUmhLTzpuQ@mail.gmail.com>
 <CAEUhbmW=02DNwVH7pLtuWBzEnEVJiJNrZVcys-pLY_cS0uro1Q@mail.gmail.com>
 <CAFEAcA9DB+j3KJCM9yxVoSzQaXgx4uC_Bb7qm_p+OwS6EKn1fQ@mail.gmail.com>
 <CAFEAcA9t7TjhCSZ1EyBOPStu6vadq3UA9FMgbWOqkqfM0aMDoA@mail.gmail.com>
 <CAFEAcA9O4naO3WJXYL_qCZAvoGRchEryFnBHMJm-MT0+CjH=aw@mail.gmail.com>
In-Reply-To: <CAFEAcA9O4naO3WJXYL_qCZAvoGRchEryFnBHMJm-MT0+CjH=aw@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 21 Jul 2026 19:34:02 +0800
X-Gm-Features: AUfX_myePWJG3f7DOU8F64g905hz731F4TYfihHfOb0M2Amp03MYcNqNke-O1gs
Message-ID: <CAEUhbmU18Z7zvkErg_CMvgnhkJuY69oON6SjoiqvCbrrG8g7gA@mail.gmail.com>
Subject: Re: QEMU net code and padding of short packets
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yw1-x1134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

On Tue, Jul 21, 2026 at 12:22=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Mon, 29 Jun 2026 at 17:31, Peter Maydell <peter.maydell@linaro.org> wr=
ote:
> > I ran into this from a different angle today, and I think
> > qemu_receive_packet()'s check is wrong currently, not just
> > with this change. Although net_peer_needs_padding() will
> > almost always return "true" today, if the network device
> > has no peer (e.g. run with -net none or -nodefaults and no
> > other network backend connected to it) then we won't pad
> > packets we feed in for loopback, and so the bugs which
> > commit a01344d9d78 is trying to fix still occur. I'll send
> > a patch to make that change once I've tested it a bit.
> >
> > I'm also looking at a variant of this involving vlan headers:
> > https://gitlab.com/qemu-project/qemu/-/work_items/3518
> >
> > In commit 63b901bfd30 you removed the code from rtl8139.c
> > which handled padding out short frames in the device's
> > receive path, because we now do the padding at the other end.
> > However, in this case the padding code in the device was
> > also handling a case where there's an 802.1Q vlan tag: it makes
> > the buffer at least MIN_BUF_SIZE + VLAN_HLEN =3D=3D 64 bytes, with
> > the comment "Include some tailroom in case a vlan tag is
> > later removed". Then later we use this to avoid the copy
> > from the buffer reading off the end, but now the copy can
> > read 4 bytes of data off the end of the packet into guest
> > memory.
> >
> > How should we handle this? We could:
> >  - reinstate the rtl8139 padding code
> >  - make the generic padding code allow enough extra space
> >    for the 802.1Q vlan tag (so devices can assume that the
> >    frame is at least its minimum size even if there's a
> >    vlan tag)
> >  - have rtl8139 special case this
>
> Ping? How do you think we should handle the "short packet
> with a vlan header" case? I think I lean towards making
> the generic code deal with it.
>
> I'm also still very unsure whether our network layer is
> intended to distinguish "this is a short packet that we
> padded" from "this is a packet that the guest padded".
> Is a network driver/card model supposed to be able to
> opt in to getting unpadded packets and then identify and
> diagnose-as-error incoming short packets if it wants to?
> That would mean we need to distinguish "we padded this
> because the guest sent a short packet and we don't want
> to deal with that in loopback or otherwise" from "we
> padded this because it comes from a source that hands
> us legitimate short packets that would have been padded
> if they'd ever gone through a real network device".
>

Sorry for the delayed reply. I went back through the original change
and the current rtl8139 path. I think the source/destination
distinction you pointed out is real, but the current net API does not
encode it explicitly. The intent of 969e50b61a285 was that a short
packet supplied by a normal backend is a valid Ethernet packet whose
zero padding has been omitted. Before delivering it to a physical NIC
model, QEMU materializes that padding. A packet transmitted by a NIC
model, on the other hand, is the actual result of that model's TX path
and should reach the backend unchanged. The original commit explicitly
accepted the consequence that slirp/tap could no longer be used to
inject a real runt frame into a NIC model. So I don't think do_not_pad
should also be interpreted as "this physical NIC can receive and
diagnose real runts". That is a different property. virtio-net uses
do_not_pad because it accepts a length-delimited logical packet, not
because it is modelling runt-frame reception.

For the current cleanup, I think centralizing the padding as in your
draft series is still the right direction, provided we document that
contract. If we later want to support injecting genuine runt frames,
we will need a separate per-packet indication for "padding omitted"
versus "exact wire length". That indication would need to survive
queues, filters and hubs; a source-side boolean alone would not be
sufficient. For the VLAN case, after looking at it more closely, I
agree that the generic padding code should handle it. A single-tagged
Ethernet frame has a minimum length of ETH_ZLEN + VLAN_HLEN =3D=3D 64
bytes without FCS, so padding it to 64 is not merely providing private
tailroom for rtl8139. Ideally the helper could derive the minimum from
the L2 header length, which would also cover double-tagged frames.

There is also an independent rtl8139 loopback bug in
rtl8139_transfer_frame(). When dot1q_buf is present, it allocates and
fills buf2 using iov_size(iov, 3), which includes the inserted VLAN
tag, but calls qemu_receive_packet() with the original size. We need
to pass buf2_size there as well. Otherwise the padding helper will
copy four bytes less than the buffer actually contains. With both
changes, the loopback RX path receives a 64-byte tagged frame, and
VLAN stripping leaves the expected 60-byte frame without relying on an
out-of-bounds read.

Regards,
Bin

