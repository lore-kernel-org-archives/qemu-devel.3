Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB05C61DFD
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 02:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Dze-0001vZ-AW; Mon, 31 Aug 2026 22:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x1Dzb-0001vD-AV
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:12:56 -0400
Received: from va-2-28.ptr.blmpb.com ([209.127.231.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xiangwencheng@lanxincomputing.com>)
 id 1x1DzX-0007Gh-AP
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 22:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1788228765;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=ltLphJMhYwfdkcEfIotk1IteW6j95X8KR4j7/Rw79+Q=;
 b=qmXNy+GqxEYMAToZBeqzSTKiNVOKQTGzUa5DVvA3BFuYdmAK1afjaBXnuarSOpvpTUCdVF
 mlBotmHkK2BGgRASPOQR7HkNMGll/zFOO1pBqDCChHHxoypdmB3PsryAgyPJUY/sg9Slj+
 KyeOTLIhj1fpdczsOwuNn41DvqwWG9iZw/0rpGyvDNS7I7THHr2P/tAfD1AATKa8aakR3R
 IpBNteJPdGEIlHE2xNS11/Yg/55skjnRr23SCbZTSCA1F9S0w8ci6p4/o//GP8/6oj0eGa
 Ypis4SwXdLaVfhYG9qI4+QtgD0iy9L8uV42G1cKZFdKcv5snrhSKsP9yCD8a6g==
X-Original-From: BillXiang <xiangwencheng@lanxincomputing.com>
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26a96349b+21d340+nongnu.org+xiangwencheng@lanxincomputing.com>
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <apW0SkNxWPCyvVV6@x1.local>
Cc: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 "Albert Esteve" <aesteve@redhat.com>, 
 "Alberto Faria" <afaria@redhat.com>, 
 "Alessandro Di Federico" <ale@rev.ng>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Anton Johansson" <anjo@rev.ng>, "Markus Armbruster" <armbru@redhat.com>, 
 "Brian Cain" <bcain@quicinc.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, 
 "Chao Peng" <chao.p.peng@linux.intel.com>, <cjia@nvidia.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <cw@f00f.org>, 
 <dbarboza@qti.qualcomm.com>, 
 "Demi Marie Obenour" <demiobenour@gmail.com>, <dhedde@kalrayinc.com>, 
 "Eric Blake" <eblake@redhat.com>, <eblot@rivosinc.com>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 "Eduardo Habkost" <eduardo@habkost.net>, 
 "Elena Ufimtseva" <elena.ufimtseva@oracle.com>, 
 "Auger Eric" <eric.auger@redhat.com>, <felipe@nutanix.com>, 
 <helge.deller@googlemail.com>, "Alyssa Ross" <hi@alyssa.is>, 
 <iggy@theiggy.com>, "Warner Losh" <imp@bsdimp.com>, 
 <jacob.oursland@gmail.com>, "Jan Kiszka" <jan.kiszka@web.de>, 
 "Jason Gunthorpe" <jgg@nvidia.com>, <jidong.xiao@gmail.com>, 
 "Jim Shu" <jim.shu@sifive.com>, 
 "Joao Martins" <joao.m.martins@oracle.com>, 
 "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>, 
 "Luc Michel" <luc@lmichel.fr>, 
 "Manos Pitsidianakis" <manos.pitsidianakis@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>, 
 <matthieu@minio.io>, "Max Chou" <max.chou@sifive.com>, 
 "Mark Burton" <mburton@qti.qualcomm.com>,  "Ho, 
 Nelson" <nelson.ho@windriver.com>, 
 "Paul Walmsley" <paul.walmsley@sifive.com>, 
 "Paolo Bonzini" <pbonzini@redhat.com>, 
 "Peter Maydell" <peter.maydell@linaro.org>, 
 "QEMU Developers" <qemu-devel@nongnu.org>, 
 "Roberto Campesato" <rbc@meta.com>, 
 "Richard Henderson" <richard.henderson@linaro.org>, 
 "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>, 
 "Bernhard Beschow" <shentey@gmail.com>, 
 "Stefan Hajnoczi" <stefanha@gmail.com>, "Thomas Huth" <thuth@redhat.com>, 
 <utsingh@redhat.com>, "Wei Wang" <wei.w.wang@intel.com>, <z.huo@139.com>, 
 "LIU Zhiwei" <zhiwei_liu@linux.alibaba.com>, <zwu.kernel@gmail.com>
Mime-Version: 1.0
Subject: Re: KVM/QEMU community call tomorrow - agenda items?
Message-Id: <951ba9d4-e3b4-4205-ac87-a92afe302a6b@lanxincomputing.com>
Content-Language: en-US
References: <877bl6eoqv.fsf@draig.linaro.org>
 <413b9ba2-20cf-4af6-9998-be46da277c84@lanxincomputing.com>
 <48cef34d-18c1-4b8c-a75d-19d1d1321634@oss.qualcomm.com>
 <apW0SkNxWPCyvVV6@x1.local>
Content-Type: text/plain; charset=UTF-8
To: "Peter Xu" <peterx@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 10:12:37 +0800
From: "BillXiang" <xiangwencheng@lanxincomputing.com>
Received: from [127.0.0.1] ([123.120.5.129]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Sep 2026 10:12:41 +0800
Received-SPF: pass client-ip=209.127.231.28;
 envelope-from=xiangwencheng@lanxincomputing.com; helo=va-2-28.ptr.blmpb.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
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

On 9/1/2026 1:05 AM, Peter Xu wrote:
> On Mon, Aug 31, 2026 at 05:46:12PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> On 31/8/26 13:49, BillXiang wrote:
>>
>>> How about discussing the patch[1]:
>>> "virtio: Add aligned ld/st accessors for vring".
>>>
>>> As pointed out in the patch, this has been a long-standing issue. It is
>>> now necessary to introduce atomic accessors for fields that require
>>> atomicity, such as the avail_idx field in virtio. This support is
>>> especially crucial for architectures like RISC-V, which do not natively
>>> support misaligned memory accesses.
>>>
>>> I'm particularly eager to receive more suggestions for it.
>=20
> I saw the last email was from me..
>=20
> https://lore.kernel.org/qemu-devel/aoxiBB2Wn8NiL5s6@x1.local/
>=20
> I believe that was what PeterM suggested. I think Richard also at least
> partly agrees. so I thought we had at least partial consensus on the roug=
h
> idea, if not exactly how.
>=20
> I confess I haven't fully got the latter part of Richard's comment,
> regarding the possibility to reuse accel/tcg/ldst_atomicity.c.inc: that
> path seems to invole a guest CPU context, where in the case of reading
> virtio ring it is from host and it has no guest CPU context.  But I think
> we can continue the discussion on the list in that thread.
>=20
>>
>> This is a very technical topic, not sure if the community call will
>> be a better place than the mailing list, in particular if no virtio /
>> atomic expert developers appears. We'll see :)
>=20
> Yes, I had such similar feeling that the problem was not yet blocked by
> something that a video call would better help..
>=20
> For example, I still want to double check if that change would work for
> your current use case, it will at least verify the thought, no matter if =
we
> want to use it or not.
>=20
> Thanks,
>=20

Thanks for your reply. Your change works for the virtio use case. While=20
waiting for further comments, I've also gathered some additional=20
information. Let's continue the discussion on the original thread.

--
BillXiang

