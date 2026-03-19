Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B80109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:51:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ISH-0002fZ-BF; Thu, 19 Mar 2026 14:50:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w3ISD-0002eB-3U
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:50:45 -0400
Received: from p-west2-cluster6-host11-snip4-1.eps.apple.com ([57.103.70.104]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w3IS9-0000rS-Q4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:50:44 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPS id
 DB64F1800556; Thu, 19 Mar 2026 18:50:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773946239; x=1776538239;
 bh=krxHIbtBMSe2MifOiFUaIGaMiVhfvzQgriXMvtUJR8k=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=A2SnyOaGEZUOVmoGPbB8Sw/W+YoxgXLDgrfsddLor+y3t4BuyY00u5+wnBFiiR/TUjIZ1gGKDXwKnwLphU/eV+lOH4vZF5PbPqym5EiFWE56TpOWJ+fXqczFdC3DkiXQml53VcTKOo26bunMTzRUmdHtYK9R0pMlnk/4nkBToGNW+aOqSwRO/lNw1Y7RSavY9VsjbxJjc6lyLiZfi4DryOmUBAPkM0Xee5dwtBs9XzvVuWuTaMBPBA5iXWKlxFN86aQH74S/k/FbO6s3H4RAi7mZmxEoAjjvO6ov2stbM7+mkmomsT6ggnFr6c2msq/gNl63mfbOpvwE6iUNh2fMwg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-7 (Postfix) with ESMTPSA id
 52EEC1800429; Thu, 19 Mar 2026 18:50:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v3 3/6] whpx: arm: enable more enlightements
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
Date: Thu, 19 Mar 2026 19:50:18 +0100
Cc: qemu-devel@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4387E53A-E140-48E9-80C3-721F9C0B9A9D@unpredictable.fr>
References: <20260314221529.47841-1-mohamed@unpredictable.fr>
 <20260314221529.47841-4-mohamed@unpredictable.fr>
 <CAFEAcA8v59wSwRvig6NRjWHyvBGY=gPhWFN1B_jD9k+aXqo9Ng@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: LIBJK3vu0kQkhv8HUkXCbvOoQLTrLjQh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE1MSBTYWx0ZWRfX2Y+1A57r9v4+
 JZJ/QiSFedSWvaE/5vx4aUk1jqIvORFdwHr0Lw3QEd8jxf043DzQQ8AL0ETBXO2HhoA89ngw5qB
 2wAvSExz70aY/a7xpH/kniy676KMo3afeb4veTgOitEs1qwNgZBB1szclBdF17XMGW+nySbrDBN
 jsQ9ZNzY9ipPPv8X8ciKltJjUnv4RzMFRYVTkmza0ABmxLBWt8P4L+PV5Iyf6pDa7tFVvjTCtzs
 kzixQRTam2yE9U5UTDLy4SeX+YLnI2i5LQbIcmLW8wD88ML6qGATmfyKH0DrN3ZRR0OlQ0JN/pX
 z/9TrVhFO5n2OpVYFk/RSOmbwieTozicMG8m06T1d/rNVMZ9yh4D25F/SCWoas=
X-Authority-Info-Out: v=2.4 cv=fLk0HJae c=1 sm=1 tr=0 ts=69bc457d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=AeSh69YkIUbGMtCq220A:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LIBJK3vu0kQkhv8HUkXCbvOoQLTrLjQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=921
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 clxscore=1030
 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603190151
Received-SPF: pass client-ip=57.103.70.104;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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


> On 19. Mar 2026, at 19:13, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Sat, 14 Mar 2026 at 22:15, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Linux uses AccessVpRegs without checking availability and panics if =
it's not there. Expose it unconditionally.
>=20
> The commit message subject says we're enabling enlightenments...
>=20
>> @@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, =
MachineState *ms)
>>     synthetic_features.Bank0.AccessPartitionReferenceTsc =3D 1;
>>     synthetic_features.Bank0.AccessHypercallRegs =3D 1;
>>     synthetic_features.Bank0.AccessVpIndex =3D 1;
>> -    synthetic_features.Bank0.AccessHypercallRegs =3D 1;
>=20
> ...but the code change seems to be removing one as well as
> adding the three new ones. Intentional?
Hello,

The AccessHypercallRegs bit was set twice - with the first one being two=20=

lines earlier - removed a spurious one of the two.

>=20
>>     synthetic_features.Bank0.TbFlushHypercalls =3D 1;
>>     synthetic_features.Bank0.AccessSynicRegs =3D 1;
>>     synthetic_features.Bank0.AccessSyntheticTimerRegs =3D 1;
>>     synthetic_features.Bank0.AccessIntrCtrlRegs =3D 1;
>>     synthetic_features.Bank0.SyntheticClusterIpi =3D 1;
>>     synthetic_features.Bank0.DirectSyntheticTimers =3D 1;
>> +    synthetic_features.Bank0.FastHypercallOutput =3D 1;
>> +    synthetic_features.Bank0.AccessVpRegs =3D 1;
>> +    synthetic_features.Bank0.SyncContext =3D 1;
>>=20
>>     /*
>>      * On ARM64, have enlightenments off by default
>=20
> I've taken this series into target-arm.next for the moment --
> I can either drop this patch or else fix it up depending on
> what the right thing is.
>=20
> PS: for commit messages, could you wrap the body text at
> the usual 70-ish columns, please?
Will add some tooling to catch those earlier instead of trying to =
manually wrap=E2=80=A6
(and inevitably failing some of the time=E2=80=A6)
>=20
> thanks
> -- PMM


