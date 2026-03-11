Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D16761125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LYH-0000Yf-Kk; Wed, 11 Mar 2026 11:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LXV-0000QP-6E
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:32:05 -0400
Received: from ci-2005f-snip4-1.eps.apple.com ([57.103.89.182]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LXR-0005CK-Ub
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:32:00 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPS id
 446C1180010D; Wed, 11 Mar 2026 15:31:55 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773243116; x=1775835116;
 bh=nse4g/ZmK9a93cOTpyOjjHmt5RCHFxzRR4AAevaqPRE=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=cgWHb8kT9USGXAuyuFizBp6V/DSkbir7fO3VL4jNM4hP5+nVqwFA7Uh8Ufdt55LNP/SVtqJgi+xW25a5s3S/WTvdn1tGAJmdJqY5lEvZ120jAXjtOZkXh1ROJV6eQcXWj60FK5vYvGT2DuVnLSpyU7LyuWoW6l8j0yZFKdwmIVJm7P3syNg64STd7Ydkzj++IlWadL5tkEc+AuLqw5Pl+t0fTAepVT05FjMGLrWrqHC1iKCmoJzeLi+HR57AZHfZO1mL4eiGJgOwcn/NKvatt/FILxOFk8/oaWlqb/QSGNNWE2Ijh9fYsxMcWJQkhQzsYoSYTjeeifqb3FbbuDcFLA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-13 (Postfix) with ESMTPSA id
 B7D59180013D; Wed, 11 Mar 2026 15:31:53 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v2 9/9] accel/mshv: disable la57 (5lvl paging)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <abGHbalv5UKNj8F8@example.com>
Date: Wed, 11 Mar 2026 16:31:41 +0100
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FCD2D66-8079-4F65-A85D-473F78FBC1D4@unpredictable.fr>
References: <20260311113505.1177878-1-magnuskulke@linux.microsoft.com>
 <20260311113505.1177878-10-magnuskulke@linux.microsoft.com>
 <2D1F935F-865A-4B24-B616-BEE57B22FB2B@unpredictable.fr>
 <abGHbalv5UKNj8F8@example.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.400.21)
X-Authority-Info-Out: v=2.4 cv=Xqn3+FF9 c=1 sm=1 tr=0 ts=69b18aeb
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=hEA-IkUmpG_o9_Koa4AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3Tt-tZPEChQbWSDRhPOHlollA1rfXW0T
X-Proofpoint-ORIG-GUID: 3Tt-tZPEChQbWSDRhPOHlollA1rfXW0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzMSBTYWx0ZWRfX2uDHykBeFnMC
 HDXYn9SbDvDZ3cWokzKLpQRvHcfa7mp7yh6swlpw/koKTUj83l0NaKjZkGQso+wxbIBnGOYr+4v
 4pzZ5rzTFGxjptfZjA5ZmzvVqtRkLV7xQjFhHxwHIrtWfBERHv0rbTTJZjA5X1pEytrOmm0GRXP
 bj00wWe8stdynFUJOwGK3glni57eRTSTUOk1zurZ206HOSZWEVN9xO4H5mXghb5EZcRPLf1YT8/
 n+ON6nGASZgBF0RHeLxogcjjZrmieI8fvEcuN8xlxhcK6HFHPLPAvmL7z+03u9+OBrRgDvaME8A
 N1glxOqxVUPfSwkyXIrAIDk9i6d6VKxrNrPyZALbAtKqSzee6XfZriXBRL0rGE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1030 spamscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603110131
X-JNJ: AAAAAAAB/xA7+UKLF3DDeMhUXT6lWpak6Jbr/2F4wzJR1Ad04PsaFoIDvSeAV7MwkBJN0SoB4w8kTj+uQfj7dTXL/0/rLghN2DUgok2kIVJpf7btv7+oK4/U1O2LU13kvA8StKd1z15W3IvXOgAR3j+Yq9+tyztktf6qei53RlBVaz091eamZnP9DjQvBjY6AqLSdwoELriOlv/TawDE7uBLhY7PQLHkIx/WQtApFL0fiNWepXw+8/8IIBK2JZX/gjRVxVKQd9Oj9WmoybNp2n3Xx1Tg0nSkwvoTBay1bVPjmZ52UGEzO4lH+i7Tb0uspiJtJvfTk0ssuGKiXkicfOr3GWl8D3Ty8ZfqSVe8W9hJNMed79QxECpEURPpqDOkdiDpWEdKNF36Z0wtH6uyM1pju8EOiFEjdHaTeQ6yvSp2K1aBGfC+StLrjlduV12IpAGc3rQc0TC3H8uGqOTlpBI+4N11ug6R1tIMsZXoJQLCuefXSLJYZ8igStNKDIuiuTO1GZj2XG+ENagMt/kLPNM5XWOPMg6le9Z38MD1d4jMTCSNSp/iD8iMMNijnzcJDWAzYRfBUm/MSQy/XNl+DqDTR0T1Yaqs1zg5++EPd23lFNqlhiiXH1PKbki9m8u9sjy/+2pmR6c0kq/QfpLWHWjB/BBTYvqom3VMBbdRc++obattiYw7audYU4ox86KRtzfGuNRi5g==
Received-SPF: pass client-ip=57.103.89.182;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 11. Mar 2026, at 16:17, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> On Wed, Mar 11, 2026 at 12:54:12PM +0100, Mohamed Mediouni wrote:
>=20
>> This should already be fixed on master since yesterday. Can you repro =
this?
>>=20
>=20
> Hey Mohamed,
>=20
> if you refer to "cb02fc2284 target/i386: emulate: LA57 fix", I don't
> think that was sufficient. It addressed a stack smashing issue, but =
the
> guest would still run into MMIO problems on la57-enabled hw.

Hello,

Thank you, I=E2=80=99ll test this further. Boot-tested it on an Alpine =
Linux VM but looks like
that wasn=E2=80=99t enough...

FYI I added a new callback interface in x86_emul_ops (mmu_gva_to_gpa) to =
support
adding the Hyper-V page table walker, but if it=E2=80=99s anything like =
the WHP one it=E2=80=99s going to
be very slow=E2=80=A6 which is why I moved to the new interface in the =
first place.





