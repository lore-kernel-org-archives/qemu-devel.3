Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90512C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2026 04:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdgvs-0000ZA-Dd; Sun, 28 Jun 2026 00:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wdgvq-0000Yx-Fu
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 00:15:46 -0400
Received: from ms-2001g-snip4-8.eps.apple.com ([57.103.73.199]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wdgvm-0006Zo-Hq
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 00:15:45 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPS id
 EC5881800127; Sun, 28 Jun 2026 04:15:36 +0000 (UTC)
X-ICL-RepId: 019f0c70-a5a2-783c-85b8-3e80fad613df
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQhPAEMDWhxBD0kdXAFeEhVdRV4FXQpRH1sLXAN3BldeWhdeTVEPDx1cVlACWktAEwRPEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FXggZCF0dGRVaCQpXB0F/QHdfcVofRA1BB0ADWnFDFEEGXgdGC0gLOQpZclgDM308cwBSRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1782620139; x=1785212139; bh=TaFuMmZKlH0+z+LNFB485NvaV3VZvduNNbNywBC+Zi8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=SsZV+s4AHLHeLA8TUpYiS/XdYcAxduXGNvnu+YLud54McVQwD+h4FpaTewJUVmsSXK9GDz+9nSn+KxuyUNnaIqm6Wvo+bFwVJmzMgyh7mRbVETGiSd/X5Y5qBcY+z0JZIsKhrDS1+hNB25BY6FrT2fmu/ijfLf8ZmuG+IMs2ZzK5Sgvzl5hhqg/liRpdEde2HZ/eNuS1/1KuHncQ2oSrU64q3HVA5QcRiwF2sDjoCAQpSB95GX0AHrsINDzkXE4tA8N59UVJfn0WAEMc2VIxddaeAvxXgDMXxYeIDjgbWKnpbIKyurntCT0P5lATD0jCFApik+cOZV/h8nTVohKj7Q==
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-100-percent-6 (Postfix) with ESMTPSA id
 865EC1800123; Sun, 28 Jun 2026 04:15:35 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.10\))
Subject: Re: [PATCH v2 2/5] fifo32: add fifo32_peek()
From: Matt Jacobson <mhjacobson@me.com>
In-Reply-To: <CAFEAcA86dxpB8Tj805e185yiFCp9eE_Y4MeHJAAwdGq+uYP3zw@mail.gmail.com>
Date: Sun, 28 Jun 2026 00:15:32 -0400
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <51F8D2F1-4494-41C3-9530-982A94E31CDD@me.com>
References: <20260617235032.21491-1-mhjacobson@me.com>
 <20260617235032.21491-3-mhjacobson@me.com>
 <CAFEAcA86dxpB8Tj805e185yiFCp9eE_Y4MeHJAAwdGq+uYP3zw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3696.120.41.1.10)
X-Proofpoint-GUID: 07YN3UPxn9hIJQlFl7wttm7Pm0842iOo
X-Proofpoint-ORIG-GUID: 07YN3UPxn9hIJQlFl7wttm7Pm0842iOo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDAzMyBTYWx0ZWRfX/bPDBepehVdA
 tj9pJMMSAq3BoCE+YgRxkaOr03q9vbChCDaNGKfZ4Kug2zpiJigdEsBzsz5zuitx9nTYv2K/p4X
 MyohnrJFqITm/0A83AreHzX3YlK2T8WhCjfBCu/NymgjhREkEcdTChETwyvayTnlY8P8tcExWyj
 XvUy0xvEvs3YXx0PTZ5ZARDTOIStJFul8D9pBR9+tYyzE27TME5dG7/Z1AUmBliCYN5gvWOUNZs
 09PeHPcJNoiCtJk+n5SANjLyuhigJpBprw4Jy8xhqcH8r/pQVpdC7V43ZylC9fNF06rkPa3gHVL
 mC8GSnS6JUI9vd3VpgM
Received-SPF: pass client-ip=57.103.73.199; envelope-from=mhjacobson@me.com;
 helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> On Jun 22, 2026, at 12:47 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> fifo8_peek() assert()s that we have enough data in the FIFO
> to peek it. fifo8_peek_buf() doesn't assert anything, it
> instead returns you the number of bytes actually read. I
> think to make fifo32_peek() consistent with fifo8_peek() we
> should here have
>=20
>    uint32_t read =3D fifo8_peek_buf(...);
>    assert(read =3D=3D sizeof(bytes));
>=20
> This will also avoid code analyzers like Coverity complaining
> that we failed to check the return value of fifo8_peek_buf().
>=20
> <...>
>=20
> This bit can be more simply written as
>=20
>       return ldl_le_p(bytes);
>=20
> (which says "load a little-endian 32 bit value from this addr").

> On Jun 23, 2026, at 4:54 AM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> Oh, a trivial style nit since this needs respinning anyway:
> we generally prefer[*] "sizeof(foo)" over "sizeof foo", which
> also matches the other two uses in the file.

Agreed on all points.  I'll include these fixes in v3.

Thanks for the review.

Matt=

