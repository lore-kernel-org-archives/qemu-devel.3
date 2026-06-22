Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA45CDB471
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:12:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbhFw-000205-Dm; Mon, 22 Jun 2026 12:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wbhFt-0001yT-TL
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:12:14 -0400
Received: from mr-2005k-snip4-11.eps.apple.com ([57.103.71.13]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wbhFs-0000Jx-HO
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 12:12:13 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id
 71B17180013C; Mon, 22 Jun 2026 16:12:06 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhPAEMDWhxBD0kdXAFeEhVdRV4FXQpRH1sLXAN3BldeWhdeTVEPDx1cVlACWktAEwRPEwVSB11NVg1HD1geXBQXFUFDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXBzILSXVZdC4fQAtLckADW3BJFDoALHNGdEd7SnJdBCgGQAxMcwBSRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782144728; x=1784736728; bh=dN26ZtRyPYiBeSi5uFsBv0DsXBo0G+WRZj0OUQYm5MQ=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=qOB3Tu0xpTJ8+BXuqEMcloEjTljtUK/YS5vlwga3f/Pc17nusW528E3NBrRCNzNdEsMRwvZqDMYPznN2DVIzuOunRMkxbZvdiWmN42N900ExoM6DDm151+M/mM1VFZu432qCr5xR9SLvSwmbGHs2RqMmn6jExn1YASFbG9aCbqyHYznek8zTg6rToBJSf+qW0XHBvsf2pRVd8ZA0Xh/wpb8wh/fSWxe+zcy7TKTf6zkmE+QbX8Z02poKVeLT0AWc/OETTFXpjTJ8AXAwPx5lPtUyoEXZqh1b/VxJZKXqKllkAB1BrVv69RxZgYKvrtCiCIxbhrKRQIyzvqv9EVsEgA==
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id
 2E2711800096; Mon, 22 Jun 2026 16:12:05 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <b11f77bf-68e7-47f8-9c39-612edcf45467@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 12:12:02 -0400
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B21F4CE-023A-40B9-B3AD-F7B2A03C4054@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
 <b11f77bf-68e7-47f8-9c39-612edcf45467@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2MCBTYWx0ZWRfXxlpsnLxCDRsq
 avFtt9qOfDNdv39UFEmkuUc56EsrQJ7Ii06As2yOOBhYomG7RL+++KWeEClAQCOQJuD3B4DCKfd
 mYd6Ge5H9abDZKZ8AVr4MGEHKqw4JFUVt5mlJYQcZiuRGR6apAD7qXtcQwRS+SaNyBrw2qYEd+h
 caStSaZoC8QGAJsLLvzKhSp5bjvT2Pgq121zzGwmcifgPz0/5yXMbN13tAYso6MSSynq9xEPrDR
 bT0UtCC4W+toMy2seTK99np6YwEM4npjzMN5fVFHK4FbPjmjfcV+DjvNwvdBhQ+L7wUIwCY40IX
 Z1idDjB4DredAUMukxT
X-Proofpoint-GUID: ryXDKykquBIacKcScS0KWvjmPQ0hkFQy
X-Proofpoint-ORIG-GUID: ryXDKykquBIacKcScS0KWvjmPQ0hkFQy
Received-SPF: pass client-ip=57.103.71.13; envelope-from=mhjacobson@me.com;
 helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Hi Philippe,

Thanks for reviewing.

> On Jun 22, 2026, at 3:57 AM, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> On 18/6/26 01:50, Matt Jacobson wrote:
>=20
>> +static inline uint32_t fifo32_peek(Fifo32 *fifo)
>> +{
>> +    uint8_t bytes[sizeof(uint32_t)];
>> +    uint32_t ret =3D 0;
>> +    int i;
>> +
>> +    fifo8_peek_buf(&fifo->fifo, bytes, sizeof bytes);
>=20
> Could this work?
>=20
>       fifo8_peek_buf(&fifo->fifo, (uint8_t *)&ret, sizeof(ret));

I don't think it would, at least not without other matching changes.  =
The existing fifo32_push() and fifo32_pop() routines explicitly =
store/load the bytes in little-endian order, so a single fifo8_peek_buf =
would not work on big-endian hosts.

The rest of your comments are well-taken; I'll include them in v3.

Thanks again,

Matt=

