Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8370EB26EA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 17:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vprnk-0005VR-UA; Tue, 10 Feb 2026 12:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vprni-0005Up-Or
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:45:26 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vprng-00072B-Tc
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 12:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770745520; x=1771350320; i=deller@gmx.de;
 bh=AujOlu3IU98yu41I2at1Q+w9YEO45oiR+jNnkLWaVf0=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=i11IzH1QKz2x4FVAilnpFVQ1uhUh9xQXWRUoIux7zey/qBiyz27al5GsTvFQcHDR
 TLp5eioGYvsZE3aNOVgUM3sP/ly7g0TFug7EPYzvOrJ4xKGuVtBzah4x83QDS9J1F
 XwUEabr7B+a7BNoA7al2qqImNvbcm6qMU7w24Kv3ZOTKRbV5eFM7+YG3k5jRB5auz
 xlsMI/uRnMa7bHA+4Vaa5JT12nX2CFGj0vVLpvW43TyrBWPBg+Z2vo/9JeIV/s6rB
 pp8tEYkLN3oKHjXBJ33hEj9+SzoBGb/vnsjDjK2LmwutTFjlvA0wZklI0+GwSBxKA
 UtYhnvevwiUvNeU39A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QJD-1vqgkP2OBB-004mOe; Tue, 10
 Feb 2026 18:45:20 +0100
Message-ID: <93c80b9e-7eb9-45f2-bdd7-a769e2935ba1@gmx.de>
Date: Tue, 10 Feb 2026 18:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aXH4PpkC4AtccsOE@redhat.com>
 <CAMxuvaw04pDNzHyw5+Qcv_KfrhDTiyp+MNxpECp+HfTa5iLOGw@mail.gmail.com>
 <aXH-TlzxZ1gDvPH2@redhat.com>
 <CAFEAcA_u6QUhs+6-cyYm_qttsDiV2zHbsc-_FbTb8QzWXk6+tw@mail.gmail.com>
 <aXICpFZuNM9GG4Kv@redhat.com>
 <CAMxuvawgOvQbwoyCzFBLw++JqR0vFbVUhbv1AJWU6VqK1MM_Og@mail.gmail.com>
 <82f74c82-c572-4ab9-b527-11ea287056d1@linaro.org>
 <CAJ+F1CJtrv9YgDbiekVmDD2yT+6nUe39nLwLsKxvFOtMc1kUGA@mail.gmail.com>
 <CAJSP0QUCQ8LkHEPNPb75XZmo46xxvP3uA373fzAZTwn=bo_bdg@mail.gmail.com>
 <f7a90238-f33d-430d-acd2-d8cd9ec275fe@gmx.de>
 <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <CAJSP0QVbvRxZXjbfoegu+NA=0hX3N9pSeG7Stx_jpqo1Mgwd0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:1oxhQv9k7SNYLiWHDsbyjsDA19vvfc2+XAFi9jx0iNLvMy1VqND
 Q2OQb5kWOixz1eWT3+rxv+w6Cem/u4A2hvbAKhsG3WwZYqhVzj5QBosgRwK++qrRTf8i3uo
 Z1FgtZ4i/lGVlSZzhdbPg7hyHJhFSDjSc1i4uPNHWic2wZcVRmRHakVe4lXxq1L3lfSu6GA
 3khqmhhcz5E2yEBY0XL3Q==
UI-OutboundReport: notjunk:1;M01:P0:NtPJ78+1uuA=;LJ568GatRmzDJ1WlPcZ29AjuDSc
 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
 fmCBQ1/vw5oITknG86LYdc0IeM0zjaJwlb5drM
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 1/27/26 15:18, Stefan Hajnoczi wrote:
> You are welcome to add the MPE project idea if you want to mentor it
> this summer. It's okay if you are still waiting on responses from
> people you are in touch with. Now that QEMU has at least 4 project
> ideas I can go ahead and submit the GSoC org application and you can
> still add your idea later.

Is there still time (before the 19th) ?

Instead of MPE, I wonder if there was at any time the idea to
add a SCSI TAPE emulation? I mean, not a pass-through driver,
but something which emulates a real drive, or at least the basic
SCSI TAPE commands. Maybe by utilizing the tape library from
the SIMH project?

Helge

