Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A99F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVKV-0005Q5-HI; Fri, 06 Mar 2026 08:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyVKP-0005Oi-S7
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:34:54 -0500
Received: from ci-2005l-snip4-11.eps.apple.com ([57.103.89.251]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyVKN-00050C-5X
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:34:53 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPS id
 B771D1800095; Fri,  6 Mar 2026 13:34:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772804088; x=1775396088;
 bh=ehnMFMVCz0SpK161XH6nRWNPFX03gd1vbun+ATWbEDM=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=M/UVpT2PKvnzGekXHufBhJ765YsDsk19Zw6wwnz6sKHHEMyzxuFIU6YYRACvWLgGxRBcC/kHMvA6ZtlXRr3neBUUT2gLG5C9dhjeX0HeMS7hmwVoWpoN5w5oS/dR63uicWGMQxXhgfPr8dnx2gvp6a6es6CImFO2lXsA9BtqjXt5ica7+DYjT38iL7THO9DNs0cZN6bbdmS+NPa93M+FDDztTsM/YEArK+nn/XqXDJl/LRYdHGnIoQvPUqdZLNwkGJHF0zjD0lceo/H32+/StJ664ZFfBHDb+CSWJauxt4any3PCIgGASuG2bBvZjUfkhXPhCmL3URjIOTl4Wtsxzw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-2 (Postfix) with ESMTPSA id
 B8DE018001CD; Fri,  6 Mar 2026 13:34:43 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v15 16/17] hvf: arm: disable SME when nested virt is active
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA-bh0s0mkUEsunwDRAjRsCDJaJkzHToUg77e-6X=ejbyw@mail.gmail.com>
Date: Fri, 6 Mar 2026 14:34:31 +0100
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>
Content-Transfer-Encoding: quoted-printable
Message-Id: <38911692-67DC-4212-AF8B-E647F488390D@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
 <20260306130107.35359-17-mohamed@unpredictable.fr>
 <CAFEAcA-bh0s0mkUEsunwDRAjRsCDJaJkzHToUg77e-6X=ejbyw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-GUID: JV8xV7nYfk31LUC9oLTbWj9vuQ5-HkQE
X-Authority-Info-Out: v=2.4 cv=G8gR0tk5 c=1 sm=1 tr=0 ts=69aad7f6
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=6AXXRJrY3pTrCmY4uEcA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEzMCBTYWx0ZWRfX7Fo/pmdejF5t
 EDsBD2/a2cCtvG0CNfN/3aMz6rHuxcgdvXmMRmlvzEBtAu+y1+3/NyhMHbgUT1X45+kJx+cOTVJ
 fr7f0OJ6QCfygfUL2xgVAPmVe1GhbdJMUuaSlrCj2IJ5BCI2+IeSoc3UH2R7WwE/MmcqDOy/z4T
 Bfneed5r+9zh745nbPh/jolluZT8ziq4zXRcGPgmpzFrNqxZXEdF/MTOyjiC9eRnmvmvyQ71Aa5
 KhprSzKUvLpHichrqd9x3v/DcfrKyZQGUkv0/68bit6GlZarpWZ5CE0NpuPn47dosYUGqwKAATY
 fFDA+qYK0qu07rJLFRiJp6pHAepuhyL74sT+s7nZn6OxOQpgm5qiycNNSolrtk=
X-Proofpoint-ORIG-GUID: JV8xV7nYfk31LUC9oLTbWj9vuQ5-HkQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=920 mlxscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0
 clxscore=1030 malwarescore=0 adultscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060130
X-JNJ: AAAAAAABKhag1jDETk/uaCh8bO/9bKvQfrHCeExN/7wUerlAu7kj+O92uUf3LN3+yWGNN/Z6/GsJ6Zg1GcA2eIv8B5rJtnzBVyRfcv24cnPeU7g2f6kNN515fww8lNbotmafFMFfEr1qM69qYY+RByHMVqH3W8b1cIFV2IvxBDU0anYf7ZcauE0bsyQzlW7rcey9NtHXsePHU5J0m7cs84oD5Rc9C0rVUcHh0sPI6b7ZS/hHlhMEJ5tHA5x12aZzumNp6LFLOCKdprqeiJ5dvIgErAmzONgUHwRCyFGxlgivgiuqSdmnOcE5F1SXUdXUE7/MIV23wOR+MvNgD8OMEDRNoXdoAcEgHBsLaNeCP7h71sdieiVlAq1M5DHXJYh6pjTe2uRLBaLGVCBGCvdE9QysphKk2EdKRlGLBX03hcODqIZHnRjm3IV6lLC1JIdNFch2x6oME0ix62EzFTjGLENQ6XUA0LZ5HF0uY1li05tB+1fsk2cYVTOCVi2kDCPu/scyU7XRssLVHJKxqxe7DAZC/dhdWJsedCuZS+ZZZ8vSAsgXBW6nJR2+hvnCBtNR0UcBH2SwQhhzbKa74DliT3fxtG3FbgUm7LtETgNv9zxZ3vQwVVzTZas6E8IqCH8eC8YpPYJHZwN/+PucYe5cvxZrDGV26PtTuOj5O9txS/0iWj4p2je+xeK7dBnrZYjI/T82y0Lf0cZokA0G8dD6my8MMgwYN8UYkXsrTsS9W5x/sSmO
Received-SPF: pass client-ip=57.103.89.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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



> On 6. Mar 2026, at 14:32, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Fri, 6 Mar 2026 at 13:02, Mohamed Mediouni =
<mohamed@unpredictable.fr> wrote:
>>=20
>> Currently, Apple doesn't support the nested virtualisation + SME =
combination.
>>=20
>> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>> ---
>> target/arm/hvf/hvf.c | 3 +++
>> target/arm/hvf_arm.h | 5 +++++
>> 2 files changed, 8 insertions(+)
>>=20
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 0183dd8a60..61ba5acce4 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1181,6 +1181,9 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>=20
>>     if (hvf_nested_virt_enabled()) {
>>         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
>> +        /* SME is not implemented with nested virt on the Apple side =
*/
>> +        SET_IDREG(&host_isar, ID_AA64PFR1,
>> +              GET_IDREG(&host_isar, ID_AA64PFR1) & =
~R_ID_AA64PFR1_SME_MASK);
>=20
> This is
>  FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);
>=20
> isn't it?
>=20
Hi,

That's an equivalent sequence indeed. Should I respin for this?

Thank you,
>=20
> thanks
> -- PMM


