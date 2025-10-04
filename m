Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5811CAC5BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wbg-0005XQ-Ku; Sat, 04 Oct 2025 03:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4wbe-0005Wb-8s
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:23:02 -0400
Received: from p-east3-cluster3-host9-snip4-1.eps.apple.com ([57.103.86.84]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v4wbb-0006Ee-Ig
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:23:02 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 6F6C71800128; Sat,  4 Oct 2025 07:22:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=jWl0rRljYnmnjT52LiUJwIZF+Ely2UsaP7+2W3Dmhvk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=eikdPH0I/WSEsRh2Ezz6J3jzVdBG9HBT2/R6yztH5jMEBGvYa6cT3gObE6pENW83KrMAlRUBDHGB2kkGRwVxdLL6dAYa1sicQgPyKWmkrQTPL3y/QYnfgl4d7MaQsxhDnHkLlfScQDDMD1BQMpYWX9A4SatujviM7I2k2GE7/PUv/pcJ2zjTaWfodrtJB5Zb52U2JHQuCxVAzebGKO33nAXCQe/PL7PMUZN6kSyBsZNuR2C6EAxanvUJSImJCqzd9bTUo/IGDgn27cl5+F4YNs3rFgeFyLWi5uMdIMP+HERnUbJwMcXLp9+Y50Skhg1+5WZ22Tle2eDCugRyda9JmA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 C1AE118000B1; Sat,  4 Oct 2025 07:22:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: Reg. guest unaligned accesses in TCG
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
Date: Sat, 4 Oct 2025 09:22:40 +0200
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08EF65B7-ACA6-4AE7-802B-FDEE324CDE4B@unpredictable.fr>
References: <CAJhHMCCfOqP6E2XvkY5JNtgQrXXH7uV_y9wfLcYFh9kecgocaQ@mail.gmail.com>
To: Pranith Kumar <bobby.prani@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA2MiBTYWx0ZWRfXzaFKjEeQxXs/
 YfjzJ8a4d1H/dcLuDuIODBqrsbFoRMNDsWaayiIIISDPRQ9KV574WSHTON/R5wnDwxMh01vKdrT
 lb4SAh1kFF7vZONY3R6ewe/KqpWWUX0Eky1UhuPmdyi247xdNvEAHAEezQ+N/9Dr+io4GzcA3Ki
 x2ehwmSi5GA3PFCJzSUguFVZxJIefZJ+OgTR1Zk6yxUTanHGtyTnGlIdgrIdOyAH1wsNHUwGAMw
 tBbOo3OlU5WezwWZ6Cj5+lDIlAvvqW+fga9OO7bCMneqgsTH3sGJkMMHY+iVsjaSpu3dgokgk=
X-Proofpoint-GUID: ODqg9-ryVer906JWdPTBqEX2f5zfWo_v
X-Proofpoint-ORIG-GUID: ODqg9-ryVer906JWdPTBqEX2f5zfWo_v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_07,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 clxscore=1030
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510040062
Received-SPF: pass client-ip=57.103.86.84;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 4. Oct 2025, at 08:34, Pranith Kumar <bobby.prani@gmail.com> wrote:
>=20
> Hi Richard and Alex,
>=20
> I am trying to implement efficient x86 guest on ARM64 host
> virtualization where the host has FEAT_LRCPC2 instructions. If I
> translate every x86 load to LDAPR and every x86 store to STLR, it will
> meet the memory consistency requirements.
Hello,

If you=E2=80=99re targeting Apple chips, note that RCpc is really slow =
on those
as they expect you to use the hardware TSO mode instead.

But to get TSO mode on those you=E2=80=99ll need to use HVF=E2=80=A6
> The necessary condition for using these RCpc instructions is the
> alignment. The manual states that alignment fault will be raised if:
>=20
> * Not all bytes of the memory access lie within a 16-byte quantity
> aligned to 16 bytes, and
> * The value of SCTLR_ELx.nAA applicable to the current Exception level =
is 0.
>=20
> How does TCG check for alignment? How do I check if the guest memory
> access is within the 16-byte alignment? Will alignment fault be raised
> if it is not?
The hardware will raise an alignment fault in that case. Other emulators
then do backpatching to a barrier-reliant sequence in that case.

> Any pointers are greatly appreciated!
>=20
> Thank you,
> --=20
> Pranith
>=20


