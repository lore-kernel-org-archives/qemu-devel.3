Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55400ECD6F9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 23:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqJQm-0007xZ-FH; Wed, 11 Feb 2026 18:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJQg-0007wz-CA
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:15:34 -0500
Received: from p-west1-cluster5-host1-snip4-2.eps.apple.com ([57.103.66.173]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vqJQe-00010e-3B
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 18:15:30 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-14 (Postfix) with ESMTPS id
 0A6EE1800659; Wed, 11 Feb 2026 23:15:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770851725; x=1773443725;
 bh=XDQGjOiYIYBJKHMr1XO3mJ8sniPla/PBhzJ0NkxdApU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Z+XnRNIBP1ul5ouDB6Wj9RegUGsovZ9ahrz/HGT4/z7NkJIwFYJT/n9y6iaroESK60k7yMggFDwqca3Z0222Li2fFVAxd3LAH6KAbOA7vu0xnrrnbzT+/8hryxC15WNxViXwQy9wmLJP9tLjFmPs2SWtroR6z0NmZTKH9JEE4denoYdHdskn7bJBIbQF5kHtST00F4Mh1aurJRmnlM8ZNHnbmue5aFm1dQ6KUaJmovL4ZCvUju8tvNi+EuiQQsvWUOW0be0l0eoIBazQXfx1JIp9OOGhI7tTzlbVQ5qs4pm89qecxQDuuGhJ4PdwpUh565aqSHBE1HeabrSn8TEY7A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-14 (Postfix) with ESMTPSA id
 96BDA180065A; Wed, 11 Feb 2026 23:15:21 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH] hw/arm/virt: Add virtio-transports property
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA8qtxXP0Uawc+UdSYmpuC8wmpSVkjnYQ_jDQe6zTuNWpA@mail.gmail.com>
Date: Thu, 12 Feb 2026 00:15:09 +0100
Cc: Mohammadfaiz Bawa <mbawa@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, alex.bennee@linaro.org, philmd@linaro.org,
 cohuck@redhat.com, eric.auger@redhat.com, sebott@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <D5033059-0647-441A-BB8E-91CB6E9DBD3B@unpredictable.fr>
References: <20260211122759.125094-1-mbawa@redhat.com>
 <BE3C6640-85CB-437D-A038-81762FA5AD33@unpredictable.fr>
 <CAFEAcA8qtxXP0Uawc+UdSYmpuC8wmpSVkjnYQ_jDQe6zTuNWpA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDE4MCBTYWx0ZWRfX10J8Ylwao6jq
 pq3CgDAP+aKFLD5A7o4VOD3KrmkyJUg0JAiHEgnGywrfVLlwEFdWYrR7EpjdqO2JguBPB76qr6u
 2fzihC4Rr05ycWer9ZNezk2ydjnVCIED3ofXOFQvcAxP6quEOEFo72EeOYfwvbaSsa0lTyJ0KsH
 WAi29ytuOHxOMs5Cbb+zlyqu5EIPQ52B6RiASwRv0LS30ccEZuSrmJzBGY7ooOcfM9X2Ga/Wc/R
 U3oP5zZMUot5FxiY+Skz18jTtaDjSbb0HxmHTnGQACOywrtEfPA4BzN2OkCh9nCNRdHDCLDbicS
 pohw17KbOotn5tkwc+WHrC4B0ccfOxYq8+6BV8FKNc+BJsuuG95CVY7c5ytuGQ=
