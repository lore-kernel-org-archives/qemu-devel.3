Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38611061B0F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 16:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Fo9-0002Yi-Gu; Mon, 30 Mar 2026 12:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w7Fo0-0002Wl-17
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:49:37 -0400
Received: from ci-2006g-snip4-11.eps.apple.com ([57.103.90.201]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w7Fnv-0003Ko-To
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 12:49:33 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-10 (Postfix) with ESMTPS id
 018E61800169; Mon, 30 Mar 2026 16:49:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774889365; x=1777481365;
 bh=QD+ZefaqxbGHLuNSknPSMW7y3d42Wk1UUlLO+LdNqn4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=B7nn9LkDHLtiU1Gnz+lXIfGur1MUi/UCfOz2dADTMoZ4rEocjBTuG4otPcrarJkNUKlAfxhnjLqu2tZLKYJU3MhQmtvURC9d2hevTY8LemwJQ38A/G1l6HqRiJVzJtUNlsgTCJnz5rext5xSUJ1Hz0m0aM7hYZq0y8ivaPQ8uL9KXlKbIolRVmHc+daxZKAazypB9tx9hzvKZb7V9I27QqTV2LOwtjFBH+oc0tVoP+PzgcMPnx7H/0wwffLL/rOjgA17B7lRlJQbxZ6lh4PhU2bonJU6b9ZNIaIN61zeUT4aeGFU8fcKGAl+BKE3nFaD2U86YDMTFL4Rb24srjzADA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-10 (Postfix) with ESMTPSA id
 69FFF1800178; Mon, 30 Mar 2026 16:49:22 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH] meson.build: Add --enable-use-pdb option
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <b7d47483-167a-48bf-b494-87b2f7bfbe69@redhat.com>
Date: Mon, 30 Mar 2026 18:49:10 +0200
Cc: Steve Aarnio <saarnio@qti.qualcomm.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CCFA763-8BF1-4975-A758-F480BD9D314C@unpredictable.fr>
References: <MN2PR02MB6622718572E2A2B5E4EE3C039B4EA@MN2PR02MB6622.namprd02.prod.outlook.com>
 <b7d47483-167a-48bf-b494-87b2f7bfbe69@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: uqvK3fk1DjWE8aQ_xBzoCj2bbpMXQT2j
X-Authority-Info-Out: v=2.4 cv=C9DkCAP+ c=1 sm=1 tr=0 ts=69caa994
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Twlkf-z8AAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=u95PIktiEcSF7GJu_fMA:9 a=CjuIK1q_8ugA:10 a=-74SuR6ZdpOK_LpdRCUo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEzNiBTYWx0ZWRfX5hptgcuSOtvd
 5KXs9EnUppfZZafez+rE7dYJcbmEYD+hdYl1Xh2CQnowNvDB7b78QFHzt8/0qjNQq1uo99JEEBe
 P1xywDoNPBpuneG1HfMGiWSI0fCUHIsralfvhvqPpW51eamfeT1CGbF3HePyxHH82a8ovPWmeBV
 pBMXc0QYC9OxjMjnJYWHxAr7vsMZvqDFy8SfWSbqFAD3oNRxfGfRHsGknMGW1+5D+/v8AFDULQY
 es21Or5eU83HOajVfdSfYZZHcmW0Qs+mnvUOzZlP5p0J9YYpQOWdbIVbX6XYxaWuyEwvovZLbaU
 cWM0viVbv4U4/XSkJJbioF0smMUz7iOTRaVnQDz7SX2c27+mXr6XYAj/rdA8m4=
X-Proofpoint-ORIG-GUID: uqvK3fk1DjWE8aQ_xBzoCj2bbpMXQT2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=761 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603300136
Received-SPF: pass client-ip=57.103.90.201;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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



> On 30. Mar 2026, at 18:33, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 3/18/26 20:18, Steve Aarnio wrote:
>> This option will (attempt to) modify the QEMU compile and link flags =
to
>> emit PDB symbol files rather than the standard (DWARF?) symbol output
>> from gcc/clang.
>> This enables using native Windows debug tools (Windbg/Visual Studio) =
for
>> debugging QEMU.
>> Signed-off-by: Steve Aarnio <saarnio@qti.qualcomm.com>
>=20
> I would prefer to have support for this in Meson itself, but anyway, I =
have some questions below
>=20
>> +if get_option('debug') and get_option('use_pdb')
>> +  qemu_common_flags +=3D =
cc.get_supported_arguments('-g','-gcodeview','- =
gcolumn-info','-fno-omit-frame-pointer')
>=20
> GCC documentation says -gcolumn-info enabled by default, also who is =
enabling -fomit-frame-pointer so that you have to drop it?

Hello,

=
https://clang.llvm.org/docs/ClangCommandLineReference.html#cmdoption-clang=
-fomit-frame-pointer

Clang documentation says:
On many targets, -O1 and higher omit the frame pointer by default

>=20
>> +  qemu_ldflags +=3D =
cc.get_supported_link_arguments('-g','-Wl,--pdb=3D')
>=20
> What linkers support --pdb=3D, and what goes after the equal sign?

lld, and pdb=3D is enough to have an autogenerated path (output[.pdb]).

gcc and GNU ld don't support this.

>=20
> Also, the update to scripts/meson-buildoptions.sh is missing, just =
running "make" will regenerate it.
>=20
> Paolo
>=20
>=20


