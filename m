Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034AEC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9M42-0005B4-Tt; Wed, 23 Sep 2026 08:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x9M41-0005Al-5i; Wed, 23 Sep 2026 08:27:05 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1x9M3z-0007wX-70; Wed, 23 Sep 2026 08:27:04 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 69C04583223;
 Wed, 23 Sep 2026 14:26:58 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LyRLX1niaOFt; Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 576AF5831F1; Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5492F5831F0;
 Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
Date: Wed, 23 Sep 2026 14:26:56 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Amit Machhiwal <amachhiw@linux.ibm.com>, 
 David Hildenbrand <david@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-ppc@nongnu.org, 
 kvm@vger.kernel.org, qemu-s390x@nongnu.org
Subject: Re: [PATCH 04/88] qom: auto-terminate interfaces array in
 OBJECT_DEFINE_TYPE macros
In-Reply-To: <20260923-nohmp-v1-4-ebc029d4bd80@redhat.com>
Message-ID: <86b86d86-b2f8-2569-8754-0a229efa9364@eik.bme.hu>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
 <20260923-nohmp-v1-4-ebc029d4bd80@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-633698529-1790166416=:75141"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-633698529-1790166416=:75141
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 23 Sep 2026, Marc-André Lureau wrote:
> The DO_OBJECT_DEFINE_TYPE_EXTENDED macro requires callers to manually
> append a NULL sentinel to the interfaces list. Forgetting it causes
> out-of-bounds reads during type registration, leading to run-time
> crashes.
>
> Append an empty initializer in the base macro so the sentinel is always
> present, and drop the now-redundant manual terminators from all callers.

This is nice however another similar common list, the TypeInfo.interfaces 
still requires explicit NULL termination and now these are inconsistent 
which can also lead to people get confused where to add NULL element and 
where can it be omitted. Maybe we should consider adding a macro to make 
interface lists that adds the terminating element and use that everywhere 
or just stick to require explicit NULL at the end of interfaces list 
everywhere?

Regards,
BALATON Zoltan
--3866299591-633698529-1790166416=:75141--