X-Proofpoint-GUID: yaxHdiscOkr-zKUPUyachyJHppYUChz5
X-Authority-Info-Out: v=2.4 cv=L7UQguT8 c=1 sm=1 tr=0 ts=698d0d8c
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=NEAV23lmAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=kK5MzHQlxg5x93d8jmwA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yaxHdiscOkr-zKUPUyachyJHppYUChz5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_03,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1030 suspectscore=0 mlxscore=0 adultscore=0 malwarescore=0
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110180
X-JNJ: AAAAAAABZIZehYz5il0f/5bHWJtQLWfL/sryhlXydN6+Nt2L4jCxuKegU1Q9Fv/U5X4ZvjLN/ky9eGuz+O90oFNiUSVXDjRjvunehT8kVMoPUCCnY+csu7oiHDHH+QOEt3uWJHJIpXkDs337U42BEQ2jNg8cBPMlGTtog3pZE+ttVezhrsI9GiXUgIxTChQHmXUZBrc/GYilJI+YUAQ77eyXLYfev0J3k8I7DlR6Vcofn8UfUtBabg/iDD/H+w8UGD/FjP+udtOzC8A77y1vhSxHQg0LfboDFY6OAUwUJqvpNy86waQRltcvOuzlUnKIKKghjE3xdGvtG4ft+DRB5OHhML9FJJDYwEDpYPqhG0EfV4JoRJE5SYvp0/4M1OVdlfKLWTOAfmB09czCauWhFjw7ymBUhwLkW+TUHTEHl+m1tuInUEq/tHLCGzv3bw4XMcYJI8gkWG0Qo/rFofwBcaV4TYojg+M47rcP9h0Y/me7wREJOaNt+7j0qt0r9FAlJskm3bjNfMjmdcZRmGg90CjSUbzFTgZcXPXZ/RT0Vf34jMmvcKg+6aNZo7F2X5fhdAjGIo86WsmDIRL364ToDjhTFhWDsN8Yb8OlgiB0q1XsFuOhXuqX6SyJLghQ1Tm9XT+UMzOZLCjuEGRfAuEQNt7fPK8t0wpMtcME5olvHGQM3xcyX1tSwNTe61rJPXAb/xA8E14tu1Um
Received-SPF: pass client-ip=57.103.66.173;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



> On 11. Feb 2026, at 16:08, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Wed, 11 Feb 2026 at 12:50, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>>=20
>>=20
>>> On 11. Feb 2026, at 13:27, Mohammadfaiz Bawa <mbawa@redhat.com> =
wrote:
>>>=20
>>> Windows ARM64 guests detect virtio-mmio devices declared in ACPI
>>> tables even when no backend is attached. This causes "Unknown
>>> devices" (ACPI\LNRO0005) to appear in Device Manager.
>=20
> Is that a problem? There's a device there, and Windows doesn't
> support it, so it reports that there's a device there that
> it doesn't support, which seems reasonable enough.
>=20

Hello,

For customers, some security software gets quite unhappy if it sees
that there are devices with no drivers installed.

For development it indeed doesn=E2=80=99t matter.
>>>=20
>>> Until Windows fixes that by supporting, adding a new machine
>>> property 'virtio-transports' to control the number of
>>> virtio-mmio transports instantiated. The default remains
>>> NUM_VIRTIO_TRANSPORTS (32) for backward compatibility.
>>> Setting it to 0 allows users to disable virtio-mmio entirely.
>>>=20
>>> Usage: -machine virt,virtio-transports=3D0
>>=20
>> Hello,
>>=20
>> With keeping in mind that this was documented in this (closed=E2=80=A6)=
 issue
>> https://github.com/virtio-win/kvm-guest-drivers-windows/issues/595
>>=20
>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>=20
>>> +    if (transports > NUM_VIRTIO_TRANSPORTS) {
>>> +        error_setg(errp, "virtio-transports must not exceed %d",
>>> +                   NUM_VIRTIO_TRANSPORTS);
>> Any particular reason to (keep) capping the maximum to 16?
>>=20
>> =46rom a cursory look, base_memmap seems to have room for plenty =
more.
>=20
> My first question to anybody wanting more than 32 here would be
> "why are you not using virtio-pci" ? The whole virtio-mmio infra
> in the virt board is only here because at the time we had no PCI
> support.
>=20
Could it make sense to have it disabled by default for new machine model =
versions then?

Thank you,
-Mohamed=20
> The advantage of this series to me is that it means we have
> a way for users to say "I'm not using this functionality,
> just turn it off completely" which lets them reduce the
> security surface a little.
>=20
> The other thing worth checking is whether we're correctly
> following the ACPI spec in exposing virtio-transports with
> nothing plugged into them, or if we're supposed to be
> suppressing them.
>=20
> thanks
> -- PMM


